Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F451A15F;
	Fri, 18 Sep 2026 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750621; cv=none; b=SsNp0OL3qemN59B6neTSaiDQa4bCeV8NjqsRL3Ei9MNnn8Y3eKtQoLyilDQF+sqVDFczbC37uINMEFaSNbHCmYl9aHEspYpPy3f2uXV9SePU4PLNoYQsSuubZz6GsOwoiscQ2D+waqMXH9PqHzPTp8i2qddwzO6+ltJC+/r9mwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750621; c=relaxed/simple;
	bh=fnQ2v+X/Wt2e+j41qAgCtT9DkGeoSVNo+TuWZtrtmTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsGo0aEzckbPx6g9MQC0MzKSoh3fGpQWPqf9wCorwPWtHBpaS4aiCJJhN4OKZYnNu5gBRv15rK9wPE7WNLfsH0BnwcmUPumffpuPQmeY2kRcONBhqmmphBDuON3Ik7T5j46oC3RfUHBTzjNySlN8e3+YH5wXH4M7gCVVkvTpNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3eTj1ed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3eTj1ed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800951F00898;
	Fri, 18 Sep 2026 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789750619;
	bh=VnodSeJ+BTPmRT46DnqqdJcHvkEHEr1Na5mzFLJc5CU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d3eTj1edbQXSQgRW3v5SFAgv6Sj8zCCOU7FlK8vkFr2HWYd6jposyZJ7fe7EONjAW
	 xY3XZBBQYI4+NMYdChbxjykKtpVqqlT2LgWD5tq1RoALnSXBnhykJ6cxRDRxgZ+00+
	 AV9OiBCZ+U5FnJn6Ant8mg+ItN0muSItAzlnilbznSU0D44voNS3x+5V0SjNDSq6LW
	 zpyjH3S5jNO0L4SjsF61PqvQaFRn9mB23KNHNHB23CKhvTTqS8BcwNdle+w1CMxhHE
	 x8RQZp8qWP1NeHwL+JGyQ4zRL/+gwLSx5/Gz48eC7oh7D6i70Z8dryf4TGMQ+VOII5
	 EJBBIKEkwWRzw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 18:56:52 +0200
Subject: [PATCH v2 2/2] ARM: dts: ux500: Use AB8505 charger compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ab8500-charger-dt-v2-2-5f17c332a2a7@kernel.org>
References: <20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org>
In-Reply-To: <20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org>
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

