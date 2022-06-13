<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Product.css">
    <title>Product</title>
</head>
<body>

    <header>
        <div id="homepage">
            <input class="header_option_button" type="button" value="COM with me" onclick="location.href='../Home/Home.html'">
        </div>
        <div id="header_search">
            <input id="search_space" type="text">
            <input id="search_button" type="button" value="검색">
        </div>
        <div id="header_option">
            <input class="header_option_button" type="button" value="Login"onclick="location.href='../Login.html'">
            <input class="header_option_button" type="button" value="Join" onclick="location.href='../Join.html'">
        </div>
    </header>
    <nav>
        <input class="nav_button" type="button" value="CPU" onclick="location.href='../Products/CPU.html'">
        <input class="nav_button" type="button" value="Mainboard" onclick="location.href='../Products/Mainboard.html'">
        <input class="nav_button" type="button" value="GPU" onclick="location.href='../Products/GPU.html'">
        <input class="nav_button" type="button" value="RAM" onclick="location.href='../Products/RAM.html'">
        <input class="nav_button" type="button" value="SSD&HDD" onclick="location.href='../Products/Disk.html'">
        <input class="nav_button" type="button" value="Cooler" onclick="location.href='../Products/Cooler.html'">
        <input class="nav_button" type="button" value="Power" onclick="location.href='../Products/Power.html'">
        <input class="nav_button" type="button" value="Tower" onclick="location.href='../Products/Tower.html'">
        <input class="nav_button" type="button" value="Forum"onclick="location.href='../Forum/Post_List.html'">
    </nav>

    <main>
        <div id="Product_Content">
            <div id="Product_image_space">
                <img id="Product_image" src="../../image/Product/i9-12900.jpg">
            </div>
            <div id="Product_simple_descript">
                <div id="Product_Name">
                    <p>Intel® Core™ i9-12900 Processor</p>
                </div>
                <div id="Product_Cost">
                    <p> 746480 (₩)</p>
                </div>
                <div id="Buy_button_space">
                    <input id="Buy_button" type="button" value="Buy Now" onclick="location.href='../Products/After_Purchase.html'">
                </div>
            </div>
        </div>
        <div id="Product_description_table">
            <table>
                <tr>
                    <td class="attribute">제품회사</td>
                    <td class="table_content">Intel</td>
                    <td class="attribute">출시일</td>
                    <td class="table_content">2021 4분기</td>
                </tr>
                <tr>
                    <td class="attribute">CPU 종류</td>
                    <td class="table_content">코어 i9-12세대</td>
                    <td class="attribute">소켓 구분</td>
                    <td class="table_content">소켓(1700)</td>
                </tr>
            </table>
        </div>
        <div id="Comments_Space">
            <div id="Comments_Input">
                <input id="Comments_Input_text" type="text" value="의견을 입력하세요">
                <input id="Comments_Input_button" type="button" value="제출">
            </div>
        </div>
    </main>
</body>