From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] kernel/power/: move function prototypes to
	header
Date: Fri, 2 Nov 2007 16:44:49 +0100
Message-ID: <20071102154449.GR30287@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: pavel@suse.cz, rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch moves the prototypes of count_highmem_pages() and 
restore_highmem() to kernel/power/power.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 kernel/power/power.h    |    8 ++++++++
 kernel/power/snapshot.c |    1 -
 kernel/power/swsusp.c   |    8 --------
 3 files changed, 8 insertions(+), 9 deletions(-)

20af06052a0203d9e60b4937282793900c756182 
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 195dc46..3fe1e7f 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -211,3 +211,11 @@ static inline int pm_notifier_call_chain(unsigned long val)
 	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
 			== NOTIFY_BAD) ? -EINVAL : 0;
 }
+
+#ifdef CONFIG_HIGHMEM
+unsigned int count_highmem_pages(void);
+int restore_highmem(void);
+#else
+static inline unsigned int count_highmem_pages(void) { return 0; }
+static inline int restore_highmem(void) { return 0; }
+#endif
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 78039b4..d9ed1ff 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -872,7 +872,6 @@ unsigned int count_highmem_pages(void)
 }
 #else
 static inline void *saveable_highmem_page(unsigned long pfn) { return NULL; }
-static inline unsigned int count_highmem_pages(void) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
 /**
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index e1722d3..605c536 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -64,14 +64,6 @@ unsigned long image_size = 500 * 1024 * 1024;
 
 int in_suspend __nosavedata = 0;
 
-#ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void);
-int restore_highmem(void);
-#else
-static inline int restore_highmem(void) { return 0; }
-static inline unsigned int count_highmem_pages(void) { return 0; }
-#endif
-
 /**
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
