From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/4] ACPI: battery: Fix acpi_battery_exit on acpi_battery_init_async errors
Date: Fri,  7 Apr 2017 12:43:43 +0200
Message-ID: <20170407104345.27042-2-hdegoede@redhat.com>
References: <20170407104345.27042-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbdDGKnv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 06:43:51 -0400
In-Reply-To: <20170407104345.27042-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

The acpi_lock_battery_dir() / acpi_bus_register_driver() calls in
acpi_battery_init_async() may fail. Check that they succeeded before
undoing them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/battery.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4ef1e46..b35fca4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -67,6 +67,7 @@ MODULE_DESCRIPTION("ACPI Battery Driver");
 MODULE_LICENSE("GPL");
 
 static async_cookie_t async_cookie;
+static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static unsigned int cache_time = 1000;
@@ -1329,6 +1330,7 @@ static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 	if (result < 0)
 		acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
+	battery_driver_registered = (result == 0);
 }
 
 static int __init acpi_battery_init(void)
@@ -1343,9 +1345,11 @@ static int __init acpi_battery_init(void)
 static void __exit acpi_battery_exit(void)
 {
 	async_synchronize_cookie(async_cookie + 1);
-	acpi_bus_unregister_driver(&acpi_battery_driver);
+	if (battery_driver_registered)
+		acpi_bus_unregister_driver(&acpi_battery_driver);
 #ifdef CONFIG_ACPI_PROCFS_POWER
-	acpi_unlock_battery_dir(acpi_battery_dir);
+	if (acpi_battery_dir)
+		acpi_unlock_battery_dir(acpi_battery_dir);
 #endif
 }
 
-- 
2.9.3
