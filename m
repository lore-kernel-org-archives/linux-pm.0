From: nigel@tuxonice.net
Subject: [PATCH 07/10] Hibernation: Iterate over sectors not swap
	entries.
Date: Fri, 28 May 2010 21:14:56 +1000
Message-ID: <1275045299-25890-8-git-send-email-nigel@tuxonice.net>
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

Record sectors in extents when allocating storage, and use the
sector numbers instead of swap offsets as we write the image. If
we then store these sector extents at the start of the image (as
following patches will do), we can drop the index pages that are
interspersed with the image, do fully asynchronous I/O (which
should give a speed boost) and perhaps also remove some of the
duplication in the paths for reading and writing pages.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/swap.c |   25 ++++++++++---------------
 1 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 15cbe70..d87f663 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -76,14 +76,7 @@ struct swsusp_header {
 static struct swsusp_header *swsusp_header;
 
 static struct hib_extent_state swap_extents;
-
-static sector_t next_swapdev_block(void)
-{
-	unsigned long res = hib_extent_next(&swap_extents);
-	if (res)
-		res = swapdev_block(root_swap, res);
-	return res;
-}
+static struct hib_extent_state sector_extents;
 
 /**
  *	alloc_swapdev_block - allocate a swap page and register that it has
@@ -92,14 +85,16 @@ static sector_t next_swapdev_block(void)
 
 sector_t alloc_swapdev_block(int swap)
 {
-	unsigned long offset;
+	unsigned long offset, sector;
 
 	offset = swp_offset(get_swap_page_of_type(swap));
 	if (offset) {
-		if (hib_extents_insert(&swap_extents, offset))
+		sector = swapdev_block(swap, offset);
+		if (hib_extents_insert(&swap_extents, offset) ||
+		    hib_extents_insert(&sector_extents, sector))
 			swap_free(swp_entry(swap, offset));
 		else
-			return swapdev_block(swap, offset);
+			return sector;
 	}
 	return 0;
 }
@@ -140,7 +135,7 @@ static int allocate_swap(unsigned int nr_pages)
 		return 0;
 	}
 
-	hib_reset_extent_pos(&swap_extents);
+	hib_reset_extent_pos(&sector_extents);
 	return 1;
 }
 
@@ -280,7 +275,7 @@ static int get_swap_writer(struct swap_map_handle *handle, unsigned long pages)
 		ret = -ENOSPC;
 		goto err_close;
 	}
-	handle->cur_swap = next_swapdev_block();
+	handle->cur_swap = hib_extent_next(&sector_extents);
 	if (!handle->cur_swap) {
 		ret = -ENOSPC;
 		goto err_rel;
@@ -303,7 +298,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 
 	if (!handle->cur)
 		return -EINVAL;
-	offset = next_swapdev_block();
+	offset = hib_extent_next(&sector_extents);
 	error = write_page(buf, offset, bio_chain);
 	if (error)
 		return error;
@@ -312,7 +307,7 @@ static int swap_write_page(struct swap_map_handle *handle, void *buf,
 		error = hib_wait_on_bio_chain(bio_chain);
 		if (error)
 			goto out;
-		offset = next_swapdev_block();
+		offset = hib_extent_next(&sector_extents);
 		if (!offset)
 			return -ENOSPC;
 		handle->cur->next_swap = offset;
-- 
1.7.0.4
