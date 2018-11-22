From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 1/2] power: supply: add input voltage limit property.
Date: Thu, 22 Nov 2018 11:11:18 +0100
Message-ID: <20181122101119.29194-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, sre@kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org, linux-kernel@vger.kernel.org, groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com, bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

We have a problem with USBPD chargers which under certain conditions
can result in system overheating if the voltage provided by the USBPD
port is too high. While the preferred means to control this would be
through devicetree or ACPI settings, this is not always possible, and
we need to have a means to set a voltage limit.

This patch exposes a new property, similar to input current limit, to
re-configure the maximum voltage from the external supply at runtime
based on system-level knowledge or user input.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v2:
- Document the new property in ABI/testing/sysfs-class-power.
- Add the Reviewed-by Guenter Roeck tag.

 Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
 Documentation/power/power_supply_class.txt  |  2 ++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dce1b..4fb24b0a28df 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -335,6 +335,17 @@ Description:
 		Access: Read, Write
 		Valid values: Represented in microamps
 
+What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
+Date:		Nov 2018
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Details the incoming VBUS voltage limit currently set in the
+		supply. Normally this is configured based on the type of
+		connection made.
+
+		Access: Read, Write
+		Valid values: Represented in microvolts
+
 What:		/sys/class/power_supply/<supply_name>/online,
 Date:		May 2007
 Contact:	linux-pm@vger.kernel.org
diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
index 300d37896e51..7b4be615b4f8 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -137,6 +137,8 @@ power supply object.
 
 INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
 the current drawn from a charging source.
+INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
+the voltage limit from a charging source.
 
 CHARGE_CONTROL_LIMIT - current charge control limit setting
 CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..5848742ebb59 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(charge_control_limit),
 	POWER_SUPPLY_ATTR(charge_control_limit_max),
 	POWER_SUPPLY_ATTR(input_current_limit),
+	POWER_SUPPLY_ATTR(input_voltage_limit),
 	POWER_SUPPLY_ATTR(energy_full_design),
 	POWER_SUPPLY_ATTR(energy_empty_design),
 	POWER_SUPPLY_ATTR(energy_full),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f80769175c56..608ba88e32ee 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -122,6 +122,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
-- 
2.19.1
