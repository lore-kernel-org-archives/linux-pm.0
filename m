Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE863F39C8;
	Mon, 31 Aug 2026 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164421; cv=none; b=q8hV0/0UiGJJ8jOYiadaBNCol1B2atAGF7sl72BOB77SKLvAVYiWtdlMoPNnRslFBoR0bAwn+pdlOktUN+BSvjRBNaXRLp8+CN6E5giKy2Ya2Bst0DQBWUUrTbfyq0Ccg5nFKN+ZlNIWjQP04YwXRt5sXIATQLnyaJkNZp8R2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164421; c=relaxed/simple;
	bh=Ya4pJnpX5WisDeNUR/GYAcZlBrgSDyfWCdda9z8QRxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCHkji71KIepkHFWyGdQbWUxZ7VO09vVp1PWSPwVUxWdYbAp89O7rnvnshgIHlsQoIIIdwDAbNYAVVNHw49D8nvwaO/ThS3yCkK03++STfp37JuOde5+OTj2ZlM42XVZgNhRGmy0pgeD23fXCda6McB+Kl8Uwe2kQ6bmsPQdxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=tRQmTI60; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exEIEtKO; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="tRQmTI60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exEIEtKO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id A27F013800E9;
	Mon, 31 Aug 2026 04:20:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 04:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164418; x=
	1788171618; bh=mBpU3Op3r4JDPeCWNFWPI1BaBuK91a9+fdBYmwtcAeI=; b=t
	RQmTI60W9XwmBoHzH5DW0CYxtcPfC6TxBa31AAWWwrub3Zv0Wb5a3KPboRgT16X3
	EnNUadFOymS3t7xrEuzgdn2619Sp4d8WMMWKICvTWWAK0+CUdHMD46ZJ+7LMCK1A
	licFPuo0eRVvH4gqpA0N5PZ1u+9DeCh5OeBLj/Y6fMmDWh01WqZ6sve4zThmbZJU
	+wy+E5XdWiGWSpIpin6IXQaGrHMS/+MEXDKYm5cI6Z5Jy65lTplJq3kSdcYsbKX3
	KOoi12Z45f52+/fB0DbLn7b0IcXSaYyrjAaqCaMv+4kbewQdFxazPpiW5b23r/eN
	5mdIwzW7nU2oId7t680+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164418; x=1788171618; bh=m
	BpU3Op3r4JDPeCWNFWPI1BaBuK91a9+fdBYmwtcAeI=; b=exEIEtKO175hhr46o
	stOgpFoP2ju2zWl3Cm938ErxptBTLcWozObm6hy2I8StS7KsdkU+mvKzxQi6b4+E
	bayzdzcWnEHTe8mERvemzoGiAYcY8t1Ehophm2hQEB3x3LsjCiyZFn5Bi+DvJktq
	M5nkFed/HgyosWPSPW8b08eSsSkw1tsmX+NE47JAbdnSwx2gVOun99ZReknPzuM6
	kIbY+5RTj8JhWpGiBpO8rQzgp4Z4YFHfcAXeLNnS52FwWq05Ir9BXPHfitSfTVb9
	Uex+0lSCP/gndl4HKLaDgymKjffVw+l9x1peAlKk14Xhvdb7lxO8ss86X5l2JTYc
	pCTMQ==
X-ME-Sender: <xms:QTmVajdQwR_w4oxu_2DRF-xA5FNa5DGe-RsRqt7niKgn1fAHGTG6hg>
    <xme:QTmVagvpC5DmGwolyAVc13aofNL2uvuWeOwhnLvaOxPLgWEBSjVw4GGRDHA_HoOmc
    95iEjv1prIH5cklHkULL-CgZsch0PK6g_GrO634VufOkEUyJIKheg>
X-ME-Received: <xmr:QTmVaikyOvJj6To1U1RNPQty8Ei1R1zd-mcJzeY1jx7HFDhJBpHuSjW9Cktn_cmp9MTbHYeI3w>
X-ME-Proxy-Cause: dmFkZTGGv45yNZEVAFcnckiDzpTtShgB5u7mCs5YP5orSJ890J7bGUFahPSU03RmgLiAtr
    Jw4l31ghUGxCrG3APtLbl3i8GBubnvSq6gl6HKO8aHRUp5ikWaIvYCsJEGeV3tML7pOPXs
    CzEWC4pDFu+WHpAxNESshJYienY6rRqnAUfknBAVdHfefUILJ2XaoNpfTOvKv++FVGciMC
    B2ncF57mixOvt8aQehNcPNzuhLHc0b8pEmUA7/vQ2/jGpxr0FfbPNP2unmeFFHN2HVJZoV
    SLAAmz+ZYwpapuC6rFgs88iyyqWIh5rltqj2sRnN8oNbNaCk4EkbW41/vBKDpfaD74T7Do
    O/hEpNU8ZFEQ1F8xb5+orO0vAHY/Z7MdGJzBD9o7p9A+6bQuOPKDaMfbXREYsX9MO7W6JK
    ofXFSeW0HvTtXSTimAxb9+UYBAubavQMZYe5tGXrvQvRoNQ1uIycyq9N6cBq8peWhO5AmH
    ON8D9haiotqLqx3eAHHVTHQK8qjdd0a7Cqfb1V0/khWI+Cag77QcnyFriIEWDZmoLHWLKO
    +qepF3mCvnd1RdqjANo0z1o0BAEQ0Wd0iwjy/0jAiRX9hmXhMRf6t11d9m7cWfPAeiTNBB
    VqKv0wUaQAnNalA6H1aZg3GnKmylHU/7Qxnc91QDAlhNw7SI9rp4RKuDRB6w
X-ME-Proxy: <xmx:QTmVajA7VYedTH_XjIv8F-2hID_2bh2C0cEohR-fH3gApZNUkALTAA>
    <xmx:QTmVaqw0ZWDI-xZfU435OfjTx5kxRFvw2Tbi2QXE_LPyhJblc5lClQ>
    <xmx:QTmVandIHey5I0q7DZtun35Fz3Iu1-OwMxJSE9KTQV5isqL-65sGSw>
    <xmx:QTmVasyuAbxc9FtNgCXkb19WOhPd7MGFPFRhPvnJ2ZOBj7jpGfxHbA>
    <xmx:QjmVahKdlki_dRXT6iWjpdC_UJIJKVbOM3cbpaSQqqE95O_8CoPBncOl>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:20:09 -0400 (EDT)
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
	Sidong Yang <sidong.yang@furiosa.ai>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v11 01/14] accel/rocket: request the core clocks by name
Date: Mon, 31 Aug 2026 20:19:43 +1200
Message-ID: <20260831081956.84871-2-gahing@gahingwoo.com>
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

From: Igor Paunovic <royalnet026@gmail.com>

rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
setting the .id members. The rocket_core array is allocated with
devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
.rdev, .dev and .index, so all four clk_bulk_data entries are requested
with a NULL con_id (unlike core->resets, whose ids are set a few lines
above).

clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
of_parse_clkspec() only consults "clock-names" when a name was passed,
so the index stays 0 for all four entries. Every entry therefore ends up
holding a handle to the *first* clock of the DT "clocks" property, i.e.
ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
four different clocks.

The consequence is that rocket_device_runtime_resume() prepares and
enables the AXI clock four times, while hclk, pclk and - most
importantly - the NPU compute clock ("npu", SCMI_CLK_NPU on RK3588) are
never prepared or enabled by this driver at all. The NPU still works
only because the Rockchip power-domain driver sets GENPD_FLAG_PM_CLK and
its attach_dev() callback walks the device node with of_clk_get() and
adds every clock to the pm_clk list, so genpd happens to keep the
remaining clocks running. The bug is therefore latent today, but it
means the driver holds no reference to the clock that actually feeds the
NPU, which stands in the way of any future frequency scaling
(OPP/devfreq) work.

Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
/sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other
two cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
"fdab0000.npu" consumer at all - their only consumers are the
"npu@fdab0000" handles created by the power-domain driver via
of_clk_get().

Set the ids explicitly, in the order mandated by the binding
(Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
aclk, hclk, npu, pclk. After the change the driver holds one handle per
distinct clock and clk_bulk_prepare_enable() covers all four.

Note that this is a user-visible tightening for out-of-tree DTs: the
old NULL-id requests resolved by index and succeeded no matter what
"clock-names" contained, while the named requests fail probe with
-ENOENT when one of the four names is missing. That is the right
outcome for in-tree users - the binding requires exactly these four
clock-names and rk3588-base.dtsi carries them on all three cores - but
a DT that relied on the permissive lookup goes from silently running on
the wrong clock handles to not probing at all, so record the change
here where git log will find it.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba..5dd260bac 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
 
+	core->clks[0].id = "aclk";
+	core->clks[1].id = "hclk";
+	core->clks[2].id = "npu";
+	core->clks[3].id = "pclk";
 	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
-- 
2.43.0

