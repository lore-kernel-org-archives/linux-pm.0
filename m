From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/6] PM/Suspend: Do not shrink memory before
	suspend
Date: Wed, 13 May 2009 10:34:35 +0200
Message-ID: <200905131034.36673.rjw__46866.845773957$1242204784$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905101548.57557.rjw@sisk.pl>
	<200905131032.53624.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905131032.53624.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove the shrinking of memory from the suspend-to-RAM code, where
it is not really necessary.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Acked-by: Wu Fengguang <fengguang.wu@intel.com>
---
 kernel/power/main.c |   20 +-------------------
 mm/vmscan.c         |    4 ++--
 2 files changed, 3 insertions(+), 21 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -188,9 +188,6 @@ static void suspend_test_finish(const ch
 
 #endif
 
-/* This is just an arbitrary number */
-#define FREE_PAGE_NUMBER (100)
-
 static struct platform_suspend_ops *suspend_ops;
 
 /**
@@ -226,7 +223,6 @@ int suspend_valid_only_mem(suspend_state
 static int suspend_prepare(void)
 {
 	int error;
-	unsigned int free_pages;
 
 	if (!suspend_ops || !suspend_ops->enter)
 		return -EPERM;
@@ -241,24 +237,10 @@ static int suspend_prepare(void)
 	if (error)
 		goto Finish;
 
-	if (suspend_freeze_processes()) {
-		error = -EAGAIN;
-		goto Thaw;
-	}
-
-	free_pages = global_page_state(NR_FREE_PAGES);
-	if (free_pages < FREE_PAGE_NUMBER) {
-		pr_debug("PM: free some memory\n");
-		shrink_all_memory(FREE_PAGE_NUMBER - free_pages);
-		if (nr_free_pages() < FREE_PAGE_NUMBER) {
-			error = -ENOMEM;
-			printk(KERN_ERR "PM: No enough memory\n");
-		}
-	}
+	error = suspend_freeze_processes();
 	if (!error)
 		return 0;
 
- Thaw:
 	suspend_thaw_processes();
 	usermodehelper_enable();
  Finish:
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -2054,7 +2054,7 @@ unsigned long global_lru_pages(void)
 		+ global_page_state(NR_INACTIVE_FILE);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_HIBERNATION
 /*
  * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages' pages
  * from LRU lists system-wide, for given pass and priority.
@@ -2194,7 +2194,7 @@ out:
 
 	return sc.nr_reclaimed;
 }
-#endif
+#endif /* CONFIG_HIBERNATION */
 
 /* It's optimal to keep kswapds on the same CPUs as their memory, but
    not required for correctness.  So if the last cpu in a node goes
