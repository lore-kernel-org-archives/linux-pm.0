From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/15] power-supply: Return early if "power-supplies" property isn't valid
Date: Thu,  4 Sep 2014 17:31:23 +0530
Message-ID: <ef5d24a5fcdc5b442374ae148d0c640411bdccd9.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:41288 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbaIDMCK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:10 -0400
Received: by mail-pd0-f181.google.com with SMTP id fp1so13552409pdb.40
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:10 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

If power-supply's DT node doesn't have a valid "power-supplies" entry, then
power_supply_check_supplies() should return early instead of trying to allocate
memory for "supplied_from" array.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 10f0b57..414384a 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -226,6 +226,10 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		of_node_put(np);
 	} while (np);
 
+	/* Missing valid "power-supplies" entries */
+	if (cnt == 1)
+		return 0;
+
 	/* All supplies found, allocate char ** array for filling */
 	psy->supplied_from = devm_kzalloc(psy->dev, sizeof(psy->supplied_from),
 					  GFP_KERNEL);
-- 
2.0.3.693.g996b0fd

