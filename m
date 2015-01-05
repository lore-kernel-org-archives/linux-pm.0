From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC PATCHv2 05/19] power: 88pm860x_charger: Use power_supply_*() API
 for accessing function attrs
Date: Mon, 05 Jan 2015 16:47:48 +0100
Message-ID: <1420472882-10463-6-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property
 - set_property -> power_supply_set_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samusng.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/power/88pm860x_charger.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_charger.c
index 650930e4fa79..59d62665b526 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -296,12 +296,13 @@ static int set_charging_fsm(struct pm860x_charger_info *info)
 	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
 	if (!psy)
 		return -EINVAL;
-	ret = psy->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &data);
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW,
+			&data);
 	if (ret)
 		return ret;
 	vbatt = data.intval / 1000;
 
-	ret = psy->get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data);
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_PRESENT, &data);
 	if (ret)
 		return ret;
 
@@ -430,7 +431,7 @@ static irqreturn_t pm860x_temp_handler(int irq, void *data)
 	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
 	if (!psy)
 		goto out;
-	ret = psy->get_property(psy, POWER_SUPPLY_PROP_TEMP, &temp);
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &temp);
 	if (ret)
 		goto out;
 	value = temp.intval / 10;
@@ -485,7 +486,8 @@ static irqreturn_t pm860x_done_handler(int irq, void *data)
 	psy = power_supply_get_by_name(pm860x_supplied_to[0]);
 	if (!psy)
 		goto out;
-	ret = psy->get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW,
+			&val);
 	if (ret)
 		goto out;
 	vbatt = val.intval / 1000;
@@ -500,7 +502,8 @@ static irqreturn_t pm860x_done_handler(int irq, void *data)
 	if (ret < 0)
 		goto out;
 	if (vbatt > CHARGE_THRESHOLD && ret & STATUS2_CHG)
-		psy->set_property(psy, POWER_SUPPLY_PROP_CHARGE_FULL, &val);
+		power_supply_set_property(psy, POWER_SUPPLY_PROP_CHARGE_FULL,
+				&val);
 
 out:
 	mutex_unlock(&info->lock);
-- 
1.9.1
