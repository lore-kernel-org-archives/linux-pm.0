Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0435C6BE;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977029; cv=none; b=LvB4IQ+aBZ3JYLHdDoDYU3RRKH/P/X/uiQAzPKjPPYdnoSCpBa4S/mOt/3JQnQ3A0f272iMc+kNgO9trk1EUjnC74ggl8q7XMnmw6NjyAu/o3GItw3rfXc0I+K14o1QtNOy1SQAK1GGB6EMOdnro6QgJ347uAvoiYlY44fPZMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977029; c=relaxed/simple;
	bh=HmXNcA1YAnZLx3RPO+XZdE0dPg1yJCRKOMe6ArOea/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAtzOk5mnIcrooAimok5BqsiJhULe7aCtItwnG19OHClhRO2jKSNkhx0qR8C8iEXD/kn5os2QsSVhdI1bXRU4dRrcRpq7hx3FpONm1QNaHcXxnp4RkwuzypRq8XR2apFiFTYK5rj7Z+RhUVznOEd1kT1vPQkGpOCX9s4JctI/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei0GaIjp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei0GaIjp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28C0C2BCFC;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789977028;
	bh=HmXNcA1YAnZLx3RPO+XZdE0dPg1yJCRKOMe6ArOea/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ei0GaIjp/JYeY5paFYYdOhUUpKgeAMxtlvvhXH7xYUsbPrUOJGxWKCq0tgnxPeEff
	 8iYfC6oAOtkIgqr9ubL8pRuU6Oy3pNRLis8Js+5SE8EoxM2p+j9bqS5WVLKlIgUd9e
	 DqQyzlNT8CsQLgeV3hms6dvSM1rAZBK+h9VP49mBi0AV9WGFqnRRrLVoj695JtSNWF
	 l4wM5jVmdciTIphDjySjrbtDNQlXdjG7SDv6fvJAQe6ZzYsZSXI4U2dlkFQ7rTfMp6
	 szoExnbD8MSIPlL6OiNDQf5aDAfxxk2Ow3CQlC1CYW77dTZDm5UHP9tq4Cx2wQ++Zz
	 Cv/jsRHK3F6dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF7C982E1;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 21 Sep 2026 10:50:04 +0300
Subject: [PATCH v5 3/3] ARM: dts: mediatek: mt6323: add EFUSE support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mt6323-nvmem-v5-3-2f5d308369f0@protonmail.com>
References: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
In-Reply-To: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789977026; l=757;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=8n+fwUrTUb93L9BoRmKvxttEJdPZMxj+kOtwP+JsFd4=;
 b=SWoFRNidnBCUlUu656YiSgktrrfkfKBTAufN94jHbzP0uIfkrOYsUy/RuOLTGuMSNNMwX8OhO
 r1AiZZpqB58AUPELx7M3UW9eqjjGGHGyP6PH3PAFVownyr3h4R0WR2K
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
index c070f4b0936c..c2d08d29cee7 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -19,6 +19,10 @@ mt6323_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
+		efuse {
+			compatible = "mediatek,mt6323-efuse";
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.55.0


