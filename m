From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v19 0/3] ARM: qcom: cpuidle support for 8064, 8074, 8084
Date: Thu,  9 Apr 2015 13:20:40 -0600
Message-ID: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset adds acks and reviewed-by tags to the SPM driver and updates the
defconfig files to enable cpuidle support on the v18 rev of the patchset [1].

The dependencies for these changes are
- SCM and device tree changes for QCOM SoCs [2], [4].
- cpuidle framework changes [3]

Changes since v18:
+ Add commit tags to SPM driver
+ Update qcom_defconfig to enable cpuidle support
+ Update multi_v7_defconfig to enable cpuidle support

Thanks,
Lina

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333521.html
[2]. https://lkml.org/lkml/2015/3/27/599
[3]. https://lkml.org/lkml/2015/3/25/117
[4]. https://lkml.org/lkml/2015/1/19/483

Lina Iyer (3):
  ARM: qcom: Add Subsystem Power Manager (SPM) driver
  ARM: config: Update qcom_defconfig to enable cpuidle
  ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs

 arch/arm/configs/multi_v7_defconfig |   2 +
 arch/arm/configs/qcom_defconfig     |   2 +
 drivers/soc/qcom/Kconfig            |   7 +
 drivers/soc/qcom/Makefile           |   1 +
 drivers/soc/qcom/spm.c              | 385 ++++++++++++++++++++++++++++++++++++
 5 files changed, 397 insertions(+)
 create mode 100644 drivers/soc/qcom/spm.c

-- 
2.1.0
