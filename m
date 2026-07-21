Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825B4302FF
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616930; cv=none; b=g20xcpecKaBt7kY9wV1hWD06ZYX6WgOxTtroLFrWCnX68b3v6Mut1Gc0+GAFRYuL9jAI4Qr7o/arTDLOPd/f59GqgVLfpfmHeVxuLVvOQj/g33+7QLPxP65laoOgbqVMlUr6xoeVVIgNSIwz0D4MpJ9jgKQkLCtzg/7g/s1ckrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616930; c=relaxed/simple;
	bh=Weo+Ui8E43MHQNrKTqB+K8VGg2TvPBPQ6D1g4YfmF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3/nA6/+fkhasOOm/nUVoSoR+K41YL1gKjXhNyZBRZg+vp8dNRXoK5VcQLuEdie14GtuIK9TbtNqq2DNw+qhGlDFIi5p8oGalehTphVfRUPfvU5+JuMDrM09xSS3gqOm/+o+Y4QawBJGFWoy1rnaU1synwB9aCVZNR3e6ncEiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1JubqtR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1JubqtR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ced3386430so72340325ad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784616928; x=1785221728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=Y1JubqtRZwAsb43vVoeSY5JJjyZlmldO9NC9MH8KBHAhdY+eCt+yF8EQwu8oYh76DT
         MBzdt6DuPei4vUVl2ymrABNtz181vEHdUNn4eP8cU5iDmbLVB79E9XIfWUWJ0jIS9bYR
         9i+IVVezSOdycmXwyGUG5mDeD+rH5aFyIXTEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616928; x=1785221728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=KpIinNhwjjCEj9Kl5XmAHdr88mhh2kTtPmLwKUM/iKT1T5SRkO82TrAIce6edd3dBW
         bQwk0GYTpOPdf4iQ4PFBu1WTCcX/2Ovjpd86VwauvplVA2hkBdN5rOYdQgMZYDQxmiBP
         A0e/L4GrfDQYmdj/Uc0Ril0XonldVwzbEGVrJ/AzNWHWr1WaF3UMBwRrXrqRiY434+cr
         sL1/ssR5V+dnaS7efdSUZk+fdIPu1fGTSSyocLREB/IURfSbJqY1GNQHN1hgN3hli5NN
         4PkwsZoP2xlkrC5NJ5+GD00/7vFXR5yb5yRbHiiPsqpRmZJKijNL3X3gcnv+/typRLpt
         dMog==
X-Forwarded-Encrypted: i=1; AHgh+Rp4OGQT8WgGLpBspPj7/+EYxnGVQnxquReDiLhEw7V2rtw7K/yJQGyCArWhR2WPVHmdNKc9jfkIEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2iQpOLFCq6bu6sqvPRFtpjo4Jzv5ZpfCLEWcJthiMahnkv2v
	A1TXIV5qFmjQaHXmceib/zhWd8JzSvwSKOvXiZ92j5KQTrvMSiDqXinUuBW1ENGZ3Q==
X-Gm-Gg: AR+sD11QtzyWSqzu02yZhsyJkXj7OZwxg1v5tjX5mS2i+7sgvmSs8cSWrPz2zECDuO1
	7/Aw12VGG7reoY0nclmlauPsn9v9wLzxcpuAB2Lj5h3DCbAgoyP36JpiAsNDd77VsVBppnqNiri
	zc2ciJ7cmjXLZA544CLlkmDgRzzTxaKkpbuIBq6VlUV+MQEVPIqr8zA4oEcCPPJvA1uVqMp6Fi2
	I/p/jekVmFWGeOAdoK5Ozo3Wa7bP91rTnpZTmYrX21ETer/4PCVdVLakfYaANhwys6fUh37qJdb
	zm6TfV4APsWF88hHKoDfBoDHZ2xUWHZlq/CwcInfTmQ8XONY0IZEcdesKTkVGU4ncut5n77EZ0r
	25/qCAuwS9ZcTzFIOikdxZqO5SsAj1CiWC1o/v+UsDIdt6fhl/E4mqZsobVhXCj24B8z+2nY/OC
	IVjXEWZ/RevlznkVJPkQR0OGWReDzlE2/rZ50eYI1aEEZgRj1AAqGGIyBg/Ho=
X-Received: by 2002:a17:902:ef49:b0:2cc:ee78:3236 with SMTP id d9443c01a7336-2cf34997125mr195766485ad.33.1784616927898;
        Mon, 20 Jul 2026 23:55:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3916:f048:32c3:931f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ee77sm69716005ad.4.2026.07.20.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:55:27 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 11/16] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Tue, 21 Jul 2026 14:54:06 +0800
Message-ID: <20260721065413.2306137-12-wenst@chromium.org>
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

This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.

MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
and USB 3.x Super Speed (SS). The block can also be synthesized with
either HS-only capability or HS+SS capability. The SSUSB controller
handles the device or gadget mode. Saying that SSUSB handles the HS
portion is wrong.

For example, on the MT8195, the first two instances support both HS and
SS, while the latter two instances support only HS.

Switch to a "ports" sub-node for describing USB connections. Port 1 is
Super Speed if the controller is SS-capable, otherwise it is High Speed.
Port 2 is High Speed if SS-capable. This port mapping scheme directly
matches what the hardware returns in its capability registers.

Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Squashed DT binding revert and addition together
- Dropped reviewed-by from Bartosz
---
 .../bindings/usb/mediatek,mtk-xhci.yaml         | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 231e6f35a986..d6c75bd20b78 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -107,10 +107,6 @@ properties:
       - description: USB3/SS(P) PHY
       - description: USB2/HS PHY
 
-  port:
-    $ref: /schemas/graph.yaml#/properties/port
-    description: Super Speed (SS) Output endpoint to a Type-C connector
-
   vusb33-supply:
     description: Regulator of USB AVDD3.3v
 
@@ -188,6 +184,19 @@ properties:
   "#size-cells":
     const: 0
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Super Speed (SS) data bus if SS-capable;
+          otherwise High Speed (HS) data bus.
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: High Speed (HS) data bus if controller is SS-capable.
+
 patternProperties:
   "@[0-9a-f]{1}$":
     type: object
-- 
2.55.0.229.g6434b31f56-goog

