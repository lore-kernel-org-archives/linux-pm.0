From: Narendran Rajan <nrajan@codeaurora.org>
Subject: [v2] thermal: Add qcom tsens thermal sensor driver
Date: Thu,  5 Feb 2015 12:42:36 -0800
Message-ID: <1423168957-14981-1-git-send-email-nrajan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Narendran Rajan <nrajan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

This version of patch incorporates several review comments from community (Srini, Leena, Stephen, Eduardo).

Main changes compared to v1 are the following:
- Removed HW trip mode specific code as this is not preset in upstream
- Removed interrupts support. Not needed as the thermal framework uses polling method
- Made it a generic qcom tsens driver (name changes throughout)
- Made tsens device a subnode of gcc
- Leveraged patches from Srini for qfprom access and making it gcc subnode
- Uses SIMPLE_DEV_PM_OPS
- Bug fixes, clean up as pointed out in the reviews
- Combined dt documentation along with the driver

This patch has dependency on following patches published in the mailing list

https://patchwork.kernel.org/patch/5748661/
https://patchwork.kernel.org/patch/5748681/

https://patchwork.kernel.org/patch/5707771/
https://patchwork.kernel.org/patch/5707781/

Narendran Rajan (1):
  thermal: Add qcom tsens thermal sensor driver

 .../devicetree/bindings/thermal/qcom-thermal.txt   |  59 +++
 drivers/thermal/Kconfig                            |  14 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom-tsens.c                       | 498 +++++++++++++++++++++
 4 files changed, 572 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-thermal.txt
 create mode 100644 drivers/thermal/qcom-tsens.c

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
