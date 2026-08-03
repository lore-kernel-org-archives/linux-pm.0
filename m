Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71025B0B3
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736474; cv=none; b=X8BSoj6ZpHNKMSzvYscQi+VboDXsTXq1rhva9y786Nkq6WeJzZrvJw2oppyze8sqRSVepIkfvWQv3pSlMKRvkrJ4wAlZaRENb3KlMyygHaqVvmmJdqJOz9OabfV36YDkgOYTxpPRqNRQR9WKLshIT9SSc1A3cMSBvK4+68HQpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736474; c=relaxed/simple;
	bh=8I32DuevIxpDGk0rBhyOs9Rcf6NAd9pmc8hqltENfB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sYN6j7myRQ7d7rc9eg6fjMCVvREb+ekofC+n5xEsC0RtygcCqes8lrEmzori46jZcvZk1koKGt0VLTyWyRXd4H66JBrG2qV4T679ubTVhr79i17SW6OqyuNMbur5dZpl8rNNxY1qMiWFMBcpv5ZKXtPgsANvHBqfMSLRlKQzG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c45261d88eff11f1aa26b74ffac11d73-20260803
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c6ea6ec1-e518-46e4-b5c4-fa6a2d11cf2a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:c6ea6ec1-e518-46e4-b5c4-fa6a2d11cf2a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:662e726180efa697c96b83bcad0b836b,BulkI
	D:2608031347567GBH1KBE,BulkQuantity:1,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c45261d88eff11f1aa26b74ffac11d73-20260803
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(175.2.45.188)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1818191233; Mon, 03 Aug 2026 13:54:18 +0800
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	will@kernel.org,
	james.morse@arm.com
Cc: linux-pm@vger.kernel.org,
	Xiong Xin <xiongxin@kylinos.cn>,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH] PM: hibernate: flush icache for restored pages from task context
Date: Mon,  3 Aug 2026 13:54:12 +0800
Message-Id: <20260803055412.63981-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When resuming from hibernation with `hibernate=nocompress`, the kernel
loads the image via load_image(), which submits read bios asynchronously
and waits on them with hib_wait_io(). The bio completion callback
hib_end_io() runs from the block IRQ/softirq path.

Commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
restored in-place") added a flush_icache_range() call inside hib_end_io()
(under clean_pages_on_read). On architectures such as ARM64,
flush_icache_range() ends with kick_all_cpus_sync() -> smp_call_function()
(wait=1), which contains:

    WARN_ON_ONCE(!in_task());

Because hib_end_io() executes in hardirq/softirq context, in_task() is
always false there, and the WARN fires which happens while the resume
task is asleep in hib_wait_io() and the CPU is idle, the warning log as
follows:

[  182.265661] PM: Loading image data pages (286403 pages)...
[  182.265670] hibernate: Hibernated on CPU 0 [mpidr:0x0]
[  182.267762] ------------[ cut here ]------------
[  182.267767] WARNING: kernel/smp.c:844 at smp_call_function_many_cond+0x78c/0xa08, CPU#2: swapper/2/0
[  182.298749] Modules linked in: btrfs xor libblake2b raid6_pq ufs qnx4 hfsplus hfs minix ntfs msdos jfs nls_ucs2_utils xfs st xfrd
[  182.353702] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 7.2.0-rc5-generic #2 PREEMPT(lazy)
...
[  182.372630] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  182.379578] pc : smp_call_function_many_cond+0x78c/0xa08
[  182.384877] lr : kick_all_cpus_sync+0x50/0xa8
[  182.389221] sp : ffff800083cabc30
[  182.392522] x29: ffff800083cabc30 x28: ffff002002322ac0 x27: ffff001f8bb5a000
[  182.399646] x26: ffff80008351ddb8 x25: 0000000000000002 x24: 0000000000000000
[  182.406770] x23: ffff80008351d000 x22: 0000000000000001 x21: 0000000000000001
[  182.413892] x20: 0000000000000000 x19: 0000000000000000 x18: ffff800083c95068
[  182.421015] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  182.428138] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  182.435261] x11: 00000000000000c0 x10: 0000000000000000 x9 : ffff80008027bd38
[  182.442384] x8 : ffff800083cabe88 x7 : 0000000000000000 x6 : 0000000000000000
[  182.449507] x5 : ffff80008351ddb8 x4 : 0000000000000000 x3 : 0000000000000001
[  182.456630] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000010000
[  182.463753] Call trace:
[  182.466187]  smp_call_function_many_cond+0x78c/0xa08 (P)
[  182.471487]  kick_all_cpus_sync+0x50/0xa8
[  182.475484]  hib_end_io+0x18c/0x270
[  182.478963]  bio_endio+0x1b8/0x320
[  182.482355]  blk_mq_end_request_batch+0x2d8/0x650
[  182.487048]  nvme_pci_complete_batch+0x74/0xb0 [nvme]
[  182.492091]  nvme_irq+0x9c/0xb0 [nvme]
[  182.495830]  __handle_irq_event_percpu+0x64/0x440
[  182.500523]  handle_irq_event+0x58/0x130
[  182.504435]  handle_fasteoi_irq+0x120/0x1b8
[  182.508606]  handle_irq_desc+0x58/0x98
[  182.512344]  generic_handle_domain_irq+0x24/0x50
[  182.516949]  gic_handle_irq+0x19c/0x3a0
[  182.520773]  call_on_irq_stack+0x48/0x68
[  182.524684]  do_interrupt_handler+0xb0/0xc0
[  182.528856]  el1_interrupt+0x4c/0xd8
[  182.532421]  el1h_64_irq_handler+0x1c/0x40
[  182.536506]  el1h_64_irq+0x84/0x88
[  182.539895]  default_idle_call+0x48/0x150 (P)
[  182.544241]  do_idle+0x26c/0x3b0
[  182.547457]  cpu_startup_entry+0x40/0x50
[  182.551367]  secondary_start_kernel+0x130/0x170
[  182.555885]  __secondary_switched+0xc8/0xd0
[  182.560058] ---[ end trace 0000000000000000 ]---

This only affects the nocompress path: the compressed path
(load_compressed_image) sets clean_pages_on_decompress and flushes from
the decompression kthread (task context), so its hib_end_io() never calls
flush_icache_range().

Fix it by deferring the flush to task context. hib_end_io() now only
records the restored page on a per-batch list (using page->lru, which is
free because hibernate safe/in-place pages are neither on an LRU nor in
the page cache). After hib_wait_io() returns to load_image() (task
context, all bios of the batch completed), hib_flush_icache_pages() walks
the list and calls flush_icache_range() on each page. This preserves the
asynchronous batched I/O throughput of the nocompress path.

Fixes: f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages restored in-place")
Acked-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c626e9dc3c1c..7a97f5550124 100644
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
@@ -1106,8 +1135,12 @@ static int load_image(struct swap_map_handle *handle,
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
@@ -1121,10 +1154,17 @@ static int load_image(struct swap_map_handle *handle,
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

