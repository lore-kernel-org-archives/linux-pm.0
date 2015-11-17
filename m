From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] cpufreq: do not mark s3c2410_plls_add as __init
Date: Tue, 17 Nov 2015 10:57:48 +0900
Message-ID: <564A899C.4040402@samsung.com>
References: <8497197.sYxqVOch7s@wuerfel> <28389377.zxoR5rtJ13@vostro.rjw.lan>
 <4389196.cuM78vZZnJ@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------080504020908010100070006
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:36345 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbKQB5y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 20:57:54 -0500
In-reply-to: <4389196.cuM78vZZnJ@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------080504020908010100070006
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 17.11.2015 07:17, Arnd Bergmann wrote:
> On Monday 16 November 2015 23:36:42 Rafael J. Wysocki wrote:
>>
>> This should go in through the Samsung tree, so I'll leave it for them to pick
>> it up (at least for the time being).
> 
> Ok, fair enough. Kukjin or Krzysztof, can you pick this up?

Sure.

As for the patch I think everything can be converted to init/initdata
(as in attachment).

Best regards,
Krzysztof




--------------080504020908010100070006
Content-Type: text/x-patch;
 name="init_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="init_data.patch"

diff --git a/arch/arm/mach-s3c24xx/pll-s3c2410.c b/arch/arm/mach-s3c24xx/pll-s3c2410.c
index 5e37d368594b..d9fd5319379b 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2410.c
@@ -65,12 +65,12 @@ static struct cpufreq_frequency_table pll_vals_12MHz[] = {
     { .frequency = 270000000, .driver_data = PLLVAL(127, 1, 1),  },
 };
 
-static int s3c2410_plls_add(struct device *dev, struct subsys_interface *sif)
+static int __init s3c2410_plls_add(struct device *dev, struct subsys_interface *sif)
 {
 	return s3c_plltab_register(pll_vals_12MHz, ARRAY_SIZE(pll_vals_12MHz));
 }
 
-static struct subsys_interface s3c2410_plls_interface = {
+static struct subsys_interface s3c2410_plls_interface __initdata = {
 	.name		= "s3c2410_plls",
 	.subsys		= &s3c2410_subsys,
 	.add_dev	= s3c2410_plls_add,
@@ -83,7 +83,7 @@ static int __init s3c2410_pll_init(void)
 }
 arch_initcall(s3c2410_pll_init);
 
-static struct subsys_interface s3c2410a_plls_interface = {
+static struct subsys_interface s3c2410a_plls_interface __initdata = {
 	.name		= "s3c2410a_plls",
 	.subsys		= &s3c2410a_subsys,
 	.add_dev	= s3c2410_plls_add,
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
index a19460e6e7b0..01958230cf2f 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
@@ -50,7 +50,7 @@ static struct cpufreq_frequency_table s3c2440_plls_12[] __initdata = {
 	{ .frequency = 400000000,	.driver_data = PLLVAL(0x5c, 1, 1),  }, 	/* FVco 800.000000 */
 };
 
-static int s3c2440_plls12_add(struct device *dev, struct subsys_interface *sif)
+static int __init s3c2440_plls12_add(struct device *dev, struct subsys_interface *sif)
 {
 	struct clk *xtal_clk;
 	unsigned long xtal;
@@ -71,7 +71,7 @@ static int s3c2440_plls12_add(struct device *dev, struct subsys_interface *sif)
 	return 0;
 }
 
-static struct subsys_interface s3c2440_plls12_interface = {
+static struct subsys_interface s3c2440_plls12_interface __initdata = {
 	.name		= "s3c2440_plls12",
 	.subsys		= &s3c2440_subsys,
 	.add_dev	= s3c2440_plls12_add,
@@ -84,7 +84,7 @@ static int __init s3c2440_pll_12mhz(void)
 }
 arch_initcall(s3c2440_pll_12mhz);
 
-static struct subsys_interface s3c2442_plls12_interface = {
+static struct subsys_interface s3c2442_plls12_interface __initdata = {
 	.name		= "s3c2442_plls12",
 	.subsys		= &s3c2442_subsys,
 	.add_dev	= s3c2440_plls12_add,
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
index 1191b2905625..db9f476ab581 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
@@ -78,7 +78,7 @@ static struct cpufreq_frequency_table s3c2440_plls_169344[] __initdata = {
 	{ .frequency = 402192000,	.driver_data = PLLVAL(87, 2, 1), 	}, 	/* FVco 804.384000 */
 };
 
-static int s3c2440_plls169344_add(struct device *dev,
+static int __init s3c2440_plls169344_add(struct device *dev,
 				  struct subsys_interface *sif)
 {
 	struct clk *xtal_clk;
@@ -100,7 +100,7 @@ static int s3c2440_plls169344_add(struct device *dev,
 	return 0;
 }
 
-static struct subsys_interface s3c2440_plls169344_interface = {
+static struct subsys_interface s3c2440_plls169344_interface __initdata  = {
 	.name		= "s3c2440_plls169344",
 	.subsys		= &s3c2440_subsys,
 	.add_dev	= s3c2440_plls169344_add,
@@ -112,7 +112,7 @@ static int __init s3c2440_pll_16934400(void)
 }
 arch_initcall(s3c2440_pll_16934400);
 
-static struct subsys_interface s3c2442_plls169344_interface = {
+static struct subsys_interface s3c2442_plls169344_interface __initdata = {
 	.name		= "s3c2442_plls169344",
 	.subsys		= &s3c2442_subsys,
 	.add_dev	= s3c2440_plls169344_add,

--------------080504020908010100070006--
