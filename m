From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Patch 1/2: Add support to swsusp for merging partial
	pages.
Date: Mon, 06 Jul 2009 15:44:31 +1000
Message-ID: <4A518F3F.9050007__16631.2854657464$1246859297$gmane$org@crca.org.au>
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
To: Rafael Wysocki <rjw@sisk.pl>, linux-pm <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>
List-Id: linux-pm@vger.kernel.org

>From e823b418d0cdc80da65a9c9b2d9783998c17de68 Mon Sep 17 00:00:00 2001
From: Nigel Cunningham <nigel@tuxonice.net>
Date: Sun, 5 Jul 2009 22:51:48 +1000
Subject: [PATCH] Hibernation patch: Buffered I/O.

Add support for merging partial pages together when writing an image.
Prefix each 'chunk' by the size of the chunk. This will be used (in the
next patch) to enable support for compressing the image and merging the
compressed data together into complete pages.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/swap.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 8ba052c..260c622 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -45,6 +45,8 @@ static struct swsusp_header *swsusp_header;
 
 static unsigned short root_swap = 0xffff;
 static struct block_device *resume_bdev;
+static char *merged_buffer;
+static int merged_buffer_posn;
 
 /**
  *	submit - submit BIO request.
@@ -305,6 +307,62 @@ static int flush_swap_writer(struct swap_map_handle *handle)
 		return -EINVAL;
 }
 
+static int swap_read_page(struct swap_map_handle *handle, void *buf,
+				struct bio **bio_chain);
+
+/*
+ * do_buffered_io - combine (potentially) smaller buffers into PAGE_SIZE I/O
+ * @writing:		Bool - whether writing (or reading).
+ * @buffer:		The start of the buffer to write or fill.
+ * @buffer_size:	The size of the buffer to write or fill.
+ **/
+int swap_buffered_io(int writing, char *buffer, int buffer_size,
+		struct swap_map_handle *handle, struct bio **bio)
+{
+	int bytes_left = buffer_size, result = 0;
+
+	while (bytes_left) {
+		char *buf_start = buffer + buffer_size - bytes_left;
+		char *merged_start = merged_buffer + merged_buffer_posn;
+		int capacity = PAGE_SIZE - merged_buffer_posn;
+		char *to = writing ? merged_start : buf_start;
+		char *from = writing ? buf_start : merged_start;
+
+		if (bytes_left < capacity) {
+			memcpy(to, from, bytes_left);
+			merged_buffer_posn += bytes_left;
+			return 0;
+		}
+
+		/* Complete this page and start a new one */
+		memcpy(to, from, capacity);
+		bytes_left -= capacity;
+
+		if (writing) {
+			result = swap_write_page(handle, merged_buffer, bio);
+			if (result)
+				return result;
+		} else {
+			/* Must be sync until I add readahead */
+			result = swap_read_page(handle, merged_buffer, NULL);
+			if (result)
+				return result;
+		}
+
+		merged_buffer_posn = 0;
+	}
+
+	return 0;
+}
+
+int swap_flush_buffered_io(struct swap_map_handle *handle, struct bio **bio)
+{
+	if (!merged_buffer_posn)
+		return 0;
+
+	return swap_write_page(handle, merged_buffer, bio);
+}
+
 /**
  *	save_image - save the suspend image data
  */
@@ -329,12 +387,25 @@ static int save_image(struct swap_map_handle *handle,
 		m = 1;
 	nr_pages = 0;
 	bio = NULL;
+	merged_buffer = (void *) get_zeroed_page(__GFP_WAIT | __GFP_HIGH);
+	merged_buffer_posn = 0;
 	do_gettimeofday(&start);
 	do {
 		ret = snapshot_read_next(snapshot, PAGE_SIZE);
 		if (ret > 0) {
-			error = swap_write_page(handle, data_of(*snapshot),
-						&bio);
+			int bytes = PAGE_SIZE;
+
+			/*
+			 * Write the size of the (possibly) compressed data and
+			 * then the data itself.
+			 */
+
+			error = swap_buffered_io(WRITE, (void *) &bytes, sizeof(bytes),
+					handle, &bio);
+			if (error)
+				break;
+			error = swap_buffered_io(WRITE, data_of(*snapshot), bytes,
+					handle, &bio);
 			if (error)
 				break;
 			if (!(nr_pages % m))
@@ -342,6 +413,7 @@ static int save_image(struct swap_map_handle *handle,
 			nr_pages++;
 		}
 	} while (ret > 0);
+	error = swap_flush_buffered_io(handle, &bio);
 	err2 = wait_on_bio_chain(&bio);
 	do_gettimeofday(&stop);
 	if (!error)
@@ -349,6 +421,7 @@ static int save_image(struct swap_map_handle *handle,
 	if (!error)
 		printk("\b\b\b\bdone\n");
 	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
+	free_page((unsigned long) merged_buffer);
 	return error;
 }
 
@@ -364,7 +437,7 @@ static int enough_swap(unsigned int nr_pages)
 	unsigned int free_swap = count_swap_pages(root_swap, 1);
 
 	pr_debug("PM: Free swap pages: %u\n", free_swap);
-	return free_swap > nr_pages + PAGES_FOR_IO;
+	return free_swap > (nr_pages + PAGES_FOR_IO) * 1.01;
 }
 
 /**
@@ -512,12 +585,27 @@ static int load_image(struct swap_map_handle *handle,
 		m = 1;
 	nr_pages = 0;
 	bio = NULL;
+	merged_buffer = (void *) get_zeroed_page(__GFP_WAIT | __GFP_HIGH);
+	merged_buffer_posn = PAGE_SIZE; /* Start by reading first page */
 	do_gettimeofday(&start);
 	for ( ; ; ) {
+		int bytes;
+
 		error = snapshot_write_next(snapshot, PAGE_SIZE);
 		if (error <= 0)
 			break;
-		error = swap_read_page(handle, data_of(*snapshot), &bio);
+
+		/*
+		 * Write the size of the (possibly) compressed data and
+		 * then the data itself.
+		 */
+
+		error = swap_buffered_io(READ, (void *) &bytes, sizeof(bytes),
+				handle, &bio);
+		if (error)
+			break;
+		error = swap_buffered_io(READ, data_of(*snapshot), bytes,
+				handle, &bio);
 		if (error)
 			break;
 		if (snapshot->sync_read)
@@ -539,6 +627,7 @@ static int load_image(struct swap_map_handle *handle,
 			error = -ENODATA;
 	}
 	swsusp_show_speed(&start, &stop, nr_to_read, "Read");
+	free_page((unsigned long) merged_buffer);
 	return error;
 }
 
-- 
1.6.0.4
