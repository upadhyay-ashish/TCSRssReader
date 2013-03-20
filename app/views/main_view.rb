class MainView < UITableViewController

  attr_accessor :feeds, :menu
  CellIdentifier = "Cell"


  def viewDidLoad

    super

    reload_table_data("Events","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=e")

    self.menu = REMenu.alloc.initWithItems([])

    self.view.backgroundColor = UIColor.colorWithWhite(0.902, alpha:1.000)
    self.navigationController.navigationBar.tintColor = UIColor.colorWithRed(0, green:179/255.0, blue:134/255.0, alpha:1)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Menu", style:UIBarButtonItemStyleBordered, target:self, action:"showMenu")

  end

  def showMenu

    return self.menu.close if self.menu.isOpen

    events_menu_item = REMenuItem.alloc.initWithTitle("Events", subtitle:"TCS Events", image:UIImage.imageNamed("Icon_Home.png"), highlightedImage:nil, action:Proc.new{|obj| reload_table_data("Events","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=e") })

    press_menu_item = REMenuItem.alloc.initWithTitle("Press Releases", subtitle:"TCS Press Releases", image:UIImage.imageNamed("Icon_Explore.png"), highlightedImage:nil, action:Proc.new{|obj| reload_table_data("Press Releases","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=p") })

    news_menu_item = REMenuItem.alloc.initWithTitle("News", subtitle:"TCS News", image:UIImage.imageNamed("Icon_Activity.png"), highlightedImage:nil, action:Proc.new{|obj| reload_table_data("News","http://www.tcs.com/rss_feeds/Pages/feed.aspx?f=n") })

    events_menu_item.tag = 0;
    press_menu_item.tag = 1;
    news_menu_item.tag = 2;

    self.menu = REMenu.alloc.initWithItems([ news_menu_item, events_menu_item, press_menu_item ])
    menu.cornerRadius = 4;
    menu.shadowColor = UIColor.blackColor
    menu.shadowOffset = CGSizeMake(0, 1)
    menu.shadowOpacity = 1
    menu.imageOffset = CGSizeMake(5, -1)
    menu.showFromNavigationController(self.navigationController)

  end

  def reload_table_data(title, url)
    self.title = title
    FeedsParser.fetch_events_feeds(title, url)
    self.feeds = Feed.find(:type => title)
    self.tableView.reloadData
  end



  def tableView( tableView, numberOfRowsInSection: section)
    self.feeds.count
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    190
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    # CustomFeedCell.get_cell_for_feed(tableView, self.feeds[indexPath.row])


    cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
    if (cell.nil?)
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellIdentifier)
      webView = UIWebView.alloc.initWithFrame(CGRectMake(10, 10, cell.bounds.size.width - 20, cell.bounds.size.height - 20))
      webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth
      webView.tag = 1001
      webView.userInteractionEnabled = false
      webView.backgroundColor = UIColor.clearColor
      webView.opaque = false

      cell.addSubview(webView)
    end
    webView = cell.viewWithTag(1001)
    webView.delegate = self
    html = "<div><b>#{self.feeds[indexPath.row].title }</b></div>"+ self.feeds[indexPath.row].description
    webView.loadHTMLString(html, baseURL:nil)

    return cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    false
  end

end
