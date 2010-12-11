From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 2/3] ACPI / PM: Drop acpi_bus_get_power()
Date: Sat, 11 Dec 2010 23:44:39 +0100
Message-ID: <201012112344.39592.rjw__377.480095676397$1292107655$gmane$org@sisk.pl>
References: <201012112339.53105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012112339.53105.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

There are no more users of acpi_bus_get_power(), so it can be
dropped.  Moreover, it should be dropped, because it modifies
the device->power.state field of an ACPI device without updating
the reference counters of the device's power resources, which is
wrong.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |   19 -------------------
 include/acpi/acpi_bus.h |    1 -
 2 files changed, 20 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -236,25 +236,6 @@ static int __acpi_bus_get_power(struct a
 }
 
 
-int acpi_bus_get_power(acpi_handle handle, int *state)
-{
-	struct acpi_device *device;
-	int result;
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
-
-	result = __acpi_bus_get_power(device, state);
-	if (result)
-		return result;
-
-	device->power.state = *state;
-	return 0;
-}
-EXPORT_SYMBOL(acpi_bus_get_power);
-
-
 static int __acpi_bus_set_power(struct acpi_device *device, int state)
 {
 	int result = 0;
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -327,7 +327,6 @@ void acpi_bus_data_handler(acpi_handle h
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 				       unsigned long long *sta);
 int acpi_bus_get_status(struct acpi_device *device);
-int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
