library(RSelenium)
library(rvest)
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4446L,
  browserName = "chrome"
)

remDr$open()
remDr$navigate("https://melon.com")#��� Ȩ������ ����
Sys.sleep(2)
loginbtn <- remDr$findElement(using="css", value='.btn_login')
loginbtn$clickElement() #����Ȩ �α��� ��ư ������
Sys.sleep(2)
mloginbtn <- remDr$findElement(using="css", value='.btn_gate.melon')
mloginbtn$clickElement() #melon���� �α��� ��ư ������
Sys.sleep(2)
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pwd")
txt_id$setElementAttribute("value","hhhimbin") 
Sys.sleep(2)
txt_pw$setElementAttribute("value","park0816!") #���̵� ��й�ȣ �Է�
Sys.sleep(2)
floginbtn <- remDr$findElement(using="css", value='.btn_login03')
floginbtn$clickElement() #������ �α��� ��ư ������
Sys.sleep(2)
mybtn <- remDr$findElement(using="css", value='.menu_bg.menu10') 
mybtn$clickElement() #���̹����Ŵ����̵�
Sys.sleep(2)
aviewbtn <- remDr$findElement(using="xpath", value='//*[@id="viewMore"]/span[1]')
aviewbtn$clickElement() #��ü�����ư
Sys.sleep(2)

numb1 <- remDr$findElements(using = "css", '.no') 
numb1 <- unlist(lapply(numb1, function(x) {x$getElementText()}))
numb1 <- trimws(numb1[2:51]) #ù��° �����Ⱚ�� ������ ���������� ����

title1 = c()
for (i in 1:50){
  temp <- remDr$findElements(using = "xpath", sprintf('//*[@id="frm"]/div/table/tbody/tr[%d]/td[3]/div/div/a[2]',i))
  title1[i] <- trimws(unlist(lapply(temp, function(x) {x$getElementText()}))) #�� Ÿ��Ʋ ����
}

artist1 <- remDr$findElements(using = "id", 'artistName')
artist1 <- trimws(unlist(lapply(artist1, function(x) {x$getElementText()}))) #������ ����

album1 = c()
for (i in 1:50){
  temp <- remDr$findElements(using = "xpath", sprintf('//*[@id="frm"]/div/table/tbody/tr[%d]/td[5]/div/div/a',i))
  album1[i] <- trimws(unlist(lapply(temp, function(x) {x$getElementText()}))) #������ ����
}

like1 <- remDr$findElements(using = "css", '.cnt')
like1 <- trimws(unlist(lapply(like1, function(x) {x$getElementText()}))) #� �޸� ���ƿ� �� ����

Sys.sleep(2)
Npage <- remDr$findElement(using="xpath", value='//*[@id="pageNavDetail"]/div/span/a')
Npage$clickElement() #������������ư ������
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

result = data.frame("�ֱټ�"=c(numb1,numb2),"Ÿ��Ʋ"=c(title1,title2), "��Ƽ��Ʈ"=c(artist1,artist2),"����"=c(album1,album2),"���ƿ�"=c(like1,like2))
result #1������,2������ ������ ������ �������������ڷ�� ��ȯ

