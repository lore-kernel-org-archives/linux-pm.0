From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC PATCH v15 00/11] ARM: qcom: cpuidle support for 8064, 8074, 8084
Date: Mon,  9 Mar 2015 09:16:35 -0600
Message-ID: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39530 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbbCIPRL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 11:17:11 -0400
Received: by pabrd3 with SMTP id rd3so39832638pab.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2015 08:17:10 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Hi,

I was able to use Daniel's series for the cpuidle_ops [5] and test it on QCOM
SOCs. This alleviates the concerns raised in the previous revision of the QCOM
cpuidle driver.

The previous revision of the QCOM cpuidle driver [1], creates cpuidle device
after a successful probe of the SPM device for the CPU.  There was a concern
regarding the initialization of unnecesary devices on a multi-v7 configuration
[2]. The solutions proposed to solve this problem didnt turn up elegant either
because of the restriction with the existing cpuidle framework.

With Daniel's patches [5], I was able to address the concerns with the cpuidle
driver and devices intialization. Please take a look at this series. The crux
of the difference from the previous series [1] is in the spm_drv_probe() and
registering of the cpuidle_ops and use of ARM generic cpuidle driver.

Changes since v14:
- Support for cpuidle_ops
- SPM probe changes to register cpuidle
- Rebase on top of 4.0-rc1
- Remove SCM patches from series. Rebased on top of Kumar's tree[4]
- Removed cpuidle-qcom.c in favor of ARM generic cpuidle driver
- Included Daniel's change for supporting creating cpuidle devices by platform

Tested on: 8074, 8084.

Thanks,
Lina

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308118.html
[2]. http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308465.html
[3]. http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311071.html
[4]. http://www.spinics.net/lists/linux-arm-msm/msg13630.html
[5]. https://lkml.org/lkml/2015/3/3/271

Daniel Lezcano (1):
  ARM: cpuidle: Register per cpuidle device

Lina Iyer (10):
  ARM: qcom: Add Subsystem Power Manager (SPM) driver
  ARM: cpuidle: qcom: Add documentation for qcom cpuidle states.
  ARM: cpuidle: Register cpuidle_ops for QCOM cpus
  ARM: dts: qcom: Add power-controller device node for 8074 Krait CPUs
  ARM: dts: qcom: Add power-controller device node for 8084 Krait CPUs
  ARM: dts: qcom: Update power-controller device node for 8064 Krait
    CPUs
  ARM: dts: qcom: Add idle states device nodes for 8074
  ARM: dts: qcom: Add idle states device nodes for 8084
  ARM: dts: qcom: Add idle state device nodes for 8064
  ARM: qcom: Update defconfig

 .../bindings/arm/msm/qcom,idle-state.txt           |  81 ++++
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  38 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  48 ++-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  48 ++-
 arch/arm/configs/qcom_defconfig                    |   2 +
 arch/arm/include/asm/cpuidle_ops.h                 |   5 +
 drivers/cpuidle/cpuidle-arm.c                      |  34 +-
 drivers/soc/qcom/Kconfig                           |   7 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/spm.c                             | 422 +++++++++++++++++++++
 11 files changed, 700 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 drivers/soc/qcom/spm.c

-- 
2.1.0

