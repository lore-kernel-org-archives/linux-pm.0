Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521550;
	b=KttcMXdCq8VvNpUwnocVzeyEVD9CDMx8tGf/KHH30kZM9BNhjk3WGhsW7WwhjNIiGvD8
	 Kl4Z8nYJv9EJytdey+7VXouKrF3dCVMW6BgN56kPIXv88/VpyTVfayn/Pb8FTGtv2Eftt
	 1XVwxhQd+j9bHrCly9OTVfu+C7gA9hUfVgIycig1qSY+2O++uEP3gykqeZDitUz+aOb3k
	 CFjxkZ2GU0sYVqQzzd6581wpN9Cv5EHDzgnItFosLmXnq5mTqtPU3kChb2MTYNnz7MJ0c
	 FPyi6PX0vKf+lDs5wBxPHOaCFuQJjeoQKiw0QDBlY6sX0T7z1jd/4DNAJyEZuQpfwOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521550;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=NPdbRbvxDKL0OEN8vp8xEKhBdOR2W8Jv4hucbhwG/+A=;
	b=kzaqtcZeyIFoocGCdgvPq5sYGfSzD2KyX30lI6YeXJQnnQkX7pye9rzwJpZYc85+4ajc
	 z/7timKXxZzyo0059TdKGgMeG6CWEp1woGMb3HBsH+kHum/jacQKBSQ5LW+PDckCRRdPj
	 esbQqmEyQQn7DGznqJloQj3I6v40gWamPdkj/gJnFfJc7csF7F6CXyjaNWOlClywtpFYm
	 VuJCKjXSIV3H2w7zJPgrN8+y3SKgNjgr4+xECo/I5IXtBvIuEyiJUtNiuA8XoQ8MrkLMl
	 MgVNTk+JlZp7AtT303b3La6cP3Tl2SwaEHTv/jhZOUIXB7UdRBqHY9JSU4+DWFePtSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=niZzirCQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yaK9S3qA;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E9606A325
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32E9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=niZzirCQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yaK9S3qA
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68D101400315
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:25:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 01 Nov 2026 03:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521548; x=
	1793607948; bh=NPdbRbvxDKL0OEN8vp8xEKhBdOR2W8Jv4hucbhwG/+A=; b=n
	iZzirCQkqYXCNIxUz2sFWYfcmpRR0K7GmffY/WBRrF9UmTBtcb+jyjJNxVG0klmB
	qcdOePWVyidi4dW5Z8MTsQixDvKZ3adluAuOvNLQgVSx/rIcaBMumqlS8BBXtGfW
	Blxz2WHD4D0Bgnn/v9sJj69FePwpOpWgS+t8S2cA+d4h4cLxyxqzZ12mVxicKX+D
	EbfdUTlbH9tINsykTmiOv5QtOg7ib5WG2AtxewdxGQ1LSZQ/wOipctvcosw+n/mj
	aLvPZlnodueHrLfnx/sBhyr15odaihqZs2WeDhWnET11BivnOFkSFPmORDhz1bN5
	FiG31WoZNSpvQJLz48Xeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521548; x=1793607948; bh=N
	PdbRbvxDKL0OEN8vp8xEKhBdOR2W8Jv4hucbhwG/+A=; b=yaK9S3qAxzqcoxGjU
	3FMOd27yYAbgeVcwV15/BB2f/SAHu5B1vRy9/Zvjg4VGm8yJjhdbV+0k3LuBVZMO
	Ik7OK8uPn+dORfyZ1qnsr/qUci8NgsRQIIdDMB0wbtrCMLIkoK92geq1ic0qT5wK
	KszciHAt4ekcnpPJkEq9R3h/J5vVIS6fB7biVlPf2eAW69+7i2WgRz9JERB9KKvK
	49PYG46L2az0KMNRTtoMpL4paqRP+nGLVcNiaZ03yKd2Vibyw0TVRHoTGbKSAbyi
	o5bu4gnHLVWrYxV/jD7ApR7OyBGqtsQ0YO6hGe7HumWkh4sfj29kUUZFamg0uq8G
	nQfTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521548; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:i9uJphklzH00ZF4dDMnQAkNdrNWBc8+oTIpzLf6oSF/6ny0
	I+9uDkeQflxnK8Jv8nvxUR2rOiByplCgGo83yyum+VHCQLhgTzk+qOUB4Vj6ZZFT
	PN415rWi2e/mwy/jICzir/tZgQQrUIzakNEIUzpzoX+CgZQ2bV7W/xpvu9xylqbQ
	IroP4xz5z0u7IjvJWz7R8AVY7TPOnJwJ1ffpVnQRpIdSjL943jdz5Ou4oFBm3DI3
	Qs7gsu8bEfqQ9RVsegGTboVbnBGjRGQqjZB/xURg2sRAovYqlTn7pDWKgNmRMYS0
	1ck/9+5f1Jshdi1k/lZn8MsUHsLdAYc95mC19yg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PZDS+veFbqQDJ+VNCkTEHlkvGkaR5Y/qNdA3sVFBnT0=:RQfuEIfrK3E/kuhenQWz1jJv+vMrrmq89n6uVuBYCrU=;
X-ME-Sender: <xms:i_fmavhsNBt3B45TPi8JwdUCQVh810yR4lU7JPPesrsw42OoCFdmpQ>
    <xme:i_fmauXZ0tBSxoM5cWalWLboGWbJyd7BdMKxLN6xAdyfBiOG2EO-mDOA4cXj3kYRK
    XY_R1NNKhcUrD0tbbe4XG7baktQIaIZKV_VMgAqimz8MANc5UFfdC0>
X-ME-Received: <xmr:i_fmatzheeu7X-2SuJI_3joX3kGpCCB5OY_yZ8GZss-GWI5t3dwUH-8Lv8bizyagRf3qDbkS>
X-ME-Proxy-Cause: dmFkZTETy3iq6shVyHvrvogT1vA3sVBaKllPQ1wQ4LJMhjF44qU0s0XZ8eLq/k6yctnKst
    MQPxEHxz9rrNjy7Xu2B++/5ClKVy+wWlOe4prEQQ1cEZShiRkH2Az4aoIaQ7tW8kjSzcT/
    rzySxuLXzlyEr2rtEtR/nzCISg5bgzc2qBGIAEm8GSq2Oqw6ayxglCo+wJhexK748o/Vuq
    VCZ791nPG3/fm2XPz4N1DAOQHM301syJ+x8WNVw0p1WeHLUL/pESRogs2PT0nTCL+D/AVe
    uMFe6ZJmkMon01iwUgCmMMmKB+Akp8cbOLKrT/8zAMxMIr+tlt223iRbsj3VTWGUq6v9et
    CKYqGc4ftTNW1AYlDnaFX6sX2wb51+0LBW32NXj9+Kj6S2fa40cy8vlvf0Rhs5EOhpmZji
    9aBOLC2eALC6M10neHuSCtLrT6ohlEgQu8dSuyYSHS09BDIbBBDZquD450KQo3fhfCTy7d
    hvuD3NhFZmP9pN68r+pZ+qC5XuwQD4fcKnad1Dc4qjk0KtLyGJfQZmk+7gFBCm0dijkGMm
    dQD23E/47MI9HItTZjJNE4aXHmnMLqAIzJInTIoXfDrZBaHn+/+ycSrYU+/CwOT7KVdRfj
    Mf73vW+88X2WRLNA86Hm7B4w8z5hYOc30kOUAbLq92UUpmCf7IwCW1XDgYqw
X-ME-Proxy: <xmx:i_fmapPozTt8Rf_d1peH1rRkyL4VfGoSRrLaEt38OQxIstayu8yTmA>
    <xmx:i_fmaqY1tfQGqQI0vDTGQsELnATj1ep67nZO7mKlloQ7pzj_wnirgQ>
    <xmx:i_fmaq6rMpijKhBFDy9g4pcabHHRpuxxsPwVk70dnlMUakMbmumGeA>
    <xmx:i_fmahCDroab2xCQptt-_GXXubSg7d0qq_zh0mSQFjqYq091sM-enA>
    <xmx:jPfmavOlpkvQS9gl3KhyVvaaDVhMmskLJftveY5qhOWW9e7AabCCOREy>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:25:39 -0500 (EST)
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
Subject: [PATCH v15 14/15] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Sun,  1 Nov 2026 21:23:06 +1300
Message-ID: <20261101082307.151957-15-gahing@gahingwoo.com>
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

Add the two RKNN cores and their IOMMUs, disabled, and label PD_NPU so a
board can give it the NPU rail. Each core lists both core domains, its own
first, as tested.

Assign CLK_RKNN_DSU0 594 MHz. Nothing in mainline sets its rate or the NPU
rail, and at the 786 MHz it comes up at, on the 750 mV a ROCK 4D boots
with, two cores running together write wrong words, 11 to 25 in each pass
of 5400 rows. 594 MHz is clean, and Rockchip's OPP table asks only 725 mV
of its 500 and 600 MHz steps.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 74 +++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index ea9229b6e6f5..80943d748bfa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1057,7 +1057,7 @@ power: power-controller {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				power-domain@RK3576_PD_NPU {
+				pd_npu: power-domain@RK3576_PD_NPU {
 					reg = <RK3576_PD_NPU>;
 					#power-domain-cells = <1>;
 					#address-cells = <1>;
@@ -1284,6 +1284,78 @@ power-domain@RK3576_PD_VO1 {
 			};
 		};
 
+		rknn_core_0: npu@27700000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27700000 0x0 0x1000>,
+			      <0x0 0x27701000 0x0 0x1000>,
+			      <0x0 0x27703000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core";
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			assigned-clocks = <&cru CLK_RKNN_DSU0>;
+			assigned-clock-rates = <594000000>;
+			resets = <&cru SRST_A_RKNN0>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+			iommus = <&rknn_mmu_0>;
+			status = "disabled";
+		};
+
+		rknn_mmu_0: iommu@27702000 {
+			compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x27702000 0x0 0x100>,
+			      <0x0 0x27702100 0x0 0x100>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "npu",
+				      "aclk_cbuf", "hclk_cbuf";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU0>;
+			status = "disabled";
+		};
+
+		rknn_core_1: npu@27708000 {
+			compatible = "rockchip,rk3576-rknn-core";
+			reg = <0x0 0x27708000 0x0 0x1000>,
+			      <0x0 0x27709000 0x0 0x1000>,
+			      <0x0 0x2770b000 0x0 0x1000>;
+			reg-names = "pc", "cna", "core";
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
+				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "hclk", "npu", "pclk",
+				      "aclk_cbuf", "hclk_cbuf";
+			assigned-clocks = <&cru CLK_RKNN_DSU0>;
+			assigned-clock-rates = <594000000>;
+			resets = <&cru SRST_A_RKNN1>;
+			reset-names = "srst_a";
+			power-domains = <&power RK3576_PD_NPU1>, <&power RK3576_PD_NPU0>;
+			iommus = <&rknn_mmu_1>;
+			status = "disabled";
+		};
+
+		rknn_mmu_1: iommu@2770a000 {
+			compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x2770a000 0x0 0x100>,
+			      <0x0 0x2770a100 0x0 0x100>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKNN1>, <&cru HCLK_RKNN_ROOT>,
+				 <&cru CLK_RKNN_DSU0>, <&cru ACLK_RKNN_CBUF>,
+				 <&cru HCLK_RKNN_CBUF>;
+			clock-names = "aclk", "iface", "npu",
+				      "aclk_cbuf", "hclk_cbuf";
+			#iommu-cells = <0>;
+			power-domains = <&power RK3576_PD_NPU1>;
+			status = "disabled";
+		};
+
 		gpu: gpu@27800000 {
 			compatible = "rockchip,rk3576-mali", "arm,mali-bifrost";
 			reg = <0x0 0x27800000 0x0 0x20000>;
-- 
2.43.0

