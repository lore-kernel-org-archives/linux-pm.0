Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D602EA480;
	Fri,  2 Oct 2026 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912537; cv=none; b=WnnX/GSAG1O+TqCFAVTE1mvTJmeF51rm6rQFfBgGfzZaoTRBW9JPYPmNkAzxrLCz2zFpqcYzZ6/iPsDV+lD8xPwLS20UkASa1ihWqNjonaopFs+oUTlOh1p+UjaJE7e3z2d5U1zBuGcsCGqz595OSUJPp1Cj1gQSX1dqVVtHPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912537; c=relaxed/simple;
	bh=1CZ5hc0ZiNiuFmDQdjFQtKP9+eQjiN2Pw/AX/n4vXtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0vri8xP9RRvPDv7Rrs8rjyfwwUaZ6sucbFSlO3H1iRmVDUxHbGKWgT6sVb2s8Mmp+oJxBWhTfZfVCfUqP3GNLlWt9nfNnx9c7Pg8bPM9pRj07bOu28YdXdsVlAAeja/Rs5x4uyy5rlFNu2ydLJ2YkayJtShlt3e1eEkrxsWewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d115786be1311f19a56ed5b684f684d-20261002
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ff679bfe-fb40-4873-afd9-f77821df3a88,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:1a3e33aeaa9f0afb7f6f9f34456ce186,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d115786be1311f19a56ed5b684f684d-20261002
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 332736694; Fri, 02 Oct 2026 11:42:06 +0800
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
Subject: [PATCH v3 3/4] PM: hibernate: drain pending reads in compressed image load errors
Date: Fri,  2 Oct 2026 11:41:59 +0800
Message-Id: <20261002034200.920546-4-xiongxin@kylinos.cn>
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

The error exits of load_compressed_image() free the ring buffer pages
without waiting for the read bios that may still be in flight: when a
read or decompression error aborts the load mid-round, the device can
still be writing into pages that are handed back to the allocator by
out_clean().

save_compressed_image() and load_image() both drain the batch on their
way out; add the same wait here, which also folds the error of any
in-flight read into the return value instead of dropping it.

Fixes: 343df3c79c62 ("suspend: simplify block I/O handling")
Assisted-by: GLM:glm-5.3
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

