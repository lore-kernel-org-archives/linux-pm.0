From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH v4 2/2] cpufreq: imx6q-cpufreq driver depends on SOC_IMX6Q/SOC_IMX6SL
Date: Thu,  9 Jan 2014 18:39:52 -0800
Message-ID: <1389321592-33220-2-git-send-email-john.tobias.ph@gmail.com>
References: <1389321592-33220-1-git-send-email-john.tobias.ph@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389321592-33220-1-git-send-email-john.tobias.ph@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, festevam@gmail.com
Cc: John Tobias <john.tobias.ph@gmail.com>
List-Id: linux-pm@vger.kernel.org

The ARCH_HAS_CPUFREQ, HAVE_IMX_ANATOP and PM_OPP are moved up to ARCH_MCX.
The driver should show if the SOC_IMX6Q and/or SOC_IMX6SL is/are selected.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3ba5dcc..230c663 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -80,7 +80,7 @@ config ARM_HIGHBANK_CPUFREQ
 
 config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
-	depends on ARCH_MXC
+	depends on SOC_IMX6Q || SOC_IMX6SL
 	depends on REGULATOR_ANATOP
 	help
 	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
-- 
1.8.3.2
