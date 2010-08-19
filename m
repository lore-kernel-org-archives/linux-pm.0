From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Thu, 19 Aug 2010 19:49:35 +1000
Message-ID: <1282211375.17635.96.camel@shrek.rexursive.com>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<201008190102.04474.rjw@sisk.pl>
	<1282174881.17635.93.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1282174881.17635.93.camel@shrek.rexursive.com>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-08-19 at 09:41 +1000, Bojan Smojver wrote:
> OK, I'll prepare a patch that has compression/decompression as
> optional, using kernel command line switch.

Not tested, but here it is, so that you can tell me if this is roughly
what you had in mind. I still have to see about Kconfig selects. Will
get back to you on this.

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index 9d60ab7..986dcf5 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -66,7 +66,8 @@ swsusp saves the state of the machine into active swaps and then reboots or
 powerdowns.  You must explicitly specify the swap partition to resume from with
 ``resume='' kernel option. If signature is found it loads and restores saved
 state. If the option ``noresume'' is specified as a boot parameter, it skips
-the resuming.
+the resuming. If the option ``nocompress'' is specified as a boot parameter, it
+saves hibernation image without compression.
 
 In the meantime while the system is suspended you should not add/remove any
 of the hardware, write to the filesystems, etc.
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ca6066a..cb57eb9 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -137,6 +137,8 @@ config SUSPEND_FREEZER
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
 	select SUSPEND_NVS if HAS_IOMEM
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index aa9e916..fabf905 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -29,6 +29,7 @@
 #include "power.h"
 
 
+static int nocompress = 0;
 static int noresume = 0;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
@@ -630,6 +631,8 @@ int hibernate(void)
 
 		if (hibernation_mode == HIBERNATION_PLATFORM)
 			flags |= SF_PLATFORM_MODE;
+		if (nocompress)
+			flags |= SF_NOCOMPRESS_MODE;
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
@@ -996,12 +999,19 @@ static int __init resume_offset_setup(char *str)
 	return 1;
 }
 
+static int __init nocompress_setup(char *str)
+{
+	nocompress = 1;
+	return 1;
+}
+
 static int __init noresume_setup(char *str)
 {
 	noresume = 1;
 	return 1;
 }
 
+__setup("nocompress", nocompress_setup);
 __setup("noresume", noresume_setup);
 __setup("resume_offset=", resume_offset_setup);
 __setup("resume=", resume_setup);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 006270f..c7e42e4 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -134,6 +134,7 @@ extern int swsusp_swap_in_use(void);
  * the image header.
  */
 #define SF_PLATFORM_MODE	1
+#define SF_NOCOMPRESS_MODE	2
 
 /* kernel/power/hibernate.c */
 extern int swsusp_check(void);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index b0bb217..1fe089b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -24,6 +24,7 @@
 #include <linux/swapops.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/lzo.h>
 
 #include "power.h"
 
@@ -357,6 +358,18 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 	return error;
 }
 
+/* We need to remember how much compressed data we need to read. */
+#define LZO_HEADER	sizeof(size_t)
+
+/* Number of pages/bytes we'll compress at one time. */
+#define LZO_UNC_PAGES	32
+#define LZO_UNC_SIZE	(LZO_UNC_PAGES * PAGE_SIZE)
+
+/* Number of pages/bytes we need for compressed data (worst case). */
+#define LZO_CMP_PAGES	DIV_ROUND_UP(lzo1x_worst_compress(LZO_UNC_SIZE) + \
+			             LZO_HEADER, PAGE_SIZE)
+#define LZO_CMP_SIZE	(LZO_CMP_PAGES * PAGE_SIZE)
+
 /**
  *	save_image - save the suspend image data
  */
@@ -404,6 +417,133 @@ static int save_image(struct swap_map_handle *handle,
 	return ret;
 }
 
+
+/**
+ *	save_image_cmp - save the suspend image data, compress
+ */
+
+static int save_image_cmp(struct swap_map_handle *handle,
+                          struct snapshot_handle *snapshot,
+                          unsigned int nr_to_write)
+{
+	unsigned int m;
+	int ret;
+	int nr_pages;
+	int err2;
+	struct bio *bio;
+	struct timeval start;
+	struct timeval stop;
+	size_t off, unc_len, cmp_len;
+	unsigned char *unc, *cmp, *wrk, *page;
+
+	page = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
+	if (!page) {
+		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
+		return -ENOMEM;
+	}
+
+	wrk = vmalloc(LZO1X_1_MEM_COMPRESS);
+	if (!wrk) {
+		printk(KERN_ERR "PM: Failed to allocate LZO workspace\n");
+		free_page((unsigned long)page);
+		return -ENOMEM;
+	}
+
+	unc = vmalloc(LZO_UNC_SIZE);
+	if (!unc) {
+		printk(KERN_ERR "PM: Failed to allocate LZO uncompressed\n");
+		vfree(wrk);
+		free_page((unsigned long)page);
+		return -ENOMEM;
+	}
+
+	cmp = vmalloc(LZO_CMP_SIZE);
+	if (!cmp) {
+		printk(KERN_ERR "PM: Failed to allocate LZO compressed\n");
+		vfree(unc);
+		vfree(wrk);
+		free_page((unsigned long)page);
+		return -ENOMEM;
+	}
+
+	printk(KERN_INFO "PM: Saving image data pages (%u pages) ...     ",
+		nr_to_write);
+	m = nr_to_write / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	bio = NULL;
+	do_gettimeofday(&start);
+	while (1) {
+		for (off = 0; off < LZO_UNC_SIZE; off += PAGE_SIZE) {
+			ret = snapshot_read_next(snapshot);
+			if (ret < 0)
+				goto out_finish;
+
+			if (!ret)
+				break;
+
+			memcpy(unc + off, data_of(*snapshot), PAGE_SIZE);
+
+			if (!(nr_pages % m))
+				printk(KERN_CONT "\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+
+		if (!off)
+			break;
+
+		unc_len = off;
+		ret = lzo1x_1_compress(unc, unc_len,
+		                       cmp + LZO_HEADER, &cmp_len, wrk);
+		if (ret < 0) {
+			printk(KERN_ERR "PM: LZO compression failed\n");
+			break;
+		}
+
+		if (unlikely(!cmp_len ||
+		             cmp_len > lzo1x_worst_compress(unc_len))) {
+			printk(KERN_ERR "PM: Invalid LZO compressed length\n");
+			ret = -1;
+			break;
+		}
+
+		*(size_t *)cmp = cmp_len;
+
+		/* Given we are writing one page at a time to disk, we copy
+		 * that much from the buffer, although the last bit will likely
+		 * be smaller than full page. This is OK - we saved the length
+		 * of the compressed data, so any garbage at the end will be
+		 * discarded when we read it.
+		 */
+		for (off = 0; off < LZO_HEADER + cmp_len; off += PAGE_SIZE) {
+			memcpy(page, cmp + off, PAGE_SIZE);
+
+			ret = swap_write_page(handle, page, &bio);
+			if (ret)
+				goto out_finish;
+		}
+	}
+
+out_finish:
+	err2 = hib_wait_on_bio_chain(&bio);
+	do_gettimeofday(&stop);
+	if (!ret)
+		ret = err2;
+	if (!ret)
+		printk(KERN_CONT "\b\b\b\bdone\n");
+	else
+		printk(KERN_CONT "\n");
+	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
+
+	vfree(cmp);
+	vfree(unc);
+	vfree(wrk);
+	free_page((unsigned long)page);
+
+	return ret;
+}
+
 /**
  *	enough_swap - Make sure we have enough swap to save the image.
  *
@@ -416,7 +556,8 @@ static int enough_swap(unsigned int nr_pages)
 	unsigned int free_swap = count_swap_pages(root_swap, 1);
 
 	pr_debug("PM: Free swap pages: %u\n", free_swap);
-	return free_swap > nr_pages + PAGES_FOR_IO;
+	return free_swap >
+	       (nr_pages * LZO_CMP_PAGES) / LZO_UNC_PAGES + 1 + PAGES_FOR_IO;
 }
 
 /**
@@ -458,8 +599,12 @@ int swsusp_write(unsigned int flags)
 	}
 	header = (struct swsusp_info *)data_of(snapshot);
 	error = swap_write_page(&handle, header, NULL);
-	if (!error)
-		error = save_image(&handle, &snapshot, pages - 1);
+	if (!error) {
+		if (flags & SF_NOCOMPRESS_MODE)
+			error = save_image(&handle, &snapshot, pages - 1);
+		else
+			error = save_image_cmp(&handle, &snapshot, pages - 1);
+	}
 out_finish:
 	error = swap_writer_finish(&handle, flags, error);
 	return error;
@@ -590,6 +735,126 @@ static int load_image(struct swap_map_handle *handle,
 }
 
 /**
+ *	load_image_unc - load the image using the swap map handle, uncompress
+ *	@handle and the snapshot handle @snapshot
+ *	(assume there are @nr_pages pages to load)
+ */
+
+static int load_image_unc(struct swap_map_handle *handle,
+                          struct snapshot_handle *snapshot,
+                          unsigned int nr_to_read)
+{
+	unsigned int m;
+	int error = 0;
+	struct timeval start;
+	struct timeval stop;
+	unsigned nr_pages;
+	size_t off, unc_len, cmp_len;
+	unsigned char *unc, *cmp, *page;
+
+	page = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
+	if (!page) {
+		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
+		return -ENOMEM;
+	}
+
+	unc = vmalloc(LZO_UNC_SIZE);
+	if (!unc) {
+		printk(KERN_ERR "PM: Failed to allocate LZO uncompressed\n");
+		free_page((unsigned long)page);
+		return -ENOMEM;
+	}
+
+	cmp = vmalloc(LZO_CMP_SIZE);
+	if (!cmp) {
+		printk(KERN_ERR "PM: Failed to allocate LZO compressed\n");
+		vfree(unc);
+		free_page((unsigned long)page);
+		return -ENOMEM;
+	}
+
+	printk(KERN_INFO "PM: Loading image data pages (%u pages) ...     ",
+		nr_to_read);
+	m = nr_to_read / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	do_gettimeofday(&start);
+
+	error = snapshot_write_next(snapshot);
+	if (error <= 0)
+		goto out_finish;
+
+	for ( ; ; ) {
+		error = swap_read_page(handle, page, NULL); /* sync */
+		if (error)
+			break;
+
+		cmp_len = *(size_t *)page;
+		if (unlikely(!cmp_len ||
+		             cmp_len > lzo1x_worst_compress(LZO_UNC_SIZE))) {
+			printk(KERN_ERR "PM: Invalid LZO compressed length\n");
+			error = -1;
+			break;
+		}
+
+		memcpy(cmp, page, PAGE_SIZE);
+		for (off = PAGE_SIZE; off < LZO_HEADER + cmp_len; off += PAGE_SIZE) {
+			error = swap_read_page(handle, page, NULL); /* sync */
+			if (error)
+				goto out_finish;
+
+			memcpy(cmp + off, page, PAGE_SIZE);
+		}
+
+		unc_len = LZO_UNC_SIZE;
+		error = lzo1x_decompress_safe(cmp + LZO_HEADER, cmp_len,
+		                              unc, &unc_len);
+		if (error < 0) {
+			printk(KERN_ERR "PM: LZO decompression failed\n");
+			break;
+		}
+
+		if (unlikely(!unc_len ||
+		             unc_len > LZO_UNC_SIZE ||
+		             unc_len & (PAGE_SIZE - 1))) {
+			printk(KERN_ERR "PM: Invalid LZO uncompressed length\n");
+			error = -1;
+			break;
+		}
+
+		for (off = 0; off < unc_len; off += PAGE_SIZE) {
+			memcpy(data_of(*snapshot), unc + off, PAGE_SIZE);
+
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+
+			error = snapshot_write_next(snapshot);
+			if (error <= 0)
+				goto out_finish;
+		}
+	}
+
+out_finish:
+	do_gettimeofday(&stop);
+	if (!error) {
+		printk("\b\b\b\bdone\n");
+		snapshot_write_finalize(snapshot);
+		if (!snapshot_image_loaded(snapshot))
+			error = -ENODATA;
+	} else
+		printk("\n");
+	swsusp_show_speed(&start, &stop, nr_to_read, "Read");
+
+	vfree(cmp);
+	vfree(unc);
+	free_page((unsigned long)page);
+
+	return error;
+}
+
+/**
  *	swsusp_read - read the hibernation image.
  *	@flags_p: flags passed by the "frozen" kernel in the image header should
  *		  be written into this memeory location
@@ -612,8 +877,12 @@ int swsusp_read(unsigned int *flags_p)
 		goto end;
 	if (!error)
 		error = swap_read_page(&handle, header, NULL);
-	if (!error)
-		error = load_image(&handle, &snapshot, header->pages - 1);
+	if (!error) {
+		if (*flags_p & SF_NOCOMPRESS_MODE)
+			error = load_image(&handle, &snapshot, header->pages - 1);
+		else	
+			error = load_image_unc(&handle, &snapshot, header->pages - 1);
+	}
 	swap_reader_finish(&handle);
 end:
 	if (!error)

-- 
Bojan
