Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0F38A711;
	Thu,  6 Aug 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998092; cv=none; b=i8AJNqCLAuCaxheji6bhVRwfi4B4JueW3RXmN3qa2OEJTDoNIJWMmQWsrT1mH/EV3Nkkm7hipmZXgVchzFLzw+CNUu+gZor5unpGBygEjRox1IZvLbxuR1aTzGpzRVCiHzQPgpeLaMIaBUZNINR4F668Cf06tGRdNUKEHR5fxn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998092; c=relaxed/simple;
	bh=oV4iDIMq5N3PrVLkQlF1wL5VJYlz7tVgJd6QkEBft/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPb3SKDr5R+ZopVbZBkWRn7bXJ2gaDFcl5eNsZC9x0ArFky2JHWG7D8wxla/g5Xyiwj4XAEp8PQv9NjBZlLUgy9vH99lTtm+YhRV9mI0/ByOv001pf6SJzbEU25RRburSPSwiOI+SSu2wa3unJtF0R1igovW+zPIndz7nnKJyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=wSG6iSfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S8YHrigh; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="wSG6iSfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8YHrigh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id EFE4113000E6;
	Thu,  6 Aug 2026 02:34:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 02:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998077; x=
	1786001677; bh=fJ4g5RSUTUngB2QsAjY07V1zWb09bk9RMpH/GbhT9pQ=; b=w
	SG6iSfdqsvA3rAq9BQEBLgV4E/+Ov8Z5W0+T0VehnEkcIKBwpHRZQuU3lGv0c5zO
	1HP8e3XcMBFnPWUJ8ufEgDAOEcZguVL3q2Z6kZK9hCJASoCWC4oHIY3FiwFSPAqE
	YpAKUlbVvn1m4n02djWlX+DEuFeiiTRnHSt9Pb6eygoFPGRb0oGya1WpAuv3y/Db
	vABvGu9GFLVQXG9X5sJiSxDWZWjppxkSZG2NqB6IHxezwHl71PHLnvs3+QKSeaxf
	3VcUK8Sbympjr3HjO3Uryu8PBfgbDponPD2qdnt/d1OGFdbaqS9cZSPsQ2yiYU1E
	rona2ZUzluppMtcDfSuMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998077; x=1786001677; bh=f
	J4g5RSUTUngB2QsAjY07V1zWb09bk9RMpH/GbhT9pQ=; b=S8YHrigh4nEKlWkvG
	+q6e2PS6wWdgKzEu7j0M96c5gdEfarubB+hhEUkXERcQF9mWg6f3ujA7bMaujMy8
	WsDZ/ksY6psrdmA9u2ove6CnwMCEFEzuAUUx8lXMRFYFXHJw8byZ9oLSkMkoZyQu
	sP1bNBV/ApamZFP8qdmMaccHGBv0VzASFunPb1yvHvO3SMCODCVVZH+12Tilsxp+
	Qh1pgt4Q9rIhRPOtNiMMy7S/iwu1VJ/RDEuVQaUo2My5m8dC5IdTyACQTO+9yK0d
	knNJeLTxRRP1+dgE6gQm55bMPikAiqBgdYzBixjw6tuN+/TTh/PAkfYX2mpQ/DYF
	b8gYg==
X-ME-Sender: <xms:_Sp0at_aqaa5Jph2NjyfWajSUnhYqNQBPZIZOAnFumVHFfeYVlRpkQ>
    <xme:_Sp0at25LBFSlotpAE4tKvg_HrWPFOYtEfJjxPcITeRcqgX6Ny7dVFu2FEJhxkW3s
    GTTMUus4qYFH_aqIosoijGESmh7-NyfEQ8NNH0u77egApsznBgSNW4>
X-ME-Received: <xmr:_Sp0am39DaU0T5dj3T3-jpJQrkCR7ZtzqCNbx6vEgUxFeM1cOtRuElekK7QGK96clMoeRwwNhw>
X-ME-Proxy-Cause: dmFkZTGFJBmuMX6/OoMIUUbGTsyRPYhG/uy10uEHxPhEMy1PtqR444ErfelFkEd6NaLDUC
    EBUCOHXp08/9Un39jJxgI9b2esIOnp5rWanlB4YhinnucbzSevlRBcSlxqBRgtJmJAytlr
    8jytKxWFTXZF+UV2dS5D5bsKb56ES/qfa3QMJcUD0Qb7oa6fVNmmcPyHheuE9wg/2fDzZ7
    r6RjRj3Ca3Q7rZqID3DpbLJDs+lnzwJj3q0SM27msM26I/izlHpq2QekLfMQvsbdpgH44l
    1K9VPvcjZ1lkCA5hd6bzp0gHNELw7gmJmQS1Sr9fNc+XDlEyKd2OlO/Vi3aDTcob1YIXtj
    lUN1/FVkDS0Q1+t3NuM4lwxsmSkw4q84vTxM5v+W8Sfdx1ycTo12rZwixrwZ3ssMqzRoo6
    +aAAnjjh4nBI98vJFrrkBy+U8ptRzn321G/t1rg2g2C9VbCAljoUf5HoGfrUoPepDViCX+
    6yaaNJJb9Q5BLxRn+zhXD89hgxVh+/tzrhghXV436FmidID654mRq6GAOZC/cwcNHN1a5k
    99+sqeF7h5tRUHZvcT2+OO3h0vYtHa2kkcAIn7PROdjiWlCZzubAAAZ1R3mFcXnYsNOwtF
    AyZO1QomI7bmNd3Oh1m0XDWNLnkwtD+W5hVJWLMhC6vSgvL2M6A67LUVyfWA
X-ME-Proxy: <xmx:_Sp0aqxwfZIfffP8yubfPL6TlBpwQlci8pe7Da4JBS5ZbRpfCrdiKw>
    <xmx:_Sp0aiUyMha1NUIuV1DqAlm1heiYs8OlH_Ia8m6avQw_cFEhtfyscQ>
    <xmx:_Sp0anqN9zV8hgTRrwOsn3qk_8lYjo070Ofd2MfY9AlIrGZmI8mXDA>
    <xmx:_Sp0avc1Z6DUNAKkjhORUuTF9BC9gY6WCw8ARnOkq_GRfsEaMMPFKA>
    <xmx:_Sp0ahDsePWuBB17pDaeCkvvoboZkV2W55tvhttWmsML5FhGQFVoY_Oz>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:34:29 -0400 (EDT)
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
Subject: [RFC PATCH v6 1/9] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Thu,  6 Aug 2026 18:34:05 +1200
Message-ID: <20260806063413.350184-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806063413.350184-1-gahing@gahingwoo.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
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

