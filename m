From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 4/8] serio: Speed-up resume
Date: Thu, 10 Jul 2008 02:01:55 +0200
Message-ID: <200807100201.56232.rjw__41042.9366319024$1215648857$gmane$org@sisk.pl>
References: <200807100152.17755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807100152.17755.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Shaohua Li <shaohua.li@intel.com>
Subject: serio: Speed-up resume

serio_resume will call into psmouse_extensions(). In my test, the
routine is very slow, it blocks resume about 1 sec. Below patch (move
resume to kseriod, just like boot time probe) cures the issue in my
test, and seems no side effect. I'm no familiar with serio driver, so
please check. 

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Acked-by: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/input/serio/serio.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

Index: linux-next/drivers/input/serio/serio.c
===================================================================
--- linux-next.orig/drivers/input/serio/serio.c
+++ linux-next/drivers/input/serio/serio.c
@@ -163,6 +163,7 @@ enum serio_event_type {
 	SERIO_RECONNECT_PORT,
 	SERIO_REGISTER_PORT,
 	SERIO_ATTACH_DRIVER,
+	SERIO_RESUME_PORT,
 };
 
 struct serio_event {
@@ -287,6 +288,13 @@ static struct serio_event *serio_get_eve
 	return event;
 }
 
+#ifdef CONFIG_PM
+static void serio_resume_port(struct device *dev);
+#else
+static inline void serio_resume_port(struct device *dev)
+{
+}
+#endif /* CONFIG_PM */
 static void serio_handle_event(void)
 {
 	struct serio_event *event;
@@ -319,6 +327,10 @@ static void serio_handle_event(void)
 				serio_attach_driver(event->object);
 				break;
 
+			case SERIO_RESUME_PORT:
+				serio_resume_port(event->object);
+				break;
+
 			default:
 				break;
 		}
@@ -925,21 +937,26 @@ static int serio_suspend(struct device *
 	return 0;
 }
 
-static int serio_resume(struct device *dev)
+static void serio_resume_port(struct device *dev)
 {
 	struct serio *serio = to_serio_port(dev);
 
-	if (dev->power.power_state.event != PM_EVENT_ON &&
-	    serio_reconnect_driver(serio)) {
-		/*
-		 * Driver re-probing can take a while, so better let kseriod
-		 * deal with it.
-		 */
-		serio_rescan(serio);
+	if (serio_reconnect_driver(serio)) {
+		serio_disconnect_port(serio);
+		serio_find_driver(serio);
 	}
 
 	dev->power.power_state = PMSG_ON;
+}
 
+static int serio_resume(struct device *dev)
+{
+	/*
+	 * Driver reconnect can take a while, so better let kseriod
+	 * deal with it.
+	 */
+	if (dev->power.power_state.event != PM_EVENT_ON)
+		serio_queue_event(dev, NULL, SERIO_RESUME_PORT);
 	return 0;
 }
 #endif /* CONFIG_PM */
