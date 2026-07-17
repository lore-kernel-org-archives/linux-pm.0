Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1A2F8E9E;
	Fri, 17 Jul 2026 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278378; cv=none; b=uWykIiwdP6COQLIX66IcuLPrAt5zUzdn6xCOvMUweOeUHJL5ooi3IthQh75lCW5Tqa0rdCNPtosdVhgDVm/1gq4JMP7arFfFGy157C1wU6yAUnWPKLrIBiqtBiVMqkY0cesElCNXghOLqqTb5xzYLIyU5I8WfFyW2kW4aDStvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278378; c=relaxed/simple;
	bh=3hmQwi5CLbuGAcazcePiREkww0em2ryjBUjCW/OwpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxuXzTqwpfGipVajbKTc6brPJF3u1awJPdWSiR5n1XfLKsiWIugxLeuRZ1ID8+qxphsL8dMM7lcatafoZpVn98CLRcn2zLkCYYKgNX2l8cJyufgqL9mEAY66U2R37dnnC0ofwUU4IW62COXGxRhxMBF613lc3yq5QVVoAeGkxek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=EV3Uv/Za; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0rPuvGY; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="EV3Uv/Za";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0rPuvGY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id E7F6D13002AA;
	Fri, 17 Jul 2026 04:52:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784278375; x=
	1784281975; bh=LFrLmXfIbuifi2fq9urlAuWTT2eNH/ystm/PsWX4Rsw=; b=E
	V3Uv/ZaXaDIR0evVbL2ZKAAyiBWjjBDsEks1MC/sAcg31yvfdW84P+aIHVpKvLE2
	5WQgOiPBVBAW8MVXndJlSy+QFbf9TvQGSyY0z4CnEw1s1p94TJer+Yv6sVvRkdOz
	R/OkzU3SvuJW8+RtF4sU1miYzRjyEMN5rptyTTvcrSBq7Ike+1QXy5Iocflxrqq0
	nD7dYD3ofv2tlaIglX48Mkq+tZMrMlzsr5IXVwprnNzZ/thnQ+u3YTGK0JdjoMsW
	8iqjiWZs7Bbl3ZIpipI0j7IJf2QBLiL25zgO0P9bUDQoI/fCjznHVB17WoGLI85q
	5MWf6+uK5gg90MrXkCSrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784278375; x=1784281975; bh=L
	FrLmXfIbuifi2fq9urlAuWTT2eNH/ystm/PsWX4Rsw=; b=e0rPuvGYlrksLwfdl
	jy/96FW8ma3v8AHKR1eXHmnAIZEKt6Vk9OAYOkfbblwUugQw0urxlHVNXwTSutlu
	anGPIckB+OFzpjA9qOAR3IYwx9ddkvY3oCV67mCNXtqSSFBNLDsrBLOwj/gOmIMy
	oO5s2m1Txoife8SnCq03c8MsKBOGeHiEo4Yw73DXAjYcXWfIfmGIbxleyhdhoidW
	RMqF6G6ODTrLyrmXAJHmARnTpm0GNPwbCudXcW4vzDdsCxLje/mkyQz+Q6SyTQXS
	iqXR8HKmpxTkH+/vBKPu8dL03WQJ9zig1y9ZTAW2dSO83RxMkgJc5nLP6z5J2piF
	xATxA==
X-ME-Sender: <xms:Z-1Zamtq2qF1Me7NmEHs-HGNm41gdD1g3GPZ-FQO6NhDCIMAy2cZGg>
    <xme:Z-1ZanXAQuaNPaI2DcWwHMlB1j0qSJPukF7jl88htiPmtP6MkdKNIxnKQPRj4K_ri
    ahxfW9KctefMuM6u9J5uFwCtLO2HEOmwjD0qWlYn3GayJyj0xnwy5s>
X-ME-Received: <xmr:Z-1ZatT2RO4lstf4QMMx9hfNIc0KLNeYOvHIMXzt5hoy4bKK6oRjKi2xTTK6bDkq06zdxbDcEnZf6X-DEQg>
X-ME-Proxy-Cause: dmFkZTFKgLZg3eiKsItrAZog+DFhH3PPGLnzSnarCUeNKzO8IlnkZCjNB3sgT8GthLC1Xg
    IvJQkADwqDptr+dTHsfASZ9bA9wWe6sAoTiHGLBbDiihg2eC/DPK2ZHSML9NDLc2O58opm
    CO6H5WnAZOuDssEHAPojH8O3zZqDBaVxFzE2kFvvabx5f4bBwDbLFpZQczL6I/+mzdU8bo
    ZVSoTIA7NlZXOmB47dpGcyMee9KDWKTuVBnimx6RlmicnM3hpX6uzk/z/B24Lcj1RBpaDS
    l4u9/GT6IMgnzHKW4PFFlEOcllaPmqnYFWQrwgvgk5NV8FQsar8tOlZDrFX/HzosSN71Zw
    gquTW+mRuJCPCb/HoYnfYc+lVw5vZjOMFsVkf2QGtzOtzkP0kW3N7kInZudhFok6gvvyu7
    G6bWB9XjeBc9lWnGDGoFPxRFkzCZnipvlchYNzXCQk/HJ0zsbbchLCU1FPs0/xJ/Uj3emd
    tbSfvW59LNC64zEVg49ugpPqJdowz1RFoiQljUecHEUzKTTiNXiq6xsDIJ7MDDLkKDR+69
    vcNOBgAvo43QhGaaJ7DrJmKAONAONCw7PvTw52/I3+usBUzAekrmHMSvEabvdC/keNyUEW
    3abDD63U9qULL85uK8uaedmXJBaLR5WA4P8uyCydn4HP7/SpAnHA2RKaVtcA
X-ME-Proxy: <xmx:Z-1ZalJ6AiBU-BhPku12Cb8cCyaW3gWQyM2WrSO36cGWIYJcjmJ82w>
    <xmx:Z-1Zau159zX1OqHCFe8wq3J9OpzHU5eCOmN2HTqPRGVckZGZIOgkPg>
    <xmx:Z-1ZaoJuwf5p7TLOZ_kCEADGJbZRy7B9UIq0njGg9XEV3SMiTohyYw>
    <xmx:Z-1Zaun6Ruf_IPN9D6K25bMkLZUHotzqguPZC0XClIiIr_xvnVdB5w>
    <xmx:Z-1Zaid9ohDTQzSzikebSUhGGwlPCtMb4I03ZO-uCHCulL9Jm9DEaSbs>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:52:49 -0400 (EDT)
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
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 1/9] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Fri, 17 Jul 2026 20:50:39 +1200
Message-ID: <20260717085220.3212274-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717085220.3212274-1-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the RK3576 NPU core: add rockchip,rk3576-rknn-core to the
compatible enum and drop sram-supply from required (RK3576 has no NPU
SRAM supply).

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a490..d904db3bf 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -75,7 +76,6 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
 
 additionalProperties: false
 
-- 
2.43.0

