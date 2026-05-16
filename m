Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4C3EDE51;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951902; cv=none; b=FKacOQT67SAfCkoqBDUi9b3aid2POYOPNTwb9HTSmKCLW4d6E/t/yulWsixmL5jOpuvngmg28kaBJVmnVDjMOfByADgq5LVUgu9znDRDyDJJoaHiBQVoII0Gdv0sOYaK2rbSc+XioaNyWSKj1MDWy8+3BzCGxTq51Bi+Dr3/1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951902; c=relaxed/simple;
	bh=LgAbB0ZXLnx/BP4AfsepnntHvttapSIZpd8aWCrBwiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTWztRiAntqfAoSkthhDnrksyOSB7A9TVJGcbO8irAExQ7YGY4mGjaICsW0XOBegypEoyTRWuDSu8X2nJMW2wuH1cd4Ne0VhAzmUR+FBwyCgSbTyYOPzODbgUXc8ugCfS8hcqG7DboE1cEkinyektOD/9U/EbbWbc4KvboN1OYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/ogeJvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/ogeJvo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 785CFC19425;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951902;
	bh=LgAbB0ZXLnx/BP4AfsepnntHvttapSIZpd8aWCrBwiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P/ogeJvo6Qqoo6251PbBts1gxDZKQiSTZJABnSyV+H+BPs3XOTuNY8mzop4NeoEb7
	 dWaQr2pVxhRn7VYGMcPBHB9Q+CabVNprvHlUPt6aYqC5frvXBKdvVbRDLG/rDQnUJ2
	 Mu6BKndXokp/HqiCMDJmD9USbKgqleB9cUuRxkcyDd1PIcGky0r9oZcsLrh8dKc44F
	 FNUM59cmQMktPYOS1NHlOPSMCnewFSf75WztHhgTRlAG4B4DFNrw1ABQaKwMWzCI95
	 k38WDRoM/8LzTPTMc1SNkUt9rlUUj7SvY++aKvxQbMXCGTjv4kwS2cgz9n1xQnlqiM
	 fJrs2LOotNLGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6885ACD4F21;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 16 May 2026 19:17:06 +0200
Subject: [PATCH v6 6/8] arm64: dts: amlogic: t7: Add i2c pinctrl node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-add-mcu-fan-khadas-vim4-v6-6-cccc9b61f465@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=F350Js/5aqFj9YLCGASaC045elV+sRf2mbU4+Ox2uSQ=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQxbHshupb14UHLFPDuh4t/dq0s3vaxZNZC7y4IrkDXG4K
 i3N3GrUUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEykgJeRYaNEUOTW+OXrvJMc
 dn3fvOPXXtUX8YFbs48fear2dte9TU6MDBc6N3LXpXhI1PYcj864E31vkvfsBrWrCZ7a+zrEbr0
 qZQAA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add the T7 pinctrl used by the Khadas VIM4 for MCU communication.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


