Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B833E95A0;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=SbWs/fv3y8HFBFl/pSkZyjZdr5zaQsw42righ0EeEmHUEP+tpN1HwUFECrZor60mG0PnESfj/hIh+/HcoSAiJQzrpZNthbYWcss47acFHOHvX7E5q06eOHjbuYWK9Hc4gkWDJqTNjp1K8YRFhCZLb0CFIN1B7icgyJ5ETA67qaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=7Utam/boR1PWgSQoP1yDij+IYi+ZEoWdQq6cZLulu/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7L5uaP8rIzcB3MGjCcSzy4YsvVYYc5ZWOkfVgkCmjcBL8K7eyPrBVbiRQ39WCE4QJnncHFax4u1M+/PNxn6pN2t/LXGAY5Va+BOR34qRfv+EdFkwwUnpwzRxhYZDG/FmyEn+8Bcv6c4YR5eDYM4QUW7b/fw6VGBO11D1Ul7dRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djskdR+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djskdR+k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41F15C2BCFB;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919099;
	bh=7Utam/boR1PWgSQoP1yDij+IYi+ZEoWdQq6cZLulu/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=djskdR+kkHYOdurNWMbYbWTcYiLvOCdZy6W+eY9cUq1/jnk4RMCjFQQXhvUKNOUcS
	 kbN/uXZdsJ9sOxzTa0HG/LaGvvukVOJQ8mVgSQSPd32/dIAoyp/gqql69V45iOTpDq
	 HvNm93/EFwSTC2InyfFAui1a2R0t0IdgzQ3iIifkWQNTXpSTs+hRTFzU+b2ORFFkC6
	 VgQs+fSbusaYb1km5ndMLQlqCMHpjIfrqxEGNFW955MUpDrZdjYtgMd8wTfZMokAwb
	 vd8DObyVXGPCEB6/xbLUZE30ePWu3vGJF2wCdG4Cd2R85Hv39MnSILRggE34w5lyvq
	 kyyRV9ShQ1ngw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D06CD342F;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:25:03 +0300
Subject: [PATCH 11/13] ARM: dts: mediatek: mt6323: add support for EFUSE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-11-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=819;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=D++I3Bv55Tj53B0+HYj0FqRkAmuZ8JRO4SRqrQ1v3kE=;
 b=R3R3H7pkJl3SJUsgkp3G8bZc23LQ5YY0fHmstJk6moZH4EJsDmbtoGRjL08m4XlCYoOWSwz31
 FlLs6lfwy17D4sKpkub4ktmaXHGzhwXdwRg7E6rcWqbUXkR1+orSxOX
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the efuse node for the mt6323 efuse.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6323.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
index c070f4b0936c..3fe6a5e35e70 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -19,6 +19,12 @@ mt6323_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
+		mt6323_efuse: efuse {
+			compatible = "mediatek,mt6323-efuse";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.53.0


