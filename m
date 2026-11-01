Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521452;
	b=WaQHipCMu9k4/L33GeR2dzRT0PCYGG0VUeLxQ3bH2S/oWSXhHUvMbmTnRcD8rVGSqWC7
	 D/E0bODe8ksZx6efYM4ZrADuZmik4kjtVqOqy6XvGnf0YbBNY88rle3/kImoT8pKf+RtI
	 lnChRKBJtUVb+p9ceqbNQ0Ms1MSc8knvMuL4tgc2EMfdcEd3lTBM01SS5evGZ350Nsi4w
	 7kwJYSbI7+GzVUdIDJYR7tu4ukePlE9/J/nzvBuMfW7if/Plw0aYbqzLUAJdDHa+iUOP4
	 yNNKz580wF8mTlaYHQnj7NrhpedmWlllt8uDfoLGxWt9+W2hnT0x2LlRttYRd4uKw8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521452;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=cgr3O4I7DwkUDW0N/kSwsX4ydZ39VN+0kbFssYLbxJg=;
	b=ovGSgLsFMmA6oe5m+0mk+08lzVtMI+PQyJSvTBGVGT4iTaRQ277553EzQP6PtHyWYAJs
	 3I7L6bc4tL0VF20kBINUZNwlGbXk9U5lFSY3eHsF5sBNxtKzL8e58t+uxdRInRQNRKMJL
	 3c3WAgoTkUAXh5gdLKB4sD3SB1rVoTdfSMPZMVzRZLJRmSJytXY1MxPOFIzv6UTV52bmt
	 Q0hInHQTVCrLFkedgvYmjZfydCmiAJzNC8NTC/khqO3Qb7kh6xBomdlCzzZPrdGR7keye
	 y17WcJ9IhYlUSOaZtHwyteguKqgC/qkdaPxPYRJx8yso8F39dBFrNJtkAQiGmrsGPkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=DD3dVSEd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cObI03vx;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DB606A32F
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF9DB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=DD3dVSEd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cObI03vx
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 269E0EC06A1
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:24:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 03:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521451; x=
	1793607851; bh=cgr3O4I7DwkUDW0N/kSwsX4ydZ39VN+0kbFssYLbxJg=; b=D
	D3dVSEddWuKhJ5+P4wX4ffYK2bu87Ah0Y+aUc/gI5P1Q8x0W3cV5VkzcEMyz49B3
	TFydSWKmQPdrWPl9PYzE3a9AFS9fDfL9ZRyL3UuOoLVceWwtlcA/J31+iCDzbS5n
	qfcX3cQAbXumSFn1DQWtCuD0JnYne7LpSK2r7L83EQnoUJNOkNe2AcVcCP3w3LFh
	NV9Mbec2JHZhV7bnZu0KOfX+Ni8wgzbZ+0vjN4ATF/LLa+7B2/ecp2lE33Ud8yyV
	p2i47cX/RYItDMjayZZ3O6j4cJIbJhFJOSxrdILbpGIS1gRp61ZdCqotsz6mO2a3
	DA9IqIh4TeYG6VahueiGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521451; x=1793607851; bh=c
	gr3O4I7DwkUDW0N/kSwsX4ydZ39VN+0kbFssYLbxJg=; b=cObI03vx7rkLK2mau
	vqkD/wtwMSgcqEFSMnbyq2qRiHqtWhWDsBwB8f2EU9djCdeUpgYiC4d+x8A7Dyer
	wYc//+BqIH8pSZiYne8DD8ULLYvxG6jUGHca/R+qm07gqOFtatrv9yMkarf5WPm4
	nEl3fmML044quAzJ3CxXFNet2RRYHx2Izg2GEDuxeta9C++UZT8on+fGWpgJfTXq
	ySYvnfni0rBJISOJUKjs4qOJtdz/eStYpd7CZteMzdwhm9Ak1GAigYlIlHKMcsZU
	OCw2ecQWYzmVMETboyE8qZ9SsA8r96Onp4VtOjVoa0TDXxpoToUcLxk7Ntdv6lLy
	dn88A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521451; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:fACik6nVOOxYXRsNIL0FnGu48TG50LFgPxllqASjiTGdj/O
	685wImbnZNS8KdJZvfSanx1iAUd6K3+911kn1mJLNsXbZJGuwrndbiw4yv5BnPHy
	SKq0OKJt7GXtnY9DE99Py16DaCCXYpLoLvMx9AEwWKgkPpexNSKaPR5z69+w/GHL
	anro7/qosof+XvZDFo0RcVnAzBuRO/IshEvz5Hk+h0yHvPWWycqw43xZQiPJliWN
	EShpdZa8KOHESpH8OkxOCN/i+bxdStjA+0OIsuXJtcxLgJGpCiQlI2MB5VwcBxUJ
	FIh20GYNjMhUA1EgndPYFZoVVSG+IqDQ3TNKHLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G2ezc5FLDefrR+8r2DKGPcy/zKp7XpR519EEybRktVQ=:ZuRx5xe755qYa0gb4/aDfZM05kBxhm1L8sT7M608++E=;
X-ME-Sender: <xms:K_fmagwT-AqMUXnhdntSZ2H7Iw99TmpZ7uQxFJUTP29XW9T0H51AyA>
    <xme:K_fmandBoKBlTSlxj7zi4uhyiKcGJX5LmvGQLBB-4S-qtwYcLw5Rdvxmbf4nQGFSn
    PqF4VJZPwv-_yHlAUnDBuBmZMnPuOKv-lEaEuw3lU5EgP7UlNj5bg>
X-ME-Received: <xmr:K_fmapLf7WPQU4kdHUuEJcysZ2kHkkXU_LirWcuLhhzx8yQDe4eXsrJyaa97X1b3Ie0OQwvt>
X-ME-Proxy-Cause: dmFkZTEio0HITRPU8VpT4PebgbYf+HqQTVmTBwoXIcaWhSPJQuOpCGNL4Feyfw1mm6jNto
    aCqGt+GjGmHddQdDYMsFOcBW2fd2wbE1C2hSqpUPgYFBCtzpG0VAhrL+r+dSJb3xHPmeXu
    bbiU80H+3s8diofjGu9JFbSOoisVQrvN3eDU6svi49hrmcI63rUfSkuUe5+aUvGFuszdig
    Qnc72eHSOddgDW0HvcKHXNvldok2Sz2296F+6Jr1XxRzNWV9h54MRHCMGFMHXdGms8Xsm1
    Bk/Rw1sBqh58/z5F2FEqlRBvxPnvur8T5rxLVrR8npGrMSSnol3N1co7aLduCklPXA/vJl
    YnFEZni01NLKMQSYX/mIf+ZL4IJ4nKp6UeVFxNKY0H9ZkwD+pN+hUO6U8qVglr0xDwBrUo
    Ap91fJhWyJmW7tmIhfo1ecixjxPiIxBlkz2+I3fZDeKM0s+jVo4i2YAEMvIRr9oxESn0bA
    dYOSHaNneoSd7TOH7qPxulWMlw5H4ir1fqyMB6M9qTPz1zCxBgUFVJ72mc2b7lJqlTlc01
    +yg9c8YauDhdWXWKM/kX7urjBozR2WEB+DztoA8IR0e6n9kkyEWuD0Itq1J4jfQtAKJhFQ
    ROHqX/PWdXMnjSp1FHjdtvqC3n/RoSZdXckt9BOYpAtvD4wkhxGwK8VtchVA
X-ME-Proxy: <xmx:K_fmajl6Tpd7Oavv05hJzLJLBJAkMvi23ZRUqHd0v7ajCCrMBk7FYw>
    <xmx:K_fmakXwlDjbQssh8qwjDpPkjxIhODFkpWdHMz-yPB9qVKPQ6QpqAg>
    <xmx:K_fmalthWUdisAovsc9BYlxq54liDIo7E_JpxJ25JHFvIm0tuRZdCg>
    <xmx:K_fmao0d2_aXDgeONcZe9IbDFuV88nXkawIheY8k5uv_ipR0N-09zg>
    <xmx:K_fmajXp1FzijLW9CrX4NAhVST5I3w_OHQxt0wFumXftctJlTIr2BSAw>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:24:03 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 05/15] accel/rocket: factor the completion tail out of the IRQ handler
Date: Sun,  1 Nov 2026 21:22:57 +1300
Message-ID: <20261101082307.151957-6-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
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

Move the part of rocket_job_handle_irq() that starts the next task or
retires the job into rocket_job_next_locked(). No functional change.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 152a9098634b..417d5ef06c09 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -365,6 +365,25 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+/* Start the job's next task, or retire it. Caller holds job_lock. */
+static void rocket_job_next_locked(struct rocket_core *core)
+{
+	lockdep_assert_held(&core->job_lock);
+
+	if (!core->in_flight_job)
+		return;
+
+	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
+		rocket_job_hw_submit(core, core->in_flight_job);
+		return;
+	}
+
+	iommu_detach_group(NULL, iommu_group_get(core->dev));
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -378,17 +397,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
-- 
2.43.0

