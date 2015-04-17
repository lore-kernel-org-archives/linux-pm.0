From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 0/7] arm64: qcom: cpuidle support for MSM8916 SoC
Date: Fri, 17 Apr 2015 17:49:02 -0600
Message-ID: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, mark.rutland@arm.com, Will.Deacon@arm.com, lorenzo.pieralisi@arm.com
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, mlocke@codeaurora.org, bryanh@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset adds cpuidle support for the MSM8916 Qualcomm SoC.  This is based
on cpu-ops patches for the QCOM arm-v8 SoCs [1].

MSM8916 SoC is a quad-A53 SoC with an L2 configured as a single cluster. Like
many other QCOM SoC's the power management for the cpu is controlled by a
peripheral hardware block called the Subsystem Power Manager (SPM) [2]. The SPM
is a finite state machine that is triggered when the core executes the ARM WFI
instruction. SPM is configured to execute the desired idle state before
terminating the cpu in SCM. Low power modes supported are WFI and SPC (standalone
power collapse - individual cpu power down state).

The patches do the following -

- Modify ARM32 cpuidle_ops structure to match that of ARM64
- Support ARM32 and AARCH64 initialization using the same platform code
- Add 8916 specific SPM register information
- Add device bindings for 8916 SPM nodes
- Add cpuidle device bindings.

Thanks,
Lina

[1]. https://lkml.org/lkml/2015/4/9/774
[2]. http://www.spinics.net/lists/arm-kernel/msg411542.html

Lina Iyer (7):
  arm: Modify cpuidle_ops structures to match ARM64
  arm64: qcom: Add SPM driver support for ARM and ARM64
  qcom: spm: Use u32 for register offsets
  qcom: spm: Add 8916 SPM register data
  arm64: dts: Add power-controller device bindings for QCOM 8916 SoC
  arm64: dts: Add cpu idle states for 8916
  arm64: defconfig: Enable power management support for QCOM SoCs

 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  1 +
 arch/arm/include/asm/cpuidle.h                     |  4 +--
 arch/arm/kernel/cpuidle.c                          |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 38 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/soc/qcom/cpu_ops.c                         |  5 +++
 drivers/soc/qcom/spm.c                             | 40 ++++++++++++++++++----
 7 files changed, 82 insertions(+), 9 deletions(-)

-- 
2.1.0
