From: Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 0/5] Qualcomm Suspend to Idle Support
Date: Thu, 19 May 2016 00:00:15 -0500
Message-ID: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, Andy Gross <andy.gross@linaro.org>
List-Id: linux-pm@vger.kernel.org

This set of patches adds suspend to idle support for the Qualcomm APQ8084
and MSM8916 platforms.  The patches add a minimal set of suspend ops and
init functions to properly configure the enter_freeze function.

This patch set is based on the work done in the following:
[RFC v3 00/12] PM: SoC idle support using PM domains
http://comments.gmane.org/gmane.linux.ports.arm.msm/17966

The relevant prerequisites are the PSCI enablement DT patches.  PSCI based
firmware is also required for the MSM8916 to work properly.

Andy Gross (5):
  soc: qcom: Add suspend to idle support
  arm: defconfig: Add Qualcomm Suspend options
  arm64: dts: msm8916: Add spc compat tag
  ARM: dts: qcom: Remove size elements from pmic reg
  ARM: dts: qcom: pma8084: Add pwrkey entry

 arch/arm/boot/dts/qcom-pma8084.dtsi   | 20 ++++++---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |  2 +-
 arch/arm64/configs/defconfig          |  2 +
 drivers/soc/qcom/Makefile             |  1 +
 drivers/soc/qcom/suspend.c            | 77 +++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 7 deletions(-)
 create mode 100644 drivers/soc/qcom/suspend.c

-- 
1.9.1
