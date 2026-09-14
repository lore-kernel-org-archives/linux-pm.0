Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6C403E88;
	Mon, 14 Sep 2026 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386891; cv=none; b=CAkLopYr4JiT11GPml7PJGRZFwJFQ+YkjFAjVjcHGmfmp1jowtJZdh8/Q/N5N3Qz5pUv+LPZ4w5ukZgdJo27hUpa8QdIl1O8phcbaKcsgZJ9iOQCJe0h7EewBXHKtpXng58nudC2ADlJPcrNbne2FuuyynCYSoXIQYYJpk8Mi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386891; c=relaxed/simple;
	bh=zvzPPB8W4tqTIW5eT1Tyyyl4tDJItjuM7VwAh+epX7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8+fZfcz3uriiHHGascxVYGHJwPXmnGi42WR1yaJ/XDchZc+b8aOmnzcwSYV9ic4YKyTdZlKEh7PzujhoU9OEa53JCpMS1lVA/YI5x5/ISAstyqlbLYuPAX8CITbxIz+mwxlcpbx3B8IIQQqPkNAJ1Ns94W0GuIyLJMUSqcXdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP0ELdhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP0ELdhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A781F00893;
	Mon, 14 Sep 2026 11:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386889;
	bh=KOCsjRkBypCPyH2YlnwYvNyuwyphb2mRtG01Ff9alSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LP0ELdhJykW6OYeigGpKRCelEZ1nEfq9pwY2OFrFr93/JfWPot9NNyFZ7JW8bvubj
	 hmPHk9Mu+GJudg1+6Ycev3LPViRMHEYNiab2QvXdGZL8U3KSB1vRR1yFpVcE5icxRZ
	 qMsdwx3hMK72qv0nD79OO7ZL1rM2pRWpQjti9DxS9KttTrZ9CRDAhXzYkGE3ckSrAp
	 XMCRVV9ehrygpGMfB/p9/Az+bTsP7iyHUOJ6JCctAtwlF+xtloPgpr9IJ8aG/PKnw3
	 wzP7STjlzsQmameSbll1H6Aks0uZYvBrUeUuZu0R7iohjd4ZdyglPD+x+RT+bvFL1V
	 mKjE/5LlHPxHQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:31 +0200
Subject: [PATCH v2 03/20] dt-bindings: arm: Add the actual power domains on
 U8500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-3-9d0c17e1f816@kernel.org>
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

This file has been left in an unfinished state just defining
the root power domain for the U8500 SoC. Fix it up by adding
the actual existing power domains in this SoC.

The PRCMU code and old regulator driver is mentioning some
*_RET domains, this means "retention" and is a state in the
domain and not a domain of its own.

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

