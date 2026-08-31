Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCA3B4E9B;
	Mon, 31 Aug 2026 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149361; cv=none; b=XUdsOYf62PYl3hKTEOUfl48jOi4J/EubX5MYLQfnhr5P58tW2TbBeb23ChcJJLPQikOlz5+NwqZqLdArzdctdfSkccKhg37t5+ijNc5+5PjCghb5M+jhoPtrOxJp7M944i4g77komZJ1VATjAs3OdcQa9t5xRDpJKDlGLtPDe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149361; c=relaxed/simple;
	bh=ocxI92rXz6jlGIQBVHlzlo7HwU0/NSLjOc0Plg88GpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6MA3tcPME7xQtiZAMZ5yBB1i0Fih144H1AAz/aPzizeh477I6Ipqjr7MBI6B6A/wZdGUTREsl09SqYLp4mTtNZllTGOQYmh3gkLi/XFmEthshhmXGbt+Zj+Sa1UgLMSXykC7+fiCbON6lCyzPYwxfsXTtVj3ZIHGJIawg8F5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=L9T5+Dnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FMWJSMDx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="L9T5+Dnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FMWJSMDx"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F20E81D000E1;
	Mon, 31 Aug 2026 00:09:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 00:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149358; x=
	1788235758; bh=W7m+cCkjA3WueMD/RPZpNcMr0lXTVLw93fSG4CHMuGk=; b=L
	9T5+Dnw5aCb5M0+C6meKt3RntXCoGz40/meWqqRzgOGy7ub3Spm4zLZyRO5TEsud
	h/3g40HLh/2j2hNwmbeY93db5vqf/URZ8RAdWsqvRUjqxjvS4PFbsnOB/zqCX/6u
	xPPWr7kRoMAQ4UrOebqJDL3AqNvQShegTM6oNOVCNxQ7FhXNqbu6c544RFTRuNX1
	FWNnwxcAamJBJ2YS771gJe6Ux1Lem1yzLoeLxFciQmXSBVSuukqIzwmEtJL3J97W
	mWocBjUcxCQ/dYBu0SXwjI1P4STQkYhelTBz2k+ZeCaQ9rmAKXUeBoWzNS3gmBEa
	I175Z8tKoD2ClqFJFwDnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149358; x=1788235758; bh=W
	7m+cCkjA3WueMD/RPZpNcMr0lXTVLw93fSG4CHMuGk=; b=FMWJSMDxtXMNU81iP
	UNp9XYSGdOKl24714CctZ0uUbvJNAPHpdkjJDOMjapmXMEAqI+U54KR8FawvBHiw
	LlLyxk8x5zgwov3047vkLMofyRcB5JQ7ciUley8sBcXCoWwK+pdejk8e/5UwqfXy
	MbmfzQKMOiP5BnynqHJeomU+xugjfp228EjdfF7KJaWwmGrvCSDvSF8qLGzdTFV8
	8l7jBEgyHHYWMtbsnPKYYAuBo4zdWjUPsez3ZptKwOxlovbQmuiAttW51S7PPcXd
	KgBpSZN8JxJYcdkir36q3h2ojrT0HZ/mr9Fk6i12wMPEAZ/xsXuL4/5dOPjX3vEm
	uYPiQ==
X-ME-Sender: <xms:bv6Uav1WhlJjAqy8NTBhpXuSQTNQV22YiDkPO5NpArMPqNU66JMCzA>
    <xme:bv6Uamfw2ta_zQp12R1mYcQ5weMsIsUVns97JggHJ9mRvuKKlOlheqT6-Y5p_zZF-
    z4XyXnZyZ6fHF3yMvWUnilm6TCOS-QQlzVKcxoCXqQlsMk1F9thix0>
X-ME-Received: <xmr:bv6UaiE-7Ur9qUdE3cLvEaslB8WyLtDGu_Mj2K4wbJX5zJH8d5WlkEumL3JBZN7POvrZLQ1aPg>
X-ME-Proxy-Cause: dmFkZTGjQoE+bumgZk1364VdFE0SGQnr9JLbQ6gDKjgf0+u/Tv4gaFc0N7xSoFs6AN7w0v
    ApOryacK8ykqctLY01Ix2xEWFe3AXQ9r2n9Rz10RIUziO/8UN5rSpJWex6cB78tKA1qNEV
    ZZkFeWstlKT/mEF+B+AbWPPXhkKvDVYvcOhLqE0exSPrq6Yd2FQ4tijmamrHWilaY50qd9
    +0BkMk+NxuwD6N7CeIj3JjXp9ImwYciAiyddF1D8uW5e1FxLdt2HXsjFM8ORpHlXDteDKi
    fAp/E6BOvg8sW1rwDtZozuuyGYy1YHlyZLduT8qpSok7AFqgw3xkTCRtwfFF7YSvr9nLFJ
    g8oywqEZ7ZQF9FhEHVTeIrGtABXlk6Z6s6V/HiG2EwFFRsKvVbsu4WG+v0VMlDM9axa/99
    qF4i05fXdlOdNvAiyRxpWWgeP3vL8JFylaYkwCOhQJLacAHHneQaj8xGRagIZ0DFOGrGE2
    KW93KXe9Z5PxAOMRYXnPoPmJTQM97lfxJYEoir1GHzZ4UtyGrtztOcqEeAys2XVeVMO52G
    L1H5tuf1NUhw25EIOq4euIqCdxDTNbb6oUWS68g/8scylv+btjmyT6eG5NphGvBrekD3w8
    nTt7rEMBLqaPnBsLcLmf1Eb0QFSFCqjMIrIz6/0T5jUem0ZsqMp1XIBsIJ6A
X-ME-Proxy: <xmx:bv6UaspLn-JirnTCJanZNe_Bpk32qeDw6x91UM_7Bnh_9WR0fQ3cbA>
    <xmx:bv6UakIq9O8PkiVtuIpC9e0DyCJ8X6FWgBEoLWdyj8mvMAbWiYSDtA>
    <xmx:bv6Ualyp1P0B7oDzn4nmhYWlnLVHrgKMIRTX1V9N8e4-QblrHGUJSw>
    <xmx:bv6UajZudrCWX_xkEIKFrXPjH8OlizJ0kGnJPUfj-TOVLSnVW8pMug>
    <xmx:bv6UatvhGoZYXIyEE9rtWbjVtXdcqWppzi9Q8784ZBaMf8SUjJnGgBng>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:09:11 -0400 (EDT)
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
Subject: [PATCH v10 06/13] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Mon, 31 Aug 2026 16:07:57 +1200
Message-ID: <20260831040804.24111-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
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

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f..83741f048 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

