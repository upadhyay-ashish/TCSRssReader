class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NanoStore.shared_store = NanoStore.store(:file, App.documents_path + "/nano.db")
    p "Feeds count = #{Feed.all.count}"
    main_view = MainView.new
    navigation_controller = UINavigationController.alloc.initWithRootViewController(main_view)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible
    true
  end
end
