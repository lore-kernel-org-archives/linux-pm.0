From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: don't enable interrupts while running
	in_interrupt
Date: Tue, 25 Jan 2011 13:08:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101251307060.1867-100000@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: tim blechmann <tim@klingt.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1445) fixes a bug in the runtime PM core left over from
the addition of the no_callbacks flag.  If this flag is set then it is
possible for rpm_suspend() to be called in_interrupt, so when
releasing spinlocks it's important not to re-enable interrupts.  

To avoid an unnecessary save-and-restore of the interrupt flag, the
patch also inlines a pm_request_idle() call.

This fixes Bugzilla #27482.

(The offending code was added in 2.6.37, so it's not necessary to apply
this to any earlier stable kernels.)

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: tim blechmann <tim@klingt.org>
CC: <stable@kernel.org>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -407,12 +407,15 @@ static int rpm_suspend(struct device *de
 		goto out;
 	}
 
+	/* Maybe the parent is now able to suspend. */
 	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
-		spin_unlock_irq(&dev->power.lock);
+		spin_unlock(&dev->power.lock);
 
-		pm_request_idle(parent);
+		spin_lock(&parent->power.lock);
+		rpm_idle(parent, RPM_ASYNC);
+		spin_unlock(&parent->power.lock);
 
-		spin_lock_irq(&dev->power.lock);
+		spin_lock(&dev->power.lock);
 	}
 
  out:
