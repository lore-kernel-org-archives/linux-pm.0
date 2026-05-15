Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95D42EEA0
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835760; cv=none; b=q6K4tqGHLyZLW3cPiQD65go8itryhS0uhy3oPqVS4vT1Db7OpsB740umWJV5DhsZph3tvOJfu8qhreogYKJlDLgC/eERpEsstZdalj6LyOZABjrRSfWkByB1RrEZ1O66pl7oG7n3W8sKhoj0vXUM71rsWhOsPT0TENjxcQrA9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835760; c=relaxed/simple;
	bh=N43s7YYjxhkf+GkW3rTXjXBZcOKRHT+sr+u8J0torXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZREolPfOQz1Bad0vtbXS6iTJZ43ed7p+y0aRkiraYo2e3m3z6UZA36lKNDbcak/MUu5VyV8geYORHJSqYtDdcyDmvXno8uDwX4K6TQziydb2NnD1G4j32kj377NPpdU3UywTZhPlDYBP8jo1BcAls+Y9qdY4qSMEFBgiZtHOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NHdrkCBi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHdrkCBi"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-366375c43c2so5200223a91.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835758; x=1779440558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YXeYvlbGnNmMv9PUsmYFfNNN3O6C6muQR1bAD60qYI=;
        b=NHdrkCBiWeitsIo035FAAwltK+dvELq8z0rJxKNuw7KfOKdaxKhJXoxAjwwsr78Rhy
         B31z87CNuSO172vT2iMuYQGdf9C9SEd+g2tSNwPSupWdMJxx37+MtUuJoDgLC7yhDO/p
         8W3AobpOhae7hZkthHul/RN0paAG/pPmyv468=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835758; x=1779440558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YXeYvlbGnNmMv9PUsmYFfNNN3O6C6muQR1bAD60qYI=;
        b=iUYnSqDOvdoUAAtscr/jc8kYn1tlq8m9oArTxvcHr27yZWVNtAm8HswJPOrto3xGp/
         o0RvPIMIxic2LYJ502aeNTYdtUqwM/gix1vdE9F0eXg8/QpBEmOidlWoheJ/2VDvXuXa
         8MIQq2MZDZvevYXLsKNGQDgOgh/L2f0bTz9qDmUNcsZb7/c1FGma6/GYizkjaVg09BYc
         zL5ASc9wuM4+u9lxINtSRbn9iS5dnocLlHQoPJAjTJjGSR4BmBijxhSAkTMQBoi602xU
         qVhGQ50RMtT0x/iXx/nWzHrI8y//ixvjvlgJaLsUR0f9K2pPmSnJjgeqPlJp1hDlwFHx
         KrjQ==
X-Forwarded-Encrypted: i=1; AFNElJ++Xujk8oEZfGxIyPGqf4XbB91g8pGcxccVHtg8/d+K95HdPUTKXxhIxe4nOZ4UKu8jMkZhP+qAzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycui7HZbpn4TyovzzsASWr51iY9ZS+8oOJuH4hX096j9oUusN0
	/ke7vgPWXnRHf+8r6uUEn5IpXY/0v8pbkP36MjIKp1oamSXMhXP20jnVozJHXGcQyg==
X-Gm-Gg: Acq92OHmURfqSrCKRlGR1O7uXw6SRgjb7NY64PPGv2YdLzCX//OSiK95OWRoTiQGGdV
	myTZRkY75PcOrwvxdzLZfo4QpSRRnIqT8DuWj5VeDOTlxp+D7rkGplGPNM+wv9hU8fAeHo6d2Fr
	8DQFAUo12WMMs9Uibt3bxupwHzpYourcS9y4ecuAeqZRN1qxBEKOSZlQWrhiYDvO1V7ggIGvOqo
	N+FDJjvCJT6B4eBeV+AJBu/0Wd6TZWcxvMv2MqR2LTogdNlWT2nm2T6ImRkxYLcgqon61H22F8k
	GcxKaoGgVmed2+gSUCE4RR3KXV5IMTDixxQ12RYJDIIEnTMwti9LtRL7R7abAvZfcJsp11eQFwm
	bKm8wIPQeN9eUQPYmr3Rnb77MQS8iFgKup/dotbYC7i7K3KfF3n5MpZRcG9JNvAC8V2+k7ML9Jz
	/xUIfPC40k9bRutCw0RmVdaC17jkG3IdBlyUbWvZqB2DD75LmVGjSMwYpwbED5wWut6Anpy2T7R
	pj7WT6O
X-Received: by 2002:a17:90b:3d0a:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-369518b25cemr3280292a91.2.1778835758557;
        Fri, 15 May 2026 02:02:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:38 -0700 (PDT)
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
Subject: [PATCH RFC 09/12] arm64: dts: mediatek: mt8192-asurada: Add M.2 E-key slot
Date: Fri, 15 May 2026 17:01:45 +0800
Message-ID: <20260515090149.3169406-10-wenst@chromium.org>
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

The MT8192 Asurada design features an M.2 E-key slot for WiFi/BT combo
cards. Only PCIe and USB are wired from the SoC to the slot, along with
some auxiliary signals.

Add the proper representation for it, replacing the PCIe wifi node and
vpcie3v3-supply property under the PCIe controller. Also clean up the
pcie controller node.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 65 +++++++++++++++++--
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index fb4d92750770..901240384a4a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -318,6 +318,41 @@ usb_a_u3_ep: endpoint {
 			};
 		};
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
+					remote-endpoint = <&usb2_hub_p4_ep>;
+				};
+			};
+
+			/* SDIO, UART and I2S not implemented */
+		};
+	};
 };
 
 &afe {
@@ -671,19 +706,19 @@ &pcie {
 	pinctrl-0 = <&pcie_pins>;
 	memory-region = <&wifi_restricted_dma_region>;
 
-	pcie0: pcie@0,0 {
+	pcie@0 {
+		compatible = "pciclass,0604";
+		reg = <0 0 0 0 0>;
 		device_type = "pci";
-		reg = <0x0000 0 0 0 0>;
 		num-lanes = <1>;
-		bus-range = <0x1 0x1>;
-
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
 
-		wifi: wifi@0,0 {
-			reg = <0x10000 0 0 0 0x100000>,
-			      <0x10000 0 0x100000 0 0x100000>;
+		port {
+			pcie_ep: endpoint {
+				remote-endpoint = <&wifi_ep>;
+			};
 		};
 	};
 };
@@ -1206,6 +1241,14 @@ pins-bus {
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
 	mmc0_default_pins: mmc0-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO184__FUNC_MSDC0_DAT0>,
@@ -1773,6 +1816,14 @@ usb2_hub_p3_ep: endpoint {
 					remote-endpoint = <&usb_a_u2_ep>;
 				};
 			};
+
+			port@4 {
+				reg = <4>;
+
+				usb2_hub_p4_ep: endpoint {
+					remote-endpoint = <&bt_ep>;
+				};
+			};
 		};
 	};
 };
-- 
2.54.0.563.g4f69b47b94-goog

