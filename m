Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800796;
	b=iPF/VO0E1grMImYTK1tuC/bqTzg40Kr22TtmGOpFrhN2Mnnb2W//66kaQwp2MAiRMG/l
	 bCHoqi3EfLRyLITR/8FaX3sxkP1TSf5fbFwD5fYYqiz6u/RkBsoWroNMPO37uMvqucSwy
	 adJBb8BQL/2Avvnj9n1ZcdmCT7Ll6TJusYeku2rR+4h07sJtQE0dbX9obYVJT0wqyyV7b
	 Ek6/UGbFu1d1LM/gMAqicDCgV3+nokTDW5iQ7SVWE/LyvcNXaUyo0if7xymvHvVoONyFs
	 XL8yioD+p0d2tiawo05rB6CrsxAk9ELH0eUNvh00Sw5V91QOe04SkPHxLTPBYYKY1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800796;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qkyD6FHBG7uM8GqqsjwTnW8YV6DYExquD3ioaGeBfO0=;
	b=24qQge4ssCQbw21d5Aw7nRIXA0R8dlAvu3db0iBr8jr3WjgP9IBuCb+i4g5fk7KN6uxU
	 Myw0rTNKTvzME+yRlLsbDvgs0SWwDiLBYo74N7F6uwHZKsuqYnx5bTj2FnH23ul5nOkFO
	 dO9ZsqLLqer2USvHItzxQnYfYyNdUJXZTKaNsFH4Om21YOdbhOotIH+DmFsRqcrjHghfJ
	 z71AV9+mUvbNAfX8mBXz40XFjxZITiieTd1wJ99jqAo7xmFzeBiI3BaFwSbLcPuy+hnZG
	 E/bzZCGI+RwrRPq75tp4qlfY4u29lz/51AuiVAPx2z+0gaQnlApBJp5QOqRDuSeD76g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D0606A31F;
	Mon, 16 Nov 2026 03:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C74D0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4bd44f14e17011f19a56ed5b684f684d-20261116
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
X-CID-O-INFO: VERSION:1.3.19,REQID:6b18efc2-1c12-4f1c-b8be-e38a88ca7d3a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:6b18efc2-1c12-4f1c-b8be-e38a88ca7d3a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:dd6a868f1b7bbb5a8e72b30f206fa8f6,BulkI
	D:2611161146298DYOR7A1,BulkQuantity:0,SF:10|38|66|78|102|127|136|153|850|8
	65|898,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4bd44f14e17011f19a56ed5b684f684d-20261116
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(175.2.56.187)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1242737867; Mon, 16 Nov 2026 11:46:24 +0800
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
Subject: [PATCH v4 0/4] PM: hibernate: flush icache for restored pages from task context
Date: Mon, 16 Nov 2026 11:46:15 +0800
Message-Id: <20261116034619.36218-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Hello,

With `hibernate=nocompress`, load_image() submits the read bios
asynchronously and hib_end_io() completes them from hardirq/softirq
context.  The flush_icache_range() call there, added by the
commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
restored in-place"), ends with kick_all_cpus_sync() on ARM64 and so
triggers the WARN_ON_ONCE(!in_task()) in smp_call_function().

This series fixes it by keeping the flush in task context, and first
closes three pre-existing holes in the restore error paths that the
rework would otherwise trip over.

Patch 1 resets clean_pages_on_read when load_image() finishes, so that
a failed nocompress resume can no longer leak the flag into a later
compressed resume, where it made hib_end_io() call flush_icache_range()
from interrupt context for the reused ring pages of
load_compressed_image().  The flag is also cleared as soon as the load
is known to have failed, so that the bios still in flight do not flush
from interrupt context during the final drain.

Patch 2 stops snapshot_write_next() from releasing all snapshot pages
in place when one of its internal allocations fails: the read bios do
not take page references, so freed pages could be handed out again
while the device is still writing the image data into them.  The image
is now released by the outer error paths, after swsusp_read() has
drained the batch.

Patch 3 makes the error exits of load_compressed_image() wait for the
read bios that may still be in flight before the ring pages are freed,
like save_compressed_image() and load_image() already do.

Patch 4 defers the flush on the nocompress path: hib_end_io() now only
records the restored page on a per-batch list, and load_image() flushes
the pages once hib_wait_io() has returned, preserving the asynchronous
batched I/O.

Patches 1 to 3 are unchanged since v3.  Patch 4 now yields with
cond_resched() in its flush loop, as the final drain may walk a
multi-gigabyte image in one go.  Many thanks to sashiko for the
reviews of v2 and v3.

Xiong Xin (4):
  PM: hibernate: reset clean_pages_on_read after load_image()
  PM: hibernate: do not free the image in place while restore I/O is in
    flight
  PM: hibernate: drain pending reads in compressed image load errors
  PM: hibernate: flush icache for restored pages from task context

 kernel/power/snapshot.c |  9 ++-----
 kernel/power/swap.c     | 57 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.25.1

