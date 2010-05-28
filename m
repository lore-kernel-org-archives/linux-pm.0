From: nigel@tuxonice.net
Subject: [PATCH 04/10] Hibernation: Switch to preallocating swap.
Date: Fri, 28 May 2010 21:14:53 +1000
Message-ID: <1275045299-25890-5-git-send-email-nigel@tuxonice.net>
References: <1275045299-25890-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275045299-25890-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Nigel Cunningham <nigel@tuxonice.net>

Switch from allocating swap as the image is written to allocating
storage prior to writing the image.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/swap.c |   62 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 550c1ed..ff2fc15 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -201,6 +201,33 @@ int alloc_swapdev_blocks(int needed)
 }
 
 /**
+ *	allocate_swap - Allocate enough swap to save the image.
+ *
+ *	Calculates the number of swap pages actually needed and seeks
+ *	to allocate that many from the resume partition. Returns TRUE
+ *	or FALSE to indicate whether we got enough storage.
+ */
+
+static int allocate_swap(unsigned int nr_pages)
+{
+	unsigned int free_swap = count_swap_pages(root_swap, 1);
+
+	nr_pages += DIV_ROUND_UP(nr_pages, MAP_PAGE_ENTRIES);
+
+	pr_debug("PM: Free swap pages: %u\n", free_swap);
+	if (free_swap < nr_pages)
+		return 0;
+
+	if (alloc_swapdev_blocks(nr_pages) < nr_pages) {
+		free_all_swap_pages(root_swap);
+		return 0;
+	}
+
+	reset_storage_pos();
+	return 1;
+}
+
+/**
  *	free_all_swap_pages - free swap pages allocated for saving image data.
  *	It also frees the extents used to register which swap entres had been
  *	allocated.
@@ -321,7 +348,7 @@ static void release_swap_writer(struct swap_map_handle *handle)
 	handle->cur = NULL;
 }
 
-static int get_swap_writer(struct swap_map_handle *handle)
+static int get_swap_writer(struct swap_map_handle *handle, unsigned long pages)
 {
 	int ret;
 
@@ -337,7 +364,12 @@ static int get_swap_writer(struct swap_map_handle *handle)
 		ret = -ENOMEM;
 		goto err_close;
 	}
-	handle->cur_swap = alloc_swapdev_block(root_swap);
+	if (!allocate_swap(pages)) {
+		printk(KERN_ERR "PM: Not enough free swap\n");
+		ret = -ENOSPC;
+		goto err_close;
+	}
+	handle->cur_swap = next_swapdev_block();
 	if (!handle->cur_swap) {
 		ret = -ENOSPC;
 		goto err_rel;
@@ -360,7 +392,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 
 	if (!handle->cur)
 		return -EINVAL;
-	offset = alloc_swapdev_block(root_swap);
+	offset = next_swapdev_block();
 	error = write_page(buf, offset, bio_chain);
 	if (error)
 		return error;
@@ -369,7 +401,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 		error = hib_wait_on_bio_chain(bio_chain);
 		if (error)
 			goto out;
-		offset = alloc_swapdev_block(root_swap);
+		offset = next_swapdev_block();
 		if (!offset)
 			return -ENOSPC;
 		handle->cur->next_swap = offset;
@@ -458,21 +490,6 @@ static int save_image(struct swap_map_handle *handle,
 }
 
 /**
- *	enough_swap - Make sure we have enough swap to save the image.
- *
- *	Returns TRUE or FALSE after checking the total amount of swap
- *	space avaiable from the resume partition.
- */
-
-static int enough_swap(unsigned int nr_pages)
-{
-	unsigned int free_swap = count_swap_pages(root_swap, 1);
-
-	pr_debug("PM: Free swap pages: %u\n", free_swap);
-	return free_swap > nr_pages + PAGES_FOR_IO;
-}
-
-/**
  *	swsusp_write - Write entire image and metadata.
  *	@flags: flags to pass to the "boot" kernel in the image header
  *
@@ -491,16 +508,11 @@ int swsusp_write(unsigned int flags)
 	int error;
 
 	pages = snapshot_get_image_size();
-	error = get_swap_writer(&handle);
+	error = get_swap_writer(&handle, pages);
 	if (error) {
 		printk(KERN_ERR "PM: Cannot get swap writer\n");
 		return error;
 	}
-	if (!enough_swap(pages)) {
-		printk(KERN_ERR "PM: Not enough free swap\n");
-		error = -ENOSPC;
-		goto out_finish;
-	}
 	memset(&snapshot, 0, sizeof(struct snapshot_handle));
 	error = snapshot_read_next(&snapshot);
 	if (error < PAGE_SIZE) {
-- 
1.7.0.4
