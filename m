Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767739F162;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772222; cv=none; b=aiFvAqUr+zXclEgmBXphVHduaBr9CqVuwGZ+LoZp2IOs/1EMfQOjJ5KvXpfp3STYvDq7hhUemQxvzUPBK1lVfCKo/w7WUGMtytFNpgfu9bnHNUE6GWBZFsdYNYLUpPF3alggct5/kGIxVIuR+4cNGszz5jsuP+gCoZDUFYMonNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772222; c=relaxed/simple;
	bh=NFdn41ZvrKDWcDcQoALKM1WDPndu6bk+UeLGgAzHlGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qe3mRRwj3zYAy/y577Yxxf+iuzyinAsE1Jd0IagxVV4rYydMnWct12I5RkTZgKTFpIEF0vwCQ7Jdo4H23veeF+729/OdPyXP75HxhPw6EemLJmpmTSnGTj6zqqgnf7g2hLcRpKEo1MbqLux/g1NN5/gtsv5oX15P+BBCadned6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ll/9ji7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ll/9ji7m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6828CC2BCC7;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772222;
	bh=NFdn41ZvrKDWcDcQoALKM1WDPndu6bk+UeLGgAzHlGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ll/9ji7mle9oW9gKW+WtLW+MYZT9xkvc1lqhj/ravus8AYfSqcH2lkb1bvQiAulcq
	 Y8x6KLDbiJqllmuPyEDvvIXnSdd0l96TQPTWFfIqI/Zzxyg9OYLm3NaTcg/kpDp0Bi
	 vvsRMQY3o64HnWsmOvUkZjJMQa2d64UVgPJ4skOvR9eo4etJZ2+YtM7GtI/Npuie5t
	 8yCGUAOEA1xBbCwcJpAQT0R85ENokMGFiqqVWi7LGoPC8aBGLlJZXl2rCdFA/4Kxgv
	 uXcYnuu5cV66hWvUvStQw9M8AU+5xXYp1wIKX63MGSPRUV7CQdIUOGhGP80krp0/pT
	 ULV6Z/mkiwmMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D96FF8FA61;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 21 Apr 2026 13:49:23 +0200
Subject: [PATCH v4 6/8] arm64: dts: amlogic: t7: Add i2c pinctrl node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-add-mcu-fan-khadas-vim4-v4-6-447114a28f2d@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=835;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=Y66wwsu4uCJ5vCnrkH5iYoYFi2DeQ8efaTE8Rt+0Rik=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+bzlArxv1e5Xx0o0Ptf4xeRq9XBfmHhWkPBZYfuxR7wl
 38x69C9jlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAi8VGMDM3bdx9dn3GqLuxl
 VF/4M4sHaZm/V0Z4/Zx/wrvNXd1Lw5zhf+28NS3VroaqLpbvTB/K3jWeF6esXRuQzszjyrgy/ux
 +dgA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add the T7 pinctrl used by the Khadas VIM4 for MCU communication.

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


