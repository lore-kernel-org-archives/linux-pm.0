Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94E3EDE72;
	Wed,  5 Aug 2026 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917298; cv=none; b=OicVvKvh+4cJOSHH1s5VoPk8jKsFFIxGG/xjK3qYTbz4b9cLDi7ZwjCNLDCS6U3qczu5CmuOw66k2cHFHVr5om5uqxWSkY95v6nAhg3HaTMwHZ9WEcRGuNL7YulxFnl5619d585T2re6MDahrZMbjXxpIr73mh9fEW185vBnAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917298; c=relaxed/simple;
	bh=eto8+h/MaXkAsviCHPdmpQdT7c0Kfi4t066koHw6hAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epVu9TesTdgbii39h3z7Eg4KQellZ9MsMHm/acWmPidqPEkmRPlT61TJz/RLSDieh6/huuPX/i6DfkIwXyrmgc7fvk1x6HQNmELq0v+yvnc9axm4TlB6VoUGPwbloHAqYf/04J/7sV2Q4ssxx0cG/s9qOs6F30kJUjChrwSJOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZolXATy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZolXATy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E231AC32782;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785917294;
	bh=eto8+h/MaXkAsviCHPdmpQdT7c0Kfi4t066koHw6hAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OZolXATyrJE/yc5j9XDI8jBSHdrWTGLmmgRxfQWnYKzLCsatgjHNH1KpeZL2D4ewB
	 HKfHfqF4IZtZt4WAhlzDqyLtS/TP6b4qy8O1NS9ejoQ8QVxgV/+GJOHyMfJYB1SVUu
	 8YilUj2OMTkmuoSyqemdqYMqPB/5jjeAuFiW4P49PbWFqWZLBLVgcwmXjmyGM3xTl5
	 K32PszTCLvOXi9O87R8wv8v1IIPl2MmKugtACwug3KxSn5azq2/aCn0/BsgcYG56JN
	 BA0tOuxoc+RwLF7bDeSGk1uDwctPqf6aGsoNx93kfgLb0hRoeFQUUEayQBh2DqNZFN
	 qOmmyvS5mG7FA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1039C55822;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 05 Aug 2026 10:06:07 +0200
Subject: [PATCH v9 6/6] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-add-mcu-fan-khadas-vim4-v9-6-75df78710b9e@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=Z7uWC5BzI9Wq+imS2bvYjb9eymbusN6NdD/vEPC6HdE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ1bR+5yHyto2astO3/kw1/dqzha+RROvV16YyDx9hWHh3
 UMLM7t/dJSyMIhxMciKKbL0z7U88e7y0TNf96inwMxhZQIZwsDFKQAT2fWKkWFq9/knovZf5xSk
 uPXkth9M3d9wXPcjd7l33M2bB5PbVHkYGRZ0u7/SyPl64DfbhY199kr/jzeWFPX/ypr/eaHrOZv
 GVYwA
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


