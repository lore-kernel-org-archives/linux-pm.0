Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387032B111;
	Fri,  2 Oct 2026 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912537; cv=none; b=K05jCcijvNzE66zrkHiJxc9sfg7wnedeCeBz5edhzlnbJ1YOi0iIESnrdOdw+VFHoBdjl8BS2v3NSgwoZmFuG7sfCJS0wT+OoE4tOWMbHbJlZ6vR4Qx03cLi7GquA72mxKkQE2Nu+1yHsAOBcuRu0aS78oib0/OS5SPnRBaXq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912537; c=relaxed/simple;
	bh=jKJLpPssFjf57DjbZxnJNzXvMSNNG6bDLx9x+CyQcto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5JZ3GTqzHhChR4sfuuDSOX1tUUxlyA/fYaFhd143R50EjQa4Ft+yEaTdL/KtHlq9QXzQe0ywl7iPddz0FWqiyFGSPAiBRwovgZD48IgvW9qp2bp6GTKDm5u9SCwz3c7c4hd+R5/E3hO7pvVwmKwJdSPfN9NQWkV6RMDLyhMCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cdbb644be1311f19a56ed5b684f684d-20261002
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:52b77540-348f-496b-b078-7b80fef0154a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:bb1faf46b69f393ca1b3855d18e20eae,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3cdbb644be1311f19a56ed5b684f684d-20261002
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1806893815; Fri, 02 Oct 2026 11:42:05 +0800
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	james.morse@arm.com,
	hch@lst.de
Cc: will.deacon@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiong Xin <xiongxin@kylinos.cn>
Subject: [PATCH v3 2/4] PM: hibernate: do not free the image in place while restore I/O is in flight
Date: Fri,  2 Oct 2026 11:41:58 +0800
Message-Id: <20261002034200.920546-3-xiongxin@kylinos.cn>
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

snapshot_write_next() calls swsusp_free() to release all snapshot pages
when one of its internal allocations fails, in prepare_image(),
get_buffer() or get_highmem_page_buffer().  At that point read bios
submitted by load_image() or load_compressed_image() may still be in
flight: the bios do not take page references, so nothing prevents the
freed pages from being handed out again while the device is still
writing the image data into them.

Drop the in-place releases and let the error paths of
load_image_and_restore() and hibernate() free the image, after
swsusp_read() has drained the batch.

Fixes: 343df3c79c62 ("suspend: simplify block I/O handling")
Assisted-by: GLM:glm-5.3
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

New in v3: without it, patch 4 could touch snapshot pages that this
in-place release has already freed.
 kernel/power/snapshot.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index b209712cb2c3..244f4a19c025 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2520,10 +2520,8 @@ static void *get_highmem_page_buffer(struct page *page,
 	 * use a "safe" page frame to store the loaded page.
 	 */
 	pbe = chain_alloc(ca, sizeof(struct highmem_pbe));
-	if (!pbe) {
-		swsusp_free();
+	if (!pbe)
 		return ERR_PTR(-ENOMEM);
-	}
 	pbe->orig_page = page;
 	if (safe_highmem_pages > 0) {
 		struct page *tmp;
@@ -2702,7 +2700,6 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	return 0;
 
  Free:
-	swsusp_free();
 	return error;
 }
 
@@ -2737,10 +2734,8 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 	 * use a "safe" page frame to store the loaded page.
 	 */
 	pbe = chain_alloc(ca, sizeof(struct pbe));
-	if (!pbe) {
-		swsusp_free();
+	if (!pbe)
 		return ERR_PTR(-ENOMEM);
-	}
 	pbe->orig_address = page_address(page);
 	pbe->address = __get_safe_page(ca->gfp_mask);
 	if (!pbe->address)
-- 
2.25.1

