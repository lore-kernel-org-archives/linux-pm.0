From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v19 3/3] ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs
Date: Thu,  9 Apr 2015 13:20:43 -0600
Message-ID: <1428607243-7723-4-git-send-email-lina.iyer@linaro.org>
References: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: olof@lixom.net, arnd@arndb.de
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Update defconfig to allow cpuidle for QCOM cpus.

* Enable QCOM_PM
* Enable ARM_CPUIDLE

Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e8a4c95..18fcc66 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -96,6 +96,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_CPUIDLE=y
 CONFIG_NEON=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_NET=y
@@ -454,6 +455,7 @@ CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_QCOM_GSBI=y
+CONFIG_QCOM_PM=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_APQ_MMCC_8084=y
-- 
2.1.0
