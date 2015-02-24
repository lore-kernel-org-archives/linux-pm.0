From: Narendran Rajan <nrajan@codeaurora.org>
Subject: [v3 0/2] thermal: Add qcom tsens thermal sensor driver
Date: Mon, 23 Feb 2015 22:47:20 -0800
Message-ID: <1424760442-12564-1-git-send-email-nrajan@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41293 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbBXGrn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 01:47:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Narendran Rajan <nrajan@codeaurora.org>

This version of patch incorporates review comments from community (mainly Lina Iyer)

Main changes compared to v1 are the following:
- Added thermal dtsi patch to the series
- Minor code cleanup

The scope of this driver is limited to QCOM A family chipsets. The register layout of
tsens hardware is different on B family chipsets compared to A family, hence limiting
the scope to A family

Suggestions/followup patches for B family support are welcome.

This patch has dependency on following patches published in the mailing list
https://patchwork.kernel.org/patch/5748661/
https://patchwork.kernel.org/patch/5748681/
https://patchwork.kernel.org/patch/5707771/
https://patchwork.kernel.org/patch/5707781/

Narendran Rajan (2):
  thermal: Add qcom tsens thermal sensor driver
  ARM: qcom: dts: Add tsens thermal data

 .../devicetree/bindings/thermal/qcom-thermal.txt   |  59 +++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  27 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  27 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi                |  28 +-
 arch/arm/boot/dts/qcom-thermal.dtsi                |  47 ++
 drivers/thermal/Kconfig                            |  14 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom-tsens.c                       | 493 +++++++++++++++++++++
 8 files changed, 690 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-thermal.txt
 create mode 100644 arch/arm/boot/dts/qcom-thermal.dtsi
 create mode 100644 drivers/thermal/qcom-tsens.c

--
Qualcomm Innovation Center, Inc. The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
