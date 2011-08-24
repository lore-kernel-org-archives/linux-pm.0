From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Runtime: Correct documentation of
	pm_runtime_irq_safe()
Date: Wed, 24 Aug 2011 22:46:41 +0200
Message-ID: <201108242246.41574.rjw__39090.7135363252$1314218795$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The description of pm_runtime_irq_safe() has to be updated to follow
the code after commit 02b2677 (PM / Runtime: Allow _put_sync() from
interrupts-disabled context).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/runtime_pm.txt |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux/Documentation/power/runtime_pm.txt
===================================================================
--- linux.orig/Documentation/power/runtime_pm.txt
+++ linux/Documentation/power/runtime_pm.txt
@@ -431,8 +431,7 @@ drivers/base/power/runtime.c and include
 
   void pm_runtime_irq_safe(struct device *dev);
     - set the power.irq_safe flag for the device, causing the runtime-PM
-      suspend and resume callbacks (but not the idle callback) to be invoked
-      with interrupts disabled
+      callbacks to be invoked with interrupts off
 
   void pm_runtime_mark_last_busy(struct device *dev);
     - set the power.last_busy field to the current time
