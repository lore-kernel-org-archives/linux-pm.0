From: Paul Parsons <lost.distance@yahoo.com>
Subject: [PATCH] apm-emulation: Fix mutex race condition
Date: Tue, 3 May 2011 01:16:30 +0100 (BST)
Message-ID: <49798.52726.qm@web29017.mail.ird.yahoo.com>
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
List-Id: linux-pm@vger.kernel.org

A process suspending the system (e.g. apm -s) locks apm_mutex at the start of apm_ioctl() and keeps it locked while calling pm_suspend(). A second process trying to ACK the suspend (e.g. apmd) may then block in apm_ioctl() trying to lock the same mutex. The first process tries to freeze processes, but the ACK process cannot be frozen because mutex_lock() is uninterruptible. Consequently pm_suspend() will ultimately fail in try_to_freeze_tasks(). This patch allows the ACK process to be frozen if it is blocked in apm_ioctl().

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
--- clean-2.6.39-rc5/drivers/char/apm-emulation.c	2011-03-15 01:20:32.000000000 +0000
+++ linux-2.6.39-rc5/drivers/char/apm-emulation.c	2011-05-03 00:34:05.467660807 +0100
@@ -275,7 +275,8 @@ apm_ioctl(struct file *filp, u_int cmd, 
 	if (!as->suser || !as->writer)
 		return -EPERM;
 
-	mutex_lock(&apm_mutex);
+	while (mutex_lock_interruptible(&apm_mutex) < 0)
+		try_to_freeze();
 	switch (cmd) {
 	case APM_IOC_SUSPEND:
 		mutex_lock(&state_lock);
