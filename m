Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84D3FF8B0;
	Tue, 15 Sep 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508825; cv=none; b=bNO0f/w/GYa10rsPA28+4N2rLRqo/Up/TBPBIBECZxtfYXf4pXe69W8MQVAqaOwriU9dqjv05UTC5KEqYtWJKC7ay6R7XDgqFkPUbtikGk8vaHbgvUfvD9yM9A3ZEua+DS3+dIpuqJVhMNQo3NWVt1qe3qGdYIQYJKuxgpiBMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508825; c=relaxed/simple;
	bh=y6f4ZVvKfYHhF29X/2ddUWrK4GzuwWA/m+ajqT8IjDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrdfMZ1O3EYr1T7nX5a9u/vK/diXYL3GMMKrFm9N/jWd7psZmDmuQ+3iQgVuAo6c+DcqmUbfviX8GdaZCbTp+CMuFVf1/EmdqYltAEUNHxi1xIVrbmUZ8PzUGNxW1/j1Pgco9Ceefm9JV38rJk2k60dlcd3oQzU8J83V5WrlQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj4U7+zc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj4U7+zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB921F000FF;
	Tue, 15 Sep 2026 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789508824;
	bh=nr0DNmrGIpDKNgCM16R6jFePrDWnY899ISA5Mxm4NM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zj4U7+zcBw1TKjTColZQIudRLr94IQyVQ+Zsw2Aush/q30ckDHwi8yaIkz2KVXwKJ
	 JNbDZrl4bNyAysg4OG0OC68ubldlNqYv32k3uCZvralgPUWMTghzIkpbzZBGJ7kMZm
	 s0NMJg2YCPjr/LWDaS1o5moptCohM4dLoyRJjNmObOI+cmmD1ap3eksIWNCJ5qxIXm
	 EAw1ldic8CASyb7wzFfVntmirQsRvVDJXr+VLm/eiKbNN2cE8UJ4IGFEHwVI6u4bcF
	 b8BeYKJzMvFsAiJV6BOOIm7vwck7zLpZxVVTHUsRHctJnj4yj+9Zsnp8VoR3JNlZkg
	 W9aY+m4e2UpVQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 15 Sep 2026 23:46:55 +0200
Subject: [PATCH 2/2] ARM: dts: ux500: Drop AB8505 main charger interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-ab8500-charger-dt-v1-2-10b7b387e6a6@kernel.org>
References: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
In-Reply-To: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The AB8505 interrupt table explicitly omits the five interrupt
sources belonging to the AB8500 main charger. Remove these nonexistent
interrupts from the AB8505 charger node, leaving its nine USB charger
interrupts.

Fixes: bc324d447fba ("ARM: dts: ux500: Add interrupts to charger")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-ab8505.dtsi | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/st/ste-ab8505.dtsi b/arch/arm/boot/dts/st/ste-ab8505.dtsi
index 131c82508e82..f7208e689d09 100644
--- a/arch/arm/boot/dts/st/ste-ab8505.dtsi
+++ b/arch/arm/boot/dts/st/ste-ab8505.dtsi
@@ -138,12 +138,7 @@ ab8500_btemp {
 
 				ab8500_charger {
 					compatible = "stericsson,ab8500-charger";
-					interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
-						     <11 IRQ_TYPE_LEVEL_HIGH>,
-						     <0 IRQ_TYPE_LEVEL_HIGH>,
-						     <107 IRQ_TYPE_LEVEL_HIGH>,
-						     <106 IRQ_TYPE_LEVEL_HIGH>,
-						     <14 IRQ_TYPE_LEVEL_HIGH>,
+					interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
 						     <15 IRQ_TYPE_LEVEL_HIGH>,
 						     <79 IRQ_TYPE_LEVEL_HIGH>,
 						     <105 IRQ_TYPE_LEVEL_HIGH>,
@@ -152,12 +147,7 @@ ab8500_charger {
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

