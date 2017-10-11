From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
Date: Wed, 11 Oct 2017 15:08:23 +0300
Message-ID: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:27169
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751910AbdJKMIc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Oct 2017 08:08:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Bai Ping <ping.bai@nxp.com>

Enable cpuidle support on i.MX6DL starting from IMX_CHIP_REVISION_1_1.

This also makes the code cleaner because 6q and 6dl actually have
different revision histories.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---

Changes since v1: https://www.spinics.net/lists/arm-kernel/msg610461.html
* Clarified comment but kept > instead of >= because that's what the
old code used. Would be OK to change with further feedback.

 arch/arm/mach-imx/mach-imx6q.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 45801b2..5707113 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -371,10 +371,13 @@ static struct platform_device imx6q_cpufreq_pdev = {
 static void __init imx6q_init_late(void)
 {
 	/*
-	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
-	 * to run cpuidle on them.
+	 * WAIT mode is broken on imx6 Dual/Quad revision 1.0 and 1.1 so
+	 * there is no point to run cpuidle on them.
+	 *
+	 * It does work on imx6 Solo/DualLite starting from 1.1
 	 */
-	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
+	if ((cpu_is_imx6q() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_1) ||
+	    (cpu_is_imx6dl() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_0))
 		imx6q_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
-- 
2.7.4
