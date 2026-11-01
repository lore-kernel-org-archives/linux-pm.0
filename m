Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521411;
	b=I+eq/D9ldroYyLRcpL5gWQyD6hY/YDSTDd0bT+VeiKq+qmZ4cA3n+DqukYaIOcnyVpbD
	 VMs1yMkslDvGD7jSKLp4NiFh3CPxTLizno+kQd7gSBMnXxW5UolnEZC6kiYc7OXqdqKa6
	 udiAF5fjnJ9Kbims3bgItnyDo9qkHZJDRLnMKj3oj7Gyz5bV1KLsCRhWUajcXOXHKX0Kg
	 wQaWjzheXmJs+ewDgJw4jSMv0Ibd84yO/i1r9z06PmoAopHoSk/FwiL7+pNRZQG+n6Vb7
	 6ARtzO4Eje7P69FYzvZYnqdxjcEUGb1Ua+bF9UDjevZZ51+aZNH5O5sOBGsT/IvrfNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521411;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=0F4ziOUj7efFtwDDPlQcoGKrClzlEgL2KvdhJLu+LYo=;
	b=oJUa/zMfJ/RYTmqPeb1hWWupKIkGOtMWwz5C+rpph5beVs0eGFdz2rl7rnjl8L5zKG3W
	 u+8INd+H0U5B61CIobn2s8+wArdx8HKHE3A8xJ9jTkvO4MfEl66PG7Mc08iKmDDEfabsY
	 OWTconmYnmopvn4raVzOUXFyk62U/rcsOfLdFnM2BP7xq45HNNupqUmaYe2fW0Rys6fEe
	 u81SeZOj0ER8iCIjgAwp5+3tG2W6dq8AcEQNAC1RPNhEloh5t6w5tcUcHuWB9/OcTStta
	 NO5ifZ26NyzMxMGUkdCpMPsGW0nj54t825UhrckV2j+ljmEM+rN+u1L5e6Fha0S8HEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=RBYBhfnT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nnOiBoPt;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700D606A327
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A700D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=RBYBhfnT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nnOiBoPt
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E9553EC0691
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:23:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 01 Nov 2026 03:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521409; x=
	1793607809; bh=0F4ziOUj7efFtwDDPlQcoGKrClzlEgL2KvdhJLu+LYo=; b=R
	BYBhfnTJAjhL5vpv6QEg7Truy1sIOQdLPaVevuXG8yayd+wCxhMo5vp3kCaNmnSP
	jBiNG3TPgn3Ab9yexr0eQQuXnTtMbmGXZSkMITwtP8QWdBwRtvmvTU8Rm7F5LyBK
	1pVkWaCRawBukouAscccbOxAhPeuYBr9uPZRA6A2QbghZ/d9LS7i5XCIzDS/dD/5
	zjzdj7imuB7K+WLbLq5mhz2HxZoHy1HH0RkYPVjwuBXH+JgtkPRI8V6uzREwFVPn
	jePpunE9BtFt177SXZWrBSASUheR+9vPr0e801/Q8NXhf7Fofi5Y/SXiPviu7+17
	0ZviYJpsCUQt8shEFwM3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521409; x=1793607809; bh=0
	F4ziOUj7efFtwDDPlQcoGKrClzlEgL2KvdhJLu+LYo=; b=nnOiBoPtvaCP2aH31
	whszeALOYHRvcsVfeGBOLJtACp5ZVA7dHx9VAlYdQBnE9Wovp+BlV0BPekmsFZp4
	rRBf0VFqvfow4jbHhyDzSQgFljmMIt0LaDI/IVqRGApE5W/GOscFGiBvuuxq+4j5
	JFFIJMBEpPKOfsX+p+RSwwpW+Pq6YQvWNbKPAHv8n18dO+0uCwnxwiExwVoB6SIo
	h8hPnz4I8SInrBM72GLv4pnc23k+NIXr+S69+0jNeQ8zMb2gPH54dUhp2ki/HEiE
	YT0Klh6RCdoPVmaFxHZO+7x7yWfiSebC7/coVi3tuCQtd87q1KzXRJCTbZT1ZtGc
	ZGrQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521409; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:XRUsVgsXdd/LNsn7wU/Zw2QKB/cOPYOgSDAm3N2iP6shiKO
	ml61Gax7rmq4t+eyvwo9J5Zy5pV6W1CiOKMG2lE5wq3wK3uw1cRBu8DeFdWc1LrK
	BiwkUmZTeL/f+zySenwrhbewPTTQzqZ0hZt1jOD/+NAhT1pwOovhDQsG+jPq6vzw
	lwobSbEEiA6FjjlS2W95ziKYvVUIS458gGQDZP+g+/mNuX/akVbXpWXmqStye8iF
	wbESNayTEogiAvSsnKo/9a1/uvvsS0ioGI+Sa5wr9bm3snqEO196yiA066QWkGFt
	VWaVjD35SzWH/D54EiGSS8fNQsd4Nr/i0qeBYQg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:G1/pb7bWMT/0l4LKBnibCs1YsTx58iSaXfSCsOSviSY=:RJHqqy+W4Is5TB1jmXvzdduGEtV4nfkar9l5VxBVQp8=;
X-ME-Sender: <xms:Affmap3zOfLrTH6mkEpyplCVeQoRuvzLBi6fPhYa0dpb4Itbe-I5rg>
    <xme:AffmaiZsQYuVQiGK4x1DQS9PsRbuMWpI7Swh3qqg6eqY8qrVvqXe1_0Fm4CP4aEXC
    ID0T1RhGyl_5j4MH6-tMPomfS026dFuDWp7XlBQeefmorRaagh89NGU>
X-ME-Received: <xmr:AffmaomN4NU5wqKBv0k9OdEKuDefoHg_bhcTNd4uL3fngiTq6rH0sMitfYobQ9R_gdgZfzdf>
X-ME-Proxy-Cause: dmFkZTGyh+h4Oz/02elyRzjcRRcFpvHFjmUJCnxNp2cKE2We77OzoK7VQLrSm4eM2eB7ES
    ZXYJNEUB69Lfmlo4BbDpozx55aBH3xHf569WnDWwtFhUpPk0WaG27oVgoEA92BrPX8ybbG
    lVvCv9B4GY0sGCL8lWuvRRdhYtj6CDshZ+rxDIsdVMf8F9QgOg8gXc9cdCOHkH1m+c2Big
    hig4aNfN4nuBefG3HYaHLHaq5rR0CK8cq0/bqlaJmEt4LbTynrCCTIklU+JAaE7AuO9r4C
    kC4gllUxYkdmDmdmnXTGCC9WevcAeVCB5BLLAP0zSIFYTrZTsiHavZssNvQ5oV0hNi/EPh
    5feOm0XUl+SWCfMTp4hdGGBkl18RkQ/GdgUTQO2+OvQVGbAugHMVKCzg6/ACXgxOyvHV7k
    6aCaeEps/8tDDS2rnQmaWcy8qHDbBW9DCwqbIt8E/0w5phGT/QbtjqDCOCAkCevHnl97jo
    puf3BDYDwQ0wFHMpNo3QErTk1Seiid/EJTvYfbPQtekWBzUYhZo6IhdKfbI45EvPPGi0D/
    6BQIJiaAst3IBvngMinjIUR7dkkfcFMVekguEsiCfILz2i1HJHZ0mgCKf3h6bJZWHEKywp
    9MOtiQWwRCYSikqW0ZS0CdhGzaWs7z0EO4dUqw4lT9hmAxvlaJldIrI91G0w
X-ME-Proxy: <xmx:AffmajxvPpFjPx9OhgdK1cXSZXxTDd463AaYHGbV_a1M5y8JwnwPHA>
    <xmx:AffmapthZiDK1JPZhANXPK9q0U-XFvQYdvCAFWtd9kOTNnxeUjClsQ>
    <xmx:Affmav-A_FskCpt9z1F0QDDIWD7s6ltzKcd4LZXIc6jzYimr8iIyhw>
    <xmx:Affmao0c8R2B6ceOZn0-Xtfv5tgvW-l1tU0Wi17xq41ZmF4xxe5rBw>
    <xmx:AffmapfKsPU94dKmmp2QoHp-o6fIx8c1nSsTPyfX4ekNLocoe1RjdL68>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:23:21 -0500 (EST)
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
Subject: [PATCH v15 01/15] accel/rocket: request the core clocks by name
Date: Sun,  1 Nov 2026 21:22:53 +1300
Message-ID: <20261101082307.151957-2-gahing@gahingwoo.com>
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
index b3b2fa9ba645..5dd260bacbff 100644
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

