From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 05/11] ACPI: Introduce new device wakeup flag
	'prepared'
Date: Mon, 23 Jun 2008 19:45:47 +0200
Message-ID: <200806231945.47937.rjw__38159.3906823129$1214244105$gmane$org@sisk.pl>
References: <200806231934.08565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806231934.08565.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI: Introduce new device wakeup flag 'prepared'

Introduce additional flag 'prepared' in
struct acpi_device_wakeup_flags and use it to prevent devices from
being enable/disabled do wake up the system multiple times in a row
(this does not happen currently, but will be possible after some of
the following patches).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c    |   24 ++++++++++++++++++++++--
 include/acpi/acpi_bus.h |    1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

Index: linux-next/drivers/acpi/power.c
===================================================================
--- linux-next.orig/drivers/acpi/power.c
+++ linux-next/drivers/acpi/power.c
@@ -363,11 +363,18 @@ int acpi_device_sleep_wake(struct acpi_d
  */
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
 {
-	int i;
+	int i, err;
 
 	if (!dev || !dev->wakeup.flags.valid)
 		return -EINVAL;
 
+	/*
+	 * Do not execute the code below twice in a row without calling
+	 * acpi_disable_wakeup_device_power() in between for the same device
+	 */
+	if (dev->wakeup.flags.prepared)
+		return 0;
+
 	/* Open power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
 		int ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
@@ -382,7 +389,11 @@ int acpi_enable_wakeup_device_power(stru
 	 * Passing 3 as the third argument below means the device may be placed
 	 * in arbitrary power state afterwards.
 	 */
-	return acpi_device_sleep_wake(dev, 1, sleep_state, 3);
+	err = acpi_device_sleep_wake(dev, 1, sleep_state, 3);
+	if (!err)
+		dev->wakeup.flags.prepared = 1;
+
+	return err;
 }
 
 /*
@@ -398,6 +409,15 @@ int acpi_disable_wakeup_device_power(str
 	if (!dev || !dev->wakeup.flags.valid)
 		return -EINVAL;
 
+	/*
+	 * Do not execute the code below twice in a row without calling
+	 * acpi_enable_wakeup_device_power() in between for the same device
+	 */
+	if (!dev->wakeup.flags.prepared)
+		return 0;
+
+	dev->wakeup.flags.prepared = 0;
+
 	ret = acpi_device_sleep_wake(dev, 0, 0, 0);
 	if (ret)
 		return ret;
Index: linux-next/include/acpi/acpi_bus.h
===================================================================
--- linux-next.orig/include/acpi/acpi_bus.h
+++ linux-next/include/acpi/acpi_bus.h
@@ -259,6 +259,7 @@ struct acpi_device_perf {
 /* Wakeup Management */
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
+	u8 prepared:1;		/* Has the wake-up capability been enabled? */
 	u8 run_wake:1;		/* Run-Wake GPE devices */
 };
 
