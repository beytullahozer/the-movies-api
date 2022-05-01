# the-movies

## Giriş 
The Movie Database (TMDb) API kullanılmaktadır. Başlamadan önce The Movie Database API'lerini kullanmak için doğru yapılandırmaları yapmanız gerekir.

Uygulamanın genel gereksinimlerini ve genel isteğe bağlı özellikleri tanımlanmıştır. Ardından Main sayfası'ndan başka bir ekrana geçiş sağlayacaktır. Bu ekranların isteğe bağlı ve gerekli özellikleri tamamlanmıştır.

● Uygulama, Swift Programlama Dili ile yazılmıştır.
● CocoaPod ile 3. part kütüphane kullanılmıştır.
● Tüm ekranların dizayn'ı ve piksel'i tamamlanmıştır.
● Uygulama tamamen işlevseldir.
● Temiz mimari tasarım kullanılmıştır.
● Kodlanabilir ve süregelir.
● Ağ Katmanı bulunmaktadır.

● Git, Gitflow, gitignore.
● Temiz kod stili.
● 3. part kütüphane soyutlama.
● MVVM Mimarisi
● Yüksek Dereceli İşlev kullanımı


## Main Ekranı
Bu bizim ilk ve ana ekranımızdır. Bu ekranda, şu anda oynatılan filmler için ekranın üstünde bir kaydırıcı scroll view bulunmaktadır. Kaydırıcının altında yaklaşan bir film listesi API alınmaktadır. Bu ekran tamamen kaydırmalıdır, yani kullanıcı aşağı kaydırdığında üst kaydırıcı hareket etmelidir. Kullanıcı listedeki veya kaydırıcıdaki filmlere dokunduğunda, onları film detay sayfasına yönlendirmektedir.

## Film Detay Ekranı
Bu uygulamamızın son sayfasıdır. Bu ekranda ekranın üst kısmında bir film görüntüsü veriyoruz. Film görüntüsünün altında derecelendirme, çıkış tarihi, IMDB simgesi, başlık ve açıklama var. Açıklama, uzunluğuna göre sığmaktadır. Bu ekran tamamen kaydırmalıdır, yani kullanıcı aşağı kaydırdığında film görüntüsü ve diğer tüm öğeler kaydırılmaktadır.

### Ekran Gereksinimleri
● API, Sayfalandırmalar ve Ekranı Yenilemek İçin Çekme Opsiyonelleri
● imdb_id ile IMDB yönlendirmesi
● Hata ve Yük tutamacı

## Gerekli API'ler
● /movie/now_playing.
● /movie/upcoming liste için.
● /movie/{movie_id}. film detayları için
