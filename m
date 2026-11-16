Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800798;
	b=m04OWKrwKsVONHGWdGXCnoezIckug6az3hGkjEcGBaiApgb5rLJ7m+Rst3VsyVkWef3s
	 Kke84qck99kQvg8fhOIgxkdjplfQ+N9cgC81T05P9/Ge+f1r4zPxXe+LK7HyFwjv94Lnv
	 +YL1+xcdSErILP0TgVaD4QevLBGotgnYiP9BXY3QirkQpIvcbVaY/WWFuOqtvW6CmDVSJ
	 8XI2HYdO/FykvngZsQmYh3/nJ3i862c22CQGimGiRdi1aWTPSjk+RYPzxY0WUtBLkE7jv
	 Nr4YbjFEbYZoV58NjQ/r1X27mJOHWvj8NvuFTgZdcFQqAMRFs+6vAJzNO+Rqq54fJxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800798;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=b6RD3UyUWO6jdAB/aup5gjBOCU2fzTMfkputdTNgGe0=;
	b=SQY1skKnemVwIykdUIyOGT1lGYpaE5mxF06Fv9sNBU5G6NU8xU30fDIH5IOm7NbVCiUr
	 5osvu6fk+hrAp5dlJAPUcl/f5tlIPpMS3nKn2jkIat4TyCu/izU5JHKH8cGeMGcgCY6JV
	 WazUeW41byYg1ZA9ZC/zWbu6zIlZz5UtXvHvqwW8ZmK6giQu10iw7meGFC0CEEvdxDksF
	 nfocti4Ip+FXgGJk83YEpuwaLLTY+RXlRcldPpq44SCpdq5uOAx/wyMj2me1ASa2ewVmP
	 mS06UvWmxAzNXGFzl5BqCVSDefC9a1cqS38qIjVfBzNi7Vv5d9pCSiNm9OEnhG+/S+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4E606A331;
	Mon, 16 Nov 2026 03:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AE4E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4e272084e17011f19a56ed5b684f684d-20261116
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
X-CID-O-INFO: VERSION:1.3.19,REQID:5ed18e32-2b59-4c65-8377-b91360d2bc02,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.19,REQID:5ed18e32-2b59-4c65-8377-b91360d2bc02,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:7db8b62,CLOUDID:be18f76374c846865c8ddbf8cccc280c,BulkI
	D:261116114632QPQLJMO0,BulkQuantity:0,SF:10|38|66|78|81|82|102|127|136|153
	|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e272084e17011f19a56ed5b684f684d-20261116
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(175.2.56.187)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1646995334; Mon, 16 Nov 2026 11:46:28 +0800
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
Subject: [PATCH v4 3/4] PM: hibernate: drain pending reads in compressed image load errors
Date: Mon, 16 Nov 2026 11:46:18 +0800
Message-Id: <20261116034619.36218-4-xiongxin@kylinos.cn>
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

The error exits of load_compressed_image() free the ring buffer pages
without waiting for the read bios that may still be in flight: when a
read or decompression error aborts the load mid-round, the device can
still be writing into pages that are handed back to the allocator by
out_clean().

save_compressed_image() and load_image() both drain the batch on their
way out; add the same wait here, which also folds the error of any
in-flight read into the return value instead of dropping it.

Fixes: 343df3c79c62 ("suspend: simplify block I/O handling")
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

New in v3: the compressed loader had the same missing drain on its
error exits, freeing the ring pages under in-flight reads.
 kernel/power/swap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 7f3cc2cc5cca..571aefaf09f4 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1204,6 +1204,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	int ret = 0;
 	int eof = 0;
 	struct hib_bio_batch hb;
+	int err2;
 	ktime_t start;
 	ktime_t stop;
 	unsigned nr_pages;
@@ -1482,11 +1483,14 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	}
 
 out_finish:
+	err2 = hib_wait_io(&hb);
 	if (crc->run_threads) {
 		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 	stop = ktime_get();
+	if (!ret)
+		ret = err2;
 	if (!ret) {
 		pr_info("Image loading done\n");
 		ret = snapshot_write_finalize(snapshot);
-- 
2.25.1

