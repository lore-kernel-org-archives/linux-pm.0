Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652D43F0BB;
	Fri,  9 Oct 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548126; cv=none; b=XpS9dzlRJdq1eCUDHl+xMOIji5sbBzpW94XlD3nc8BrcV1XHQfTkOANfadAuHFA1U2lk02x6RxtBWD9RZYB0zx745shTHCHnQiqC70TQd3KfJDmPZBzizs9yurbndqGac0TQvgvLGxSn3Tv/QPHX20TJrcmLn5Ehd14qSEpVazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548126; c=relaxed/simple;
	bh=fko1mU32chZXkfY6cWLRTPkfQt1dHmVZ6wJkgzZWVsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYtfkPp4utdknSKNaXVsqx5NtgTi34c+nsyREo4JEwiAnzjTij5dJiZdPBb3nmykxXZHU1JdVLc1R84Szc0AvHHbOjt5QU4Yu25REVuF4SdHiXYoi5cBfuXmiQaXj1OueiDvj+RNkQtlIciM8s5Wzh0ZKeuHwkKk3Z2UTEBcQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzYea1c+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzYea1c+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8D1F00899;
	Fri,  9 Oct 2026 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548113;
	bh=GlUeiKqBy40E+344jIcqfAa3hwlFrXZHKHXpJHntRnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IzYea1c+vd7AR8I9hts2rBTUcBfgjZSNZHhUzI1Gtycq5fREKkPA90uNR1RD/+7js
	 3Laq6Nxy64/TkX5+77qM/2/K7NiIVBKqsaF3l7y2OR/zl1K02Ui4P24FG+e/zyJ9Ze
	 WHJxnjEyxc58fZJZ5bxQhFKf9hT0b/8tQsZxNLAEeNl7yNAUmhxeUkkBS52PxUEWwj
	 SGzMF2FN4Kie1zPocFXJSiP+KgWE1vfCzC/acVGzM96yK+azZTPcBiI+ygeWYRN+nl
	 /kIY6/Zyy1cWZIkQqRtxsPMaXXRMJuxwY/BgRz1LrXy5OaptvSrdXTaAPxBYlqKpqn
	 dN3OK1tSnkiRA==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 09 Oct 2026 14:15:05 +0200
Subject: [PATCH 2/3] dt-bindings: arm: ux500: Drop NR_DOMAINS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-2-5eb1b90bc35e@kernel.org>
References: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
In-Reply-To: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
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

