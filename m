Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865439E18E
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456983; cv=none; b=eQMMd7g2QC7R5u/ctNam0MGJA+VfON94I9YDsjoXGigk027uQCIpxuOwTt1rcQARReOVq3GxPyh8NRRDNjygCQCv3r8VR68i1HWQqaIpQ7kqYNvJuYPPEp+DE4CJkLBNgzndpPJapLvF0ssTr9Tj/4tf+hwVcehcR2IgkMxNLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456983; c=relaxed/simple;
	bh=8WL3UZLN2HD4InMbS4x90Y0Es1/RdP71ba0rSBm2A/Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MCUWTBUwKrEdcP00N6jWCEnYUljv6GuxpvC5TR3M9TgrrOLyT/UfRNKCLJHVzSXqTcYRqdC+hjjA2Ss8bVdOe9IE7stSNNSo82ka6oO5kogW1VOwHYyxHObcIMObzWJQI45kd6jbn1ezR7jXKjY18gz+7g3te6BszNB2SbdKPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 844f43825efb11f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:12819140-d1b3-40cc-9fa4-690fc4e11d88,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:cecfe48d945c1c676baadc47478a8abd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 844f43825efb11f1aa26b74ffac11d73-20260603
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2021561886; Wed, 03 Jun 2026 11:22:57 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: Add unlikely annotations to saveable_page()
Date: Wed,  3 Jun 2026 11:22:55 +0800
Message-Id: <20260603032255.2126508-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add unlikely() branch prediction hints to conditions in saveable_page()
that are expected to be false in the common case:

- !page || page_zone(page) != zone: PFN valid implies page exists
- PageOffline(page): offline pages are rare
- PageReserved(page) && (...): reserved pages are relatively uncommon
- page_is_guard(page): guard pages are debug-only and rare

This helps the compiler optimize code layout for the hot path (valid
saveable pages), improving performance during hibernation image creation
when scanning large amounts of memory.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d933b5b2c05d..182f27eb573a 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1380,7 +1380,7 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 		return NULL;
 
 	page = pfn_to_online_page(pfn);
-	if (!page || page_zone(page) != zone)
+	if (unlikely(!page || page_zone(page) != zone))
 		return NULL;
 
 	BUG_ON(PageHighMem(page));
@@ -1388,14 +1388,14 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
 		return NULL;
 
-	if (PageOffline(page))
+	if (unlikely(PageOffline(page)))
 		return NULL;
 
-	if (PageReserved(page)
-	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
+	if (unlikely(PageReserved(page)
+	    && (!kernel_page_present(page) || pfn_is_nosave(pfn))))
 		return NULL;
 
-	if (page_is_guard(page))
+	if (unlikely(page_is_guard(page)))
 		return NULL;
 
 	return page;
-- 
2.25.1

