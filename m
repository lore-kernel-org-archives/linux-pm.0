Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121277;
	b=FyS20B57yyRMe+GaF3gng9KfnOyqAYCHWH3jj2ZbNBgagBaAPltcMr77Qw+vHwsUZ0kW
	 QspMqneUMMkQGO7MDj3bpFobmoZmuvz1Y0tZMVYjs4oxmikJfDF4SdEpos/Giwi01m646
	 2BVIi/4n1aUIm0pVxqWAcoeQMdQxi6Z2/ef37AVYCNDT7mXDgUnXzt2+7SDI+bugbJ33k
	 dk8PE5YDMF21hgC/kU48l7mCWKEGixDDZ9yT4RIpyu5z8uJxwXyCphR55N8XxLPqOFlrd
	 SY8AzmEJwoSSk6u93asb8DBfFj1d0UvHHtmi192Ufa3ns+fcm//355O72pSzAezabtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121277;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=N+9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=;
	b=5FTiBuazztPP349m+s0SGmYQo+uxk/rSylrxgkTeyxLSnVgbt/5IGN48nxRyEiscoQ3D
	 1rxP3IPWj2Jq6OfFFK8IXUygUIocbOLLH5pSTOWi44SSXsSzO4+IWvXfF6sTXZpCSGCSw
	 0XNs9d2Ma819b9Kr63ToZ9MXHG/2ZaYp93QaicnKYmCcKFGtLLDLeFx+T/fwAOVfXhP8m
	 Sz4aM4SQjw1a7vLkCvba3cqnsim0k6f8RnIUpmpsD1wVFekbwrZnYM9SyWaGWDuctXR2i
	 k7aPb3ROUOGKMN7LrgBERwkRSeZ8z8dkbqh2PSCHGjGq1xGXu3qOhctjSMb8s6pem3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=jWTYr9CX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PIT8mGoj;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E0606A31A
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 602E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=jWTYr9CX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PIT8mGoj
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C227F1D00172
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:01:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 08 Nov 2026 02:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121272; x=
	1794207672; bh=N+9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=; b=j
	WTYr9CXKRMZA1fvfN024XTZVHx1alJUmb/r59yzvhmrIk5g5g+6yvlFBpnZAuynU
	Nsad/BX5di33btUisIHPRcD3pUuwrrMhWkyaPA2uQiVsQTWhGqGwPkiSrY30DUO4
	p2lSTeG6ZzZh8zdd/TN4qPllskzUm9NQW2FODVOBfKq7P7Wz38blMTjCi4D+0zf0
	oArLYVd3I/WLgWTsjpu9Is0sjiUzkr7p7LNh8lqLWs8mWm5bWyU84IeGQnxzQ4J+
	nMUAAEOEM0/9rZgiCjUqkg4jj8V/eLZEkE6ejQiFQ+8Zrc0pO1tCujPsMAepiQe+
	0okDOcc4lAzdgmgmR7MzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121272; x=1794207672; bh=N
	+9Y3ZHWND8ST8ERZZyyzL82Il25wWJZbVPoJhmWdl4=; b=PIT8mGojCfuQl9Pim
	of47EwlTMrH/f60cKunt9+JhQLiFY/tHOa0ovoV+R+FBzI6t9un3olX+snR5wR9Q
	czGDzoioHyd5/joC6OuLGzQlqTKqLSaAWV4tQ2MiahYZ4ADs9vG//bY1kqTAonhV
	q1278qMJN2CBxzd4QfDR6fTwnoiowzLKz+tsJGc5vDG1v3+pdzbstth3yzYmhiiD
	Or2/LHHV42xBlff9LWlKFU2I48V17Rt3VwHV4UyH33VHnaZ+0IwbJooDJkpA5/+b
	XJ8srtCM97k5PS9VjXWBRJkLDkcZ/k9p402GYkPY1xJ7Dp9TX2398gGJJMZf+Cdy
	EhCEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121272; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:rygW+0lYefjaGamCva76hwxaqjhaSGJtthfBH6iLHWP+ix9
	9GRUjR0gBF/98sa25oMaaN5diV5JeKEC/USO7lRQfwoj/AsSLW7xin1OAjoAcGVV
	9lCTkjPKo9wdrfwZz9kno4XOnkcmjSAD9Ot6woPX23camheBLRH0x17G8YAVIHj3
	i1D1lSY0y25O5/9qJxz84L73vepefJ+c1uOFR5kP/ODbju9CjFG8LtzQ7Hck5fJY
	GASCrgr/RTFiQIe77CbIBIpT+EyJdgAWl/P7JVc0gCCo3Y5A3nxGmpMASIlieN+X
	ld1lnWtHT7rpfB1kTEPDU5irid+J2gSdCZhXZpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1scFNwGuSYAYmAUwATI7ZJpUkxc2rI1XTCtVvC2JBFc=:E3QG1wpL1G3f8pPSmRg3P12/DKKK+lX4bpFVJJLsfbA=;
X-ME-Sender: <xms:Nx7wau8rXRV4f2OYAyfdxkJ7wMn7-FdvY6MmC7S4e3AY1zju61Cx-Q>
    <xme:Nx7waljUmDQEAAhdwNbHCBJ2r_QwUKtlXgJqNRWdAWGH2yS0h2KPAl2jAwDCR3cAu
    xlJstJdPsU2nM0pM6dHfHQG8pjDaumgA13kG5Sd5CtOWRYcsl59Uzk8>
X-ME-Received: <xmr:Nx7was8Ph6I-VgPqFNKMt2DER1_msVA-kiIFQjnv61MILVXusLc0xuuG3BdSxwWdE7YEu3SL>
X-ME-Proxy-Cause: dmFkZTGHsXxMaNMeFsRAYE+UNc2kpKTKBlmHNoeCpbjkaXBLqGWJuCPijPHPf+fPBOcL1e
    uJGqqoK8MabTfiMBZreujYrV+d+F5ZTA03trv5m4PBpbM2Rx88koviOciFZVud6RbtQ5y7
    aim1Oox9V5+z7Yx9Z0/gxPvGVuv48JVZMf/qHlBPaTlrPus2HUH85oS54uVXp46ALFvR2y
    KMVaHY4Ac7iOkw4xPwvFFJ2eSzLlA/UhQN00EZND9KeNyVoMyC35caaXutb0fAUo04DTM0
    W6UfgoQgWgCa6rIrWkrZYFfMWG/I8W0tygWQKfbX0rUrNO6ZQmLvI/XRj5DdZi86n5KqAl
    lHnzGyyHgMgeGnu+Qd42X34ltprILrbvo5Tf9pou/FpS3LQ9aqrwQu97TgtXOdnVMdijcf
    lO/fmyaA8CCcDen31l3Kv4yt+pFsMSbVga+MOhzdTfOVWSpDQ8xhblXAYS69uGgMt1PW8T
    ce4kEKiAq0yU4LhDYNOUU1/paGWkY69rdok7TkKJRpE7ZDu5LjMCg8mkR72ubfNWuy06hv
    M+APEvibJRQRY091gdEuAbbecGbpXEKGMfjaL52kE/J9QpdlyyBvASFfHb8P3F/Sni5JBM
    njcU0ZL2Uwcfr7RdXS+aRLjcu2oDINtFSoy2ss6M1QbgtFeGeBCITPP/ltQQ
X-ME-Proxy: <xmx:Nx7wapSAi7g0AJpZDY65n6HGQeaQR697BSPlMP51sf5grZb0Wy7WkQ>
    <xmx:Nx7wanc6C-koyJW1O7vkF4eCqZrXiy8qRmb1c4kMfl4VhCkHLPv9Nw>
    <xmx:Nx7wavE28cpUrzeS6v3FwQvGmyLXTMBb0UknpeYX9L_MdzQTOcIVkg>
    <xmx:Nx7walIn_c4ebM54b8KtT_2IhJ8KKc0g1vm6_XHiLRtCgL0wvskgUQ>
    <xmx:OB7walM5ERiwyiiehSQCUm-NQEcGe4-91fpFVVFi0-owGMoFdj1nmTOr>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:01:02 -0500 (EST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v16 06/16] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Sun,  8 Nov 2026 19:59:07 +1300
Message-ID: <20261108065917.135194-7-gahing@gahingwoo.com>
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

The RK3576 and the RK3588 use the same NPU block, with different hardware
resources.

The RK3576 has two cores. Each core needs six clocks, two more than the
RK3588 (aclk_cbuf and hclk_cbuf), needs only one reset, and has no
sram-supply.

Define the requirements of each SoC in allOf. The RK3588 still requires
sram-supply.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd..2eb9337819e6 100644
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
@@ -54,9 +59,11 @@ properties:
     maxItems: 1
 
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ -75,7 +82,36 @@ required:
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
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        sram-supply: false
 
 additionalProperties: false
 
-- 
2.43.0

