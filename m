From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: fix new mutex-locking bug in the PM core
Date: Fri, 29 Feb 2008 11:50:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802291145560.6695-100000@iolanthe.rowland.org>
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
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1041) fixes a bug introduced by the
acquire-all-device-semaphores reversion.  The error pathway of
dpm_suspend() fails to reacquire a mutex it should be holding.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Fri, 29 Feb 2008, Rafael J. Wysocki wrote:

> > Incidentally, there seemed to be a bug in your dpm_suspend() -- the
> > dpm_list_mtx needs to be reacquired before the error checking.
>
> Oh, yes.  Will you please send a fix when
> http://marc.info/?l=linux-acpi&m=120389632114090&w=4 is merged?

Why wait?  We might as well avoid having an unfixed bug present.

Greg & Andrew, this patch should be merged right after with Rafael's
"PM: Do not acquire device semaphores upfront during suspend" patch.  
Ideally it should be combined directly with that patch.

Alan Stern


Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
@@ -423,6 +423,7 @@ static int dpm_suspend(pm_message_t stat
 
 		mutex_unlock(&dpm_list_mtx);
 		error = suspend_device(dev, state);
+		mutex_lock(&dpm_list_mtx);
 		if (error) {
 			printk(KERN_ERR "Could not suspend device %s: "
 					"error %d%s\n",
@@ -433,7 +434,6 @@ static int dpm_suspend(pm_message_t stat
 					""));
 			break;
 		}
-		mutex_lock(&dpm_list_mtx);
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_off);
 	}
