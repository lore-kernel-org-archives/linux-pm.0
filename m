From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/6] ACPI / EC: Drop suspend and resume routines
Date: Fri, 25 Jun 2010 01:20:38 +0200
Message-ID: <201006250120.38554.rjw__37196.3441408754$1277422214$gmane$org@sisk.pl>
References: <201006250117.45148.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006250117.45148.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: len.brown@intel.com, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The suspend and resume routines provided by the EC driver are not
really necessary, because the handler of the GPE disabled by them
is not going to be executed after suspend_device_irqs() and before
resume_device_irqs() anyway.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/ec.c |   18 ------------------
 1 file changed, 18 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -1088,22 +1088,6 @@ error:
 	return -ENODEV;
 }
 
-static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
-{
-	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Stop using the GPE, but keep it reference counted. */
-	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
-	return 0;
-}
-
-static int acpi_ec_resume(struct acpi_device *device)
-{
-	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Enable the GPE again, but don't reference count it once more. */
-	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
-	return 0;
-}
-
 static struct acpi_driver acpi_ec_driver = {
 	.name = "ec",
 	.class = ACPI_EC_CLASS,
@@ -1111,8 +1095,6 @@ static struct acpi_driver acpi_ec_driver
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
-		.suspend = acpi_ec_suspend,
-		.resume = acpi_ec_resume,
 		},
 };
 
