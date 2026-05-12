Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FB345CC0;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563300; cv=none; b=XD3fcBrH1nOF2wSB2hItGvcKu0IfHqBwd+jfj8RkJPHJG/kJYnA8mNcNqjAfpKlO51uciP7ydC1xdmnRx/JloPDpMCezZ9FZIGBvtjk/TAs497BVtTpN/03O2jEwjtg03PDwb5sao6L03qgdNaFgAhZP+q34pCKpvkpL6/wrWfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563300; c=relaxed/simple;
	bh=8LjuDulzYLmRaj2TDf8HCdfbm6wsv3ZhsqGhe2hh7Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJWMe9yWaFWI4AkMt4AFUCI2tbnJ1W3Aj0Bi9FGwF6KlVjFi9kDScj1GeHnuLk5qmEogSULhsWTCv3NeE8Rswixd8JD/2xvSpn6nuSpiCvpmbyskozUM6dm0rVfPZd2h3jLXEHsSwfAUDdz7AMFf1XnqSSPYkJIiLK6ulkzAYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh+A6D1a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh+A6D1a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B051C4AF1C;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563300;
	bh=8LjuDulzYLmRaj2TDf8HCdfbm6wsv3ZhsqGhe2hh7Ys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oh+A6D1aWTTHR6KfcLfwdhAwkL16uURUqLSpC3fIi2jyI4GE8/GO3p/1Ax2pQh5OH
	 loAADBHqZ0wQFVL4Xk9Mt/d806AzPgifHrvPcTqFFcaNe7s8uetQupuAM+da2xgKjt
	 Kh4UO0xp1n4D5uM0kxCHm5yMfXMbYUbZIXwmOSBMN8JRQUFHPmx4II9S7d7iQ2lDo8
	 1SghxLXT4qVVaMAJ9RAzKjIsmtovTumUmbnxSiqsE0kQ6fRlAO/UnKA+uY+407WssX
	 zS6uWpUbkfpJ7bbuwTQGuyjnxujPI3sjPq301djx91r9cQx8vbG39JTb4y3WoQJOxj
	 wVD/c3J8coHRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A14CD4F21;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 12 May 2026 08:18:26 +0300
Subject: [PATCH v2 12/16] ARM: dts: mediatek: mt6323: add EFUSE support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mt6323-v2-12-3efcba579e88@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778563297; l=766;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=IHPy/RTwV0nW27F1+HFkiB9qZUJYzsWzRshWgHfRmOc=;
 b=xAbskpASSwthNpq1WyjYIVEaYi3Eq9sMQSWuWsIp4060HeQxZuug2Pxt29zLFJ8L9hlzYJjiZ
 e0HJCBguc+BAeVeLwIGraBQP+CV7MiIxnWqFoaDFfenzHkoaWF+yf4D
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the efuse node for the mt6323 efuse.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6323.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
index c070f4b0936c..435936b477fa 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -19,6 +19,10 @@ mt6323_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
+		mt6323_efuse: efuse {
+			compatible = "mediatek,mt6323-efuse";
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.54.0


