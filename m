From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] power: supply: lp8788: remove an unneeded NULL check
Date: Fri, 14 Oct 2016 10:33:28 +0300
Message-ID: <20161014073328.GC15168@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We checked that "pdata->chg_params" is non-NULL earlier in this function
so when we add "i" to it, it's still non-NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 7321b72..509e2b3 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -384,9 +384,6 @@ static int lp8788_update_charger_params(struct platform_device *pdev,
 	for (i = 0; i < pdata->num_chg_params; i++) {
 		param = pdata->chg_params + i;
 
-		if (!param)
-			continue;
-
 		if (lp8788_is_valid_charger_register(param->addr)) {
 			ret = lp8788_write_byte(lp, param->addr, param->val);
 			if (ret)
