From: Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] thinkpad_acpi: add support for
 force_discharge
Date: Sun, 13 May 2018 17:30:00 +0200
Message-ID: <20180513153000.GA5117@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Lenovo ThinkPad systems have a feature that lets you
force the battery to discharge regardless if AC is attached
or not.

This patch implements that feature and exposes it via the generic
ACPI battery driver.

Signed-off-by: Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 56 ++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b8b74889..28a87640 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9236,7 +9236,11 @@ static struct ibm_struct mute_led_driver_data = {
 #define SET_INHIBIT	"BICS"
 #define GET_INHIBIT	"BICG"
 
+#define GET_DISCHARGE	"BDSG"
+#define SET_DISCHARGE	"PSBS"
+
 #define INHIBIT_ATTR	"inhibit_charge"
+#define DISCHARGE_ATTR	"force_discharge"
 
 #define START_ATTR "charge_start_threshold"
 #define STOP_ATTR  "charge_stop_threshold"
@@ -9256,7 +9260,8 @@ enum {
 	/* This is used in the get/set helpers */
 	THRESHOLD_START,
 	THRESHOLD_STOP,
-	INHIBIT_CHARGE
+	INHIBIT_CHARGE,
+	FORCE_DISCHARGE
 };
 
 struct tpacpi_battery_data {
@@ -9265,6 +9270,7 @@ struct tpacpi_battery_data {
 	int charge_stop;
 	int stop_support;
 	int inhibit_support;
+	int discharge_support;
 };
 
 struct tpacpi_battery_driver_data {
@@ -9329,6 +9335,12 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
 		/* The inhibit charge status is in the first bit */
 		*ret = *ret & 0x01;
 		return 0;
+	case FORCE_DISCHARGE:
+		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_DISCHARGE, ret, battery))
+			return -ENODEV;
+		/* The force discharge status is in the first bit */
+		*ret = *ret & 0x01;
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
@@ -9372,6 +9384,14 @@ static int tpacpi_battery_set(int what, int battery, int value)
 			return -ENODEV;
 		}
 		return 0;
+	case FORCE_DISCHARGE:
+		param = battery;
+		param |= value << 8;
+		if ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_DISCHARGE, &ret, param)) {
+			pr_err("failed to set force dischrage on %d", battery);
+			return -ENODEV;
+		}
+		return 0;
 	default:
 		pr_crit("wrong parameter: %d", what);
 		return -EINVAL;
@@ -9431,11 +9451,16 @@ static int tpacpi_battery_probe(int battery)
 			/* Support is marked in bit 5 */
 			battery_info.batteries[battery].inhibit_support = ret & BIT(5);
 
-	pr_info("battery %d registered (start %d, stop %d, inhibit: %d)",
+	if (acpi_has_method(hkey_handle, GET_DISCHARGE))
+		if (!ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_DISCHARGE, &ret, battery)))
+			battery_info.batteries[battery].discharge_support = ret & BIT(8);
+
+	pr_info("battery %d registered (start %d, stop %d, inhibit: %d, force: %d)",
 			battery,
 			battery_info.batteries[battery].charge_start,
 			battery_info.batteries[battery].charge_stop,
-			battery_info.batteries[battery].inhibit_support);
+			battery_info.batteries[battery].inhibit_support,
+			battery_info.batteries[battery].discharge_support);
 
 	return 0;
 }
@@ -9530,6 +9555,15 @@ static ssize_t tpacpi_battery_store(int what,
 		if (tpacpi_battery_set(INHIBIT_CHARGE, battery, value))
 			return -ENODEV;
 		return count;
+	case FORCE_DISCHARGE:
+		if (!battery_info.batteries[battery].discharge_support)
+			return -ENODEV;
+		/* The only valid values are 1 and 0 */
+		if (value != 0 && value != 1)
+			return -EINVAL;
+		if (tpacpi_battery_set(FORCE_DISCHARGE, battery, value))
+			return -ENODEV;
+		return count;
 	default:
 		pr_crit("Wrong parameter: %d", what);
 		return -EINVAL;
@@ -9606,14 +9640,30 @@ static ssize_t inhibit_charge_show(struct device *device,
 	return tpacpi_battery_show(INHIBIT_CHARGE, device, buf);
 }
 
+static ssize_t force_discharge_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	return tpacpi_battery_store(FORCE_DISCHARGE, dev, buf, count);
+}
+
+static ssize_t force_discharge_show(struct device *device,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return tpacpi_battery_show(FORCE_DISCHARGE, device, buf);
+}
+
 static DEVICE_ATTR_RW(charge_start_threshold);
 static DEVICE_ATTR_RW(charge_stop_threshold);
 static DEVICE_ATTR_RW(inhibit_charge);
+static DEVICE_ATTR_RW(force_discharge);
 
 static struct attribute *tpacpi_battery_attrs[] = {
 	&dev_attr_charge_start_threshold.attr,
 	&dev_attr_charge_stop_threshold.attr,
 	&dev_attr_inhibit_charge.attr,
+	&dev_attr_force_discharge.attr,
 	NULL,
 };
 
-- 
2.17.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
