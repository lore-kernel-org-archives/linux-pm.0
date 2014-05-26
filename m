From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 3/4] ARM: imx53: instanciate cpufreq device
Date: Mon, 26 May 2014 12:15:07 +0200
Message-ID: <1401099308-9658-3-git-send-email-l.stach@pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46416 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbaEZKPN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 06:15:13 -0400
In-Reply-To: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@freescale.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de

Instanciate the platform device for the i.MX5 specific
cpufreq driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx53.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 65850908a4b4..ca90967c10b7 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -26,9 +26,12 @@
 
 static void __init imx53_dt_init(void)
 {
+	struct platform_device_info devinfo = { .name = "imx5-cpufreq", };
+
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_full(&devinfo);
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
-- 
2.0.0.rc2

