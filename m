From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 0/9] qcom: Add support for TSENS driver
Date: Wed, 16 Sep 2015 11:53:14 +0530
Message-ID: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59642 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbIPGZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 02:25:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>

Changes since v1:
* Created virtual tsens device from gcc driver for 8960,
with DT having a single node for gcc and tsens
* Minor fixes with rebasing on 4.3-rc1

Changes since RFC:
* Added support for 8916 and 8084
* Based off the latest nvmem framework patches [1]
* Minor review fixes for comments mostly from Lina

This is an attempt to have a single TSENS driver for
the different versions of the TSENS IP that exist, on
different qcom msm/apq SoCs'
Support is added for msm8916, msm8960 and msm8974 families.

A lot of the work is based of original code from Stephen Boyd
and Siddartha Mohanadoss. I have also picked some of what
Narendran Rajan did in his attempt to upstream the support
for 8960 family. I could not keep the original authorship on
any of the patches because I ended up moving the code around
quite a bit in an effort to have a single driver for the
various devices. I would be glad to change the authorship
for any of the patches if needed.

Rajendra Nayak (9):
  thermal: qcom: tsens: Add a skeletal TSENS drivers
  thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
  thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
  clk: qcom: create virtual child device for TSENS
  thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
  arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes
  arm: dts: apq8064: Add thermal zones, tsens and qfprom nodes
  arm: dts: apq8084: Add thermal zones, tsens and qfprom nodes
  arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  36 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 101 +++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                | 105 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 105 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  66 +++++
 drivers/clk/qcom/gcc-msm8960.c                     |  23 +-
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom/Kconfig                       |  10 +
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/tsens-8916.c                  | 107 ++++++++
 drivers/thermal/qcom/tsens-8960.c                  | 291 +++++++++++++++++++++
 drivers/thermal/qcom/tsens-8974.c                  | 239 +++++++++++++++++
 drivers/thermal/qcom/tsens-common.c                | 130 +++++++++
 drivers/thermal/qcom/tsens.c                       | 215 +++++++++++++++
 drivers/thermal/qcom/tsens.h                       |  69 +++++
 16 files changed, 1504 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 drivers/thermal/qcom/Kconfig
 create mode 100644 drivers/thermal/qcom/Makefile
 create mode 100644 drivers/thermal/qcom/tsens-8916.c
 create mode 100644 drivers/thermal/qcom/tsens-8960.c
 create mode 100644 drivers/thermal/qcom/tsens-8974.c
 create mode 100644 drivers/thermal/qcom/tsens-common.c
 create mode 100644 drivers/thermal/qcom/tsens.c
 create mode 100644 drivers/thermal/qcom/tsens.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

