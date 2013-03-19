class FeedDescription < UIViewController


  def viewDidLoad
    self.view.backgroundColor = 'blue'.to_color
    webview = UIWebView.alloc.initWithFrame([[0,40],[320,200]])
    myHTML = "<html><body><h1>Hello, world!</h1></body></html>";
    webview.loadHTMLString(myHTML, baseURL:nil)
    self.view.addSubview(webview)
  end


end
