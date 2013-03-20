class MainView < UITableViewController

  attr_accessor :feeds, :menu

  CellIdentifier = "Cell"
  FONT_SIZE           = 14.0
  CELL_CONTENT_WIDTH  = 320.0
  CELL_CONTENT_MARGIN = 30.0


  def viewDidLoad

    super
    self.title = "Events"
    update_feeds if Feed.all.empty?
    self.feeds = Feed.find( type: "Events")

    self.menu = REMenu.alloc.initWithItems([])

    self.view.backgroundColor = UIColor.colorWithWhite(0.902, alpha:1.000)
    self.navigationController.navigationBar.tintColor = UIColor.colorWithRed(0, green:179/255.0, blue:134/255.0, alpha:1)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Menu", style:UIBarButtonItemStyleBordered, target:self, action:"showMenu")

  end

  def showMenu
    MBProgressHUD.hideHUDForView(self.view, animated:false)
    return self.menu.close if self.menu.isOpen

    events_menu_item = REMenuItem.alloc.initWithTitle("Events", subtitle:"TCS Events", image:UIImage.imageNamed("Icon_Home.png"), highlightedImage:nil, action:Proc.new{|obj| reload_table_data("Events") })

    press_menu_item = REMenuItem.alloc.initWithTitle("Press Releases", subtitle:"TCS Press Releases", image:UIImage.imageNamed("Icon_Explore.png"), highlightedImage:nil, action:Proc.new{|obj| reload_table_data("Press Releases") })

    news_menu_item = REMenuItem.alloc.initWithTitle("News", subtitle:"TCS News", image:UIImage.imageNamed("Icon_Activity.png"), highlightedImage:nil, action:Proc.new{|obj| reload_table_data("News") })

    refresh_menu_item = REMenuItem.alloc.initWithTitle("Refresh", subtitle:"Refresh all feeds", image:UIImage.imageNamed("Icon_Profile.png"), highlightedImage:nil, action:Proc.new{ |obj|
                                                         update_feeds
                                                         self.feeds = Feed.find( type: self.title)
                                                         self.tableView.reloadData
    })

    events_menu_item.tag    = 0;
    press_menu_item.tag     = 1;
    news_menu_item.tag      = 2;
    refresh_menu_item.tag   = 3;

    self.menu = REMenu.alloc.initWithItems([ news_menu_item, events_menu_item, press_menu_item, refresh_menu_item ])

    menu.cornerRadius   = 4;
    menu.shadowColor    = UIColor.blackColor
    menu.shadowOffset   = CGSizeMake(0, 1)
    menu.shadowOpacity  = 1
    menu.imageOffset    = CGSizeMake(5, -1)

    menu.showFromNavigationController(self.navigationController)

  end

  def update_feeds
    hud = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
    status1 = FeedsParser.fetch_feeds("Events","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=e")
    status2 = FeedsParser.fetch_feeds("Press Releases","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=p")
    status3 = FeedsParser.fetch_feeds("News","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=n")
    status =status1 and status2 and status3
    hud.labelText = "Failed retrieving feeds" unless status
    hud.hide(true) if status
  end

  def reload_table_data(title)
    self.title = title
    self.feeds = Feed.find(type: title)
    self.tableView.reloadData
  end

  def tableView( tableView, numberOfRowsInSection: section)
    self.feeds.count
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)

    text = (remove_html_tags(self.feeds[indexPath.row].description) + " " + self.feeds[indexPath.row].title )
    constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0)
    size = text.sizeWithFont(UIFont.systemFontOfSize(FONT_SIZE),constrainedToSize:constraint, lineBreakMode:UILineBreakModeWordWrap)
    height = size.height > 44.0 ? size.height : 44

    return (height + (CELL_CONTENT_MARGIN * 2 ))

  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)

    cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellIdentifier)

    text = remove_html_tags(self.feeds[indexPath.row].description)
    constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0)
    size = text.sizeWithFont(UIFont.systemFontOfSize(FONT_SIZE),constrainedToSize:constraint, lineBreakMode:UILineBreakModeWordWrap)

    cell.setFrame(CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), ((size.height > 44.0 ? size.height : 44))))

    cell.textLabel.text = self.feeds[indexPath.row].title
    cell.textLabel.numberOfLines = 2
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap
    cell.textLabel.setFont(UIFont.systemFontOfSize(18))
    cell.textLabel.setMinimumFontSize(18)
    cell.textLabel.setNumberOfLines(0)
    cell.textLabel.setTag(1)

    cell.detailTextLabel.text = text
    cell.detailTextLabel.numberOfLines = 2
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap
    cell.detailTextLabel.setMinimumFontSize(FONT_SIZE)
    cell.detailTextLabel.setNumberOfLines(0)
    cell.detailTextLabel.setFont(UIFont.systemFontOfSize(FONT_SIZE))
    cell.detailTextLabel.setTag(2)

    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell

  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # vc = UIViewController.alloc.init
    # vc.title = "Ashish"
    # self.navigationController.pushViewController(vc, animated:true)
    false
  end

  def remove_html_tags(string)
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    string.gsub!(re, '')
    string.gsub!('Read More...', '')
    string
  end

end
