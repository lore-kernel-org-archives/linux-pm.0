Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316293BCD3A;
	Thu,  6 Aug 2026 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998096; cv=none; b=OZmp76/dcmJpeEJa2EODIrtkYZkGgPqyNeGiSZEkJALilbSTfjU04dgX5aOO54/5vIdFbgiKALNtsoeu/7JKUv7YsyPIzfo8Pa/jxuy0G4Xm09Z3yYLwlw0cRY1rtinyYzcYGbpvYW/+t+lBZvGXH9NOq9Q5PigaZvX3lo6zDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998096; c=relaxed/simple;
	bh=49LsQG+QjElX2eCbzDnse345n7kq+FWFX7y+e2sBLqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+HptoTnexLVgXm0q2O5BXzLTyOf5dI+62IEeULiKMO0MxSDRsSMdUdTLoQYVSnk/LgsXORyEhbBdvu0JI2vuIZAi4Myd2EA7XI1yHgd9RuDIzmRvIhuKyHLsEhZC6Ldxk1XORHS5epab1qgkg/u29XqQmXaHvC1m8++aBxUnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=jVo7OWtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GdddeNOt; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="jVo7OWtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GdddeNOt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id C173513000EE;
	Thu,  6 Aug 2026 02:34:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 06 Aug 2026 02:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998088; x=
	1786001688; bh=AnRpSSR1MsqH9LAlQncz/jaOzpH1LWDcFn32HaGkRrs=; b=j
	Vo7OWtWsPzxvrYMszx6TmSpH8vDscYdf/75Y8C6pERPgq+gB1dznvW4cSFu8jpjF
	f4UWZ69/tJZ86tA6x1hGrhPrJIX3TIOcq7kdmeHs3yXocY5epgzS+5LVrAATa2Fa
	QM406Hkr3YRl4OF2wnJUBxsFlrEQT0mxmT3/MuhWj+eFk2NJrMYjuxmfPnEwO2/d
	OJtIOiXqnnbQtKQf4IMC3yZNCkdGkt+WXIjUb5CKTzmTPeGGvHcNv2jp4V3D4i9/
	0Jy1FUAwx0ErJTgiI5Uaq7xhMInTAuV/iluEKEGuPQslIyiuIyEuC7v5aiMlrjJF
	6c0cOoGtWLmtVk+XhjEMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998088; x=1786001688; bh=A
	nRpSSR1MsqH9LAlQncz/jaOzpH1LWDcFn32HaGkRrs=; b=GdddeNOtKmX5W+dvo
	laHjsZMHpQMEJd222t2Q98z21TBpgFVPh0w//cjJ1WVkiO3RLKDdq4oof0DSIXhS
	SfVd9KJdcwHzuxBCkrmIDVHP81r0B6VTVeOQ9A0onLP4A8e4vjEIeZ3hZg9JhiwO
	47IkSsP6yOgORBUdZb1VKf2qfqjnWOX+S9aj6aogbv+8Z5LQRPUiljX0bg5nrKod
	zgZFxStzN7o2Vll0S6Zm4/Kckmqhdo2f+5YrOVTvXwEH5LYoYW0l5JICUDjjAelc
	hS0n5ZqVXaFop8WMsYLDnitMm5Flr/+qknValMX8rg++WZX4sJMaAS6Cd6i65x9L
	se6Rg==
X-ME-Sender: <xms:CCt0aiCIeR5NuczN8CCm-rFdNLfvzgcXsDy7_ZNWkcMDEXTiLTDheg>
    <xme:CCt0aorkLcDHMdr1cIKOyyrn2Rwsiemdy37GNhfYw8C_-41zAjRGjHZQW7MwXCuKH
    xH3gyqJ2cyUA8-S7TNISPNBnidqPQaL8uUGaTHZyD6DTFZiVLNVQQ>
X-ME-Received: <xmr:CCt0ahaXYJKuQAVJeJaM1cMrdHI9yY1kWc69JLAE2nNnyXkV8UN4sJqLogiXFEMEypdZVddVIw>
X-ME-Proxy-Cause: dmFkZTGFJBmuMX6/OoMIUUbGTsyRPYhG/uy10uEHxPhEMy1PtqR444ErfelFkEd6NaLDUC
    EBUCOHXp08/9Un39jJxgI9b2esIOnp5rWanlB4YhinnucbzSevlRBcSlxqBRgtJmJAytlr
    8jytKxWFTXZF+UV2dS5D5bsKb56ES/qfa3QMJcUD0Qb7oa6fVNmmcPyHheuE9wg/2fDzZ7
    r6RjRj3Ca3Q7rZqID3DpbLJDs+lnzwJj3q0SM27msM26I/izlHpq2QekLfMQvsbdpgH44l
    1K9VPvcjZ1lkCA5hd6bzp0gHNELw7gmJmQS1Sr9fNc+XDlEyKd2OlO/Vi3aDTcob1YIXLQ
    LxZlV5GazxcH7BrV7X3Ie/38Cdt9HHtvkKNS7cnXAoHdzAdp4EiJiFF9pCYJJgMcp1CSsf
    eqrv3v7tNKg0Jooyxx2PM7Xt8TX0JCtdIWx3YN3VnshI2whsH8802jrKOTNJUIgPWxSyJV
    T3csEgu3z8+eu5/aBWcRAIxNhPdyK9vM8WRm6yNiHr074z4jupWDbfprP3thrvcVdmwwQd
    4xu82xLfnY7gmWH87NAnxZSu75uJahT18hYUrMFANpBwJ1o/IMzJiXyXlvEW68YnH+EqHS
    l0vgs0rCG+EtJ0/NIC1lbnIrE4ZEJTZtEEe/O6DeKyQDi2OvXpWZ+HsHhM+Q
X-ME-Proxy: <xmx:CCt0aqGzggoZLWAmWHaeEj-cEKrG6wAA1nfoGqXxVhlowHVDow09Dw>
    <xmx:CCt0anbScxpTECDdxeiouShQYnaANErB0nms9bOjmv1vab8pYEtBvg>
    <xmx:CCt0aveVnQQ0QhsXIgCMVrttkaywru3zLmp5jZ-zRGizhlmAJxhCrQ>
    <xmx:CCt0ajAh9QHoPhpqbDNedc4jJFxFH60VYwRPlQpH83PdX5ebVw5orQ>
    <xmx:CCt0alV9IlewKxfyuxg8uDevoYL0X2PA0N5o-lK8MoSbjYzgPM931yEF>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:34:40 -0400 (EDT)
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
Subject: [RFC PATCH v6 2/9] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Thu,  6 Aug 2026 18:34:06 +1200
Message-ID: <20260806063413.350184-3-gahing@gahingwoo.com>
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

Some domains do not come up in a usable state on their own and need
their resets cycled once power is on. The RK3576 NPU domains are one
case: without it the first access after power-on takes an async SError.

pd-node has no resets property and every nesting level is
unevaluatedProperties: false, so describing that in DT is rejected
today. Add it alongside clocks.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f..f23c1a118 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,14 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        minItems: 1
+        maxItems: 30
+        description: |
+          A number of phandles to resets that need to be cycled once the power
+          domain has been switched on, for domains whose logic does not come up
+          in a usable state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
-- 
2.43.0

