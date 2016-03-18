From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] power: ipaq-micro-battery: freeing the wrong variable
Date: Fri, 18 Mar 2016 12:00:51 +0300
Message-ID: <20160318090051.GA19233@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26118 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbcCRJBu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 05:01:50 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

We accidentally free "micro_ac_power" which is an error pointer and it
leads to an oops.  We intended to free "micro_batt_power".

Fixes: a2c1d531854c ('power_supply: ipaq_micro_battery: Check return values in probe')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/power/ipaq_micro_battery.c b/drivers/power/ipaq_micro_battery.c
index 3f314b1..35b01c7 100644
--- a/drivers/power/ipaq_micro_battery.c
+++ b/drivers/power/ipaq_micro_battery.c
@@ -261,7 +261,7 @@ static int micro_batt_probe(struct platform_device *pdev)
 	return 0;
 
 ac_err:
-	power_supply_unregister(micro_ac_power);
+	power_supply_unregister(micro_batt_power);
 batt_err:
 	cancel_delayed_work_sync(&mb->update);
 	destroy_workqueue(mb->wq);
