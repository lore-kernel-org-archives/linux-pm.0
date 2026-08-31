Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03B3C09F5;
	Mon, 31 Aug 2026 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149371; cv=none; b=S+KTv6AXs+CsytyLoha21TFNOC6lNZavPFyzpW3iHQPDXDaX8fviDBrCWZjpGk+TM3NvrMpGtmdcQYkJ4NoGo8jSfGgU3Zi+ov9qy2R6G9n+Oq0G6eAydX4Yb3P6nXhSYYXuv8crqGILxGDkfoy4fhVAjK2fzBRNJmd47DAFDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149371; c=relaxed/simple;
	bh=CnWYRGn8A2CYIxAKUN6+IpvR0RZSQZ+TrHmYhGYwjSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=op5V6N1UBbEBsLP9J5owzc4MDXcsKSQbvcbNDOU5BfbELIxKsE5vNrT59eS1PHyJej5Jn47EEAUqd6FPF4g1aP8GzylnuvD0l7W5fGUipVWtNnEal1X5L5HfbCwr0O1pGkaQRPuAHMCrkw6z7h7Fg8bx7TfR50MKm30DA7T2RqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=CV9aWwzQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liCac5TH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="CV9aWwzQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liCac5TH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BA817A0014;
	Mon, 31 Aug 2026 00:09:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 00:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149369; x=
	1788235769; bh=Bm7huY5WQXjxwqWxfiTvH04R09OwCZF8hQZPpxtRqLo=; b=C
	V9aWwzQygkVHgN3E5R/NRNMI/wsgHIlsJbzG7POoMKCanYM9ZkWjb/9dLFSaJLm4
	CpjDsbQhH9sXc7LkM+JES5S9R+PkpUzWF8p05xzfOx9KnDGWgJrkXv+YQH9PU8ll
	axxRW9RIHjcRfE/DyqlnxG+OCZHQr7+unNE5r/8QvQoRgwZwWz4Qe4ZIWqDgD9q3
	9iqqimeKxT35/Vvmg8gM/UjowtEQiSIMY7T3YXZlAsvRzZ6SfbFg3PQRhXQxPVxI
	otcial/NL+Y95Mq5Id37zzBuD20DwUE9cBJjxkPZu7vliZOmVGE6+jZJrtpChWKW
	INMDEokcm+VeFCNth3rSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149369; x=1788235769; bh=B
	m7huY5WQXjxwqWxfiTvH04R09OwCZF8hQZPpxtRqLo=; b=liCac5THlTP8Ghve1
	mAxgUAjJumVxYs7ROhRhUjnKiai7Ln2PSXplUjWz+QHw1QaoWhRvFxi4tUmzsPkO
	oc3VngIncRmSvo7BRdZkXg0ObnVNfS5bLFSH+Ne6ua4bJ7Uf6hzJzRPSE/OWhYif
	ndYlnbOVOB/y+k/42drQcSAFCCbDpKkuybiulnn6pGIdZc7HYFeLZsVCo3PW+2mE
	BIDQdL/t24tKu1gSGXMhVWZSCMg4+4d1bCYE6/ueWN28RpohPgfJFussZ0YVgn92
	4DRzv0MzF9ctrcodbquGau/YoHfieh0Ritjz7S1HQPaR1hFxx0HFF7ah/qe0mXfN
	1gL0A==
X-ME-Sender: <xms:eP6Uat4W-Ioz7lQWg0GKCa1jIfsCmV7Dy4y04rNdVpne5Wwdfs8wCQ>
    <xme:eP6UajTJGRPbTLBYr_Q2Cd-optUXEK_G08jBiyJzXudcYU0cJW127hJYfU7YsYc0p
    sFZyO3oGfZ5rVa9wQxCcpvnDjMHvZCqNsPNNZYf99BOJBJ5nXsOWQ>
X-ME-Received: <xmr:eP6Uamq7cwuvXu6Q_VS3SWAcipILO8E1fe9XZt-bxfTbSh8QAa13sE4Qsa7gt4P2gEFO6x0TkA>
X-ME-Proxy-Cause: dmFkZTFrmGdraA1wQ3u7fSC2szCs3dTKzi/Amki67rwemwxet7nxM0ToJ2yK8NWZy80VBj
    m9nFeJFSLUsMmp4v/avaroH3z5Dq6jG4k86bAf0y32LtQ7RQOAYU0EDi/Vek7cY9IfGAli
    KbguFiQRUm7Yej/X8Q7usb0aRYgmhdttAZZaV7gMFf/0gCkGbI0GMXhWHVbjxOciLjJdey
    nBHFTEwJHw6b/X1tteAoW5feajlR4udOAumKRJZOKSBxp0+HOuOhd3F7jLrJp4hskYXnWm
    Yfl8tng267MYxnNxKDOVFuoUTQiqdV/pQsZF1H5QJFaOThb9EnTKuskqcvPNlFdWCr/4Tu
    1Kx1zm84ic3pQiOs+nUGNsjLF4KzdokkkjKlJccOli63AGG67E+EkFycjUzcmvgPyi5jWW
    8FRYKtHmss6acQVGvzq2jqS7RgC/M3TiVxUw4aeN2dZszTFa4BTztUTAQx0l/kQLXsk0M8
    eBruXnd6OJI5Zv6S4WyzIxMOENLVafd0/nyZBqGNwEYAWmrNtfzesdsTYjrbwgJk9mKMky
    22Lb4tpIpz8yheynmenEXC/NqMQXXDiAL+lq9I3U+H7JY6rV4kA0XQn2k/srs+vqsVEp7w
    pVPUPhuPpvQW6vrojM8FIHnwU64sWVMZyUpJRUIxA0mrQQOjnCaVuUfkfiaA
X-ME-Proxy: <xmx:eP6Uat85vn0uW1WxFOTzA-xRG9_2gUDwLUfFzj2sY8Y8mvFHxfLLJA>
    <xmx:eP6UajNnYncv7Nv-iD8f28DcQ-k0WCvMlb3cSOat3nc9iuUBkuJnXA>
    <xmx:eP6Uavkhsd4ZS8tq1EBJbUGnkEiuP4HOmK-NzWV592IUqWC_cXh2Gw>
    <xmx:eP6Uag_XbtmS-eXCaiAIZbFC7V8qQwxe5ej2t6NqC43bK8juOcLGCA>
    <xmx:ef6UajSvYZ_pRpyyGuKmdG3Rieum11lKK1LVVYXsEBjDpEqWPPD2QiKJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:09:21 -0400 (EDT)
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
	Jiaxing Hu <gahing@gahingwoo.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 07/13] dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
Date: Mon, 31 Aug 2026 16:07:58 +1200
Message-ID: <20260831040804.24111-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
where every other Rockchip MMU takes two, the extra three being the
compute clock and the two convolution buffer clocks.

Give them a compatible of their own and pin both sides with an allOf, so
that an rk3568-iommu cannot carry five clocks and an NPU MMU cannot
carry two. Describing the extra clocks as belonging to one SoC without
saying so in the schema, which is what a comment on a description does,
leaves both of those spellings valid.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iommu/rockchip,iommu.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11f..83d7e7c8e 100644
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

