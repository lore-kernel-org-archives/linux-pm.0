Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB43137C0FB;
	Sun, 20 Sep 2026 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944504; cv=none; b=V/LYA0qKSaSXaQd6t9MZ6lEFxpIiDNiCPSTN0oFuXWZCi8jbdG5PtwL7QcqlzfSuQf2qOc54QXUXee91Sf7tsDl0jzlYnAHI3addap1HkFQZBoUVv7zjJ/KktObhxQW6H3p1LrLm35oqX+siEbMYfnE8R2A/7gzVYUe4Fht0QHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944504; c=relaxed/simple;
	bh=fko1mU32chZXkfY6cWLRTPkfQt1dHmVZ6wJkgzZWVsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0YF/R+vhS5/QGbgeXF0CzaswID7g8HvGO+zcMZRcL6pnvaUetAokYwYv92OGjpsCLjL2TE2aMRdW3lg6NPi7j+5TZ/Hs0C8ycN7hOwJ9RSmHcrbB7ZD887EL/4J6V3MAXsQPsr8lNxl2l8UCJWyr5wn46SZYveJzlNPqq6Zrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj7WbB8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj7WbB8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558701F00898;
	Sun, 20 Sep 2026 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944503;
	bh=GlUeiKqBy40E+344jIcqfAa3hwlFrXZHKHXpJHntRnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Lj7WbB8dmxhxIG6kakpsInEh1xjuyykvGQz9EkXx72XadH/nqBbyRCa55D5WxyZYF
	 6XOsSE98KShPD/FUhZ/Z9V8MtwCAa0xJMaIxyCMYLDptfc1WfWJQsISyG5G6NPeFTd
	 TReMZRaUTMr+Mdn5lQrx86xcpgGdD5uVnC9GjsAkFQnFuWLKk+8aqJQUmRO6GA6kfc
	 nJ/H0jsBe04Ay0mdXSN00KxB2TqrKXNH1XqWqMDA+TA9oJlJa5lR9GAzNolHZb2nSI
	 LGwk4izQp6cT76xxlXNEuKsrUXsOkqn4TTioh97rjKfH+kO1Brtm5Ryi/0c8njF0Uq
	 kFzZHh97RoXLA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:08 +0200
Subject: [PATCH v3 02/18] dt-bindings: arm: ux500: Drop NR_DOMAINS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-2-9352be6b86b1@kernel.org>
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
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

Keep the internal Ux500 PM domain count local to the only driver
that uses it.

Do not expose this implementation detail through the DT binding header.

Assisted-by: LLM
Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/pmdomain/st/ste-ux500-pm-domain.c  | 2 ++
 include/dt-bindings/arm/ux500_pm_domains.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index 6896cb4a7b71..c9129a3b1805 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -17,6 +17,8 @@
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
 
+#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+
 static int pd_power_off(struct generic_pm_domain *domain)
 {
 	/*
diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
index 9bd764f0c9e6..9d94801d8b89 100644
--- a/include/dt-bindings/arm/ux500_pm_domains.h
+++ b/include/dt-bindings/arm/ux500_pm_domains.h
@@ -9,7 +9,5 @@
 
 #define DOMAIN_VAPE		0
 
-/* Number of PM domains. */
-#define NR_DOMAINS		(DOMAIN_VAPE + 1)
 
 #endif

-- 
2.55.0

