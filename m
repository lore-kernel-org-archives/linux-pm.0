From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/15] power-supply: Rearrange code to remove duplicate lines
Date: Thu,  4 Sep 2014 17:31:28 +0530
Message-ID: <1d1fa9656ca0763735eee03ea34f4b6f70032406.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43889 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:36 -0400
Received: by mail-pd0-f176.google.com with SMTP id w10so4073623pde.35
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:35 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

of_node_put() was called twice in power_supply_check_supplies() whereas a single
call will also work. Rearrange code a bit to make that feasible.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/power/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 7657335..8a86cd1 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -218,12 +218,12 @@ static int power_supply_check_supplies(struct power_supply *psy)
 			break;
 
 		ret = power_supply_find_supply_from_node(np);
+		of_node_put(np);
+
 		if (ret) {
 			dev_dbg(psy->dev, "Failed to find supply, defer!\n");
-			of_node_put(np);
 			return -EPROBE_DEFER;
 		}
-		of_node_put(np);
 	} while (np);
 
 	/* Missing valid "power-supplies" entries */
-- 
2.0.3.693.g996b0fd

