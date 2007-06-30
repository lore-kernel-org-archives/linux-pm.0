From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 6/9] PM: Fix compilation of suspend code
	if CONFIG_PM is unset
Date: Sat, 30 Jun 2007 23:08:53 +0200
Message-ID: <200706302308.55223.rjw__40805.7512286634$1183238238$gmane$org@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some platforms, particualrly in the ARM tree, require that suspend_set_ops() and
pm_suspend() be defined even if CONFIG_PM is not set.  Make this requirement be
satisfied.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.22-rc6/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6.orig/include/linux/suspend.h	2007-06-29 22:42:55.000000000 +0200
+++ linux-2.6.22-rc6/include/linux/suspend.h	2007-06-29 22:43:37.000000000 +0200
@@ -79,6 +79,7 @@ struct platform_suspend_ops {
 
 extern struct platform_suspend_ops *suspend_ops;
 
+#ifdef CONFIG_PM
 /**
  * suspend_set_ops - set platform dependent suspend operations
  * @ops: The new suspend operations to set.
@@ -105,6 +106,12 @@ extern void arch_suspend_disable_irqs(vo
 extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
+#else /* CONFIG_PM */
+#define suspend_valid_only_mem	NULL
+
+static inline void suspend_set_ops(struct platform_suspend_ops *ops) {}
+static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+#endif /* CONFIG_PM */
 
 /* struct pbe is used for creating lists of pages that should be restored
  * atomically during the resume from disk, because the page frames they have
