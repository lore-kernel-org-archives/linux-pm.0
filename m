From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] PM: Measure device suspend and resume times
Date: Mon, 21 Dec 2009 22:04:12 +0100
Message-ID: <200912212204.12679.rjw__47247.6384057247$1261430128$gmane$org@sisk.pl>
References: <200912212201.47920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912212201.47920.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Measure and print the time of suspending and resuming all devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -372,6 +372,23 @@ static void pm_dev_err(struct device *de
 		kobject_name(&dev->kobj), pm_verb(state.event), info, error);
 }
 
+static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
+{
+	ktime_t calltime;
+	s64 usecs64;
+	int usecs;
+
+	calltime = ktime_get();
+	usecs64 = ktime_to_ns(ktime_sub(calltime, starttime));
+	do_div(usecs64, NSEC_PER_USEC);
+	usecs = usecs64;
+	if (usecs == 0)
+		usecs = 1;
+	pr_info("PM: %s%s%s of devices complete after %ld.%03ld msecs\n",
+		info ?: "", info ? " " : "", pm_verb(state.event),
+		usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
+}
+
 /*------------------------- Resume routines -------------------------*/
 
 /**
@@ -408,6 +425,7 @@ static int device_resume_noirq(struct de
 void dpm_resume_noirq(pm_message_t state)
 {
 	struct device *dev;
+	ktime_t starttime = ktime_get();
 
 	mutex_lock(&dpm_list_mtx);
 	transition_started = false;
@@ -421,6 +439,7 @@ void dpm_resume_noirq(pm_message_t state
 				pm_dev_err(dev, state, " early", error);
 		}
 	mutex_unlock(&dpm_list_mtx);
+	dpm_show_time(starttime, state, "early");
 	resume_device_irqs();
 }
 EXPORT_SYMBOL_GPL(dpm_resume_noirq);
@@ -506,6 +525,7 @@ static int device_resume(struct device *
 static void dpm_resume(pm_message_t state)
 {
 	struct list_head list;
+	ktime_t starttime = ktime_get();
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
@@ -534,6 +554,7 @@ static void dpm_resume(pm_message_t stat
 	}
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+	dpm_show_time(starttime, state, NULL);
 }
 
 /**
@@ -666,6 +687,7 @@ static int device_suspend_noirq(struct d
 int dpm_suspend_noirq(pm_message_t state)
 {
 	struct device *dev;
+	ktime_t starttime = ktime_get();
 	int error = 0;
 
 	suspend_device_irqs();
@@ -681,6 +703,8 @@ int dpm_suspend_noirq(pm_message_t state
 	mutex_unlock(&dpm_list_mtx);
 	if (error)
 		dpm_resume_noirq(resume_event(state));
+	else
+		dpm_show_time(starttime, state, "late");
 	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_noirq);
@@ -760,6 +784,7 @@ static int device_suspend(struct device 
 static int dpm_suspend(pm_message_t state)
 {
 	struct list_head list;
+	ktime_t starttime = ktime_get();
 	int error = 0;
 
 	INIT_LIST_HEAD(&list);
@@ -785,6 +810,8 @@ static int dpm_suspend(pm_message_t stat
 	}
 	list_splice(&list, dpm_list.prev);
 	mutex_unlock(&dpm_list_mtx);
+	if (!error)
+		dpm_show_time(starttime, state, NULL);
 	return error;
 }
 
