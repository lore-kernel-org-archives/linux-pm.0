From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 0/2] thermal: tsens: SDM845 support
Date: Sat,  2 Jun 2018 14:11:11 +0300
Message-ID: <cover.1527937396.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, edubezval@gmail.com, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Add SDM845 support in the tsens driver. I've create a separate file
(tsens-sdm845.c) because I expect it to diverge from the other drivers.

Cleanup the tsens_device structure while we're at it.


Amit Kucheria (2):
  thermal: tsens: Add support for SDM845 platform
  tsens: Get rid of unused fields in structure

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-sdm845.c                | 98 ++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c                       |  3 +
 drivers/thermal/qcom/tsens.h                       |  3 +-
 5 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

-- 
2.7.4
