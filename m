Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1E43C048;
	Tue,  1 Sep 2026 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276467; cv=none; b=AlBtXRK0UNpOaPj4hK3x+sHPuxP/6syJQ6SLCm9f8ErB8j6+S4ofujdnWk4EAIfVKF7MX9OTenAICmRBpaOz1mOIIqiJimO9z68FPyGYukBq9baQAnitkXOXEJNnPv2Rl5g6EUJJ1ji3aZvudHafBQEAJ5saVBKHCSlGUAggTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276467; c=relaxed/simple;
	bh=eto8+h/MaXkAsviCHPdmpQdT7c0Kfi4t066koHw6hAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCrncXcaa2s1Le1GUkckqxwbb6tf4AP4emeD0NBAxxeLP3p9s2DXfxBO7kWWJfWxV4mic9+EDIyHbmW68Wf0Z4PNCsPMZ6DI18/YlfUAASW4oktmfOeySCXqyIyChIBRryNP66iiKQ0myraztcQQCVg4DSN7131vrxQSyyNzkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiPHoIA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiPHoIA8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D97C2BCFF;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276466;
	bh=eto8+h/MaXkAsviCHPdmpQdT7c0Kfi4t066koHw6hAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UiPHoIA8cqD2VvU+uW+MTs3MrccWyDVyvOHhj6U1ym8qGMVg4ciSqoRR/DWTU+O35
	 1ZQPo5Sl+p8n6CLwHw9OItXz550QfkHj5JNhKCd1iegE/hU8AugW2mi/LJ08EyKR7v
	 aWsAh+G52/C2dzyTJxk39/RuwFGOmaINF59F4mtFDmhPynjRyTlgOPlJgXmJNB6TWi
	 e984ZNXbmkIa++fZOH+f95p3okA6QR3khk0OVHS61hXtD6GKWOadsOmWceC/UJwiuJ
	 IhHzFQlyti+iucITO8hfgrGjZPKbpGCeh64rEy6XGWFd1VtocgHikbpIaojNvXroQo
	 zp/x9/n0IXEMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E06C624D3;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 01 Sep 2026 17:25:57 +0200
Subject: [PATCH v10 6/6] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-mcu-fan-khadas-vim4-v10-6-aecdb9955a30@aliel.fr>
References: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
In-Reply-To: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=Z7uWC5BzI9Wq+imS2bvYjb9eymbusN6NdD/vEPC6HdE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a0dx+UNA2Ttpa2JXA3PdoSsHGmck9Q4CLtFVdlXdnNc
 3c8frulo5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZiInjcjw5y6K3lTNi7Sf6Pc
 u7Oy75iP5V65osVc5kI1U1JivyY8b2VkmC3f+OgiH4OMVPka742bN3hdZA1vX5m+LjcnUWTh8b6
 DDAA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Enable and configure i2c MCU node to get fan working on Khadas VIM4.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index c41525a34b721..7d95aadcf6a66 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -167,6 +167,19 @@ xtal: xtal-clk {
 	};
 };
 
+&i2c_m_ao_a {
+	status = "okay";
+	pinctrl-0 = <&i2c0_ao_d_pins>;
+	pinctrl-names = "default";
+
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,vim4-mcu";
+		reg = <0x18>;
+		fan-supply = <&vcc5v>;
+		#cooling-cells = <2>;
+	};
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_pins>;

-- 
2.49.0


