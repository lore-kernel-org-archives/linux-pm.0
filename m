Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521518;
	b=voaFik5FYwL0IFSP9fqngDP/LToTG3Cg9yND0rpsaSXYZP2nIgaBuCJBbVzC8QCjrXJA
	 qwDfRJcME+VtIzxf1goy8WMHF0/TN81BcKgP/K+v6TTNp6O/7T0Ka9XeSq1xeJlt9iExo
	 VtYN+z0cIQ6vrgl55+tfUfHPv6atEUoZx8+7QFaRa4aUWwRLIsKwWx+3hlkbwrZei6tHT
	 02yFcScbZV2kokxnEFwRICVl80b8UtbWlBmeGMY4MVfASkmUKHqq39Xs1NiUNHe0ANoAR
	 IarPLvH5lYPmgXYqOCOplA2amMMmbxpV5hHMe/ENMf3c7Y9A+U4buFsAYi0LH8AmNLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521518;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Tv5fkRu09KXVRP9FVynrYKMqmVnc7aPAP0+T7s9cgJo=;
	b=d6GRAdZ6hY9Pkg/gTIVhb9NENdvZDANKnHyh4CckhEb6HvNk2AenVFgrPR62pDvPHQYy
	 yxYk4t0E6CddmFk9gWt9fjmKlUeab565i2znI7fYEgU645mIpyCGp6vBx5Mr3mECdiCxN
	 ZtaOA9pGUgPgAHY2lLwkXW5XxbKOi/3X54bbHXB8x861XREHWaZ8PgJ90ghTPcgkh6yWL
	 H4CZtKDCh/VAul6JgBSxI9uuTNq20hm8dfjnFz3cXERAd+u0eI3Q5EtbcGbs8y/D0QTUD
	 NfTgHPg9W7taQqZsl751KgCNOplzMsrr2ahSUh/hdFO3NrsJGH3TbPZ+jLomHf2AjYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=PqdJHAxW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="d6h/j0Vq";
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B4606A327
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89B4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=PqdJHAxW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=d6h/j0Vq
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E42BEC06AA
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:25:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 01 Nov 2026 03:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521517; x=
	1793607917; bh=Tv5fkRu09KXVRP9FVynrYKMqmVnc7aPAP0+T7s9cgJo=; b=P
	qdJHAxWG0KXBX0L53PIi99HA/TCQBoO+m0Ojvi5daE8auRtzWWBpluHqi1YqwKBu
	KqLnndaohdHTEnKKVNn0aovDkKcIn5NVMV1gfYnhOfv4NJZLcq5eO9uvtTUCnTTR
	aw7C8eQk8FAw39tiLXg+ts+TnfYzGlfuCg/vGI78wF2FylK+Oh9g74U9LLbSd7Ga
	rn8t0BbsoKPqmlry+I98t8Q6yr08x1C8Bxavk+BqI4+yJ4eghNuF5+9rCHlEo6Um
	DU7cLbqKHiyVxjynR88lMWhxgx43JYMQR6vg8K2oj8BazCDv6ve0WxMbhiScGaL/
	li6jgD6ovJ6Us+clcYbuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521517; x=1793607917; bh=T
	v5fkRu09KXVRP9FVynrYKMqmVnc7aPAP0+T7s9cgJo=; b=d6h/j0VqpZnswyxLe
	TDxI5QSDpIa41yGjRXA6DuCxuULB6+nGXjbxVUE0nIudJvxrYKqgavWPTPalTEVo
	6eSst6YR6hdo8cVQHHXcLskZ3haA36CGEvJHN4acKGOwxI1096OsC9pOb3K6XoWt
	qwimKuBVOVJUl3NxHpokroaiU4VpIa8vEgu6tcZmGql60IVf2vWppr0F7V6CiQWi
	Y4x0bI8UKgUpKjAI2hhXWe2u4Udb5j385V+Pw6GMUdPEhrg5NpmV7TA4nQHvANuP
	p2Enba2xhoa6dORRwRVlZrkTmfAv6rVuOyDfGt4NhrbcPtf7HHeEfl+fXE20uUHG
	7+T/A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521517; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:tdxCYrPQcEDGvEXEaPvVA+3KQEZdrXLBinSXAKbLJrHCiFf
	XZSciz/fBEPw928j3Z7n/bJgvXHg3QwNwJ2FO5AKDQYi3irfyb5rgA6twLo8D34g
	TUMv06UNadJoIlcjDz1olY1GHYhOu9SWeXkyrR9C71wV6oWBL18IRXSK1a4NIsDR
	BPjU/5yw4JU/M9gsejSZyUlmmnymVxhO4D6+h5MzWf0vnTzS6bqxr8+Gk1P+FWxn
	lh/O9ieo9RYrr3dm7GYSNjFwsSx2zgN+98P+Zrmq2cSYXtX1g8TcD0jNbmaw08F0
	3aYHYGEaoz7acjP8dWj944uI7bc9CZUBEa7kqEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TMI4G3FfRtfK153uLDGMotu82/dmE4aWDIt7Zf9oT5I=:dmv/SLJbJOjQbsE5cSp+knpjdeRLxcZfzZNGs5RdvS8=;
X-ME-Sender: <xms:bPfmalYr88yq-SWwJC3prFbCvotwkWs-QxfD72YMIQmspo56Ke_bJA>
    <xme:bPfmautbuuC4VDnNTW2rdI5YRRiyMogLJUYZjBYISOKktdGBNDXEJ00A8bjIZKh0f
    oUzcvJEvk5i0irjRCS_q_NDVrkXSym04xtBluhTFELxRZ92uuI3QieW>
X-ME-Received: <xmr:bPfmamqiZcFNywp2BsUMb4IjDuTv9s5ubCAuF2iI2szInPMkR0pm7Zetnzk6bEdA7aaI9RXn>
X-ME-Proxy-Cause: dmFkZTFdrgDvVMB4r8CdkYfzi8HENt4ZniAaptnk32evqYdyDIUiN4u+qJPwmsM4JYUqec
    v4rUc8qfApvAbNJ2Ra5MN0yu3ypyPORLkMOGtOh0XTohnIkhEZSu885LWalalXIttPYzbS
    Uhv9ju2v9YW8dXNYmcdznMmIwtsq4G9/p/9pAJdo4PcRzp26MJH7eJVbVBQEQz64thDX9J
    rIjgCk+/ALyTQntMJk4psITzNS/0cKtpyVdzy1WkbmXRFtUlCqvV4FYt4G2/QB1inevd/2
    X+lu//RQBB1G2vupca1DP6ChIyyGmcAZj7jM/POQCR3PixoJogN0CISxEX6S2m7UerBIjq
    GJAwyQEIbAyp9OKHYsN32TiZil4fqBPFsChN2M3LfcPV+jKsfFAYzoxuxy2xl5ru54j8cr
    bglBbPy2si+ZYYWBNFUltSMoZtyB2AGKZg39hZi3hcgUD8ZL6CNPHshOjikxc3LmOlVlQ/
    bTKWFoExw5TfPKCHPLAzXXLWROSfqLKrXMhpnDbw2tBKsyeE3G0UwmPwW3yQbdCSrFBzWd
    LI2inVOR2elmETw0lLvG+ou2bI0X62/sh3c6nHxUcLTfa6xXmlV/CiE4WBH89v6/XH13/U
    U34Om9Oh6e0P5ZT/lGyfkWpfEq51WsRDxhB7QjYEiwY8+yfzyZ2QCVge3bOQ
X-ME-Proxy: <xmx:bPfmagl5FseJ76YKPYzusaeMe2qfUAL6tuPjy_5qQXl-XtTNnDEEeg>
    <xmx:bPfmauS7LPXkhtF1Rd034SXQwvxTr4Z8vmcFBPS-a3ntrbQdXYWdzg>
    <xmx:bPfmahSI2rL9H-COcHSOif0CzAN5L4qSq9nW_oJGCiUSpE5pT_7Zkw>
    <xmx:bPfman7-MlLXAjZGe3gfGidScaPa-HNMukUTnm7TIaf5HdMoDd51UA>
    <xmx:bffmamk08b_iHlxbZIGL1Vn_TIdngJmWyIK7-dCxGMb9DPNRTLw8eIX9>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:25:09 -0500 (EST)
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
Subject: [PATCH v15 11/15] accel/rocket: select the per-core clock and reset counts from match data
Date: Sun,  1 Nov 2026 21:23:03 +1300
Message-ID: <20261101082307.151957-12-gahing@gahingwoo.com>
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

The RK3576 has the same RKNN block with a different number of clocks and
resets. Take the counts from soc_data in the match data; RK3588 keeps four
and two. Check soc before anything is allocated, since a device bound by
name has no match data.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  7 +++++++
 drivers/accel/rocket/rocket_drv.c  | 26 +++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bacbff..b202d15816a3 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -23,7 +23,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
-	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
+	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
 						    core->resets);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
@@ -32,7 +32,7 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
-	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
+	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
@@ -109,9 +109,9 @@ void rocket_core_fini(struct rocket_core *core)
 
 void rocket_core_reset(struct rocket_core *core)
 {
-	reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_assert(core->soc->num_resets, core->resets);
 
 	udelay(10);
 
-	reset_control_bulk_deassert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_deassert(core->soc->num_resets, core->resets);
 }
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca..ba74c5339b94 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -27,9 +27,16 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+/* Per-SoC differences, selected by the of_device_id match data. */
+struct rocket_soc_data {
+	unsigned int num_clks;		/* clk_bulk count */
+	unsigned int num_resets;	/* reset_bulk count */
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	const struct rocket_soc_data *soc;
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5d7805c41dc3..284af027f398 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,8 +159,22 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	/*
+	 * soc is dereferenced without a check by every one of its users, and
+	 * rocket_core_init() below is the first of them. A device that bound
+	 * by name rather than by compatible has no match data, so fail before
+	 * anything is allocated rather than at the first dereference: the
+	 * number of cores comes from a walk of matching DT nodes, and a device
+	 * with no of_node was never counted by it.
+	 */
+	if (!soc) {
+		dev_err(&pdev->dev, "no match data for this device\n");
+		return -ENODEV;
+	}
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -179,6 +193,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = soc;
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -216,8 +231,13 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.num_clks = 4,
+	.num_resets = 2,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
@@ -243,7 +263,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -263,7 +283,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

