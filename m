From: Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4 1/2] power_supply: Add more charge types and CHARGE_CONTROL_* properties
Date: Tue, 16 Apr 2019 18:43:19 -0600
Message-ID: <20190417004320.232200-1-ncrews@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dlaurie@chromium.org, lamzin@google.com, bartfab@google.com, derat@google.com, dtor@google.com, sjg@chromium.org, jchwong@chromium.org, Nick Crews <ncrews@chromium.org>
List-Id: linux-pm@vger.kernel.org

Add "Standard", "Adaptive", and "Custom" modes to the charge_type
property, to expand the existing "Trickle" and "Fast" modes.
In addition, add POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
and POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties, to expand
the existing CHARGE_CONTROL_* properties. I am adding them in order
to support a new Chrome OS device, but these properties should be
general enough that they can be used on other devices.

The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
more tricky: "Adaptive" means that the charge controller uses some
custom algorithm to change the charge type automatically, with no
configuration needed. "Custom" means that the charge controller uses the
POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
other algorithm. For example, in the use case that I am supporting,
this means the battery begins charging when the percentage
level drops below POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
charging ceases when the percentage level goes above
POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD.

v4 changes:
- Add documentation for the new properties, and add documentation for
  the the previously missing charge_control_limit and
  charge_control_limit_max properties.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 Documentation/ABI/testing/sysfs-class-power | 51 +++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c   |  4 +-
 include/linux/power_supply.h                | 10 +++-
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dce1b..b77e30b9014e 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -114,15 +114,60 @@ Description:
 		Access: Read
 		Valid values: Represented in microamps
 
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowable charging current. Used for charge rate
+		throttling for thermal cooling or improving battery health.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_limit_max
+Date:		Oct 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum legal value for the charge_control_limit property.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_start_threshold
+Date:		April 2019
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents a battery percentage level, below which charging will
+		begin.
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/charge_control_end_threshold
+Date:		April 2019
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents a battery percentage level, above which charging will
+		stop.
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
 What:		/sys/class/power_supply/<supply_name>/charge_type
 Date:		July 2009
 Contact:	linux-pm@vger.kernel.org
 Description:
 		Represents the type of charging currently being applied to the
-		battery.
+		battery. "Trickle", "Fast", and "Standard" all mean different
+		charging speeds. "Adaptive" means that the charger uses some
+		algorithm to adjust the charge rate dynamically, without
+		any user configuration required. "Custom" means that the charger
+		uses the charge_control_* properties as configuration for some
+		different algorithm.
 
-		Access: Read
-		Valid values: "Unknown", "N/A", "Trickle", "Fast"
+		Access: Read, Write
+		Valid values: "Unknown", "N/A", "Trickle", "Fast", "Standard",
+			      "Adaptive", "Custom"
 
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..6104a3f03d46 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -56,7 +56,7 @@ static const char * const power_supply_status_text[] = {
 };
 
 static const char * const power_supply_charge_type_text[] = {
-	"Unknown", "N/A", "Trickle", "Fast"
+	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
 };
 
 static const char * const power_supply_health_text[] = {
@@ -274,6 +274,8 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(constant_charge_voltage_max),
 	POWER_SUPPLY_ATTR(charge_control_limit),
 	POWER_SUPPLY_ATTR(charge_control_limit_max),
+	POWER_SUPPLY_ATTR(charge_control_start_threshold),
+	POWER_SUPPLY_ATTR(charge_control_end_threshold),
 	POWER_SUPPLY_ATTR(input_current_limit),
 	POWER_SUPPLY_ATTR(energy_full_design),
 	POWER_SUPPLY_ATTR(energy_empty_design),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 2f9c201a54d1..d59205170232 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -40,11 +40,15 @@ enum {
 	POWER_SUPPLY_STATUS_FULL,
 };
 
+/* What algorithm is the charger using? */
 enum {
 	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
 	POWER_SUPPLY_CHARGE_TYPE_NONE,
-	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
-	POWER_SUPPLY_CHARGE_TYPE_FAST,
+	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
+	POWER_SUPPLY_CHARGE_TYPE_FAST,		/* fast speed */
+	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
+	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
+	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
 };
 
 enum {
@@ -121,6 +125,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
-- 
2.20.1
