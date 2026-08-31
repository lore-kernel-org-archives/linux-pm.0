Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA53C0A1F;
	Mon, 31 Aug 2026 04:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149403; cv=none; b=Wc48EoUMKaUBM79PvFCRwjrjGJTgmkaOj1EsOoaX9/CWLCPwIqi6oUWofJ2lRiWW4NfEh7Rtz9syV54uPqwk4BA2AtPncTZqWStuTliNWN/wXxr4ibcS59EJvz2TpSGJdQxZ5ye4e5oyLdb2Ph/KQpCsnbOl5xfM2xkXxpmSTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149403; c=relaxed/simple;
	bh=kN06lZ9HD0pj4xFD/f2Qilt0vzfMYrJJB1Lsh3PgnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgSFYV6j6+bZNh7xphwK4p16ZqEc2b1XikBemeCAcVlYs3DwsiZuJGGvtjS7wqOitgC1szWdRzWHPJXIgNgZ7JNv46cWOKnAIYwJ/xD3Au/3saZ1UDtj/PBDVef/+79b7yfY0Qv/ZbVQPLonXZ+x7DhOa4pvqSxK4QoueQUXs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=dPAyRK9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kko2NJd2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="dPAyRK9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kko2NJd2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2EFC7A0014;
	Mon, 31 Aug 2026 00:10:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 00:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149400; x=
	1788235800; bh=mPwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=d
	PAyRK9KwarO0J8Eq6iy5mBdi/lGn6CCCa7VErv1Zd0FWw+0TQYiNPxxSYM9JSESz
	sO1L3KIaf31Df9d3g/w0XShRwLkd0wm0H9AhFxSaHlySd2jjoYZpT8MR9hfuoong
	3szcSpKnJYbOZXRKiQHF7gYdvMBI7ZXCqzkmgjAnL0iz9CORJs48teAka2j0NhCJ
	aiQxMcohWtTNasCJkb/dBwI6WpIVYJzXm3qTCBonlqFlZgbf7zJMuym6pk7Njvts
	tQbgh2KJSqsewJpqSEqBlkA4xd9siAgW7YfrpqQtkFh6NxPpRl0f0Gzil/0DSVeB
	kouym5htYgFOg+3tNwDKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149400; x=1788235800; bh=m
	PwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=Kko2NJd2g8Saau880
	idWMHg+dkLrodKlRBxxjLgvioYWLPWfL9pdiLhHO3xxWNaAMINMtx/ra2MUKuqB3
	LIlNqEhPpi118rhV4G4moeSOH/BQryr/v3Zh4AIWIekbfEFgEX6wOjF54jwF5DMZ
	0GliMOC7+AZ/N2Zu5mpOw6/XiiRUMuMNAtTx7wRnVJC67t6JgY2x8AYtj2vaK5qP
	DSRnNB2euzQfiTLwVX6GvoMRj6h0fxgC+EiqPOjFEsLhVThjgxHe0QRmArjUHSWt
	T7aIgOi2rwmVyDL4ZTsYfryBTDpy5yYumfcZTaZw0mZJxZ0GS1scNn1bVW5HaqJb
	a9cvw==
X-ME-Sender: <xms:mP6UaikWEiJ8wGRn2GSPh6Pb0btknm7vDdNOJDWA0zlv1ml4OQuYgQ>
    <xme:mP6UapvESt6QMYFP9HziavzWN_j33VIlLMpfDG05VHx7NJjucES3-07FZ_zG3Id4S
    0PqtZOqTrJjP5foVtQ1ukQi-7TLiGJN3csKAtm2ZRNhAw3Y6WRtnE4>
X-ME-Received: <xmr:mP6Uat_-NNID5bwBEKZx0LVQT5IZ-Gbxm_GphqZsQJhljT_1sTLB5gkjvmCaVA8gArkqZJJhKw>
X-ME-Proxy-Cause: dmFkZTGgZgR+VcPfe+PhAzOLd0oIFeQYFsXhiZHiqFEfJLX+Zh5ZMdMCmp7DSb14qyqV39
    jp/P4WoX1+fWMg7xKNkg19erm52kJxQUcTYbC3fhf7J3kTCWp177f4eiTLGImcgm9FlW/K
    919HsGQiniAe1IB7e9jl0y2Y9dxEodpqsZNpi/Wh8/Y0aGqz1kZ0NysbtBSq+wCn4J8DOp
    NMVeqNR7AEscaSespCcNi1Tsf5l8QtvZS5D7uic9GEJ8sDuUqjUvTw65giXWj5Lizkd8mk
    k6Wvf2Wg5sOErrVa3i9eyoCaEv0ghglB6LbcQ07PYZ4WQgjzQYOd+k7ebFmJtNV5tyGONp
    ZEuPBk9Ry7VqrMOJAH9/OpoUT7HzWEijFRWuPdbDRmDKPiqUtHRGOZUzJf5EoLoP5EQGLP
    ABrX2Y8eHWrejJl3OOsSVt/hl5b0oC0SYCAPkBqlJgNkvKaFVDb7EqX8UQCW62u11SR4s6
    RDGobJmZuMJ6KAhJh8PYVlTlP8UFK5sVV9ScAmN9hZw0K2wYHhTjvxel/zGODwrtpmiQgW
    vw7uIC2jMgpzeOSkso5POu22nBnd5jnzf/JL2x9R9rMdDXYuNME1DwPQXXRLnjw3k70ECx
    On2SX0Bu7qOn2FSL9EsFfrsXI9yhtItGkZ42rakIn+qQd0+WvTaiNeH58Xmw
X-ME-Proxy: <xmx:mP6UaiyW0VzDebZ2t6aFpTOpFjJ-0aVyDp9ApzpIjUjxVyyVve1u_A>
    <xmx:mP6Uat9NQKH0vvFf7klW6WJpQxjaB7Shx3qON6NBURPy7t6eBhPJ8g>
    <xmx:mP6UavLHxezYj4cta8o1reo4SFUDKpGRnfLFM5bX1xGkoo_O80RpXw>
    <xmx:mP6Uaq9JQs8Kb75LAFk8mb_ppIaPyx7ZmWIoXGVSre9cofUL4ctltg>
    <xmx:mP6UaqOMRx6YyVYeZb9aQWFSrWLjmfYSRGSXscc4TzAQWOYkJAY1qPV2>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:09:53 -0400 (EDT)
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
Subject: [PATCH v10 10/13] accel/rocket: select the per-core clock and reset counts from match data
Date: Mon, 31 Aug 2026 16:08:01 +1200
Message-ID: <20260831040804.24111-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
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

