Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF849553B;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986243; cv=none; b=RSK/FH4k2E0pztXCOJ5ilk0FuBSjxJX9czecpHwYlgDQHg9JEsrSBmU3P2tYuTvMASFHIgNpy0mWr8fApsu6SAmWehl0oo6PW6xIKEcMy2tQ5G7MznLE/Xo3EfnzesUdFYkrB0lQqh4Pyz7c70WdBdnhELXmoTP7ITLf11ZfuYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986243; c=relaxed/simple;
	bh=fm/6sk7gCdpwISaGU9WT3cWYZ93Sf6uQPBQjjnBRxxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q19CZszLV0E0fA+QZDL/gIZXJk0fZzdnJvIMTkTCYEibR8O1P/KFgNsZh8WeFb1eZ8sIvZ/DY6awwCnL1A+dSffMx6MuaoSDaFoRa4/CHjSiZcKcCmRO36kK2LMGI12OprQb3MJx1vr495i2Rg940SVm2PWjGjqne69REOUzFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzbMc/pY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzbMc/pY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A3ABC2BD01;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782986243;
	bh=fm/6sk7gCdpwISaGU9WT3cWYZ93Sf6uQPBQjjnBRxxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bzbMc/pY/pJWmDifnbQE1aH8wxpG2BkGdtgNXDqqD3NDyQkGP56Klxj14iVCvylNK
	 aNgjCARDvlRDHFegTHp/DSV1dK3aDOeLHBFjjjqTnNS5s8Nt1+SHKJo7AU++0sVmLo
	 u6SptGOcdxs5CUYjCEbJHEkbdSFx+MZhKJxJ/XoC7oazsEI4zKUUc+Kt1inJnWTt7D
	 MDuNublw6KRTNt+4t0JZpD8wAbpZ4FcslHFS4ULtXpS+8PqTI50I59lz2fuVqoPfOv
	 0/0Chzc7wUm0CDjhUBESYLrINMnXKb05YJ5ivEcFN/Ojphzwp97LG/t6ph3C1z189H
	 ofMq7TAPERnyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A417C44503;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 02 Jul 2026 11:56:01 +0200
Subject: [PATCH v8 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-add-mcu-fan-khadas-vim4-v8-8-244feee91a36@aliel.fr>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5abGcNDyZbnwiwCnG4O77X3HruqGOL8UXlt8GMxy8MBB
 zl9Jn3qKGVhEONikBVTZOmfa3ni3eWjZ77uUU+BmcPKBDKEgYtTACaiLcfwP+av4IwZqs2uh69+
 qPYpbCifcHrdTO/XOw03zg7heP0udR3D/xw1/3f6H3IFF2Vftz7dZrBJ9bXKKs6vE5renXUQZwu
 v5AMA
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


