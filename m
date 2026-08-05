Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6D3DD87A;
	Wed,  5 Aug 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911930; cv=none; b=k1fIXP2Wzm66BPmAsTmgalnQ1mMLE4JA61Nv95gnEYOK2+neuPQBev+/2ZTsN546zgQShGtuBufzvFJWx/JZ+8hscP03UNYuBotjL3rl4Mf+mYhK3vbB+axxyJM7DGWdhvEEu0FMd0FWyqyocYm+UsQXlVL4aAqjh2YiD/KI+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911930; c=relaxed/simple;
	bh=oV4iDIMq5N3PrVLkQlF1wL5VJYlz7tVgJd6QkEBft/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPlWbdM4BBNrYGDFCqPYmW5PZDWTfojDTZjjpfn2zMU+T0cFy49EkAMUIRlhIXpN1dX4KibIs9lc+buPIliopQ6TBvGM7kDeSrnlsse50NGOmF7sEUR34+8vMEvr8/ovqpPrqqM0RTn21/ULdMUQbmPJgnYtfjPleuTfDxt7g+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=XdZdAf+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jv6FGm7V; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="XdZdAf+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jv6FGm7V"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 7EBC813802B4;
	Wed,  5 Aug 2026 02:38:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Aug 2026 02:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785911928; x=
	1785915528; bh=fJ4g5RSUTUngB2QsAjY07V1zWb09bk9RMpH/GbhT9pQ=; b=X
	dZdAf+HZqPEY/3HkmErwnByoueV2aNFePdNp4O9Nm7Ijm6RyRnvTaAyUhsgqeEsd
	3qT+qe+RnT0ZM3IQ+D8gXP7hKDo3hkHBD1kPG4/6naTTbr2V03z/lhzdOmmGQFeO
	i9OJ81CsmTZY5QodPPExsiZimimKif8k8N3vXIImCSfiIYZ2iu2dwGKxROm7tf1h
	e1iKggi0uYxgMcmIHdkzoeG9H8Izcks71f7uspy0YlvEKnEa0CjFg/KLV73PVqCO
	J0QYpVBYALgnFR8c8BE6Q6DrnHmhdp16pMinqvq8OCmn7hqUt4HYY9g5px20DSbZ
	taNvsHG5RUKq9+PuycWzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785911928; x=1785915528; bh=f
	J4g5RSUTUngB2QsAjY07V1zWb09bk9RMpH/GbhT9pQ=; b=jv6FGm7VWXTei0ag6
	66NaKwKxOoxGRrH7JRSLKGYp/qc6p4v4kBC/wr+VMgiz5ZtS2uY3E98e5kk2+Ki6
	Mda7lc17vE1IIYwIYNXk1S9JxBeI3++cjFtLIOAuNCdfTDiF4OgCxKoKdCiMRv7r
	4J+F9auJZc8uHB8q8si8cWeYjmJGV6ugjsQcgJWlu8I/axBX1K7C73ofpIzvjnRx
	PGo9AAguBRHh7LSsMrwr4F81Gvqnp8IFTWdKwtTjqYwh3oq/egy0NrCRsd8kvCcO
	rEk2uf9i6m54goxugk4eACtPqkPWYptr3IR6eJ3pFEFDrxui22GVbSyU5KjOLyhh
	w/oEQ==
X-ME-Sender: <xms:eNpyaiPwEcsUK2Qqz5Cnc3dwSVBCorVER4gh38Q1CeBgSRi6fyvrUQ>
    <xme:eNpyak740BxK7mRkl-1miOcgFRDDdyOiPHqV0Na625V6PV1Zg_NxkmBEpYnpeQqSu
    Ha_Tef2_zboti68wPdb8EMwPHBepJBRxYwNtg2o4fLrILrKStp4cuIC>
X-ME-Received: <xmr:eNpyahwNtdhA9H9J58hOqDiy_Qwxf7TTPF-JfJ1rhroSatk4-ie70nNtKX-L5eE7Bz1EzeOtwQ>
X-ME-Proxy-Cause: dmFkZTFvuAanzUrhVpA32hSUnDPgOowLpJQO/4s4PzivY4uBI+kvSyr6z/K246vCeGvoXm
    JC7DPBHVAJx+zWTyOpYDRX1/xmFGgTSEPyFBhONjsRCF+V8SKWa4aEEA+wcaskWyU/znrw
    5Xrb0QSDZT6htRIrc77oN3tcoxClRuHctzxIP8rmI2ckJJ8dbGG+k1QAmOkOgnVTX2NiSZ
    UZ405qTGi9bRXJSvTiG3zhqnZPzftLBofjji3nri0zG/vCyKlz59j9Lum9P8rDs3Mx8xqJ
    mBff4nUkrLd6pFaBN/w2Bb1B2Qx3KABwyugLg3v7I+8OIN2QxdPvF8ddTsRMpG8xeVGRl+
    GQLOfcADkBK/VPNODrOp39ouxfiUpJdRnUAh8AJuSxx/UOUIRK/4eGBqP0LpPPWlgO+HxJ
    szPhmvxI596WhNUV/gwcryzd3OYkS1gaatoVenGUlKQPywfruM4ZfS6xpLz56JiXaSO4Eh
    06La50W4G1kVgtCeECS1nVRInHVVQnhzjZcNePR2tGgpA/hsIYgbaqbmbNFDCgjtwbU7/e
    PjEwoE8Suf8OYEaGPov7SI/McRx0q1ZGujIZUh3MQg13wTk70USCAhzazA4PkYgWIETZK8
    9BaiCD0kvAZh4MLGzTTFNVYvmBRxzOUp3RRGTaVLE3x4T+PNDSyyBfU0EDEQ
X-ME-Proxy: <xmx:eNpyasTNib5orUyII8ma1o9K8uHxQTlwZ5GbjD7jjbTUnn5_pXUjRQ>
    <xmx:eNpyah8HA2doig8dPPCPgI0jNAvDvS-2DblQ6kpBcXpMs5ifGNZbqg>
    <xmx:eNpyahL0jAaUZr8jtRYcspeuwSJPUbxscv_OHH35UvudK40cHjgHPQ>
    <xmx:eNpyats91Vl0bNi1HHvELq4ry2jtw7LlV4HTo-coEn0PfCWxBKuGKA>
    <xmx:eNpyau9wq5Qha4J82WsK4vVJgjYjBGaHq09KPu28kAVClIXwI6S1lxU4>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:38:41 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v5 v5 1/8] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Wed,  5 Aug 2026 18:38:19 +1200
Message-ID: <20260805063826.95682-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063826.95682-1-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
already describes, but it wires them up differently: two extra CBUF
clocks, two power domains per core, and a single reset instead of two.
It also has no NPU SRAM supply.

Widen the property ranges to cover both, then pin each SoC back to its
own shape in allOf so nothing loosens for RK3588, and keep sram-supply
required for rockchip,rk3588-rknn-core only.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a490..3b611b64c 100644
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

