Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121312;
	b=HjKjhvjx2cEHlr4E8z8yE58ervOBqe5dgmMdwkcwB0VRRwdrApAyD3FtFhuqI9h8mOfL
	 dHSLqFAHkZsA2DDZCG1HVPZVPio7zDs8205w9G2Wxby4ThcE7un0htwOZzBIdp3G0KXb0
	 Axl1evwqSy/0c4XBjNhCGezk4FHk7U0FC3n7G6SJggBQ33Lq1edI46+vv+pmmGSWVSQQn
	 0dXLTwUvck6H+fCOHRDQb1n5r2llqy3MtXA7AF58GbXLG7E0OTfKGdjHInLdryRylvy1j
	 tEaZ9B81pCWvD969cJ52Vy2mN+hksoZI5p15nI4MEyVBNcCCDfwQbtG8uQ2wev5E0yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121312;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=6x2DdXPRXEfWTwXK9W5PcsBc7yr8Bb9BaYYA36DgAhY=;
	b=pRtECH7XkrN4mf6URUeXfxmNCvlnpEPXJEuFgV0sgW+IkGEvF3jbiGIiXo8/U7E5soHl
	 NXoTPKTrkAJ2k9mg53M+7ersciZhFGBmoSAjk6gIf+OWd0W5rqjDwtop7xlUpPLbs5rgT
	 UejhkmlEeadk1TTuYtVmGW5f8OPe+/xWt1/2rJNr67XLykns9CqlXQnMmZI9Cc/3r7LAr
	 4F2mPzN/321ghKIGC2Dzs4lmrza9q7yZs/FiapvIEHIrwg4odP4Wev8B3csdTaiCpn5aJ
	 cd6ErQkLuZAiRjgDzAqaUGWPGIswCS/u1CmskKt345/m9uMqeqllqbyHTfHKcsqNU1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=XrMzaHhI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dF4KTh1s;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98193606A31A
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98193606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=XrMzaHhI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dF4KTh1s
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2576F1D0016E
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:01:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 02:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121306; x=
	1794207706; bh=6x2DdXPRXEfWTwXK9W5PcsBc7yr8Bb9BaYYA36DgAhY=; b=X
	rMzaHhITrOJLy0EAN14eJNvdzy5tSoVNf8bIS5b9fg2SIoOaREXFSlIYN/Uv2c9R
	IPcXXi6SZTAGC9omqKMVIHmZrVp4bR/W1QPi5sYQZbEZOK4s5DF8qhWJvq0em8/6
	bBHCNcnr3e6BblaW3FA9UMoSv5xBpClHlmaF2+Mh1rGnXnMBcL8I3b5cVFXJZBNy
	Eige/Wv2HHsDVgvz6r01OaYugYOzR+oVsd853S8cM6WML8SgH7oJba19kbMerN2r
	SnxHTeu0ruAEujIn6OcdQIvexRBSIWWlnzLd7RskgFdwN9ygu42PFAqEHkN6j/g6
	rL1vyqtFmMmQAZ+myKoyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121306; x=1794207706; bh=6
	x2DdXPRXEfWTwXK9W5PcsBc7yr8Bb9BaYYA36DgAhY=; b=dF4KTh1suZlKJF054
	W/ZavY3b5OjDjv7W2CRb4HD+ETTYYm1q/aSp4gxrHz6GxccD1nV7xP2cYLDfMcqH
	L+WxGzFRfDYWyHb6WnRq8mkYOZkDQEeTf034jn70ZckwW/q6vPg7zs0YMTlGr4sD
	fJ5eeGh+UJ0uvb3OxGmkqBEvY9yIEjO8nz0OY9s1UGBq12qjawhw4ceLnMjoMgXF
	dMdZrhJ14atw0fYj0Ygcpr9pIDDH+sh2MztSu/rVEqf97euG3LgeA9sYxUoUSX4G
	QnUo8mXNFt5vvbKCfVRJoYAZEYpu1f+ChtjsXhGWc9Cex+K8qom9Z1aIhrlXQ4bT
	9WUdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121306; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:gJ2hVDlvDQuyHdbY64auq/vF5aNOF0CitQcvG4875PKCAMb
	BFrSiGfmfbi6eOsMRgT+e7ccbPOT1Q/QM1rmKY47Ki06gNHnm6yCE9Vc8Ww1E2wq
	RCCWGB6EryZ44TuemWFavd9YZuTuJ5tNH813+v8s0lkLMr08qQnZKyTfPyYDOI3H
	32Dc9PYSxzFsLvuWfxkSxkww5OjtCSAGeB1ZEq5Xc6Oy+fxBJL4gDNEeL6J31s4s
	BmnKL6B3+Qh7wQA/qrSv1R1wi/u0nFfJiwQ4aYLazmSm3ZWO17PC+zdbX38iZ4M4
	h2QVfXiXsY8ZVM2mCEzYgzTaut//EgakYFW9EQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jmEw0lATz+qo6BCu7oZA2TGdAsgYFeP6VfeubYFd7jI=:laoGVPMLf2LRqPKwP6T2FlWgv2jsQM2NXAuJVqlbhm0=;
X-ME-Sender: <xms:Wh7wao5DQGnrqHfGjTFEd-0fJ92NJZdlF0YtBriMtdPjQ1Q4BDWGkQ>
    <xme:Wh7wahjawJkNmVcUUn99KyHfNZNhogr7AoXjeSbPF98m_oBCfEpKWFQxaLopyvAB9
    u1HAouFA-J7_e-jrGTteWYgFaf7mn-eDJzAnt-pzuUEnhgWlmVyUS-E>
X-ME-Received: <xmr:Wh7waiq4ytUWuhBYzr1H2a52ZghhhXPDdj1t7TFmkU4x6H8zVlSnxK9p0r04SO6S_zepbBlo>
X-ME-Proxy-Cause: dmFkZTGvkKxq58o0YNxgTMh3d5jffRDgbsao96ujwv1USJioDVitFBsUz9Y9ALvBwrcFLj
    kqFzjA/JbfCca892DNnBgXlAIz/Xxro/f25InzU0DQtumgiyjJEPdVMs+6+yx7WUBJP/YG
    kYssWJdG03gLhVAFs6x0tZImyIVP25VaCkHrJsYEtQ25KNqyMNodRMMcDwL/ewfvSbUzXE
    lOpl8VaSDqhAlCB8LXVrtWvLZj7RTDhzgoNxVWjbpoiYOFTXCNgIrASZtbjWqAIunuzq8y
    RnT1o8a16XcyUiVZM+A24xqdJvaR2RIn2a0sf4Iz44fGqtMHdPP4kkbz91+OyZlEgQJ5dB
    xLWNqQK4S3gv4lkeCCdiqEFCx6mNk2mdL8ADJwCJeLj+J7IfJBqhllH7udzpR1xJzt1Pin
    vvYIlGlxdaY5WzzSWl1FL1NT/UuqYxcclBmenSyWE6ktRFrgbljMtZz5d+ySu23jBu4Fxq
    M3mfdam69PR6ydC9wJLpaZpsZTgNz0+H/CA5qUoxLLizokOlxGkS7TXxph9QbFbsgXNe1S
    J2Gq6QSFhhoDQeunJhwpzPcX7KwXn3LGmX9vgu5bdN12r/SxpXLyU7pzisXErS3Cp9oG9J
    4cIGWQMDmiqLS6ic7FyEwQVEv1/vD9s2kKawssMmSlEs0p3r0C4X/IBy/dxg
X-ME-Proxy: <xmx:Wh7waneLnv_tzKLm29UH7SosAzigaLpP1qGf8Fb2OSDTmnaoXSN8cg>
    <xmx:Wh7wagLiD-kuhSRm7b5pZJMwVWiiCTiFenF5ZNj88pJDsf23uRTuKA>
    <xmx:Wh7wakvSqq7_r51H_WutvrUzPTOX7-EyxRPSmCZn89vn4Ahv2u1CTg>
    <xmx:Wh7wamJvf95Zjc0cG60rh6D5vwdtNmcz4FvsmF6B2r4-Y__OMCUOLA>
    <xmx:Wh7wajW68x5HkEn6VmcvancBl8nY6dBrhDpr3yH41rjQKuYEviFGlL_C>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:01:37 -0500 (EST)
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
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
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
	Jiaxing Hu <gahing@gahingwoo.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v16 08/16] dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
Date: Sun,  8 Nov 2026 19:59:09 +1300
Message-ID: <20261108065917.135194-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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

The RK3576 NPU IOMMU is compatible with rk3568-iommu but needs four
clocks: aclk, iface and the two CBUF clocks.

Measured: with only aclk and iface, the IOMMU reset fails and the NPU does
not probe. Without either one of the CBUF clocks it fails as well, and one
of those configurations does not even boot.

With all four clocks the IOMMU works, and the npu clock is not needed.

rk_iommu enables every clock listed in the device tree (841363ebb508), so
this list decides whether the IOMMU can reset.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iommu/rockchip,iommu.yaml        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11ff5e..e40c9ac2b463 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3576-iommu
+              - rockchip,rk3576-npu-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
@@ -42,14 +43,20 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Convolution buffer core clock
+      - description: Convolution buffer interface clock
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - const: iface
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   "#iommu-cells":
     const: 0
@@ -72,6 +79,25 @@ required:
   - clock-names
   - "#iommu-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-npu-iommu
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          minItems: 4
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

