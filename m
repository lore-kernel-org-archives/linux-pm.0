Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE216441049
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835772; cv=none; b=csCJrrGj+84ggchyq6GHsfZDzj86ASmx2XNC+j0Kpc2lGd+TK1o5pHVErNegId+mWm62qE/+tJarOgfvkwmPoIsvLy1FbvDhFoSrgkZqOye9tyUwCs4oMmZrjlBIkn3YPZAiD16su/MEoNJE/9yzg94+qVMrCR9KGCTuxtybMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835772; c=relaxed/simple;
	bh=hzmFuLfaZehJONSUg8nNmwN5xN2aJspRaBE7HbdGagQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQjvO/ARiARo9kfBeman4MXWlCyquemiT4W+VeVtStZnmatHv9U8ZI5ml4Rv/scxZN25txMURijjIRQ59PJyNGxrpJHo37cT5aG5sJ2IUa2T7LJ2Pgl4L8P1SGSVqz+pd9Vlc/9JLz3spwCLvbTgb9BN4ZdduyUsZCOGoB03PMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fpbM0JDu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fpbM0JDu"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-368977e33b1so3329617a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835769; x=1779440569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt4T5ObMyYagXPbowM8Wn1tRV9x+5vQ2cef3iU5ynik=;
        b=fpbM0JDuoHI1reJ6klWr2SLVRJe4FIi6JZOHStuaNlznIkJwajRajT0ocY1Q6F48V6
         CnuDOr5LT0NMQqVBkqUastLg5gXGbnML6k2FXxP/PGgCqTgWme+2zQe3k5P8v+YJXHIq
         k6up0xH7SzdepLAfaWrDzOlrTgJeNl4zSvqe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835769; x=1779440569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pt4T5ObMyYagXPbowM8Wn1tRV9x+5vQ2cef3iU5ynik=;
        b=sYYeil5CfB98XmqeBjTo4uw1k0sQIy5UCXwDPu/MXtHCukRcF5BcHmC8Vi8dk6hpW9
         TYL5Oyh8Qwi24NqpQuy823I/DY76MMv44xHn9ucls4IS4fNQLw3OQRyA+YU6PnQ6kvtC
         Z5Egdk1A+r5kWEsPw7D0/wHze10fRrHOYSxmFZNTsxR/l4jnIFqqQAqpTeM/l8RGLAzv
         GxXI+PTWvL6w/C6+H3z8h7kJ3qC2+SmcB/3FhzcbNF40J02yS6QJLTF9Ew+MfEp3l4Hb
         ZflrXcy4hkqLimOYsueKwRi15eXqepxoR0t2gCUCn/jB9NOVIQk3PXjUTqSIeF74OTMX
         +INQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ofdDCZqm8HDtAV2TNRrvraaiNGHu5UQD1JZDIGnMK7t9kmRg9kfDe7m/LRBOPpukMIsWY5MKG4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqh3SqKu3wWlnS/7E4sDFzPjue/NA1+O+baDHHPVuWs+lZVW4Y
	GT1bWU4qv4AUEiu5ksZgHkpZbIcZvAaqFiikieI5iSL8iEICNHbtIAycZELWec366w==
X-Gm-Gg: Acq92OEzCSz8yNmun7y3dJvoc7jh5WH+vE2lg+vR9AwUlMAlTSC/IL4sA8FdmK+655q
	OIqm8iuI6OZidI7hwPVVwhA7N0Z1FI74a8/eLZvVZDPC7Q6MwNOnIoCd2e4UEqGqCIZ1gKgzKzx
	lIGS6KWui0v5zIOaQ7h/g0kxk284VjGx/gCOidYUUEXpwBZ1ywHt5Xr+hPAf3oovIp1Bag0CWZR
	rWxYdfuf2PzroUIjGoDi9NjhBQp//aBQTpoUMTddXtiCfY93y5u8O/+AvNmnpMUUJJ+r90aGXle
	rvNfu8lcaoT+4gczoxOa7CqLLWmad0wGE6Se1h8cNL3Pf7YLUGSUbzTRUyFO7gFa7PtvVZu/nKS
	1uqQCPQv4TZkZYgNahG+51/yQBgsY97ihE8IVSehEh+Q0aji61AIMrKRtoNMXScnM6GRKqj7tGA
	QfYEsePpV9TVisc7QBc/TNPpect1ixBUSF4AXsFGQWTW1cOz+K70U04vkJNBKY5lhh5LDs6xbgJ
	P2CPjhD
X-Received: by 2002:a17:90b:1344:b0:366:4782:138c with SMTP id 98e67ed59e1d1-36951b971ccmr3221579a91.17.1778835768758;
        Fri, 15 May 2026 02:02:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:48 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH RFC 12/12] arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot
Date: Fri, 15 May 2026 17:01:48 +0800
Message-ID: <20260515090149.3169406-13-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515090149.3169406-1-wenst@chromium.org>
References: <20260515090149.3169406-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8188 Geralt design features a chip-on-board WiFi/BT solution. This
is a M.2 E-key WiFi/BT board layout directly inserted into the mainboard
design. The connections to the rest of the board are almost the same as
if it were a separate M.2 card. The only addition is the PMU_EN pin on
the chip; on M.2 cards this would be tied to the primary power source.

Model the chip-on-board WiFi/BT solution as a M.2 E-key slot with PCIe,
USB and auxiliary signals. The PMU_EN pin, which enables the internal
power controls and regulators, is modeled as a regulator fed by the
pp3300_wlan regulator. Since power sequencing is now correctly modeled
using the M.2 E-key slot, drop the "regulator-always-on" property one
pp3300_wlan regulator. Also drop the comment in xhci2 saying "MT7921's
power is controlled by PCIe".

Also drop the voltage range on the pp3300_wlan regulator. This
"regulator" is just a load switch and does not provide any regulation.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 93 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index 4cb23595d17b..d7b5eb95ba0f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -86,13 +86,11 @@ pp3300_z1: regulator-pp3300-z1 {
 	pp3300_wlan: regulator-pp3300-wlan {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_wlan";
-		regulator-always-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
 		enable-active-high;
 		gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&wlan_en>;
 		pinctrl-names = "default";
+		/* load switch */
 		vin-supply = <&pp3300_z1>;
 	};
 
@@ -159,6 +157,17 @@ ppvar_mipi_disp_avee: regulator-ppvar-mipi-disp-avee {
 		vin-supply = <&pp5000_z1>;
 	};
 
+	/* PMU_EN pin controls internal regulators and power sequence */
+	wlan_pmu: regulator-wlan-pmu {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-pmu";
+		enable-active-high;
+		gpio = <&pio 145 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&wlan_pmu_en>;
+		pinctrl-names = "default";
+		vin-supply = <&pp3300_wlan>;
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -193,6 +202,39 @@ adsp_dma_mem: memory@61000000 {
 			no-map;
 		};
 	};
+
+	wifi-bt-connector {
+		compatible = "pcie-m2-e-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_e_key_kill_pins>;
+		vpcie1v8-supply = <&mt6359_vcn18_ldo_reg>;
+		vpcie3v3-supply = <&wlan_pmu>;
+		w-disable1-gpios = <&pio 13 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&pio 14 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PCIe for WiFi */
+			port@0 {
+				reg = <0>;
+
+				wifi_ep: endpoint {
+					remote-endpoint = <&pcie_ep>;
+				};
+			};
+
+			/* USB for Bluetooth */
+			port@2 {
+				reg = <2>;
+
+				bt_ep: endpoint {
+					remote-endpoint = <&usb2_ep>;
+				};
+			};
+		};
+	};
 };
 
 &adsp {
@@ -656,6 +698,22 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
 	status = "okay";
+
+	pcie@0 {
+		compatible = "pciclass,0604";
+		reg = <0 0 0 0 0>;
+		device_type = "pci";
+		num-lanes = <1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		port {
+			pcie_ep: endpoint {
+				remote-endpoint = <&wifi_ep>;
+			};
+		};
+	};
 };
 
 &pciephy {
@@ -999,6 +1057,14 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO13__FUNC_B_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_B_GPIO14>;
+			output-high;
+		};
+	};
+
 	mipi_disp_avdd_en: mipi-disp-avdd-en-pins {
 		pins-en-ppvar-mipi-disp {
 			pinmux = <PINMUX_GPIO3__FUNC_B_GPIO3>;
@@ -1163,6 +1229,13 @@ pins-bus {
 		};
 	};
 
+	wlan_pmu_en: wlan-pmu-en-pins {
+		pins-wlan-pmu-en {
+			pinmux = <PINMUX_GPIO145__FUNC_B_GPIO145>;
+			output-low;
+		};
+	};
+
 	wlan_en: wlan-en-pins {
 		pins-en-pp3300-wlan {
 			pinmux = <PINMUX_GPIO12__FUNC_B_GPIO12>;
@@ -1342,10 +1415,22 @@ vdosys1_ep_ext: endpoint@1 {
 };
 
 &xhci2 {
-	/* no power supply since MT7921's power is controlled by PCIe */
 	/* MT7921's USB BT has issues with USB2 LPM */
 	usb2-lpm-disable;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			usb2_ep: endpoint {
+				remote-endpoint = <&bt_ep>;
+			};
+		};
+	};
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.54.0.563.g4f69b47b94-goog

