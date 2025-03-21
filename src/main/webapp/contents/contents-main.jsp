<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>탭 네비게이션</title>
<link rel="stylesheet" href="../assets/css/contents/contents.css" />
<link rel="stylesheet" href="../assets/css/global.css" />
</head>
<body>
	<div class="page-container">
		<div class="tab-container">
			<div class="tab-btn"></div>
			<div id="achievementTab" class="tab-text tab-text-off">업적</div>
			<div id="myTreeTab" class="tab-text tab-text-on">나의 성장 나무</div>
			<div id="pointShopTab" class="tab-text tab-text-off">포인트 샵</div>
		</div>
		<h1 class="tree-title-word">나의 성장나무</h1>
		<div class="tree-wrapper">
			<div class="tree-container">
				<div class="tree-box"></div>
			</div>
			<div class="tree-button-group">
				<button class="save-button">저장</button>
				<button class="cancel-button">취소</button>
			</div>
		</div>

		<!-- 나의꾸미기 -->
		<h1 class="decorate-title-word">나의 꾸미기</h1>
		<div class="decorate-tab-container">
			<button class="decorate-tab selected" onclick="showContent('전체')">전체</button>
			<button class="decorate-tab" onclick="showContent('배경')">배경</button>
			<button class="decorate-tab" onclick="showContent('스티커')">스티커</button>
			<button class="decorate-tab" onclick="showContent('나무')">나무</button>
		</div>
		<div class="container" id="content-container">
			<%-- <%@ include file="contents-background.jsp" %> --%>
			<%@ include file="contents-sticker.jsp"%>
		</div>
		</div>
		<script>
        document.addEventListener("DOMContentLoaded", function () {
            const folderItems = document.querySelectorAll(".folder-item");

            folderItems.forEach((item) => {
                item.addEventListener("click", function () {
                    folderItems.forEach((el) => el.classList.remove("selected"));
                    this.classList.add("selected");
                });
            });

            const tabElements = document.querySelectorAll(".decorate-tab");

            tabElements.forEach((element) => {
                element.addEventListener("click", function () {
                    tabElements.forEach((el) => el.classList.remove("selected"));
                    this.classList.add("selected");
                });
            });
        });
        
        const achievementTab = document.getElementById("achievementTab");
        const myTreeTab = document.getElementById("myTreeTab");
        const pointShopTab = document.getElementById("pointShopTab");
        const tabBtn = document.querySelector(".tab-btn");
        
        achievementTab.addEventListener("click", () => {
            tabBtn.classList.remove("tab-btn-second", "tab-btn-third");
            achievementTab.classList.add("tab-text-on");
            achievementTab.classList.remove("tab-text-off");
            myTreeTab.classList.add("tab-text-off");
            myTreeTab.classList.remove("tab-text-on");
            pointShopTab.classList.add("tab-text-off");
            pointShopTab.classList.remove("tab-text-on");
            
        });

        myTreeTab.addEventListener("click", () => {
        	tabBtn.classList.remove("tab-btn-third");
            tabBtn.classList.add("tab-btn-second");
            myTreeTab.classList.add("tab-text-on");
            myTreeTab.classList.remove("tab-text-off");
            achievementTab.classList.add("tab-text-off");
            achievementTab.classList.remove("tab-text-on");
            pointShopTab.classList.add("tab-text-off");
            pointShopTab.classList.remove("tab-text-on");
        });
        
        pointShopTab.addEventListener("click", () => {
        	tabBtn.classList.remove("tab-btn-second");
            tabBtn.classList.add("tab-btn-third");
            pointShopTab.classList.add("tab-text-on");
            pointShopTab.classList.remove("tab-text-off");
            myTreeTab.classList.add("tab-text-off");
            myTreeTab.classList.remove("tab-text-on");
            achievementTab.classList.add("tab-text-off");
            achievementTab.classList.remove("tab-text-on");
        });
       
        document.addEventListener("DOMContentLoaded", function () {
            // 초기에 로드된 경우에만 이벤트 등록
            attachFolderItemClickEvent();
        });

        function attachFolderItemClickEvent() {
            const folderItems = document.querySelectorAll(".folder-item");
            folderItems.forEach((item) => {
                item.addEventListener("click", function () {
                    folderItems.forEach((el) => el.classList.remove("selected"));
                    this.classList.add("selected");
                });
            });
        }

        // showContent() 함수에서 content 변경 후 이벤트 재등록
        function showContent(category) {
            document.querySelectorAll(".decorate-tab").forEach(tab => {
                tab.classList.remove("selected");
            });

            document.querySelectorAll(".decorate-tab").forEach(tab => {
                if (tab.textContent.trim() === category) {
                    tab.classList.add("selected");
                }
            });

            let fileName = "";
            switch (category) {
                case "전체":
                    fileName = "contents-all.jsp";
                    break;
                case "배경":
                    fileName = "contents-background.jsp";
                    break;
                case "스티커":
                    fileName = "contents-sticker.jsp";
                    break;
                case "나무":
                    fileName = "contents-tree.jsp";
                    break;
                default:
                    fileName = "contents-background.jsp";
            }

            fetch(fileName)
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.text();
                })
                .then(data => {
                    document.getElementById("content-container").innerHTML = data;

                    // **새로운 콘텐츠가 로드된 후 다시 이벤트 등록**
                    attachFolderItemClickEvent();
                })
                .catch(error => console.error("Error loading content:", error));
        }
    </script>
</body>
</html>