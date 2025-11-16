# 📱 Video Double-Tap Seek Interaction  
**iOS Video Interaction Showcase Project**

본 프로젝트는 **영상 더블탭(좌/우) 시킹 인터랙션**을 포함한 현대적 비디오 UX를 iOS Native 환경에서 구현한 데모 애플리케이션입니다.  
Netflix, YouTube 등 주요 플랫폼에서 사용되는 자연스러운 제스처 기반 내비게이션을 UIKit 중심으로 구성하였으며, 확장 가능한 구조를 통해 실제 서비스 적용을 고려한 형태로 설계되었습니다.

---

## 🎯 프로젝트 목표
- **영상 더블탭 좌/우 이동 기능 구현 (Double-Tap to Seek)**
- 직관적이고 반응성 높은 사용자 경험 제공
- AVPlayer 기반 커스텀 제스처 처리
- 향후 다양한 비디오 UX로 확장 가능한 구조 제공

---

## 🛠 기술 스택
- **Language:** Swift  
- **Frameworks:** UIKit, AVKit  
- **Layout:** SnapKit  
- **Architecture:** Lightweight MVC (ViewController + Model + Network Layer)
- **Networking:** URLSession 기반 APIManager 구조
- **Data Handling:** Remote JSON endpoint 기반 VideoDetails 모델 디코딩

---

## 📂 프로젝트 구조
```
VideoPlayApp/
...
├── Model/
│ └── DataModel.swift # VideoDetails 등 데이터 모델 정의
│
├── Network/
│ └── APIManager.swift # URLSession 기반 네트워크 레이어
│
├── Utils/
│ └── ScreenUtils.swift # 화면 계산 등 공용 유틸리티
│
└── View/
    ├── ViewController.swift # 메인 화면 (비디오 리스트)
    ├── TableViewCell.swift # 비디오 리스트 셀
    ├── VideoPlayerViewController.swift # 비디오 재생 화면
    └── VideoControlView.swift # 비디오 컨트롤 오버레이 (멈춤/재생, 설정, 더블탭, 나가기)
```

---

## ✨ 주요 기능 (Key Features)

### ▶️ 1. 더블탭 시킹(Double Tap to Seek)
- 좌측 더블탭 → **뒤로 skip**
- 우측 더블탭 → **앞으로 skip**
- 탭 연속 입력 시 스킵 누적
- 싱글 탭 시 컨트롤 UI 토글

### ▶️ 2. AVPlayer 기반 커스텀 비디오 플레이어
- 풀스크린 대응
- 상태 변화에 따른 즉각적인 UI 반응
- 재생/정지, 시킹 등 이벤트 처리 모듈화
- 기기 회전(Orientation Change)에 따른 레이아웃 및 UI 자동 조정

---

## 🖥 실행 화면 (예시)

| GIF |
|:--:|
| - 화면 회전, <br> - 싱글탭: control show/hide <br> - 더블탭 이상: 건너뛰기 |
|<img src="https://github.com/user-attachments/assets/d1a8e8ce-4a7d-4e7a-a8a8-1487ad671087" width="250">|


---

## 🚀 향후 확장 방향
- **영상 Progress Bar UI 추가:** 재생 위치를 직관적으로 확인할 수 있는 커스텀 프로그레스 바 구성
- **Progress Bar Drag-to-Seek 기능 지원:** 프로그레스 바를 드래그하여 원하는 재생 위치로 즉시 이동할 수 있는 인터랙션 구현
- **핀치 제스처를 이용한 줌 기능**


