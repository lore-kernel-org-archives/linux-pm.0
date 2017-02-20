From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] PM / OPP: fix off-by-one bug in
 dev_pm_opp_get_max_volt_latency loop
Date: Mon, 20 Feb 2017 19:57:57 +0100
Message-ID: <1487617077-21865-1-git-send-email-a.hajda@samsung.com>
References: <CGME20170220185824eucas1p227fb1d8679f66825702296113c776095@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34547 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdBTS6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Feb 2017 13:58:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Reading array at given index before checking if index is valid results in
illegal memory access.

The bug was detected using KASAN framework.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/base/power/opp/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 91ec323..dae6172 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -231,7 +231,8 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	 * The caller needs to ensure that opp_table (and hence the regulator)
 	 * isn't freed, while we are executing this routine.
 	 */
-	for (i = 0; reg = regulators[i], i < count; i++) {
+	for (i = 0; i < count; i++) {
+		reg = regulators[i];
 		ret = regulator_set_voltage_time(reg, uV[i].min, uV[i].max);
 		if (ret > 0)
 			latency_ns += ret * 1000;
-- 
2.7.4
