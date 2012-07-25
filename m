From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/52] ACPI Battery: Added capacity
Date: Tue, 24 Jul 2012 23:41:10 -0400
Message-ID: <a58e1150225cc9e554b76da5519b2bb5bb6e46ff.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, srinivas pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

From: srinivas pandruvada <srinivas.pandruvada@intel.com>

Added Capacity field, which is a pre-defined power_supply
property. Calculating capacity using current charge/energy and
full charge/energy.
Some user mode implementations are relying on capacity field to
show battery strength and power down decision.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 7dd3f9f..5662d64 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -250,6 +250,13 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		else
 			val->intval = battery->capacity_now * 1000;
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		if (battery->capacity_now && battery->full_charge_capacity)
+			val->intval = battery->capacity_now * 100/
+					battery->full_charge_capacity;
+		else
+			val->intval = 0;
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = battery->model_number;
 		break;
@@ -276,6 +283,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
@@ -292,6 +300,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
-- 
1.7.12.rc0
