From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/13] ACPI / PM: Prevent
	acpi_power_get_inferred_state() from making changes
Date: Thu, 25 Nov 2010 00:05:17 +0100
Message-ID: <201011250005.17710.rjw__16291.5449160666$1290640685$gmane$org@sisk.pl>
References: <201011250001.11297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011250001.11297.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

acpi_power_get_inferred_state() should not update
device->power.state behind the back of its caller, so make it return
the state via a pointer instead.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |    3 ++-
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/power.c    |   12 ++++--------
 3 files changed, 7 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -423,19 +423,16 @@ int acpi_disable_wakeup_device_power(str
                              Device Power Management
    -------------------------------------------------------------------------- */
 
-int acpi_power_get_inferred_state(struct acpi_device *device)
+int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
 {
 	int result = 0;
 	struct acpi_handle_list *list = NULL;
 	int list_state = 0;
 	int i = 0;
 
-
-	if (!device)
+	if (!device || !state)
 		return -EINVAL;
 
-	device->power.state = ACPI_STATE_UNKNOWN;
-
 	/*
 	 * We know a device's inferred power state when all the resources
 	 * required for a given D-state are 'on'.
@@ -450,13 +447,12 @@ int acpi_power_get_inferred_state(struct
 			return result;
 
 		if (list_state == ACPI_POWER_RESOURCE_STATE_ON) {
-			device->power.state = i;
+			*state = i;
 			return 0;
 		}
 	}
 
-	device->power.state = ACPI_STATE_D3;
-
+	*state = ACPI_STATE_D3;
 	return 0;
 }
 
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -222,7 +222,8 @@ int acpi_bus_get_power(acpi_handle handl
 		 * indirectly (via power resources).
 		 */
 		if (device->power.flags.power_resources) {
-			result = acpi_power_get_inferred_state(device);
+			result = acpi_power_get_inferred_state(device,
+							&device->power.state);
 			if (result)
 				return result;
 		} else if (device->power.flags.explicit_get) {
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -41,7 +41,7 @@ static inline int acpi_debugfs_init(void
 int acpi_power_init(void);
 int acpi_device_sleep_wake(struct acpi_device *dev,
                            int enable, int sleep_state, int dev_state);
-int acpi_power_get_inferred_state(struct acpi_device *device);
+int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_transition(struct acpi_device *device, int state);
 extern int acpi_power_nocheck;
 
