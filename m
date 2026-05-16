Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F93EEAE3;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951903; cv=none; b=CnT4h1abFCeYzioOpWc0C9kUnw4GPeXAAsQEadlcZIRe/6Axlp+4KlJJuuTCzWjLemNqbFqDa/KSV8NIPktlaEknfNtx8lFDqMTFA40irfFDCqkCZ+mXvrGzKQY48pED5iRKxfENvt8Ep7E8psq29e3uFC/zY/yKUYDyq/Zevz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951903; c=relaxed/simple;
	bh=fm/6sk7gCdpwISaGU9WT3cWYZ93Sf6uQPBQjjnBRxxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLdgto9TxdoAoGFIaE40gpJ+kyz7Z/UwQyFNegIaIbf12KdXgH3Zqjk2gkyAoeNXBficOvQHMs87QGAXjUw/cpbFkb/hAlBpvhkFZ2zf8aWoeApx0xwJanT2tHul+1lgo1pYyMZklG33AOnV5nvdG6jeJaM9jBIKn0AEVluxz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2/gP6qh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2/gP6qh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B13FFC2BCF5;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951902;
	bh=fm/6sk7gCdpwISaGU9WT3cWYZ93Sf6uQPBQjjnBRxxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R2/gP6qh3cyks92N2UuNFBHalCc7hsnC2KEWZpMsgD+MsVy/mlJzAGQrkSZYkQkIu
	 amduRQe2V1iiwnY8OHJ5qobvAi71dk9XdFBu9VM8L33Yudzz0erYxqWAriHK4P0K4B
	 vSrYcdT94yVVZdc+e+oJUUNdnsRxmoHmTbhY1If1q+cWqJ4IXsQWzVtuFF/xqb0ptR
	 06a02re4/22JeNkY763AJqZVdJL6GpbUHyV8GTFU6C2ENmbY9xrl4lUwb3b6r2fsio
	 biLKlWw2D3bSZZDziai7gmbK521cK4q/zoyGkqz0UHxHRFY+6IyTgSlRPcp8Oaqqge
	 QLBoVxsLecpMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10D0CD4F48;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 16 May 2026 19:17:08 +0200
Subject: [PATCH v6 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-add-mcu-fan-khadas-vim4-v6-8-cccc9b61f465@aliel.fr>
References: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
In-Reply-To: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQxbHstsB3Uu+camfa9KbLV5qOpXbbz/HSsvY9j3LlcQm5
 XyMCJTpKGVhEONikBVTZOmfa3ni3eWjZ77uUU+BmcPKBDKEgYtTACaitIPhn/ZN5tis9Wyz7DzP
 bL8wqzqumkle0fJPcn7Ok5+HtRnWGDD8szP+tfWtY46nxVabPac+Gh7akSnNuVV3v+u0td5ijb4
 qXAA=
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


