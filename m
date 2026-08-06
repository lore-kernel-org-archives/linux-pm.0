Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A612D249B;
	Thu,  6 Aug 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998106; cv=none; b=ar3P7ug7aIeVEwlJliNVa97qaVlLOkkd2p/gL4E5i3xNF/CHhf1+/bQdjrP1dIUiQwZFeokWJd6dID9KHuiraMN/497yrnFa1EG2Gupz8kEGlK5XlChZ8lJLwGYVcoNJeOypYitMGjlRShZA7mnaTy2bn3IXGI0tPPsYvyEoG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998106; c=relaxed/simple;
	bh=Df5AHuktF9fz7Jm/CYNfDKMnRCGULu7pvSBW6EFPH5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAJ8nLBUSC3kgwlNNyY+6Zq0PSJo/hVkX9EA2pL6v9R76MEKxI5JNAp8cmc8swYCN1yIrEzvIv+T8GFK+HLlwoKJ9vUoV6VXIvaROeQ2Hm/o4cnTMk2JL46BPjz+SuLq8+SSYpMoITeYDKYYA8CIb9ZiDFrgJBXXLwotD429Fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=AubB0woD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7aZSlio; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="AubB0woD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7aZSlio"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 1060D13000EF;
	Thu,  6 Aug 2026 02:34:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 02:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998098; x=
	1786001698; bh=dz4911OQ/U9WwE2DmYwJp/fanXix6/EOPELe//q1LB4=; b=A
	ubB0woDN8UqXqQo+j+neh0DNP0Iri/Ewk01Be+cz/V1DRd0zQikUwIRAj8YIIpZC
	4kHRW9hDmEOUG+Gn/JjSpZQCRJ75y/9xhXC4u3elzMW/xCoH0FJypcFuHAD4Q9ll
	OsykH9ON/3mRnfOrRBSVMS0242Of32Twq8jdaeJKVQea+znnbPLQ1skpjX7+xAqq
	2zkFRSbF5aNYLIdetpcO7HTETUj0r22Zz2/mtWKsnjiApRwKrX2HLfUECUwZq3+W
	Z/4nYf5WOa3i/0jEpA6ZYucI8TPPU/7FM9U0gyF8MHD676nJQ/66jUYv2+Jh3UDf
	/JKzrxspoAOYX/FsxG9/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998098; x=1786001698; bh=d
	z4911OQ/U9WwE2DmYwJp/fanXix6/EOPELe//q1LB4=; b=l7aZSliohhl+r4GI0
	It9Aij6q8rx8tMSP+u4DKC/atm4CQsq826U3u1eduWgLqQvwsJzKzn2XoMSSi2uS
	H2g2HsayHCldYAaYTdPH27gyLtSi+dr0zHKZzUOkYF0nB+wEIRL77l6k0e16rt+F
	MMeG6jD28xT0keaQngaUufQyDha8hXu0IB4uyF3ZG3QYTOL1QQ/s9W9Z1R/np17v
	akhB5DVDaTpuQkT9xRqLfkQrBW1gojCZQCuZF3mzW5F5qD89vlSL2qUDU96GM+li
	Zn6fB5sDgFRL2Fq0MI4vZ2/bWV0efdem63zGCfFRiJzfzjNb6j7/2ZQtsf6WBp4W
	Vvs6A==
X-ME-Sender: <xms:Eit0akhUh-yUx7SAA-LoNJSu4CBnh_iau3LrqFhoDKQCkzP01J9kHg>
    <xme:Eit0avzeAZbvtYOkY-GY9B2OOHN9EZ_th5A7KP_o-UGj0LaKyGiDl3abGOlNyBvgu
    utsYIc7IjNN-TJONiwZ68mSR5DRClXiASa8zRpqvtQrethpLXNlcRU>
X-ME-Received: <xmr:Eit0ao_0zjhLAASQGmc59X1z1FTVhdPyeO97wB_wp-yLDWMmc6mI1NEh9leRRPWjzqAQzu4eEg>
X-ME-Proxy-Cause: dmFkZTEh6EqLEron4P620rfA50oje5pogyeStsqRC64znWcm/DBV15Jp+RPu9rfpq1CYYb
    UFmLU5UCxdxDCYby+qIAZtXGI2PUlpFQNXwfYq4ttCgPHbGa62/TDDwxKwLB8tX7dfhqau
    EbUP3O00RQtnFbFjlgrSaMtfjvGvqyYuejLHQ8kaCQjYwTQGvwYjMVbSb1Jvpanl+FPpuM
    SqFyNQH/92jvSpo2kN70zd3lo4jOKuY6rGBanj09NT9Qpf7fxDVsJep1Tqo9Yuq62YMLgS
    +erfmDCU3gBbJvDrolUKAZwfNdHwfv2Y4EHW05E61S/1zu1MOw9sAC69rBYAvxBuvfJpXF
    rEZx9RIYKVmVcDnIWMeFyHATrOa77nf/u0hgh+JumJM9xqWojT/nakNe5Ca1TcSoc0wW5A
    pfWuBXecjdDNuGaXFetXLR1TxZot3SP7PiTyYTJA3P56rn13l0Alsdm9BFPfpS8LKhi3x2
    37lLTJyX3qjzyzA9u+apcedkf56ta1cnkenebGELsi55fXtOQYPL3Jdp3nuC1hnD0nx1wo
    ltHP142i/s6J2sxM+e5VM7yBd7A6P9Tl5K2xJKVzu8ECSnVp2UxK7+p0Qa2lR7IhFX7L/K
    iVbFCFW1/U6wShabiFJaktv0H9BQOi9qdIc9qbg0voSKxinc7fW6lYHmImAA
X-ME-Proxy: <xmx:Eit0asxLqZI9JH9-0g9VLtxFC8NVL9H87vrK1o-Faf69nGDzRYq0xg>
    <xmx:Eit0apWDra3wAuI4KumiIa-udV1nSnx8NwrE9q1p8XWhu9fOfgbW-w>
    <xmx:Eit0anZB4V7IdK3XPs4cIkq9Yr9oLn1UgDVoPeiE5y1hGSvSj8FBPQ>
    <xmx:Eit0amRiY5Rd004pefWYLdHMskFia8N9Vtv6BgTUpm7Qf5-ZECnbEw>
    <xmx:Eit0amscsrBoNQWkUGrZQNS2A9qPCsxS0i1CdBbdkwFe9xOLFg-tautu>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:34:51 -0400 (EDT)
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
Subject: [RFC PATCH v6 3/9] dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
Date: Thu,  6 Aug 2026 18:34:07 +1200
Message-ID: <20260806063413.350184-4-gahing@gahingwoo.com>
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

The RK3576 NPU MMUs need more than aclk and iface. With only those two
enabled the MMU accepts reads but silently drops register writes: a
DTE_ADDR value written from the power domain, while the domain clocks
are still on, reads back correctly, and the write rk_iommu_resume() does
microseconds later does not land at all. The vendor DT names the CBUF
clocks as that MMU's interface clocks and its driver keeps every NPU
clock on for as long as the device is powered.

The driver side of this is already upstream, commit 841363ebb508
("iommu/rockchip: Take all DT clocks"), which switched rk_iommu to
devm_clk_bulk_get_all(). Widen the schema to match so those nodes can
be described. minItems stays at 2, so every existing devicetree, which
all carry exactly aclk and iface, is unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../devicetree/bindings/iommu/rockchip,iommu.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11f..a3cedcaaa 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -42,14 +42,22 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Compute clock, RK3576 NPU MMUs only
+      - description: Convolution buffer core clock, RK3576 NPU MMUs only
+      - description: Convolution buffer interface clock, RK3576 NPU MMUs only
 
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
-- 
2.43.0

