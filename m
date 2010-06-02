From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 20/21] Hibernation: Remove swap_map structure
Date: Wed,  2 Jun 2010 22:19:19 +1000
Message-ID: <1275481160-31150-21-git-send-email-nigel__4602.88095423511$1275483635$gmane$org@tuxonice.net>
References: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Remove the now unused swap_map structure and associated
swap_map_handle.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |   56 -----------------------------------------------
 1 files changed, 0 insertions(+), 56 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index dd71ef2..5c791c0 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -126,40 +126,7 @@ void hib_wait_on_bio_chain(void)
 	wait_event(num_in_progress_wait, !atomic_read(&hib_io_in_progress));
 }
 
-/*
- *	The swap map is a data structure used for keeping track of each page
- *	written to a swap partition.  It consists of many swap_map_page
- *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
- *	These structures are stored on the swap and linked together with the
- *	help of the .next_swap member.
- *
- *	The swap map is created during suspend.  The swap map pages are
- *	allocated and populated one at a time, so we only need one memory
- *	page to set up the entire structure.
- *
- *	During resume we also only need to use one swap_map_page structure
- *	at a time.
- */
-
-#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(sector_t) - 1)
-
-struct swap_map_page {
-	sector_t entries[MAP_PAGE_ENTRIES];
-	sector_t next_swap;
-};
-
-/**
- *	The swap_map_handle structure is used for handling swap in
- *	a file-alike way
- */
-
-struct swap_map_handle {
-	struct swap_map_page *cur;
-	unsigned int k;
-};
-
 static sector_t first_sector;
-static struct swap_map_handle handle;
 
 extern struct hib_extent_state sector_extents;
 
@@ -207,20 +174,12 @@ static int write_page(void *buf, sector_t offset, int sync)
 
 void release_swap_writer(void)
 {
-	if (handle.cur)
-		free_page((unsigned long)handle.cur);
-	handle.cur = NULL;
 }
 
 int hib_bio_prepare_write(void)
 {
 	int result, result2;
 
-	handle.cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
-
-	if (!handle.cur)
-		return -ENOMEM;
-
 	result = hib_prepare_buffer();
 	if (result) {
 		release_swap_writer();
@@ -232,8 +191,6 @@ int hib_bio_prepare_write(void)
 	result = hib_extents_store(&sector_extents);
 	result2 = hib_flush_write_buffer();
 
-	handle.k = 0;
-
 	if (result || result2)
 		release_swap_writer();
 
@@ -244,8 +201,6 @@ int swap_write_page(void *buf, int sync)
 {
 	sector_t offset;
 
-	if (!handle.cur)
-		return -EINVAL;
 	offset = hib_extent_next(&sector_extents);
 	return write_page(buf, offset, sync);
 }
@@ -263,19 +218,12 @@ int flush_swap_writer(void)
 
 void release_swap_reader(void)
 {
-	if (handle.cur)
-		free_page((unsigned long)handle.cur);
-	handle.cur = NULL;
 }
 
 int get_swap_reader(unsigned int *flags_p, sector_t first_page)
 {
 	int error;
 
-	handle.cur = (struct swap_map_page *)get_zeroed_page(__GFP_WAIT | __GFP_HIGH);
-	if (!handle.cur)
-		return -ENOMEM;
-
 	error = hib_prepare_buffer();
 	if (error) {
 		release_swap_reader();
@@ -290,8 +238,6 @@ int get_swap_reader(unsigned int *flags_p, sector_t first_page)
 		return error;
 	}
 
-	handle.k = 0;
-
 	error = hib_extents_load(&sector_extents, 1);
 
 	if (error) {
@@ -306,8 +252,6 @@ int swap_read_page(void *buf, int sync)
 {
 	sector_t offset;
 
-	if (!handle.cur)
-		return -EINVAL;
 	offset = hib_extent_next(&sector_extents);
 	if (!offset)
 		return -EFAULT;
-- 
1.7.0.4
