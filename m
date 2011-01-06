From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/11] ACPI / PM: Drop special ACPI wakeup flags
Date: Thu, 6 Jan 2011 23:35:10 +0100
Message-ID: <201101062335.10677.rjw__40521.437142934$1294354227$gmane$org@sisk.pl>
References: <201101062331.17079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101062331.17079.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Drop special ACPI wakeup flags, wakeup.state.enabled and
wakeup.flags.always_enabled, that aren't necessary any more after
we've started to use standard device wakeup flags for handling ACPI
wakeup devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/glue.c     |    5 +----
 include/acpi/acpi_bus.h |    6 ------
 2 files changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6/drivers/acpi/glue.c
===================================================================
--- linux-2.6.orig/drivers/acpi/glue.c
+++ linux-2.6/drivers/acpi/glue.c
@@ -167,11 +167,8 @@ static int acpi_bind_one(struct device *
 				"firmware_node");
 		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				"physical_node");
-		if (acpi_dev->wakeup.flags.valid) {
+		if (acpi_dev->wakeup.flags.valid)
 			device_set_wakeup_capable(dev, true);
-			device_set_wakeup_enable(dev,
-						acpi_dev->wakeup.state.enabled);
-		}
 	}
 
 	return 0;
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -241,20 +241,14 @@ struct acpi_device_perf {
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
 	u8 run_wake:1;		/* Run-Wake GPE devices */
-	u8 always_enabled:1;	/* Run-wake devices that are always enabled */
 	u8 notifier_present:1;  /* Wake-up notify handler has been installed */
 };
 
-struct acpi_device_wakeup_state {
-	u8 enabled:1;
-};
-
 struct acpi_device_wakeup {
 	acpi_handle gpe_device;
 	u64 gpe_number;
 	u64 sleep_state;
 	struct acpi_handle_list resources;
-	struct acpi_device_wakeup_state state;
 	struct acpi_device_wakeup_flags flags;
 	int prepare_count;
 	int run_wake_count;
