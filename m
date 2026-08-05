Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620533DAAAF;
	Wed,  5 Aug 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911949; cv=none; b=FIrVJpRPuv7ftyQX/M2hz2oQo2khrGA4RDmpD7KU82kSQWvpsYJkcVBNZAKRtmzEaS3YctteDxfBKHRi1RMoXL+l0/z+dIx6ytLCVDWzrb/H6sg8YWm/X8lq0c2hBpk3Qe4CzHAJfM0NVSUkUYx4EhybD3/ZyHRsThayWzmwnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911949; c=relaxed/simple;
	bh=Df5AHuktF9fz7Jm/CYNfDKMnRCGULu7pvSBW6EFPH5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+AkDxY95vyjlIVTK9y5QUB5OxbxntqV5QGoOIbkIstgO1/65qzUpCQu3lHBGvIL2RxjiZpTAIXjquxgXyFgoYUJu2s8mnFu3Qmb9T0sYiG9K42QksUcz/wraZPbsx4fe+qUfyTZ0tHPgiZboYQtMEdANclbNNX+3OfFh0B3a8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=oRer74ze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ir15E5n0; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="oRer74ze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ir15E5n0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 9A39413802B4;
	Wed,  5 Aug 2026 02:39:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 02:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785911946; x=
	1785915546; bh=dz4911OQ/U9WwE2DmYwJp/fanXix6/EOPELe//q1LB4=; b=o
	Rer74ze2koG1U+jwX44TqXgWxGXGg5fkYIQ+thxXtSJbJS+qc2wrUeUsKqgfPWUQ
	FZviaBF00BVPTy6HW2JGYclxv1sXDWvXRRbay/82q9WaSJ3kscF6xdmMuZjkD/3J
	YVROCh288PZRnmED7QdvTLTdsLpq1SyY2sUfIDn6y5vEYjUCPcVlX2eNbj+yw1Un
	GjVCsoch3rKceMV/Q2Hd0TOgtxt4tPQm+G9KWF4xF5Ma/chG3s/fG3/cg4lW6XHE
	7mkzdgL6wRATBpoUzkgFWxQITkh7Bcm/G3XyHF8Y+pJrjbKJ+PP6/Jf1DR51zmOS
	rjKnvyHGeo2hnjnyMPZxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785911946; x=1785915546; bh=d
	z4911OQ/U9WwE2DmYwJp/fanXix6/EOPELe//q1LB4=; b=Ir15E5n0CfjzzhTRF
	WD+FPE0/0hanpJidKtAokqhgsm8VCSFbvRYp0rZGobQrq9gzxbyJgm/BP0dPPT0U
	5IsrtSJqOLzMZE7DstCBEJ764oLhD5iwMdsxjTXcSsA2ROkMQApXh0bNxZRm7M6a
	UmFOke6ncfB8x0QDCcLzGLnj472FFeC77Fhp+J5tX6jgWsrSsUyi741xOsttxfoX
	FIb+G0EHvV8snGHwyv0PnL7632VqA9ujBXELchFgZM//zscAAO5EP1H0lJJHd0Ks
	DbL7sOVgkN9SKu348AzvaVz5/1RiwNGuMhIVoC3JdXsVBbLn31FcaRavkKvPRyt6
	MINAA==
X-ME-Sender: <xms:itpyahS4GoKMzrvEqv9I0uI0JNu4bSV26xGAYJKWNs36JzRSg2VPvA>
    <xme:itpyamqY77nhBLL7FCU_qKqK-qDDtLO5iviCy6DQlT4SEmgiFO2uc9sNqq251C--4
    nIBZFqOo8-HtMDxZeFZ6ClNd0f7SpcHu6awnbfCMMUxPDKeuYj2ZK2_>
X-ME-Received: <xmr:itpyavoxh03uai6KaAd5j9-6T-qchqtz-MTzX0lrpTA82gy6sf3Uugku2-sXHoC4bgvxCfFABQ>
X-ME-Proxy-Cause: dmFkZTGweWZ3oVrdbXXe5zNbY/1qm1pdBIKLQOv4wqtwxzIaCfusFJaUYDgRMW01OwQqmB
    PNcsOh6d5VtSN0ib3zlEWexayeHywWIm1PgtBDTmi1jqIXlJ4epZiRyRlOvRuTP/H94+Wk
    lk56ToFXuoLAF80uX/ZVFpHBbYL9/inXConVeGj5fP4oIjygHxURzt/8P2LkmOCZkpV/Kj
    p0I4ZXMhB3Hn7OHdNdqEICLLcaUpxq7aYzGqf1zEXgoEoToiw/A8MuK/o9jyR6a8MALeRg
    Lewa3lXhOyvgeH3GuUZQ4nFdlSaJtvfszCwH+l3e0Qw7QgR2O5+vsW0n/AqGh0ClOQOjCu
    gSSVY5IOnWchyGm/VH0NctxrtR1j/3U12WaypKZuYQEHBCPD9Sh1a0GTfvV1EmpSl5xVeg
    QyX12yYPgYsqgw+5UJNrkTzR+c5/fHsC/zGxeO1esawFimYCoE2hY3e6tFE1D5uVpslC4B
    sJG9qDCWplVhTvb1P+iPcmcGaHU2bJaSMAfAZcsSzBWjx+q935eKVdZTIgNGz1wSuOX+ef
    1+cUqNw76PEJiKpEePj99smDFSWUVUFapXXTUUEQ3TbUtng1b/6W2r83Odl83joURDgqEs
    GM3n3jPYoXmodIn+f8pT4oHHR22f236YkESXhzIloPTHVoE2Hc3gusVLjEqw
X-ME-Proxy: <xmx:itpyah02tyYKufNmBBURrx-ULEv8OthuFaHdB4BIsUvHbSD6C7Lw2Q>
    <xmx:itpyajgqpR4RC1zjoNcJ9vlZYmMY2y0o3W23HpfWUfj35IMMu4lEDQ>
    <xmx:itpyaglw0jv14m69XE13ETphQiSfHCsNlornOAQaqXbmfLfAWm4iYw>
    <xmx:itpyar_4L_hLI0zZvpDZyL5t3AnDIZfIr7TnE1zjgI8XCCIJTdJKWQ>
    <xmx:itpyagMxbJKukPx-A4Ois5NYec0ciRM1KZoZJMtvWJfDE0tDp5TD9nQt>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:39:00 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v5 v5 3/8] dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
Date: Wed,  5 Aug 2026 18:38:21 +1200
Message-ID: <20260805063826.95682-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063826.95682-1-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
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

