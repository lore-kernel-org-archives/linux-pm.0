Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0143E4BE
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835768; cv=none; b=gDw7v0ulHstFOZxYUK8G+3Aq36yToX4RdAc7781CG1nca+cpzjzcJkQk7ymEz86Kccv/LYSzBBFQhdb2ROr3Zs5e1zXc7DrfsCHa/3LZKM8YkuKDNSmOmzHt0+giU8OeP0CJ28cki0fbfON0CMJphKsRBRgbLELmlG4vWj3qDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835768; c=relaxed/simple;
	bh=Gz1BdO2CNIH1WVRh/auvzptyTOFoc+CyHx9t/Lizdxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI6nOAOXo2gvLsWEtoH8K9mF+L9CSv8WBBIyn8DZ5XQe4dBe/yx5AhYqPKtlYI1HXqvaYNPPtTXDQbicsWvrR3GvGNctT6lApRWjockwsmyfJFqLxMZTCyCS3XzZ3cD16AQGKaXRPzOev4EUIpHdoMXpAUV8Ktq/qyu9+5h0Des=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M2v0VpvA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M2v0VpvA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367d88b9940so4929192a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835765; x=1779440565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2ZaGVux29bB4QztqEVTUE9+3m9wph3XttnIMDbQw7w=;
        b=M2v0VpvAjlya9oG55Sn6CgaBBDHW5/dZHaKggREN3ATYa9+fAnANphMS+zRZapskTf
         BeOm2v1MqsAB/2o+441GRo1sjw/VMgch7S0wG5Cd/BpGFDY1wktLy70KpArBtgdORpR7
         6X5jlTdwuJ02fwq2KqwgyRhZ3WJpS1tU3Wu+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835765; x=1779440565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2ZaGVux29bB4QztqEVTUE9+3m9wph3XttnIMDbQw7w=;
        b=Sa/GyCmDNJyPtQbtLjL6uZ4+z7tb03VwSeEMA/dVhxOfX2JZ4yeqINOz1E33NRLo+N
         ctibYq3RjGh09DTcJMO4HwpLsmrF1/KQ/HBRgN3o2pqfMxdwWKoIRoqAoIB1JEcx81Hp
         MmNJiaV74yOlK589A7A8hVFnH9+0F9wKltHA861msj6+RwPNAufRJipEVhYbcdAjaYss
         tYql8SCGbxrrTbM2VKYNUb5WLFYaxt7TFXYY6fDfpaLyWYzZXzQUUTX/5we/8ub3nqFO
         4Ir740S7/MznRtlc/R4fs+2TnixAvXjJ1jK0CdV3V5LW0mMzNX1I+8+HSmKhlzab6ubB
         nQbA==
X-Forwarded-Encrypted: i=1; AFNElJ/lqPgQeZ4XH2EZem1ZVoNsLyNuPbPBzYGaZ/g+Hkz1dvnn3yE1nZuj/vPEJB2wAoVTk1cT8Ehrsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCafUhrWHXfiwwGPoMtEeUCwtDHyQrXqouQaQjKUTyfXHvIRN
	XcUUM57cD8oZQXqQUns2vqfwgfqc3WmeS5Vf+YRI85ZtcvnJQdDcQkg+9RMTzkg4LQ==
X-Gm-Gg: Acq92OHuyL/LDEScFo3iL3z106Djq1dcNBEv3TQqaBpwxy4FdhK7e4HRV3yNfLd8vXQ
	WJzMevpmhG2YPExEmjo3HJpWQIxHMvAjoN71NZk9Zqx14y+vVrICysFRiM7hcpt2dMPmrqjw3XZ
	qRL0mMa6MS/dMzCjbezDvu6hcqcuekeD9CpPAlWTDZH1BAuM8zpOnXp8d+tHv1IGH/GMKh4E4yd
	yK1XliA5HnLWSx3cF+hJcv0NzpIB+Zz/w5OwZeF0cloBFCq4SB/1zY5w5UJdaBYVR4hsLL7vvOw
	zCdZr+AVHKPu+uC8dExod7Eg0GttB1BesW/cdkizwoBhMhydtfk2iyYYYQMz+FlDHMQdGU3fyN/
	xicPWgOvFzEvK2zoTEXJ6mhiVsG0xclBW2fCXZAfq32E3wMg4PGjTKll5fb9nb8EXK+fukpRbXn
	CEOHyY85hGDeUpDKBscsw4135ICfX1AQw7IC1nFTVphno+g8zDECcvooH/mNVc4d27xvCZjzwvf
	56Gtg/e3E8We6V0aHo=
X-Received: by 2002:a17:90b:53cf:b0:366:16d1:6a25 with SMTP id 98e67ed59e1d1-369518b206cmr3162750a91.5.1778835765371;
        Fri, 15 May 2026 02:02:45 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:44 -0700 (PDT)
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
Subject: [PATCH RFC 11/12] arm64: dts: mediatek: mt8195-cherry: Add USB type-A connector
Date: Fri, 15 May 2026 17:01:47 +0800
Message-ID: <20260515090149.3169406-12-wenst@chromium.org>
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

The MT8195 Cherry design features a USB type-A connector for external
devices.

Add a proper representation for it with a node for the connector and
OF graph connection to the USB hub behind it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 72 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index c95a54de3567..b21cbe918c1f 100644
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
@@ -1672,9 +1697,52 @@ vdosys1_ep_ext: endpoint@1 {
 
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
-- 
2.54.0.563.g4f69b47b94-goog

