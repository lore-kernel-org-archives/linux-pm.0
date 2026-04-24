Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214F3DC4D0;
	Fri, 24 Apr 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040410; cv=none; b=AbdefNGBpQdSiaCeuBKSSA8qi0/SirfwrrEuQnhC+9u6y6+qZJnEKksJti7vLMmWrWNFd4hu1XIZ+m393mov0heY98z8xknJHVTatagQ5NGX+XF2TrGMgmfOIFopnuiyZ7MuwkTNtUfsNaVGVzJCNI3X6go2dAPsSnk5qNBn4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040410; c=relaxed/simple;
	bh=LgAbB0ZXLnx/BP4AfsepnntHvttapSIZpd8aWCrBwiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYklBBkHyqjTGJoSLenh+hMAqIMoVkrKEWtalw9NBxayPTnuHeg9TIoj7A7xT+kh+GxKRT5Ex6b45VrT01G9O8xoN6LsIVCJGcf2ZM/Cp7RszwepNKJ68trL3p1cUAWx/h6DCWPZ3y7BKFq7wvrOyTLWpcx0znU5C7FgIOrwudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuMg6ojl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuMg6ojl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4146FC2BCB6;
	Fri, 24 Apr 2026 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777040410;
	bh=LgAbB0ZXLnx/BP4AfsepnntHvttapSIZpd8aWCrBwiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cuMg6ojleRTgRYwhsS7RYsru8mjvOQoA2tKh2jDNaGxKnkCznchzq5RRgVsdNkH1w
	 WbinnftlIG4tdGLnpzBUL7LR+XChCFVQHjjaRb7AIZ5VwFn10JZmUi1Vax6Un0//EY
	 FYlW6iFfcusIYPWDphIIXFnhNSX6QKUzG7whI8AeUzxpdzunizeewcdI8ve+T4S9AQ
	 4vNd5x/pFTaFUYTKFUmit8lMxTIQkH8wrpUlAh5IaVVxj4YEcy5GQOZsIakZtbTpQp
	 qncYSl+sFaeCcZ/3V/nbj2G3+aEy2LbrIU+qe3HbAm1sEzs1KmgTVfMLt1tVALGWZJ
	 KDkokFyuZ6hKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3130BFED3C9;
	Fri, 24 Apr 2026 14:20:10 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 16:17:37 +0200
Subject: [PATCH v5 6/8] arm64: dts: amlogic: t7: Add i2c pinctrl node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-add-mcu-fan-khadas-vim4-v5-6-afcfa7157b23@aliel.fr>
References: <20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr>
In-Reply-To: <20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=F350Js/5aqFj9YLCGASaC045elV+sRf2mbU4+Ox2uSQ=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brGlGNnz/vmnocm/Wy29yIo6KZIbpi71UZL2X+c5Mnb
 P6bs0Kvo5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZiIw0mG/0GJXTYsC6c8NV54
 9MaH2rkv1pbEq0cKBr3o8MqaLGw2vY3hf27EkdmLivTZJMLW6hXOXvfuAG+uSAD7F8MVlV/t5/b
 psgAA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add the T7 pinctrl used by the Khadas VIM4 for MCU communication.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index 7fe72c94ed623..e96fe10b251a0 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -376,6 +376,16 @@ mux {
 					};
 				};
 
+				i2c0_ao_d_pins: i2c0-ao-d {
+					mux {
+						groups = "i2c0_ao_sck_d",
+							 "i2c0_ao_sda_d";
+						function = "i2c0_ao";
+						bias-disable;
+						drive-strength-microamp = <3000>;
+					};
+				};
+
 				pwm_a_pins: pwm-a {
 					mux {
 						groups = "pwm_a";

-- 
2.49.0


