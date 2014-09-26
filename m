From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v2 6/6] ARM: imx53: add cpufreq support
Date: Fri, 26 Sep 2014 15:41:04 +0200
Message-ID: <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39611 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbaIZNlg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 09:41:36 -0400
In-Reply-To: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Instanciate device for the generic cpufreq-dt driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2:
- new patch, split out from DTS changes and rebased
  with new name for cpufreq driver
---
 arch/arm/mach-imx/mach-imx53.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 03dd6ea13acc..7587cf0cba3e 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -41,6 +41,8 @@ static void __init imx53_dt_init(void)
 static void __init imx53_init_late(void)
 {
 	imx53_pm_init();
+
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 }
 
 static const char * const imx53_dt_board_compat[] __initconst = {
-- 
2.1.0

