Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386E3F54BD;
	Fri,  9 Oct 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548128; cv=none; b=qNRHy4LGfwRQgh7kB5XGOV1sBLWEZC/7GDnyqFBP5CUc9TOdA3AEwMIUFjQSLhZD0gt1LkGyWlwvOI8z6NA8gMCiMlQL8OFqWBMvYu+73/MXbEeg4E+hiQuKgPYWvzhVg6kpK28xTHSvpGY08J0uMXOkIDxRwG4aOTSQKbq5AWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548128; c=relaxed/simple;
	bh=9s6+go964v+F7zQjZYUB7oxVX1+N07SWkvoqIRb0A4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXZcl7+1utOXrbEaui9zwUjPaRM4STS5p1RSRgjvnRpXoZuxd0QdWGVIt11DDApbjkxSC+c982PsKSo99P6zgrsDUuvd5mKdKUT/YXgQ49deE+o9oov+mILXf6IBsDePNq5qZ2EIOoxEZncYfQ6aXk1naNWGjqwpal4VkGNq1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvP1gpYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvP1gpYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A281F0089C;
	Fri,  9 Oct 2026 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548116;
	bh=qYOnwGjU9FvWidAAprn3NnZ89m+Pt/3YnDA4zAbg1Tk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WvP1gpYeIki1iYEbjU6ZR3nlyFVirOe7SqIq5+qI4bBLob4GIv55ZFGf1RoROqW2Z
	 wTliFrXrBuKvO9FbYsu9ptbE/PqESi1st9zxAWgcoKslhid8SirghaC1+UhxEUx4Vg
	 qw1XGbpEAaGUqTwIfwB4tLYCR0Jtc4wPSXvtCWb+3IH46rYO7gmt3Cl6PKz42qqics
	 v7XqGUYOBuQfMy/rPNjPdF7Pudn0m0ACg2b8vDQG263Jk8geJW6JH1crEQlp0Z8jMk
	 8bEUJAxld6ehXEIeU+3NLuv5hQcMjrOt/AG9bmbO/UFxLHV+siRghzH8/Zjsfrqyoz
	 3mBUtq40ZLRaA==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 09 Oct 2026 14:15:06 +0200
Subject: [PATCH 3/3] dt-bindings: arm: Add the actual power domains on
 U8500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-3-5eb1b90bc35e@kernel.org>
References: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
In-Reply-To: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, 
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

