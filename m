Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A3403E82;
	Mon, 17 Aug 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966621; cv=none; b=AinVedXxOwc8iOELqynTQHFsENW/otbJKiTAIRQo2OL3wpTF4lsFUF/8yizEwoW6b0xl8VYpWiNaY7S9J7O9a1RnvIGX0riPwPAmPOl9h0KDNpTo2csnumsTUYZKrlW3IQWDNtx5jVpiZYwQPhfVo8W6F+hJEvwz4sqwrDDirds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966621; c=relaxed/simple;
	bh=NEsxuPX5MEC4uueUZv3V5rYxGhi3i5wdU0ScVrfkiDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXWmOUiztk80/eXlBTZzWJUe1fOz6uEybk46ynAT4os9f7H1u7TIUGhiQjtR9B0ydL75c+j8OHECUwN+ZTuMu8v+JWo07iWmxHhSKe6fd1itoJIS20vG/4s4gpPNbRQolYBtQhDPCjMSer9WdmgGuw8cFjVujis1gn7fVcT+kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=c2irJvce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6qglTI8; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="c2irJvce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6qglTI8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 8229A13802E1;
	Mon, 17 Aug 2026 07:36:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 07:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966619; x=
	1786970219; bh=OySDevrrI40i+GobXOkYgg/pX4BBqshAOlV1V9u/EO4=; b=c
	2irJvce7vedEl8BL7x4eSKtrvp7sq0I4s+IxaP4dsxhCxeKIkJvLz7B1OnO8G3Ya
	FB22QPd2ONvl4Xj3NglD3KUAaFB65Bk2onOFNu3M95k+7nF4boAh0iYTO9p9Y7cu
	qulp5WgAnvnmwaU5Y69i1IZ3WcdhtWVavkDt/70RIpTFwA/iKcc+fuSdTlpZg8s2
	QOfN0qz34AmiBJ5LkSu14SOSBRx+Ja47SOvjRdlLhwa6Q7vyRvrant4vDdsFVl8M
	W04xbhVni7pwml1u9BgmNg7DL1gjIQ6yHv2+rtu/Lx2ocKjNKA7fGAoo5Shog8UZ
	cHJMaYBWSirfyNssbPH+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966619; x=1786970219; bh=O
	ySDevrrI40i+GobXOkYgg/pX4BBqshAOlV1V9u/EO4=; b=E6qglTI8x2pmGbKlD
	mRbh4UeqVcEn0mDDeVEEbpJ1EhPwrub4x2E1sGafUEeCKwFChoh39M/MIM3a7wfr
	GOzUOLpbwm2D7ZNwXcsvTgaU6dYc0p+Zqok6wuRO03y2bcSRMmWDMl3i7VABu01t
	KB+Ydg2Sn56UkugVIx49zbihc2nL762pgU1KQVKGSxmtqdbTsQJjngBBYoTUr7BQ
	1XAasmM4DMJ7QodWdF/sgfH/1j55CveO1q7gmneE5I/C6tj7tg4xLA+GH3jMj5iA
	fX70xicqb+Meyxfy4DP1uiN2AMNGBm0j0mlNqDdZMak6iDVtb6cz8Ss1cOh+nExV
	3smFA==
X-ME-Sender: <xms:WvKCaoEwxdmaP6wZWthgT_Gh_yCeCnpDhC_Ien_XfK9XBbJ4yyjxHg>
    <xme:WvKCaiZEJl8wDIqWlkbiWNDfMl2qXtRORRVXmcdUv2k-QRGC3MeQka2cdKO5PcjpC
    agwDpoh4KjWk6PWFXWcSOM32rxtM_k9GleE65vj5YSuTOtce2XcAvE_>
X-ME-Received: <xmr:WvKCalH9FOILIs7kYHOuC5nlRK6YffFdJT9OQBg6wm0MB5IO_uxmCX_emFE31a58T0cGEWLF1w>
X-ME-Proxy-Cause: dmFkZTGP3FQryWN2SPm20DQenbmOfNE6fL/K4DUOThQfhpensSZoMGvODMa21190m3zCzU
    tcvgKMaeIqLYkXweO1UcSjDezKDXSKtBVakBIkbXIyYMTJARNAkI2FOvuKiw7unSG0pQIo
    UeMdkQepY+1kGdjTkqe39i1ZMgXAV7MkJSTRKqJISiFP62BzbgWPCFKl+tOVFVv2XxhG0X
    RslnFNTQbA5oM4IgWI8WQ4839e6uu0pyhyxiK4+Yo2Ae6w7oaxOoRPU2Iez7pZUeglgou9
    sVygE96o9DawYfxzdgWl2PdBzG6IqUjFP6aER0tw0YZJF0ew04pg0SPygQjA+SJPDnFZsk
    2Npq7GNxfmHjCracsp3ZIORHgJ18oJu5epkGoJ5zSZjz1J7zW3u/FKAPyC/ddCOm6HhkJu
    zBP5QwSYax0XLVFcjMnzvAodClV1F6zv484NMhLwqFr+3wFP3BVwhv8GOl14gOyY/XRWkR
    RXLQHuldhnCL9oWBRoiALDNf54qrXQlfW4pkPuF/WOsmRzrvhyVIIh6homx7NwDkvNWofR
    mCDwSUTfuIOhiGG86zRB9Gi2bMKIUNgRcvmZI0j7IImoteT658LdAPWZ9zfNMKnfIM80bF
    r/vir7rCRKyxgxFclXIboCYB+LxpzBoo3FW+JKdsRqK4EhdWG4w0GixfkP1g
X-ME-Proxy: <xmx:WvKCanznDDZopV0D_ZCeGJ5HaKJztLRv6O3dE0pzpz-cnW1F9hhBTw>
    <xmx:WvKCanGzGKh7oro7uHPY2R8q2sJjpWiQdyR4T6m58G1xZ-NT9IyPyQ>
    <xmx:WvKCasuFLJh4nyThCdsyz11X_SzHrV-iWWWB-Q2ueTJeAJaCo4O8hQ>
    <xmx:WvKCarWxEVcJ5enDEetKQ7PBj-DGFvl-DLNz-txg6NWTzVatscuO_Q>
    <xmx:W_KCasXtQrZJqxJXumLngrYZGkSDKOxXHFQDNbN3iWS8Ey9BXqXN3G-->
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:36:51 -0400 (EDT)
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
	Jiaxing Hu <gahing@gahingwoo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 04/12] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Mon, 17 Aug 2026 23:35:55 +1200
Message-ID: <20260817113603.1436067-5-gahing@gahingwoo.com>
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

The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
already describes, but it wires them up differently: two extra CBUF
clocks, two power domains per core, and a single reset instead of two.
It also has no NPU SRAM supply.

Widen the property ranges to cover both, then pin each SoC back to its
own shape in allOf so nothing loosens for RK3588, and keep sram-supply
required for rockchip,rk3588-rknn-core only.

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

