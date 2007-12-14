From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Thu, 13 Dec 2007 23:31:31 -0800
Message-ID: <20071213233131.733c2438.akpm@linux-foundation.org>
References: <Pine.LNX.4.44L0.0709211536570.5816-100000@iolanthe.rowland.org>
	<20071212234201.a8932915.akpm@linux-foundation.org>
	<200712131758.38116.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712131758.38116.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Dec 2007 17:58:37 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Thursday, 13 of December 2007, Andrew Morton wrote:
> > On Fri, 21 Sep 2007 15:37:40 -0400 (EDT) Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > This patch (as994) reorganizes the way suspend and resume
> > > notifications are sent to drivers.  The major changes are that now the
> > > PM core acquires every device semaphore before calling the methods,
> > > and calls to device_add() during suspends will fail.
> > 
> > Causes my t61p to deadlock during suspend-to-RAM.  Really late - the little
> > moon symbol has started to flash but the LCD is still powered and the
> > cursor still blinks.  Only a poweroff restores control.
> 
> Most probably, one of the drivers or a CPU hotplug notifier unregisters a
> device during suspend (wrong).
> 
> Please boot with no_console_suspend and check if the box survives (with this
> patch applied):
> 
> # echo 8 > /proc/sys/kernel/printk
> # echo processors > /sys/power/pm_test
> # echo mem > /sys/power/state
> 
> If it doesn't, you can try 
> 
> # echo platform > /sys/power/pm_test
> # echo mem > /sys/power/state
> 
> and
> 
> # echo devices > /sys/power/pm_test
> # echo mem > /sys/power/state

hm, that was all fairly helpful.  <looks at the document> <erk, long>

This:

--- a/drivers/base/power/main.c~a
+++ a/drivers/base/power/main.c
@@ -58,13 +58,36 @@ static DECLARE_RWSEM(pm_sleep_rwsem);
 
 int (*platform_enable_wakeup)(struct device *dev, int is_on);
 
+static void __do_down(struct semaphore *s, const char *file, int line)
+{
+	printk("%s:%d\n", file, line);
+	dump_stack();
+	down(s);
+}
+#define do_down(s) __do_down(s, __FILE__, __LINE__)
+
+static void __do_mutex_lock(struct mutex *m, const char *file, int line)
+{
+	printk("%s:%d\n", file, line);
+	dump_stack();
+	mutex_lock(m);
+}
+#define do_mutex_lock(m) __do_mutex_lock(m, __FILE__, __LINE__)
+
+static void __do_down_write(struct rw_semaphore *s, const char *file, int line)
+{
+	printk("%s:%d\n", file, line);
+	dump_stack();
+	down_write(s);
+}
+#define do_down_write(s) __do_down_write(s, __FILE__, __LINE__)
 
 void device_pm_add(struct device *dev)
 {
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
-	mutex_lock(&dpm_list_mtx);
+	do_mutex_lock(&dpm_list_mtx);
 	list_add_tail(&dev->power.entry, &dpm_active);
 	mutex_unlock(&dpm_list_mtx);
 }
@@ -76,8 +99,8 @@ void device_pm_remove(struct device *dev
 		 kobject_name(&dev->kobj));
 
 	/* Don't remove a device while the PM core has it locked for suspend */
-	down(&dev->sem);
-	mutex_lock(&dpm_list_mtx);
+	do_down(&dev->sem);
+	do_mutex_lock(&dpm_list_mtx);
 	dpm_sysfs_remove(dev);
 	list_del_init(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
@@ -229,7 +252,7 @@ static void dpm_resume(void)
  */
 static void unlock_all_devices(void)
 {
-	mutex_lock(&dpm_list_mtx);
+	do_mutex_lock(&dpm_list_mtx);
  	while (!list_empty(&dpm_locked)) {
  		struct list_head *entry = dpm_locked.prev;
  		struct device *dev = to_device(entry);
@@ -412,7 +435,7 @@ static int dpm_suspend(pm_message_t stat
  */
 static void lock_all_devices(void)
 {
-	mutex_lock(&dpm_list_mtx);
+	do_mutex_lock(&dpm_list_mtx);
 	while (!list_empty(&dpm_active)) {
 		struct list_head *entry = dpm_active.next;
 		struct device *dev = to_device(entry);
@@ -422,8 +445,8 @@ static void lock_all_devices(void)
 		 */
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
-		down(&dev->sem);
-		mutex_lock(&dpm_list_mtx);
+		do_down(&dev->sem);
+		do_mutex_lock(&dpm_list_mtx);
 
 		if (list_empty(entry))
 			up(&dev->sem);		/* Device was removed */
@@ -445,7 +468,7 @@ int device_suspend(pm_message_t state)
 	int error;
 
 	might_sleep();
-	down_write(&pm_sleep_rwsem);
+	do_down_write(&pm_sleep_rwsem);
 	lock_all_devices();
 	error = dpm_suspend(state);
 	if (error) {
_

gives me this:

http://userweb.kernel.org/~akpm/pc131699.jpg

which identifies your culprit: msr.

I'd suggest that the above debug patch be turned into some
boot-option-enabled thing and that it be rolled out with this locking
change for a while at least.
