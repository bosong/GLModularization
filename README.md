# GLModularization
组件化开发探索

1，主工程依赖组件工程的方式是在Podfile中添加 pod 'MapUnit', :path => ‘MapUnit’ （MapUnit为被依赖的组件工程名）

2，组件工程需要在 .podspec 文件中设置 s.exclude_files，以排除AppDelegate.h.m 和 main.m 文件

3，组件工程有时需要在 .podspec 文件中设置 s.dependency，以添加对基础组件或第三方的依赖

4，组件工程需要在 .podspec 文件中设置 s.resources，以包含资源文件

5，主工程和所有组件工程的资源文件和类文件名不能重复，需要加前缀防止冲突

6，Router被主工程和所有组件工程所依赖，即在Podfile中添加 pod 'UNRouter', :path => ‘Router’

7，目前在组件工程相应控制器的 +load 方法中进行 router的注册操作

8，组件工程避免使用 Main.storyboard