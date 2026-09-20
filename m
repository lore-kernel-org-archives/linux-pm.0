Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08F486414;
	Sun, 20 Sep 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944535; cv=none; b=FwgKY3g0rA+UzsO8KgBD1LJQTdlsabI4WCCgyIm0mX4iIojpKeCTX/HQw+hCIUDUGDdQvPTOR6wmSlydyId18Db2blB/5ZT1276wyGp4r8JIr2e9y2NLCZ2sPf4ZMpa0YgXPq+8pv8jRsjMOFJazh48QeO/i3SIXvLnzzWaabQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944535; c=relaxed/simple;
	bh=LTleXBcJ62WJZLOwTXgzJaq6IDV9v8NNvIAqcXgTRIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4GQ8hqHDPcn+u+hUHTFAJxgoJuOBx7GXdzZ9Ma3t6sM9X7Q9LVRdwDjXLUgtN/dIZ7LyCgiGotmVdE/s53dL/AQ0zFLBgjzBapQEAwAUryHJiF3Ac9rE3dD3POzta0Mq2QtBxvCyLnrQCFieOHD30tZTgM8DdzPhiNuKWnXQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqT6NJk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqT6NJk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146BB1F00898;
	Sun, 20 Sep 2026 22:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944533;
	bh=2lEjcT7B6RrB8qhxzgkUJFkPdx9c1jv0+Xl7DW4HptY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kqT6NJk6jifwbEvaz3n1mfwmMn2iP5ohN3vlpa/NC/9YL9/HGRGojrHjKRFOyJqly
	 ihdQVg6YTdzTVNquR5Jaz+jB6SLQhIM4Uu4Bw8Zj4Ybm3ud7CboriCBVqj1CdRg9f4
	 +exucgWF9gQ1C5S/7j4VAII+vBFVSXWsSSjaxGrlVanCujs554D93pNNRNW0W7Ne2p
	 H/2A4ECDXsET/zwnSehUwN0xkyHRJ5bxp9ZjXkhU4r60Kz2ef4PA+yqqOwLakLPhHg
	 WLJsPcqRfwQ6PEquUOwUVRCHHF3k1EC18I72AP5fOg6XaskXk1zpRWMNdHGmQEthjz
	 B9tlP5I2YkBkQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:15 +0200
Subject: [PATCH v3 09/18] dt-bindings: timer: arm,twd-timer: Allow power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-9-9352be6b86b1@kernel.org>
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

Allow TWD timer nodes to reference their power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/timer/arm,twd-timer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
index eb1127352c7b..716d5f2d4eac 100644
--- a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
@@ -33,6 +33,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   always-on:
     description:
       If present, the timer is powered through an always-on power domain,

-- 
2.55.0

