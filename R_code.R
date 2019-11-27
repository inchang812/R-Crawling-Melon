library(RSelenium)
library(rvest)
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4446L,
  browserName = "chrome"
)

remDr$open()
remDr$navigate("https://melon.com")#멜론 홈페이지 접속
Sys.sleep(2)
loginbtn <- remDr$findElement(using="css", value='.btn_login')
loginbtn$clickElement() #메인홈 로그인 버튼 누르기
Sys.sleep(2)
mloginbtn <- remDr$findElement(using="css", value='.btn_gate.melon')
mloginbtn$clickElement() #melon으로 로그인 버튼 누르기
Sys.sleep(2)
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pwd")
txt_id$setElementAttribute("value","hhhimbin") 
Sys.sleep(2)
txt_pw$setElementAttribute("value","park0816!") #아이디 비밀번호 입력
Sys.sleep(2)
floginbtn <- remDr$findElement(using="css", value='.btn_login03')
floginbtn$clickElement() #마지막 로그인 버튼 누르기
Sys.sleep(2)
mybtn <- remDr$findElement(using="css", value='.menu_bg.menu10') 
mybtn$clickElement() #마이뮤직매뉴로이동
Sys.sleep(2)
aviewbtn <- remDr$findElement(using="xpath", value='//*[@id="viewMore"]/span[1]')
aviewbtn$clickElement() #전체보기버튼
Sys.sleep(2)

numb1 <- remDr$findElements(using = "css", '.no') 
numb1 <- unlist(lapply(numb1, function(x) {x$getElementText()}))
numb1 <- trimws(numb1[2:51]) #첫번째 쓰레기값을 제외한 순위데이터 저장

title1 = c()
for (i in 1:50){
  temp <- remDr$findElements(using = "xpath", sprintf('//*[@id="frm"]/div/table/tbody/tr[%d]/td[3]/div/div/a[2]',i))
  title1[i] <- trimws(unlist(lapply(temp, function(x) {x$getElementText()}))) #곡 타이틀 저장
}

artist1 <- remDr$findElements(using = "id", 'artistName')
artist1 <- trimws(unlist(lapply(artist1, function(x) {x$getElementText()}))) #가수명 저장

album1 = c()
for (i in 1:50){
  temp <- remDr$findElements(using = "xpath", sprintf('//*[@id="frm"]/div/table/tbody/tr[%d]/td[5]/div/div/a',i))
  album1[i] <- trimws(unlist(lapply(temp, function(x) {x$getElementText()}))) #엘범명 저장
}

like1 <- remDr$findElements(using = "css", '.cnt')
like1 <- trimws(unlist(lapply(like1, function(x) {x$getElementText()}))) #곡에 달린 좋아요 수 저장

Sys.sleep(2)
Npage <- remDr$findElement(using="xpath", value='//*[@id="pageNavDetail"]/div/span/a')
Npage$clickElement() #다음페이지버튼 누르기
Sys.sleep(2)

numb2 <- remDr$findElements(using = "css", '.no')
numb2 <- unlist(lapply(numb2, function(x) {x$getElementText()}))
numb2 <- trimws(numb2[2:51])

title2 = c()
for (i in 1:50){
  temp <- remDr$findElements(using = "xpath", sprintf('//*[@id="frm"]/div/table/tbody/tr[%d]/td[3]/div/div/a[2]',i))
  title2[i] <- trimws(unlist(lapply(temp, function(x) {x$getElementText()})))
}

artist2 <- remDr$findElements(using = "id", 'artistName')
artist2 <- trimws(unlist(lapply(artist2, function(x) {x$getElementText()})))

album2 = c()
for (i in 1:50){
  temp <- remDr$findElements(using = "xpath", sprintf('//*[@id="frm"]/div/table/tbody/tr[%d]/td[5]/div/div/a',i))
  album2[i] <- trimws(unlist(lapply(temp, function(x) {x$getElementText()})))
}

like2 <- remDr$findElements(using = "css", '.cnt')
like2 <- trimws(unlist(lapply(like2, function(x) {x$getElementText()})))

result = data.frame("최근순"=c(numb1,numb2),"타이틀"=c(title1,title2), "아티스트"=c(artist1,artist2),"엘범"=c(album1,album2),"좋아요"=c(like1,like2))
result #1페이지,2페이지 데이터 결합해 데이터프레임자료로 변환

