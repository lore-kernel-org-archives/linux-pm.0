Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A01209F43;
	Fri,  2 Oct 2026 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912537; cv=none; b=r5cmQyW1OopZ0YPKs5JjDYjKQ/aAPTPDUTbpeyRXPKSa6dwDC4lrM2WWpsdEekiQD3v7Ge939NQPxUEGAIRX2bwy2Q+6ByChD7mTGiTYUZMNWqx+Hcl2vjEIkkfdSmskvGEV2jmcsif1r+jNZUVrn7YSSVNzgwVE106nnDzAElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912537; c=relaxed/simple;
	bh=DtviaBrkqHC80UYi6LzyyHJpYQgme1f6uG9UBQSsu/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ak3SeMDQ6R/lP5mtpCas4kYHJcpDbl3hRAnN4MgAVg7GJkg4EpStmSexpD10CT8sXTBS5tCyKvdZTR7fempEkZVeJKwQ9/IWv1BS97/XbFo33ys7E/AvTffxAwOomhryA30sHGahMfVekCv200zfdLz4qN5jL2usAS0wRFolp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c441500be1311f19a56ed5b684f684d-20261002
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3812c682-6555-46da-a844-5cf90b389a2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:c97e038e4a0afbd360ce8fc115b8facc,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c441500be1311f19a56ed5b684f684d-20261002
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongxin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1910903092; Fri, 02 Oct 2026 11:42:04 +0800
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
Subject: [PATCH v3 0/4] PM: hibernate: flush icache for restored pages from task context
Date: Fri,  2 Oct 2026 11:41:56 +0800
Message-Id: <20261002034200.920546-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
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

Patches 1 to 3 are new in v3; the per-patch changelogs are in the ---
sections of each commit.  Many thanks to sashiko for the v2 review,
both findings are addressed.

Xiong Xin (4):
  PM: hibernate: reset clean_pages_on_read after load_image()
  PM: hibernate: do not free the image in place while restore I/O is in
    flight
  PM: hibernate: drain pending reads in compressed image load errors
  PM: hibernate: flush icache for restored pages from task context

 kernel/power/snapshot.c |  9 ++-----
 kernel/power/swap.c     | 55 +++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 14 deletions(-)

-- 
2.25.1

