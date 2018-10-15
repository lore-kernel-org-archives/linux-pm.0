From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 0/4] thermal: tsens: Add support for QCS404 platform
Date: Tue, 16 Oct 2018 00:10:39 +0530
Message-ID: <cover.1539627762.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
IP. Introduce a fallback binding to handle "v1" functionality.

These patches apply on top of previous tsens-related patches sent to the
list pending merge along with various qcs404 patches under review
(available in this branch[1] for convenience).

[1] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=integration-linux-qcomlt

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
