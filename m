From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] s3c-adc-battery: Add naive
	POWER_SUPPLY_PROP_PRESENT implementation
Date: Thu, 10 Nov 2011 09:56:43 +0100
Message-ID: <201111100956.43979.heiko__30960.7537383728$1320915429$gmane$org@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Userspace programs like upower seem to depend on the presence of the
POWER_SUPPLY_PROP_PRESENT property.

The real presence of the battery cannot be sensed and all other
routines of s3c-adc-battery simply expect it to be present.

Therefore we simply return 1, unless the battery struct is not present at all.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/power/s3c_adc_battery.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/power/s3c_adc_battery.c b/drivers/power/s3c_adc_battery.c
index d32d0d7..42d1f92 100644
--- a/drivers/power/s3c_adc_battery.c
+++ b/drivers/power/s3c_adc_battery.c
@@ -51,6 +51,7 @@ static enum power_supply_property s3c_adc_backup_bat_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_PRESENT,
 };
 
 static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
@@ -60,6 +61,11 @@ static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
 	struct s3c_adc_bat *bat = container_of(psy, struct s3c_adc_bat, psy);
 
 	if (!bat) {
+		if (psp == POWER_SUPPLY_PROP_PRESENT) {
+			val->intval = 0;
+			return 0;
+		}
+
 		dev_err(psy->dev, "%s: no battery infos ?!\n", __func__);
 		return -EINVAL;
 	}
@@ -83,6 +89,9 @@ static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		val->intval = bat->pdata->backup_volt_max;
 		return 0;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -106,6 +115,7 @@ static enum power_supply_property s3c_adc_main_bat_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
 };
 
 static int calc_full_volt(int volt_val, int cur_val, int impedance)
@@ -132,6 +142,11 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 	unsigned int lut_size = bat->pdata->lut_noac_cnt;
 
 	if (!bat) {
+		if (psp == POWER_SUPPLY_PROP_PRESENT) {
+			val->intval = 0;
+			return 0;
+		}
+
 		dev_err(psy->dev, "no battery infos ?!\n");
 		return -EINVAL;
 	}
@@ -205,6 +220,9 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		val->intval = bat->cur_value;
 		return 0;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
1.6.1
