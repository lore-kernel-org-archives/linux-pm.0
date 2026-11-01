Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521462;
	b=NCkZvus0W2BS5CssstXF3e6HW6kk2qHM3bQQbqDLi5M+9LCFL8DcQ37+mth4uYKRuq8G
	 JEkyxxP/CTBvHzrw9/hvFWu5s1pwhatdm9hHy6sJBV2fuV4PpAvBY4p7Y9nNH/R4uZiu+
	 4Vilv9bMVOPKRz2k9/vz+F4kAdrH3e1Pt1/oo4iEkTRxkzArU853BSUMwKYImq+FJ8VZH
	 DM52/D4Asj3Orvc3UYhaePB3j99pgRz6lo5ADyFuW4M403LUhqo2o/OwWlCuvszGr6ehm
	 w7aF/vlc16PmEQR8Sc3/hJg4VfP/CzT7CW8pmg+5iexjGWXggrBuJ6ychqQeanD9pNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521462;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Xj9axg9dYLGo8p01aLCCgHl7zzs0dRi/f+h5LP9McgI=;
	b=wB43NOntSbGiQxAbkbFdnxLn1rG2QgruK4AULew8/Lw4yncGJzmv2GxBgmf1UokQU0Cd
	 Da1Wmx3SgWo9y33aK0kJXcga9QnV4uIW5puLR5tIImjogif8h3nTffyRkiDcNcBUP4tZF
	 8UQFMZJbZ8jNwmEK+Nx2n5+MP/WqK9SV1psknyrwx6yDExEFHdYNUi2d2b+gijtS2/lUh
	 3WWJrUSoN0pgCBGfxqvJJVlRnEKmfudqKfqoIWp40R5wT103o778ly7+Xg5mdTSZkJqG3
	 vwrdvk48Xjp/NXu3m+sY4zHT411TeUCxCAmSNs2i4bh7q3N+3Cr9CILVKUDpFKifnow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=ZUE2kLUh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yA0iizie;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA4606A326
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FCA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=ZUE2kLUh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yA0iizie
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86347140030B
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:24:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 03:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521461; x=
	1793607861; bh=Xj9axg9dYLGo8p01aLCCgHl7zzs0dRi/f+h5LP9McgI=; b=Z
	UE2kLUhu+f0h4zzJ7dQNeGGmU6x0eCmvflkfG8hlr4R+lO5kUaYpg1scaSJLQaTf
	u9dBXckKhipYFpy5Xry4XzDCgFoseELeenqYN0NwsqfkgPn+97HjYpMDySAqd1Lg
	ahxW9fRQ5R5YMdfx2CCjngo88MuczShDgw+62LvXZrFXDOfGjcY+CQ/OENHNcfGe
	L5YsMkAwsFCZ+5ykEIF/wSoX91EbXO98M1kwf706z7tPbeeusGrGY72ZYLJS/QWZ
	uk0y206WG0075IyUoX/0SvlZs60vA1UL30zLZjnpq//GUXB/4uqZofwRUMtOIApz
	RgSC4ZSaiGQjcO6xnH2ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521461; x=1793607861; bh=X
	j9axg9dYLGo8p01aLCCgHl7zzs0dRi/f+h5LP9McgI=; b=yA0iizieupE0/Rl/N
	QNS3w5eyyCQa2OOnOgJjfo6uOya3dZ+YvoIC+y91f+hC/P7kqlvZ/oOok5wtI6k1
	cCzVNArcZUvhkV0Q1NS0kF7YvePCWe/5iGBxSh67+utZpZ6107eDd7GudFlvOk9Z
	kPMv10hPCnmWEIo+pkCSUK3GKY0o6SEP+FvBCLfDszbGm9iXB4BZev1RyzRYuFcq
	2RXmVSjM0hOJcVBBYbKotRxv0T40pBnqe5JnkxRbC02wnelIq6TjoOWfM4AjvK3M
	hQ6UlOngvpvDwpPhaPrkFCnBdRwx9DOjqGKuv72SFJKUfZs3ziQ42YhgI6v2q1hu
	4fgcA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521461; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:X0Bv3QBakRS+swyDLempEyvh+BNBsOIHOveb6W706RA5lSO
	AoWhpFnx++wjSBwnZ+BErZ+hSJloPNlopqxtFb8998xSOOpehBg9mWBruLrVz0fw
	B76CENVn/pnArOVMOkDmXIdlPO5Y3c1PZOwPT5dygx+DV9Q+vFXlL8Gr05fldSQw
	7U5nPds0J9KDNv9jxIbF8ITY5+wju1dSFMplGn6ukJHo0Zb9UH383/X3sbwAtX8f
	tckJqxyjbZKxpuxPLEICo27uiIoicBjYYYlK3xtX+KmtGL5Xibz5fayACqa0dtQc
	tzo76Jb7Q+q+3gvcY6WXY0IpIZbXQrRoXjz0rRA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/cR+SVB5SQ0kGP0/C0/QK06xN+k1K/x4EQfQy/b1HSY=:4Xq95QJdIqCjB39RLzyySSIteLteH9r9uz6l54PwLfw=;
X-ME-Sender: <xms:NffmappYiiEfk4kfjkeNmrE3x9bbwYjo8qJ1BS2hvxfVLSeTq3BWfw>
    <xme:NffmapTQGRvTElT2d0EPyQjKzgY25MzyOou17JuLGt-pT7K1Mq9znNiujCs5YGg6y
    sU03Im7CXxLEKsNibXsCP2LqVvFo7AkuioOY8-a2wzUBv4TH44N4A>
X-ME-Received: <xmr:NffmatlYCyvECxQvyETkXjlReYmwPXTBB_Zwh99ir20A-fFxy3a3zK2VpGW6H5YiHO_PwUYi>
X-ME-Proxy-Cause: dmFkZTGZ556hZr4OQNVERo9rUYXTF10cGGQBi7vLn3VnSr966c7BEZC28LhiqgFQ0DLnXR
    bnYwdeOAqs5QxBVuvkRL+ZwpHs/blmZG2wUWUiNLZ7HENeZpMSZpencZWiEx1r/ZYZ/gaT
    5aRTZsrFo+PnzxoJMR1ENyaKg8E7fhdgt1B6kN2BycVkXJHEJTKc3jHTPe6IjiylVhuTTD
    rIDq43QCU8cfWL1yKlOgbv7lVceHpNeuB46oYLXbGuG53l6HRsNNJeQwVLCejjdSqA3oLJ
    mySu3UERpxtLqccEHJ3QQ08pgTmGPEw/h/+EEsPDgBAlHAn17s6eZ3ZSMRh5fpdn/9Y7MW
    A4rXUGboymQeYRhevUsMu99pylgnR1ci1qPeAm1i9ilW2KXn+HDY/CMMKnD405vPZSMIAh
    ES4PMdqvNXQ7QUwxpvmakX14ML6/VWcidwIGbtd5Z36B8pG7IVS/WskaIVqL021NAJxc2B
    /rfw9y47objWwdzSCmJ70FIOgJGSAqR9mntmLWHfzhbdquX0VmYu0VURVrFw2PA8bwIFvh
    p/JyHLmDqKNUc+pdg4V8gmSCK//MVTL30Lbg6qyUA9FhG3bmA2/MWiurCN/6R3QJ0QTe1i
    sucgcgOKk16/auPcTGxxu9BmGIQVE1RnosKooRtX8cizl+Tvru/4UwWmSG6A
X-ME-Proxy: <xmx:NffmatGW220jToEwOhR7lCy7bcaAo0LH2mLgSm1MRCCuN3-Fj9D7zA>
    <xmx:Nffmagm1kmBFVt9bJp6ZmEDIHeeR-WHXun76PHDhcv23TnKn69DJsA>
    <xmx:NffmasSr-IKyDYvzy1vq30ODzQqhhzHDD5Dgk_G6fGtCxuSYwdgxGQ>
    <xmx:Nffmal6FwYnZffS2k_QoX8ZcBMdo5cI06LhkartZ9s68737wETpKkg>
    <xmx:NffmavXEdFxjRyf7BP8FK3c75DIi3NBZDtANZ4DUTD5ql7SR9v2HcMji>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:24:13 -0500 (EST)
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
	Jiaxing Hu <gahing@gahingwoo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v15 06/15] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Sun,  1 Nov 2026 21:22:58 +1300
Message-ID: <20261101082307.151957-7-gahing@gahingwoo.com>
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

The RK3576 NPU has two cores of the RKNN block this binding describes, with
two extra CBUF clocks, two power domains per core, one reset instead of
two, and no SRAM supply. Widen the properties and pin each SoC to its own
shape in allOf; sram-supply stays required for RK3588.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd..3b611b64c8aa 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -33,14 +34,18 @@ properties:
       - const: core # Main NPU core processing unit registers
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: aclk
       - const: hclk
       - const: npu
       - const: pclk
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   interrupts:
     maxItems: 1
@@ -51,12 +56,15 @@ properties:
   npu-supply: true
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ -75,7 +83,40 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        power-domains:
+          maxItems: 1
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+      required:
+        - sram-supply
+    else:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        power-domains:
+          minItems: 2
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        sram-supply: false
 
 additionalProperties: false
 
-- 
2.43.0

