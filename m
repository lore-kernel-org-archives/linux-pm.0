From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 6/6] PM_EVENT_PRETHAW,
	issue from PM core
Date: Mon, 5 Jun 2006 09:38:49 -0700
Message-ID: <200606050938.49835.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z4FhEQ4d+CCLwQr"
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_Z4FhEQ4d+CCLwQr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This converts the PM core to issue the new PRETHAW message.  The rest of
the kernel is now ready to receive these, courtesy of preceding patches.
---
 kernel/power/disk.c   |    4 ++--
 kernel/power/swsusp.c |    9 ++++++++-
 kernel/power/user.c   |    2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)


--Boundary-00=_Z4FhEQ4d+CCLwQr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="prethaw-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prethaw-core.patch"

This converts the PM core to issue the new PRETHAW message.  The rest of
the kernel is now ready to receive these, courtesy of preceding patches.

---
 kernel/power/disk.c   |    4 ++--
 kernel/power/swsusp.c |    9 ++++++++-
 kernel/power/user.c   |    2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

Index: scratch/kernel/power/swsusp.c
===================================================================
--- scratch.orig/kernel/power/swsusp.c	2006-06-05 09:06:46.000000000 -0700
+++ scratch/kernel/power/swsusp.c	2006-06-05 09:20:01.000000000 -0700
@@ -240,6 +240,9 @@ int swsusp_suspend(void)
 	restore_processor_state();
 Restore_highmem:
 	restore_highmem();
+	/* NOTE:  device_power_up() is just a resume() for devices
+	 * that suspended with irqs off ... no overall powerup.
+	 */
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
@@ -249,8 +252,12 @@ Enable_irqs:
 int swsusp_resume(void)
 {
 	int error;
+
 	local_irq_disable();
-	if (device_power_down(PMSG_FREEZE))
+	/* NOTE:  device_power_down() is just a suspend() with irqs off;
+	 * it has no special "power things down" semantics
+	 */
+	if (device_power_down(PMSG_PRETHAW))
 		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
Index: scratch/kernel/power/user.c
===================================================================
--- scratch.orig/kernel/power/user.c	2006-06-05 09:06:46.000000000 -0700
+++ scratch/kernel/power/user.c	2006-06-05 09:20:01.000000000 -0700
@@ -191,7 +191,7 @@ static int snapshot_ioctl(struct inode *
 		}
 		down(&pm_sem);
 		pm_prepare_console();
-		error = device_suspend(PMSG_FREEZE);
+		error = device_suspend(PMSG_PRETHAW);
 		if (!error) {
 			error = swsusp_resume();
 			device_resume();
Index: scratch/kernel/power/disk.c
===================================================================
--- scratch.orig/kernel/power/disk.c	2006-06-05 09:06:46.000000000 -0700
+++ scratch/kernel/power/disk.c	2006-06-05 09:20:01.000000000 -0700
@@ -98,7 +98,7 @@ static void unprepare_processes(void)
 }
 
 /**
- *	pm_suspend_disk - The granpappy of power management.
+ *	pm_suspend_disk - The granpappy of hibernation power management.
  *
  *	If we're going through the firmware, then get it over with quickly.
  *
@@ -207,7 +207,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Preparing devices for restore.\n");
 
-	if ((error = device_suspend(PMSG_FREEZE))) {
+	if ((error = device_suspend(PMSG_PRETHAW))) {
 		printk("Some devices failed to suspend\n");
 		swsusp_free();
 		goto Thaw;

--Boundary-00=_Z4FhEQ4d+CCLwQr
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_Z4FhEQ4d+CCLwQr--
