# Movies Api
<br>

## Definition
Uygulama The Movie Database domain'i ile REST mimarisi ve servisleri kullanır. 
<br>

It use The Movie Database (TMDb) api’s. Before you start you need to do correct configurations to use The Movie Database api’s.

In the application, a few screens and detailed and designed features are determined on these screens.

General Requirements
● Coded with Swift Programming Language.
● At least one 3rd party library be implemented with CocoaPods.
● All screens be pixel perfect design.
● App be fully functional.
● Clean architectural design.
● Codable.
● Network Layer.

General Optionals
● Git & Proper Gitflow Usage & gitignore.
● Clean code style.
● Abstracting the 3rd party libraries.
● MVVM Architecture.
● High order function usage.

### Main Screen
This is our first and main screen. In this screen, it has a slider on top of the screen, for the now playing movies. Under the slider, there is an upcoming movies list. 
● This screen should scroll entirely, means when the user scrolls down the top slider should move. 
● When the user taps the movies either on list or slider it redirect them to the movie detail page.
● Paginations & Pull To Refresh Screen Optionals.
● There are Error & Load handle Required Api’s.
● /movie/now_playing for slider use this api.
● /movie/upcoming for list use this api.
<br>
### Detail Screen
This is the last page of the movies app. In this screen, it is giving a movie image on top of the screen. Under the movie image we have rating, release date, IMDB icon, title and description. 
● Description should fit according to the length of it. 
● This screen should scroll entirely, means when the user scrolls down, movie image and all other elements should scroll.
● IMDB redirection with imdb_id.
● Error & Load handle.
● /movie/{movie_id}. for movie details use this api.
<br>
Tüm veriler eksiksiz çalışmaktadır ve bir sayfada 2 farklı url kullanılmaktadır.
Scroll sağ ve aşağı hareketi ile resim solgunlaştırılmak.
CollectionView tercih etmek.
Label'ları verilere uygun kullanılmak.
<br>
<p align="center">
  <img src="https://user-images.githubusercontent.com/88663603/166777120-4d79e627-37b2-4b61-b8c5-ff3fd458fbf1.png" width="250" />
  <img src="https://user-images.githubusercontent.com/88663603/166776080-bfb30d6f-f7d0-4020-a0be-8b076a642fcc.png" width="250" />
  <img src="https://user-images.githubusercontent.com/88663603/166778114-ea6662bc-f00c-4588-b1b9-7ad6cad5d167.png" width="250" />
  <img src="https://user-images.githubusercontent.com/88663603/166776763-3ae71892-bf41-4fa0-b7bc-851b633b8fba.png" width="250" />
  <img src="https://user-images.githubusercontent.com/88663603/166777941-b2c026b7-7c01-408c-ad72-6c241ab5da29.png" width="250" />
  <img src="https://user-images.githubusercontent.com/88663603/166778425-d85f5524-7825-4884-b813-333e9a339092.png" width="250" />
