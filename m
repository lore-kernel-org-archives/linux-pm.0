From: Ming Lin <mlin@kernel.org>
Subject: [PATCH v3 4/4] PM: submit bio in a sane way in cases without bio_chain
Date: Thu, 23 Apr 2015 16:04:35 -0700
Message-ID: <1429830275-6792-5-git-send-email-mlin@kernel.org>
References: <1429830275-6792-1-git-send-email-mlin@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1429830275-6792-1-git-send-email-mlin@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Jens Axboe <axboe@kernel.dk>, Dongsu Park <dongsu.park@profitbricks.com>, linux-pm@vger.kernel.org, Ming Lin <mlin@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

Make bio submission in kernel/power/block_io.c to properly submit
bios also when bio_chain is not available. In that case, it's not
necessary to handle refcount with bio_get(), but it's saner to simply
call a predefined helper submit_bio_wait(). So call bio_get() only
when bio_chain is given.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-pm@vger.kernel.org
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
[dpark: add more description in commit message]
Signed-off-by: Dongsu Park <dongsu.park@profitbricks.com>
Signed-off-by: Ming Lin <mlin@kernel.org>
---
 kernel/power/block_io.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index 9a58bc2..7206408 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -34,7 +34,6 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
 	bio = bio_alloc(__GFP_WAIT | __GFP_HIGH, 1);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_bdev = bdev;
-	bio->bi_end_io = end_swap_bio_read;
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		printk(KERN_ERR "PM: Adding page to bio failed at %llu\n",
@@ -44,15 +43,29 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
 	}
 
 	lock_page(page);
-	bio_get(bio);
 
 	if (bio_chain == NULL) {
-		submit_bio(bio_rw, bio);
-		wait_on_page_locked(page);
+		int err = submit_bio_wait(bio_rw, bio);
+
+		if (err) {
+			SetPageError(page);
+			ClearPageUptodate(page);
+			pr_alert("Read-error on swap-device (%u:%u:%llu)\n",
+				 imajor(bio->bi_bdev->bd_inode),
+				 iminor(bio->bi_bdev->bd_inode),
+				 (unsigned long long)bio->bi_iter.bi_sector);
+		} else {
+			SetPageUptodate(page);
+		}
+
 		if (rw == READ)
-			bio_set_pages_dirty(bio);
+			set_page_dirty_lock(page);
+		unlock_page(page);
 		bio_put(bio);
 	} else {
+		bio->bi_end_io = end_swap_bio_read;
+		bio_get(bio);
+
 		if (rw == READ)
 			get_page(page);	/* These pages are freed later */
 		bio->bi_private = *bio_chain;
-- 
1.9.1
