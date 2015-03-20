From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v17 00/11] ARM: qcom: cpuidle support for 8064, 8074, 8084
Date: Fri, 20 Mar 2015 14:21:07 -0600
Message-ID: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This v17 revision of patch has minor changes since v16. Primarily rebased on
top of Daniels' changes [1].

Changes since v16:
- Dropped per-cpu cpuidle changes in the cpuidle-arm driver, Daniel submitted
  it as part of his series.
- Rebase on top of [1].
- Return -ENXIO when qcom_cpuidle_init() detects SPM device is not probed yet.
- Declare cpuidle_ops using CPUIDLE_METHOD_OF_DECLARE.

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

[1]. https://lkml.org/lkml/2015/3/20/165


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
 drivers/cpuidle/Kconfig.arm                        |   7 +
 drivers/soc/qcom/Kconfig                           |   7 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/spm.c                             | 405 +++++++++++++++++++++
 10 files changed, 629 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 drivers/soc/qcom/spm.c

-- 
2.1.0
