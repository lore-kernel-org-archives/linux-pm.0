Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147D1A8F7B;
	Thu, 18 Jun 2026 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758863; cv=none; b=PGAd+MKBVrJo4SRHCEHuh/vyAqoLMWtMFYwn5UQQdCjtvVOMs23rtbbUuVjPS03o+h1J3AlHbR5nOS1y3bBacqKXN7ZKFg3PEtl/bH+UPlVRN3+ZG2q/pAaiKx3o/bxQSFrsdDM+u16HPKiO0uhoHz2tbM06LTiEh/fLFAyFgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758863; c=relaxed/simple;
	bh=zqv/gIUmQPc5qXE1LapdE/S0PfiaAgSHzgt8E9zBhgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUhvvEzxi+prXt35YjDmRpG+ZF2+ATuYUYsQ7GngxVpBaG18Oxkbilt0duDG2N7kCQbLjuIbni/ssu81rF034YZMLutz53CjtJHyL62i0AvEbSHblZ8xbc0jSQkPY2dwp3n7ELdLzXB5tZTYm72Qcq80Zhr18rEZcJDhtm2BCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia84VKjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia84VKjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F3F1F000E9;
	Thu, 18 Jun 2026 05:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758861;
	bh=02Y1pCsb2IfbXGeGoPoXW5OadRTKcmJFhbHDQeWin5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ia84VKjk/kDlkHMweHZPDCi200y3A+c0Wm9ojt2P5+3R4wj3M5vYOck22KHQ4sDUD
	 WeMCrLODF3vmTkvY2Ve9j6rkpdW19ldLQfRf0B1TZO83de9keFKX45j7msdzi8/Uqk
	 14PM5ZeQKccVG3NlOWAQF5tQtp3YQrWVNP+fjlUATBoPQGwHyC4Lkml1rUUvKi+4Ea
	 hVLBHB/fFElJtSyXnypa9d4F7eF+tb/o7MnGv5JDMq8bnSBYxmzRPIAKGRO4gcYfw3
	 6qu8+Jb+SE9X8iUsXVmuebvER0N2Ynn+D6xVUhU08hm/8fZPv9CSWK9R3Jc0AQHpCo
	 2R4Yt4bPHKKCA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:48 +0200
Subject: [PATCH 02/11] dt-bindings: Add the actual power domains on U8500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-2-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This file has been left in an unfinished state just defining
the root power domain for the U8500 SoC. Fix it up by adding
the actual existing power domains in this SoC.

The PRCMU code and old regulator driver is mentioning some
*_RET domains, this means "retention" and is a state in the
domain and not a domain of its own.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/dt-bindings/arm/ux500_pm_domains.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
index 9bd764f0c9e6..1c168e59ac90 100644
--- a/include/dt-bindings/arm/ux500_pm_domains.h
+++ b/include/dt-bindings/arm/ux500_pm_domains.h
@@ -8,8 +8,23 @@
 #define _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
 
 #define DOMAIN_VAPE		0
+#define DOMAIN_VARM		1
+#define DOMAIN_VMODEM		2
+#define DOMAIN_VPLL		3
+#define DOMAIN_VSMPS1		4
+#define DOMAIN_VSMPS2		5
+#define DOMAIN_VSMPS3		6
+#define DOMAIN_VRF1		7
+#define DOMAIN_SVA_MMDSP	8
+#define DOMAIN_SVA_PIPE		9
+#define DOMAIN_SIA_MMDSP	10
+#define DOMAIN_SIA_PIPE		11
+#define DOMAIN_SGA		12
+#define DOMAIN_B2R2_MCDE	13
+#define DOMAIN_ESRAM_12		14
+#define DOMAIN_ESRAM_34		15
 
 /* Number of PM domains. */
-#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+#define NR_DOMAINS		(DOMAIN_ESRAM_34 + 1)
 
 #endif

-- 
2.54.0

