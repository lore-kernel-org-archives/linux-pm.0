Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCB3E1CEE;
	Fri, 10 Apr 2026 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839753; cv=none; b=baUNQerAIPDmUpghONy6PRLsOcM0Cj4zbg6v30UhtAmCAUCaCkdxpYThIJ5bETNclwvPeqvHmq0Gj12EpCKuL7/YOMUGCgezCqwlIWHwYvSDH5z43JIoIzuV6Cu2HQJhv99bYiGWS6oR4IIvYQGLBNil2T/oaeEch34Wd3U7QAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839753; c=relaxed/simple;
	bh=zbgRfmKb31HDgkan9Fy8S+p1BOUmWfaoe9tmTB9hGac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lEQ7kCVUKXO6OnSTSiwiJD8g5eL2WoHG/V6ml6TCsQvtRjcC5fYpkn8tWuyQS7a2dgs7kAiixRilPx5MTx46F9pbn5y9NjTAGJCBGmpoLUMkA7RpFveovCCn0uvvXjV3Tk5yDOxoaEq+LZnOgCof5UjgNOMiNOBnovq/ghbhoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=V8cYyD9b; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="V8cYyD9b"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775839740;
	bh=zbgRfmKb31HDgkan9Fy8S+p1BOUmWfaoe9tmTB9hGac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V8cYyD9bEpwmmkTC/R7Qz5FjheScvjl8nZ5M8pQ41u89djP5EFMB8CTdxr004BJzm
	 N70SjO/+XSlnZQ5g3u+y70Puhe46UGJWDTDsn99BXyRXS9y4GDpSEYoAF8DSUnrTsJ
	 vTR+2xxzZQKCX9tDDf11eygThjC1pcZepzqs8tOw=
Date: Fri, 10 Apr 2026 18:48:09 +0200
Subject: [PATCH 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add fan cooling
 to thermal zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-add-thermal-t7-vim4-v1-8-19f2b8da74d7@aliel.fr>
References: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
In-Reply-To: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1775839732; l=2874;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=zbgRfmKb31HDgkan9Fy8S+p1BOUmWfaoe9tmTB9hGac=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC2gP6l2ZGwBwfkdmnqHoopj7P0pXQieYHCsQz4S7Isj+ycLZJpj4jxyYI8NLM4ceXReP/Ntm/y
 vy0wj2kaYsQY=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Add an active trip at 50°C to all six thermal zones and map it to the
khadas_mcu fan controller, using cooling states 30 to 100.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 5d7f5390f3a66..ba9219073dd0a 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -157,6 +157,74 @@ wifi32k: wifi32k {
 	};
 };
 
+&a53_thermal {
+	trips {
+		a53_active: a53-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&a53_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
+&a73_thermal {
+	trips {
+		a73_active: a73-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&a73_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
+&gpu_thermal {
+	trips {
+		gpu_active: gpu-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&gpu_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
+&hevc_thermal {
+	trips {
+		hevc_active: hevc-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&hevc_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
 &i2c_m_ao_a {
 	status = "okay";
 	pinctrl-0 = <&i2c0_ao_d_pins>;
@@ -170,6 +238,23 @@ khadas_mcu: system-controller@18 {
 	};
 };
 
+&nna_thermal {
+	trips {
+		nna_active: nna-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&nna_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_pins>;
@@ -266,3 +351,20 @@ &uart_a {
 	clocks = <&xtal>, <&xtal>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
+
+&vpu_thermal {
+	trips {
+		vpu_active: vpu-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&vpu_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};

-- 
2.49.0

