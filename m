Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420588;
	b=2lYyB4fY5N1YfpZiw4+u+VBHxrN2J8PNTbZO2g+b8N0Axwd0+j9C66r+tSzNxey8E+Zm
	 RPFLymGrxh69aLJLbl+E4IZDSdEwwt3nWAC2ycncZk8Z2mwrR/CzQh4C0wo3cMilzdLub
	 ybpumkzA6QM7+0VRsrzh9zXlhX7lJyGYxmuUpJWxy2e8h+0XDfrsWWCrEiaqmUPrZYlqH
	 Gg+16gJwE9POt4uJ7PWxWmx18RPG3WBxO+1A/Dn4v4+uNbpcA3b1erxA1jTyzIAOeW+n4
	 Wl1L8i6dDLNSoJ6+OcPCUe/Ef/L8AU5v/7aTK98AGMukDvNugILxAz7Q4e+tlVBpdDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420588;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FAqlgXzrPgvz39IQUH9LPoXp2YywYov87eDHsyT3IrA=;
	b=yU49WcCQlpUJk9lo3uGQT1EmJUvJ9yWCQUolPpoYb72FGua53uUFCmiy5dIgJcA8R6Aa
	 PR95nAekDciNooAEkdmwpI6PnjsJvqdakWTnJe+ya04LdNJMnVodM0f7BXyBJWH1k48v8
	 CdJv6Inkt4qPlJbmOVzFYG30frOTcFDFfGH72xVa+tpoIWV0KUtMkqenaAHQX0eYNpdui
	 ywbAPIqXL0HNJdL8t7flK/zkGYBqgdZiiBase1KjENurC7qtuk7ZlcNufnquc7FqodkxR
	 EgD6PH3fqCr9FKpKcbSDqlZCQsiSjkSCR05EDJE6qvhDzfCrT1KeZsdXnwqGY8VlnEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38588606A31E;
	Mon, 23 Nov 2026 07:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C131C1F000D1;
	Mon, 23 Nov 2026 07:56:26 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 08:56:17 +0100
Subject: [PATCH v2 1/2] interconnect: qcom: Consistently enable MSM8916,
 MSM8939 and SDX65
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-b4-qcom-kconfig-unify-interconnect-v2-1-99b282e87d40@oss.qualcomm.com>
References: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
In-Reply-To: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Rx0AZ4Fj+0lgGR2cyWrTgoIUSS3bMe2fz11jfRihIpk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrA/GifzFcs01K/UvhQdPcDFn46WISZ/TAQkdxx
 pEJf+Ru0MeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawPxogAKCRDBN2bmhouD
 1/2sD/4k4aQvVwUUN1G/+iyGlpqfTYvXj0iNPzdguGTgK59TdxlaUUifLhJ4CcZyEuA0m0zCD7X
 FCDcgUvGXbdmjKFvXKZpqK1uc9k8MZBO88IJuxecJP5ejp02vdkcAhT/MzGs1HKsILrdrbPuIUa
 V0V8xOG5PIGpzJZaZnTeOZ1owovdeMTY+wmu0ZAfm3wlrQJZ2lljzSG/2nr6stZxkY0qL3zioji
 PXsrWIg3SmwXtSsh8h1X7Zkwh7Q1kwggv4L7v262Hqj66fOcakY/m4cci/GA2dYy1CvSHeMVoa9
 j2F7lEBVqBYG7X52yVMwgOHa0tp4Rfq5Sa0XKXQaIHdTGwKBSb4kEAcn3qNdwiIzDQNOb0U0fCt
 Hh3u/OfitSO6/FtQiapzGBq2H/quiilF5fK/ZM36Vn/6Q4mlsIK0eU0qapCAzRPu6g01oqjpbO0
 OQHpBTxXPaW1pfGCvn2oMSlVV4EoAwFU82KQDaPeb43W/W0ed02CO54RKoVMCgxPwZqrQvtkvaG
 BcUy/iVMqOI4GYqK6jsL1qC6YjUGFiQsANBJsioFtgw6FiW1gvb70u6pYwwm8d0PRKL4mT83ZaC
 3gegBWToykeB4uV4HNpQcz3kmol+fFSfoKnrUk/hYLi6kT+52tk5JowhV17aCsAorQQgZGgqCVR
 DKJdI+NpqXvuNVQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Critical drivers for MSM8916, MSM8939 and SDX65, like clock and pin
controllers, are already enabled by default (MSM8916 for both ARM and
ARM64), so should be the interconnect drivers as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 7f3a977e8f10..110789a2d232 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -92,7 +92,7 @@ config INTERCONNECT_QCOM_MSM8916
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM if ARM64
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
 	  platforms.
@@ -111,6 +111,7 @@ config INTERCONNECT_QCOM_MSM8939
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8939-based
 	  platforms.
@@ -367,6 +368,7 @@ config INTERCONNECT_QCOM_SDX65
 	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx65-based
 	  platforms.

-- 
2.53.0

