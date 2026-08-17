Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B1403B0B;
	Mon, 17 Aug 2026 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966641; cv=none; b=awUclfgE8HN+upRORvq+r6Xuk/UKmQodA6ZoalGmBtRCjrJfWjnHe9a+hpfr44WqhIymkPydur57IoT3HazISwPFcmJRT5BZwJ4BU39k7IdhwU7GndAH0d6uc4FKx2hFHdBwzjs1cWNUGMqJJzk1ud2Nmtz2+4daL+VPk5O4FFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966641; c=relaxed/simple;
	bh=4r4rDtj2kL4QvP+Gv+qIVL3lIgvzL9V+6nUlr4A1cuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ID8fCV3uPFvz7uviYW31D3Ab6DFgJFsSHzC9+4HU2l6708MWqEQkKWPBC7TGi/IGwpyQiyhkFWpjyHAAr64QAvAfH2FOcGFu0V/suBffbRjD9whEIiMzUO5YCypPsOIQ1SzHBBMXGyPgj0TYWyniZP8vBiXx7GRo/LItKwghaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=de7gymRD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRokXfjs; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="de7gymRD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRokXfjs"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 3962E13802DB;
	Mon, 17 Aug 2026 07:37:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 17 Aug 2026 07:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966639; x=
	1786970239; bh=lby+YKGYne2e+SBq5qvdcTNcFHIm7YId3vHFaeK2h7M=; b=d
	e7gymRDYMlScGDp70tPUdRljlwGLJ6KiviJ706mafNmY5tDOb1UMeLtvKLajAQ9V
	66XW4rYlTgrRgwe/EEK0wSFyJkKsQ8FoE6Fklhehyl0sLeRhfM5TIzzoXgnLRB1y
	yzXp9UirBPICmE0rBRtCHq2OGDjsalFyLFkGtME7yyw/UKeCQYIonChaIFV9U0vq
	em8kZbZLQx+YmNMdcCh/cq5Z8rxla512LM9UeWpGVAnwaTGLo3OwisbK7j/cC+lX
	D9jkQEIDxm6Oj2nJlZ1TqyDqO4LX57cIXi6t/XGEyeulbXl9VTY1i2FVu/yvU1Uu
	SY2Fnz78EHTDtN+EvMk5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966639; x=1786970239; bh=l
	by+YKGYne2e+SBq5qvdcTNcFHIm7YId3vHFaeK2h7M=; b=gRokXfjsfS5YWjP7E
	q+CczumhAHukEMKU46qeOY66AOUWPLN+lQbkhhu68wV7GQsoS8Im1LSjjzMNzN/1
	1gACSbyLJPFOrDSQIje41Wh03dOAdCMDQVTSuk3vC+cgN0eOemHeuHc8af9ACCok
	Pvy1R1boPmKyZJGNT2HcBTC40ARNPS5U7IBYU/fJNmmjfBFoY+2e9FsXOmMd9OkX
	QD1YTTSw6scAybIR9f9ZJ634Sr4xRMbk0zexguECRpthYA4Ys4MdOiLDw2VYk0aA
	/F+zl/Ja3s9Ke8M188cyeF/CzbDu+hQtj4tJ54NeL5iNwZ1CrXRS7Q7NDfSh9SKa
	MarDg==
X-ME-Sender: <xms:bvKCaqSj7r1gmOZMlbjS9OezXOmQFbTx6w1JF4ZpYRNRxrQl7co8WA>
    <xme:bvKCar4zc7F4XLQEr-EFv8A3Mv6ylN2XOwaOaZzPgUyISxSQRq0jspWC4KiN7Osou
    _M7ka1d0FkeAGVWhg02-H0TaxY4T1Or26Nla_9Ox4dTbhPQUXBuQVmG>
X-ME-Received: <xmr:bvKCajoI_K05dC4KrskmYlQzXI0n6INT_D8-7KCeoUZNMGcsEZhcyYYW7KKqhEKcSvJ9s32zVw>
X-ME-Proxy-Cause: dmFkZTEbo03Dt9gKvRTGBg3KEH1DqaPY/H6zCcSZZeM1zR7Pq9k+21FPEdaywskSvmMkcc
    cHQ2RFBjtPcxhgy/KmNB50Y6FMXUqKJIWg52JZWhqYAF445T2t3cJnwt16b6flTr+Tm5aw
    Oq/F9cwAChEJdajME7GraNUQPPLDINvFa3LSSEkNznYz3dK5thur6LAy+M+kg2y6wZWD8F
    hVtQBPknZHWJriktC5PREMWeO0aUUNzqIcRLR7sfqAfsUY9FxPi1wp6mQNE+eG1pwEmW5F
    9jX9PSrR0OLTHeZuYHwePCiONOa0ACIpucN0J6DuEHfShdx4/NDN52R4lkIf3tcUt4ZXrL
    6rfKdgVQeMYuR3Gl/+q/46EfE66ZeaHT5zSqx9wraLED0QIpU7JOnMLSGlJYGP3JIkaEDu
    wB+m1w9JVm6ZAMGFpfDuRXJrAusoNAcHg60g+mBgz3+5IEsn7eqJCuYaUMemYrEe/pnT28
    KSblYDq51kwH+MEjuvSYL5CZy7KWfYn5c+R+wj6S0kheCpuTPu2l2+HuF1P57cDQVjwuau
    ibWerofQ9eA+WhbmviRIyM1G2RpBLIOz+aFClJUE9p4UDJz9Y5823d0f0Yp3LnhKz02q1D
    OOhGnBB11TBTYpaTzQM+a3en+THow3qDwPnX++nnLzn0DpurOPrpjC0l83pg
X-ME-Proxy: <xmx:bvKCavU3iPiJmAr-E-iruMq5A12h_uGZGtZWQ6eylTVb4w2USIv9Rw>
    <xmx:bvKCajqiID08tmSbGqR9oGtSDF_2f2oaA_-jQhRLAmnRqZSDj-ZbDA>
    <xmx:bvKCamskjIvQSw7QPkLvd3X_iVEkSmt71H0EVROaKIthtRj1QyWM3Q>
    <xmx:bvKCapQAdLRaZl7sNOXP7bmnRH4OZqb7Lq4Qc5pOSni0KHQsy8C4lA>
    <xmx:b_KCasZXnas407wd-J8bX7dLWy64HhiHO2ku2QUq7a7MI_olUhLSAnns>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:11 -0400 (EDT)
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
Subject: [PATCH v8 06/12] dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
Date: Mon, 17 Aug 2026 23:35:57 +1200
Message-ID: <20260817113603.1436067-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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

