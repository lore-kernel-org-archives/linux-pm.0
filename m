Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196F3DCD86;
	Fri, 24 Apr 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040410; cv=none; b=QfHyCcgCsNppIHclLMcmTZpL6I8efVWOCWNeN3QQlt1Vau7XgF72pb0+QVnYgM+NHI2xxXtIDa2WjN3VIcnGRQdw0i4VBP51/LzpRrOzdAwlaes5dQ0xvHd9NBWo9gaR3EVLbEDW8RJREVrOjSdaCjpL2OUvaeqfsGVzAyQzBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040410; c=relaxed/simple;
	bh=fm/6sk7gCdpwISaGU9WT3cWYZ93Sf6uQPBQjjnBRxxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SN3faUWmfEY6CsrLwk9b6cBpph2lI/nR4cxxDtoXsoNjWKjLy8ZVsjElrWWY9HCiSRP5qYko3uJOFGcHuaVu2VS7gDmr4nhrAg9BaJtAY3j1HK4yrC/8ybO3xfL3xu040kyksk2lylF3l8x5vcOZqbrplscZLdUbborBfiD2YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB4pC12t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB4pC12t"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A745C2BCC7;
	Fri, 24 Apr 2026 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777040410;
	bh=fm/6sk7gCdpwISaGU9WT3cWYZ93Sf6uQPBQjjnBRxxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MB4pC12t86Z/VzsVD3nQdz3oT89F5fU6XkgRoSTZdHS0A34SN+Y1AlHXjljYs7G4s
	 AZ34sGLTGRC6bijfZUpH+FD44lpA0wjfci/rLgeO1Yf8fAbRa5ztUY8V/AEXCFQHGL
	 FiOdURxWpmd4mHJ/AdT0DjbBtfHKQ9GvUDqkAdq4lMzSzosEwDoQN8aZasfVOaXadB
	 WP5T2wo46mTqG7CCMbHh55iyyN6hl7lRu3fd68bzFXS5oRzsmb9fuk7lgJuzbfkD02
	 1cac98Zg0CH0POYbW8Z2NovCArRrBiq3CiSK4zA2VDbuvEe4N3hmvieeDbKrs9bQT6
	 lxMyfHzCsIGGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B62FED3CC;
	Fri, 24 Apr 2026 14:20:10 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 16:17:39 +0200
Subject: [PATCH v5 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-add-mcu-fan-khadas-vim4-v5-8-afcfa7157b23@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=ReP9jX1LqZ1xk8srjfORg2VmRh0QSxflyWImCLygV1k=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brGnEG9dZth+5n/36TXyK1d9qhFbu+p0y1/tLzYGPPu
 /Dds6Yyd5SyMIhxMciKKbL0z7U88e7y0TNf96inwMxhZQIbwsUpABM584qR4VBNZ9Rd7mPutqvr
 Q60ES99b7Q8xFDvc2q3nLimd2jbzLcM/W0f/AoO339yva95vnMnusMDx+usjDvvUy0QEGf9/6hL
 gBwA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Enable and configure i2c MCU node to get fan working on Khadas VIM4.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 69d6118ba57e7..5d7f5390f3a66 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -157,6 +157,19 @@ wifi32k: wifi32k {
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


