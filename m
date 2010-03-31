From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Wed, 31 Mar 2010 16:41:32 +0200
Message-ID: <4BB35F1C.4030100@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003300009.18315.rjw@sisk.pl> <4BB1BD70.90105@gmail.com>
	<201003302250.26105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090309040302040602010208"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003302250.26105.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309040302040602010208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 03/30/2010 10:50 PM, Rafael J. Wysocki wrote:
> So, I definitely would like to see numbers.

With the patch attached, I get similar results for
uncompressed image -> user.c -> s2disk (compress+threads)
compressed image -> user.c -> s2disk (none of compress+threads)

BUT note that there are differences in pages _copied_ in the "user.c ->
s2disk" phase. Compression was about 40 %. So in the former case 100000
pages went through and in the latter one only ~ 38000. So presumably
there will be savings if the pages are compressed in the kernel in the
save-image phase instead of in userspace.

I'll test (after I hack that up) also the case of image compression when
saving the image and let you know.

It was tested on a machine with openSUSE factory with init 5 with KDE 4.
The memory consumption was ~ 400M (100000 pages) after boot every time.
Hibernation lasted 12-13s in both cases.

-- 
js

--------------090309040302040602010208
Content-Type: text/x-patch;
 name="image_compress.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="image_compress.patch"

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 1ceea79..1bb7dc0 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -26,6 +26,7 @@
 #include <linux/console.h>
 #include <linux/highmem.h>
 #include <linux/list.h>
+#include <linux/lzo.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -35,6 +36,10 @@
 
 #include "power.h"
 
+static void *lzo_buf;
+static void *page_buf;
+struct timeval hib_start_time;
+
 struct memory_bitmap;
 
 static int swsusp_page_is_free(struct page *);
@@ -933,15 +938,76 @@ static unsigned int count_data_pages(void)
 	return n;
 }
 
+static void cccopy(struct memory_bitmap *copy_bm, const char *buffer, int buffer_size)
+{
+	static unsigned long dst_page_pos;
+	static char *dst_page;
+	int bytes_left = buffer_size;
+
+	if (!dst_page)
+		dst_page = phys_to_virt(PFN_PHYS(memory_bm_next_pfn(copy_bm)));
+
+	while (bytes_left) {
+		const char *from = buffer + buffer_size - bytes_left;
+		char *to = dst_page + dst_page_pos;
+		int capacity = PAGE_SIZE - dst_page_pos;
+		int n;
+
+//		printk("%s: to=%p from=%p\n", __func__, to, from);
+		if (bytes_left <= capacity) {
+			for (n = 0; n < bytes_left; n++)
+				to[n] = from[n];
+			dst_page_pos += bytes_left;
+			return;
+		}
+
+		/* Complete this page and start a new one */
+		for (n = 0; n < capacity; n++)
+			to[n] = from[n];
+		bytes_left -= capacity;
+
+		dst_page = phys_to_virt(PFN_PHYS(memory_bm_next_pfn(copy_bm)));
+
+		dst_page_pos = 0;
+	}
+}
+
+#define COMPRESS_IMAGE 0
+
 /* This is needed, because copy_page and memcpy are not usable for copying
  * task structs.
  */
-static inline void do_copy_page(long *dst, long *src)
+static unsigned long do_copy_page(struct memory_bitmap *copy_bm,
+		const unsigned char *src)
 {
-	int n;
+//	static int first = true;
+#if COMPRESS_IMAGE
+	size_t dst_len;
+	int ret;
 
-	for (n = PAGE_SIZE / sizeof(long); n; n--)
-		*dst++ = *src++;
+//	printk("%s: %p\n", __func__, page_buf);
+	ret = lzo1x_1_compress(src, PAGE_SIZE, page_buf, &dst_len, lzo_buf);
+	if (ret < 0) {
+		printk(KERN_EMERG "%s: compress failed: ret=%d dst_len=%zu\n",
+				__func__, ret, dst_len);
+		BUG();
+	}
+
+	cccopy(copy_bm, (char *)&dst_len, sizeof(dst_len));
+	cccopy(copy_bm, page_buf, dst_len);
+
+	return sizeof(dst_len) + dst_len;
+#else
+	cccopy(copy_bm, src, PAGE_SIZE);
+	return PAGE_SIZE;
+#endif
+
+/*	if (first) {
+		print_hex_dump_bytes("O:", DUMP_PREFIX_OFFSET, src, PAGE_SIZE);
+		printk(KERN_DEBUG "len=%zu\n", dst_len);
+		print_hex_dump_bytes("N:", DUMP_PREFIX_OFFSET, dst, dst_len);
+		first = false;
+	}*/
 }
 
 
@@ -951,6 +1017,7 @@ static inline void do_copy_page(long *dst, long *src)
  *		CONFIG_DEBUG_PAGEALLOC is not set and in that case
  *		kernel_page_present() always returns 'true').
  */
+#if 0
 static void safe_copy_page(void *dst, struct page *s_page)
 {
 	if (kernel_page_present(s_page)) {
@@ -962,7 +1029,6 @@ static void safe_copy_page(void *dst, struct page *s_page)
 	}
 }
 
-
 #ifdef CONFIG_HIGHMEM
 static inline struct page *
 page_is_saveable(struct zone *zone, unsigned long pfn)
@@ -999,7 +1065,6 @@ static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 	}
 }
 #else
-#define page_is_saveable(zone, pfn)	saveable_page(zone, pfn)
 
 static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
@@ -1007,12 +1072,14 @@ static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 				pfn_to_page(src_pfn));
 }
 #endif /* CONFIG_HIGHMEM */
+#endif
+#define page_is_saveable(zone, pfn)	saveable_page(zone, pfn)
 
-static void
+static unsigned long
 copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 {
 	struct zone *zone;
-	unsigned long pfn;
+	unsigned long pfn, copied;
 
 	for_each_populated_zone(zone) {
 		unsigned long max_zone_pfn;
@@ -1025,12 +1092,15 @@ copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
 	}
 	memory_bm_position_reset(orig_bm);
 	memory_bm_position_reset(copy_bm);
+	copied = 0;
 	for(;;) {
 		pfn = memory_bm_next_pfn(orig_bm);
 		if (unlikely(pfn == BM_END_OF_MAP))
 			break;
-		copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
+		copied += do_copy_page(copy_bm, page_address(pfn_to_page(pfn)));
+//		copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
 	}
+	return copied;
 }
 
 /* Total number of image pages */
@@ -1265,8 +1335,19 @@ int hibernate_preallocate_memory(void)
 	struct timeval start, stop;
 	int error;
 
+	if (!lzo_buf)
+		lzo_buf = vmalloc(LZO1X_MEM_COMPRESS);
+
+	if (!page_buf)
+		page_buf = (void *)__get_free_pages(GFP_KERNEL,
+				get_order(lzo1x_worst_compress(PAGE_SIZE)));
+
+	BUG_ON(!lzo_buf);
+	BUG_ON(!page_buf);
+
 	printk(KERN_INFO "PM: Preallocating image memory... ");
 	do_gettimeofday(&start);
+	hib_start_time = start;
 
 	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
 	if (error)
@@ -1525,7 +1606,7 @@ asmlinkage int swsusp_save(void)
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
-	copy_data_pages(&copy_bm, &orig_bm);
+	nr_copy_pages = DIV_ROUND_UP(copy_data_pages(&copy_bm, &orig_bm), PAGE_SIZE);
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -1534,11 +1615,11 @@ asmlinkage int swsusp_save(void)
 	 */
 
 	nr_pages += nr_highmem;
-	nr_copy_pages = nr_pages;
+//	nr_copy_pages = nr_pages;
 	nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
 
-	printk(KERN_INFO "PM: Hibernation image created (%d pages copied)\n",
-		nr_pages);
+	printk(KERN_INFO "PM: Hibernation image created (%d of %d pages copied)\n",
+		nr_copy_pages, nr_pages);
 
 	return 0;
 }
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 92688ce..0f2d6c2 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -541,6 +541,12 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_POWER_OFF:
+		{
+		extern struct timeval hib_start_time;
+		struct timeval stop;
+		do_gettimeofday(&stop);
+		swsusp_show_speed(&hib_start_time, &stop, 0, "Overall");
+		}
 		if (data->platform_support)
 			error = hibernation_platform_enter();
 		break;

--------------090309040302040602010208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090309040302040602010208--
