From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 0/4] thermal: tsens: Add support for QCS404 platform
Date: Mon, 19 Nov 2018 17:55:18 +0530
Message-ID: <cover.1542629810.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
IP. Introduce a fallback binding to handle "v1" functionality.

These patches have been tested on top of 4.20-rc3 + various qcs404-related
DT patches now in Andy's ci-next branch[1].

Changes since v1:
- Change p1 and p2 to be fixed-size arrays
- Refactor DT entries to be sorted by address, Thanks Vinod
- Added Acks

[1] https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=ci-next

Amit Kucheria (4):
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor

 .../bindings/thermal/qcom-tsens.txt           |   3 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 226 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   2 +-
 drivers/thermal/qcom/tsens-v1.c               | 196 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 6 files changed, 430 insertions(+), 2 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1
