From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 0/8] qcom: Add support for TSENS driver
Date: Fri,  9 Oct 2015 15:11:02 +0530
Message-ID: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42813 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbbJIJlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 05:41:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, agross@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com, Rajendra Nayak <rnayak@codeaurora.org>

Patches 1/8 to 4/8 will need to go via the thermal tree/Eduardo.
Patches 5/8 to 8/8 will need to go via qcom-msm tree/Andy.

Eduardo, can you please take a look at the patches and let me
know if you see any issues.

Current set of patches apply on 4.3-rc4. Need to pull in clk-next
(for a dependent patch) to be able to test on ifc6410 board.

Changes since v3:
* Dropped 'clk: qcom: create virtual child device for TSENS' which
is picked up by Stephen
* Updated GCC bindings with optional TSENS properties

Changes since v2:
* Minor review fixes from Stephen/Punit and rebase on 4.3-rc4

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

Rajendra Nayak (8):
  thermal: qcom: tsens: Add a skeletal TSENS drivers
  thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
  thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
  thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
  arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes
  arm: dts: apq8064: Add thermal zones, tsens and qfprom nodes
  arm: dts: apq8084: Add thermal zones, tsens and qfprom nodes
  arm64: dts: msm8916: Add thermal zones, tsens and qfprom nodes

 .../devicetree/bindings/clock/qcom,gcc.txt         |  20 ++
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  33 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 101 +++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                | 105 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 105 ++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  66 +++++
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom/Kconfig                       |  10 +
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/tsens-8916.c                  | 107 ++++++++
 drivers/thermal/qcom/tsens-8960.c                  | 291 +++++++++++++++++++++
 drivers/thermal/qcom/tsens-8974.c                  | 239 +++++++++++++++++
 drivers/thermal/qcom/tsens-common.c                | 130 +++++++++
 drivers/thermal/qcom/tsens.c                       | 206 +++++++++++++++
 drivers/thermal/qcom/tsens.h                       |  69 +++++
 16 files changed, 1490 insertions(+)
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

