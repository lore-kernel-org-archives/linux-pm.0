Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C513F12EC;
	Thu, 17 Sep 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632045; cv=none; b=nBYm45enRtd+QngJf2TsNrF4uLewAtF8tf2fcTgThz2HvPFDOvnOou4ZDRBdyRpKDla1bDLAuSO5PiMjuvK9ALb1uCV1+ZeloN232E63m0Fbg7wSLA1dqC6M/LFuZ8+tynijOtBYWbPRkHugGoJ4/6FBRdastmH0TuqrIpnS18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632045; c=relaxed/simple;
	bh=eto8+h/MaXkAsviCHPdmpQdT7c0Kfi4t066koHw6hAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPPp29caxnLr0O32dN5ROBNYZ5i9TC8wlTTZLGnc93UfPWkXwuaXxnXp00dst7xkppqgRw0reyKkhSWjwyveDw9xqMTL2Xb27yKwGxJTuKZggcSSBPHsqDjkd8aVECSfwUzwNJ16sdHSRLqhujH5Ff3aOCzNgY3AlihQ9vJg3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLYkHTsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLYkHTsH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55E25C2BD05;
	Thu, 17 Sep 2026 08:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789632045;
	bh=eto8+h/MaXkAsviCHPdmpQdT7c0Kfi4t066koHw6hAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aLYkHTsHZXIDsir866SV6YWty1ZgyZIGhcp+9Ub6n3FayyM7guGMhDZJ6ZcHCVYM4
	 PpiQH0/ymoHlf67jrt06SSJe1Z7srO5I7vizPoc0Eu5gDXmNUTFs2lvBt2qC8Vgabd
	 j+OumI+rxNdG6fdzgvFqhr6A2W7SWFMFlhiKKhrNnSrTvm7HuVKlC0VrGN4GUca4IN
	 lzFCM2GtqVb8l2mgzzwLJwwZt8eeAh9HhMKveIQlx0n60ISE9g8Y3cPkCkv95UKrad
	 IKonTTwrDnpYG4Lz0he/YC9ZaAQn4vbyQ31U5KpASBxYhujul2fhNM0F1xmAEF+SC8
	 WwMlH0GoFGR0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389CFC982D0;
	Thu, 17 Sep 2026 08:00:45 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 17 Sep 2026 09:59:05 +0200
Subject: [PATCH v12 6/6] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-add-mcu-fan-khadas-vim4-v12-6-497cd543a148@aliel.fr>
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9bqeYqHb2Qe4D9/hil7ZZOBFKt54vSIIMXClw8iSn1dJ
 NodZiV3lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABM53cTI8Nbl6P2Xqx4eK/22
 IDZ4gy67df2pmt2Pf+6/cS7TbvW0oxkM/xM0A50duCT034TmRzE52/O6n/AP2LggT8ktVeXY3Sh
 WFgA=
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


