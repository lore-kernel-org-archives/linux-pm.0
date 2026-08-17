Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3A409276;
	Mon, 17 Aug 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966696; cv=none; b=RBW8tDzuiBgQdZGyG89qpYn142NxCRi0MkWYCE67bgP5NDZclbdNJ3NXym2cdw2qaNjm9jiyGmtqdcSL/taghkx7TQHEAypOFgTTWXNA6KRaFPuRNu4im4l99JZeF316E1bGaA8kAwXS5Qy2Hn113MuBbZpxRSm4ZUSQC85ziOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966696; c=relaxed/simple;
	bh=rKtYZ4cuNw2XD4BIP9sPPE9g0fpAvvKP/Sfa/QGMjIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsJ6E0zFNEWestXz1zLrkLuzo5O3pVCOvVNlBvRgwynI+OUOzUarPae/67dbTI98bq+s9WRgOWqlSidvXZKonp7Z5ZStrGW5tyNhczEF5GmCr6GP8wesPb9qDusY/UjO3cfsa9GC6f+AapPuoda//uC1WZ6hDwXpWNvIvgLEow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=UC6wXu8v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1GOyFvU; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="UC6wXu8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1GOyFvU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 9224B138014E;
	Mon, 17 Aug 2026 07:38:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 17 Aug 2026 07:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966694; x=
	1786970294; bh=yyAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=U
	C6wXu8vzA5KTRsum1Hv57itUDhGNlDDKahmNsuxgF2YX7zRphrSBdny8pybxzZEp
	bbLtl2INgh3Ki6IHBfjBBFSM4i/kGv0oNUTUUQoJoLLNosy95EVyzQNHgVSUBnsF
	CWUFCLB/x2yo8GM6kdZqFF0i6gP1uEUlerGtP6cQzQPL4dYeBz/ZAb0jAdcDiZ70
	1WFqSYLr7+tl7xcNHKj5O0dmEv4sf7dF90kDo4OYX7W4dqXUf9k9YUGzHTzNSMef
	kwSd3I0kYwvVT7ZdcKBs7hc+pkUhZv3G6EaM9J9eY7OiQy5clOclO2KzTTdJO5Zc
	JWuzMcE82tGYv0cpxmQlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966694; x=1786970294; bh=y
	yAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=H1GOyFvU2D9cY8bGn
	CQduY643hst0y4Df6rpLRDMtNi+VbmpVATovQP9iKyY3YLOKAiv7IQ51bW5WJAgF
	cej56PbW+Q2Np2/y2KLbQKhc3QpThc917+9v3kXMVzSkcTmzGS/hL0b6sx+4o+Q9
	QO+Ukh4sHxDK+R6uxCoIquArN6YuBvzFWAJEc3XBBPiSMVKqeUuJJdvWgLqFgIF0
	Cc07Gy+xgN7hm2kcHT//DxevgjJ3JmyBMWOOQe+dr05DEpSdJfcLU5idYtwrgbb1
	1JXoY7uQREkB+EmTUBFJU3RbrVgIA0sEzWQwxuWUFXQ83D8z29jnq0dHZ/tlFPqu
	/9Z4A==
X-ME-Sender: <xms:pvKCagYqCmrr3DWX6tlQgGORhEcF56bN9PR6AwAM1_JsE-bfk6t0Ow>
    <xme:pvKCanh3P5IAiKXpW6kPuosAgT_r_J5t2HFOgTf87hSproRHCUQtru50qFVFdvLcm
    AF4uS4ONyqzyA350Qd2WW_V_Kgnsza6yS93AvYFSX45k3ktsjmng4c>
X-ME-Received: <xmr:pvKCamz6RaW__STif3I47ItLLGovIrMbGVjnXybdbSGKXHu7PCmMfcA_gVPMxVasnTF-R7vZnA>
X-ME-Proxy-Cause: dmFkZTFJpbjkSDT6AcryrIHhgbEVj8SvkD3tgmT76I8WU6lQDo3YUCdtzXxAeg/zKqpB+E
    Srz/I8ZJc3N7HCrgkTkwyaBZdvHNOdURxqLv8+rxKpfV73gGv9LWiSebktKgvlTsmvhDvl
    7z8e7P5tVZXD1XfHmjG3x7RlOqfrClYofT98201dsDsGzeGalaNI/cy87SBMyHKVxLpD1H
    cf8c4VtlmLV27PNqhGPBVow9iGRSY0ganIZ7M7ursi5UKI38krV8lOdP4K1YQOgw9wIEpu
    SQtDihQpP3WqB+Si6LCioT5pFEw0karkUBJswAF2S4IqKtJUmYgRgB9BVHgg2tCz+ac+s9
    epDgVkO1FTH2DrfrjlowXOa+VdD4IUyGBQAAqcCFT0Lcs6PlYJ4YcbQ+tZT8CbcX7vs/WZ
    pt8R+i7JQFMFcw1yjpAyQbbfcPaPGKdkhycUsl0htYzlfl2oIk0yDX2ggsV5fl1nVLAFr0
    dgl266Gp+IJ9IFQjRk8vrshqbDYhh94/pGxW16HcOhGtHxK/HxWiHdf/Q5NMTvgiSW/da5
    5Z282k6IQtO580HhuRbYF4I/7m49p0OVQTf7OmVFiABhF1B4nQGIPHVpycbGQ9g+JaD6c0
    40KKE/5EHpextBZxpKXawkitOhohNrUMZReC9KfZTd2OQLqgKjtZvf3YCyag
X-ME-Proxy: <xmx:pvKCaj9DtVQT2Kmjn1gjQvOMhfxdVR9KhPj1taeShUbPCHveWYNc6w>
    <xmx:pvKCarzsqohJXjiOBRBfvzBO-GkszcinWehSj3uAAYQAIgPKZOyngA>
    <xmx:pvKCasWpNmDCfovS3gIQVRLyNBTX12ejR_6ySwfli0REutuVZUaS5w>
    <xmx:pvKCauaj1W-tqM99YvKPWnr074IftRvD2CGSHp8FgAK7XCROb6dXCg>
    <xmx:pvKCaps1LB9jOslpzMTc4hVbm_jGnBA96E_HidWVQp6YWhLTppKKrVTd>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:38:07 -0400 (EDT)
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
Subject: [PATCH v8 12/12] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Mon, 17 Aug 2026 23:36:03 +1200
Message-ID: <20260817113603.1436067-13-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D, and hand
vdd_npu_s0 to the NPU power domain as its domain-supply, so the rail is
switched by the domain that gates the block.

Measured on a ROCK 4D with this in place. The rail's regulator debugfs
reports open_count 1, so the domain is the consumer that took it. A
sampler running beside an inference caught use_count at 1, and three
reads at rest report use_count 0 with the rail disabled, so it follows
the domain rather than staying on. Over the same run the genpd
active_time of all four NPU domains rises by roughly 60ms per inference,
and the inferences either side of that are 128 of 128 channels against
the CPU reference.

rknn_core_0 keeps npu-supply on the same rail, which the binding
requires. Only rknn_core_0 is enabled: the driver binds one core per
node and the second core is left to whoever can test it.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..79e039bee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -722,6 +722,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	hdmi {
 		hdmi_tx_on_h: hdmi-tx-on-h {
@@ -779,6 +783,15 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
-- 
2.43.0

