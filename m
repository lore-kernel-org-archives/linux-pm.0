Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF483D333F;
	Mon, 31 Aug 2026 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164519; cv=none; b=dL35K2DRjFxfgesYdQtjyH5B0NV3vzLvU5epyQFjBpXU+WWO1aCM2IwUH6RITAls1g6gcWRBEphTiAA3X2NY1EtaBJjj8oTO7TJV7UgQeF5mHIwz3zNGyjPrPZGbmtlwj+CD8qleZsDzDeay0fTwKHn2/qnc+LFQ9VnmVv2UwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164519; c=relaxed/simple;
	bh=kN06lZ9HD0pj4xFD/f2Qilt0vzfMYrJJB1Lsh3PgnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxA25duD8EMI0znkinwX6EbTYnbD/ThJr1uHDW88+UGWLCKbeoB1pQSCQqqd6Vgfr+mBdFuo5vtPjQol8KwSgmhtbZ17zoetvQ+M/J8smOBQwt1pdsqE1uKzb0Yt+vf45vMiY3iDzkbdCdmIHLxhndpsba17Kg62VASUWsQlyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=FSDPicFI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D6fgqtoB; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FSDPicFI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D6fgqtoB"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 8A9381380045;
	Mon, 31 Aug 2026 04:21:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 04:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164517; x=
	1788171717; bh=mPwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=F
	SDPicFI73gUkaSDJDyPP9x4ylawnqNAL6gSMzKLjgAyE6dHZ3crUZ4kBxwk5YsyJ
	/QWe73G6Wj4pdQWZbQ9tU+9/NnxPZg/eR9LaIXbeconBwXQDYrznT3IP2ZuCumq2
	6tTgz0BwRPqJusnpN28F6Jvv8K+tLOZc51sp4t8Y3q1Lunue+DabaZLnYSsfoqCc
	xIgUtnPtDMwJDq+alhPlC22QF75MQZ/2vjffNZ83ektnQ9G+pegGrvtMQazFs9xD
	tMrA419tOJoi413nEHUpfiy3BhbFoA86giaY2WJWWWUB07N6grXcnwSRhDlCRrRJ
	/yQF6MzoPPsY5ZIxx9FcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164517; x=1788171717; bh=m
	PwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=D6fgqtoBcmH5r17lj
	Latf/pegm9kE9CA8F0kUPe4/uP/bMiPN0l4Pvr86c2C3LI/H079qSd7oK2eqmv8J
	iaNpZLK67cykfmEiaqKHPHP26Jdz11F2lyNINLzb1kjfRQOFo9j9WQ9qtDdJYGti
	RzohTO07W4vZCJztXoRHSfISMNxVCIEzjvl4RPyjluUNwiD0AjmYRp6T5HzbQkew
	OCVVK8ct+OYGSF4JJi90Y/fd7l32bAlzT0yvVxpL50Bq2RFp0Po5qTr6w1OnQckg
	KUqSP1KS5nKl+/jJkU8HXDRHjnMh5tS6Ysz+vbP/pF8QbrNGCBITLtw9TIG5g3xW
	SqkKA==
X-ME-Sender: <xms:pTmVarbcWuno68GoC7okvMZFUexjHpySXcXE-MIjveijjToPj3vQmw>
    <xme:pTmVaqT8pWphzFyaC1nflGCE39i6VxUMuHRTRrXizaI3WeQwFdPnS2VzqSKUPB8ww
    lhRBXBDbRkbUiwc8lx-R6ivuMTKhF1daVkdh7FZkT_OEO3VPGxn-0E>
X-ME-Received: <xmr:pTmVarTwr_9wLyLgjJnHHF4ZtFdCmQfOjIRGbzA_ddq1KXsHnLHSpEdCYpnun3NQypqZ7IVmrg>
X-ME-Proxy-Cause: dmFkZTGIFgHn697QN77LvkxTVd0HUgqc7dtgfWAXvrJnzjyYk/1E0GgI5UhaHEirT/WT1x
    b+qszzNdMAzVFopaNRs2dxhnDg09r1jPoC9MEUtixnInykmU3Pw0l3hwtCEJ1ad3c93Xay
    bd+l5sHxlTS6v/5iZXzAZK/4u27Ei0nAwXdeaVFF7kRMXjXXfW3iRGTZonBhmmpTvqhV+z
    V8Wknu+rEOyAMoGvxP8cZTL5kJKYkaLJxiSkeTXi9Trr4J2M5YjykmqP7kv72jWCs8a19h
    BukMvHNfzyzCVsSYvDh2T5LUAPpVgmVJhTbdZLaOSzh+ILq3lNXn5p+T2rNKefe0YsrRCm
    kp/nrGKrzUBgtGVe6D3IE8KpZxmONp46E3TI5jUlHmF3BelNeketdsJdADjX3e4DRXTUh7
    T5VtgKTpcPlL8i8cSg8Z65UoSLxgRfdPhSJ1AqvOgJsTjR23dTtD7NWbqBh3MTz9ZhAGzk
    tUXGA/huZ1iuy5MrCsDioQnSZAxlMupa73ixGtpiraRZ9pBvGM4sqaRvZ31JGM4PxfAHbl
    MeaXAVU3qFl//5jtZGujsuFmKIpZORpn+AbJmclLxxUWHGqa85cJjwD70tj0zmyuc4SieE
    s5O3WjIwaiKPsodHXzYXbUfGnvdKooLwWxYLuxFPv9+0phDzMuXeLaqPKMkQ
X-ME-Proxy: <xmx:pTmVat3ry9Xxu5vdeeaZ3u5p8UFIZ-Xdk5I8nsjRSD49KzwVs29Szg>
    <xmx:pTmVajzQ_4kkcV8oDh5sEVd-oJSq1miVmhxiy0abTf_k6lQCUW0irg>
    <xmx:pTmVaovXK-k-vH7ERL2j4pveU6naYXefZt8gRf5-lOfxmI3FN-F2rw>
    <xmx:pTmVatRjxgcejdkPXkolCl-RZtmZAqwQwL50FUfhSIvzRs-MAmnUGQ>
    <xmx:pTmVavflr42b4DRYfGqFt5cc9TMNu6uNrqGkYIDwBjLhjGxxXAnZVqrk>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:21:49 -0400 (EDT)
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
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v11 11/14] accel/rocket: select the per-core clock and reset counts from match data
Date: Mon, 31 Aug 2026 20:19:53 +1200
Message-ID: <20260831081956.84871-12-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081956.84871-1-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 carries the same RKNN block with a different set of clocks and
resets, so the counts cannot stay compile-time constants. Add a soc_data
struct to the of_device_id match data and take the bulk counts from it.
RK3588 keeps four clocks and two resets, so nothing changes for it, and
the arrays keep their present sizes: the SoC that needs a longer one
grows it in the patch that adds the names.

rocket_core_reset() is switched over as well. It is the same array, and
leaving it on ARRAY_SIZE() would walk entries that were never acquired
once a SoC asks for fewer.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  7 +++++++
 drivers/accel/rocket/rocket_drv.c  | 12 +++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bac..b202d1581 100644
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
index f6d738285..ba74c5339 100644
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
index 8bbbce594..6e7dc91c5 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = of_device_get_match_data(&pdev->dev);
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -213,8 +214,13 @@ static void rocket_remove(struct platform_device *pdev)
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
@@ -240,7 +246,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -260,7 +266,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

