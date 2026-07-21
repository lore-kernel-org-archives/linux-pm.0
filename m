Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B601436BFE
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616953; cv=none; b=SztTYeS3dCR6Z1SjQ71ohycQp46nloEGKmHZ2Uqx68GDo2H/xqis3EeNk8Abfizs3P1WC85gzlMzkq0uYuZbty+3D1OG3Q2OC7H5YT34Mb6C5NDTprfZzHC/Q+eeWsToVUEZCtsGCZio/dkVGxNSpZ6v6C4FwlNfIXEZzADyMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616953; c=relaxed/simple;
	bh=dQJuzRDQpj3VKXEaKtnWxM5VvaRqmUrz7HxM3N6SqEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AumjqE+rYx3z6JlZCuHp3vwdW8KjvkZoB2RkNR7lxtMs9Z2MTcHVea0taeBprfxU++OcNlWDn9ziifLQHBxio8rWU1MGBBz4BVKQGGJ6gmPJ5E/89kwVIXpsGA8Wgy9cdQlTxDAebll8ZHA/JZGJpKlkijmSnKHDaxvkihUKys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=De69R6kl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="De69R6kl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso81991725ad.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616951; x=1785221751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qD4jR5z3A5YuzPTTRZhT1+z9pUoFsNBk+NnZEFwJXQc=;
        b=De69R6kl/RIs4jiZEmbS7IViHEZg8GkwEo0/e/Tmzh4r5jZ4KL7xkOtt4VLtMaKqU2
         AmliIv1OTxMNTiHuJ6NzZrvi/bp+1Odgyj4Ij3U59gI0jNYrldtvxbPqe+DDgA2vTVG/
         HH+6KVwmxt2GfKyBtys2ml7eC4oj/894+IPyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616951; x=1785221751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qD4jR5z3A5YuzPTTRZhT1+z9pUoFsNBk+NnZEFwJXQc=;
        b=UrQzazYNSx+4zLWBz4oaG3ltu6itBcJ/CoLg4CugkgXaFbpwgve08yqlnjM1Rxx2y6
         GpXzxtxrZdoze1wFc9gILqoy7sDzTmFPuiQQKgBryDyzSV8hKblKuYs3XV9/6ae3zU24
         rzNS5boE2UWOa8akUi6LrxQx1RIKbXRqfeb2M1WZJiCSf6YGUq6zPGZVNtieK1sSF+N3
         7ZVxtjxiH9PoCmGNmLFyqhwJudKdQyRLXXApqE3nUgo5E+Z1TF9U+WGQq3gOaPwbi0UH
         hD0WOrgFgCXl0QA48SIiDzHqy/aqZDEmDWJ4SJpfvuyq+jDZvgRjmsSrf5wVMiTfHyrJ
         xP7A==
X-Forwarded-Encrypted: i=1; AHgh+RqKPSie8mI9ZFVP3wV+/9Ll6i/PEMMQh4Xh+cJcB5I6GASQJcIHh4LPoEN5D0pS7GmnwXkdKYB5Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4S3SWwI7wmPyJD+wYyxvtXmwJgq1NHKNoqTwOZMpj3j9aCCF
	tF2Zp6xbV1gskxV6Yw1Ra+Ub+MyIJaO3WH28ect+Or08tcwgJAbcA3Vmj6ncJbJXHA==
X-Gm-Gg: AfdE7cknuEFI3Zz/BLRmkrOgG9I1RTX/mHgseJ10SjTevoM2XRtIDhKLvbP5RNWtuxF
	4O9Ji2E4iSkEzsCd2tqBGH3JTXWdVZrTm2aO0DO0uNSTdA4wcHifoQryXtipU8Woj0BB14TH9F4
	llY6vW8Wx4i1+gD6Gmv8949giA3/qYZtelxqyLqpkh+SuEfTfFZi6G0tkZGacW8SoXrelpda09/
	G61dPEMTny2PexGmHTNQwF2yUMlHkl3u0Vb9KZ1zWJof9NGRW8a0BNCTQy8deNM+mWVIRVW0pPq
	G6EL/GJCl9BE5+akVJT3zdjA8T29xaT5sX9qqld6i8gnuEXA4ZPHZkLBoOS1xuiNTISPl4IKPYZ
	CUUDmN9tc/xjIUr9Y0JaVZQjnwZ5mycNns8DdHnUImgMCEEhfjW52XSkie4Utxj81ecTi1Nc8T5
	xjyjQyBqJvMQ5ufQuVG/GzmAikTbRS/J2StTHnEeFTK1bFv/IGn+xNDOIfwupnNyRg2EhERA==
X-Received: by 2002:a17:902:fc8e:b0:2cc:ed57:c7c with SMTP id d9443c01a7336-2cf349cc532mr189795135ad.32.1784616950743;
        Mon, 20 Jul 2026 23:55:50 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:50 -0700 (PDT)
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
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 16/16] arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT as M.2 E-key slot
Date: Tue, 21 Jul 2026 14:54:11 +0800
Message-ID: <20260721065413.2306137-17-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260721065413.2306137-1-wenst@chromium.org>
References: <20260721065413.2306137-1-wenst@chromium.org>
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
Changes since v2:
- Drop default GPIO output state from kill pins pinconfig
---
 .../boot/dts/mediatek/mt8188-geralt.dtsi      | 92 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
index dee946309121..73b5c0fdeae6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
@@ -88,13 +88,11 @@ pp3300_z1: regulator-pp3300-z1 {
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
 
@@ -161,6 +159,17 @@ ppvar_mipi_disp_avee: regulator-ppvar-mipi-disp-avee {
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
@@ -195,6 +204,39 @@ adsp_dma_mem: memory@61000000 {
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
@@ -659,6 +701,22 @@ &pcie {
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
@@ -1002,6 +1060,13 @@ pins-bus {
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
@@ -1174,6 +1239,13 @@ pins-bus {
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
@@ -1417,10 +1489,22 @@ vdosys1_ep_ext: endpoint@1 {
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
2.55.0.229.g6434b31f56-goog

