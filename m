From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] power: qcom_smbb: test the correct variable
Date: Thu, 24 Sep 2015 21:41:37 +0300
Message-ID: <20150924184137.GA28804@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"state" is a bool so it's never less than zero.  The intent was to test
"ret" instead.

Fixes: 56d7df8716b2 ('power: Add Qualcomm SMBB driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/power/qcom_smbb.c b/drivers/power/qcom_smbb.c
index 0dabfe8..5eb1e9e 100644
--- a/drivers/power/qcom_smbb.c
+++ b/drivers/power/qcom_smbb.c
@@ -351,7 +351,7 @@ static void smbb_set_line_flag(struct smbb_charger *chg, int irq, int flag)
 	int ret;
 
 	ret = irq_get_irqchip_state(irq, IRQCHIP_STATE_LINE_LEVEL, &state);
-	if (state < 0) {
+	if (ret < 0) {
 		dev_err(chg->dev, "failed to read irq line\n");
 		return;
 	}
