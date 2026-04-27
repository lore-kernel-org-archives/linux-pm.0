Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62263346FD2;
	Mon, 27 Apr 2026 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274205; cv=none; b=G8iRC1qi9Crzv8ch8D7z4q0Maz1hx+dA9+P1E/6bh+q5M5xrE1gP6DmUlBEr9Kd2mJJnQ9u8g0mxvVv4FBpXG+m02RexfW8sKbMiGdFZs1YR1jHEkAGBpc9/NkM5pReDS5xVLDYtuAW0FK3Nk/8BkUJUggkJvFb3XhYzBgz1eZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274205; c=relaxed/simple;
	bh=8HzKh0CsYmGIMngJ/4+BYykBWGiMmfP0pM8J1UsfrB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oyezWWMrC98FVzkBwZGaevlgyL1KGlsS2n6T4gDNMtHppGuIDgrITj+QbNn3OqunwdPz6QPt5yZfcpIMWkPa+Jf2g5Yzjsy51Y87cLiCi7MRCL3y/gvmnAH6CknYyQQnKM5efl4zHQCgHH4wyuO0MvY7myNMRJgprChoblMdBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Zl9Pj3qB; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=txtDWcEB; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Zl9Pj3qB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="txtDWcEB"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g3vxv4gTyz9tty;
	Mon, 27 Apr 2026 09:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777274195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNJkRq0Y8simejX2Aa8XtIUh6Eyf4vR8aRfuoLPHrWY=;
	b=Zl9Pj3qBfuKkbhhIB73UH0q0hqcVm6qjP6z4eldu+8C7/fN6RLYMhKRIraW/Hl1DcNKwLL
	eTQd/9evh+MGwoXxx9xWzaq/mw5OehGTHgqFNlngxfMZ/+mgksiHGFWjL0xvMqcMWSx4Fe
	8SBjWYrS5SI2P2uJFzzohxRtwL1hW7J5V4Y3rgEOO9HejIx4SVdyGPLuGDjOFrtsz7fpzK
	KEcUwwxubv7cyclG4MvuiIDKHOAew3F8i3iZoS/jG2+ZTsef+cy81tD7pajQeFYQULGOfo
	yaftIBD4kQ5jmyJgJ2dJ+8gX2rVqXZJDQ6h7ZtzdLSA4QibvVRDAa9KdAFR2dA==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777274193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNJkRq0Y8simejX2Aa8XtIUh6Eyf4vR8aRfuoLPHrWY=;
	b=txtDWcEBiElxI0YPtmeKnq5I2+M25J+FjsalJWL40Fsb6PzGrmwrTFPKwEKbNOHS5wDAOP
	uKmc/EdJn5YO0gh5Cvy83Q1zRatlR8kj2ewbc8Wlo1b3Z4/UsFm/brdF+/uaJSLSl8mSyp
	2NWF/BKO3TrballD9OKKXehU5F+q0iRPDgt21kM0kvfoCN4Nw9vpWhDRvwt4GJkrb+neVT
	PVrwXBy8l7k17xDim5lHMtysIIreKAiDRxgpAaCxk9uR4eqq1tXzpMfEe1nHZjmGKauVvQ
	SQ2NVrI3EV7XtghjC/Yv1KQren//EjMD1paABk45IPW7b7E733jwvOKLtNlLEg==
Date: Mon, 27 Apr 2026 15:15:17 +0800
Subject: [PATCH v5 3/3] riscv: dts: spacemit: Add thermal sensor for K1 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-k1-thermal-v5-3-df39187480ed@mailbox.org>
References: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
In-Reply-To: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Shuwei Wu <shuwei.wu@mailbox.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Vincent Legoll <legoll@online.fr>, 
 Gong Shuai <gsh517025@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777274126; l=3192;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=8HzKh0CsYmGIMngJ/4+BYykBWGiMmfP0pM8J1UsfrB0=;
 b=sPSo1p+fRgWfsIBAcWspbSex6Q+7fR3ybqJIkbskOZxkD7AxY1MFkmmpVh5Ps5X0eCAf+8hUc
 hsumGXIewy5C1H9TpeSr6e4GKLgjDuLuNCIUPPOzBwuo3D/wRuRSSQn
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-META: 1edu9cugtjhi4dqfs4p77qwrqgmidauy
X-MBO-RS-ID: 5067cfa422e911d2738

Include the Thermal Sensor node in the SpacemiT K1 dtsi
with definitions for registers, clocks, and interrupts.
Additionally, configure thermal zones for the soc, package, gpu, and
clusters to enable temperature monitoring via the thermal framework.

Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
Tested-by: Gong Shuai <gsh517025@gmail.com>
Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>

---
Changes in v2:
- Update compatible to "spacemit,k1-tsensor"
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 529ec68e9c23..e9952204224e 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -339,6 +339,96 @@ osc_32k: clock-32k {
 		};
 	};
 
+	thermal-zones {
+		soc-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 0>;
+
+			trips {
+				soc-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		package-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 1>;
+
+			trips {
+				package-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 2>;
+
+			trips {
+				gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 3>;
+
+			trips {
+				cluster0-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cluster0-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 4>;
+
+			trips {
+				cluster1-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cluster1-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -494,6 +584,17 @@ syscon_apbc: system-controller@d4015000 {
 			#reset-cells = <1>;
 		};
 
+		thermal: thermal@d4018000 {
+			compatible = "spacemit,k1-tsensor";
+			reg = <0x0 0xd4018000 0x0 0x100>;
+			clocks = <&syscon_apbc CLK_TSEN>,
+				 <&syscon_apbc CLK_TSEN_BUS>;
+			clock-names = "core", "bus";
+			interrupts = <61>;
+			resets = <&syscon_apbc RESET_TSEN>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		i2c6: i2c@d4018800 {
 			compatible = "spacemit,k1-i2c";
 			reg = <0x0 0xd4018800 0x0 0x38>;

-- 
2.53.0

