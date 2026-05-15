Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9843CEC8
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835757; cv=none; b=FrCG6E41bFLi8EGlxvRW1XfHeGP1OIbWq5qQ1VjOBg1Sz3RVBTPe/OGozKSko33JhL9gm/BPkdx5FEXiPn4rmaQfOpehDSAvCo8O8BlabIIrsowZB7iG7w88xTlQUOwnmC1X5I/4l9fzFHS+qcwPnhRN4gmQi2o5QE+KO2DQY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835757; c=relaxed/simple;
	bh=6pAbUH6Dp2ugRs5RDIe0yKeS1DEjUiAIURTicXIqUwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvsBGT0/WPLUPjb+rOHb3wGpzCtmXxwVfmpldd11Whk5+cQF2Tdsl5dWB4sYsAD9Fiut3O8qcBhL5AjZCu9ruw2uMi9bIO2JrirUMrI9NV3n2oS/Ht5Kfdu0Ntzi5TDOA1GZ+u2ZjnDoPTxUP1fS5uRxGOaXiuOapuRz9OMcHgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bUMxrti+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUMxrti+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3680540a6efso4099925a91.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835755; x=1779440555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi/8adN9TdR0oUR/hsRlFBiThItLlG36dm/4R472kYw=;
        b=bUMxrti+DL5cdjuUph+f7J+OVkKQVS7Va88HwADdYgfspcuFt5n9wWuqqHqkJlmGoi
         xXtH1XJOvPDKCZ/4s+q7KaihI0xsth93QNTuBX3ydKDflyld3xd3NWhyowN6yc93/a/2
         DD9E/8ywwBfWx6VUCPYTpKsdRmI7/Kzwv3WUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835755; x=1779440555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gi/8adN9TdR0oUR/hsRlFBiThItLlG36dm/4R472kYw=;
        b=Vx/dhtKDFptTL7zfueoMkUmWPQ13DQE4LX+s0yKPNTYVYGV6HHLW7vzl51yqiEsCFl
         MVVWr/8918xjCvZKhcjmZxz676z5hLYn1AyEmYM0/YJbBVaMukuVABrhapUwN93kkay0
         2KQ/gZ6JnrBGRdm8nyRuFUD3Ns/H1h04cd3FjcKK50lmh25dOyP9m8HVmIyotRDWnUnx
         fo502hM3C8hILQfjcS3qaIWY2JFnB3rHYKptYrsG8y1h4Ije/4WINUvIQjeopwY8SVJ2
         3Scuq9wbVlJmfypRpXtnwx3wbvUktiBAfPQ8fq5zZj//xpIa7yisqIzS21mR12co56xB
         BIQw==
X-Forwarded-Encrypted: i=1; AFNElJ+bxiQv9bXFYmxpa/gtTtCRKUC6mbh+8qll5s++8/2N9RyyfIkW7tb9jYQ/feFXS8xOGpPk3fx8+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgm1SwRHsUNlMsZqQd6oCgYBCs3KRw49PTU7/7tDNs5PlvkQT6
	mYOVcO0nqxSBTtTu2Zmld0tQ1PILxYFsOvMUJVH38UidZAzxK9AplApJhymwFqaJ9Q==
X-Gm-Gg: Acq92OGU0xxOD7cBDKgWphA63eLDEDzQQerf89elhFeGs/FZjDGMSuF3qJSBdGsorW3
	ArTE6jcu5aUxNnKxdOkWy5EOGu1D1WHLhIOvoNGwCkVBQmaI5pY8uDmussCX7l3ro4DkjJR9dSx
	5v3PZbOuzZGk66XqSQKX3vRMv0kXuYvuXA2GjYj4u0sVe5+LPyuD8aa2qkxnf4Gro5Zn8YSyG90
	jRTYoq6AXUmtdkfQLTyO4jzT/sISqFB264019FQCwKDpJ5vNHdxh2LSe570Zv/3ZUjg+DnaEnG2
	v6bzMSJqFG7B/dBGTe8sEZ9fvrcG3hDihWPQ/PdAsZZlNe/obAiVwEEJLkAJQvHgGB598HwpKwk
	JQbBYHBnKdsl/Agk+kdJ5CWp/gcPOO9K6+PeLCVLT+YGWLkbftOzXzA++eiL13Jvg1UjCHzaPby
	L4won/w5zG9s9WTBPrZvKNLs9y7g/A2GGRk64LhKNZh7emBwInQCXPMqC+uHH6vF2h9aBLNUuA0
	i73xa8G67JqlG0qCgA=
X-Received: by 2002:a17:90b:5790:b0:368:98c0:8836 with SMTP id 98e67ed59e1d1-36951a667c3mr3003689a91.18.1778835755183;
        Fri, 15 May 2026 02:02:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:34 -0700 (PDT)
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
Subject: [PATCH RFC 08/12] arm64: dts: mediatek: mt8192-asurada: Add USB type-A connector
Date: Fri, 15 May 2026 17:01:44 +0800
Message-ID: <20260515090149.3169406-9-wenst@chromium.org>
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

The MT8192 Asurada design features a USB type-A connector for external
devices.

Add a proper representation for it with a node for the connector and
OF graph connection to the USB hub behind it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 74 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index b7387075cb87..fb4d92750770 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -292,6 +292,32 @@ sound: sound {
 		pinctrl-24 = <&aud_gpio_tdm_off_pins>;
 		pinctrl-25 = <&aud_gpio_tdm_on_pins>;
 	};
+
+	usb-a-connector {
+		compatible = "usb-a-connector";
+		vbus-supply = <&pp5000_a>;
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
 };
 
 &afe {
@@ -1702,11 +1728,53 @@ &uart0 {
 };
 
 &xhci {
-	status = "okay";
-
 	wakeup-source;
 	vusb33-supply = <&pp3300_g>;
-	vbus-supply = <&pp5000_a>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	usb3_hub: usb-hub@1 {
+		compatible = "usb5e3,620";
+		reg = <1>;
+		reset-gpios = <&pio 44 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp5000_a>;
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
+		reset-gpios = <&pio 44 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&pp5000_a>;
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
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.54.0.563.g4f69b47b94-goog

