From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 20/27] pm2301-charger: use pm_runtime_last_busy_and_autosuspend helper
Date: Wed, 24 Sep 2014 21:45:10 +0530
Message-ID: <1411575342-31048-21-git-send-email-vinod.koul@intel.com>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: subhransu.s.prusty@intel.com, vinod.koul@intel.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the new pm_runtime_last_busy_and_autosuspend helper instead of open
coding the same code

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/power/pm2301_charger.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pm2301_charger.c b/drivers/power/pm2301_charger.c
index 62c15af..673b203 100644
--- a/drivers/power/pm2301_charger.c
+++ b/drivers/power/pm2301_charger.c
@@ -499,8 +499,7 @@ static irqreturn_t  pm2xxx_irq_int(int irq, void *data)
 		}
 	} while (gpio_get_value(pm2->pdata->gpio_irq_number) == 0);
 
-	pm_runtime_mark_last_busy(pm2->dev);
-	pm_runtime_put_autosuspend(pm2->dev);
+	pm_runtime_last_busy_and_autosuspend(pm2->dev);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.4
