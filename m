From: Len Brown <lenb@kernel.org>
Subject: [PATCH 53/76] ACPI: Evaluate thermal trip points before reading
 temperature
Date: Fri, 30 Mar 2012 06:13:56 -0400
Message-ID: <9bcb8118965ab4631a65ee0726e6518f75cda6c5.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg@redhat.com>

An HP laptop (Pavilion G4-1016tx) has the following code in _TMP:

       Store (\_SB.PCI0.LPCB.EC0.RTMP, Local0)
       If (LGreaterEqual (Local0, S4TP))
       {
           Store (One, HTS4)
       }

S4TP is initialised at 0 and not programmed further until either _HOT or
_CRT is called. If we evaluate _TMP before the trip points then HTS4 will
always be set, causing the firmware to generate a message on boot
complaining that the system shut down because of overheating. The simplest
solution is just to reverse the checking of trip points and _TMP in thermal
init.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 48fbc64..7dbebea 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -941,13 +941,13 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	if (!tz)
 		return -EINVAL;
 
-	/* Get temperature [_TMP] (required) */
-	result = acpi_thermal_get_temperature(tz);
+	/* Get trip points [_CRT, _PSV, etc.] (required) */
+	result = acpi_thermal_get_trip_points(tz);
 	if (result)
 		return result;
 
-	/* Get trip points [_CRT, _PSV, etc.] (required) */
-	result = acpi_thermal_get_trip_points(tz);
+	/* Get temperature [_TMP] (required) */
+	result = acpi_thermal_get_temperature(tz);
 	if (result)
 		return result;
 
-- 
1.7.10.rc2.19.gfae9d

