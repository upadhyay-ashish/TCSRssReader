class FeedDescription < UIViewController

  attr_accessor :feed

  def viewDidLoad
    self.title = feed.title
    webview = UIWebView.alloc.initWithFrame([[0,0],[320,480]])
    myHTML = feed.description
    webview.loadHTMLString(myHTML, baseURL:nil)
    self.view.addSubview(webview)
  end


end
