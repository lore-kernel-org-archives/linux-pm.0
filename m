Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EC3D524F;
	Mon, 14 Sep 2026 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386916; cv=none; b=ubKPpPH1hBHbHgl63N2E1Xuj/AZLjqnxs75JqlPa57WIiyLdJO4Rxj+m2aUUGfawU7D6ixD1Od7ErnmR12hUbvWGR/dsJb/L0WANcrMT7IMCQY9moDObvQtxQujYRCH2UdX6m1fGayxkxRZ2BvfQGfwWbkjsZACpPV7dm5mkgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386916; c=relaxed/simple;
	bh=L4wnp6xz52IPIxAqRrOQIuBieAKVGAfHz0yW+KzJljE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OiEdqIbnj6Atns0zGIOOcs4MpmZsCCe1fv2sHRT/6mkH1exJRaBslJP6uHmZDC9Iat4ZC372cOGv2KSTa+GHL4NX3+JzTTzN6hVpGFj+IyfXqU2FpwqlvXqFzBmmX+HNjp7RNDPax32X8Kj5V6BC54uOGx005S2z+HGcvPi870I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDJ36O5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDJ36O5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0E1F00893;
	Mon, 14 Sep 2026 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386914;
	bh=Ts+GxHnFwbnnmh3W5wYX+MBFoD2caSNt+6YdLlaSQWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CDJ36O5bsDGECaJwuVwUdsOWTjfctfKWomopPi96gu3rjL48cDT58nuhFGThN8/Ek
	 oXZRLkrnWHZEw2rlcrpkaakRXjuuTjph7olqDv4OmZ5hzpZiE+3XoQXcCuL9k4yd8O
	 KgxphCOvvaxAefts0ju0bN+tLbwbTyr3G+I37TlsUGXWXvshqwgp9AtCaKaaEfIzwc
	 /MUM5j7pOUGIek7mqlLWyg6EtPwPJWRAkY01m/uMHrXGi3A8LTs2+nLjZy/4oX+5RP
	 coWpcKQa5Lsc89w0zENSnvTw5QIlgUOvO2BapV9wKzc7EUxyeNZkMVpppFriOX7oyJ
	 CxfiiOWqmBx3w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:37 +0200
Subject: [PATCH v2 09/20] dt-bindings: arm: pmu: Allow power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-9-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Allow ARM PMU nodes to reference their power domain.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index f47baaefcdac..305c1a9668f4 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -88,6 +88,9 @@ properties:
     # Don't know how many CPUs, so no constraints to specify
     description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
 
+  power-domains:
+    maxItems: 1
+
   interrupt-affinity:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:

-- 
2.55.0

