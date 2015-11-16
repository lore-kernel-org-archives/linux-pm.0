From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: do not mark s3c2410_plls_add as __init
Date: Mon, 16 Nov 2015 22:26:43 +0100
Message-ID: <8497197.sYxqVOch7s@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

s3c2410_plls_add is a device notifier that may be called at runtime and
is correctly not marked __init. However it calls s3c_plltab_register()
which is marked __init, and that triggers a build error when we are
checking for section mismatches:

WARNING: vmlinux.o(.text+0x195e0): Section mismatch in reference from the function s3c2410_plls_add() to the function .init.text:s3c_plltab_register()
The function s3c2410_plls_add() references
the function __init s3c_plltab_register().
This is often because s3c2410_plls_add lacks a __init
annotation or the annotation of s3c_plltab_register is wrong.

This removes the __init annotation from s3c2410_plls_add as well as the
__initdata section annotations from s3c2440_plls_12 and s3c2440_plls_169344,
which in turn are referenced from s3c2410_plls_add.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
It would be nice to get this merged through the cpufreq tree. Most likely
this has never caused problems because the device notifiers in practice
only get called at boot time, so I assume it's enough to have this fixed
in 4.4 or 4.5 but not backported.

diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
index a19460e6e7b0..b355fca6cc2e 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
@@ -20,7 +20,7 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
-static struct cpufreq_frequency_table s3c2440_plls_12[] __initdata = {
+static struct cpufreq_frequency_table s3c2440_plls_12[] = {
 	{ .frequency = 75000000,	.driver_data = PLLVAL(0x75, 3, 3),  }, 	/* FVco 600.000000 */
 	{ .frequency = 80000000,	.driver_data = PLLVAL(0x98, 4, 3),  }, 	/* FVco 640.000000 */
 	{ .frequency = 90000000,	.driver_data = PLLVAL(0x70, 2, 3),  }, 	/* FVco 720.000000 */
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
index 1191b2905625..be9a248b5ce9 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
@@ -20,7 +20,7 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
-static struct cpufreq_frequency_table s3c2440_plls_169344[] __initdata = {
+static struct cpufreq_frequency_table s3c2440_plls_169344[] = {
 	{ .frequency = 78019200,	.driver_data = PLLVAL(121, 5, 3), 	}, 	/* FVco 624.153600 */
 	{ .frequency = 84067200,	.driver_data = PLLVAL(131, 5, 3), 	}, 	/* FVco 672.537600 */
 	{ .frequency = 90115200,	.driver_data = PLLVAL(141, 5, 3), 	}, 	/* FVco 720.921600 */
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 733aa5153e74..68ef8fd9482f 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -648,7 +648,7 @@ late_initcall(s3c_cpufreq_initcall);
  *
  * Register the given set of PLLs with the system.
  */
-int __init s3c_plltab_register(struct cpufreq_frequency_table *plls,
+int s3c_plltab_register(struct cpufreq_frequency_table *plls,
 			       unsigned int plls_no)
 {
 	struct cpufreq_frequency_table *vals;
