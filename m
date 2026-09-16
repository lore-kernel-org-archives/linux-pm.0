Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827045D182
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545598; cv=none; b=R+Q+Gh3DTJ11CS6W643FubAeaGPZX8/UaZYUtNcJvu79AtZ8CpEf9EnBIOr8MM6NqIrUknHhxnHJNIciQ6XQssvY5MrFRmBapH9iDuLttYOxqyYq4igT6nN3p9pxx/hK8chiTqYv7QycqUOBl+rcFY4zpXYIexsZ+BpQBTHmZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545598; c=relaxed/simple;
	bh=L2XN2l4t/z1NfZp3cK1qJqnXsY4CQFylN1pjRRHNQ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rw2D7Mo4UGKvToCcbWs5VHH5EzTjFrgiHmYCBXlE5cdQ08qZYeCKR/mMJZrC9k/oN0SVs7C1LVyLi183pcwD/6qh7H9pGYq8rycSSA0ayg7sy24rvxkV1oS99lwJbl3ke84eZUsRKzdJXrCFBJB1kfE9ym1vUhQCDOcGIuFWDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XBbTnAAz; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBbTnAAz"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso678179a91.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545581; x=1790150381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/vaPDanA3j6zkOBVwes5rnF9vpdWJpKDteNb10H5RQ=;
        b=XBbTnAAzXr3MB2b3V/R+MW39OWgoP6RHN/c+ZuwfEFcrxKPBln5w5BEqxEGFqCq4HF
         zHMZpHjed+KhCylaH+77qGohjFK2hwpeMgGls5ExnSvFiqtqc3N0c3d2WFpD0KGvi0gv
         g8qkJr/+G0m3WVGAVgRPP0d3UlonIVdOM+La0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545581; x=1790150381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/vaPDanA3j6zkOBVwes5rnF9vpdWJpKDteNb10H5RQ=;
        b=dFK6+FUSEFxLjmr3r3Y6QL31j0CKdCnxaEkI5T3iEBeBGpeowB2+g7PLc/GsSnWW7M
         VNoNGQO+MAOAlNrEnNTeI9XrFjrrME3TZb5SzCIKPtB3Pr7OjVnSMzY3dSkPrBGP7KAl
         etn1JYKdDEIgJ/kzZCK9BKGiFPMJc8e26GkIEjWQp8h2tnomVXsWqnqtqWCPZxBJhrQ0
         e7nsHN9t1v78GtMAOZWrKE8QphZa3/zBqmuXe1HoCVHtoGC5Rbz0tcNc0otpqvfKCSkB
         IWuwwKw2x24nWpLmYXCus3ZRoLf41znchwL2x6b5a5pkxJ5lGfer41I72x6IxVyj4ZEs
         lnjg==
X-Forwarded-Encrypted: i=1; AKwUvBz0AyIh6AMd2f6jbjtqcIfHMzvljI5MNuJWz5dnm6SKBDvy/yNBmlQ6bZvQXH4u3khpO8iVuO+jlA==@vger.kernel.org
X-Gm-Message-State: AFuF++nad9RU4TP9MZASy6KievgrskbCleh4vt7+rlW8UdsZdTkFqKCZ
	612qD1BHJNdqkPktaUvZHTdd97fEqUU5HXfS3zk3kYZw8H+G7ENayEod1CfSEwAe8w==
X-Gm-Gg: AYBFou1Ujhv1sB7B5KyshAknAM8U88NhiJKMhcdYyPFCGCSeyBw2bP32nLKl3OOr1Ks
	tHA7keKKG/rchOLDuPF/t8BJmKBU9PSWhw2kPuktxSkpinj1I1G9p3CNs2tCZzmpFutC4M6LCOL
	Ud0uexnUQ1Xte40UBGVvVxFhb6IRlmcWyK0NV6aZNEADEnlI4/DzxjB0dsY68Qk+0WPEw4FxHkz
	JEqY+OdwIMgJRk8PQ/u2k8sUKijZLLAOVFI41rRp7mUayD0bnfjR8gB1oAJ64FLW/1enZnaz4WD
	1KFGSQie1P4UC+lvEGoStEhDR2ru70/Wqm3DiGpwSgtieDNdVskDWHfm1KGzBJn+Ndv39KPFda0
	ZV2zsbM9556p35J6AWWowWTGqWhniuyRBsACGtwngkryb89LWi6bUuR95Qae5q6CzrNyG0QYp6+
	fDAGMBVUn2Y/N75MrqlJxt9DNdH3FnIOXVGDna2I1raoSVRLC8Cgn2niKj5EglUMiRP3EbJeILm
	u1XtDu+Im+g7zD3lj0+rSL3V8arjTT4oiU6ABV6T+bmVY/n1Kj3ymNnF7M=
X-Received: by 2002:a17:90b:33c9:b0:39e:1bff:b383 with SMTP id 98e67ed59e1d1-39e1e51bdf8mr4030101a91.24.1789545580791;
        Wed, 16 Sep 2026 00:59:40 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:40 -0700 (PDT)
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
Subject: [PATCH v9 15/15] arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot
Date: Wed, 16 Sep 2026 15:57:41 +0800
Message-ID: <20260916075745.3549953-16-wenst@chromium.org>
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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Drop default GPIO output state from kill pins pinconfig
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 92 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index ba3dcfc50956..4704abaebcf8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -93,13 +93,11 @@ pp3300_z1: regulator-pp3300-z1 {
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
 
@@ -166,6 +164,17 @@ ppvar_mipi_disp_avee: regulator-ppvar-mipi-disp-avee {
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
@@ -200,6 +209,39 @@ adsp_dma_mem: memory@61000000 {
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
@@ -664,6 +706,22 @@ &pcie {
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
@@ -1007,6 +1065,13 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO13__FUNC_B_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_B_GPIO14>;
+		};
+	};
+
 	mipi_disp_avdd_en: mipi-disp-avdd-en-pins {
 		pins-en-ppvar-mipi-disp {
 			pinmux = <PINMUX_GPIO3__FUNC_B_GPIO3>;
@@ -1179,6 +1244,13 @@ pins-bus {
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
@@ -1422,10 +1494,22 @@ vdosys1_ep_ext: endpoint@1 {
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
2.55.0.1032.g73a4cd73de-goog

