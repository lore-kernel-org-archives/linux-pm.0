Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA544064F
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511481; cv=none; b=GZ9vWX+5ghAFID9urZc5UKYZJtWgVmGtEdBiQmEENgFzyywCM/B8TTEJz4zE6o5jjZnyChHD3du9EKSz0Sti3Qr7Iwx2O8Wk7ZTV1jDz7vmcc90baKqjb6kFV4cSgI+/WbNG7TbPi/+Lo2xpPSbLbYnOgydm8fKWQFCiHnyCZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511481; c=relaxed/simple;
	bh=CRlSobqjLvG/xHwYpbxmBUCf/wNp/RdtxeWAo9rwuVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phtONPkj/sH0PFaYBXJtY3Vol7CM3Jn1S9c63YUfWI5JjK9gktsMm5CC2E+vjXdcrEebm+SCKBUPkYNt0HUJx6St8s/waCQUt1K2eC0yXZg6yze+CKChFhtNO2c7bqDpqS3UyIVam6fUMAvfAXUkWdUY5ht1e9LiRCZirF4hYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ejcto05J; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejcto05J"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc149372c14so498421a12.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788511479; x=1789116279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+z8Cwnd44tBSJzkmGNNNosSpCrM38d+qGnlF9iz0lg=;
        b=ejcto05Jmgp+knRk6VbQ1zifZbTGFi+36PBgB0fQ/sIRv/SxqN5feAPCkr7BE160eI
         aQKgQxbNj2BigmsBmubn1e+zLpFKbAW6dStb8cVXCVSx34dHPscdzcwlInRWM33fFtmt
         KP/n2PRb0JTP28N17kcFaTv17F1xtcMGBe5W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511479; x=1789116279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+z8Cwnd44tBSJzkmGNNNosSpCrM38d+qGnlF9iz0lg=;
        b=PQzC63K+0LLkRdYJWJPtY0Z4or7qFMkeFVlYpoLNcidACFI37dUxnjfGcqS75rNH23
         HzenbcuuFAtN0uUWAA4wgxwQUL6bbmeoBsroEdr7N1ZHVbM34Wp5GrujXhnkeQ14B/oW
         4WkFpjLw7MJ+2SwYPWV3EpEmdxar1K4R7KR8TPJ4kKo7KlDO36eRcuRyJHfWYHLzQM72
         BREZqKaonBsWTjfx8gTsWQMdeNHJheLBi6gGsQXdhNImk4iaNS2BpLvqaqleo+asEgFz
         CmK5K/hKxJ2Gs0wmigswgPBbSqNsXdvDcU5yvIHE2TR4+seVQtOPv30C3BPH2NEB1l19
         BzXg==
X-Forwarded-Encrypted: i=1; AKwUvByL1FXDLRGETtTG/KjBGxf80D/zfvrsBcxpwBMl/V66WgiTbyfi7ykYbWii04MjSeJJUF+x0ll5rg==@vger.kernel.org
X-Gm-Message-State: AFuF++kVGhybY+1ion2WOHHzrm9NpFF7xAmkGN6146a6luiGOe0n+gvq
	shhNFohi6Ei66Ys239ZpprEuLOG2+cnmU+GhTMZ66zcIJQQ7QZSxiiVxb7RYkmrYsQ==
X-Gm-Gg: AYBFou0B8aK913xwzXjrQsp+pKn0wdblbkennbrh1AB5ntFjmayNJ4GsN1/Vhlynrpi
	MXDfI1/p5eZR5QtRkI8roEgSFK4KuBO4KoLrjFIK/gGtf3ftRVHzw5mtHYJT0p0y06uDIcWOXzm
	AbcbVErygCmPTGkCRPvFVLNk1YBVFaye5aNN8vfH+o8HCOVO0Zu5ZqAFqnN14+dsoJpdi0aggKI
	D7N3uuUuiT1njQcnQJcbLOMVq/MrJyCYIWYBmgRSJP898yznQwdaaCLLPqBfJlSahcH5q5Dxg69
	60/eOYA5M05FbaKTNp+iVLP/zYfMgof/5VeZY2RfOviM1ei69em5juE3b/pWfjFzPMWXVPQSWdY
	nui+zoEYp0+SSat80WbqUJk+3sk9qrtnXhsZazEBBBlfFvQA4FoYW1N2eMWvEKW4ZPBwjVVCtS2
	3EOmkXVN5X0wEqgKUOWJmJYEyRfsdoDa9U0YPXof4N9TJPITAQImTrX/qDZ2Ea3qMs5BeSvzSj7
	50JTktzrQd1PdKtpK98g7uh96xzZ9gaJZpaQlw58hzj
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39b26272f04mr6897920a91.14.1788511478517;
        Fri, 04 Sep 2026 01:44:38 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:343:bf21:3095:9c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm3343538a91.9.2026.09.04.01.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:44:38 -0700 (PDT)
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
Cc: Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH v8 15/16] arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
Date: Fri,  4 Sep 2026 16:41:54 +0800
Message-ID: <20260904084158.1341550-16-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260904084158.1341550-1-wenst@chromium.org>
References: <20260904084158.1341550-1-wenst@chromium.org>
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
index ef7afc436aef..8d4cc30d91e4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -266,6 +266,47 @@ tboard_thermistor2: thermal-sensor-t2 {
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
@@ -791,14 +832,14 @@ pcie@0 {
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
@@ -1085,6 +1126,13 @@ pins-bus {
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
@@ -1637,9 +1685,24 @@ &xhci2 {
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
2.55.0.979.g7e5102b832-goog

