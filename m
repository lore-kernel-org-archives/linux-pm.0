From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v3 0/4] thermal: tsens: Add support for QCS404 platform
Date: Tue, 27 Nov 2018 21:59:03 +0530
Message-ID: <cover.1543335819.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
IP. Introduce a fallback binding to handle "v1" functionality.

These patches have been tested on top of 4.20-rc3 + various qcs404-related
DT patches now in Andy's ci-next branch[1].

Changes since v2:
- Fix a conversion error in the get_temp routine the caused negative
  temperature readings (Reported by Khasim)

Changes since v1:
- Change p1 and p2 to be fixed-size arrays
- Refactor DT entries to be sorted by address, Thanks Vinod
- Added Acks

Amit Kucheria (4):
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor

 .../bindings/thermal/qcom-tsens.txt           |   3 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 226 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   2 +-
 drivers/thermal/qcom/tsens-common.c           |   2 +-
 drivers/thermal/qcom/tsens-v1.c               | 196 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   3 +-
 7 files changed, 432 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1
