# wm_test

Testing the "setIgnoreMouseEvents" method in the window_manager package for desktop Flutter.

In this video we can see that parameter "forward" in setIgnoreMouseEvents doesn't have any effect if the app window is not focused after mouse clicking on it.

https://user-images.githubusercontent.com/42963068/159183651-a997b6b4-12c5-4056-8ba6-f68a52b1bba9.mov


Using forward = false, we can see that the mouse leaves the window area and then returns, and after this, mouse movement starts forwarding.

https://user-images.githubusercontent.com/42963068/159183706-ff34300a-474a-4dac-8c09-2a49bfd429a7.mov

