From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH] power_supply: Correct kerneldoc copy paste errors
Date: Thu, 18 Jun 2015 12:35:26 -0700
Message-ID: <1434656126-6689-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/power/power_supply_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index a44d4554af4f..869284c2e1e8 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -824,7 +824,7 @@ struct power_supply *__must_check power_supply_register(struct device *parent,
 EXPORT_SYMBOL_GPL(power_supply_register);
 
 /**
- * power_supply_register() - Register new non-waking-source power supply
+ * power_supply_register_no_ws() - Register new non-waking-source power supply
  * @parent:	Device to be a parent of power supply's device, usually
  *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
@@ -854,7 +854,7 @@ static void devm_power_supply_release(struct device *dev, void *res)
 }
 
 /**
- * power_supply_register() - Register managed power supply
+ * devm_power_supply_register() - Register managed power supply
  * @parent:	Device to be a parent of power supply's device, usually
  *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
@@ -890,7 +890,7 @@ devm_power_supply_register(struct device *parent,
 EXPORT_SYMBOL_GPL(devm_power_supply_register);
 
 /**
- * power_supply_register() - Register managed non-waking-source power supply
+ * devm_power_supply_register_no_ws() - Register managed non-waking-source power supply
  * @parent:	Device to be a parent of power supply's device, usually
  *		the device which probe function calls this
  * @desc:	Description of power supply, must be valid through whole
-- 
1.8.2.2
