From: Andy Whitcroft <apw@canonical.com>
Subject: [PATCH 1/1] battery: only refresh the sysfs files when pertinant information changes
Date: Thu,  3 May 2012 14:48:26 +0100
Message-ID: <1336052907-15084-1-git-send-email-apw@canonical.com>
References: <20120503124708.GA18622@srcf.ucam.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120503124708.GA18622@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jonathan Nieder <jrnieder@gmail.com>
Cc: Andy Whitcroft <apw@canonical.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Adrian Fita <adrian.fita@gmail.com>, Len Brown <lenb@kernel.org>, Ralf Jung <ralfjung-e@gmx.de>, Paolo Scarabelli <paolo@msw.it>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We only need to regenerate the sysfs files when the capacity units
change, avoid the update otherwise.

Signed-off-by: Andy Whitcroft <apw@canonical.com>
---
 drivers/acpi/battery.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

	Based on Matthew's feedback here is a version which optimises
	based on the power_unit field as returned from the battery info.
	Could someone who suffers from this issue please test this out
	and report back.  Thanks.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 86933ca..7dd3f9f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -643,11 +643,19 @@ static int acpi_battery_update(struct acpi_battery *battery)
 
 static void acpi_battery_refresh(struct acpi_battery *battery)
 {
+	int power_unit;
+
 	if (!battery->bat.dev)
 		return;
 
+	power_unit = battery->power_unit;
+
 	acpi_battery_get_info(battery);
-	/* The battery may have changed its reporting units. */
+
+	if (power_unit == battery->power_unit)
+		return;
+
+	/* The battery has changed its reporting units. */
 	sysfs_remove_battery(battery);
 	sysfs_add_battery(battery);
 }
-- 
1.7.9.5

