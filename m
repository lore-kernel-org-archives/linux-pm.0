Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE3370D6E;
	Sun, 20 Sep 2026 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944509; cv=none; b=MJbhfVbBhGbQ/Ze5tMqT/3toTm0sc3fc/mhfEAgvEuczwXeaPvTnFHBIQrWhophRQN2Q0s2QzzHTvEjjNtaDTuRZrTurKdCXQa+pmBQUUxiqmMD/QhR10lhlhMoXfTdIRYT/lCAgJfWjdSFXfHThAVKTf5fY2MpkiaRsdMmps4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944509; c=relaxed/simple;
	bh=9s6+go964v+F7zQjZYUB7oxVX1+N07SWkvoqIRb0A4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fssP8LghNZxgXsecomoytJZs5CGp1ITFuo2yiS1l9QFJEEkP5EzWt7RzqYWSFwSANvPJ0eg0q+Pr5y4EUSrgdDZO0+eVtDp85I4eoCZqdcN+Uxip2auAK4Tfybc622EV76cm3HyooC8oC+6dTSSyc3qF768YAiyRX+NzG2Gk87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SntqHsBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SntqHsBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD261F000FF;
	Sun, 20 Sep 2026 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944508;
	bh=qYOnwGjU9FvWidAAprn3NnZ89m+Pt/3YnDA4zAbg1Tk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SntqHsBIDlBzy6c6nUvfeBGaHWTzuEH3BZj0lSx1cipCgIKWOkqS6Q6wcVqUv8hff
	 8GOX/DOyVFj5QwcZ67mOhARf5CjbjbcmD0rA4wOcvl0Q0NzIXGaleNWCX6Icp5H8Hp
	 6iLdHbgSZXC1u5FGhjOYFv1RJzTQKcOoVEdUJlpzw+kU55BbB+zko7WMQ0iCe0Hyzh
	 i5tpPMW8v83kZUr2qCe94Av52VM9ocLC/uNrSKqNt9Sld3BMtnljz7n58TqpM/MmjO
	 fidtbujq/yrPg9yJJRSbAEHJQzZk8uEmv+4BN4PxmAsXRKiCNmNsQWrMGjZYbX4R7A
	 p4I1w9U7JnEOg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:09 +0200
Subject: [PATCH v3 03/18] dt-bindings: arm: Add the actual power domains on
 U8500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-3-9352be6b86b1@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

This file has been left in an unfinished state just defining
the root power domain for the U8500 SoC. Fix it up by adding
the actual existing power domains in this SoC.

The PRCMU code and old regulator driver is mentioning some
*_RET domains, this means "retention" and is a state in the
domain and not a domain of its own.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 include/dt-bindings/arm/ux500_pm_domains.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
index 9d94801d8b89..f7a9fc101fb2 100644
--- a/include/dt-bindings/arm/ux500_pm_domains.h
+++ b/include/dt-bindings/arm/ux500_pm_domains.h
@@ -8,6 +8,21 @@
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
 
 
 #endif

-- 
2.55.0

