Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEB4A5ECA
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377789; cv=none; b=kXBjK2t7NWEHRox9b4R+0TDwfhTW6JurLdoRE/hwy83dWtjjrsoUhGFZK7IK9+zmT6U6D8yCxlHSf9NEw5ZMgoGOxIWD74qPMR6LOVBiJiDAxIqiW65QdKJpW3AC3iKYbOG6GQbe97Fr0yIQ1s3hBes8GOCOQBkNPvR/lfmq5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377789; c=relaxed/simple;
	bh=6mU+rkd6x5CiFPfsOHOsBRBAd3bkLMfW6WBBQJm5CH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoMDx5ZBE95l1gcODH7ZMFtXAg49bac1cH7+7VubtvSng67mzTfHXdhkNFFgChjsH+sPz7OhY3uuSOHT6vtVQwYgwtl+e2ZML91H3TC7dL5vb8Kq2SA0XGgq04y64qe517RZGCIWv0lZoBLmKVgucz1cZhNOh7ND4+Iat7eLPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBUTTQfW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBUTTQfW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48441fa5c37so1056494f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377773; x=1788982573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFxjyshR5Gj0Fri/Nz5n1/KkLMrahfjaF4DTCzQtdSA=;
        b=QBUTTQfWgc3IXDOvInuc0RNWC5lmpFCtC/hFgMmGf71gZocvkV59oigVx/y7zCPgms
         XTQP9ELGVMYkmcSfzZchimDvAtNr+6cbntlHoqqPxT9FXvBelnYWeHbr4VSCgQLuvBcA
         3HJe1yBQJkfKp46fOu0w6fNeKxAmwPO1ZHnJ91XgXbtgYFCj863KWx9EUph72YVdDzv+
         Lm2u6tT8F/qBtNOXQzevNSEJSbLjbvaTw0uFpI9TW12GdB2cztFvapkLAg+9YQb324+Y
         zfbqBdOnCfD7cmyUiJTroB0yiX2okLVQIy88rhLe3zzUQkNKit5vP6iTS51dbZJiH8a2
         4WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377773; x=1788982573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFxjyshR5Gj0Fri/Nz5n1/KkLMrahfjaF4DTCzQtdSA=;
        b=LdUSRJzQRWQ8+7sHMzX7sNB+RmKDNj2r9P8cwGFs1gUJcpvo5rUYyeg71BTFHgNmJs
         YrgQ21Hlgfhjt4VqpQxzCqpjpJheCiOChskIOsGQH6nTeIxUCeM2uKDM6dRTA+Nl5rfT
         JiZfwAArNRe1UQnsQL86E6M3ebp2LVM+ZfqFiQ1xaFV3qYsrIt+o7df7Kbq30cWVeOYr
         0J4X+bIxTChuYQhKMvWuCmrlq39etA9gLZn5TzLEzkO5kRvPwKn92yAnstRM+7XW1gBA
         Un0BYqa/n9nSSFJmdyPqvFrP9XTEZiF6y7a3FEl0yy2WVpziF8+iW7daBkTfDpGKgPss
         AfiQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7m7ZRALoAeDePJzg9Pv99xOjZaw5Pln29KDbGW1WvHDjFReM2nDPl/PcLLoARLbIbGzgCW2DHwQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mAPOPP4ejlcDliGmmiMd4JxYO0dOMMI0ophxqm4J/2riIPs4RB
	v89sOPTT3ph4BcdY1FJ0o1ihUa+n8/xEYsLhN8l2GW67kC25NzLyGtRx
X-Gm-Gg: AYBFou3MW+iEO6ZeJXkFp8HVNZTZByV+8u+Ou0NG5aX8Bz0qcvqtiiIrNKUFf8uTzsj
	v5HMhrTcxqPjou47wjEfBjhOLTCfNYseLDVWRnv3Cj00tdJb8MwfCm73Pfx9JVE3I7Nu7wV/BN8
	syNI/Dssk0QwiAMeoXUQSRKD+Rwsqqw638D3n9qQDEySv+jKx8AEaoEPGrJISgYcCEfqGoudngv
	1nWbdQknKyCdu9bOZPnUQ5m1f2vCT5wHVZ+8ODCkHzOrSaeGukLvDUqQLQo4JseDF1NboRC2inn
	3++Anst/Ajt+SruzCanB1udJ3DK8TtjMiOF5rpOtXKrKJ87Vkal5qZU/CRrHtp5USyn8tdy/e7s
	rYpTMqLZY8j8danP6H8xvn3fA7b8WAiLg4l17IWqxPO/PE6bJ8Kt2oNY9tl9xRjpstbRmKnBBnq
	o3DcBGQKk4m25p9gWiywE+lHP5vffi0l+3s1b89Tw6JCLf+rUhi2+I6JMdug==
X-Received: by 2002:a5d:5f8a:0:b0:480:c5:d635 with SMTP id ffacd0b85a97d-4847b6295e6mr14936972f8f.0.1788377773399;
        Wed, 02 Sep 2026 12:36:13 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:36:13 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
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
Subject: [PATCH v10 9/9] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Wed,  2 Sep 2026 21:25:45 +0200
Message-ID: <20260902193351.185771-10-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add the dtsi to be included by all boards using the MT6392 PMIC,
providing support for regulator, keys, pinctrl and RTC.

Import the new file in the shared device tree for the Pumpkin boards.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
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

