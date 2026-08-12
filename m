Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD240F729;
	Wed, 12 Aug 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527715; cv=none; b=kolHq21ssIWdaxALmkWJGVpzOGfLiAoOf4/ks8Z4see634xN8ScFRScUVpDnO9iI490EwqXaQrZMxPABws05sx1QxiV16DzMh8p7UwctKvlcF3Vu/flgPHu8SB+z+WzM8pWn2yyZ10OQZ9mvOD6WGb/KhfH1xyc3zc6v5FNeuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527715; c=relaxed/simple;
	bh=49LsQG+QjElX2eCbzDnse345n7kq+FWFX7y+e2sBLqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9U/zwxZBb+tJtmX5pHV/FvVePH0UUdeonrgN7mskyt0ZGsrBinmbLKmJMuuPldJyVlVaay1R2P/LZUPS8LK+iuaLKNXJDFsDMYjksrSHxC7Yk/r/tnPSRulCK27gM1/7c9jPUQ+Em727I5QhGJhFN9g8kcpM5C8LQ/me/+fNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=h99nZ9zC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHuCavRI; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="h99nZ9zC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHuCavRI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 7D37613000EE;
	Wed, 12 Aug 2026 05:41:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 12 Aug 2026 05:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527712; x=
	1786531312; bh=AnRpSSR1MsqH9LAlQncz/jaOzpH1LWDcFn32HaGkRrs=; b=h
	99nZ9zCNnETKl6ckCI+8GXjDNdnaxcOSu137Jh4E3vpPvXdhpiwpROpB/6A1kCMM
	HO50IQknxuR3oGsv1kg+FHISFPWBx3J97Qk7kfEVWo5DubJnFaPlsR6uXunwc8bi
	WAiT+n4XAdlZ8N1kkRX8RrR3TCMF/+FflxpukvoQVcfwTP9dHMsgfr+iLM4MRotg
	EWrM8BG10FnuQCH4rc2C7X1eMZIrDxSPBWjyaq9YZxZ5YL2iOSOq2FVU6VFGPPkl
	NPvdlXDvuZBFS4zWuL+/GwLQB91SoyAlrAur0hZZ5oiKI8Ul+HzbtHEOddubzasV
	WqYtkY9/X3dgRjTYD2jOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527712; x=1786531312; bh=A
	nRpSSR1MsqH9LAlQncz/jaOzpH1LWDcFn32HaGkRrs=; b=AHuCavRIV5fUOeM9i
	bxrW4gzbSIF1EMY54Hm8/38F7Wf98M/4/8+C8RA/m8a8UHN3w2M0oqAdE9+5efGj
	FWLh+zQhbocTqnZUC8T58XgtKbxuM5FuiqRRS8by803jIcizqbTLpkE+Zjs2dqxX
	T0UhQkNy7RLeda39tydctiu5leYREwXHSZIXnhH004fwpQSzLqRaSknPpeUyW1en
	M8oYN8Xfeo+GKv9JUEdgg736vnuRE9Q17zLIrpvn0oWVi67IqShEWQIhE9Bw/QHz
	foAKizwGa2ghu7RjMOyUjeVsiGudLVCfYYO6pVY/Il9qxr5RpcmJMNHJxx2Z7gc5
	82bFw==
X-ME-Sender: <xms:4D98apAm9rBHmaDmIpvgVYp8bCnJIT7pBaraOexTHHvqA4qzhKdZJA>
    <xme:4D98ajr61URo0yO1EFql9h_wULOVn9VZMOXREMJ6pR6tY3KmsBh6QFM5FdLv8W3Th
    mAHm09RSKEQMa3BorDUgAG6wz_LsL6TAzRBZoLh72CJYU2hG5B9WBA>
X-ME-Received: <xmr:4D98agbzra_lrXeeLsw9-dW-DqpO9Wqi8hpj9jKitNTiCLksMDBotZYqpf2k_FVPZzXqYao4YA>
X-ME-Proxy-Cause: dmFkZTGwgEiQ82b/vslvxu748yQUK6wPursKF8fMIVbz67wiFGHgA47PKoO/uGXMsZMxLx
    gFPIgLOcY7P5CngkkiK3BYsM+NSvuArVGUEmY/S//Od5HX6j19/B4vsjpf5HveubJ3pf//
    pWCcY4ceqdx0GtHj0WCQ0o6J65xdr5brIk0MpFgwd1OnJb0OJtZbfDBehL90KckpJx/ici
    /427xioY7E6zKhb2nnVrNb5/eVe38u0ELJVPMEpl79CB4mXXIS+TOXwQ2vG5Pe68Rd3XXD
    xmR8fAtcy04eoj5dkZNb571/YdUoGmvjFo0tW/6wl1YthjyIcmyfW3v1C+VPOybfcM4weR
    wvHqR8eqTQsScu5/IIiyIBfpTWpXEAzxmfRiiXFihpCyhjxA52ECtPMO1Sx0d+Nwu4rFMO
    DarZyQhwhA4CrAV0a8k/h7ZKBHZYlCbIPgzl0YoLlqwZKJQOykbspoIwRU2+YPxa1eHCTZ
    5DsBZ9/6G2IjHrqPmLht9bm6qLFUU9Ff32QDxGWdeDg0zERa9SswppTTC2ltcEDJ5Ba5Tv
    KOFGZtuyAtKPuFX/ttw+me/fCXy+/0seTizHfM1lI2/0L058DD0ju2JWH+VT8CRIQneqEV
    c32LjCJEMl8jX3l3/qe3V14LOKzo+2ktbiFSdFAk7w81DjGK/dj7y+tSh/Og
X-ME-Proxy: <xmx:4D98atF4TOYpBA-coKFOu3jmOnOFjrVHBLHiOsu8R0mnd1NcLQYfoA>
    <xmx:4D98aubnxV5OWir9KyH03FhcT8D95iODRd9b3rK1Wnd3X5RNwBgblQ>
    <xmx:4D98aqdWE74Pyv-q8w8fpwv0-K3n_ZApedjlbg7pHh1ZKNcyHiGhiw>
    <xmx:4D98aiBMdga9ksxO9j4Um9g108docQoN3bMGg5u94jjzrsEoW3eSvQ>
    <xmx:4D98aoUlhEo4lhCoRajt-xNYkiCWCEWegANUDFqU9H3CqFAf3KdC-VuG>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:41:44 -0400 (EDT)
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
Subject: [PATCH v7 03/10] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Wed, 12 Aug 2026 21:40:58 +1200
Message-ID: <20260812094106.1391698-4-gahing@gahingwoo.com>
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

