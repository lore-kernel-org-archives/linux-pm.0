Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FD43DA33
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835764; cv=none; b=umeqE6z5cHLdATC8O4Q8oXJYNzVv4Ervv+zveOTfz/OkJ4kPkXY9HGxrMRwM0gA7OcxF/Ekzi8OWOJYbLMI0sTa3Eg7hG3iwDbqR+07d5MECtWTUhk0jHXsb2iVywa1qM3cVZ/163sxzg2GczpYh2Wb4DEZn/zHnaMCFmqmtq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835764; c=relaxed/simple;
	bh=VrOSzPFrQvicaTFR+8obgla8JultGfpYF5nJAKr0KVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCkIatuMAYen5I7MoLlkCmcNyPZZ/ZYirRcQgQU1ikoKZhrkpAKLlg0MIaD5haUK5vAQ3bRsXKGuvX1sVP64nVpxVrI9NfMRq9cZIqxSP70Gwk1Ebnhhrf10rDHKgYdBkq6LTVy2FfS7ZzcuqxaGLmCvb6z2Te/4cCdiLEy5qT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IntThx1g; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IntThx1g"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367c26471f5so4883914a91.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835762; x=1779440562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEzJ+Z0L9sJzo3bRALn/EbUhsV+JTXUM3B754yNkOg8=;
        b=IntThx1gua/EnZx2ZFe7/kpR6hVhyNyEUOs2k/6V+pNbH5wQM1Vi7TcOx94YenaeSY
         h8dc7BzpYkhflcnMD0+IHW8dQjWY6vUjw/H2tg1BYRD3D7yKdX2nRejXG944hUODIrJi
         fp4ZXvqqCF5owqLc0Z0asUAjqMgqW8yYIJJ6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835762; x=1779440562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EEzJ+Z0L9sJzo3bRALn/EbUhsV+JTXUM3B754yNkOg8=;
        b=ZKMGIN13i4XTFWBEjo/6+bVP6LgHHT8Vz8KciI1W5GZuhMU5hwF9qTcU5R4qTcZYFa
         2Z0Z/d7YxF7Cx57w8WrGD42151kYD7+QanOl5VEIH8WPQm85YPuyP8MUMungpEPLleIe
         SuT93ijiZi9Mtom5oMvsq1NdaJcgduQIMNC9zER8ZSJUOXuGtu9woWmAWZLKQqv83Rdu
         0BTsm4pLvvg7qklcGlTtFU8vp9yxWhscFOFyaS+WwymRddnQRCl/9Lm5LYGOO1mPmVH1
         xKKFar194YlnzCaquAK2TzRRBVw/RDO/KwMzQiJPkbyeM1Z/lULoT9k9Nj3BUXRCC7oi
         eX1g==
X-Forwarded-Encrypted: i=1; AFNElJ/uDzdUZVESOogCQcs6wYNYKnzoY1PRiwAEt50gaJ0hJ9GjedAwjUvc32FcrQKd6aZ0jv048Zm7xA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eqNPnQWg+r/nCHqb/JK/BZiUoGdzIxMCk3lUnXQBiPkIcPZ/
	MkMF2GuhbdqerQiTK7TNUZ+TCSP/1SQoR6TGWpP3ZUketlRivpU0JBVN+9frjEHHOg==
X-Gm-Gg: Acq92OHsulQmI6N2ZSOBcQ96WbPeN37CpUMMm6rPYICgP/HqOV9Nee7XJby3bWJwsI5
	+ueULibGufJ/f6ki0aP9qS0US1GvHebltPaHqjijE62TvW4iYHYJcvmSiT0PqGB0UI4PkmRKsSB
	MMQvq22mMvcfNF6eu8UZ83XfmyAdl7UhA8tfho871CpBEQdrCiqQIH8PehKC3uQRNlZ6nY39uPA
	U+a0EqNWq491cDD9qZWw4uEJkGJu28lk9a8JOmSmh4hygJVw91i6OZeeWj7uAvaybVQA4JF2BaR
	ewdxbry+ziDa1/MHhK+bkmJ9S9ZJy5QOJy/ae+O3VbSS9jgIvioqLUX/Sci/CurPJ+wxop/cM6w
	b9AAv2hElL1U956bRCyVcCuvsMOwxpCJLnBakma0sFxlQAV4FaljHN6fjGHXAzSdQTS8Mzmbrjd
	oLyTYKxB3WprB5sGW7I77QYmVhPx4n/Ld6Ai448qhXId3LdDpTfIZ3lcuYF8oX7QO10zvi9Z4Gk
	jZnBpKn
X-Received: by 2002:a17:90b:544f:b0:35f:b46e:e329 with SMTP id 98e67ed59e1d1-3695189552fmr3108678a91.6.1778835761921;
        Fri, 15 May 2026 02:02:41 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:41 -0700 (PDT)
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
Subject: [PATCH RFC 10/12] arm64: dts: mediatek: mt8195-cherry: Add M.2 E-key slot
Date: Fri, 15 May 2026 17:01:46 +0800
Message-ID: <20260515090149.3169406-11-wenst@chromium.org>
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

The Mt8195 Cherry design features an M.2 E-key slot for WiFi/BT combo
cards. Only PCIe and USB are wired from the SoC to the slot, along with
some auxiliary signals.

Add the proper representation for it, replacing the PCIe wifi node and
vpcie3v3-supply property under the PCIe controller, and the vbus-supply
property under the xhci3 node.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 74 +++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index ef7afc436aef..c95a54de3567 100644
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
@@ -1085,6 +1126,14 @@ pins-bus {
 		};
 	};
 
+	m2_e_key_kill_pins: m2-e-key-kill-pins {
+		pins-kill {
+			pinmux = <PINMUX_GPIO61__FUNC_GPIO61>,
+				 <PINMUX_GPIO59__FUNC_GPIO59>;
+			output-high;
+		};
+	};
+
 	mmc0_pins_default: mmc0-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
@@ -1637,9 +1686,24 @@ &xhci2 {
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
2.54.0.563.g4f69b47b94-goog

