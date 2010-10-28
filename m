From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 1/3] ACPI / PM: Register
	acpi_power_driver early
Date: Thu, 28 Oct 2010 15:09:12 +0200
Message-ID: <201010281509.12271.rjw__45418.4526614428$1288273334$gmane$org@sisk.pl>
References: <201010281507.34994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010281507.34994.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI device driver used for handling power resources,
acpi_power_driver, creates a struct acpi_power_resource object for
each ACPI device representing a power resource.  These objects are
then used when setting and reading the power states of devices using
the corresponding power resources.  Unfortunately, acpi_power_driver
is registered after acpi_scan_init() that may add devices using the
power resources before acpi_power_driver has a chance to create
struct acpi_power_resource objects for them (specifically, the power
resources may be referred to during the scanning process through
acpi_bus_get_power() before they have been initialized).

As the first step towards fixing this issue, move the registration
of acpi_power_driver into acpi_scan_init() so that power resource
devices can be initialized by it as soon as they have been found in
the namespace.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c  |    1 -
 drivers/acpi/scan.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -1025,7 +1025,6 @@ static int __init acpi_init(void)
 
 	acpi_scan_init();
 	acpi_ec_init();
-	acpi_power_init();
 	acpi_sysfs_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -1543,6 +1543,8 @@ int __init acpi_scan_init(void)
 		printk(KERN_ERR PREFIX "Could not register bus type\n");
 	}
 
+	acpi_power_init();
+
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
