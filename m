From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] PM: Measure device suspend and resume times
Date: Sun, 13 Dec 2009 23:40:13 +0100
Message-ID: <200912132340.13764.rjw__37810.2748575204$1260744472$gmane$org@sisk.pl>
References: <200912132338.30921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912132338.30921.rjw@sisk.pl>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Measure and print the time of suspending and resuming all devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -383,6 +383,19 @@ static void pm_dev_err(struct device *de
 		kobject_name(&dev->kobj), pm_verb(state.event), info, error);
 }
 
+static void dpm_show_time(ktime_t starttime, pm_message_t state, char *info)
+{
+	ktime_t calltime, delta;
+	unsigned long long usecs;
+
+	calltime = ktime_get();
+	delta = ktime_sub(calltime, starttime);
+	usecs = (unsigned long long)ktime_to_ns(delta) >> 10;
+	pr_info("PM: %s%s%s of devices complete after %Lu.%03Lu msecs\n",
+		info ?: "", info ? " " : "", pm_verb(state.event),
+		usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
+}
+
 /*------------------------- Resume routines -------------------------*/
 
 /**
@@ -419,6 +432,7 @@ static int device_resume_noirq(struct de
 void dpm_resume_noirq(pm_message_t state)
 {
 	struct device *dev;
+	ktime_t starttime = ktime_get();
 
 	mutex_lock(&dpm_list_mtx);
 	transition_started = false;
@@ -432,6 +446,7 @@ void dpm_resume_noirq(pm_message_t state
 				pm_dev_err(dev, state, " early", error);
 		}
 	mutex_unlock(&dpm_list_mtx);
+	dpm_show_time(starttime, state, "early");
 	resume_device_irqs();
 }
 EXPORT_SYMBOL_GPL(dpm_resume_noirq);
@@ -524,6 +539,7 @@ static int device_resume(struct device *
 static void dpm_resume(pm_message_t state)
 {
 	struct list_head list;
+	ktime_t starttime = ktime_get();
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
@@ -554,6 +570,7 @@ static void dpm_resume(pm_message_t stat
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
+	dpm_show_time(starttime, state, NULL);
 }
 
 /**
@@ -686,6 +703,7 @@ static int device_suspend_noirq(struct d
 int dpm_suspend_noirq(pm_message_t state)
 {
 	struct device *dev;
+	ktime_t starttime = ktime_get();
 	int error = 0;
 
 	suspend_device_irqs();
@@ -701,6 +719,8 @@ int dpm_suspend_noirq(pm_message_t state
 	mutex_unlock(&dpm_list_mtx);
 	if (error)
 		dpm_resume_noirq(resume_event(state));
+	else
+		dpm_show_time(starttime, state, "late");
 	return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_noirq);
@@ -800,6 +820,7 @@ static int device_suspend(struct device 
 static int dpm_suspend(pm_message_t state)
 {
 	struct list_head list;
+	ktime_t starttime = ktime_get();
 	int error = 0;
 
 	INIT_LIST_HEAD(&list);
@@ -831,6 +852,8 @@ static int dpm_suspend(pm_message_t stat
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
+	if (!error)
+		dpm_show_time(starttime, state, NULL);
 	return error;
 }
 
