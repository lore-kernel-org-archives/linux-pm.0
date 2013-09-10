From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH 3/4] ARM: i.MX: change dev_id to cpu0 while registering cpu clock
Date: Tue, 10 Sep 2013 18:59:48 +0100
Message-ID: <1378835989-19281-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56277 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3IJSAA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2013 14:00:00 -0400
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently all clkdev registration use "cpufreq-cpu0.0" as dev_id
for cpu clock which refers to virtual platform device. It needs to
be "cpu0" instead which is actual cpu0 device id.

This patch changes the dev_id from "cpufreq-cpu0.0" to "cpu0".

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-imx/clk-imx27.c       | 2 +-
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index c3cfa41..c6b40f3 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -285,7 +285,7 @@ int __init mx27_clocks_init(unsigned long fref)
 =09clk_register_clkdev(clk[ata_ahb_gate], "ata", NULL);
 =09clk_register_clkdev(clk[rtc_ipg_gate], NULL, "imx21-rtc");
 =09clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
-=09clk_register_clkdev(clk[cpu_div], NULL, "cpufreq-cpu0.0");
+=09clk_register_clkdev(clk[cpu_div], NULL, "cpu0");
 =09clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);
=20
 =09mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-im=
x51-imx53.c
index 1a56a33..de1964c 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -328,7 +328,7 @@ static void __init mx5_clocks_common_init(unsigned long=
 rate_ckil,
 =09clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
 =09clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
 =09clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
-=09clk_register_clkdev(clk[cpu_podf], NULL, "cpufreq-cpu0.0");
+=09clk_register_clkdev(clk[cpu_podf], NULL, "cpu0");
 =09clk_register_clkdev(clk[iim_gate], "iim", NULL);
 =09clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.0");
 =09clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.1");
--=20
1.8.1.2


