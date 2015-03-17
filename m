From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v16 00/11] ARM: qcom: cpuidle support for 8064, 8074, 8084
Date: Tue, 17 Mar 2015 16:33:40 -0600
Message-ID: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35814 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932538AbbCQWeY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 18:34:24 -0400
Received: by pabyw6 with SMTP id yw6so22255232pab.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2015 15:34:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Hi,

This patchset is based on common cpuidle driver for ARM and cpuidle_ops changes
by Daniel Lezcano [1]. The cpuidle driver supports ARM architecture clockgating
(WFI) and the cpu power state (SPC) for the QCOM cpus.

Changes since v15:
https://www.mail-archive.com/devicetree@vger.kernel.org/msg64700.html
- Clean up cpuidle-arm.c to use devm_kzalloc and print error codes.
- Remove qcom,idle-state-stby as a DT mode, instead use the ARM WFI defined in
  ARM cpuidle driver for clock gating/standby modes. The platform driver will
  default to standby for all cpus after executing any low power state. This allows
  us to be completely compatible with generic ARM cpuidle driver and not send out
  cpu_pm notifications that are sent out for all 'platform states'.
- Cleaned up comments around setting SPM states.
- Platform idle state (SPC) starts at index 1, previous patch was overwritting
  ARM WFI state, which is mandated to be default state at index 0. 
- Removed duplicate cpu_pm_enter() and cpu_pm_exit() callbacks.
- Re-introduce ARM_QCOM_CPUIDLE defconfig item to enable/disable QCOM cpuidle
  support.
- Update documentation on standby state to indicate that this state is no longer
  defined in the DT.
- Remove unused qcom,saw2-v1.* compatibles from documentation.
- Rebased on top of SCM changes that were pulled in Kumar's 'soc' branch [2].
- Removed Reviewed-by tags from DT patches due to change in idle states.

Changes since v14:
- Support for cpuidle_ops
- SPM probe changes to register cpuidle
- Rebase on top of 4.0-rc1
- Remove SCM patches from series. Rebased on top of Kumar's tree
- Removed cpuidle-qcom.c in favor of ARM generic cpuidle driver
- Included Daniel's change for supporting creating cpuidle devices by platform

Tested on: 8074, 8084.

Thanks,
Lina

[1]. https://lkml.org/lkml/2015/3/3/271
[2]. https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg847249.html

Daniel Lezcano (1):
  ARM: cpuidle: Register per cpuidle device

Lina Iyer (10):
  ARM: qcom: Add Subsystem Power Manager (SPM) driver
  ARM: cpuidle: qcom: Add documentation for qcom cpuidle states
  ARM: cpuidle: Add cpuidle support for QCOM cpus
  ARM: dts: qcom: Add power-controller device node for 8074 Krait CPUs
  ARM: dts: qcom: Add power-controller device node for 8084 Krait CPUs
  ARM: dts: qcom: Update power-controller device node for 8064 Krait
    CPUs
  ARM: dts: qcom: Add idle states device nodes for 8974/8074
  ARM: dts: qcom: Add idle states device nodes for 8084
  ARM: dts: qcom: Add idle state device nodes for 8064
  ARM: qcom: Update defconfig to enable cpuidle

 .../bindings/arm/msm/qcom,idle-state.txt           |  84 +++++
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  29 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  30 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  40 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  40 +-
 arch/arm/configs/qcom_defconfig                    |   2 +
 arch/arm/include/asm/cpuidle_ops.h                 |   5 +
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/cpuidle/cpuidle-arm.c                      |  39 +-
 drivers/soc/qcom/Kconfig                           |   7 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/spm.c                             | 408 +++++++++++++++++++++
 12 files changed, 674 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 drivers/soc/qcom/spm.c

-- 
2.1.0

