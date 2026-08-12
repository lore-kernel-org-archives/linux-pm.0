Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277131F9A8;
	Wed, 12 Aug 2026 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527704; cv=none; b=NMx7Ljh8iuIEP6xcjF4Lk62cd0VgNQkFhFO6Sm6keXqItvBanpzlDMubh1CtYmaySF72fE+O21w4FXZQaetNdonIrEwDEZnoNyQQIFaJdg/y77MxiiCZH8GpW3Lvpn8oHI0BT2eJOtwF5uZ/hn/C590puaVwx9U3BMgAfk3qcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527704; c=relaxed/simple;
	bh=oV4iDIMq5N3PrVLkQlF1wL5VJYlz7tVgJd6QkEBft/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR0M5YJuTodGcGrYin6cyVjfgsq1W+7oO9xz4a7CMkGEZv+jKowXwGAdmw5SBxH/f1Wkofd867149tYCfensiprhILGBJXj9mXQJOa3ZsSMXZnDGN7/A6/60tGIpGgXyGHnGb1J900PiWff2KuTTSsonodvogv4QZ8ICU9UN6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=MBzgLSRS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drX/n1sJ; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="MBzgLSRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drX/n1sJ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id BA99F13000EE;
	Wed, 12 Aug 2026 05:41:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 12 Aug 2026 05:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527701; x=
	1786531301; bh=fJ4g5RSUTUngB2QsAjY07V1zWb09bk9RMpH/GbhT9pQ=; b=M
	BzgLSRS1y6TuK2caXq89K4QPxxLDs1hTR5fsRFCvl72+2eN52V3WJz2cjTgMqC1E
	20zloIzUmcqojjUsXiH18NPDQbUQi+seaZurdxvOveZKAtL2fK7wclll1eU7cNrG
	V2dEej6qse4AczeNLoH2CHydFVpagS1Ks9iDSadQjq5YkYkGkjNXkU4MjiCgjQne
	HeEYHuIs7WkNzUyqqqxLY2kZ6/RIee12CyGUb/m1KArvo1W64PcHcC9Nya7phiZ0
	cTd2EKogcqImqxidpsMTdktUBk1gpIfiEUecPAfAWMFO4gWQcafhKz/aBHUbNADH
	CveoIfALJwU5NgBkX2yqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527701; x=1786531301; bh=f
	J4g5RSUTUngB2QsAjY07V1zWb09bk9RMpH/GbhT9pQ=; b=drX/n1sJnSiVbY6wc
	D7EQDih/4ee2njM2oTOg/wvjdcUlfv7bfcyoN7kCopa/DNt1RuG4ZcXvAF9lQJ3Y
	bgzRsOrmsGVFpAR0hwKRGWHm/INPVeepsj5rGnyIvj4Sogg8vEuseSmLVsM5rHoH
	eyMiaWFVo1wTpqX1eh8ldCpTmoc55nH3+0KTeVPLKTD+DtNEsWMGGy2YYekSaTaV
	0SuiS1GQOb9T4r4r1EDC/MW9O8fmJfmpsTScXH+YyElsDgdqglgrRFusliB7JOdf
	m62IDLirS+ODSGkVOWcPdGCG7ify1y7TtNXgxmnBt6VIuHvbomerKy+/c+XJdsEZ
	AiiXQ==
X-ME-Sender: <xms:1T98aqhwo_ZsyHlZfWFzymxULbDZ7Ilv9wwWzRGmAjjd0ZZvxsEl4A>
    <xme:1T98anIWUL6K07tqjNgY-wqIGETpnLabo5QIoP4ITxbqBiWOfcn6rwL8Id1KhgpK-
    JqMhps0iIZS-9NgP6Uh2cB71YMj9venmIvPx2qu3d6eJ8_pdbB_83g>
X-ME-Received: <xmr:1T98at5GprHPKnSdb6Drp0eZik7d5XmMozRP42MXjc4hMZwTfAcyyuadsKPxn-8X2Y0LlKUELA>
X-ME-Proxy-Cause: dmFkZTGwgEiQ82b/vslvxu748yQUK6wPursKF8fMIVbz67wiFGHgA47PKoO/uGXMsZMxLx
    gFPIgLOcY7P5CngkkiK3BYsM+NSvuArVGUEmY/S//Od5HX6j19/B4vsjpf5HveubJ3pf//
    pWCcY4ceqdx0GtHj0WCQ0o6J65xdr5brIk0MpFgwd1OnJb0OJtZbfDBehL90KckpJx/ici
    /427xioY7E6zKhb2nnVrNb5/eVe38u0ELJVPMEpl79CB4mXXIS+TOXwQ2vG5Pe68Rd3XXD
    xmR8fAtcy04eoj5dkZNb571/YdUoGmvjFo0tW/6wl1YthjyIcmyfW3v1C+VPOybfcM4wjT
    LdKEcIcF2B4kK5cHnWkC6BcCPZkRlcxU1SnK3gGEFLmBy+1dCJosAA/1B3dootFu4uq2Pc
    2tgkxqQS1xPyK7tyueuXMOwRxZEmJFBPsnxUsaEHHrJtfJMut/KeZjRNgplY4cj9VQTG2Y
    gTDDaRdLMAqBdVS2dNx0JCkhvyDeYiqWzNEkTjCnbhlu+0vnjEV+FvHpd5K2WjCAafNhhF
    DT7ZQknnOWNdLGqp22kfujsYF6zIoD0B3dKq9sBx7rf9hdaVNfzkLfuXKN5FXMdWQ+6eC/
    usJr/JoRKMJe3HByv/v/2ijXD7pzWfPiXpHQWiI1Vr2HUj9Ijr2e2BAN5I9A
X-ME-Proxy: <xmx:1T98ask7fHMc2_ym0eM9ah9oaISlUTIDaDuo5CCeigutB-dCLT2Ydg>
    <xmx:1T98an675jEGAsCj3Ng_hdUN04RgNs-IrPYjluiXiJQtnIEVciUpFg>
    <xmx:1T98al_-RwH0FPCHGIgiegzCPhekd57oxH6_kGJNRKIOEodscTgJVw>
    <xmx:1T98angFMSAeJ0ovqMdCUVL4Ru59DMdymuWeUMGuKeyi_aKblDZa0Q>
    <xmx:1T98av3_pnU5K0L6pLl3YwRCAkXPIF2tDI30-kR3JpDu40ak_2uJTbp1>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:41:32 -0400 (EDT)
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
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 02/10] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Wed, 12 Aug 2026 21:40:57 +1200
Message-ID: <20260812094106.1391698-3-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
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

