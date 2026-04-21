Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33923A4509;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772222; cv=none; b=Foe+0gAO44UQQwtaWa4e7ZwnAUCsw9oszA0KVrBnBWqrvlAAh57dcWWJr8RRuCDUzdYq75WPw/glA5upUNF9XKVepMM/aPCUJTKH6oIT+vCLXuGE1JEn9zBqfWIQdSu348Vb0S9gpr8UPl8bS4no/9BEWPd3IjUt9htx0XQMW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772222; c=relaxed/simple;
	bh=L045idsfe5tBxWKrm0ghsehcrRgpTcq43p+v6y2prJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJJCiHp3LE/O4HnS257hTi2PEiDj6SK5XIvWVq2ZWvH6n6mYKusTXLfMEIUa5NmctClF8pUAUidHR90Vw4L0+5us1MG+SLvenh1rhTCbUeSO1fnBu98gaErSY3tWGRetsvsg284rgDB1n1FQA2B59cl+h2DRbZgCplKYVB/MZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNa67ASd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNa67ASd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78F2EC4AF11;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772222;
	bh=L045idsfe5tBxWKrm0ghsehcrRgpTcq43p+v6y2prJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gNa67ASdeW+Mka+gONNh4lfgwfJgo3kL54lKPTrtntyJHmbrSR3/sBxw2bvgHGivp
	 QHJusrE5pgI0JLaHSR9bS/sGhji/yEosn2xNQyugde5WSSSr8OzxTu/UB0aStdICXR
	 +eHVavvmHCFWDEHj8WNguD//5+2m1q7bZoM63K2whbvm0yJ9fIAEOan99kGxvbFhkM
	 71gpbCXyLl+Ll7AxEWw3bQ8GHh/TYnxmlD+aLX2sg84jyScf6WePNrSimhPFYUjVSH
	 jvqdnTvuS2U4RKd1ZgQJ7u9PpjdXtyZbjZ3UFmgawRYiUBPYXaVK3FWdCNcjYbcQoZ
	 bI1HKvNurBXXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF47F8FA65;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 21 Apr 2026 13:49:24 +0200
Subject: [PATCH v4 7/8] arm64: dts: amlogic: t7: Add i2c controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-add-mcu-fan-khadas-vim4-v4-7-447114a28f2d@aliel.fr>
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=seZTIBpCrIa88Q5I5ls9lWfgh7ETpuTsfLV3IO6SlWs=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+bzlCqnF41f5ZzTdcoWHisQmKfda7g7YfbxfX5Ljq/fu
 0qq7eq1jlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiMzoY/vv9LxE5wcvHxjkz
 9c/diBAJxvi82F+b82cJTK++sbgnPYrhv8+lJivXOiYFnhi7/ltmn6JUkhwnRfbbsCec4NTYXrS
 UCQA=
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

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index e96fe10b251a0..560c9dce35266 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -711,6 +711,16 @@ pwm_ao_cd: pwm@60000 {
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


