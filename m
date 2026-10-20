Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517908;
	b=otNPm60RE9y8Z/YevtuueCJEd2fX+34jZ1CoTqUUdJnY7ws0aRaoEXiOaMW9HcjYDCLv
	 EoeaupR5ifpdvqIqztMFFgNnVB+7H8H8K8GJJWbfY2VAAcNjZS6vCxvfAVhW/DKOhJaxb
	 IolZ7MBJQ8ec1pUhWWNnIa01eM74mWXHjgh5cKm/gkOfha+23/oNutJXi6Ub1YdjAevr3
	 5B/WoR7QykFMsgvW6re6PyaWEUkby1xVaQx1syNU3HpFExZJFu5NcivmKIHOoI9CogMFs
	 GH5zUMgy5tpBgBjsknAHml5XdiduJvOdNRMmt6F+gWL9hiCt/XIIyIn83FODesOT+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ocwe/ua5bx6fTunJTjbDvG/Rp4d0BH8Fbx4UwIDjj0c=;
	b=3jkbeffFnsLZnQh6i+wzGHg+pFA1USyuuylZL/nfDvzycssJzGqCO7vo6+3plmjAlTzO
	 5MKku7VUr/EzSt75C7lJC48d8U6GubStO/PL854Zm69/byjdNF5awnCyHeE4/OPXy5jFt
	 DbNznp2hfnwI/RrwsHp27ZVohQYN9VWIWjQjGf8S1Pemhr6xLOPb+DTLRFAVnxFaIRv+S
	 IRJtZFp7qijNad1UkC0JWBrGMUdVL7vNWJLZ3ckEoSduLAZ1fRlzeAQN79tpcIECzcJPS
	 A7PIDcR4wN6uI2tYY9uC6O5KleEIOu5Vy6TT5F/BAr+ns88p+X6FmbPP4OkGENsGKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dzAHyTZH;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965C606A31B
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 17:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A965C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dzAHyTZH
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so26767185e9.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517906; x=1793122706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ocwe/ua5bx6fTunJTjbDvG/Rp4d0BH8Fbx4UwIDjj0c=;
        b=dzAHyTZH9KmnxvGzkLc4TBzZjYNmxyPET44e+8vYaLd50Da7xftyEBJXCp2EHpaxbi
         z+Ej7Tgure6ZjFr2dDhPYnLS7QB8nkMLWeWbG3+59ZWM0U4w2hKBQl5MNxqCfkaAD4la
         /dpeIPdlxbihyX5869qjfcaeU9uu8+TKSFeBDhsE6qtyZthuHCSloUyz9P87+scC14EU
         UyKmmyP4ysDTcoc39eSm6y9KQZ1sPyX6IvNU+OcrSrBEN1FfY2wSExF0Zev/PlERviHE
         G59yDW09gmU+hJ0yyIyPrCjlTEqZy5PR1LmFU7PXwSV+coISIv93hAyx0a2Yx/f2AmkJ
         mPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517906; x=1793122706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ocwe/ua5bx6fTunJTjbDvG/Rp4d0BH8Fbx4UwIDjj0c=;
        b=rUUO698jx87+wkx7/gx5wVuq2X/j9VEYAAPRQlXlgb9P3fCv2DzV/4Pl3cE/9AyELq
         dFUxVJq/cD2pCQzWSJJmMfpaSYBexwgYZlqnYhNwvmkQNCiELfn+/6NZs9tMGjzR/NMM
         z5+DK2RCSvQMVtvckgXIC6AZHNvBu09Sqz46x7+GuPdszuTpbHDGSrIm0XViZEyM5Juj
         AcFFgwlvuguWb930TQoc9ZnPsezOPl1VMIh9GtI4Qo097ibBs0HeubqfBf39p7j3jUIb
         tnpFidimBUk0rPZYfaNn8Bo274ct0cm++/BIzjTQqgPBL60tuc7Sfm7UbAd8RAlCgwhy
         SveA==
X-Forwarded-Encrypted: i=1; AKwUvBy4ty7pLsdI9NsrmzP1xvos/3IBsER0Q/DCJ6mEmIUaW1StpXGrHPCUZsmgk+DV++L6arJiiR3SnQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJDoa+RO7CVlmzXnaor1r20h2NfOT//Iah4fOkoJcqaltNh9dk9
	tJe/3lBVuy1mpDQNXmTTc9YA8kd8GeLGGH9XtZi0PT45o2POZcY9QRhS
X-Gm-Gg: AYBFou2az/SZ8QlRwtXNvoxRpYVwICIgtYPqEiL0oWsTvtrjhQj4TreXlRRHGaE2PdB
	6rGEApqsMYvyM2HFHQ5WPCOIQ68fPA8bRqSaxOS2NEQdqJcf/NppDBtL80vOL3g0vLHZYr+HOHL
	ftKWlj6IWYOLl10+65LLFbl8P5VtVDFbniJE0lHpec94hrkO4WqwkUA/kBiPxSCZYTZ+iv2zMpB
	RFPKQu9ref56Jk6HSBiNwb5DWlGFBpcd+euB1WhhwtWy7CKTlJpswDB+Rrl+hY+Y1P+7PcIzKQn
	dnS0+5CJ9hcWeTtMzuIu3JbeC6qGct4R0gCWJXJ4s8uPK8OGonb7wUN8CiacN0Do43+uqH5vKPq
	B9uSA/KjYUr2x0UfvdzHY/nYSpYt35v+qJbZpPYoV2rwFNZgaK9P9iI6j8x3j0gpzW2asTsD9ZU
	1R6LL3Mks7vwLjfm1EfK7RmXUkpSu4Wmz1PRV4i9sOsS+hZk7AikqI8371a2eYsHjEIg==
X-Received: by 2002:a05:600c:3b1e:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a1d75f9341mr271641575e9.12.1792517906016;
        Tue, 20 Oct 2026 10:38:26 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:38:25 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH RESEND v10 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Tue, 20 Oct 2026 19:33:30 +0200
Message-ID: <20261020173556.632798-10-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add the dtsi to be included by all boards using the MT6392 PMIC,
providing support for regulator, keys, pinctrl and RTC.

Import the new file in the shared device tree for the Pumpkin boards.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++++++++++++++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
 2 files changed, 152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..cc4770d70246
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2024 Val Packett <val@packett.cool>
+ * Copyright (c) 2026 Luca Leonardo Scorcia <l.scorcia@gmail.com>
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/regulator/mediatek,mt6392-regulator.h>
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6392";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mt6392keys: keys {
+			compatible = "mediatek,mt6392-keys";
+
+			key-power {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-home {
+				linux,keycodes = <KEY_HOME>;
+				wakeup-source;
+			};
+		};
+
+		mt6392pio: pinctrl {
+			compatible = "mediatek,mt6392-pinctrl";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		mt6392regulators: regulators {
+			compatible = "mediatek,mt6392-regulator";
+
+			/* Fixed supply defined in the data sheet */
+			avddldo-supply = <&mt6392_vsys_reg>;
+
+			mt6392_vcore_reg: vcore {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_BUCK_MODE_FORCE_PWM>;
+			};
+			mt6392_vproc_reg: vproc {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_BUCK_MODE_FORCE_PWM>;
+			};
+			mt6392_vsys_reg: vsys {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_BUCK_MODE_FORCE_PWM>;
+			};
+			mt6392_vaud28_reg: vaud28 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vxo22_reg: vxo22 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vaud22_reg: vaud22 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vadc18_reg: vadc18 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcama_reg: vcama { };
+			mt6392_vcn35_reg: vcn35 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vio28_reg: vio28 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vusb_reg: vusb {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vmc_reg: vmc {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vmch_reg: vmch {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vemc3v3_reg: vemc3v3 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcamaf_reg: vcamaf {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vgp1_reg: vgp1 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vgp2_reg: vgp2 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vefuse_reg: vefuse {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vm25_reg: vm25 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vdig18_reg: vdig18 { };
+			mt6392_vm_reg: vm {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vio18_reg: vio18 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcn18_reg: vcn18 {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcamd_reg: vcamd {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vcamio_reg: vcamio {
+				regulator-allowed-modes = <MT6392_REGULATOR_MODE_NORMAL
+							   MT6392_LDO_MODE_LP>;
+			};
+			mt6392_vrtc_reg: vrtc { };
+		};
+
+		mt6392rtc: rtc {
+			compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 805fb82138a8..b19d5792bd89 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -6,6 +6,8 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+#include "mt6392.dtsi"
+
 / {
 	aliases {
 		serial0 = &uart0;
@@ -160,6 +162,11 @@ &i2c2 {
 	status = "okay";
 };
 
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0

