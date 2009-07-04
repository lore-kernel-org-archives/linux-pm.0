From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / irq: Fix comment describing
	suspend_device_irqs()
Date: Sun, 5 Jul 2009 00:22:34 +0200
Message-ID: <200907050022.35117.rjw__5072.56597416035$1246746261$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The kerneldoc comment describing suspend_device_irqs() is currently
misleading, because generally the function doesn't really disable
interrupt lines at the chip level.  Replace it with a more accurate
one.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/irq/pm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/irq/pm.c
===================================================================
--- linux-2.6.orig/kernel/irq/pm.c
+++ linux-2.6/kernel/irq/pm.c
@@ -15,10 +15,10 @@
 /**
  * suspend_device_irqs - disable all currently enabled interrupt lines
  *
- * During system-wide suspend or hibernation device interrupts need to be
- * disabled at the chip level and this function is provided for this purpose.
- * It disables all interrupt lines that are enabled at the moment and sets the
- * IRQ_SUSPENDED flag for them.
+ * During system-wide suspend or hibernation device drivers need to be prevented
+ * from receiving interrupts and this function is provided for this purpose.
+ * It marks all interrupt lines in use, except for the timer ones, as disabled
+ * and sets the IRQ_SUSPENDED flag for each of them.
  */
 void suspend_device_irqs(void)
 {
