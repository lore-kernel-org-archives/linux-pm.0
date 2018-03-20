From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v5 2/5] Documentation: power: Initial effort to document
 power_supply ABI
Date: Tue, 20 Mar 2018 14:33:44 +0000
Message-ID: <332c75320c6ef1aad7bb31cfc2a78d3d5914714b.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds generic ABI information regarding power_supply
properties. This is an initial attempt to try and align the usage
of these properties between drivers. As part of this commit,
common Battery and USB related properties have been listed.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 443 ++++++++++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 444 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f85ce9e..e046566 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -1,3 +1,446 @@
+===== General Properties =====
+
+What:		/sys/class/power_supply/<supply_name>/manufacturer
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the name of the device manufacturer.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/model_name
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the name of the device model.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/serial_number
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the serial number of the device.
+
+		Access: Read
+		Valid values: Represented as string
+
+What:		/sys/class/power_supply/<supply_name>/type
+Date:		May 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Describes the main type of the supply.
+
+		Access: Read
+		Valid values: "Battery", "UPS", "Mains", "USB"
+
+===== Battery Properties =====
+
+What:		/sys/class/power_supply/<supply_name>/capacity
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Fine grain representation of battery capacity.
+		Access: Read
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum battery capacity trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery discharging scenario where user-space needs to know the
+		battery has dropped to an upper level so it can take
+		appropriate action (e.g. warning user that battery level is
+		low).
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum battery capacity trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery discharging scenario where user-space needs to know the
+		battery has dropped to a lower level so it can take
+		appropriate action (e.g. warning user that battery level is
+		critically low).
+
+		Access: Read, Write
+		Valid values: 0 - 100 (percent)
+
+What:		/sys/class/power_supply/<supply_name>/capacity_level
+Date:		June 2009
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Coarse representation of battery capacity.
+
+		Access: Read
+		Valid values: "Unknown", "Critical", "Low", "Normal", "High",
+			      "Full"
+
+What:		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average IBAT current reading for the battery, over a
+		fixed period. Normally devices will provide a fixed interval in
+		which they average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum IBAT current allowed into the battery.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single IBAT current reading for the battery.
+		This value is not averaged/smoothed.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/charge_type
+Date:		July 2009
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the type of charging currently being applied to the
+		battery.
+
+		Access: Read
+		Valid values: "Unknown", "N/A", "Trickle", "Fast"
+
+What:		/sys/class/power_supply/<supply_name>/charge_term_current
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the charging current value which is used to determine
+		when the battery is considered full and charging should end.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/health
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the health of the battery or battery side of charger
+		functionality.
+
+		Access: Read
+		Valid values: "Unknown", "Good", "Overheat", "Dead",
+			      "Over voltage", "Unspecified failure", "Cold",
+			      "Watchdog timer expire", "Safety timer expire"
+
+What:		/sys/class/power_supply/<supply_name>/precharge_current
+Date:		June 2017
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the charging current applied during pre-charging phase
+		for a battery charge cycle.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/present
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports whether a battery is present or not in the system.
+
+		Access: Read
+		Valid values:
+			0: Absent
+			1: Present
+
+What:		/sys/class/power_supply/<supply_name>/status
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the charging status of the battery. Normally this
+		is read-only reporting although for some supplies this can be
+		used to enable/disable charging to the battery.
+
+		Access: Read, Write
+		Valid values: "Unknown", "Charging", "Discharging",
+			      "Not charging", "Full"
+
+What:		/sys/class/power_supply/<supply_name>/technology
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Describes the battery technology supported by the supply.
+
+		Access: Read
+		Valid values: "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
+			      "NiCd", "LiMn"
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the current TBAT battery temperature reading.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum TBAT temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery charging scenario where user-space needs to know the
+		battery temperature has crossed an upper threshold so it can
+		take appropriate action (e.g. warning user that battery level is
+		critically high, and charging has stopped).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum TBAT temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		battery charging scenario where user-space needs to know the
+		battery temperature has crossed a lower threshold so it can take
+		appropriate action (e.g. warning user that battery level is
+		high, and charging current has been reduced accordingly to
+		remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum allowed TBAT battery temperature for
+		charging.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum allowed TBAT battery temperature for
+		charging.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/voltage_avg,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average VBAT voltage reading for the battery, over a
+		fixed period. Normally devices will provide a fixed interval in
+		which they average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_max,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum safe VBAT voltage permitted for the battery,
+		during charging.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_min,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum safe VBAT voltage permitted for the battery,
+		during discharging.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_now,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an instant, single VBAT voltage reading for the battery.
+		This value is not averaged/smoothed.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+===== USB Properties =====
+
+What: 		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports an average IBUS current reading over a fixed period.
+		Normally devices will provide a fixed interval in which they
+		average readings to smooth out the reported value.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+
+What: 		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum IBUS current the supply can support.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What: 		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the IBUS current supplied now. This value is generally
+		read-only reporting, unless the 'online' state of the supply
+		is set to be programmable, in which case this value can be set
+		within the reported min/max range.
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/input_current_limit
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Details the incoming IBUS current limit currently set in the
+		supply. Normally this is configured based on the type of
+		connection made (e.g. A configured SDP should output a maximum
+		of 500mA so the input current limit is set to the same value).
+
+		Access: Read, Write
+		Valid values: Represented in microamps
+
+What:		/sys/class/power_supply/<supply_name>/online,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Indicates if VBUS is present for the supply. When the supply is
+		online, and the supply allows it, then it's possible to switch
+		between online states (e.g. Fixed -> Programmable for a PD_PPS
+		USB supply so voltage and current can be controlled).
+
+		Access: Read, Write
+		Valid values:
+			0: Offline
+			1: Online Fixed - Fixed Voltage Supply
+			2: Online Programmable - Programmable Voltage Supply
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the current supply temperature reading. This would
+		normally be the internal temperature of the device itself (e.g
+		TJUNC temperature of an IC)
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum supply temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		charging scenario where user-space needs to know the supply
+		temperature has crossed an upper threshold so it can take
+		appropriate action (e.g. warning user that the supply
+		temperature is critically high, and charging has stopped to
+		remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum supply temperature trip-wire value where the supply will
+		notify user-space of the event. This is normally used for the
+		charging scenario where user-space needs to know the supply
+		temperature has crossed a lower threshold so it can take
+		appropriate action (e.g. warning user that the supply
+		temperature is high, and charging current has been reduced
+		accordingly to remedy the situation).
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum allowed supply temperature for operation.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the mainimum allowed supply temperature for operation.
+
+		Access: Read
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_max
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the maximum VBUS voltage the supply can support.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_min
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the minimum VBUS voltage the supply can support.
+
+		Access: Read
+		Valid values: Represented in microvolts
+
+What: 		/sys/class/power_supply/<supply_name>/voltage_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Reports the VBUS voltage supplied now. This value is generally
+		read-only reporting, unless the 'online' state of the supply
+		is set to be programmable, in which case this value can be set
+		within the reported min/max range.
+
+		Access: Read, Write
+		Valid values: Represented in microvolts
+
+===== Device Specific Properties =====
+
 What:		/sys/class/power/ds2760-battery.*/charge_now
 Date:		May 2010
 KernelVersion:	2.6.35
diff --git a/MAINTAINERS b/MAINTAINERS
index 2bee7ac..5bb0a10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11098,6 +11098,7 @@ M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-power
 F:	Documentation/devicetree/bindings/power/supply/
 F:	include/linux/power_supply.h
 F:	drivers/power/supply/
-- 
1.9.1
