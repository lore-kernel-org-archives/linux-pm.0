From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 21/21] Hibernation: Remove now-empty routines.
Date: Wed,  2 Jun 2010 22:19:20 +1000
Message-ID: <1275481160-31150-22-git-send-email-nigel__35546.9618145891$1275482627$gmane$org@tuxonice.net>
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

release_swap_writer and release_swap_reader are now empty functions.
Remove them and clean up callers (including swap_reader_finish, which
just called release_swap_reader).

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |   36 ++++--------------------------------
 kernel/power/block_io.h |    2 --
 kernel/power/swap.c     |    9 ---------
 3 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index 5c791c0..d02013a 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -172,28 +172,19 @@ static int write_page(void *buf, sector_t offset, int sync)
 	return hib_bio_write_page(offset, src, sync);
 }
 
-void release_swap_writer(void)
-{
-}
-
 int hib_bio_prepare_write(void)
 {
 	int result, result2;
 
 	result = hib_prepare_buffer();
-	if (result) {
-		release_swap_writer();
+	if (result)
 		return result;
-	}
 
 	first_sector = hib_extent_current(&sector_extents);
 
 	result = hib_extents_store(&sector_extents);
 	result2 = hib_flush_write_buffer();
 
-	if (result || result2)
-		release_swap_writer();
-
 	return result ? result : result2;
 }
 
@@ -211,38 +202,19 @@ int flush_swap_writer(void)
 	return 0;
 }
 
-/**
- *	The following functions allow us to read data using a swap map
- *	in a file-alike way
- */
-
-void release_swap_reader(void)
-{
-}
-
 int get_swap_reader(unsigned int *flags_p, sector_t first_page)
 {
 	int error;
 
 	error = hib_prepare_buffer();
-	if (error) {
-		release_swap_reader();
+	if (error)
 		return error;
-	}
 
 	/* Bootstrap reading the extents */
 	error = hib_bio_read_page(first_page, hib_ppio_buffer, 1);
-	if (error) {
-		release_swap_reader();
-		hib_free_buffer();
-		return error;
-	}
 
-	error = hib_extents_load(&sector_extents, 1);
-
-	if (error) {
-		release_swap_reader();
-	}
+	if (!error)
+		error = hib_extents_load(&sector_extents, 1);
 
 	hib_free_buffer();
 	return error;
diff --git a/kernel/power/block_io.h b/kernel/power/block_io.h
index 1482060..228fe58 100644
--- a/kernel/power/block_io.h
+++ b/kernel/power/block_io.h
@@ -14,12 +14,10 @@ void hib_wait_on_bio_chain(void);
 unsigned int hib_bio_overhead(unsigned int nr_pages);
 sector_t hib_get_first_sector(void);
 extern struct hib_extent_state sector_extents;
-void release_swap_writer(void);
 int hib_bio_prepare_write(void);
 int flush_swap_writer(void);
 int swap_write_page(void *buf, int sync);
 int get_swap_reader(unsigned int *flags_p, sector_t first_page);
-void release_swap_reader(void);
 int swap_read_page(void *buf, int sync);
 int hib_flush_write_buffer(void);
 
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index e477310..8763baa 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -220,7 +220,6 @@ static int swap_writer_finish(unsigned int flags, int error)
 
 	if (error)
 		free_all_swap_pages(root_swap);
-	release_swap_writer();
 	swsusp_close(FMODE_WRITE);
 
 	return error;
@@ -307,13 +306,6 @@ out_finish:
 	return error;
 }
 
-static int swap_reader_finish(void)
-{
-	release_swap_reader();
-
-	return 0;
-}
-
 /**
  *	load_image - load the image using the swap map handle
  *	@handle and the snapshot handle @snapshot
@@ -390,7 +382,6 @@ int swsusp_read(unsigned int *flags_p)
 		error = swap_read_page(header, 1);
 	if (!error)
 		error = load_image(&snapshot, header->pages - 1);
-	swap_reader_finish();
 end:
 	if (!error)
 		pr_debug("PM: Image successfully loaded\n");
-- 
1.7.0.4
