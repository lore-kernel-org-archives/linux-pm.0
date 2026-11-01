Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521421;
	b=lTvBFvhBQGO78yXN/+ITkQMA7exuLmEBUspKYk6KVOVOB/Tt+YhlWh6TFpYtweX1bZoj
	 Y5UhX195YxQSP0TVvgsCV1mHha8Cupir939foz4XlXZru49YXYIi5YMXcTZf8wszqHK20
	 jB+H/AK2RGZ2y4vtDvykXCFcTmya8T/ooGKRUckBPY5myJR8dGJnnp93DwpiPxBY5lil/
	 2pI+BTejpsB0t2/0mN//O8yYWEgQcumF4k6ygc3EuKJCgeE1s993FfFL+fclhRzWxM10v
	 UMxe0V2bpgYnSC7JGHHVX+f1BJbQxdD20VzsTEcEfgq/goKe2zKhiUMYCXgWonmZeXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521421;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ZAHududhAN2bNiKXcm98FWOTLV3kdD3LQHqkOnkqBH0=;
	b=Un+sboEYdbqRaDP35Ji+iic4U1OJ+oM1hJB5VU6x7iVwE7rsMNi5ENL6lXz1ignSyPu9
	 P096HvsHlxocd1KhNWS1NP0fw/3beJPe/zH55XJKO7j5SA5wbBjto0F7hKynVLJhe9voQ
	 IvtU5s1T/OPXNRTE1+b6Hq0HDMs8B2qVxnQZAVKj+T6bCbkgvo/zdclP8FZyj5B4qd4Y4
	 AM8a/hufz7GiGwMyhVXk31uvNx9xDBu59L7KIhe6Lzbhui7Cbg8fwS5pNgw8q600W1RWW
	 /9kTADdIXY8SghahmwFcM6jzUMORS+plmoJ1oMrTJ2uH5LrJp8hjopHAQUdT5DyObJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=ikZSrJxZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="toST6/OD";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16595606A325
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16595606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=ikZSrJxZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=toST6/OD
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 655111400309
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:23:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 01 Nov 2026 03:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521420; x=
	1793607820; bh=ZAHududhAN2bNiKXcm98FWOTLV3kdD3LQHqkOnkqBH0=; b=i
	kZSrJxZRULGkrzGj6gaRjAHLn4ctv1VT85ohhD9irSp/UduHrABNvmgHFbZbXgut
	82Uj9HBlzfv3YniTQRE5ezrX0csVDGNhje5Xf/CjU6cVs7vS9mudNeubkhlLqBjj
	8I+q/MPNCqHzgkJHoGp9l4b936uEzRQStuKFOo6eiCUryAtCtu+6S+gHdzOMFEpI
	l0XaETviiYKgFCL4t6mr+smZqnWhN6xP0soy9vxzsARW4mvwMSSUOyEiHKvs1+W5
	CloaezDC7QZMf6P5YbPKhdkOTKNUhbwdN4xNYLH0JUV25j9IIeFHc89Cao/NX5Dw
	MKAjtXMUZhymqqoED2j1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521420; x=1793607820; bh=Z
	AHududhAN2bNiKXcm98FWOTLV3kdD3LQHqkOnkqBH0=; b=toST6/ODOmh+2vMmz
	/N90EScYOL8E/l+AbeDDlYOpeTKSN2BdCvDWEE4JN4+ZWdgRRBJ3/dKBEEB4GphI
	VcKW9k3ALCXLqY04tPMK+YeY0IJ6v+FTomVJyGiEytRcUFXsNuuns3DtXFJRvO/s
	qq+60gTXsDeWSJTrc4pGFJWAhcjQ2qs5bqhnz0DcgR9VADC35q0MV68l1N5A5jPP
	zi3b1rmQvd8DZ2NWVNcQIa8Vs9zc40UYuV0YfCUhFIh5RXfp6Xq2s0KT0QlwiHPu
	WWeztw3AC+xYOZkmQrf9CSEGmCnm+pRDz/f83O8fgMF7XOnXoTndDVJiVipHmFg4
	lFlpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521420; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:h/bwJGxyvcLwLAOgORuq5qwGsnkfTvhpLWRhWdenJ4nMTnk
	IiWnK//ZeS5945d3gy2RoGagOPpqIba/rjvxSomX4r0hSysa+rX2/9zZTCVRd70z
	DdZnGCEX5b8XOIiwRtLzrZN1RRiFtvaNlb2UW/7wWKYHXSl4DuKH97lhzKbbp+mN
	wD4OkYJQDIAsLPx+McIIxZ6LZcnkrc/oIJYAhuKGbRhpQdEVtJTZSWOC536NTTMT
	TXG4Ah2JmxzoEIXBLv41w2Z55cttROniU339Bb62lQ/aWxMcTed2C3dmoJffHsRX
	IlrNdR2mBbZG4EqA3JjppugLtjMHn74XD7WXZMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:68moGeP8x7JmMxokVk5blklCUtJveW2G0pg9zz1D7LM=:k+QPvQZtzXDHqi+92JcSrBBnCLFrtIzMII9e5FctQI0=;
X-ME-Sender: <xms:C_fmakeuJpNnav-HXp2T-ALR4qlkh9aLlHrJLZLkhwXUKRnq4dgI8w>
    <xme:C_fmaoiieUDcBSW7nd3fxDcJslS4zsr4p7WG2Zn9Bt1-zdjK35ZSX7cMPoZ7Xyt_g
    F4l3MAXhEg3-RcV4PR9pmd81KrTxQYHYjZd8rxUw9Fz9pB3qRyC8Nai>
X-ME-Received: <xmr:C_fmakPBA57FUv1feJMModpjIqvxv6Q0DdrL8nTsXq84qP_Q4kmwfQf6xAadRleyX6yYeA37>
X-ME-Proxy-Cause: dmFkZTGyh+h4Oz/02elyRzjcRRcFpvHFjmUJCnxNp2cKE2We77OzoK7VQLrSm4eM2eB7ES
    ZXYJNEUB69Lfmlo4BbDpozx55aBH3xHf569WnDWwtFhUpPk0WaG27oVgoEA92BrPX8ybbG
    lVvCv9B4GY0sGCL8lWuvRRdhYtj6CDshZ+rxDIsdVMf8F9QgOg8gXc9cdCOHkH1m+c2Big
    hig4aNfN4nuBefG3HYaHLHaq5rR0CK8cq0/bqlaJmEt4LbTynrCCTIklU+JAaE7AuO9r4C
    kC4gllUxYkdmDmdmnXTGCC9WevcAeVCB5BLLAP0zSIFYTrZTsiHavZssNvQ5oV0hNi/EIF
    DvniigbILwxNdtqxW1aqIW7+QxtMjFlAughZdUlWYkbDChwfx6ZSP5mRAesS5EAP2K2mxA
    g1dmV83iBN5eD/BXSeDsQQoscdBrF+EuBf/h9dthzJ8Ordm2BAmilGF1tvvNzLNjTcMpxe
    IyxdUug75rREhOLZldGyGbJ180xkqMjUKK4DHKnrkRPjDMPO7a4Pn7gBMk64pO1s4cyhfo
    OqqZrBoDL2cT9Gcktih5b9o4IC76aAn0cKdQhQGiv4+a/9muWc3dHL+4CzVpQLkkG2BHeV
    R9BQibr/p+eE/AEQcwAR6pG3qxqpNuvBuui+YCRd1A51zJS6vfShl5lSqFIQ
X-ME-Proxy: <xmx:C_fmam6RLGTxjoOgT1L7PLDadbJhby7PId9xREPT8Xl5Z8R-7FXntQ>
    <xmx:C_fmauXcm8S7UDn2sxUJcbVYHqF1nNdCWbdQvQtC_kJ-lj7ScmGtzw>
    <xmx:C_fmaoF7videAlRcrxuZtc0IZLBaGUk6qZr1e441KDuS0eBeQfjJOA>
    <xmx:C_fmaueRcdI-_3rKYcyrW9ZjPJoMmVGBbcEloqleMdirfOC1uzKpog>
    <xmx:DPfmas5trhRy-aH7ikCOkoJgGn_YcweWG1DjEGEkGMUk5r5Ug8Qo0zZC>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:23:32 -0500 (EST)
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
Subject: [PATCH v15 02/15] accel/rocket: take the completion register writes under job_lock
Date: Sun,  1 Nov 2026 21:22:54 +1300
Message-ID: <20261101082307.151957-3-gahing@gahingwoo.com>
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

rocket_job_handle_irq() writes OPERATION_ENABLE and INTERRUPT_CLEAR before
taking job_lock, while rocket_job_hw_submit() writes OPERATION_ENABLE under
it, so a completion can write its zero after a submit has written its one
and stop a task that has just started. Move both writes inside the existing
scoped_guard().

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index c3edb94355a3..03e5f094f60b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -369,10 +369,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
 
-	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * Stopping the block belongs under the lock. hw_submit() writes
+		 * OPERATION_ENABLE too, and outside the lock this zero can land
+		 * after that one and stop a task that has only just started.
+		 */
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
 				rocket_job_hw_submit(core, core->in_flight_job);
@@ -384,6 +389,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void
-- 
2.43.0

