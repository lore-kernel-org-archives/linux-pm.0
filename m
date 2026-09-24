Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0B479876;
	Thu, 24 Sep 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245471; cv=none; b=lSDdBIBUSg8RgNGqpfAHjGLZGXGIp/Cgrk6jYJe3Ok+d+ETbWFA8Z8IoiW5jf/mE4JEujxu31hZ52qohsiUat8k1RKax2UGfe2FCDA/+xh2naVxSzejXa06k0HSXo4pxcrUXlDZeeNox5fRysRc6CQbKwjeX2hJsUcTzLLmZCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245471; c=relaxed/simple;
	bh=kwiEQvEoDFO387fc8Y8rhCEBnO8WNHGjgiVhQ4e58is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLvKKnBrtEEfbBwbfkfIrgWtl022awbcJbHOw7ee4oCMDYqnF8QLUcBY2kNhkIj4RHQrxbjsYgDw3jYHyJ3YIw8GbMZow/cMn5Z87aqGtIbkjKLTSPftSQynwVtkdMFSxOE1oJ/eIMWPiJyiF32HWYowofYrIQlh1OHVyhvY4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=OXZbGBj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpkZGKAP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="OXZbGBj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpkZGKAP"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 292197A00C1;
	Thu, 24 Sep 2026 06:24:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 24 Sep 2026 06:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245469; x=
	1790331869; bh=6PrxhMJ+bPB8OpltSSCWTE8BVpTQwvXCSISkeXWvIiY=; b=O
	XZbGBj8+T5lzcBXJ6DbzWckayeU/jx9fEUBd1Z9ba/dCOnmIAMsAQHgfsN44KPVQ
	3WpQyZXArTNz0lWBxMhySJmoyJxrKoSIRTT1/T43he8T9eJes4thIhjn1fud+GI7
	PCBOyr0IOA2wR6+mrdXh0JvTmOYJUyeYYz1CGKaYDCaq85C0p7hAQBtOBNud71/H
	aSW3FjLUXN/+c7k5ahF3hoZrwsWciY4oYIZvzypnco2jKY3r9IXs+jhS0dqtnYTR
	ii+r7CIdBx/3fhm7OOm4B4HRkjjqZF7/bSHAc5rvEFB/4gxmQIdEmxLiyxvbuYW9
	xUxZ+bAT/zkAW97VE3Raw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245469; x=1790331869; bh=6
	PrxhMJ+bPB8OpltSSCWTE8BVpTQwvXCSISkeXWvIiY=; b=wpkZGKAPPHYcBNd+V
	hQ09WHv+Jk8Q2ENxxYXxTHbz75MRVx1S8F8TFI4DyjIMbCpKHQ8DhyvcmsbQZMD+
	AXMdNySgcSlpzUWvHe8RIvkIHRKXB1eOlM9+NBkrD+3NoP2swxUHnOv2pMiXWbDx
	Il3y1iTFfKO0AYXu9K9Li3kZwXTE0syGlMA0fYDPZjv+1PykKsYjYpJtQyYt9xBu
	3eHbpYDYWDA2Ju7yBPRi/SPbT3FBtoEYK4qB4L8xs1pqS9E3u054qTqcQrkJmjjU
	5Q2O3wiZFgveVeBWHl8vWG13RgByMVdvgTgWzS1h2TRwP3Cb3Ql+js41r6BTPTgL
	ur8jQ==
X-ME-Sender: <xms:XPq0al_1SH0uuiHW2uI4uyJZQEpAomtBA-azMzU0xWw4JfWs3hnXWA>
    <xme:XPq0ap2zH-hMfZ0g6czXjU53ifnn0mPzqUzJV4Y9BKtuwDP6_7_w77juhGfdh3P02
    BvBmugk8ONAMcWTuKPp0UcMFiXsEoM18AueSwFcKXuA71riISZx27Nf>
X-ME-Received: <xmr:XPq0ag3mcAYRAbYgjPOHOp2qROr5tHeOKzkcHE3gygyXqLD1Q36SJf1epKJGZHc9g5lpjNQnPQ>
X-ME-Proxy-Cause: dmFkZTEBXYU9ElO+94qJ8ZHudHNBHbuza7doTwCtgpbgd1pTdTbZKfrW+V7RUYO8gbXcVM
    dWcDbNbjJEPlrI62aK8xUkCwNf2u1C12tHkh3U5h2/TCheoYky1YSdht3EXYmGzOmMkCqu
    eAmKSeKrzy+zrR2U9yIZ6iBIFM+/JeqkOvqv0CPyWVgl6sOhavMEilcrkUPkEaFA1QyjG4
    HKSUze7wVMfOQPVYNC5kKiS1ccvN96KEYzBczq7p3AoiqTymtY7XRzB/GwkjQgpBX3Rzo5
    NxmhEp9g4tRWhIeX0obdYE+jVZa16cHIZPYpe+Z5pS5GriA8Cj3jKqvvSrfBffw16mObXu
    dDi3swy5lh1qoNKC8cOg3f4jVfvLkbeq25/sG7pI5ILDUhL8Un66qJ+7nd/1ATqmxmehmv
    jaRuI0jeGQ4d1+O1ND2CrFoLdLojI1oMmSkbhRcoqFgAL68dkuyiB00lxNbrDXIOpuseSy
    cejOlSAGgrqXObvWFvIYfs9FGWfGAsOmdOO3rXCUq5hIqyD02q8ZiyLz0lN2HIXTXY+d6p
    GMhgq/Cdqe9YmSYJwH5GoLoqXHOUP95VNfVltr3JD3QS2W3t9BobW2kNnvc+KQsk4EBV6S
    g0FY6T7DQFOiPWiAEO4wkkWnDzC9qND87QHlFpEas1XKvcf114bHUSINTixQ
X-ME-Proxy: <xmx:XPq0atvgshrOx1Z4a8WnLcLsEAjmGyJYLC-pkAekS7KbsPd7eGSXjA>
    <xmx:XPq0aoYtLKKX8SwBJ1003mslYS17V0Fhx2U1PvQVqkZ4TM-kotn15w>
    <xmx:XPq0arK5w5iSGygYCXAEFXt3INtWpTJoHuG47uujkWAOKLrf1njEdw>
    <xmx:XPq0ahgjtlPHr1qzeGTTABgkFUnvF1_JoXTKuzEflWVyeZC9phJPVw>
    <xmx:Xfq0au7yPuAaeQkA2WW7H59juc50ecAYehcyKvfILAr3LlbWpCoitaSo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:24:20 -0400 (EDT)
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
Subject: [PATCH v14 13/15] arm64: dts: rockchip: add NPU core domain clocks and resets to rk3576
Date: Thu, 24 Sep 2026 22:21:33 +1200
Message-ID: <20260924102135.92217-14-gahing@gahingwoo.com>
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

Both NPU cores share the convolution buffer and the DSU, so give PD_NPU0
and PD_NPU1 the three clocks PD_NPUTOP already lists, and give each the BIU
reset the pmdomain driver cycles on power-on.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index d418bfc04..26aaf4320 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1070,14 +1070,22 @@ power-domain@RK3576_PD_NPUTOP {
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

