From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 23:42:01 +0100
Message-ID: <201101212342.01646.rjw__44435.775691136$1295649899$gmane$org@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<alpine.LFD.2.02.1101211701330.3924@x980>
	<AANLkTi=cbNWQ4eFiZQxE6BrJrhbj+w1MjDGdSmG8oUPv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=cbNWQ4eFiZQxE6BrJrhbj+w1MjDGdSmG8oUPv@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Friday, January 21, 2011, Linus Torvalds wrote:
> On Fri, Jan 21, 2011 at 2:25 PM, Len Brown <lenb@kernel.org> wrote:
> >
> > I don't know if fixing that symptom will fix the suspend
> > problem, but it can't hurt.
> 
> Any particular patch/hack you had in mind for me to test? I'm leaving
> for LCA tomorrow, I'll happily test anything. Once I'm on the road,
> I'll still have access to that thing, but it's pitifully slow and will
> be the only computer I have available, so I won't be doing lots of
> random testng.

Something like this, perhaps.  It doesn't blow up my Toshiba test box, so
hopefully it won't blow up yours ...

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
 
