Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91B480953;
	Tue, 15 Sep 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469097; cv=none; b=bQLjRGR6+LXabLfKE1OHBIyhdrRwwBiXj00dnXy4QTkBNjiViv7BbSxhsnaiMS1zHPjp8P/uVa8Q5kwPpJ4mBmF0vkvEwjbQ7NvYuOqRjThNq/rL4Zs4QACHLJ8y3MaqPrBpuPZIDzPS72eiGo51Y45Bq2ukWuPQ1wNYKDUzCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469097; c=relaxed/simple;
	bh=k+gwYS+NobpdAIM3dOhrv68WcBmgsiY15gPhhplWBQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inH1qxDq1wkZ1oLUSlU17lkits5UT8TYeUuhgiZFYZdEy+fLQWHRkANLukv8EyAMGCVhOgyseQ9VNvnyd8bWOttFsrFTF5uOAXm8UzAnvmLGCI4TZJ5zz04hXvquVT0dNrENWI5cyBQjIIsH4Uogm3DyQvN2l7pS+pjjoCcMXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=i18ug41K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OG9hm8Qf; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="i18ug41K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OG9hm8Qf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id E5EB4130050E;
	Tue, 15 Sep 2026 06:44:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 06:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469092; x=
	1789476292; bh=muWc6YiNsdF4ep6300eTVDZM5wKjxIUffmssTrDfe8A=; b=i
	18ug41KGqS1mve1Vz/btkKAXgbD+CDR+oBjrKoWulOHa5zTCigod16FSlxwriloI
	Tf8z1dX3LNmM8NM73BNybwxAdqQmZbJkmCJbBcdNsCCl1+YL0P0xkUD4Ao86qRPz
	GHd7vbzBnIplUhjrcQYnF9RRKHFaFOlLJx2IUkoHUNSmcm7mI2eZ7YzfkkT3Cnvk
	mnuIpTMcMzOAkY3DrBtTiil5cxb9jICw+Xmfe8h4k5viYuVBqjIEYj9ODcnYn+fj
	+rgJZX9J49f6utcIZ6W6oQq0C/0gwkhathb/49ZCd78mpASBNCpuGKYcRzxEzONT
	tnW05xeKuiMRrKyA4u9xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469092; x=1789476292; bh=m
	uWc6YiNsdF4ep6300eTVDZM5wKjxIUffmssTrDfe8A=; b=OG9hm8QfDR3O4ywsF
	SoTIGx49jIv0dGB34kTsYmsvxedPchY5c/xpNtqOv2yLSt+uRg+BiJItHH3O31Mp
	fVctZhjI7ux7rzfMonMctlPqtjHfAo+RRpmAswvkbe3/nXIm8mzACVRutJANiZLK
	0uqnoGDez1bMx5A7USaiCQrMNPxSEZFSoxEczUClRVz43JScovzzWcgj86PgQL4G
	LsayBQ69fu/dm8UXt8IKjh8L9YfUM4ZIn8s46oHWbsiguzKDbQT33CJp1Pylnugm
	tLQi4RTrB0ZG2rC7rQy9Bhz25ud7ECTDv/qW/F/Y4cjpgRL/MdQTobALhsi7jAfN
	FxlKA==
X-ME-Sender: <xms:pCGpanbUArGu4KbEVWLFvIo0zEcdfHPerMdK0I5wghbvxbyZSr8vMw>
    <xme:pCGpanKDUVtiQUdK19Tho0UoQ8oKRQ5hI95dxAv5DrkG0cOgjyWOBXHozfowK5Ptw
    a5p1hL-SYS4XGXdkqO-_KIWdePqVxnjiYV20zqUSWsUJvKIxIV1DGBO>
X-ME-Received: <xmr:pCGpai2TqlQ6j5zaXV0AtQJTBZQQ8izELDrsl8JVITY153R5-wbqhnm4klSXe-Vk8FT2M245Rg>
X-ME-Proxy-Cause: dmFkZTGG3t2Pe1SQ59PtZsJ9lIVvEWiYOOj+0OhEqMiVdyr6iU+SncWxYSaExRHbc/bY+w
    IDwvw0pEZBeElcDo44rRPSGzxThkv1vu71HD6PI/8P1vTeNPkT4iulfMaXjiRLKNHYVVk9
    aein6He4mNcKEJbzo1aFhlbM9FynxX90WqJkFhFHJIZ7YlgFb/2LYweskGuo8VrfwFLhzV
    F59VjdycwptChPkod4n6zXjLHXvqFYxkDDn9Zw2hI6vbJGi0gmeW/SgOGrXXTiKDCS0hvE
    ehCMQh2BKjfCh5AtTH1KLgsisCAf/WKXuD8QWLXjFSAT8ca6C5CzvDf5T/iHoC7Tc1KVQo
    sOxOGvOVWjCykUXoIdp6y5nsZfzvutkmiRrm57Mw5ZmvoCiYh3klByggSOgGCN8FFV24tF
    Aw6AFmchmDbxVIe7232M8j24MOH2peydO0eWOKLXHfqQI6yGlE/k2QkfRuGeYsuvEe2NVB
    pjpp1n0zR55Yp7EgSoCYhf/eyouV0iUyE3rrGnKDe7kKBMF067cfjPYOU6naUL1gwv3EHF
    2sXvD4Is81JUPJBnTTiBTtR3K3n/G+RwpF+Xfl6sfG/Ojeg8r+VqJnc+k/s3klBzukoZWj
    c3mLcJxpgg2ECtT0wRsNBr8MGE5IHgJHDGjhjM2eMoPGjQNsdipsaUy3HOfQ
X-ME-Proxy: <xmx:pCGpaliu9UXmnKx7WNgOW_paPEX53TtCqM7LZ0-U6vL_JZ4Ru9QCKQ>
    <xmx:pCGpahyOMGgYYOSN4zuj8QKlRJsxzJZJwXqumW3CowNnGEGm6S8HkA>
    <xmx:pCGpaqEZPZ1L10YNFG6OR7z63lbok1QPd_eZdM721DarqeHp4HslQw>
    <xmx:pCGpaiRKSxiXl0C0bFWQOX7Nnik6QNEu-07n8MDs_PSZXlO3ep_jGQ>
    <xmx:pCGpag1GasbSwpeuDIXKLXHDS1Do2-WkWn4yBiEEyP13g_5JhO9rAjed>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:44:44 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v13 06/14] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Tue, 15 Sep 2026 22:43:20 +1200
Message-ID: <20260915104328.45901-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
already describes, but it wires them up differently: two extra CBUF clocks,
two power domains per core, and a single reset instead of two. It also has
no NPU SRAM supply.

Widen the property ranges to cover both, then pin each SoC back to its own
shape in allOf so nothing loosens for RK3588, and keep sram-supply required
for rockchip,rk3588-rknn-core only.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

