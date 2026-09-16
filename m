Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D446AA8F
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545599; cv=none; b=r8GEbEBftE7LxldP2NqmATPJ0P4Uadugh5y6FUAv0NjS+YGXljT5J3soj1qsPm20bAJiI9N08ifbJae98qftvBnlnndz94zABkuCQYdW1O9HIYH/nP+pwp/BvWDKO+odImTmMvqelV/oLFMfQJg3X/BesZKLjwaDCfOMk7aSjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545599; c=relaxed/simple;
	bh=gM8tPRMx33Qx0BJjFPOzM7No2FKd/oVjiOutbBIFOqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHR6zPSE8bMUwRsp/tLSGejCObd36A64U7DEh2OtuO0C/MXBMTn00EIqsNvAXq1W3MjY5Bw+PusKLxKZhgitbYDCvxydbMsi1/yWUr4qdLEQb3Jsst5/yzRih9OiCtCO6bb0nrOh3bqUmklFGz3q5fssbe8kmdUOz65UXRU4/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jdg7GW8C; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jdg7GW8C"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so2012814a91.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545576; x=1790150376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PYR5maRbUEPUYHaCDp1coaVQzS9XJQmry5uta3mhbEE=;
        b=jdg7GW8C1HHcNqR7aJd+x91iUTOLTL7Happ2lazp2b7ruVjlH7ScUU0ArKUwp0LXFU
         wRgvKrHC8NVrxJzF1Ag6XfzZN6HnbPO9Wsozn7hnxgChR/hXqispWTs3/0HIo2hCKDeo
         DJtRtuSixpbhyxM+rEX1IOndzpapMamJGrttA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545576; x=1790150376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PYR5maRbUEPUYHaCDp1coaVQzS9XJQmry5uta3mhbEE=;
        b=IMR34NyhqNzriG1SB8lFWQbnyYnIBQONqgn3Hswfay56relg9cajyqHsfBKYHju8Ud
         QH46wAQAwsh2j8XB5oi7FgtldM6tJ56+uZLkUVPJic4WVVydFz+bfx9O30VyIc6HTwkx
         Vsx6PpA4nDdg2sG96LFeVg4t3EioZXbSlKtOeajf2f4PHJF6UDtd8JL3F1MKO0rNKNlV
         /lHPR66UKTWyp1/8bvAUVjl3fZWiiLx/v4t3nLctLe8jh2Boe1M1oTW09iL4BP/gjHwO
         wPZ6U0SJr3Zt3DdSN9fe9SA/h2kLjphlaicWZuCKSgrGBEMkiXGGt1G9kPMlnvHSCalV
         B3xw==
X-Forwarded-Encrypted: i=1; AKwUvBxHqi6iYZpm7/dwkZeD3/4C9DhqpJ8NuZirGAJ6SAWYhbOM3SWO+haK7zoLbYvZKAxnLvcaQ5lNcA==@vger.kernel.org
X-Gm-Message-State: AFuF++ml41KPEbfsyffEv22qR5hdEhW0DQ+sKrtRjHZNqH2gWKCqlPok
	6/x4pUZqouITAIwZEtXg81f57f+KiWphhpSx6t8hR1l/Fv96KaI+8X5E/M6AS6smIA==
X-Gm-Gg: AYBFou1loUBmg6lo5VxMwIop+PwSWln1xXw7NWuKd1HBF/1Auj5DJCMlphgnl0JbPu1
	rQGwab5xm59g29OJ607Zpc2v5plHgrOgXLsi0vQg7TyECXNBX8T4S4VqKODIM3Y9FcpfPii88o+
	/zQbPAtHXLN/vaPBwZ/Ilnzu+aDrTVdeKFTm5iG6S2VE+lpsGJLrx1xjPrb6wMQjnIHnW3Qj4UE
	eSwIB/8xHDUtUuyc7bRQHNUvo9VAf7C5iPqRRrCk4HnbTK56AUELOJO3c6xhKsm73nX59OITpLo
	4d0RXp+eIiyvVZIYWQannC7wbDHMAqm3uGuwlUsqlUuAlw9N90wPmJvDg5OFcehR6WsekcClZsi
	zC6N1TZJXRfwMsa1YPGNJPTIWaTDW4D6mtdhoiKlvc3Xe+Bhy81scK/HnW7mfj0HAV9vgjnrA/+
	m4EYU9iebkc1DX6qQ+Xl9AfXbfFUqCRrCFwbJPDDwnfwCcqsa6gEVbmdIDhNFLHF1IZ/twivhZT
	dXxr93FAHpP1z9tdiQPLWufiMraA4gH7Rx3cJt7htv/C3zycHkz7ank/ocU+C5tpnLx
X-Received: by 2002:a17:90b:3c08:b0:39e:fe9:c5b8 with SMTP id 98e67ed59e1d1-39e0fe9c653mr6440889a91.10.1789545575967;
        Wed, 16 Sep 2026 00:59:35 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:35 -0700 (PDT)
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
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v9 14/15] arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
Date: Wed, 16 Sep 2026 15:57:40 +0800
Message-ID: <20260916075745.3549953-15-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916075745.3549953-1-wenst@chromium.org>
References: <20260916075745.3549953-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mt8195 Cherry design features an M.2 E-key slot for WiFi/BT combo
cards. Only PCIe and USB are wired from the SoC to the slot, along with
some auxiliary signals.

Add the proper representation for it, replacing the PCIe wifi node and
vpcie3v3-supply property under the PCIe controller, and the vbus-supply
property under the xhci3 node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Drop default GPIO output state from kill pins pinconfig
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 73 +++++++++++++++++--
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index f06ca2bc165d..5d65f4554c6e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -271,6 +271,47 @@ tboard_thermistor2: thermal-sensor-t2 {
 						120000 51
 						125000 44>;
 	};
+
+	wifi-bt-connector {
+		compatible = "pcie-m2-e-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_e_key_kill_pins>;
+		vpcie3v3-supply = <&pp3300_wlan>;
+		w-disable1-gpios = <&pio 61 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&pio 59 GPIO_ACTIVE_LOW>;
+		/* PCIe auxiliary signals wired to controller. */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PCIe for WiFi */
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				wifi_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie1_ep>;
+				};
+			};
+
+			/* USB for Bluetooth */
+			port@2 {
+				reg = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				bt_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&usb3_ep>;
+				};
+			};
+
+			/* SDIO, UART and I2S not implemented */
+		};
+	};
 };
 
 &adsp {
@@ -796,14 +837,14 @@ pcie@0 {
 		reg = <0 0 0 0 0>;
 		device_type = "pci";
 		num-lanes = <1>;
-		vpcie3v3-supply = <&pp3300_wlan>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
 
-		wifi@0 {
-			reg = <0 0 0 0 0>;
-			wakeup-source;
+		port {
+			pcie1_ep: endpoint {
+				remote-endpoint = <&wifi_ep>;
+			};
 		};
 	};
 };
@@ -1090,6 +1131,13 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO61__FUNC_GPIO61>,
+				 <PINMUX_GPIO59__FUNC_GPIO59>;
+		};
+	};
+
 	mmc0_pins_default: mmc0-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
@@ -1642,9 +1690,24 @@ &xhci2 {
 &xhci3 {
 	/* MT7921's USB Bluetooth has issues with USB2 LPM */
 	usb2-lpm-disable;
-	vbus-supply = <&pp3300_wlan>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb3_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&bt_ep>;
+			};
+		};
+	};
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.55.0.1032.g73a4cd73de-goog

