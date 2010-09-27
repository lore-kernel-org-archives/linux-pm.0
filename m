From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 19/23] Hibernation: Remove wait_on_bio_chain
	result
Date: Mon, 27 Sep 2010 15:43:54 +1000
Message-ID: <1285566238-10966-20-git-send-email-nigel__190.307087223296$1285568670$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
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

wait_on_bio_chain can't fail - make the result void instead
of int.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |    6 +++---
 kernel/power/block_io.h |    2 +-
 kernel/power/power.h    |    2 +-
 kernel/power/swap.c     |   14 +++-----------
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index b068b5a..c154a92 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -121,10 +121,9 @@ int hib_bio_write_page(pgoff_t page_off, void *addr, int sync)
 			virt_to_page(addr), sync);
 }
 
-int hib_wait_on_bio_chain(void)
+void hib_wait_on_bio_chain(void)
 {
 	wait_event(num_in_progress_wait, !atomic_read(&hib_io_in_progress));
-	return 0;
 }
 
 /*
@@ -253,7 +252,8 @@ int swap_write_page(void *buf, int sync)
 
 int flush_swap_writer(void)
 {
-	return hib_wait_on_bio_chain();
+	hib_wait_on_bio_chain();
+	return 0;
 }
 
 /**
diff --git a/kernel/power/block_io.h b/kernel/power/block_io.h
index ac378c5..1482060 100644
--- a/kernel/power/block_io.h
+++ b/kernel/power/block_io.h
@@ -9,7 +9,7 @@
 /* Low level routines */
 int hib_bio_read_page(pgoff_t page_off, void *addr, int sync);
 int hib_bio_write_page(pgoff_t page_off, void *addr, int sync);
-int hib_wait_on_bio_chain(void);
+void hib_wait_on_bio_chain(void);
 
 unsigned int hib_bio_overhead(unsigned int nr_pages);
 sector_t hib_get_first_sector(void);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 3c11987..9525b9c 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -156,7 +156,7 @@ extern struct block_device *hib_resume_bdev;
 
 extern int hib_bio_read_page(pgoff_t page_off, void *addr, int sync);
 extern int hib_bio_write_page(pgoff_t page_off, void *addr, int sync);
-extern int hib_wait_on_bio_chain(void);
+extern void hib_wait_on_bio_chain(void);
 
 struct timeval;
 /* kernel/power/swsusp.c */
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 178fd31..0a9715b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -233,7 +233,6 @@ static int save_image(struct snapshot_handle *snapshot,
 	unsigned int m;
 	int ret;
 	int nr_pages;
-	int err2;
 	struct timeval start;
 	struct timeval stop;
 	int mps;
@@ -257,11 +256,9 @@ static int save_image(struct snapshot_handle *snapshot,
 		nr_pages++;
 	}
 	compress_write_finish(flags);
-	err2 = hib_wait_on_bio_chain();
+	hib_wait_on_bio_chain();
 	do_gettimeofday(&stop);
 	if (!ret)
-		ret = err2;
-	if (!ret)
 		printk(KERN_CONT "\b\b\b\bdone\n");
 	else
 		printk(KERN_CONT "\n");
@@ -338,7 +335,6 @@ static int load_image(struct snapshot_handle *snapshot,
 	int error = 0;
 	struct timeval start;
 	struct timeval stop;
-	int err2;
 	unsigned nr_pages;
 	int mps;
 
@@ -357,17 +353,13 @@ static int load_image(struct snapshot_handle *snapshot,
 		if (error)
 			break;
 		if (snapshot->sync_read)
-			error = hib_wait_on_bio_chain();
-		if (error)
-			break;
+			hib_wait_on_bio_chain();
 		if (!(nr_pages % m))
 			printk("\b\b\b\b%3d%%", nr_pages / m);
 		nr_pages++;
 	}
-	err2 = hib_wait_on_bio_chain();
+	hib_wait_on_bio_chain();
 	do_gettimeofday(&stop);
-	if (!error)
-		error = err2;
 	if (!error) {
 		printk("\b\b\b\bdone\n");
 		snapshot_write_finalize(snapshot);
-- 
1.7.0.4
