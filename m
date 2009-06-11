From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 13/19] PM/Hibernate: Move memory shrinking to
	snapshot.c (rev. 2)
Date: Thu, 11 Jun 2009 22:00:56 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB__34094.3870171488$1244757656$gmane$org@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

A future patch is going to modify the memory shrinking code so that
it will make memory allocations to free memory instead of using an
artificial memory shrinking mechanism for that.  For this purpose it
is convenient to move swsusp_shrink_memory() from
kernel/power/swsusp.c to kernel/power/snapshot.c, because the new
memory-shrinking code is going to use things that are local to
kernel/power/snapshot.c .

[rev. 2: Make some functions static and remove their headers from
 kernel/power/power.h]

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Wu Fengguang <fengguang.wu@intel.com>
---
 kernel/power/power.h    |    4 +--
 kernel/power/snapshot.c |   80 +++++++++++++++++++++++++++++++++++++++++++++-
 kernel/power/swsusp.c   |   76 --------------------------------------------
 3 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 46b5ec7..ec4dbdf 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -74,7 +74,7 @@ extern asmlinkage int swsusp_arch_resume(void);
 
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
-extern unsigned int count_data_pages(void);
+extern int swsusp_shrink_memory(void);
 
 /**
  *	Auxiliary structure used for reading the snapshot image data and
@@ -149,7 +149,6 @@ extern int swsusp_swap_in_use(void);
 
 /* kernel/power/disk.c */
 extern int swsusp_check(void);
-extern int swsusp_shrink_memory(void);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
 extern int swsusp_write(unsigned int flags);
@@ -176,7 +175,6 @@ extern int pm_notifier_call_chain(unsigned long val);
 #endif
 
 #ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void);
 int restore_highmem(void);
 #else
 static inline unsigned int count_highmem_pages(void) { return 0; }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 33e2e4a..523a451 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -39,6 +39,14 @@ static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
 static void swsusp_unset_page_forbidden(struct page *);
 
+/*
+ * Preferred image size in bytes (tunable via /sys/power/image_size).
+ * When it is set to N, swsusp will do its best to ensure the image
+ * size will not exceed N bytes, but if that is impossible, it will
+ * try to create the smallest image possible.
+ */
+unsigned long image_size = 500 * 1024 * 1024;
+
 /* List of PBEs needed for restoring the pages that were allocated before
  * the suspend and included in the suspend image, but have also been
  * allocated by the "resume" kernel, so their contents cannot be written
@@ -840,7 +848,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
  *	pages.
  */
 
-unsigned int count_highmem_pages(void)
+static unsigned int count_highmem_pages(void)
 {
 	struct zone *zone;
 	unsigned int n = 0;
@@ -902,7 +910,7 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
  *	pages.
  */
 
-unsigned int count_data_pages(void)
+static unsigned int count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long pfn, max_zone_pfn;
@@ -1058,6 +1066,74 @@ void swsusp_free(void)
 	buffer = NULL;
 }
 
+/**
+ *	swsusp_shrink_memory -  Try to free as much memory as needed
+ *
+ *	... but do not OOM-kill anyone
+ *
+ *	Notice: all userland should be stopped before it is called, or
+ *	livelock is possible.
+ */
+
+#define SHRINK_BITE	10000
+static inline unsigned long __shrink_memory(long tmp)
+{
+	if (tmp > SHRINK_BITE)
+		tmp = SHRINK_BITE;
+	return shrink_all_memory(tmp);
+}
+
+int swsusp_shrink_memory(void)
+{
+	long tmp;
+	struct zone *zone;
+	unsigned long pages = 0;
+	unsigned int i = 0;
+	char *p = "-\\|/";
+	struct timeval start, stop;
+
+	printk(KERN_INFO "PM: Shrinking memory...  ");
+	do_gettimeofday(&start);
+	do {
+		long size, highmem_size;
+
+		highmem_size = count_highmem_pages();
+		size = count_data_pages() + PAGES_FOR_IO + SPARE_PAGES;
+		tmp = size;
+		size += highmem_size;
+		for_each_populated_zone(zone) {
+			tmp += snapshot_additional_pages(zone);
+			if (is_highmem(zone)) {
+				highmem_size -=
+					zone_page_state(zone, NR_FREE_PAGES);
+			} else {
+				tmp -= zone_page_state(zone, NR_FREE_PAGES);
+				tmp += zone->lowmem_reserve[ZONE_NORMAL];
+			}
+		}
+
+		if (highmem_size < 0)
+			highmem_size = 0;
+
+		tmp += highmem_size;
+		if (tmp > 0) {
+			tmp = __shrink_memory(tmp);
+			if (!tmp)
+				return -ENOMEM;
+			pages += tmp;
+		} else if (size > image_size / PAGE_SIZE) {
+			tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
+			pages += tmp;
+		}
+		printk("\b%c", p[i++%4]);
+	} while (tmp > 0);
+	do_gettimeofday(&stop);
+	printk("\bdone (%lu pages freed)\n", pages);
+	swsusp_show_speed(&start, &stop, pages, "Freed");
+
+	return 0;
+}
+
 #ifdef CONFIG_HIGHMEM
 /**
   *	count_pages_for_highmem - compute the number of non-highmem pages
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 78c3504..87b901c 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -55,14 +55,6 @@
 
 #include "power.h"
 
-/*
- * Preferred image size in bytes (tunable via /sys/power/image_size).
- * When it is set to N, swsusp will do its best to ensure the image
- * size will not exceed N bytes, but if that is impossible, it will
- * try to create the smallest image possible.
- */
-unsigned long image_size = 500 * 1024 * 1024;
-
 int in_suspend __nosavedata = 0;
 
 /**
@@ -195,74 +187,6 @@ void swsusp_show_speed(struct timeval *start, struct timeval *stop,
 			kps / 1000, (kps % 1000) / 10);
 }
 
-/**
- *	swsusp_shrink_memory -  Try to free as much memory as needed
- *
- *	... but do not OOM-kill anyone
- *
- *	Notice: all userland should be stopped before it is called, or
- *	livelock is possible.
- */
-
-#define SHRINK_BITE	10000
-static inline unsigned long __shrink_memory(long tmp)
-{
-	if (tmp > SHRINK_BITE)
-		tmp = SHRINK_BITE;
-	return shrink_all_memory(tmp);
-}
-
-int swsusp_shrink_memory(void)
-{
-	long tmp;
-	struct zone *zone;
-	unsigned long pages = 0;
-	unsigned int i = 0;
-	char *p = "-\\|/";
-	struct timeval start, stop;
-
-	printk(KERN_INFO "PM: Shrinking memory...  ");
-	do_gettimeofday(&start);
-	do {
-		long size, highmem_size;
-
-		highmem_size = count_highmem_pages();
-		size = count_data_pages() + PAGES_FOR_IO + SPARE_PAGES;
-		tmp = size;
-		size += highmem_size;
-		for_each_populated_zone(zone) {
-			tmp += snapshot_additional_pages(zone);
-			if (is_highmem(zone)) {
-				highmem_size -=
-					zone_page_state(zone, NR_FREE_PAGES);
-			} else {
-				tmp -= zone_page_state(zone, NR_FREE_PAGES);
-				tmp += zone->lowmem_reserve[ZONE_NORMAL];
-			}
-		}
-
-		if (highmem_size < 0)
-			highmem_size = 0;
-
-		tmp += highmem_size;
-		if (tmp > 0) {
-			tmp = __shrink_memory(tmp);
-			if (!tmp)
-				return -ENOMEM;
-			pages += tmp;
-		} else if (size > image_size / PAGE_SIZE) {
-			tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
-			pages += tmp;
-		}
-		printk("\b%c", p[i++%4]);
-	} while (tmp > 0);
-	do_gettimeofday(&stop);
-	printk("\bdone (%lu pages freed)\n", pages);
-	swsusp_show_speed(&start, &stop, pages, "Freed");
-
-	return 0;
-}
-
 /*
  * Platforms, like ACPI, may want us to save some memory used by them during
  * hibernation and to restore the contents of this memory during the subsequent
-- 
1.5.2.4
