Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521484;
	b=G62WBhqHtefsk+N0N+7/5ogdkWap4NvhludmWyekbR7M4PTbCpy/eN9brN/Sw+gZhaTS
	 isDwnWjH+IS13GS6nBj+/VM5U/zqUxDGbcgOuehIjNZDjh7ccbz82qWn6D7Ak5IATXAdl
	 aTKH++QEZQFfb/n1waBsnwWSrxgnLFhmeC9tDsN7mg8LHuVjgNziGrg/0pp1OgJ4LUp1K
	 Lfh1G1WySiaq6RCsigO5Eam60HJL74eJ7NaILURd8afiZZ7mLG1Tgc2msvts/TNz9EDL3
	 XqwTUc0OepVRAFDKZUXbFgr/V+yOWeqV3ZB5AVTqrOPdNc8Zvteb/J28SpP8/ZUIhHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521484;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jBTBLTr8DQRr19T6BWMODxPqpxEX8vRTPecx1mfwqbY=;
	b=XDwNc8YYI4T8A6vONbTrs2s1JqDoPo/HvE22D0i8BsR/jjgowT5DoyAaaBvWyjBd0iV9
	 9DFX9z1Eg3Oci4jrwkARmKnf5SNGD4GCPCg8qPEFIF2x76mDzsgy4zILacWjuqn5pc0zi
	 5lNXJsSXNMnkg8RF8bi75TDHnER9QTu5ulgLo1hw0D/CzuKHo1dvyokQ3H8ZtZIYGdsXI
	 sHnMmu5F1H1T5xOOr7NGjSsP8POJ9XHzkp8liJkRuZaMVTNJL+yrlPpp7It1+qYfBDTcc
	 NGVmN6bRNIFI9TknRceDfIPNmwLkr+j0m9/9+6doFePIYhNOjF/eoSkGWwQj1SbVhRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=NKPQaJ1s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Nfw1UzeL;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC4606A325
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8FC4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=NKPQaJ1s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Nfw1UzeL
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B32EEC06A6
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:24:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 01 Nov 2026 03:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521483; x=
	1793607883; bh=jBTBLTr8DQRr19T6BWMODxPqpxEX8vRTPecx1mfwqbY=; b=N
	KPQaJ1sWSLfnujqL+bSM0ED7QciWLj8SJqIMLHWdHQ6Gg2duaLiHKts7qDwa2cCT
	ieOm7mkvkrAW9mwLOHZkgBeMPoGVZFVk31nNm8zSH/PfD+T5SaI8ZAbPi6ckfT6t
	GBMrlXSHlFwiDafUNozpaI7FSuEl4QvfuroFtNssUICTI3HOVcn2RJCp76hTz2Fw
	IgaQTmq30DJ068dXQ5OrRv0AgTP7CaHi3pr8UWNhZ6YQ7CL/rPg78I7yfAZZpuBP
	O8gUeG7mlczuCjPQ8QbwimV3Xq46TU0XemAU8YlhoFsk9gECEPxKKWHN/vj/26z8
	xpt8seopDZJ28vqRFTBHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521483; x=1793607883; bh=j
	BTBLTr8DQRr19T6BWMODxPqpxEX8vRTPecx1mfwqbY=; b=Nfw1UzeLA8BvCa8+m
	cK/dFcb3V2W3zpkhDONul7s1wDa6i4QZ90ms/Mg9LHALAw9SP4d+ABWU9KPfgxfX
	rqeNFdBo6CxrASVO+4v1wUuTKpATLBi5V2UIZDQW3DMDnxG8soDYCQjkb5H8GcP6
	XWIDj81ewF31bJt7tWmOZsmZwe8Fa96gJ1ygeItK9V0v5JlE8YEsTUEsBChqShBq
	Ou/avpIiLS8cI7Kq7HFcJcca7vHWiWFM9cwXJPwbP6pWZ++6pS7S+1VGxyzfcwlx
	Jn1w7LVQNUj4LvLkBOZIstij32WFAJJjb6ZUXiOlQ9ev4C6D1p9jEJlPcsyEC+vz
	tAhUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521483; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:kUrPHUuVCx/IiAvw2Lo4pEGzRy2WhIE9nG5qYVf9F9B/NXV
	I7oHGiG04UNUvohB4oLeDCNjaAw5H0JZ4W33+Q4VPcRifEps7ohqoHlNOAqma6Wr
	QdPyuTOCG93ty5l+udq9tczKedXaO+npZ0LRo9lvh01UOnzDlX70P0cvb9+8SzIy
	Rx0/+eZiF0K7OG1GFXG1VruoXriyu5ApogzbazetIxn7rTyQr2rIdsE4czuaCkqi
	zgvXSnDt4+mWL4LUHj81bvnfVLt/5YGA1+F+Synkqsa1yldFf7Oj9S8vNNLSb47W
	k6L1gOUd2zccl5ffhFhyAt4fRpLjVIqWFK/zdRg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OUw/4rLhRRL8bxz8QcUk3bVMI14kD7He8iiEzelAaRQ=:XrRvUajRNZ9xsu1Nf4/Mvh8UPOhIc0rMC6IdufNO4pQ=;
X-ME-Sender: <xms:Svfmantz12z8ZXWAFsAhroTUTjlSGbfjcEd3fr8San-WRKJllCw6MQ>
    <xme:Svfmai2VUaeBYwvA9k-MbMKuAgqaaEu-WfcKKjyJP5oCji3C2O044vVtHNelESWhz
    vAhD_oKPWO21ODxJaGznnYshN1Zo3Dx-5S9tF2qGcyzHDuUIzHVAOw>
X-ME-Received: <xmr:SvfmamVzGLHibkvIFPO12v_NMzUV209DV5HA-l5CabXDoRbYEXlYK9LN5maT3AJN0IxHOGKz>
X-ME-Proxy-Cause: dmFkZTETktANCVCRJ0BesY5rKwHQ9695W2PCEB7/QKg9ZEIlRl5JfFVjnamT+RfELS2Y4a
    GNXAkB3X94sC2BkHrOuE4XY2MmCDUnz88XHeADa0Op40KhB3HEfe39rvQ/yyMNum6VDgSi
    3WgkXBaCRrhxk+9xvW4sihgl5lqUcBCY+C3doTqzoabLq8E1mgaEW/YyXULtlpk2OrLkDo
    RquQ3zs7rfhTczwkf93D1lzpwCfLxKZmrt/Qzv5pGYe9wNXgRzR1h+2Y+FGJLNo+kl1j0Q
    1X/laTOBkpr2JUyV0EnsTWd+Bm7qrqqQ3IP6U8qEigGAlYwFjggHiUnqteDjCIpGlfTTcf
    ERcfb0O6+oeJfX6YcDV+0n7FQvB/oLx7Gl9e5CeI/w5QqtbD2tkyuOkHVH2MWbVonlTuMv
    EPzThXKx+4AW8DeC+PjbM8/ujZtywM3u6J9Ff8dN2ip/vACM4H0pugv9H9JhY5gZdL1qQX
    /fHnsCnL2cCL+0pbbImqG37XM2Qe+TFjdhQu1eIH6pfgT0+FdoNfK76lpevMoQbvRL0UA0
    vM05d7F8MHU6JBGHp8V8BEqSuFrrSGDA+AlguthNu3ntmwCGEqcELNNQyDfzT0JiSY+s0m
    sao7VLrGbvew0j4Ka7gYFTd1IG25xFt/8od7XWq2fNvnDTNiSVsGXsYDafHQ
X-ME-Proxy: <xmx:SvfmagOb0aNcUJJ1Zdhka02e9OGjMqccPIXAvYhfET86yL4bXt7iQg>
    <xmx:SvfmahxEgGElY7BAJL4fRNueGkG05uNyevFmJWjkV9oiR7SraJ4Oqw>
    <xmx:Svfmalj0xaTqMSpR3VN3CYv6PXgchfmyu_fZJlcXwxE2SdXam0Cbug>
    <xmx:SvfmaoTR15zu790_gUCw-DLhrRztXcC4FnhrIvu_s5lUrjaKt86nKQ>
    <xmx:S_fmart7MgMkD_yPM0r5TpnybYtEo23v8PEXjO3hvapoDgd8ZpM-veyn>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:24:34 -0500 (EST)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v15 08/15] dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
Date: Sun,  1 Nov 2026 21:23:00 +1300
Message-ID: <20261101082307.151957-9-gahing@gahingwoo.com>
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

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
instead of two. Give them their own compatible and pin both clock counts in
allOf.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iommu/rockchip,iommu.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11ff5e..83d7e7c8e0c2 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3576-iommu
+              - rockchip,rk3576-npu-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
@@ -42,14 +43,22 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Compute clock
+      - description: Convolution buffer core clock
+      - description: Convolution buffer interface clock
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - const: iface
+      - const: npu
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   "#iommu-cells":
     const: 0
@@ -72,6 +81,25 @@ required:
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
+          minItems: 5
+        clock-names:
+          minItems: 5
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

