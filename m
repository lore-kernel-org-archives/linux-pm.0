Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578249E5E9;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353537; cv=none; b=K99AiSQcrNYI6c2mbHWxHdth68nrzYLMaw1M8tza9PoUvgwi1ITObM65x8hEi/lmJGdIzuXZPzDiCPIqyZOxoaJRNr6WqQa4S/0wFWjD0IGGfB43Cn+LpXD2sQXFQL6k103aGw2cFKcqnPF8mXsMk11Sv7/E/opjpuX++7yFpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353537; c=relaxed/simple;
	bh=OuEeieU+V6Hv70haVoj7A7lwMd9n5Nm96UZgZOqvhug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfRgljt+zHATMztr05gIY9vbTeOBivgAQa2511Oqum6wyVUWAw6gITWsVl9Y/0Op1d+aa/m5odFsnMDifr266Xh5P5DmwKFaky5rLixDmR3wzRg8/luW/cjFnlC0YcaGriDV1U/FpXGxizmqfkuspBX6/9xsnwF/s/T9H3dwlN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg+k7dCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg+k7dCb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5872CC4AF52;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788353537;
	bh=OuEeieU+V6Hv70haVoj7A7lwMd9n5Nm96UZgZOqvhug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rg+k7dCbFo53XmykheSmmOTIi1sBmf5Reim9K1sGQG18dDaAEiY+b2ihjzOpmG29n
	 upHOmYRFv5FhJenaHCnfFrbCPj4ZwsnBuY7cbORAvOp9RSY87JAiBGVq8mgN820JQc
	 azXRgZrLD/XS6XwLvaO8L3jaO0pc9QJjYGF3tV1PAB4tms1ndnMRPxA0beQ1lRXWqW
	 RdhhxBTNrP8u9d9w2XWbGpO7Y+hRMEGWdxYcX34PEKCEbpljHaqihi3N2atvz9iuFN
	 zEnYN1Zf4asn+Q3kgJA47GTs9DqMquJp6GtE1h2e/mt6wphIvfp3stsu8liDBgutTl
	 sX+rEtngcfvHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F53C624D9;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 02 Sep 2026 14:51:09 +0200
Subject: [PATCH v11 5/6] arm64: dts: amlogic: t7: Add i2c controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-mcu-fan-khadas-vim4-v11-5-5f1610d83bf0@aliel.fr>
References: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
In-Reply-To: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9YM6R/Kq3Xfa9am3t4mKPfjg/gHsevT5s9TvrH6/Wfzl
 +wsR/Qmd5SyMIhxMciKKbL0z7U88e7y0TNf96inwMxhZQIZwsDFKQATqbrNyPB6U+bxtJowE+VV
 jKXeV56d2hxmuPXsRc4eZweLrjm2z5YxMkz9bma2lekmw4NvHK2uprd+fk3gfTpB1X1f1KYynuc
 a67gB
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


