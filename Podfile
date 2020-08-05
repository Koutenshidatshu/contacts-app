# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def all_pods
    pod 'RxSwift', '~> 4.5'
    pod 'RxCocoa', '~> 4.5'
    pod 'RxBlocking', '~> 4.5'
    pod 'Nuke', '~> 7.0'

end

target 'contacts-APP' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for contacts-APP

  all_pods

  target 'contacts-APPTests' do
    inherit! :search_paths
    # Pods for testing

     all_pods
  end

  target 'contacts-APPUITests' do
    # Pods for testing
  end

end
