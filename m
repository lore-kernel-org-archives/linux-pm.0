Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FE40099E
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442238; cv=none; b=kwftJY/GJplo1HhzDbWtFbctyCuHivm3E5hLNH1VpccOMCv62NpPpehFYQI4m4itszlg8LFKsPfXx2srAQpLLtuWN8dPoDhjpl5Qv4Zr06pI8vCmPjrLoWFLuK/DATOzDpHfaziv3xW5NTcp0bxnbI/AQ5tD0CFImXgv0AS/m7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442238; c=relaxed/simple;
	bh=BRmmXovbYBoA3H3MHYRf27sT89yvpKKcusCv4uR14XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/cjk9iFr2B4s1hYlOiBWnkpiZFnGtjoSGDAoY/13S7Q9jU8HjhvILdT7j1OzaM0VbaLbT79T7U/97EQEIZPTqwrBcp954fwDdEvojIygVypqHpy6eyRSwuicJye6c+dXUKnJTixREiHcCvuFtpvPEFeJNIWOuAv4bwpmD1EVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:08 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	her0gyugyu@gmail.com,
	youngjun.park@lge.com,
	taejoon.song@lge.com
Subject: [RFC PATCH 08/10] PM: hibernate: read the image back a run at a time
Date: Tue, 15 Sep 2026 12:16:56 +0900
Message-Id: <20260915031658.1505680-9-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915031658.1505680-1-youngjun.park@lge.com>
References: <20260915031658.1505680-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write side now builds one bio per contiguous run.  The read side
still submits a bio per page.

The image is read in the order it was written, so the offsets arrive
in the same runs.  Fill the batch for reads the same way as for
writes.

The compressed path queues reads ahead and then waits on the reads or
on its threads.  Submit the queued reads before those waits, so the
last of them do not wait for more reads to fill the bio.

Reading a 5G image without compression on a VM took 9 to 10% less
time.

Assisted-by: Claude:claude-fable-5
Assisted-by: Claude:claude-opus-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 kernel/power/swap.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 34e47c662798..f2fc8495ddf8 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -252,7 +252,7 @@ struct hib_bio_batch {
 	wait_queue_head_t	wait;
 	blk_status_t		error;
 	struct blk_plug		plug;
-	struct bio		*cur;		/* write bio still being filled */
+	struct bio		*cur;		/* the bio still being filled */
 	unsigned int		max_pages;	/* what the device takes at once */
 	unsigned int		nr_pages;	/* what the next bio is sized for */
 };
@@ -308,7 +308,7 @@ static void hib_end_io(struct bio *bio)
 			 (unsigned long long)bio->bi_iter.bi_sector);
 	}
 
-	/* A write bio carries as many pages as the image was contiguous for. */
+	/* A bio carries as many pages as the image was contiguous for. */
 	bio_for_each_segment_all(bv, bio, iter_all) {
 		struct page *page = bv->bv_page;
 
@@ -334,19 +334,18 @@ static int hib_submit_io_sync(blk_opf_t opf, pgoff_t page_off, void *addr)
 }
 
 /*
- * The image goes out a page at a time.  Keep filling one bio for as long as
- * the next page lands right after the last, so that pages that are
- * consecutive on the device reach it as one request rather than as many that
- * the block layer then has to merge.
+ * The image moves a page at a time in either direction.  Keep filling one bio
+ * for as long as the next page lands right after the last, so that pages that
+ * are consecutive on the device reach it as one request rather than as many
+ * that the block layer then has to merge.
  */
 static int hib_submit_io_async(blk_opf_t opf, pgoff_t page_off, void *addr,
 			 struct hib_bio_batch *hb)
 {
 	sector_t sector = page_off * (PAGE_SIZE >> 9);
-	bool write = op_is_write(opf);
 	struct bio *bio;
 
-	if (write && hb->cur) {
+	if (hb->cur) {
 		bool contiguous = bio_end_sector(hb->cur) == sector;
 
 		if (contiguous && hb->cur->bi_vcnt < hb->cur->bi_max_vecs) {
@@ -367,21 +366,13 @@ static int hib_submit_io_async(blk_opf_t opf, pgoff_t page_off, void *addr,
 		hib_submit_cur(hb);
 	}
 
-	bio = bio_alloc(file_bdev(hib_resume_bdev_file),
-			write ? hb->nr_pages : 1, opf,
+	bio = bio_alloc(file_bdev(hib_resume_bdev_file), hb->nr_pages, opf,
 			GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = sector;
 	bio_add_virt_nofail(bio, addr, PAGE_SIZE);
 	bio->bi_end_io = hib_end_io;
 	bio->bi_private = hb;
-
-	if (write) {
-		hb->cur = bio;
-		return 0;
-	}
-
-	atomic_inc(&hb->count);
-	submit_bio(bio);
+	hb->cur = bio;
 	return 0;
 }
 
@@ -1477,6 +1468,12 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		asked += i;
 		want -= i;
 
+		/*
+		 * Submit the reads queued above now.  Otherwise the last of
+		 * them can wait in the bio until more reads fill it.
+		 */
+		hib_submit_cur(&hb);
+
 		/*
 		 * We are out of data, wait for some more.
 		 */
-- 
2.48.1

