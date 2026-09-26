Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96893090E8;
	Sat, 26 Sep 2026 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790393080; cv=none; b=ANnjCEqMz9K8IIQFFTi8ZsfGF0a619jb1SdbZkoa5lbl8iylW6MFlRFt1uZw4MgwsgH2a7SoKzUOoZyu4jQRW5DF5JMV8CAgcw+SL3haRxiOFZbXM6vQKuIdlXP/qwZUuT18X7sthhWmWTaV1S61QPlClU6Gxb+QeeOpOqpv62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790393080; c=relaxed/simple;
	bh=u2bKMqmHH9et5bmwCUGc4r3mQCwAL+nmjWrOC5+NGQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSXAKP7piNuBgIiN8TU7LRWwjtnMkAzL3OJf8jN5JL7OK2BXm/iWl33FvtKJrvECtj7tVgH34Z3hfgfh6ThOcDBY44N1J30c8ddQ1cfy1Vn/Bjf/rItIZRDaLP4MqpHnJV0ip/MgzjXyIDkwOVKkVUPd8qIqXBu1rEdK2ohQtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c343442cb95911f19a56ed5b684f684d-20260926
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:da21d866-1b8c-42a3-b086-51ce81a585f3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:5bdde6c24e8d515c24ed0be13df09ffd,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c343442cb95911f19a56ed5b684f684d-20260926
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 204045198; Sat, 26 Sep 2026 11:24:20 +0800
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Xin <xiongxin@kylinos.cn>,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v2] PM: hibernate: flush icache for restored pages from task context
Date: Sat, 26 Sep 2026 11:24:16 +0800
Message-Id: <20260926032416.467937-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With `hibernate=nocompress`, load_image() submits read bios asynchronously
and hib_end_io() completes them from hardirq/softirq context.  Commit
f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages restored
in-place") calls flush_icache_range() there, which on ARM64 ends with
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
Assisted-by: GLM:5.3
Acked-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c78f1593600b..6d1019a2780f 100644
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
 
@@ -249,11 +253,19 @@ static void hib_end_io(struct bio *bio)
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
+		spin_lock(&hb->icache_lock);
+		list_add(&page->lru, &hb->icache_pages);
+		spin_unlock(&hb->icache_lock);
+	}
 
 	if (bio->bi_status && !hb->error)
 		hb->error = bio->bi_status;
@@ -295,6 +307,23 @@ static int hib_wait_io(struct hib_bio_batch *hb)
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
@@ -1116,8 +1145,12 @@ static int load_image(struct swap_map_handle *handle,
 		ret = swap_read_page(handle, data_of(*snapshot), &hb);
 		if (ret)
 			break;
-		if (snapshot->sync_read)
+		if (snapshot->sync_read) {
 			ret = hib_wait_io(&hb);
+			if (ret)
+				break;
+			hib_flush_icache_pages(&hb);
+		}
 		if (ret)
 			break;
 		if (!(nr_pages % m))
@@ -1131,10 +1164,17 @@ static int load_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret) {
+		hib_flush_icache_pages(&hb);
 		pr_info("Image loading done\n");
 		ret = snapshot_write_finalize(snapshot);
 		if (!ret && !snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
+	} else {
+		/*
+		 * Reinit the list instead of walking it to avoid
+		 * use-after-free.
+		 */
+		INIT_LIST_HEAD(&hb.icache_pages);
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
 	return ret;
-- 
2.25.1

