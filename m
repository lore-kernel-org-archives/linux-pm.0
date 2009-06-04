From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/38] device irq power management
Date: Thu, 04 Jun 2009 18:18:51 +0200
Message-ID: <20090604161900.426173095__44437.6835985624$1244139068$gmane$org@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=pm_genirq_buildfix.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

On architectures without GENERIC_HARDIRQS there are no device irqs
to suspend or resume. Add an #ifdef to replace suspend_device_irqs()
and resume_device_irqs() with an empty inline function in that case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/linux/interrupt.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/interrupt.h
===================================================================
--- linux-2.6.orig/include/linux/interrupt.h
+++ linux-2.6/include/linux/interrupt.h
@@ -183,9 +183,15 @@ extern void disable_irq(unsigned int irq
 extern void enable_irq(unsigned int irq);
 
 /* The following three functions are for the core kernel use only. */
+#ifdef CONFIG_GENERIC_HARDIRQS
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
-#ifdef CONFIG_PM_SLEEP
+#else
+static inline void suspend_device_irqs(void) { }
+static inline void resume_device_irqs(void) { }
+#endif
+
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_GENERIC_HARDIRQS)
 extern int check_wakeup_irqs(void);
 #else
 static inline int check_wakeup_irqs(void) { return 0; }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
