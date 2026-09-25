Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998947884F;
	Fri, 25 Sep 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326773; cv=none; b=i2wiT+rFi9lmXaW8MiQso3GtdkWazn8QNHEMsPy1d/hP9Lz2E6sj0xgsb5gM98idgsV9NhrtdKxpflhUCQ3tpZ0fNADljEZRFak3ijW88SbVRe5AhVluZQKE8qG8PWz8WR914XzlswUCsCR80NB1vMMHpy253aVVleITfELonFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326773; c=relaxed/simple;
	bh=fnQ2v+X/Wt2e+j41qAgCtT9DkGeoSVNo+TuWZtrtmTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VU8GFnFOILeTsIH24Rg0reuIQl22ca7hFBS0lpEtU/nKC2T6RVRkMwkDkihbj1rDzelCB2TyvnLqKypDkOadV+hIbKcvIeE5E1X+YHHSw2g3oArDqSwmJBEaUV8nT4KWNuA2qBOkjoIU2+FnzIp9CdLXqPOBPjhoyYxN39npqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDaP33Ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDaP33Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4453D1F000FF;
	Fri, 25 Sep 2026 08:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326771;
	bh=VnodSeJ+BTPmRT46DnqqdJcHvkEHEr1Na5mzFLJc5CU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fDaP33OuMom0H3hnuNmzwnZI5IPt/JAaNtIt3UMW5A2G5x0I5sgplLdC6HxWFqsfy
	 knRkcF6SpmXUIpxbI8ECAz6EGDRPVGc2c/DLVgvAk6Yni47Y8y3UMICY8qDT488vzE
	 kqEV8rkp7Y8wAwCx2wQnfUO2W92LONsmKdFZNGVYL7+lyRlBe5Pc6XmcGBCnTUv+na
	 t4cF79t8lAQV+sJcqeo+nTF9CXSNGg2OzBRHVeE6NG2bR+QEMb2eVma69DbkfTS/nf
	 jOovUsbmVQNlDRCrIbqzwJfmpQDihEQfh769mVdNVXaQs9QAevyNsZAvr5HHHHrBTD
	 pfI/0F5R86Flw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 25 Sep 2026 10:59:25 +0200
Subject: [PATCH v3 2/2] ARM: dts: ux500: Use AB8505 charger compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ab8500-charger-dt-v3-2-f80b8d295e2d@kernel.org>
References: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
In-Reply-To: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Identify the AB8505 charger using its variant-specific compatible and
retain the AB8500 compatible as a fallback for the existing driver. This
selects the AB8505 interrupt constraints from the binding.

The AB8505 interrupt table explicitly omits the five interrupt sources
belonging to the AB8500 main charger. Remove these nonexistent interrupts
from the AB8505 charger node, leaving its nine USB charger interrupts.

Fixes: bc324d447fba ("ARM: dts: ux500: Add interrupts to charger")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-ab8505.dtsi | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-ab8505.dtsi b/arch/arm/boot/dts/st/ste-ab8505.dtsi
index 131c82508e82..4c9a8418f225 100644
--- a/arch/arm/boot/dts/st/ste-ab8505.dtsi
+++ b/arch/arm/boot/dts/st/ste-ab8505.dtsi
@@ -137,13 +137,9 @@ ab8500_btemp {
 				};
 
 				ab8500_charger {
-					compatible = "stericsson,ab8500-charger";
-					interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
-						     <11 IRQ_TYPE_LEVEL_HIGH>,
-						     <0 IRQ_TYPE_LEVEL_HIGH>,
-						     <107 IRQ_TYPE_LEVEL_HIGH>,
-						     <106 IRQ_TYPE_LEVEL_HIGH>,
-						     <14 IRQ_TYPE_LEVEL_HIGH>,
+					compatible = "stericsson,ab8505-charger",
+						     "stericsson,ab8500-charger";
+					interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
 						     <15 IRQ_TYPE_LEVEL_HIGH>,
 						     <79 IRQ_TYPE_LEVEL_HIGH>,
 						     <105 IRQ_TYPE_LEVEL_HIGH>,
@@ -152,12 +148,7 @@ ab8500_charger {
 						     <22 IRQ_TYPE_LEVEL_HIGH>,
 						     <21 IRQ_TYPE_LEVEL_HIGH>,
 						     <16 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "MAIN_CH_UNPLUG_DET",
-							  "MAIN_CHARGE_PLUG_DET",
-							  "MAIN_EXT_CH_NOT_OK",
-							  "MAIN_CH_TH_PROT_R",
-							  "MAIN_CH_TH_PROT_F",
-							  "VBUS_DET_F",
+					interrupt-names = "VBUS_DET_F",
 							  "VBUS_DET_R",
 							  "USB_LINK_STATUS",
 							  "USB_CH_TH_PROT_R",

-- 
2.55.0

