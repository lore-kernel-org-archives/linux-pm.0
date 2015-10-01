From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] linux/thermal.h: rename KELVIN_TO_CELSIUS to DECI_KELVIN_TO_CELSIUS
Date: Thu,  1 Oct 2015 23:45:31 +0200
Message-ID: <1443735931-8406-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33001 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbbJAVpp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 17:45:45 -0400
Received: by laddd9 with SMTP id dd9so686777lad.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2015 14:45:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>

The macros KELVIN_TO_CELSIUS and CELSIUS_TO_KELVIN actually convert
between deciKelvins and Celsius, so rename them to reflect that. While
at it, use a statement expression in DECI_KELVIN_TO_CELSIUS to prevent
expanding the argument multiple times and get rid of a few casts.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Cleaning out old branches, I stumbled on this which apparently fell
through the cracks
[http://thread.gmane.org/gmane.linux.drivers.platform.x86.devel/5349]. The
unit mismatch still bugs the physicist in me, so I'm resending.

 drivers/acpi/thermal.c              | 12 ++++++------
 drivers/platform/x86/asus-wmi.c     |  2 +-
 drivers/platform/x86/intel_menlow.c |  8 ++++----
 include/linux/thermal.h             |  8 +++++---
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 30d8518b25fb..82707f9824ca 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -315,7 +315,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			if (crt == -1) {
 				tz->trips.critical.flags.valid = 0;
 			} else if (crt > 0) {
-				unsigned long crt_k = CELSIUS_TO_KELVIN(crt);
+				unsigned long crt_k = CELSIUS_TO_DECI_KELVIN(crt);
 				/*
 				 * Allow override critical threshold
 				 */
@@ -351,7 +351,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
-			tmp = CELSIUS_TO_KELVIN(psv);
+			tmp = CELSIUS_TO_DECI_KELVIN(psv);
 			status = AE_OK;
 		} else {
 			status = acpi_evaluate_integer(tz->device->handle,
@@ -431,7 +431,7 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					break;
 				if (i == 1)
 					tz->trips.active[0].temperature =
-						CELSIUS_TO_KELVIN(act);
+						CELSIUS_TO_DECI_KELVIN(act);
 				else
 					/*
 					 * Don't allow override higher than
@@ -439,9 +439,9 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					 */
 					tz->trips.active[i - 1].temperature =
 						(tz->trips.active[i - 2].temperature <
-						CELSIUS_TO_KELVIN(act) ?
+						CELSIUS_TO_DECI_KELVIN(act) ?
 						tz->trips.active[i - 2].temperature :
-						CELSIUS_TO_KELVIN(act));
+						CELSIUS_TO_DECI_KELVIN(act));
 				break;
 			} else {
 				tz->trips.active[i].temperature = tmp;
@@ -1105,7 +1105,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
 	pr_info(PREFIX "%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), KELVIN_TO_CELSIUS(tz->temperature));
+		acpi_device_bid(device), DECI_KELVIN_TO_CELSIUS(tz->temperature));
 	goto end;
 
 free_memory:
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index efbc3f0c592b..bb80f7a29496 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1318,7 +1318,7 @@ static ssize_t asus_hwmon_temp1(struct device *dev,
 	if (err < 0)
 		return err;
 
-	value = KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
+	value = DECI_KELVIN_TO_CELSIUS((value & 0xFFFF)) * 1000;
 
 	return sprintf(buf, "%d\n", value);
 }
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index e8b46d2c468c..0a919d81662c 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -315,7 +315,7 @@ static ssize_t aux0_show(struct device *dev,
 
 	result = sensor_get_auxtrip(attr->handle, 0, &value);
 
-	return result ? result : sprintf(buf, "%lu", KELVIN_TO_CELSIUS(value));
+	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
 }
 
 static ssize_t aux1_show(struct device *dev,
@@ -327,7 +327,7 @@ static ssize_t aux1_show(struct device *dev,
 
 	result = sensor_get_auxtrip(attr->handle, 1, &value);
 
-	return result ? result : sprintf(buf, "%lu", KELVIN_TO_CELSIUS(value));
+	return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_CELSIUS(value));
 }
 
 static ssize_t aux0_store(struct device *dev,
@@ -345,7 +345,7 @@ static ssize_t aux0_store(struct device *dev,
 	if (value < 0)
 		return -EINVAL;
 
-	result = sensor_set_auxtrip(attr->handle, 0, CELSIUS_TO_KELVIN(value));
+	result = sensor_set_auxtrip(attr->handle, 0, CELSIUS_TO_DECI_KELVIN(value));
 	return result ? result : count;
 }
 
@@ -364,7 +364,7 @@ static ssize_t aux1_store(struct device *dev,
 	if (value < 0)
 		return -EINVAL;
 
-	result = sensor_set_auxtrip(attr->handle, 1, CELSIUS_TO_KELVIN(value));
+	result = sensor_set_auxtrip(attr->handle, 1, CELSIUS_TO_DECI_KELVIN(value));
 	return result ? result : count;
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 157d366e761b..4014a59828fc 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -44,9 +44,11 @@
 #define THERMAL_WEIGHT_DEFAULT 0
 
 /* Unit conversion macros */
-#define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
-				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
-#define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
+#define DECI_KELVIN_TO_CELSIUS(t)	({			\
+	long _t = (t);						\
+	((_t-2732 >= 0) ? (_t-2732+5)/10 : (_t-2732-5)/10);	\
+})
+#define CELSIUS_TO_DECI_KELVIN(t)	((t)*10+2732)
 #define DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, off) (((t) - (off)) * 100)
 #define DECI_KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET(t, 2732)
 #define MILLICELSIUS_TO_DECI_KELVIN_WITH_OFFSET(t, off) (((t) / 100) + (off))
-- 
2.1.3

