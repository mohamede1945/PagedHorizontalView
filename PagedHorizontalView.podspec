#
# Be sure to run `pod lib lint PagedHorizontalView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PagedHorizontalView"
  s.version          = "2.0.0"
  s.summary          = "A horizontal scroller with optional pageControl and/or next and previous buttons"
  s.description      = <<-DESC
A horizontal scoller view that makes its collection view cells full screen
and can optionally wire UIPageControl and a previous and next UIbuttons.

It doesn't affect the appearance of the controls and doesn't implement the collection view data source to keep full flexibility while doing the repeated work for a horizontal scroller.
                       DESC
  s.homepage         = "https://github.com/mohamede1945/PagedHorizontalView"
  # s.screenshots     = "https://github.com/mohamede1945/PagedHorizontalView/raw/master/screenshots/demo.gif"
  s.license          = 'MIT'
  s.author           = { "Mohamed Afifi" => "mohamede1945" }
  s.source           = { :git => "https://github.com/mohamede1945/PagedHorizontalView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/mohamede1945'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'PagedHorizontalView/**/*.{swift,h}'

end
