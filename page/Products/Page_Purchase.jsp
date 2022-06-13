<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../css/Purchase.css">
    <title>Purchase</title>
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
        <div id="main_header">
            <p>Ordered Product</p>
            <hr>
        </div>
        <div id="main_content_summary">
            <img src="../../image/Product/i9-12900.jpg" width="200px" height="200px">
            <div>
                <p>Product name</p>
                <p>Intel® Core™ i9-12900 Processor</p>
            </div>
            <div>
                <p>Product cost</p>
                <p>746480 (₩)</p>
            </div>
            <div>
                <p>Purchase Amount</p>
                <select id="amount_select" name="amount">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>
            <div>
                <p>Total Cost</p>
                <p>746480 (₩)</p>
            </div>
        </div>
        <div id="Ordered_Info">
            <p>Ordered Info</p>
            <div class="Info_category">
                <p>Orderer name</p>
                <input type="text">
            </div>
            <div class="Info_category">
                <p>Phone number</p>
                <input type="text">
            </div>
            <div class="Info_category">
                <p>Shipping address</p>
                <input type="text">
            </div>
            <div class="Info_category">
                <p>Bank name</p>
                <input type="text">
            </div>
            <div class="Info_category">
                <p>Account number</p>
                <input type="text">
            </div>
            <div class="Info_category">
                <p>Account holder</p>
                <input type="text">
                <input id="Pay_Now_button" type="button" value="Pay Now">
            </div>
        </div>
    </main>
</body>
