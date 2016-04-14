From: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v1 26/27] kernel/power/swap.c: use bio_get_base_vec()
Date: Thu, 14 Apr 2016 20:02:44 +0800
Message-ID: <1460635375-28282-27-git-send-email-tom.leiming@gmail.com>
References: <1460635375-28282-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460635375-28282-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 kernel/power/swap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 12cd989..cedf752 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -230,7 +230,15 @@ static void hib_init_batch(struct hib_bio_batch *hb)
 static void hib_end_io(struct bio *bio)
 {
 	struct hib_bio_batch *hb = bio->bi_private;
-	struct page *page = bio->bi_io_vec[0].bv_page;
+
+	/*
+	 * Single bvec bio.
+	 *
+	 * For accessing page pointed to by the 1st bvec, it
+	 * works too after multipage bvecs.
+	 */
+	struct bio_vec *bvec = bio_get_base_vec(bio);
+	struct page *page = bvec->bv_page;
 
 	if (bio->bi_error) {
 		printk(KERN_ALERT "Read-error on swap-device (%u:%u:%Lu)\n",
-- 
1.9.1
