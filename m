From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 8/8] PM: Rename hibernation_ops to
	platform_hibernation_operations
Date: Tue, 26 Jun 2007 00:52:27 +0200
Message-ID: <200706260052.28206.rjw__45003.1614200727$1182812250$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706260039.17530.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Rename 'struct hibernation_ops' to 'struct platform_hibernation_operations' in
analogy with 'struct platform_suspend_operations'.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep/main.c |    2 +-
 include/linux/suspend.h   |    9 +++++----
 kernel/power/disk.c       |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6.22-rc6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.22-rc6.orig/drivers/acpi/sleep/main.c	2007-06-25 22:58:53.000000000 +0200
+++ linux-2.6.22-rc6/drivers/acpi/sleep/main.c	2007-06-25 23:08:48.000000000 +0200
@@ -258,7 +258,7 @@ static void acpi_hibernation_restore_cle
 	acpi_hw_enable_all_runtime_gpes();
 }
 
-static struct hibernation_ops acpi_hibernation_ops = {
+static struct platform_hibernation_operations acpi_hibernation_ops = {
 	.start = acpi_hibernation_start,
 	.pre_snapshot = acpi_hibernation_prepare,
 	.finish = acpi_hibernation_finish,
Index: linux-2.6.22-rc6/include/linux/suspend.h
===================================================================
--- linux-2.6.22-rc6.orig/include/linux/suspend.h	2007-06-25 22:58:00.000000000 +0200
+++ linux-2.6.22-rc6/include/linux/suspend.h	2007-06-25 23:07:21.000000000 +0200
@@ -121,7 +121,7 @@ extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
 
 /**
- * struct hibernation_ops - hibernation platform support
+ * struct platform_hibernation_operations - hibernation platform support
  *
  * The methods in this structure allow a platform to override the default
  * mechanism of shutting down the machine during a hibernation transition.
@@ -158,7 +158,7 @@ extern void mark_free_pages(struct zone 
  *	Called right after the nonboot CPUs have been enabled and before
  *	thawing devices (runs with IRQs on).
  */
-struct hibernation_ops {
+struct platform_hibernation_operations {
 	int (*start)(void);
 	int (*pre_snapshot)(void);
 	void (*finish)(void);
@@ -185,14 +185,15 @@ extern void swsusp_set_page_free(struct 
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
 
-extern void hibernation_set_ops(struct hibernation_ops *ops);
+extern void hibernation_set_ops(struct platform_hibernation_operations *ops);
 extern int hibernate(void);
 #else /* CONFIG_SOFTWARE_SUSPEND */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
 static inline void swsusp_unset_page_free(struct page *p) {}
 
-static inline void hibernation_set_ops(struct hibernation_ops *ops) {}
+static inline void
+hibernation_set_ops(struct platform_hibernation_operations *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
 #endif /* CONFIG_SOFTWARE_SUSPEND */
 
Index: linux-2.6.22-rc6/kernel/power/disk.c
===================================================================
--- linux-2.6.22-rc6.orig/kernel/power/disk.c	2007-06-25 22:59:28.000000000 +0200
+++ linux-2.6.22-rc6/kernel/power/disk.c	2007-06-25 23:08:36.000000000 +0200
@@ -45,14 +45,14 @@ enum {
 
 static int hibernation_mode = HIBERNATION_SHUTDOWN;
 
-struct hibernation_ops *hibernation_ops;
+struct platform_hibernation_operations *hibernation_ops;
 
 /**
  * hibernation_set_ops - set the global hibernate operations
  * @ops: the hibernation operations to use in subsequent hibernation transitions
  */
 
-void hibernation_set_ops(struct hibernation_ops *ops)
+void hibernation_set_ops(struct platform_hibernation_operations *ops)
 {
 	if (ops && !(ops->start && ops->pre_snapshot && ops->finish
 	    && ops->prepare && ops->enter && ops->pre_restore
