class MainView < UITableViewController

  attr_accessor :feeds

  CELL_REUSE_ID = 'cell_reuse_identifier'

  def viewDidLoad
    self.feeds = Feed.all
    self.tableView.reloadData
  end


  def tableView( tableView, numberOfRowsInSection: section)
     self.feeds.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: CELL_REUSE_ID)
    cell.textLabel.text = self.feeds[indexPath.row].title
    cell.detailTextLabel.text = self.feeds[indexPath.row].description
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    description_view = FeedDescription.new
    self.navigationController.pushViewController(description_view, animated:true)
  end

end
