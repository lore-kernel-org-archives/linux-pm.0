Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420592;
	b=gfAUjksH0TgwQc4K/0U+ktGVxyp27+WHNcZ6Dd5AvwwmwAcL3KJstDGazsDjI5d2Ubpw
	 YfNiQ3kWqyjzPsDEKl/Q7q5KCZNoOETgoYj68X/QmFGZbBIwFReNS3NLUa2PN2vvOW1Ru
	 Mt9dISjSbaFEVs+cHTsW9p1GBLt2e194QrVYSv1obIi8oplZet53chE2C0wc9ioigW/1x
	 OYwPxhI3gCV4euxK17WizpqdmD8sa/ahS1THR8E2BH6+sEB4gXhVm45++nsfdXsHKgSKC
	 D2sV75VuMk4PFhQ16ubJvciYjwvhdsyQ2jsD20q4tmgnyx8kWqbbhURP/JXkXyFOYRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420592;
	h=Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YwcFjE1k9moxF6Q32aBz5yG0oYU3QPreRKU1K6+pGvs=;
	b=lze1ox7Aa+dbn/rHehYX3+ToSvQ6xt1MMDvu3oUoQeXcKrXyXgbNbTUrsMh22Hlq8n7A
	 EFJQ0lMwdhPGezp7hM7QQR6uUx/p4VT8IBS3Cqdly1iF8IzkDNrUToNLJ75RNY8fi1DIb
	 a2CzFwQq5XtBniSCY4iiSyaol8uLDjyOJVMU8H+BWve5RzQMRDRrsP+CpRjB/EE1dzJ1/
	 ELVB5rBBZgGevxkkU/RrdH3ZCChgEVzG5J1UtKQBPASXpXBS1/6ermdlGaAczh1FxLLwf
	 9kKCX+JgTTf4nR7QISEZ4V9T/sPBj+jddu1LKof0cB3x6SXRVuMqTDGQZWGIE2zo6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70C606A31A;
	Mon, 23 Nov 2026 07:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A967A1F000D3;
	Mon, 23 Nov 2026 07:56:30 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 08:56:18 +0100
Subject: [PATCH v2 2/2] interconnect: qcom: Consistently handle MSM8953,
 MSM8976 and others
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
Message-Id: <20261123-b4-qcom-kconfig-unify-interconnect-v2-2-99b282e87d40@oss.qualcomm.com>
References: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
In-Reply-To: <20261123-b4-qcom-kconfig-unify-interconnect-v2-0-99b282e87d40@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=m1rQlv8IYLPgUrIvH9L8qfwHfRylrlTfmjd/qzMI8aM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBrA/GjfldzdIL9/BJLYT8lgcLeNPjOzdICVi8Ki
 Ek9TJXwUWqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCawPxowAKCRDBN2bmhouD
 16B7EACOapK0WHWm7mLpFYZQg6oYgE7bwCaaKQTxn6t951Xj/yEL5vofICtm1PTLtBNfcGMJWnt
 fBhrK6wry2rVoz9u1Nnw1vuGv4g5BaY3expBlXpKw4GmqXvvX3Yn14p5OfffcJWQtexymOvLUYc
 8AWmqCeecKwjQS8oFU62wDPyB+0ZW2d2NFNgYtZdwcvLkzth64j3doUjVwYcSSEcSs8DoU+ARSD
 7xsPn3+AamxdDKAbAqgvazXuLOO6siFzt350sBv4Fmr7+y2GBqBoK+o1fEJl0/eqvQzOAXFwy7Q
 wEoKWV1nBwRMUczyiuoZMJ+Z51RVIi8B82Y7XPRt6MwRo6zF87jqG2fUnE/3uPUhliYOSMY3Vss
 F3blOWOV866NPuDcMyAlkuKZVh7MD43N/RRurIi++LJBwHaV3LhB5y87pHXxA4sjY3qjkaA8E5r
 Zn21IowBjkUx9++i0TXIPPnP8Reye9In3KDwesyGCVdHKNKxtBrk31VMIEGUrJx/ZVfkrhNypQe
 v/0fCNCnC/8P4KolzFDU+S2sXqBMB0A0GCtiA0qukn2jV8oJYWAu9tfQPymvFw8Cfi8BAej6jT6
 mwga4i+/ZO+w4jeWEbUfSoTokBZa+7h4N84vGA4jzzswrdpqJiyNawzbRmFb5ZwqgKWBj1M1wxJ
 C1bTTeyV6X0KFiA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Other critical drivers, like clock and pin controllers, for Qualcomm
MSM8953, MSM8976, QCS404 and SDX75 are allowed for 32-bit ARM builds, so
interconnect drivers should follow.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 110789a2d232..d4c12d89b2e6 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -120,9 +120,8 @@ config INTERCONNECT_QCOM_MSM8953
 	tristate "Qualcomm MSM8953 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8953-based
 	  platforms.
@@ -142,8 +141,8 @@ config INTERCONNECT_QCOM_MSM8976
 	tristate "Qualcomm MSM8976 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8976-based
 	  platforms.
@@ -196,9 +195,8 @@ config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
-	default ARCH_QCOM
+	default y if ARCH_QCOM && ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
@@ -376,10 +374,9 @@ config INTERCONNECT_QCOM_SDX65
 config INTERCONNECT_QCOM_SDX75
 	tristate "Qualcomm SDX75 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
-	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
-	default ARCH_QCOM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx75-based
 	  platforms.

-- 
2.53.0

