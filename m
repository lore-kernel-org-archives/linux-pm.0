Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800799;
	b=TdeXunTImKlJqFxg3FplNzrv051I3QzR0BpQRv6uHPkQuc+bPxOzh2ezRZZyuZ1iQ3XT
	 Hw3BK0OOWoNt3jjq+ttjxQM4cUUkj+rnomRU7EHo9AD/V/uRtu9b0CTXBSmJSinAz8bqk
	 RE5anl1jUDWQngD1tFHlYvXHZtjYEbpWh+nAWHx7NEa9/lSWaug9VZGluBvANSTJgowPa
	 Q+39l6XQkaJemvricsLNeEXRShHyPVvOMXCJtkvD7ZUE1+SJIjvRbNwAjwRMt0e6eiAia
	 IekByFV+oPzGsVHj4eNfH0d9CkvLcqHeaXXKgoeUBOpu5DXkxf/+5Mk4ayasiPRBtIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800799;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Stdh/TtGG9mB7Y21JIaerURs/KE5o8leSJ5isIeNUYE=;
	b=V3UF+FAR97o+Z5VyTkoCmnnKwcw66utdn0EIqfX3WjwrAu0Pg4mOrtFUH7J3tEvHJ6yf
	 Ofi9uHPLqipn31IYws4G01foaXfXh0LlGtDHCNMPzle9HPzb4IDOAnvG7qhXGz6jqDsSc
	 oOV9qZyYZH2X03CPt9P1qSiRp4mrc1yuvHOCI/aFxDRZoK2jQWfJFVgBTNiofNQClO8pO
	 uv48qHXd0nfdU7AIH2e+mvBuuZtdRCuRisaEFTGEmRfdDLvup9F5zuew4kciSfQMQtqjM
	 572twu0ocbzR0/RH704uIHuDj/W3g/2R3DwJmVzfLMhdr+Bpy+T5x9TZHM1Tx4A1Akg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54B606A889;
	Mon, 16 Nov 2026 03:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A54B606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4dbe2854e17011f19a56ed5b684f684d-20261116
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c1bfd892-e789-4c21-a45b-91c4041763c5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:c1bfd892-e789-4c21-a45b-91c4041763c5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:40865c35ebd0f8c1e5adeeb19dda8598,BulkI
	D:2611161146327T5QP394,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|153|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4dbe2854e17011f19a56ed5b684f684d-20261116
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(175.2.56.187)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 403710987; Mon, 16 Nov 2026 11:46:28 +0800
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
Subject: [PATCH v4 2/4] PM: hibernate: do not free the image in place while restore I/O is in flight
Date: Mon, 16 Nov 2026 11:46:17 +0800
Message-Id: <20261116034619.36218-3-xiongxin@kylinos.cn>
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
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

New in v3: without it, patch 4 could touch snapshot pages that this
in-place release has already freed.
 kernel/power/snapshot.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d5dba0e50b2e..cbe051643a9c 100644
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

