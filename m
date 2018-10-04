From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: max8925: mark expected switch fall-through
Date: Thu, 4 Oct 2018 15:56:36 +0200
Message-ID: <20181004135636.GA15157@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 201510 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/max8925_power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/max8925_power.c
index 3b94620..39b4d5b 100644
--- a/drivers/power/supply/max8925_power.c
+++ b/drivers/power/supply/max8925_power.c
@@ -124,6 +124,7 @@ static irqreturn_t max8925_charger_handler(int irq, void *data)
 	case MAX8925_IRQ_VCHG_THM_OK_F:
 		/* Battery is not ready yet */
 		dev_dbg(chip->dev, "Battery temperature is out of range\n");
+		/* Fall through */
 	case MAX8925_IRQ_VCHG_DC_OVP:
 		dev_dbg(chip->dev, "Error detection\n");
 		__set_charger(info, 0);
-- 
2.7.4
