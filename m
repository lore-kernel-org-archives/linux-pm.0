Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9D324B33;
	Sun, 20 Sep 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944531; cv=none; b=Tc/VmJ029/wWSAl9hC8p7ojUr49tTF/660P2Bge0hu7dCR+p5+PjGLqG+IyI6+MDO15D2qgu5dAcUgALUYCrUb7x7xm0TQwlY4gm0p4z/dzI2V/YmCj8nR8YjCc3i4U8sjMbaL0nmF24goc4r6HulVtoMkCWGOs6BbV9lsizlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944531; c=relaxed/simple;
	bh=ABiT0MDG1NyOKYslxltOxCXn5JkOjtpSXTQhxrEHLy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBEHRhr5OafEYD1MKYHrCsT6erCQ42CqYFH+YPgCXzztJEDPXDFL2b5LRv+4rJBrBh+VxRUkP08mJG2Mg5j1PumhKkDpyryBaU491Pg8lS8yXpQxeH98Nvs4mR7ZQixgQCgf9kFBHfXS3mtSIPUUqEdDHFDC28S3L/mjMXNJOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXdOR/Ik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXdOR/Ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1C71F00893;
	Sun, 20 Sep 2026 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944529;
	bh=XA4FIDvCYy0BQ/rMAtKvbtPxkdDgnG7QQZ5e1dIml+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XXdOR/IknJe33d4peh0RN/kTPQU6vmxouThi1kj9TVw6BOOAFve8zpRcdm0g2tujD
	 hXWPqn8GvkroKOBfeA2mlaLedelOjoS2140AMHSa09IdzRhaR3gmZSE4MC77DCpJ2I
	 TobztOTYRsrw56mcnEwfsbsfjTHKVCb0AYswn5qLv8sRmbkbK9PGSI/8eLFvP0QwBk
	 wkctwHa12OhWsEOwSL5N7f2tgwmBHMsE/+SdBcOeA+wmUkIOPjViwX7i+kDOjg6Bxv
	 dXjmUjUnGksaDJc94ceFj+2ehj21yoidqlOr08Z7GkV/xxO8GTzgHlq/rLaCvveqRq
	 zvn98dVD+rMVQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:14 +0200
Subject: [PATCH v3 08/18] dt-bindings: clock: stericsson,u8500-clks: Allow
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-8-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
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

Allow the DB8500 clock controller node to reference its power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
index 4ebfa5a8d524..75e5e1107ebb 100644
--- a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
+++ b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
@@ -34,6 +34,9 @@ properties:
       - description: PRCC 5 register area
       - description: PRCC 6 register area
 
+  power-domains:
+    maxItems: 1
+
   prcmu-clock:
     description: A subnode with one clock cell for PRCMU (power, reset, control
       management unit) clocks. The cell indicates which PRCMU clock in the

-- 
2.55.0

