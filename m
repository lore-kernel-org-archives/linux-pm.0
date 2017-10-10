From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
Date: Tue, 10 Oct 2017 14:20:07 +0300
Message-ID: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com ([104.47.41.42]:57760
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755841AbdJJLUP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Oct 2017 07:20:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Bai Ping <ping.bai@nxp.com>

Enable cpuidle support on i.MX6DL starting from IMX_CHIP_REVISION_1_1.

This also makes the code cleaner because 6q and 6dl actually have
different revision histories.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 45801b2..ef0c949 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -374,7 +374,8 @@ static void __init imx6q_init_late(void)
 	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
 	 * to run cpuidle on them.
 	 */
-	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
+	if ((cpu_is_imx6q() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_1) ||
+	    (cpu_is_imx6dl() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_0))
 		imx6q_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
-- 
2.7.4
