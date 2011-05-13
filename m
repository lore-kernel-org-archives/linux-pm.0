From: Paul Parsons <lost.distance@yahoo.com>
Subject: [PATCH RFC] apm-emulation: apm_mutex breaks ACK;
	remove it
Date: Fri, 13 May 2011 02:46:03 +0100 (BST)
Message-ID: <500147.35778.qm@web29013.mail.ird.yahoo.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: jkosina@suse.cz
List-Id: linux-pm@vger.kernel.org

apm_mutex is locked by a process (e.g. apm -s) at the start of apm_ioctl() and remains locked while pm_suspend() is called. Any subsequent process trying to ACK the suspend (e.g. apmd) is then blocked at the start of apm_ioctl(), causing the suspend to be delayed for 5 seconds in apm_suspend_notifier() while the ACK times out. In short, ACKs don't work.

The driver's data structures are sufficiently protected by assorted locks. And pm_suspend() has its own mutex to prevent reentrancy. Consequently there is no obvious requirement for apm_mutex, which evolved from earlier BKL calls. So let's remove it.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
This patch supersedes my previous "apm-emulation: Fix mutex race condition" patch; this patch fixes that earlier bug too.
--- clean-2.6.39-rc7/drivers/char/apm-emulation.c	2011-03-15 01:20:32.000000000 +0000
+++ linux-2.6.39-rc7/drivers/char/apm-emulation.c	2011-05-13 01:40:02.068822695 +0100
@@ -126,7 +126,6 @@ struct apm_user {
 /*
  * Local variables
  */
-static DEFINE_MUTEX(apm_mutex);
 static atomic_t suspend_acks_pending = ATOMIC_INIT(0);
 static atomic_t userspace_notification_inhibit = ATOMIC_INIT(0);
 static int apm_disabled;
@@ -275,7 +274,6 @@ apm_ioctl(struct file *filp, u_int cmd,
 	if (!as->suser || !as->writer)
 		return -EPERM;
 
-	mutex_lock(&apm_mutex);
 	switch (cmd) {
 	case APM_IOC_SUSPEND:
 		mutex_lock(&state_lock);
@@ -336,7 +334,6 @@ apm_ioctl(struct file *filp, u_int cmd,
 		mutex_unlock(&state_lock);
 		break;
 	}
-	mutex_unlock(&apm_mutex);
 
 	return err;
 }
@@ -371,7 +368,6 @@ static int apm_open(struct inode * inode
 {
 	struct apm_user *as;
 
-	mutex_lock(&apm_mutex);
 	as = kzalloc(sizeof(*as), GFP_KERNEL);
 	if (as) {
 		/*
@@ -391,7 +387,6 @@ static int apm_open(struct inode * inode
 
 		filp->private_data = as;
 	}
-	mutex_unlock(&apm_mutex);
 
 	return as ? 0 : -ENOMEM;
 }
