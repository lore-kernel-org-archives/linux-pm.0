From: Bojan Smojver <bojan@rexursive.com>
Subject: [PATCH]: Use async I/O when reading compressed
	hibernation image
Date: Mon, 22 Nov 2010 13:03:42 +1100
Message-ID: <1290391422.2694.11.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

This is a fix for reading LZO compressed image using async I/O.
Essentially, instead of having just one page into which we keep reading
blocks from swap, we allocate enough of them to cover the largest
compressed size and then let block I/O pick them all up. Once we have
them all (and here we wait), we decompress them, as usual. Obviously,
the very first block we still pick up synchronously, because we need to
know the size of the lot before we pick up the rest.

I guess this can go in 2.6.37 (actually, this is how I _should_ have
done that patch in the first place), because it is essentially a
performance fix.

Also fixed the copyright line, which I've forgotten before.

 kernel/power/swap.c |   53
++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index a0e4a86..baf667b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -6,6 +6,7 @@
  *
  * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@ucw.cz>
  * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ * Copyright (C) 2010 Bojan Smojver <bojan@rexursive.com>
  *
  * This file is released under the GPLv2.
  *
@@ -753,30 +754,43 @@ static int load_image_lzo(struct swap_map_handle
*handle,
 {
 	unsigned int m;
 	int error = 0;
+	struct bio *bio;
 	struct timeval start;
 	struct timeval stop;
 	unsigned nr_pages;
-	size_t off, unc_len, cmp_len;
-	unsigned char *unc, *cmp, *page;
+	size_t i, off, unc_len, cmp_len;
+	unsigned char *unc, *cmp, *page[LZO_CMP_PAGES];
 
-	page = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
-	if (!page) {
-		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
-		return -ENOMEM;
+	for (i = 0; i < LZO_CMP_PAGES; i++) {
+		page[i] = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
+		if (!page[i]) {
+			printk(KERN_ERR "PM: Failed to allocate LZO page\n");
+
+			while (i)
+				free_page((unsigned long)page[--i]);
+
+			return -ENOMEM;
+		}
 	}
 
 	unc = vmalloc(LZO_UNC_SIZE);
 	if (!unc) {
 		printk(KERN_ERR "PM: Failed to allocate LZO uncompressed\n");
-		free_page((unsigned long)page);
+
+		for (i = 0; i < LZO_CMP_PAGES; i++)
+			free_page((unsigned long)page[i]);
+
 		return -ENOMEM;
 	}
 
 	cmp = vmalloc(LZO_CMP_SIZE);
 	if (!cmp) {
 		printk(KERN_ERR "PM: Failed to allocate LZO compressed\n");
+
 		vfree(unc);
-		free_page((unsigned long)page);
+		for (i = 0; i < LZO_CMP_PAGES; i++)
+			free_page((unsigned long)page[i]);
+
 		return -ENOMEM;
 	}
 
@@ -787,6 +801,7 @@ static int load_image_lzo(struct swap_map_handle
*handle,
 	if (!m)
 		m = 1;
 	nr_pages = 0;
+	bio = NULL;
 	do_gettimeofday(&start);
 
 	error = snapshot_write_next(snapshot);
@@ -794,11 +809,11 @@ static int load_image_lzo(struct swap_map_handle
*handle,
 		goto out_finish;
 
 	for (;;) {
-		error = swap_read_page(handle, page, NULL); /* sync */
+		error = swap_read_page(handle, page[0], NULL); /* sync */
 		if (error)
 			break;
 
-		cmp_len = *(size_t *)page;
+		cmp_len = *(size_t *)page[0];
 		if (unlikely(!cmp_len ||
 		             cmp_len > lzo1x_worst_compress(LZO_UNC_SIZE))) {
 			printk(KERN_ERR "PM: Invalid LZO compressed length\n");
@@ -806,13 +821,20 @@ static int load_image_lzo(struct swap_map_handle
*handle,
 			break;
 		}
 
-		memcpy(cmp, page, PAGE_SIZE);
-		for (off = PAGE_SIZE; off < LZO_HEADER + cmp_len; off += PAGE_SIZE) {
-			error = swap_read_page(handle, page, NULL); /* sync */
+		for (off = PAGE_SIZE, i = 1;
+		     off < LZO_HEADER + cmp_len; off += PAGE_SIZE, i++) {
+			error = swap_read_page(handle, page[i], &bio);
 			if (error)
 				goto out_finish;
+		}
 
-			memcpy(cmp + off, page, PAGE_SIZE);
+		error = hib_wait_on_bio_chain(&bio); /* need all data now */
+		if (error)
+			goto out_finish;
+
+		for (off = 0, i = 0;
+		     off < LZO_HEADER + cmp_len; off += PAGE_SIZE, i++) {
+			memcpy(cmp + off, page[i], PAGE_SIZE);
 		}
 
 		unc_len = LZO_UNC_SIZE;
@@ -857,7 +879,8 @@ out_finish:
 
 	vfree(cmp);
 	vfree(unc);
-	free_page((unsigned long)page);
+	for (i = 0; i < LZO_CMP_PAGES; i++)
+		free_page((unsigned long)page[i]);
 
 	return error;
 }


-- 
Bojan
