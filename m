Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5F48380C;
	Tue, 15 Sep 2026 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469119; cv=none; b=m3UJyNeZHq23G/NJqiLLS+XqOCmmU5YNnB/7zTfsG/UYtQJb2NcjFuJHm84Irnizz2dpP44tbb+6rIs4Zfzrjd38bDkx2xOOv/dA4y5665zjvXlrEfzk+sesae8nHa2cdGk0QwtX5ZaG2rRu8scXHqt87A1COZ0ZKA/5t952tqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469119; c=relaxed/simple;
	bh=t8745wRWNkKuyuDHBQoZFLJWeOid9g1cW7YEvJI2P74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/fEtzOWXlySHZTygFm3hrLNU5OTSoYP2wzm5qiDDiWSzD4UPi37TcHUcmLZEtIiEjf32CV0GjH8c2RZAa5qXtmusZVFL1cTZgd9xAuXSMI5CxKz2Vaj9vmCQVc4j833TQiCTCy8TLVTUBBeHf3/gEQbwBu2vsE71E3dQgPnAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ZNBdsXjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jr5jwo89; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ZNBdsXjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jr5jwo89"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 3CAB5130050E;
	Tue, 15 Sep 2026 06:45:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 15 Sep 2026 06:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469116; x=
	1789476316; bh=EM0swreY1zyIAIB6E9vTAuQx73Txv82P4kLUWclFi0w=; b=Z
	NBdsXjOTfxQLqShF/u10fmxMjcWSCmihmXU0lorl4p4dzoTmvac/Bn9h7hCApnBZ
	RwV+1DI1PsdGqaNDKPzQIGhVzAuV9eY++JLdKq1h4beIQfnPuhaFlyMjGcTSZB2Q
	PWBhczMiu/HMSibgKuALKDAngekjHeiuXaokSrcVAtMweRvVnyytxbeP1SjVxN1K
	Pb+AcTDEgiLiAnLNmmz70nQTjh8Scz+iDk/UD62WHb4+AHY3it0G001eDOmZwab4
	pTdFyhK5So1fyauJ643TpBKN35nVNZUwkuxUqlBtd9fgmHIahMsfvlJ2ewWfGFV2
	Oy3zsYLsm78kAVirwgZKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469116; x=1789476316; bh=E
	M0swreY1zyIAIB6E9vTAuQx73Txv82P4kLUWclFi0w=; b=jr5jwo89juUECPKIA
	fxvcps5oWmrfFeBY8k72oXGjlMUz5p93xC+Yj7YH0m3UOBIAHtaRAio2dmYOcIPA
	/tTsUHCfT4wsQEEscB9J6aDQEEbk2sWN/TpOGqiYBt7gn4gjrWK8Tq63w1zwwwf4
	ak7wAA73Vab6jufB3Ic2E0hKKvktdaeJAH3/7oxi5yu8iVBZ2sRVNpHoRojSaRi1
	yuJHCbGPTqcnurJh5m9pykGrg4MZzTLSwS807yxDi6nYN69sLoQQ9wj5+ZPVPiia
	uff4jZxkIEe3tHCtZDQbz1dEujSayXj/DKXCcRvV3V31eEFVfYqWTlnBKq+GxBtj
	B8zDQ==
X-ME-Sender: <xms:uyGpasXBVIiPDMQ2tuU2Xx4OvVx34oB7DFKTFZFBSAmrYGkC0rfBEg>
    <xme:uyGpaniAXKMFSxkvUZd4t_aU9d0-H1L8XhEhKb7XsRoJ_ZCxzv1ZbcbYHzy48__GE
    pse1rxblpOwxD0eKb2n7habVsuIlizv3yTztgGWppBk9Gn6pUENwQGJVw>
X-ME-Received: <xmr:uyGpam0uL7Qk0O86M5H2kaKGP1692ZqVwz1Jl9FHlZp8g9knUAxl86SclstQXeE3ZE7kgzV36w>
X-ME-Proxy-Cause: dmFkZTGG3t2Pe1SQ59PtZsJ9lIVvEWiYOOj+0OhEqMiVdyr6iU+SncWxYSaExRHbc/bY+w
    IDwvw0pEZBeElcDo44rRPSGzxThkv1vu71HD6PI/8P1vTeNPkT4iulfMaXjiRLKNHYVVk9
    aein6He4mNcKEJbzo1aFhlbM9FynxX90WqJkFhFHJIZ7YlgFb/2LYweskGuo8VrfwFLhzV
    F59VjdycwptChPkod4n6zXjLHXvqFYxkDDn9Zw2hI6vbJGi0gmeW/SgOGrXXTiKDCS0hvE
    ehCMQh2BKjfCh5AtTH1KLgsisCAf/WKXuD8QWLXjFSAT8ca6C5CzvDf5T/iHoC7Tc1KVVA
    S1IdwXS2VGoXxxGqKXkQb8xscbE8Q6Y0JvzsYbHxu5MjsVUxQa/dDIMyDcJziRJiQ6l2cf
    72No3qjFknmHNlLSW83hFj9f4IciEOPkPLdJas09hDZTKVfOKaZDQUVTPkvEtapRelno3U
    HFE1oYXsx8Nc1SiEmBr96L+YvqaeOSrHj90aFz3WFUnKTYdHeNgB2yRUGq+Cm2FgFqrwik
    bg+ECg0XXlLvP8y1/rHZ9VE3hepf3VzZXR4kvhca2Am/rzI/i0ggqNbGJy7C/xJ9M6R/SU
    K0c7boogVZUK5B6TF5ngxKGI3TfwKXoPNxbTIbzmWhIfIHWw6bM7W6Bq+tgQ
X-ME-Proxy: <xmx:uyGpap27u6_vIdsHMt4u8Mctnlz_UIq8lqLuHmwlMkI-u7b7qyIC7g>
    <xmx:uyGpanwf_8UEuJqvuM1ee7CUkdUQlqVZQVkkP0dxKweJruT8nJ24vw>
    <xmx:uyGpavtl2FdDqxs7hltcWpvR1bwHw1OvOY3yRfSXSH8-EFvzcgCDdQ>
    <xmx:uyGpaoMw-Vo8V5Ij3IG_qC2O2K4Qx_HHxXXgPLkA9UW-xlYeNXOnMQ>
    <xmx:vCGpatyR86IgSQSNSd4MXsxBrnT8dDeYuV9VMQs-iYxxRNUuYeZR8Cp0>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:45:07 -0400 (EDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v13 08/14] dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
Date: Tue, 15 Sep 2026 22:43:22 +1200
Message-ID: <20260915104328.45901-9-gahing@gahingwoo.com>
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

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks where
every other Rockchip MMU takes two, the extra three being the compute clock
and the two convolution buffer clocks.

Give them a compatible of their own and pin both sides with an allOf, so
that an rk3568-iommu cannot carry five clocks and an NPU MMU cannot carry
two. Describing the extra clocks as belonging to one SoC without saying so
in the schema, which is what a comment on a description does, leaves both
of those spellings valid.

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

