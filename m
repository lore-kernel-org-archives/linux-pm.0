From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 8/9] cpufreq: zynq: Use generic platdev driver
Date: Fri, 22 Apr 2016 16:58:46 +0530
Message-ID: <e0092fa19646f22d667a46854743076465bc5429.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33360 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbcDVL3h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 07:29:37 -0400
Received: by mail-pf0-f170.google.com with SMTP id 184so40868648pff.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2016 04:29:36 -0700 (PDT)
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
index 24dde5e256d4..5ad29383e862 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -68,6 +68,8 @@ static const struct of_device_id machines[] __initcon=
st =3D {
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

