Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800797;
	b=Hb1AaGs09ber+es9gcxrUGSvAp53KLmfQIvSYFxdMgXy/RM6LEGCcReGpNsXn8hdv/rc
	 WmHjyJe+2I4TtM87bSsVYEGsknLjcB3Gy/DjASI3rU6yCU/CD0P2hTZMuK18m87eU00wB
	 fRpTa555g2KzReK/J4+4tGO8ZuOvJV8oUAJqkhSK5xYRIlro3uR13V4IbJD79axrPy2Ki
	 KTro30QH3MrbJWtIHvWClAbWPtrDJi9cHKo8E1QF6CdR0jfcnwtA+qY03M4GEuwMCjQey
	 bkABdRD2cEFk7Xxz4wGc9SKuRLyOSt/TDp2x6GAZUPjsQ4Lw1+GnaZ9E4Ta/WL6bpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800797;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2A5t0ONI7IaIjMnCj2YskkeywEfhopiL1ZV70Pfvk8s=;
	b=LfvuAT6gqjtGxsdYmleAHzqnmHewHKAOAMD4gwLaSxbZXpS1858mnmx7caqunzFaqwbU
	 mpbJHAk27fRsOm9ME273Mx+ejh8rNYI7gOR4Dydkd51kp8hOC+i4VybR7Oz2qbc2RJgvp
	 9AU821GgcroZlUn90oNObiDc+jwOH0JIQZMFFj8c0Sru3btnQLh9L7sleObzqPz2fmHQJ
	 7Fk3PunRuUHVAhvT5hwYjyejzSCH0qL7Stg+fMBUXMoTrnQ768RbHFkLo/8TWUfhVOvml
	 gsl9Bf9yjS17i+UTsUQrMkokxrXUN8F7CLJZom+Gj6q4MeN+Ev5EtmNSb0aikh8tV5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F0606A321;
	Mon, 16 Nov 2026 03:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A5F0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4e9ff4c8e17011f19a56ed5b684f684d-20261116
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:80263444-d9f5-4e4e-9782-35bd9705b93b,IP:10,
	URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:80263444-d9f5-4e4e-9782-35bd9705b93b,IP:10,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:646adadb829665bad7c155de3639e34f,BulkI
	D:2611161146298DYOR7A1,BulkQuantity:1,SF:10|38|66|78|81|82|102|127|136|153
	|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:11|94|82|1,Fi
	le:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,D
	KR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e9ff4c8e17011f19a56ed5b684f684d-20261116
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(175.2.56.187)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 430389582; Mon, 16 Nov 2026 11:46:29 +0800
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
Subject: [PATCH v4 4/4] PM: hibernate: flush icache for restored pages from task context
Date: Mon, 16 Nov 2026 11:46:19 +0800
Message-Id: <20261116034619.36218-5-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116034619.36218-1-xiongxin@kylinos.cn>
References: <20261116034619.36218-1-xiongxin@kylinos.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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
Acked-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

Changes in v2:
- Polish the commit message and drop the embedded call trace.

Changes in v3, addressing review feedback from sashiko:
- Take icache_lock with spin_lock_irqsave()/spin_unlock_irqrestore().
- Drop the hib_wait_io() error check that became unreachable.
- Move the clean_pages_on_read reset to 1/4, rebase on 2/4 and 3/4.

Changes in v4, addressing review feedback from sashiko:
- Add a cond_resched() to the flush loop: with the batched I/O the
  final drain can walk a multi-gigabyte image in one go, and on ARM64
  each flush_icache_range() broadcasts an IPI, which is long enough
  to upset the softlockup watchdog and RCU.
 kernel/power/swap.c | 49 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 571aefaf09f4..01b67293a981 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -23,6 +23,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/pm.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/cpumask.h>
@@ -223,6 +224,8 @@ struct hib_bio_batch {
 	wait_queue_head_t	wait;
 	blk_status_t		error;
 	struct blk_plug		plug;
+	struct list_head	icache_pages;
+	spinlock_t		icache_lock;
 };
 
 static void hib_init_batch(struct hib_bio_batch *hb)
@@ -230,6 +233,8 @@ static void hib_init_batch(struct hib_bio_batch *hb)
 	atomic_set(&hb->count, 0);
 	init_waitqueue_head(&hb->wait);
 	hb->error = BLK_STS_OK;
+	INIT_LIST_HEAD(&hb->icache_pages);
+	spin_lock_init(&hb->icache_lock);
 	blk_start_plug(&hb->plug);
 }
 
@@ -242,6 +247,7 @@ static void hib_end_io(struct bio *bio)
 {
 	struct hib_bio_batch *hb = bio->bi_private;
 	struct page *page = bio_first_page_all(bio);
+	unsigned long flags;
 
 	if (bio->bi_status) {
 		pr_alert("Read-error on swap-device (%u:%u:%Lu)\n",
@@ -249,11 +255,19 @@ static void hib_end_io(struct bio *bio)
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
@@ -295,6 +309,24 @@ static int hib_wait_io(struct hib_bio_batch *hb)
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
+		cond_resched();
+	}
+}
+
 /*
  * Saving part
  */
@@ -1116,10 +1148,12 @@ static int load_image(struct swap_map_handle *handle,
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
@@ -1134,6 +1168,7 @@ static int load_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret) {
+		hib_flush_icache_pages(&hb);
 		pr_info("Image loading done\n");
 		ret = snapshot_write_finalize(snapshot);
 		if (!ret && !snapshot_image_loaded(snapshot))
-- 
2.25.1

