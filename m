Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FC3F5BFC;
	Mon, 14 Sep 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386886; cv=none; b=rr+zzCRigeeS5fj4xGFd3agbAVx0+xhjFf9HXJOtN87LtddIuOHW4SjYC8KjFDjU6aeIDLn4MVC5RHCFjjpo4RzI3IIk7bnBtiVLhaZu4N4Ay48cAkyvnhFxKClnpGCFKU743AHyfNuAduiax4q1ytdYqTMTiIPBIduGX7cSehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386886; c=relaxed/simple;
	bh=IL9TQZOQyeB7QJLrU/ktOvWidXLQK0813KYcLkBbj+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNWkcXxg/s9OKaY9+7bL5zmGQ5/iIlNqmIE5p5do8ukqAGWRjt1TqE2d1ctVl5s6UlwOFtC3eiDS45CJJ7IwPSKMd3gQONZJbMiFXYhftfTR7wivZsUta9ag0MZl4qLS37KftAduyIAYYpgTcpnPBQJ3TgjF/gLL/kgnfJ3ugB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuRSVoGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuRSVoGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F0C1F000FF;
	Mon, 14 Sep 2026 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386885;
	bh=0WQR24aA1+zpILZ24E2nmmO9FJh3/tkJD7MuOSXMJkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BuRSVoGTDJ5b6ZWeoUYUn/0++Uuw4qeo8slDYh69a9IWsCFCAou4v3xMJFeegq0v3
	 tTzetCMiDtySzL6cZnzaJSXvZXx82jLxblY/Uc/zkeRXSoBrYFtlVvbSsHmF3klHsn
	 +MiAajbLsVRYi4a4qoNEZsbyjc9TVwdsNrlB5MVASKYfow6LsGX2Dtzls9qPvgvTL/
	 0Z5PfwBuTvQUMbXCuOqcYszuYqwF83K6MemtvrcN/KZvxK8x7NCZklknEKKeTO4YbR
	 RR2Lva4n5YJQ++nqoTJSBKcNqUsKLN+L5YTB2rjsRy3bhd88ic2/bFdoPzXS5UMUWk
	 vLYOikbQd2k1g==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:30 +0200
Subject: [PATCH v2 02/20] dt-bindings: arm: ux500: Drop NR_DOMAINS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-2-9d0c17e1f816@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3

Keep the internal Ux500 PM domain count local to the only driver
that uses it.

Do not expose this implementation detail through the DT binding header.

Assisted-by: LLM
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/20260623-just-grinning-peccary-d661ca@quoll/
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

