From: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v16 04/11] ARM: cpuidle: Add cpuidle support for QCOM cpus
Date: Tue, 17 Mar 2015 16:33:44 -0600
Message-ID: <1426631631-56937-5-git-send-email-lina.iyer@linaro.org>
References: <1426631631-56937-1-git-send-email-lina.iyer@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426631631-56937-1-git-send-email-lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, msivasub-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Register cpuidle ops for Krait Processor Sub-System. Supports v1 and v2
versions of KPSS.

Define ARM_QCOM_CPUIDLE config item to enable cpuidle support.

Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/include/asm/cpuidle_ops.h | 5 +++++
 drivers/cpuidle/Kconfig.arm        | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include/asm/cpuidle_ops.h
index be0a612..adc8874 100644
--- a/arch/arm/include/asm/cpuidle_ops.h
+++ b/arch/arm/include/asm/cpuidle_ops.h
@@ -1,3 +1,8 @@
 /*
  * List of cpuidle operations
  */
+
+#if IS_ENABLED(CONFIG_ARM_QCOM_CPUIDLE)
+CPUIDLE_OPS(qcom_kpss_v1)
+CPUIDLE_OPS(qcom_kpss_v2)
+#endif
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 1ab9a48..b1494acb 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -75,3 +75,10 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_QCOM_CPUIDLE
+	bool "CPU Idle Driver for QCOM processors"
+	depends on ARCH_QCOM
+	select ARM_CPUIDLE
+	help
+	  Select this to enable cpuidle on QCOM processors.
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
