From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] thermal: Use freezable workqueue
Date: Tue, 8 Feb 2011 00:29:57 +0100
Message-ID: <201102080029.57195.rjw__8262.54458302191$1297121488$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <len.brown@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

If thermal polling is enabled, which for example is the case for
ACPI thermal zones with the _TZP object defined, the thermal driver
uses delayed work items for this purpose.  Unfortunately, since
they are queued up using schedule_delayed_work(), the work function
may be executed during system suspend or resume, which is not
desirable.

To prevent that from happening, use a freezable workqueue for
queuing up delayed work items in the thermal driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/thermal/thermal_sys.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/thermal/thermal_sys.c
===================================================================
--- linux-2.6.orig/drivers/thermal/thermal_sys.c
+++ linux-2.6/drivers/thermal/thermal_sys.c
@@ -62,6 +62,20 @@ static DEFINE_MUTEX(thermal_list_lock);
 
 static unsigned int thermal_event_seqnum;
 
+static struct workqueue_struct *thermal_wq;
+
+static int __init thermal_start_workqueue(void)
+{
+	thermal_wq = alloc_workqueue("thermal", WQ_FREEZEABLE, 0);
+	return thermal_wq ? 0 : -ENOMEM;
+}
+
+static inline void thermal_destroy_workqueue(void)
+{
+	if (thermal_wq)
+		destroy_workqueue(thermal_wq);
+}
+
 static struct genl_family thermal_event_genl_family = {
 	.id = GENL_ID_GENERATE,
 	.name = THERMAL_GENL_FAMILY_NAME,
@@ -611,10 +625,10 @@ static void thermal_zone_device_set_poll
 		return;
 
 	if (delay > 1000)
-		schedule_delayed_work(&(tz->poll_queue),
+		queue_delayed_work(thermal_wq, &(tz->poll_queue),
 				      round_jiffies(msecs_to_jiffies(delay)));
 	else
-		schedule_delayed_work(&(tz->poll_queue),
+		queue_delayed_work(thermal_wq, &(tz->poll_queue),
 				      msecs_to_jiffies(delay));
 }
 
@@ -1306,11 +1320,14 @@ static int __init thermal_init(void)
 	int result = 0;
 
 	result = class_register(&thermal_class);
+	if (!result)
+		result = thermal_start_workqueue();
 	if (result) {
 		idr_destroy(&thermal_tz_idr);
 		idr_destroy(&thermal_cdev_idr);
 		mutex_destroy(&thermal_idr_lock);
 		mutex_destroy(&thermal_list_lock);
+		thermal_destroy_workqueue();
 	}
 	result = genetlink_init();
 	return result;
@@ -1328,6 +1345,7 @@ static void __exit thermal_exit(void)
 	idr_destroy(&thermal_cdev_idr);
 	mutex_destroy(&thermal_idr_lock);
 	mutex_destroy(&thermal_list_lock);
+	thermal_destroy_workqueue();
 	genetlink_exit();
 }
 
