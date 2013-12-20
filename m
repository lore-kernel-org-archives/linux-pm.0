From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH v3 1/2] ARM: imx6sl: Add cpu frequency scaling support
Date: Thu, 19 Dec 2013 20:15:28 -0800
Message-ID: <1387512929-7304-1-git-send-email-john.tobias.ph@gmail.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, rjw@rjwysocki.net, shawn.guo@linaro.org, festevam@gmail.com, b20788@freescale.com, viresh.kumar@linaro.org
Cc: John Tobias <john.tobias.ph@gmail.com>
List-Id: linux-pm@vger.kernel.org

Re-use imx6q cpufreq driver to support cpu
frequency scaling on imx6sl.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/mach-imx/mach-imx6sl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 2f952e3..3072e15 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -34,6 +34,13 @@ static void __init imx6sl_fec_init(void)
 	}
 }
 
+static void __init imx6sl_init_late(void)
+{
+	/* imx6sl reuses imx6q cpufreq driver */
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
+		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
+}
+
 static void __init imx6sl_init_machine(void)
 {
 	struct device *parent;
@@ -70,6 +77,7 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
 	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6sl_init_irq,
 	.init_machine	= imx6sl_init_machine,
+	.init_late      = imx6sl_init_late,
 	.dt_compat	= imx6sl_dt_compat,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
1.8.3.2

