Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3245D91A
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545579; cv=none; b=ss6MYQzE6tn8EaGQuyIPAmF3YLZnQp6G0VUzEiFQpaCCPZNl8UVh9xOwMAjcsgn0kJFaxZHS5vByPx5wpzhqJNeYCo2ovhHukquFzJomNfyqGAgptDYlZYtN9zPLZ/bHQL5T8WdgpSC368VDEBKW+85WmRCjVST9+9Nemi67ZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545579; c=relaxed/simple;
	bh=n5OM2/VFYsx7oj5lWPwm1kxpni3dSJJQk03UQEkKIio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOXrbXXBF+iICyyJ6UASs9twu7gXXJSMw5T5PKkRoCyjOncIdWq4W0wkzH3FRbq7TV/lJ6OCDIFk026ARNv7fflpp4Jt8dm2e07/rpjh1PLBznpxqExJJmWiFY6g6dgmXLDsiw3+7IzMlwANvO/9KmqSSqX6zhQCeaG5wHawRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ohYqnxUt; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ohYqnxUt"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so353415a12.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789545556; x=1790150356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnPIF04bEgfqnB06sJJ+n/4J6DJ5aXluvuxFl2QwIxQ=;
        b=ohYqnxUtCPXeFU+yDLfm/g1jv2GU38BjR70gPaXT6fZBcN1akUi9BoI/csovFlpLeS
         X8cZbpOkdAT7PpAIHjYLJsNJXHKv2pVqHHFVhp77Ze8Mz8Pjou+T1OuotuigsqHGgzKo
         GTUvC3aWZ47Z7rkhK+0MjnFLYucVqepA4e0UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545556; x=1790150356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnPIF04bEgfqnB06sJJ+n/4J6DJ5aXluvuxFl2QwIxQ=;
        b=u/z/3iaefHNdT2oYqFxhLPwGI17lM5RJx4VMlPir1IIEhOL8Hmb816yKl55Nij5+pJ
         RpZe27aYDPm86AGAV7wJzgA3jLQGx6O4F25xLgxGNZNhS5e+QON3Oo6oNFjXmcmOWF2g
         mWmaqkhnhZD8Ftmo9k8U0n7Kjnndd2yiAQVXdOSUrofb53XTP0ecxhi4Q/xuhSLobGTz
         3M3BNzk8DI63o7+dFhmu1a0CjDLc6N42l9HEo+HLwuXP8JFNQyfZEIz4Zc+rdB8trtl9
         IgpHKDMC5CmieLCOxrJ5yMkvQLFWFhdLVuA1amSYbjDeIHq2h72227PDvrERNhunmDa4
         +oPw==
X-Forwarded-Encrypted: i=1; AKwUvByLwjv8MtsH86Hr+d7HvixpjihKIUHyw1UVSH82ii0tcVvPWlyeOhhTHFhI1TkN4/TltTdt6I5P5w==@vger.kernel.org
X-Gm-Message-State: AFuF++mhRKp/B9viIFWU373AphGO8hyBDAaP3D7sFGpPPoDmZ0fQQWG0
	vArv3aOF2l72lFIorvjMPOwOwRGFojUuXlkrMLZuVxYTF+GqzW3Gq4zETHocQtJbCw==
X-Gm-Gg: AYBFou29ntzhhyMPWjUkYgPc2964iMYKod11/HM9BE8HXLoL2MwLl693ctCChXm/Qe9
	j1RgEXcCKMkzkpYcgqTr9LpzBMVLkDOXgVkqHBjRPGrJ6Vwz9c9b5whbAw4pfPm5XqZU0jtkjEZ
	M9WfWkYvFIDQ3V5dUQyaWcjF1Ej4I9KvxP7ghFgcJpeEq8E4B9B6uRKdBzYIin4oGPHw68vcbi/
	7BpxDytZDuYVBJujNs+jDqKV7E2DlQL8/GZlh38Of0bgG+0ynp+T32vSl0s42RNQ8AVatA3uGqo
	G1um7K+ueIiQP0k09ADkKctAzVoV0NZH+hBfn4k1Pm0Z8Xsd6GgauNEEdqUzKkyVDth8N67WCmZ
	UwmP/fFXbr/4vphTRnJQw+uOg4LfYDCOB/gK7PdRwnxy0ERFAro/UZo15fSt8A4qlAqrLRSqASe
	BOx32311WpdINFh3yzn7imkbHI0mPfw0dDiZe+OQLrY+Y9uqACQS+krNBw8ZRj8OfamEDUigw/Q
	m/y1wp/uBva8k24HHmf9RJKofSS92oLrwgy+YlWXsGuwu0mS5nOnxX7Qg==
X-Received: by 2002:a17:90b:4cc8:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39e1e330a2dmr4372580a91.10.1789545556050;
        Wed, 16 Sep 2026 00:59:16 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7acba2sm4348197a91.16.2026.09.16.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:59:15 -0700 (PDT)
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
Subject: [PATCH v9 10/15] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Wed, 16 Sep 2026 15:57:36 +0800
Message-ID: <20260916075745.3549953-11-wenst@chromium.org>
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
2.55.0.1032.g73a4cd73de-goog

