Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFFC3ED10F;
	Wed,  5 Aug 2026 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917298; cv=none; b=m+kp4AaLuURVcItjHcYVL15qIpXilPthaUVtUo+GqGJOXh4P1CxRsKFv7o0aSU/2ujBLfbg0VfU3qPmbHyaP3t6PXVnSvY8acocWDGwAFNS0e5ug33v7L8xI8YgdSOuwG5s0vJNLaT5zfe8X0XaHptapwoL81/PqF4kee3cE/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917298; c=relaxed/simple;
	bh=OuEeieU+V6Hv70haVoj7A7lwMd9n5Nm96UZgZOqvhug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1BN3iVz8O0hJdlV+/z6vOgnVAA0blQBvNUjU0DOr8un8tXctDo3vMIG6+Gbf30exDHZjvHwc2PPq7HJXEOj9JozA6VK9+jXtfm/n6AjoP9FPu2DzgMu51vJW6/00yEyKTXp2rpedDNBLqDhl1dVLzJSe9Bb+J8VBa8gzIKK8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6ZKiTUa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6ZKiTUa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2DA0C2BD04;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785917294;
	bh=OuEeieU+V6Hv70haVoj7A7lwMd9n5Nm96UZgZOqvhug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J6ZKiTUaeGgKG2ecyhMMYNtnPpwKKd9MMphy2Hk0OgoC6ypeTb4Xi0xa8Dkis6djT
	 fyu+zf62AABIfywssljTNaYIl0LVGCzApH2fIveoQVSdnU5iRc9Qa/jcz1vBVP+Gxr
	 GcYcbDy1DLFY6S2s0AHQ6pepVcdvrbg9Dhxdd69LKPVJ8wZfgCcW0r1MFEDfRuxRT9
	 sp0U+LiJeA+bGVqTuVZc1g8tVY80TDmr/DSV5JLCnOOuMgr6uCyGgPUWG2kyz48Vke
	 aenlfcwdfVNfnWKN2QHIkBKFmj4TcRSYgWVSwU0M7g2FO9/ivr1GD1oHL8jywyNORr
	 ClhPeOukFt1mw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF979C55174;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 05 Aug 2026 10:06:06 +0200
Subject: [PATCH v9 5/6] arm64: dts: amlogic: t7: Add i2c controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-add-mcu-fan-khadas-vim4-v9-5-75df78710b9e@aliel.fr>
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
In-Reply-To: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
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
 mfd@lists.linux.dev, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=aLYRKhvnbuah+/DuOuT+PfGuc1jyAXlae73BAxIufCo=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ1bR++xD0lozJ/qybzkrnOm85vwtL0MDGeZzn5Rf1M9jN
 b59I0W+o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZjITwlGhnle+1bf3SDsa6g1
 I8/Vyadl95H3G+8LWbJ/jHxX/PqBoTwjw7aULVsvn88Usbq17S6jnnL+kv8aUZ327RMaVO1k/WT
 TOAA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add the T7 i2c controller node used by the Khadas VIM4
for MCU communication.

Use amlogic,meson-axg-i2c as fallback compatible.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index c3dc479b137de..0f48e23077e99 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -724,6 +724,16 @@ pwm_ao_cd: pwm@60000 {
 				status = "disabled";
 			};
 
+			i2c_m_ao_a: i2c@76000 {
+				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
+				reg = <0x0 0x76000 0x0 0x48>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_SYS_I2C_AO_A>;
+				status = "disabled";
+			};
+
 			sd_emmc_a: mmc@88000 {
 				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
 				reg = <0x0 0x88000 0x0 0x800>;

-- 
2.49.0


