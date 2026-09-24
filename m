Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6C45DF68;
	Thu, 24 Sep 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245325; cv=none; b=B5APZ6EJMqreI9EAhrrrGbzhfwRm9hlobty0gv//uwHxMnoPBC9k2bLKHsi6MdXRrDo62Bxv7A2YSs0uHtuXgJpFkx5FIjsLUh+rv9nm563wGFqgN9el/QOalrtVBrrooicUFY5c3j13EI3RVGV80Wdqs8h0e/BmC1RokJKYPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245325; c=relaxed/simple;
	bh=NzFBEuKw+edBTPRDPqk05HVymcwE1+Hsrc/T5KLMj4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Afcva6ss9RtZJfvFKFhVqfjW7PkdkIh3b3hLmtrqhC6WO9qMNy3uEWYLm8HWMEpFBD+Rs36NqkqrvlFMJOrLCEs3UYPHttbYrypX3+V9dBQH+Z+9DwIXzUbGWHFqjw+IpT5ro2Eh3JUZphoTJgMINvy9yFmLHgd4ozpAxgIMQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ZAN7AZIC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ah3ffRP+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ZAN7AZIC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ah3ffRP+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B79CD7A0052;
	Thu, 24 Sep 2026 06:22:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 24 Sep 2026 06:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245321; x=
	1790331721; bh=bhEwuQXKYWMYM7UfAE9zXDC7PfmHACUKFcOafx5HkO8=; b=Z
	AN7AZICfZ7e6jDnZhxpB9PUzoV3hLBEM1W4Qtudcvb8XW4ckpU5D1uwNGHJ2ZnWu
	82dCTxcB7EJqa5JLDf3nLW4hKiNXaZdmA6P6K3xIT2BJvD3r6vF87tjKlSstJCDS
	9fJ42LGGnMWcWqlq3aL8zblG9+Q3DqZqFmkRHZcPpbUOKRKqpS1VtEWsbBfcp4vq
	RIcTV3jctRus2t+Gyhm1JQyOyl4XPKecROuBW4FqLxmU59UlKN+ydjVHNgC+8rS6
	EbC56wgVmKMRU48MlWkufis8R77/ds9C/0q8H7pZZeyg2sRxwX60iaI1nvjG1jUQ
	YQ7eoxcNa4jxKZMDQIe8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245321; x=1790331721; bh=b
	hEwuQXKYWMYM7UfAE9zXDC7PfmHACUKFcOafx5HkO8=; b=ah3ffRP+jAqff15eV
	LPT7T8o/VQdTo/POXaP+BMAFTzTQK28GHUQG6gOFXjooMnDimxCbYztKA/WzBLSZ
	XREqj6G1l50xQSzIml5PQ3Yd0a1hhNM8RYDrSaAcQE4CrBsnHxLIGzSQmhxzWeQV
	lfR8QPJDdeKWXHRB57OUz5ZNAPRzZ6NQ0iceq60Wyt2BRGVWSXqN2FZrF+quQHeq
	WKEFdaz1hCMykil/kQUkywwlKnbGvxyo8t3jnmIEhnI1rRCe0bmbjpF1PoXMa0kn
	ZiaGAa46e7uOnkzk0PdW5Yrg5U/uZmdof2Rhk5Z28KfBr4EhwsTqfUC7EIH0uJcn
	4kf7g==
X-ME-Sender: <xms:yfm0asad7A3Da22Rll8jQGVNriupFxyr9JBfDfkd_6TSr3AeMx_ARw>
    <xme:yfm0anjxDhjWzvMFlzJGG30sQyEann-MQnOETqnybyPi06cu7B7biVNDdUknqYyEo
    PoKn3fXYnR6e4NXCREWkzSHWhHSs4LADRUznCydrIagmV8-ZFuEbWMa>
X-ME-Received: <xmr:yfm0akz-xFCSHdI1F0iLdm-_BZTAOhzEu47xVAk-FTem7QV3It1ml6pW6lwN-qlTk9DNShlDDw>
X-ME-Proxy-Cause: dmFkZTE5U9DWJ/1d8NZBV16bjZrXhnu9+RjSei8Egg+AJBodp1SsqcAZICkdFDYYk8PQ/z
    nbl5nAv32NCM/Rvob60jzzR/sJI+sbtZKf4EXYq6NkDnWs3QsBAvLEkGDZPcVAuKZu09hj
    kufWDx+OHd427BpEwAmDDK2HcwDl5PIVxykoKPNTzoVswPV46/qyR6Xp/JY/TaNWyTgMqq
    yMy5OLUd6yAzE6clJlYL4qCFZSrQCDEMACpcb7vwZPjxoszy3u6FTeAITQlCqDvBOfb2xA
    f1SHw7kF1Gfs8fOU43Noc1IHs7QEkTjIEBtZWO5SBQ25T666ulWx7WKsjltbKYna0Y/oT0
    E+W0Z3CE6nOJgzb2tbTfbc5qfAHkD/1VVTbIYhLHcbq3ozpFHR5ZJDRId6v718KKPoapwL
    izW/nh3rjZWFbQ55ujRw2jsXmHVK+YCMAhIb3gMeFZqbM23q21JYb8LOxPUgazOTtctXku
    CWVnuPIyMw+4NrkiiRyn8MBQIOlxFmANR4rUxenOb6ynawyJKlXufoUd4xIl/a/hiqr8ox
    YP2MK5v0A0U4H9cUzF+SZID3mshCSj6Ikq/v3tjGq7UiSdhtvZo/CsGYAVRzdTB2LUI8tG
    m4gwKoVrLsBlp0NEkcRF5Qo6qerHy6/loj+kcKovjkF2yIQralEKsdzPTjzA
X-ME-Proxy: <xmx:yfm0aq7NXUqOfFHwJwhTOe2DhM0vj8P43sRbKsZILFUTnS7EaUJdbQ>
    <xmx:yfm0al2VPMtCjtwdr8_5AsbpyyRdbxcldZ_l8pln-lJB_YgoCr-CWA>
    <xmx:yfm0aj0aP_6X8O-6s2DfYdNnC8WqvWUF0LCFd8XajfC_CxxTmUA5dw>
    <xmx:yfm0akcgH-xgTzxzz3b7UfpWezgMVK9DGyKFjK1MdRxZiA7odQ4Scg>
    <xmx:yfm0aijKzDr9zfFA1IKoWhCkf6F3_HEz_ydZObfMeDoR4bl_0L1PTwQv>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:21:53 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v14 01/15] accel/rocket: request the core clocks by name
Date: Thu, 24 Sep 2026 22:21:21 +1200
Message-ID: <20260924102135.92217-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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
of_parse_clkspec() only consults "clock-names" when a name was passed, so
the index stays 0 for all four entries. Every entry therefore ends up
holding a handle to the *first* clock of the DT "clocks" property, i.e.
ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
four different clocks.

The consequence is that rocket_device_runtime_resume() prepares and enables
the AXI clock four times, while hclk, pclk and - most importantly - the NPU
compute clock ("npu", SCMI_CLK_NPU on RK3588) are never prepared or enabled
by this driver at all. The NPU still works only because the Rockchip
power-domain driver sets GENPD_FLAG_PM_CLK and its attach_dev() callback
walks the device node with of_clk_get() and adds every clock to the pm_clk
list, so genpd happens to keep the remaining clocks running. The bug is
therefore latent today, but it means the driver holds no reference to the
clock that actually feeds the NPU, which stands in the way of any future
frequency scaling (OPP/devfreq) work.

Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
/sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other two
cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
"fdab0000.npu" consumer at all - their only consumers are the
"npu@fdab0000" handles created by the power-domain driver via of_clk_get().

Set the ids explicitly, in the order mandated by the binding
(Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
aclk, hclk, npu, pclk. After the change the driver holds one handle per
distinct clock and clk_bulk_prepare_enable() covers all four.

Note that this is a user-visible tightening for out-of-tree DTs: the old
NULL-id requests resolved by index and succeeded no matter what
"clock-names" contained, while the named requests fail probe with -ENOENT
when one of the four names is missing. That is the right outcome for
in-tree users - the binding requires exactly these four clock-names and
rk3588-base.dtsi carries them on all three cores - but a DT that relied on
the permissive lookup goes from silently running on the wrong clock handles
to not probing at all, so record the change here where git log will find
it.

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

