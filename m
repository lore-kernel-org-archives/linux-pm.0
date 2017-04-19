From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 4/5] ACPI: ac: Add a blacklist with PMIC ACPI HIDs with a native charger driver
Date: Wed, 19 Apr 2017 14:02:11 +0200
Message-ID: <20170419120212.24949-5-hdegoede@redhat.com>
References: <20170419120212.24949-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170419120212.24949-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some systems we have a native PMIC driver which provides Mains
monitoring, while the ACPI ac driver is broken on these systems
due to bad DSTDs or because we do not support the proprietary and
undocumented ACPI opregions these ACPI battery devices rely on
(e.g. BMOP opregion).

This leads for example to a ADP1 power_supply which reports
itself as always online even if no mains are connected.

This commit adds a blacklist with PMIC ACPI HIDs for which we've a
native charger or extcon driver and makes the ACPI ac driver not
register itself when a PMIC on this list is present.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set replacing:
 "ACPI: ac: Add acpi_ac_unregister() function"
 "power: supply: axp288_charger: Unregister duplicate ACPI ac supply"
 And also this patch from my local patch-queue (not submitted yet):
 "i2c-cht-wc: remove broken ACPI AC power-supply"
Changes in v7:
-Some minor code style tweaks based on review from Andy Shevchenko
---
 drivers/acpi/ac.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f71b756..8f52483 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -57,12 +57,23 @@ static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device);
 static void acpi_ac_notify(struct acpi_device *device, u32 event);
 
+struct acpi_ac_bl {
+	const char *hid;
+	int hrv;
+};
+
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, ac_device_ids);
 
+/* Lists of PMIC ACPI HIDs with an (often better) native charger driver */
+static const struct acpi_ac_bl acpi_ac_blacklist[] = {
+	{ "INT33F4", -1 }, /* X-Powers AXP288 PMIC */
+	{ "INT34D3",  3 }, /* Intel Cherrytrail Whiskey Cove PMIC */
+};
+
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev);
 #endif
@@ -424,11 +435,20 @@ static int acpi_ac_remove(struct acpi_device *device)
 
 static int __init acpi_ac_init(void)
 {
+	unsigned int i;
 	int result;
 
 	if (acpi_disabled)
 		return -ENODEV;
 
+	for (i = 0; i < ARRAY_SIZE(acpi_ac_blacklist); i++)
+		if (acpi_dev_present(acpi_ac_blacklist[i].hid, "1",
+				     acpi_ac_blacklist[i].hrv)) {
+			pr_info(PREFIX "AC: found native %s PMIC, not loading\n",
+				acpi_ac_blacklist[i].hid);
+			return -ENODEV;
+		}
+
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
-- 
2.9.3

