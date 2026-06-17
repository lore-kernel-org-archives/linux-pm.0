Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E53CA4AF;
	Wed, 17 Jun 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689726; cv=none; b=KFO676Ka+YN5+TbovMihK9FRBkEFHemORS0GvlKRyxr4xfZCXlmKtTHj2cv4zA+6kOLHLjUNjEsPH90T9VCGR+O5cNISRiPjXImj0vG9E29j85jc0fBwOyAzLXBka6gAPLqRIpTb1r8bLNvH5+2UluenLHa1Iuql6y6oJdPPLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689726; c=relaxed/simple;
	bh=7RJjhSRLrORuQ7QpJYxJUaa7YME47dK6mHpkFjegxhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ttfajmu1qe5Y+Z6e9yy3jzA5Sk9xjIr2YTYzUxiSPcVjXuEjHTeWfU9OQcg2CfqnX4wXZ56a/UT1uT+Qg0gn4Zh1y+KeSdLGYcXckz7LRuOL5Ur8nL/e7yMrUjJRPRLAU1/w+s4C5Mw3ofZQRYRoLmDncIMOKMLcOqdyO5TGPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbPLBs8Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbPLBs8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6755BC4AF0F;
	Wed, 17 Jun 2026 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781689726;
	bh=7RJjhSRLrORuQ7QpJYxJUaa7YME47dK6mHpkFjegxhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gbPLBs8YUPI0ybhirSX0tF0h3sEX/w4iqUWf+HteIvQZsOu7YiIpE7Saw7lx3zfCY
	 N3eGoOFH5Oo3Ia/zOQqs4/bYMb0S6W8ebVqa3X2V4mlWhU20GUgU2kvpOlq5Yod0A5
	 LS7mX0N/vfur4nE4Fw5fNwniDG8zJk8KOcFXnp5c4tuY0/ITD3OmzDulRPjrmCiW0M
	 OH/vWIWKGz710dTwyr4djWWvyV38VTaie6YoR49Cw6ZUiVGtqRGEr/CxSYP7or9yKH
	 OugxJNwqGod+zlxVBaZ52WFAaYLSJP4R6uNCss4n8VF5oTYQe0tOfMrakUQ8WMmA39
	 8q0DVEuMjrNKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C00ECD98F7;
	Wed, 17 Jun 2026 09:48:46 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Wed, 17 Jun 2026 12:48:47 +0300
Subject: [PATCH v2 4/4] ARM: dts: mediatek: mt6323: add EFUSE support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt6323-nvmem-v2-4-4f30e36aa0f4@protonmail.com>
References: <20260617-mt6323-nvmem-v2-0-4f30e36aa0f4@protonmail.com>
In-Reply-To: <20260617-mt6323-nvmem-v2-0-4f30e36aa0f4@protonmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781689724; l=771;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=oXee/GlWmV/sWGn0ruKkyx1IqiA7OAnfJd9/nLpO/3U=;
 b=6uJ+OZO8oqJesmSmMdNsRIguN121Z4j27szzh4KE0Z0Nj6L1qqciqKuThetTt4Kbu75gr84f9
 P91XQBn/A4IA3FmGiNPF9ltC/pq9iIcMVD/PB92MMsCc54p+dAAF6M+
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the devicetree node for the mt6323 efuse.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6323.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
index c230c865116d..807e000a7ff6 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -14,6 +14,10 @@ pmic: mt6323 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		efuse {
+			compatible = "mediatek,mt6323-efuse";
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.54.0


