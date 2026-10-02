Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BCA304BDF;
	Fri,  2 Oct 2026 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912538; cv=none; b=f4K3Z+Am1wnR637GFsSdySxPdIv8ipZ5GXhT8RCi0sOBkq0GAGou3P2WpKKO6fN3eimwWQTi4dNcyc/zNup/0G3isBiVhA3KKMle9M/zBvVP5SXHYemt1ZxxV/WZLv6CEmdHhaaJIy0zTA3pBu/KXo8DaIvpQZJ6J0lpIn+sFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912538; c=relaxed/simple;
	bh=r0PebhUK6DISHy9k/VcZvjC/dQ3MIhf0s5jytEN8utA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCPLjlDUTK3FiNp7NKUGNF5+f/eGHmr7oMVURz/eOAxw7B64N55Pyk6McR7THlYBHF148QkmscNdGEZa8nc2mrYaoyKUaSItVxDqtkIZvrvvcdlAJhljSupvBUsqEjA4SpSvBLib/EtJ2D1xIj0ZxqLjuzMZJfNEzC//z3FIh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d74b592be1311f19a56ed5b684f684d-20261002
X-CID-CACHE: Type:Local,Time:202610021138+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:362115e7-63df-48a2-9169-a6773592c685,IP:0,U
	RL:70,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:95
X-CID-META: VersionHash:7db8b62,CLOUDID:fc30afa5dd3474a643cbda0d816da66c,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:11|14|95|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN,TF_CID_SPAM_UPP
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d74b592be1311f19a56ed5b684f684d-20261002
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1429797258; Fri, 02 Oct 2026 11:42:06 +0800
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	james.morse@arm.com,
	hch@lst.de
Cc: will.deacon@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Xin <xiongxin@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v3 4/4] PM: hibernate: flush icache for restored pages from task context
Date: Fri,  2 Oct 2026 11:42:00 +0800
Message-Id: <20261002034200.920546-5-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261002034200.920546-1-xiongxin@kylinos.cn>
References: <20261002034200.920546-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With `hibernate=nocompress`, load_image() submits read bios asynchronously
and hib_end_io() completes them from hardirq/softirq context.  The
commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
restored in-place") calls flush_icache_range() there, which on ARM64 ends
kick_all_cpus_sync() and so triggers

    WARN_ON_ONCE(!in_task());

in smp_call_function(), as in_task() is always false in interrupt context.

Only the nocompress path is affected: load_compressed_image() flushes from
the decompression kthread, in task context.

Defer the flush to task context.  hib_end_io() now only records the
restored page on a per-batch list (page->lru is free to use, as safe
in-place pages are on no LRU).  Once hib_wait_io() returns to load_image(),
hib_flush_icache_pages() walks the list and flushes each page, preserving
the asynchronous batched I/O throughput.

Fixes: f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages restored in-place")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260926032416.467937-1-xiongxin%40kylinos.cn
Assisted-by: GLM:glm-5.3
Acked-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

Changes in v2:

- Polish the commit message and drop the embedded call trace.

Changes in v3, addressing review feedback from sashiko:

- Take icache_lock with spin_lock_irqsave()/spin_unlock_irqrestore():
  hib_end_io() can also be called from task context when submit_bio()
  completes a bio inline (e.g. on error), and a plain spin_lock() held
  there could deadlock against a hardirq/softirq completion of another
  bio of the same batch on the same CPU.
- Drop the hib_wait_io() error check in load_image() that became
  unreachable after adding the in-block break.
- Move the clean_pages_on_read reset to 1/4 and rebase on the new
  2/4 and 3/4, which keep the restored pages alive until the batch
  has been drained.
 kernel/power/swap.c | 47 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 571aefaf09f4..fb26f1376b92 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -223,6 +223,8 @@ struct hib_bio_batch {
 	wait_queue_head_t	wait;
 	blk_status_t		error;
 	struct blk_plug		plug;
+	struct list_head	icache_pages;
+	spinlock_t		icache_lock;
 };
 
 static void hib_init_batch(struct hib_bio_batch *hb)
@@ -230,6 +232,8 @@ static void hib_init_batch(struct hib_bio_batch *hb)
 	atomic_set(&hb->count, 0);
 	init_waitqueue_head(&hb->wait);
 	hb->error = BLK_STS_OK;
+	INIT_LIST_HEAD(&hb->icache_pages);
+	spin_lock_init(&hb->icache_lock);
 	blk_start_plug(&hb->plug);
 }
 
@@ -242,6 +246,7 @@ static void hib_end_io(struct bio *bio)
 {
 	struct hib_bio_batch *hb = bio->bi_private;
 	struct page *page = bio_first_page_all(bio);
+	unsigned long flags;
 
 	if (bio->bi_status) {
 		pr_alert("Read-error on swap-device (%u:%u:%Lu)\n",
@@ -249,11 +254,19 @@ static void hib_end_io(struct bio *bio)
 			 (unsigned long long)bio->bi_iter.bi_sector);
 	}
 
-	if (bio_data_dir(bio) == WRITE)
+	if (bio_data_dir(bio) == WRITE) {
 		put_page(page);
-	else if (clean_pages_on_read)
-		flush_icache_range((unsigned long)page_address(page),
-				   (unsigned long)page_address(page) + PAGE_SIZE);
+	} else if (clean_pages_on_read) {
+		/*
+		 * Stash the page on the batch list, load_image()
+		 * will flush it once hib_wait_io() has returned to task
+		 * context. The page is neither on an LRU nor in the page
+		 * cache, so its lru member is free to use as link node.
+		 */
+		spin_lock_irqsave(&hb->icache_lock, flags);
+		list_add(&page->lru, &hb->icache_pages);
+		spin_unlock_irqrestore(&hb->icache_lock, flags);
+	}
 
 	if (bio->bi_status && !hb->error)
 		hb->error = bio->bi_status;
@@ -295,6 +308,23 @@ static int hib_wait_io(struct hib_bio_batch *hb)
 	return blk_status_to_errno(hb->error);
 }
 
+/*
+ * Flush the icache for pages restored since the last hib_wait_io().
+ * Must be called from task context (after hib_wait_io() returned): all
+ * bios of the batch have completed, so the icache_pages list is no longer
+ * touched by hib_end_io() and can be walked without the lock.
+ */
+static void hib_flush_icache_pages(struct hib_bio_batch *hb)
+{
+	struct page *page, *tmp;
+
+	list_for_each_entry_safe(page, tmp, &hb->icache_pages, lru) {
+		list_del_init(&page->lru);
+		flush_icache_range((unsigned long)page_address(page),
+				   (unsigned long)page_address(page) + PAGE_SIZE);
+	}
+}
+
 /*
  * Saving part
  */
@@ -1116,10 +1146,12 @@ static int load_image(struct swap_map_handle *handle,
 		ret = swap_read_page(handle, data_of(*snapshot), &hb);
 		if (ret)
 			break;
-		if (snapshot->sync_read)
+		if (snapshot->sync_read) {
 			ret = hib_wait_io(&hb);
-		if (ret)
-			break;
+			if (ret)
+				break;
+			hib_flush_icache_pages(&hb);
+		}
 		if (!(nr_pages % m))
 			pr_info("Image loading progress: %3d%%\n",
 				nr_pages / m * 10);
@@ -1134,6 +1166,7 @@ static int load_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret) {
+		hib_flush_icache_pages(&hb);
 		pr_info("Image loading done\n");
 		ret = snapshot_write_finalize(snapshot);
 		if (!ret && !snapshot_image_loaded(snapshot))
-- 
2.25.1

