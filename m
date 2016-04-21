From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/8] cpufreq: zynq: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:13:53 +0530
Message-ID: <9d64ef8232464d1ea5ad786b318fab49c4332005.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-zynq/common.c          | 2 --
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 860ffb663f02..da876d28ccbc 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -110,7 +110,6 @@ static void __init zynq_init_late(void)
  */
 static void __init zynq_init_machine(void)
 {
-	struct platform_device_info devinfo =3D { .name =3D "cpufreq-dt", };
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device *parent =3D NULL;
@@ -145,7 +144,6 @@ static void __init zynq_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
=20
 	platform_device_register(&zynq_cpuidle_device);
-	platform_device_register_full(&devinfo);
 }
=20
 static void __init zynq_timer_init(void)
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpu=
freq-dt-platdev.c
index db6767a1f975..c8a3eceac356 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -64,6 +64,8 @@ static const struct of_device_id machines[] =3D {
 	{ .compatible =3D "ti,omap3", },
 	{ .compatible =3D "ti,omap4", },
 	{ .compatible =3D "ti,omap5", },
+
+	{ .compatible =3D "xlnx,zynq-7000", },
 };
=20
 static int __init cpufreq_dt_platdev_init(void)
--=20
2.7.1.410.g6faf27b
