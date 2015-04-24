From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 4/4] PM: submit bio in a sane way in cases without
 bio_chain
Date: Fri, 24 Apr 2015 09:17:26 -0700
Message-ID: <20150424161726.GA21763@infradead.org>
References: <1429830275-6792-1-git-send-email-mlin@kernel.org>
 <1429830275-6792-5-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:32927 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbbDXQR0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 12:17:26 -0400
Content-Disposition: inline
In-Reply-To: <1429830275-6792-5-git-send-email-mlin@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ming Lin <mlin@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>, Dongsu Park <dongsu.park@profitbricks.com>, linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@sisk.pl

On Thu, Apr 23, 2015 at 04:04:35PM -0700, Ming Lin wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> Make bio submission in kernel/power/block_io.c to properly submit
> bios also when bio_chain is not available. In that case, it's not
> necessary to handle refcount with bio_get(), but it's saner to simply
> call a predefined helper submit_bio_wait(). So call bio_get() only
> when bio_chain is given.

The patch looks correct, buth that whole code is a f****ing mess.

For one it really shouldn't mess with pages states nor abuse
end_swap_bio_read.

Something like the untested patch below should do it, but it really
needs some solid testing from people that know how to even exercise
it.

---
>From af56dde07c34b203f5c40c8864bfd55697b0aad0 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 24 Apr 2015 11:26:00 +0200
Subject: suspend: sane block I/O handling

stop abusing struct page functionality and the swap end_io handler, and
instead add a modified version of the blk-lib.c bio_batch helpers.

Also move the block I/O code into swap.c as they are directly tied into
each other.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h    |   1 -
 kernel/power/Makefile   |   3 +-
 kernel/power/block_io.c | 103 -------------------------------
 kernel/power/power.h    |   9 ---
 kernel/power/swap.c     | 159 ++++++++++++++++++++++++++++++++++++------------
 mm/page_io.c            |   2 +-
 6 files changed, 122 insertions(+), 155 deletions(-)
 delete mode 100644 kernel/power/block_io.c

diff --git a/include/linux/swap.h b/include/linux/swap.h
index cee108c..3887472 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -377,7 +377,6 @@ extern void end_swap_bio_write(struct bio *bio, int err);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	void (*end_write_func)(struct bio *, int));
 extern int swap_set_page_dirty(struct page *page);
-extern void end_swap_bio_read(struct bio *bio, int err);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 29472bf..cb880a1 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -7,8 +7,7 @@ obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
 obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
-obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o \
-				   block_io.o
+obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o
 obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
 obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 
diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
deleted file mode 100644
index 9a58bc2..0000000
--- a/kernel/power/block_io.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * This file provides functions for block I/O operations on swap/file.
- *
- * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@ucw.cz>
- * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
- *
- * This file is released under the GPLv2.
- */
-
-#include <linux/bio.h>
-#include <linux/kernel.h>
-#include <linux/pagemap.h>
-#include <linux/swap.h>
-
-#include "power.h"
-
-/**
- *	submit - submit BIO request.
- *	@rw:	READ or WRITE.
- *	@off	physical offset of page.
- *	@page:	page we're reading or writing.
- *	@bio_chain: list of pending biod (for async reading)
- *
- *	Straight from the textbook - allocate and initialize the bio.
- *	If we're reading, make sure the page is marked as dirty.
- *	Then submit it and, if @bio_chain == NULL, wait.
- */
-static int submit(int rw, struct block_device *bdev, sector_t sector,
-		struct page *page, struct bio **bio_chain)
-{
-	const int bio_rw = rw | REQ_SYNC;
-	struct bio *bio;
-
-	bio = bio_alloc(__GFP_WAIT | __GFP_HIGH, 1);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_bdev = bdev;
-	bio->bi_end_io = end_swap_bio_read;
-
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk(KERN_ERR "PM: Adding page to bio failed at %llu\n",
-			(unsigned long long)sector);
-		bio_put(bio);
-		return -EFAULT;
-	}
-
-	lock_page(page);
-	bio_get(bio);
-
-	if (bio_chain == NULL) {
-		submit_bio(bio_rw, bio);
-		wait_on_page_locked(page);
-		if (rw == READ)
-			bio_set_pages_dirty(bio);
-		bio_put(bio);
-	} else {
-		if (rw == READ)
-			get_page(page);	/* These pages are freed later */
-		bio->bi_private = *bio_chain;
-		*bio_chain = bio;
-		submit_bio(bio_rw, bio);
-	}
-	return 0;
-}
-
-int hib_bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
-{
-	return submit(READ, hib_resume_bdev, page_off * (PAGE_SIZE >> 9),
-			virt_to_page(addr), bio_chain);
-}
-
-int hib_bio_write_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
-{
-	return submit(WRITE, hib_resume_bdev, page_off * (PAGE_SIZE >> 9),
-			virt_to_page(addr), bio_chain);
-}
-
-int hib_wait_on_bio_chain(struct bio **bio_chain)
-{
-	struct bio *bio;
-	struct bio *next_bio;
-	int ret = 0;
-
-	if (bio_chain == NULL)
-		return 0;
-
-	bio = *bio_chain;
-	if (bio == NULL)
-		return 0;
-	while (bio) {
-		struct page *page;
-
-		next_bio = bio->bi_private;
-		page = bio->bi_io_vec[0].bv_page;
-		wait_on_page_locked(page);
-		if (!PageUptodate(page) || PageError(page))
-			ret = -EIO;
-		put_page(page);
-		bio_put(bio);
-		bio = next_bio;
-	}
-	*bio_chain = NULL;
-	return ret;
-}
diff --git a/kernel/power/power.h b/kernel/power/power.h
index ce9b832..caadb56 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -163,15 +163,6 @@ extern void swsusp_close(fmode_t);
 extern int swsusp_unmark(void);
 #endif
 
-/* kernel/power/block_io.c */
-extern struct block_device *hib_resume_bdev;
-
-extern int hib_bio_read_page(pgoff_t page_off, void *addr,
-		struct bio **bio_chain);
-extern int hib_bio_write_page(pgoff_t page_off, void *addr,
-		struct bio **bio_chain);
-extern int hib_wait_on_bio_chain(struct bio **bio_chain);
-
 struct timeval;
 /* kernel/power/swsusp.c */
 extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 570aff8..8a0b64d 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -212,7 +212,84 @@ int swsusp_swap_in_use(void)
  */
 
 static unsigned short root_swap = 0xffff;
-struct block_device *hib_resume_bdev;
+static struct block_device *hib_resume_bdev;
+
+struct hib_bio_batch {
+	atomic_t		count;
+	wait_queue_head_t	wait;
+	int			error;
+};
+
+static void hib_init_batch(struct hib_bio_batch *hb)
+{
+	atomic_set(&hb->count, 0);
+	init_waitqueue_head(&hb->wait);
+	hb->error = 0;
+}
+
+static void hib_end_io(struct bio *bio, int error)
+{
+	struct hib_bio_batch *hb = bio->bi_private;
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct page *page = bio->bi_io_vec[0].bv_page;
+
+	if (!uptodate || error) {
+		printk(KERN_ALERT "Read-error on swap-device (%u:%u:%Lu)\n",
+				imajor(bio->bi_bdev->bd_inode),
+				iminor(bio->bi_bdev->bd_inode),
+				(unsigned long long)bio->bi_iter.bi_sector);
+
+		if (!error)
+			error = -EIO;
+	}
+	
+	if (bio_data_dir(bio) == WRITE)
+		put_page(page);
+
+	if (error && !hb->error)
+		hb->error = error;
+	if (atomic_dec_and_test(&hb->count))
+		wake_up(&hb->wait);
+
+	bio_put(bio);
+}
+
+static int hib_submit_io(int rw, pgoff_t page_off, void *addr,
+		struct hib_bio_batch *hb)
+{
+	struct page *page = virt_to_page(addr);
+	struct bio *bio;
+	int error = 0;
+
+	bio = bio_alloc(__GFP_WAIT | __GFP_HIGH, 1);
+	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
+	bio->bi_bdev = hib_resume_bdev;
+
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk(KERN_ERR "PM: Adding page to bio failed at %llu\n",
+			(unsigned long long)bio->bi_iter.bi_sector);
+		bio_put(bio);
+		return -EFAULT;
+	}
+
+	if (hb) {
+		bio->bi_end_io = hib_end_io;
+		bio->bi_private = hb;
+		atomic_inc(&hb->count);
+		submit_bio(rw, bio);
+	} else {
+		error = submit_bio_wait(rw, bio);
+		bio_put(bio);
+	}
+
+	return error;
+}
+
+static int hib_wait_io(struct hib_bio_batch *hb)
+{
+	wait_event(hb->wait, atomic_read(&hb->count) == 0);
+	return hb->error;
+}
 
 /*
  * Saving part
@@ -222,7 +299,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 {
 	int error;
 
-	hib_bio_read_page(swsusp_resume_block, swsusp_header, NULL);
+	hib_submit_io(READ_SYNC, swsusp_resume_block, swsusp_header, NULL);
 	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
 	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
@@ -231,7 +308,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
-		error = hib_bio_write_page(swsusp_resume_block,
+		error = hib_submit_io(WRITE_SYNC, swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
 		printk(KERN_ERR "PM: Swap header not found!\n");
@@ -271,10 +348,10 @@ static int swsusp_swap_check(void)
  *	write_page - Write one page to given swap location.
  *	@buf:		Address we're writing.
  *	@offset:	Offset of the swap page we're writing to.
- *	@bio_chain:	Link the next write BIO here
+ *	@hb:		bio completion batch
  */
 
-static int write_page(void *buf, sector_t offset, struct bio **bio_chain)
+static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
 {
 	void *src;
 	int ret;
@@ -282,13 +359,13 @@ static int write_page(void *buf, sector_t offset, struct bio **bio_chain)
 	if (!offset)
 		return -ENOSPC;
 
-	if (bio_chain) {
+	if (hb) {
 		src = (void *)__get_free_page(__GFP_WAIT | __GFP_NOWARN |
 		                              __GFP_NORETRY);
 		if (src) {
 			copy_page(src, buf);
 		} else {
-			ret = hib_wait_on_bio_chain(bio_chain); /* Free pages */
+			ret = hib_wait_io(hb); /* Free pages */
 			if (ret)
 				return ret;
 			src = (void *)__get_free_page(__GFP_WAIT |
@@ -298,14 +375,14 @@ static int write_page(void *buf, sector_t offset, struct bio **bio_chain)
 				copy_page(src, buf);
 			} else {
 				WARN_ON_ONCE(1);
-				bio_chain = NULL;	/* Go synchronous */
+				hb = NULL;	/* Go synchronous */
 				src = buf;
 			}
 		}
 	} else {
 		src = buf;
 	}
-	return hib_bio_write_page(offset, src, bio_chain);
+	return hib_submit_io(WRITE_SYNC, offset, src, hb);
 }
 
 static void release_swap_writer(struct swap_map_handle *handle)
@@ -348,7 +425,7 @@ err_close:
 }
 
 static int swap_write_page(struct swap_map_handle *handle, void *buf,
-				struct bio **bio_chain)
+		struct hib_bio_batch *hb)
 {
 	int error = 0;
 	sector_t offset;
@@ -356,7 +433,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 	if (!handle->cur)
 		return -EINVAL;
 	offset = alloc_swapdev_block(root_swap);
-	error = write_page(buf, offset, bio_chain);
+	error = write_page(buf, offset, hb);
 	if (error)
 		return error;
 	handle->cur->entries[handle->k++] = offset;
@@ -365,15 +442,15 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 		if (!offset)
 			return -ENOSPC;
 		handle->cur->next_swap = offset;
-		error = write_page(handle->cur, handle->cur_swap, bio_chain);
+		error = write_page(handle->cur, handle->cur_swap, hb);
 		if (error)
 			goto out;
 		clear_page(handle->cur);
 		handle->cur_swap = offset;
 		handle->k = 0;
 
-		if (bio_chain && low_free_pages() <= handle->reqd_free_pages) {
-			error = hib_wait_on_bio_chain(bio_chain);
+		if (hb && low_free_pages() <= handle->reqd_free_pages) {
+			error = hib_wait_io(hb);
 			if (error)
 				goto out;
 			/*
@@ -445,23 +522,24 @@ static int save_image(struct swap_map_handle *handle,
 	int ret;
 	int nr_pages;
 	int err2;
-	struct bio *bio;
+	struct hib_bio_batch hb;
 	ktime_t start;
 	ktime_t stop;
 
+	hib_init_batch(&hb);
+
 	printk(KERN_INFO "PM: Saving image data pages (%u pages)...\n",
 		nr_to_write);
 	m = nr_to_write / 10;
 	if (!m)
 		m = 1;
 	nr_pages = 0;
-	bio = NULL;
 	start = ktime_get();
 	while (1) {
 		ret = snapshot_read_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = swap_write_page(handle, data_of(*snapshot), &bio);
+		ret = swap_write_page(handle, data_of(*snapshot), &hb);
 		if (ret)
 			break;
 		if (!(nr_pages % m))
@@ -469,7 +547,7 @@ static int save_image(struct swap_map_handle *handle,
 			       nr_pages / m * 10);
 		nr_pages++;
 	}
-	err2 = hib_wait_on_bio_chain(&bio);
+	err2 = hib_wait_io(&hb);
 	stop = ktime_get();
 	if (!ret)
 		ret = err2;
@@ -580,7 +658,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	int ret = 0;
 	int nr_pages;
 	int err2;
-	struct bio *bio;
+	struct hib_bio_batch hb;
 	ktime_t start;
 	ktime_t stop;
 	size_t off;
@@ -589,6 +667,8 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	struct cmp_data *data = NULL;
 	struct crc_data *crc = NULL;
 
+	hib_init_batch(&hb);
+
 	/*
 	 * We'll limit the number of threads for compression to limit memory
 	 * footprint.
@@ -674,7 +754,6 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
-	bio = NULL;
 	start = ktime_get();
 	for (;;) {
 		for (thr = 0; thr < nr_threads; thr++) {
@@ -748,7 +827,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			     off += PAGE_SIZE) {
 				memcpy(page, data[thr].cmp + off, PAGE_SIZE);
 
-				ret = swap_write_page(handle, page, &bio);
+				ret = swap_write_page(handle, page, &hb);
 				if (ret)
 					goto out_finish;
 			}
@@ -759,7 +838,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 	}
 
 out_finish:
-	err2 = hib_wait_on_bio_chain(&bio);
+	err2 = hib_wait_io(&hb);
 	stop = ktime_get();
 	if (!ret)
 		ret = err2;
@@ -906,7 +985,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
 			return -ENOMEM;
 		}
 
-		error = hib_bio_read_page(offset, tmp->map, NULL);
+		error = hib_submit_io(READ_SYNC, offset, tmp->map, NULL);
 		if (error) {
 			release_swap_reader(handle);
 			return error;
@@ -919,7 +998,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
 }
 
 static int swap_read_page(struct swap_map_handle *handle, void *buf,
-				struct bio **bio_chain)
+		struct hib_bio_batch *hb)
 {
 	sector_t offset;
 	int error;
@@ -930,7 +1009,7 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
 	offset = handle->cur->entries[handle->k];
 	if (!offset)
 		return -EFAULT;
-	error = hib_bio_read_page(offset, buf, bio_chain);
+	error = hib_submit_io(READ_SYNC, offset, buf, hb);
 	if (error)
 		return error;
 	if (++handle->k >= MAP_PAGE_ENTRIES) {
@@ -968,27 +1047,28 @@ static int load_image(struct swap_map_handle *handle,
 	int ret = 0;
 	ktime_t start;
 	ktime_t stop;
-	struct bio *bio;
+	struct hib_bio_batch hb;
 	int err2;
 	unsigned nr_pages;
 
+	hib_init_batch(&hb);
+
 	printk(KERN_INFO "PM: Loading image data pages (%u pages)...\n",
 		nr_to_read);
 	m = nr_to_read / 10;
 	if (!m)
 		m = 1;
 	nr_pages = 0;
-	bio = NULL;
 	start = ktime_get();
 	for ( ; ; ) {
 		ret = snapshot_write_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = swap_read_page(handle, data_of(*snapshot), &bio);
+		ret = swap_read_page(handle, data_of(*snapshot), &hb);
 		if (ret)
 			break;
 		if (snapshot->sync_read)
-			ret = hib_wait_on_bio_chain(&bio);
+			ret = hib_wait_io(&hb);
 		if (ret)
 			break;
 		if (!(nr_pages % m))
@@ -996,7 +1076,7 @@ static int load_image(struct swap_map_handle *handle,
 			       nr_pages / m * 10);
 		nr_pages++;
 	}
-	err2 = hib_wait_on_bio_chain(&bio);
+	err2 = hib_wait_io(&hb);
 	stop = ktime_get();
 	if (!ret)
 		ret = err2;
@@ -1067,7 +1147,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	unsigned int m;
 	int ret = 0;
 	int eof = 0;
-	struct bio *bio;
+	struct hib_bio_batch hb;
 	ktime_t start;
 	ktime_t stop;
 	unsigned nr_pages;
@@ -1080,6 +1160,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	struct dec_data *data = NULL;
 	struct crc_data *crc = NULL;
 
+	hib_init_batch(&hb);
+
 	/*
 	 * We'll limit the number of threads for decompression to limit memory
 	 * footprint.
@@ -1190,7 +1272,6 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
-	bio = NULL;
 	start = ktime_get();
 
 	ret = snapshot_write_next(snapshot);
@@ -1199,7 +1280,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 	for(;;) {
 		for (i = 0; !eof && i < want; i++) {
-			ret = swap_read_page(handle, page[ring], &bio);
+			ret = swap_read_page(handle, page[ring], &hb);
 			if (ret) {
 				/*
 				 * On real read error, finish. On end of data,
@@ -1226,7 +1307,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 			if (!asked)
 				break;
 
-			ret = hib_wait_on_bio_chain(&bio);
+			ret = hib_wait_io(&hb);
 			if (ret)
 				goto out_finish;
 			have += asked;
@@ -1281,7 +1362,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		 * Wait for more data while we are decompressing.
 		 */
 		if (have < LZO_CMP_PAGES && asked) {
-			ret = hib_wait_on_bio_chain(&bio);
+			ret = hib_wait_io(&hb);
 			if (ret)
 				goto out_finish;
 			have += asked;
@@ -1430,7 +1511,7 @@ int swsusp_check(void)
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
-		error = hib_bio_read_page(swsusp_resume_block,
+		error = hib_submit_io(READ_SYNC, swsusp_resume_block,
 					swsusp_header, NULL);
 		if (error)
 			goto put;
@@ -1438,7 +1519,7 @@ int swsusp_check(void)
 		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			/* Reset swap signature now */
-			error = hib_bio_write_page(swsusp_resume_block,
+			error = hib_submit_io(WRITE_SYNC, swsusp_resume_block,
 						swsusp_header, NULL);
 		} else {
 			error = -EINVAL;
@@ -1482,10 +1563,10 @@ int swsusp_unmark(void)
 {
 	int error;
 
-	hib_bio_read_page(swsusp_resume_block, swsusp_header, NULL);
+	hib_submit_io(READ_SYNC, swsusp_resume_block, swsusp_header, NULL);
 	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
-		error = hib_bio_write_page(swsusp_resume_block,
+		error = hib_submit_io(WRITE_SYNC, swsusp_resume_block,
 					swsusp_header, NULL);
 	} else {
 		printk(KERN_ERR "PM: Cannot find swsusp signature!\n");
diff --git a/mm/page_io.c b/mm/page_io.c
index 6424869..520baa4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -69,7 +69,7 @@ void end_swap_bio_write(struct bio *bio, int err)
 	bio_put(bio);
 }
 
-void end_swap_bio_read(struct bio *bio, int err)
+static void end_swap_bio_read(struct bio *bio, int err)
 {
 	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
 	struct page *page = bio->bi_io_vec[0].bv_page;
-- 
1.9.1

