Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521538;
	b=fbeusgYdf7dDXSvxOCpCuFkhxHJ+mJ31xHXpvZuIQIHq/arp/sGFiBSszigfRpN4N+FT
	 ZF8QOezpr5C5/70dltiYk6ivfRkw9MsAi5kF5mm6Up4pV+ySlntp9mmW12W+Y964p4oRA
	 7P4pN53QfyPSFbP6kRY9KYImy9saZi1gy+YYiEFfZdtd2LSsz0sTRqieLloe0TmQzKh5v
	 PbsuTwhGHNp7k0yhIO5+Yfv2yY8U7uiRxRl/wAKwvku3Z9iXmcKPklr264yNgfZYiUF7s
	 wZfKuDUydE9jMlJHygGRCKkg3gKP0Q5yoWYxeIFwLoDldCBLIxcXo5luERXRKKBJ93A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521538;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hehxHz+XcJJW1FfdyU2uS9OwIFl/78x/QxuIZj8So2w=;
	b=rX6K1dcU2BIQNbT+gVtI6cdUXQq+A0IGOu/aMFLKeEIgvEcUD5YL0ANl95jlHYjF+gVV
	 Q71GwrBbADoRC0/xaUaRF7P9KgT4SRpDkvGSDjGw8KJXT8xxT8F2LAeTFUXHHNKDxDWiS
	 8MJJqxq1HWpCVZnXFnsxwLFQ+eB++ISrCbSQrt74EwpOLkLDAM8Ob5OdDCPIZ5HWT4dSD
	 9qSoIrNqXX/zPlgqDBW1+EswJgr6hArj3uPS3UD1OPxmd7/h/9d151T43i9McoQYEW2NA
	 2bf/LkvtKkJGosDuPP/1YZ4VN0zTgNOGLrKiDqfWU08N5MpCiwuUwI54Z6tC4e0sv4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=F1OyosDr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qTFJaxHy;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84916606A329
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84916606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=F1OyosDr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qTFJaxHy
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5D5C1400314
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:25:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 01 Nov 2026 03:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521537; x=
	1793607937; bh=hehxHz+XcJJW1FfdyU2uS9OwIFl/78x/QxuIZj8So2w=; b=F
	1OyosDrqNCkSP2mO/T96AAcCe/M94LZvmx0/bUH+gJ2UfjxYG8kB2TFHdde3LpEx
	EIyKA/0dEhHHpon2dU7nr1Dp9+KcHS2LwTkrd7Yauy28PXQkjI1v+kgW+0rLoacP
	XRFks2/GElmgI6n7Z59y2tQX8yygjXUZTdJ7rV8WqEhvdGsGVSi4X5GjDXMUjVTz
	0bwUExMRrBSdxwrpuiCBuxA7ODrM2Og77LTU+MXf3ZInBm8mWOaNTS0SZgcYMTWY
	VQ3QuL/HIaX1H3u15OsvB/X9LFXildzSwAMTPd8s1N4WEwn2Isz5ipjLpHbigZhD
	WpEblTPbQftNI8oiS42OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521537; x=1793607937; bh=h
	ehxHz+XcJJW1FfdyU2uS9OwIFl/78x/QxuIZj8So2w=; b=qTFJaxHy++nTNAxsG
	A0nIBUSdk2ymDVbuQltMsu76UTLhEhPioIW+9ZbtQFv1zfkZpDrMMfjSjuZ418TV
	8rhUTLfkLL57SXA9krgEJQu34nEd4dL6SRBWqY5DTMXYhrb7xaHUPS86WY/E3Vgh
	iFY5kkB2sm+xL4p70lG78DQlO1evGRuFM8iKff+tVvQ7OMPtGnwdqXX2qqyUPXiB
	B0v3TAcGZCkkzOOWsnC4p1S6I76iE3U4xgCxcBiX0P1vrqIEIzuY8JSusHejjANz
	WRSqQsMizGZUbSc9VJs1Z4lTT8XxxM2F8gOXBfOIqNiLHL3x0tSdL1liQp7Zwc9y
	wM4SQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521537; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:pEsvgvhnda/JaFGGDaYZjcEM85hWWNiOOIU+2Bo85lIouxy
	qvs/7AqPKxCiW+KIRdy80B3uuFj95zHY3jyvsFaRGCBdVCSUMFIDO3atkAnm6aTR
	zavvSTvewQlW8x2yLCSHm6OV3/WpVNAg2rsnHnKpH0+RqZQ6Rp74NeoKhK0WguDt
	RA/Vwre9UzWn7r7x6V+ia3Uefs//vhoAIGj4Cra+xCoH7LjDcsiIj0Xs7K3L3lDQ
	5INqk72zoqmcmVLUHpUzva7dRYWZA+HFVDYf5n5yHE6PPyo44qg/JfWhjSY31B85
	dEUe5qLxbbpVO0o0sGoIsm4ZUSOhQ2aPi88VqAg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1T9sEsn4stlUbzvAo1DFzO6Y7bqkN0G4xf3cjg8UAQo=:IqkVwNLAKeppQo2g2DvGaDvnWrMWjd1zZ8rdYrfeZr0=;
X-ME-Sender: <xms:gffmahYGOE_EauUhvicO8XtzULw7C5fQNLqTYVpU4rVBgrh5NEEXOQ>
    <xme:gffmaqv_k13JP6UAXJCKr562AbN11_ZJ0tnXaZgKADVd2yoMwpXngp9j-opPebzAw
    _0vXrDBLnSbvwG1GorKpV-22-NXR7CCCzFnfkuQtpfRt3xqR2C6O1ER>
X-ME-Received: <xmr:gffmairbLuiQYok1wTYMyFe8pgPXFHCWlY6EGXjzUd2BcSCyUKnB9-6QJEPrPbJMlb4i98aB>
X-ME-Proxy-Cause: dmFkZTETy3iq6shVyHvrvogT1vA3sVBaKllPQ1wQ4LJMhjF44qU0s0XZ8eLq/k6yctnKst
    MQPxEHxz9rrNjy7Xu2B++/5ClKVy+wWlOe4prEQQ1cEZShiRkH2Az4aoIaQ7tW8kjSzcT/
    rzySxuLXzlyEr2rtEtR/nzCISg5bgzc2qBGIAEm8GSq2Oqw6ayxglCo+wJhexK748o/Vuq
    VCZ791nPG3/fm2XPz4N1DAOQHM301syJ+x8WNVw0p1WeHLUL/pESRogs2PT0nTCL+D/AVe
    uMFe6ZJmkMon01iwUgCmMMmKB+Akp8cbOLKrT/8zAMxMIr+tlt223iRbsj3VTWGUq6v9oT
    RmZ0SkkoTZMt0nznFQX0byctVKpH5l51DBkkRVzZLRpCfFPmAtfa8i2Yq/HdFiWlL+LRKs
    lbKUUZSzEoxM9QrNM32K0hKnS3US/TfSRW+RzArq/klP8U1SffEqabTRTa8ubvVd4o1qhW
    fdzi/G5kp6MEPddUinb+gyxFBefJoWkE85730X/MOeTYAOeWe8ZhxiT57dg7mLfuI3gG+t
    B4SZ6ed7sRz0xdMmpTkqJmr6JAI1VZ9cnT7OxFsB4NERbxVeCCI1vS/UH6i/RtYqq3g3Ct
    9aHNwOTRPqrNPyc759Bg6rGse3d4fWrdtm6+tA1uIqNUm7mgaeKYSuebFYPg
X-ME-Proxy: <xmx:gffmaskiwOSG4D7B8uVJkphbMrxf7kA-q2fIYWsl4Cxm8MjiOFEBAA>
    <xmx:gffmaqSC7AE6jxU7pdPlQS36gAIBIbAO_X_LUQUDEGHiyiVOTyg83g>
    <xmx:gffmatSnEibMpZl74QfEaGftsL8SHuSCWox3Bzs3oSXzl_AOYiPufw>
    <xmx:gffmaj4Dn5IIGnD9bk7Du0LTyYRMT4FmpnEaCbx-0xM6DChkH0h2Pw>
    <xmx:gffmaimeuUabua-_M1ls-3RDh_J9Ex5xFsLsFMi8RR78yxXgCL4Uh6YY>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:25:29 -0500 (EST)
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
Subject: [PATCH v15 13/15] arm64: dts: rockchip: add NPU core domain clocks and resets to rk3576
Date: Sun,  1 Nov 2026 21:23:05 +1300
Message-ID: <20261101082307.151957-14-gahing@gahingwoo.com>
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

Both NPU cores share the convolution buffer and the DSU, so give PD_NPU0
and PD_NPU1 the three clocks PD_NPUTOP already lists, and give each the BIU
reset the pmdomain driver cycles on power-on.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 9d9e9d7868a0..ea9229b6e6f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1085,14 +1085,22 @@ power-domain@RK3576_PD_NPUTOP {
 						power-domain@RK3576_PD_NPU0 {
 							reg = <RK3576_PD_NPU0>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN0>;
+								 <&cru ACLK_RKNN0>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN0_BIU>;
 							pm_qos = <&qos_npu_m0>;
 							#power-domain-cells = <0>;
 						};
 						power-domain@RK3576_PD_NPU1 {
 							reg = <RK3576_PD_NPU1>;
 							clocks = <&cru HCLK_RKNN_ROOT>,
-								 <&cru ACLK_RKNN1>;
+								 <&cru ACLK_RKNN1>,
+								 <&cru CLK_RKNN_DSU0>,
+								 <&cru ACLK_RKNN_CBUF>,
+								 <&cru HCLK_RKNN_CBUF>;
+							resets = <&cru SRST_A_RKNN1_BIU>;
 							pm_qos = <&qos_npu_m1>;
 							#power-domain-cells = <0>;
 						};
-- 
2.43.0

