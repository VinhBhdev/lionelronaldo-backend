<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toi Cr</title>

    <link rel="stylesheet" href="./assets/css/footer.css">
    <link rel="stylesheet" href="./assets/css/comunity.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
    <link rel="stylesheet" type="text/css" href="./assets/css/base.css">
    <link rel="stylesheet" type="text/css"  type="text/css"href="./assets/css/main.css">
    <link rel="stylesheet" type="text/css" href="./assets/fonts/fontawesome-free-6.3.0-web/css/all.min.css">

    <link rel="icon" href="./assets/img/logo.jpg" type="image/x-icon" />

    <!-- ReactJs -->
    <script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>

    <script src="./includes/include.js"></script>
</head>
<body>
    <div class="header" w3-include-html="./includes/header.html"></div>

    <div class="container">

        <div class="chat-box">
            <!-- <label for="">Send to: </label> -->
            <div class="receiver-section">
                <label for="">Gửi tới: </label>
                <select>
                    <option value="everyone">Everyone</option>
                    <option value="ronaldo">Ronaldo</option>
                    <option value="messi">Messi</option>
                    <option value="benzema">Benzema</option>
                    <option value="neymar">Neymar</option>
                </select>
            </div>

            <ul class="message-box">
                
            </ul>

            <form class="message-form" method = "post">
                <div class="input-form">
                    <label for="name">Tên hiển thị:</label>
                    <input id = 'name' type="text" name="name-shown"required>
                </div>

                <div class="input-form">
                    <label for="message-content">Nội dung</label>
                    <input id = 'message-content'type="text" name="message" required>

                    <button onclick= sendMessageToServer()>Gửi</button>
                </div>
            </form>
        </div>

    </div>

    <footer class="footer-distributed" w3-include-html="./includes/footer.html"> </footer>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    
    <script>
        includeHTML();
    </script>
    
    <script>
        function updateScroll(){
            const messageBox = document.querySelector('.message-box')
            messageBox.scrollTop = messageBox.scrollHeight;
        }
        
        let ws = new WebSocket("ws://localhost:8080/LeoCris/chat")
        ws.onmessage = function(event) {
            const mySpan = document.querySelector('.message-box');
            mySpan.innerHTML+="<li>" + event.data+"</li>";
            updateScroll();
        };

        ws.onerror = function(event){
            console.log("Error ", event)
        } 
        
        const messageForm = document.querySelector('.message-form')
        messageForm.addEventListener('submit', (e)=>{
            e.preventDefault()
        })
        function sendMessageToServer(){
            let nameShown = document.getElementById("name").value;
            let messageContent = document.getElementById("message-content").value;
            let message = JSON.stringify({"nameShown": nameShown, "messageContent":messageContent})
            if(nameShown && messageContent)
            {
                ws.send(message);
            }
           document.getElementById("message-content").value="";
        }
    </script>
    
    
    
    <script>
        
        setTimeout(()=>{
//            e.preventDefault()
            updateScroll();
        },200)
        
        $(document).ready(()=>{
            setTimeout(()=>{
                $.post('http://localhost:8080/LeoCris/get-old-messages', (data) =>{
                    document.querySelector(".message-box").innerHTML = data
                })
            }, 100)
        })
        
        /*var cntScroll = 1;

        function longPoll() {
            // Gửi request đến server
            $.ajax({
              url: "http://localhost:8080/LeoCris/ProcessSendMessage",
              type: "POST",
              timeout: 1020, // Thiết lập timeout
              success: function(data) {
                // Xử lý dữ liệu khi nhận được từ server
                console.log("New data received: " + data);
                
                document.querySelector(".message-box").innerHTML = data
                // Thực hiện long polling lại
//                const messageBox = document.querySelector('.message-box')
//                messageBox.scrollTop = messageBox.scrollHeight;
                if (cntScroll == 1){
                    const messageBox = document.querySelector('.message-box')
                    messageBox.scrollTop = messageBox.scrollHeight;
                    cntScroll = 0
                }
                longPoll();
              },
              error: function(xhr, status, error) {
                // Xử lý lỗi
                console.log("Error occurred while long polling: " + error);
                
                
                // Thực hiện long polling lại
                longPoll();
              }
            });
          }

          // Thực hiện long polling khi trang web được load
          $(document).ready(function() {
            longPoll();
          });*/

    </script>    
<!--    <script>
        var form = document.querySelector('.message-form');
        form.addEventListener('submit', function(event) {
          event.preventDefault();
          var xhr = new XMLHttpRequest();
          xhr.open('POST', 'ProcessSendMessage', true);
          xhr.setRequestHeader('Content-Type', 'application/json');
          xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
              // Xử lý phản hồi từ Servlet hoặc xử lý dữ liệu trên trang ở đây
      //        console.log(xhr.responseText);
                 document.querySelector(".message-box").innerHTML = xhr.responseText
                 const messageBox = document.querySelector('.message-box')
                 messageBox.scrollTop = messageBox.scrollHeight;

            }
          };
      
          let messageContent = document.querySelector('#message-content').value
          let nameShown = document.querySelector('#name').value
          let data = JSON.stringify({"nameShown": nameShown, "messageContent":messageContent})
          xhr.send(data);
        });
</script>-->

</body>
</html>