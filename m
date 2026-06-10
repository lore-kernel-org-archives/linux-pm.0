Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56833D79EF
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080933; cv=none; b=OjBMVPgx9XevQ0Ckox7gaLC6GuJSoMBC1C9Hzqg0P3D7bHzffBVDZEj+WrTW0F/KMrrouG1e8gXSJqQmvWJmBqYrj3WukV9UG/lbdDPRIU1XnzHLeAlUZCWNUDuL8I+atpFr2oegjvssESPIm0EqbXaZRYXqzPWR3p4FpBX+wJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080933; c=relaxed/simple;
	bh=rV73mlDiXmF5Z2ojMFBLCM4SIkcjQtW4k2nOaQI0FbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPETUz6Aqo+aT4+TTdsItBaO+rwC4x5mfHnrTYIwISEQKQ9xhLnxTbSvrvbJxRzdOStDKLpdhcI1EQy1npdVNzXLbvGnjUeZdZ3IS9hZHFoJZnQwe7J7E56iXkSiMmlC7kywR8sWRrZO0ko9YWJUlpYByihVJWL/n+JufiF1YKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=efTq5iDM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efTq5iDM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36baec934b6so4233788a91.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080932; x=1781685732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//v6/82RkqjQCguIRc8t+FdPVtsIJvFDXM0cNoEMOXg=;
        b=efTq5iDML1g52IvvhY/ADbNH6pZM77yKZG+t9DvZiKu5le5iL76Cwkkr0r7V4qko/u
         WWhadTOTUFzHPYzPEjdrTZRirUkCMoosKIMYT2q1P3GQ8bWfm+BcBFQzgBOGqwl2bbI9
         JJfQDBFC721l5aVnrqRigQKpA5u3KquA9BHh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080932; x=1781685732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//v6/82RkqjQCguIRc8t+FdPVtsIJvFDXM0cNoEMOXg=;
        b=K4wWp5MO7a7xAtXsJ8BFWt3zDXeFFPuEWub2giei5jVzqKTepfaCzfY7HF2x6rrgct
         TmlVf10g0KDHKmlQlgPQaGyLK8IlbEeM+5+ObNzPpWgN/GpUsZDJQZcjyq3paB7xspbM
         ZKmDFxVM97lchOhnU7JRgyTZJzBxhXre9L4MA2ve44Y+w0rBQlBX785KK3uOFQ520xWK
         nEXn5dmFdxM1hxrLsupyTpJlnEFBoDgBhswycy4oDmb8lT8Lhmqs+hnoDMeHMyNGpfcO
         KJEW48G9CVpRI8eV33qxJzVYclp3IUi0/EZ5Gn4blyyMHgVDGpZKN02DD9YzienS60Wp
         V7KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NyjYm3f+rgKO7D5wpGBWzgqK0uWLvFop0Ho6cqxbcQ3xePRIJK8V2jUKjnMRTN+u9HGt3QLYiOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+/cJliJeGwm+uTPmCtTm/AUqsxii00cOhAOgiI+aZ9upDW4p
	HZiDIy2nL8oF9tV2F7QYZcVI36swCQdpFdT0usbyXrdAPJT6ePzviNt5/DxJ6h8tcNeVW1aS7XS
	AcetFXA==
X-Gm-Gg: Acq92OFDxCRFCOYSzTUCZkvyqscbkjJpDBXljQu3a4wVf7c+H2K03rHBL/MGSQoVMOS
	oN7T+sYXm93SxXS3xEELaGzlSDQj6cHuk0F7TTdJ8t33Ce5F4/X9vzim1ZMjWXcWtnmGIXpOEwX
	7QSs7XN6caQr76hqgvWKctx2HTxCk2H+QPOb4TWVUjHKqdPAc8zBQgGpyIS0emuVsp6iAGTpval
	xRqMc1vIvN+T7sKJrpRbTz2Jlu5Eb/H1EaPbiFyngOuteA+DHfGzRgSOvdbv1zFABKbbY2rSOxb
	0Ona5prEBqq56xDeGXl6Vc8KJlEWVEVYCoxd/qbOvQAR0B7UhjrNtH3VzuzqnaQW2W3qMeHFKX8
	1c8744OXPshPvsTwMz8yBV12xiec9IcuOCgKBoK0c8paWpWNjQIPpFRIgJpXMbQbQ4SIL2tvPHr
	wfOhpYjQdnK0n9bzYNFbUkgVuwKz5DeRXuwfAo+mIgHciARN3W+KbTPNO6/Zax+pznyKKezSH8F
	ACS18/SsGGKwDDg7Q==
X-Received: by 2002:a17:903:94d:b0:2c0:d94f:50c7 with SMTP id d9443c01a7336-2c1ec508177mr217649415ad.7.1781080931995;
        Wed, 10 Jun 2026 01:42:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:11 -0700 (PDT)
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
Subject: [PATCH v2 12/16] arm64: dts: mediatek: mt8192-asurada: Add USB type-A connector
Date: Wed, 10 Jun 2026 16:40:46 +0800
Message-ID: <20260610084053.2059858-13-wenst@chromium.org>
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
2.54.0.1099.g489fc7bff1-goog

