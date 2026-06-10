Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423F3DB323
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080947; cv=none; b=b6tGbQbnWItCzxSDHF25iQCaP0rKaS1h0k6ASzNMRi9xszMdLflDs1BAOrBT2C2lVakQwewVU9IPHPv3rTWH71PbVUSk/+0rZZKsNw0MdKLUbSHOE9at4KGtC6Fji33+AeJ4/FvEmneFQ2m+uKh/VJewfkqk3ZM1kye6khI/ydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080947; c=relaxed/simple;
	bh=zHVdhMq+rKWWCXxeqfGAmNE6GxjdX0TW1LENd5DAyAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THVAcWYalnlPH5hSh5kRolzWGD6wLwETVhYG8ncNiT8NCubrlJplB4wR+Kkru2XScuSNePYaAvPOYEpH7ZTK7FpdwCy3g0Tcj27BlP2o3CLYEqxkdgwUg01jF69aMzoRuoDuEBKwWvotlMq9BQdLAhFqk3We7D9V9IYykwEP5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NkUiCPf2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NkUiCPf2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso44743935ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080945; x=1781685745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvuoLRCQSovwiopZEvbdmvmPWRVQtE1B+7b6jjVlfrA=;
        b=NkUiCPf2sINRL09ygukL+F7oiwQI8yGwlyiJqZJSjA1HFciJ2zix19qQGcmBT6LPbN
         pUv13Sh6NAM8CXQzjPp58sWgoGcgmFeat6zQhEYlfdiVyIX2R8P1frZK/mwNh6A2usX0
         SR5/4uROp0oJCyA5b6ikIQU5jB5SdlhpG2sks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080945; x=1781685745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvuoLRCQSovwiopZEvbdmvmPWRVQtE1B+7b6jjVlfrA=;
        b=ewuuTXUkU39raHVhRdsGpcX9B28est9Boh7QmU1xJG6uuk/QT1c+vCF4+/DEnvMbxv
         SBjcmahDuHzV05QOeZ87qg6H3kzOlf3dtgQJ1AfaddGrJ2ci0jZTNhJaRp1zPigIcHuF
         ldaS/6KO1aozK6TeIvzNBcBl7+50HjpJT91QUMBh6RU0/pLq6Bp5YIC2Io3TtkVjf7Kg
         csHE9FE2xK+xSDoeN6RnIXi/ONduxNJy6XNNgGnibgT0n6Yhv5LFbliAOKItEbnL+22p
         i+ZI+8ejWyscS+S71FNbE29LsJbeD4h0+JAkZei1hRVWD2Xitqs4PxRG93WC0J7Ji6wo
         Cywg==
X-Forwarded-Encrypted: i=1; AFNElJ/xHhFHqURF9yNPRvKbHF+4zK3PyW++nIK7esFaD4zfhDcwrpfGxumm53JCrp1jmcYJeIYh41gmEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcr3WunIc6VmOS6vNeHCcpMaV1ZCYYvAJS8H3s5PkkcXKILAnV
	uuKb9kJ+ONefQyfptmBPoKmEkrJDno/C8Oz4IRnZdUpRzaKlRioaXye/7p+5I+dkxg==
X-Gm-Gg: Acq92OGlgaorZdu1lDmu99nR4ZLHvWTRlGn7tab6w4Kw5le7pemzb70VIf2YsqtlZCG
	Mirx33wRe9vyS6j8x7dw+gLUmudwsblU8l5mpWbEaUG4mnh67HZWJXdH1Qb63KU1mho9h0QtrO4
	Zf3+VAZBl+oYieofrbXyaLS+BPsChgO3lDYVvkjBSSXtfjIrNdop5M9kcuz2Cxao3jw9tyICqcM
	VdlPK5/Dn23PILH9/SDYvUGzRtIs577tc7r63e0h4ZocxzmH3cTR0KjVFoSeje64sUMolaIdi9m
	mnwM+4FE2z273lKD4UE6LYnLjIZ2L/fM2OAUREZLypXaCQk9f5xXFVK6WiSe+JWAGz3jcsImPOu
	hnV767DN6n+nYUE2YtaGokXc1bhkKFqIBq1EtVp+cOFWsATmJeNNtOsR52MtLIPa9/PeCut/k7o
	E1B7z457WoLEF0yooXtvKE7f4svyVVG8Q2if6MMgPttjpnUN+QhKNEtnqUfYHmSiK6tM+Hd13XO
	7hjGzo3ZeWpfITltA==
X-Received: by 2002:a17:902:f543:b0:2c2:27be:39a3 with SMTP id d9443c01a7336-2c227be3b4fmr207662865ad.29.1781080945255;
        Wed, 10 Jun 2026 01:42:25 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 15/16] arm64: dts: mediatek: mt8195-cherry: Add USB type-A connector
Date: Wed, 10 Jun 2026 16:40:49 +0800
Message-ID: <20260610084053.2059858-16-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8195 Cherry design features a USB type-A connector for external
devices.

Add a proper representation for it with a node for the connector and
OF graph connection to the USB hub behind it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 73 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index c95a54de3567..8a21a8b996df 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -153,7 +153,6 @@ usb_vbus: regulator-5v0-usb-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb-vbus";
 		enable-active-high;
-		regulator-always-on;
 		vin-supply = <&pp5000_s5>;
 	};
 
@@ -267,6 +266,32 @@ tboard_thermistor2: thermal-sensor-t2 {
 						125000 44>;
 	};
 
+	usb-a-connector {
+		compatible = "usb-a-connector";
+		vbus-supply = <&usb_vbus>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				usb_a_u2_ep: endpoint {
+					remote-endpoint = <&usb2_hub_p3_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				usb_a_u3_ep: endpoint {
+					remote-endpoint = <&usb3_hub_p3_ep>;
+				};
+			};
+		};
+	};
+
 	wifi-bt-connector {
 		compatible = "pcie-m2-e-connector";
 		pinctrl-names = "default";
@@ -1672,13 +1697,55 @@ vdosys1_ep_ext: endpoint@1 {
 
 &xhci0 {
 	rx-fifo-depth = <3072>;
-	vbus-supply = <&usb_vbus>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
+
+	usb3_hub: usb-hub@1 {
+		compatible = "usb5e3,620";
+		reg = <1>;
+		reset-gpios = <&pio 84 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp5000_s5>;
+		peer-hub = <&usb2_hub>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@3 {
+				reg = <3>;
+
+				usb3_hub_p3_ep: endpoint {
+					remote-endpoint = <&usb_a_u3_ep>;
+				};
+			};
+		};
+	};
+
+	usb2_hub: usb-hub@2 {
+		compatible = "usb5e3,610";
+		reg = <2>;
+		reset-gpios = <&pio 84 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp5000_s5>;
+		peer-hub = <&usb3_hub>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@3 {
+				reg = <3>;
+
+				usb2_hub_p3_ep: endpoint {
+					remote-endpoint = <&usb_a_u2_ep>;
+				};
+			};
+		};
+	};
 };
 
 &xhci2 {
-	vbus-supply = <&usb_vbus>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
 };
-- 
2.54.0.1099.g489fc7bff1-goog

