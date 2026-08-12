Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD140927A;
	Wed, 12 Aug 2026 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527725; cv=none; b=eotK6fMO58IRrWrtrDE1s2Yx7NbRfTSMDjIhIuvqfUkBBO0aY/5UoZUAHDYN8wuBg+sYf63sBBBIaKlLhKF72VIdoabm8EG8tAkQ6BWXDShPCUN2XuHpaSy7en37+jEIk8XVeQhHIijU9fwRkwRDjftg5AWEN5eOgt0RhGw2Aq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527725; c=relaxed/simple;
	bh=Df5AHuktF9fz7Jm/CYNfDKMnRCGULu7pvSBW6EFPH5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NINGsjNCT+8u6GgxlE/wsnfyYsOZ0hXO5BTfp9yrmqxSIHoZ4pQEF4CTPJx8dK7iiHMn7tcMsIo+0EF5sMqtqPWqVZspieWPTuT82MOwwUkwF+RxYnx6SECDSz6v5f4Jc3RCEC6Pj+0oWXSl+FIDF/CogH/29i8zwmgX8RbE0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=lais61UW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fRYs+Ls+; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="lais61UW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fRYs+Ls+"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id D202D13000EE;
	Wed, 12 Aug 2026 05:42:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 12 Aug 2026 05:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527722; x=
	1786531322; bh=dz4911OQ/U9WwE2DmYwJp/fanXix6/EOPELe//q1LB4=; b=l
	ais61UWwaCLyylBkSoQphf/cIqF2NPA99s2v7ku1itX2K2YMEqHDsMypyC6WA7Zd
	Jn3cFOeyiWyyuRjqcfGCiK0X2J6uo3TgmBDjVXCfRbGjP6tunzIPylavKGJLarjq
	fWQC3TniAdbYGijiV07CavkkwtHLuH//H7oZelPq0yqzP7lW1+FJy1hZVsBfXzT3
	FWtNoTUAYtprmjIGjZSxjC39WZOpNPrC7xolDMaS0B6r1ayB0dUPMPGYMrMXZRiS
	ch9WC4v5xgV+stzsA+SEmo9CJKG+STSVHSwNEDlypSbWbavShVi1iLDnL0VjbE6Z
	g5QkbqjLoPs6xJyXgppMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527722; x=1786531322; bh=d
	z4911OQ/U9WwE2DmYwJp/fanXix6/EOPELe//q1LB4=; b=fRYs+Ls+wOVhBcsVq
	env/uVeeU2m/oj9gXTWhu7Uc7xO4SnQmW3IVkYr3qEId5kbewhdSXb9NFsotmjVc
	xzv3IYhmf3UfaWiXdwET22tx1HjRGstoNbtB5F5AC+cKXjiLAMkQiMDp9J6sUjLK
	UnmBF2+EDB7nm3iBySvjzBwvNGpfSyJ7KnnUy0AySs1KHLE1gpDHBtinYH8VF6G9
	qxyaEwgIL8WZjuyq/OD+L1IeQvs7A+eLwtxX4pbVYnWArPuUkqcVcJPjVU4WezNv
	aUMdUbx0Cowno1F2JH/WsE+i0O+ZdqEjImIWuXg+2e+EMYzRZAFe+E4i0+J27Ugt
	vy2+Q==
X-ME-Sender: <xms:6j98anPSs8uKh-fkQZipQJYx0r1kBXp97QO5uaRL768-6PXTkcy6Sw>
    <xme:6j98aks58i4LZ5xTzPLI9_b5h4YnOKXu1-NDkZKeCxKr86lGrbbH4xlGckG3nMEnM
    O8YXVrvguHEpNznYXmDpz45TcuJFwnKw8ea0WnCSm_f-lAZlOYwNQ>
X-ME-Received: <xmr:6j98ajJiHAtc47wbwg8jof3PQZ0HVwjcd7pXcDoVSLW5gZtMi30Gxhd_g0_-tXeCZrjFydW-tQ>
X-ME-Proxy-Cause: dmFkZTEYvpdseLajXWUr1gL0M738NU2iCql6I+cfa9FIs4o2b1w02bNCHerinoxzaTZtlB
    i3JmzYV7kDt82Fjkba304pAgMI6zthPVMj0KUas/ulgVDYM2ahl8MOoZQikFukOGelpnnl
    H5n0QN2jPNupPSzuU2pHQwuSAw2W7/32UZkPSSDDRERO+Kgv9afvOYwY9PmVH9gTM6PDK/
    r2at23GMPp04dCk/KJj96WqbecHo8PaDJ9uhhz+jK/nMwkSI3Qgvli1PV4tKoqDCBQ/sVQ
    j/Qmeb1L+0vgs4Mo+TbQvDHYr71jJj44D4q7FcqCoxvk0BZ7a/N2iqA0aeAAvAiMbFRDFt
    yhegdjWM8HklAQUH3C/7BCaoVxoGr2prZm1ciKyuGUS8a+4AoeACDjscO6tll7GLwSxNs9
    5AUEK1ssZJNKas4lRVzk5nJSfiwtJa0uLf/TAnQc+b1p3imMsz19pswppsK451u3kkTq86
    XWhmo8GFqshY9v7NbQ08mCy2+7vKrnhZR40kj+TG0HlwxiFJDZNkncI15itMFjgYWa7ccw
    fAJvXc39abNylyupLmHwggKJgZagDnZgUJo7b5NtMLxFWIxQgHRy4vofCg7FUllENvnJPa
    4t4zHbseMTD8Xjg3/AtmrI4m4vxn3GtMAWbj7/1box0OAH2E7LOBI5Mj6uTQ
X-ME-Proxy: <xmx:6j98ajNsZRol79xuY4aOfsfcXs1I9XjoXqf0OIIU5Agl4EnxCDtsHQ>
    <xmx:6j98anDZ165qDjKG30xO8UCpgkPWS6ZEAKMhSuqXXaIwi-oKhHVIfQ>
    <xmx:6j98arWR7vYsrNyFWu_IP4mLqfc-DW7Vt2WFnO289XEdB0FP7QA6uw>
    <xmx:6j98ajcnO-RifF9IQ9g1Mlecs3FkcVFD5ZNb25BjEqeOG04CKJ8qHA>
    <xmx:6j98al3wJhPdELoqD-M7NyS4ge8cu6vr0elsR9PnvBCQ6JEhvklyo35X>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:41:55 -0400 (EDT)
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
Subject: [PATCH v7 04/10] dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
Date: Wed, 12 Aug 2026 21:40:59 +1200
Message-ID: <20260812094106.1391698-5-gahing@gahingwoo.com>
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

