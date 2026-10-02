Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7B31D362;
	Fri,  2 Oct 2026 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912537; cv=none; b=i6Qo8PNJclc1mugsOtRHLStXEfxAvpjNqLEgg2OUr/b2DRkNuN84JFiRdursdHfREr5vWSF3mVRkW2INfPdxxOeUQN+wg65uoktcg1VYMJs0gQyglypQaAQ3dT1sddXSfYapnuJkVPNaKwNlWaUnmwx4jV3hhoLdsN/HJAHPOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912537; c=relaxed/simple;
	bh=dTkh+S7kQ6fMQ6FdAL/V5OFqBO95eTN53dUmKW7LHJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jo4jrxbwno6Mh9cnboJhfBQnUF/JCu5LjaNSDDGWsrW4N+qpFMrsGt3TdjHytjna5NeYrmGfmfnRqteKUgNCMR5VtfdnyHLnP8qICABka6KTeyyUp2oCh5WWpW/SlYfL41ECx5ecvFneKIGSTebSTRN3jl5++Zprd74FIQF6uPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3ca5bfd0be1311f19a56ed5b684f684d-20261002
X-CID-CACHE: Type:Local,Time:202610021138+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:28744585-f5d4-4542-b4af-85e804c00e6d,IP:0,U
	RL:70,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:95
X-CID-META: VersionHash:7db8b62,CLOUDID:2facd962f07ac6b4f39243a50558353a,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:5|-100,IP:nil,URL:11|14|95|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN,TF_CID_SPAM_UPP
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3ca5bfd0be1311f19a56ed5b684f684d-20261002
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1616017193; Fri, 02 Oct 2026 11:42:05 +0800
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/4] PM: hibernate: reset clean_pages_on_read after load_image()
Date: Fri,  2 Oct 2026 11:41:57 +0800
Message-Id: <20261002034200.920546-2-xiongxin@kylinos.cn>
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

load_image() sets clean_pages_on_read but nothing clears it.  If a
nocompress resume attempt fails and a compressed resume follows in the
same boot, the stale flag makes hib_end_io() call flush_icache_range()
from interrupt context for the reused ring pages of
load_compressed_image(), triggering the WARN_ON_ONCE(!in_task()) in
smp_call_function() on ARM64.

Reset the flag before load_image() returns, so that it cannot leak
into a later compressed resume.

Also clear it once the load is known to have failed, so that the bios
still in flight do not trigger the same interrupt-context flush during
the final drain.

Fixes: f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages restored in-place")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260926032416.467937-1-xiongxin%40kylinos.cn
Assisted-by: GLM:glm-5.3
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
---

New in v3, split from the single-patch v2 per review feedback from
sashiko, as it also fixes the stale clean_pages_on_read path on its
own; it now also covers the final drain of a failing load.
 kernel/power/swap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c78f1593600b..7f3cc2cc5cca 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1125,6 +1125,9 @@ static int load_image(struct swap_map_handle *handle,
 				nr_pages / m * 10);
 		nr_pages++;
 	}
+	/* Stop flushing pages on load failure. */
+	if (ret < 0)
+		clean_pages_on_read = false;
 	err2 = hib_wait_io(&hb);
 	hib_finish_batch(&hb);
 	stop = ktime_get();
@@ -1137,6 +1140,7 @@ static int load_image(struct swap_map_handle *handle,
 			ret = -ENODATA;
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
+	clean_pages_on_read = false;
 	return ret;
 }
 
-- 
2.25.1

