From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH 3/3] PM: pm.h - Add comments about Xen
	save/restore/chkpt use case
Date: Sat, 19 Feb 2011 15:12:38 -0800
Message-ID: <1298157158-5421-4-git-send-email-rshriram__33580.0364301123$1298158061$gmane$org@cs.ubc.ca>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

Add documentation to pm.h on how xen uses PM events (freeze,
thaw, restore) to implement Guest VM save/checkpoint/restore
functionality.

Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
---
 include/linux/pm.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index dd9c7ab..2ddd9d3 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -516,6 +516,25 @@ extern void update_pm_runtime_accounting(struct device *dev);
  * well as during system sleep states like PM_SUSPEND_STANDBY.  They may
  * be able to use wakeup events to exit from runtime low-power states,
  * or from system low-power states such as standby or suspend-to-RAM.
+ *
+ * Xen Guest Kernels use PM_FREEZE, PM_RESTORE and PM_THAW to implement
+ * VM save/restore/checkpoint functionality. Save and Restore are somewhat
+ * similar to hibernate functionality. The sequence of events is shown below:
+ *        dpm_suspend_start(PMSG_FREEZE);
+ *
+ *              dpm_suspend_noirq(PMSG_FREEZE);
+ *
+ *                     sysdev_suspend(PMSG_FREEZE);
+ *                     cancelled = suspend_hypercall()
+ *                     sysdev_resume();
+ *
+ *             dpm_resume_noirq(cancelled ? PMSG_THAW : PMSG_RESTORE);
+ *
+ *     dpm_resume_end(cancelled ? PMSG_THAW : PMSG_RESTORE);
+ *
+ * If the syspend_hypercall returns 1, it means that the VM was merely
+ * checkpointed (akin to THAW). If it returns 0, it means the system has been
+ * fully restored from its on-disk snapshot (akin to RESTORE).
  */
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.7.0.4
