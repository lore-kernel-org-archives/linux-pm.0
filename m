Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA125D530
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882703; cv=none; b=U0GJaOB5YYLmqIlafYckJp34ypleMDzuKPLdxjR9MPP6wJsuh8my2HxSOt9vbrsEkX6DSqSa44Kq90EcRszOpOCisL+6M2oU91nv7uZ2rbn7keyDG7bBXue9fTAJJdhiLJRUonGq9z0ddBRXdIawRi7G/8uSqfV6pid1mPrDBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882703; c=relaxed/simple;
	bh=Weo+Ui8E43MHQNrKTqB+K8VGg2TvPBPQ6D1g4YfmF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi2nST6xsdXzSnDwXQFlM+6gqgn08UZw0W7sLhMg9c8vr95iNeoJxXZ6bkauPqc3vnnAIYrl734NgZq6Qbe22x4fvuUDDsZr/hrl0EbQEOvy0v6X2cnWUQtNuCXnsGc9RmAcItzn66BrgUatrUDYD2Xv84k6LhtGIXEEIerrZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eEH8NjHx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEH8NjHx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso164573a91.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784882701; x=1785487501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=eEH8NjHxdbQ4AzHsBEZRYGZUyiY8pMiQTx3ef7+ZNkeVWAJMFIpp55gIpBVDIyDTTm
         7x37H6Q80oqvnFsqIuhMdkihsXSqLb31/ML/PxJuDa6h67Z5SK2+efCvC30Qz0W73IKF
         ASLrFJziTRsKXt0YJFXXcXXlFA7kRGE/jGvk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784882701; x=1785487501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbHZBlGJIBZH9w4CnNEDqTFXqQ2V4R1HGaboHmDjj7s=;
        b=j3jiSMfbJG2wC/Wtqn0sPYP8VTzQlaQ8VdJ0uj2Sbcg7PWBJsqkOTjWxo7u4XR9OvI
         4I93KFUbRTkVOvgpHznERRsOt9jQaS3/uZlzouYf7iWs/L2BLjtX7At3dQE4uzKvWzVX
         FPTYXb6FJ6hcfY6COiH3xVpnV3K9/Gy2l4TaKX2u3GRc+ag0v1qECZ9ZzOJBCTkx4s70
         LjAETlfJCCDmpz16in5FJtJJsssBqSXowJUij36clRH4NGmYPjSBufdjsInPugg6Gxor
         EvuXPcKp3O1Duw5Qb2zr8nm5ky7M/PPWDf1jX9KUUc0LuuyRKLOIZbBBXwKKcZRRC8mS
         YYEg==
X-Forwarded-Encrypted: i=1; AHgh+Roc5RG+RTOMi/5p2dQuGq9KpNIx1OHa84gJrd2w18BfrpPRpzxlTtR6w1x4WCmujt0GWpl1z7jJWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtIa+fSTjLpgO2VFWt+L2cIwVtRBjcy8riCG3abWyRTxaGZtK
	ci2/0knVIiWM9wsI7Ll59zdAS6vV4TUxqq4Ke/bNBE9HMyQGoloh3TBkPKgYSs+p1A==
X-Gm-Gg: AR+sD11AlKsg4KH+gU8J2K3MgNL6TzP8tzYrwLE7DXV8WAG2iGO8Rf/7f50SYsrQDRk
	mceg/R2RVCUFLMg2ySOIV0VN+XepPnUzNYmqx+g4tSMXr7o/Wj1VSie8veD/y6aKSvDf5u42cIe
	VPzFEmMlwiyAweEKkx6pLWB+rGydJwUr3yzqr8xg2Aqe/wm28nCepjpY9SRNPoMqdrNNkFp2Ycq
	T5dnpUmrrx5FFeWBk3g37mj7EAb2nqPF1l7qP4Om8qk32zvIg0UP8isrOuO49aMOgXaq199dYlg
	baTMiptVXwDqp+Q7c6drWlzBr4XNavW4M05uBq6cDw4O+5RQQa0xBfJ45rNf3SolEWDmKSzrGpC
	nWIU2VkpRsuJgjQuZyHtw5TA4TNiTW9vl7VeZeO6GCkcqElm9vSkxL4WYCe1arGV+DPN2sW8Jo8
	lMUtwJIfI3rb8CjTL6BF7qyIX4GnEZR5V+eE1sA1+s5e2O85Bi1vck34JRTKw=
X-Received: by 2002:a17:90b:4d08:b0:38d:eaed:4adb with SMTP id 98e67ed59e1d1-38ec85cb1b9mr5733586a91.20.1784882700981;
        Fri, 24 Jul 2026 01:45:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:f131:86cc:5858:7325])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f089ac6d8sm434546a91.2.2026.07.24.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:45:00 -0700 (PDT)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 11/16] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Fri, 24 Jul 2026 16:43:20 +0800
Message-ID: <20260724084328.3943997-12-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260724084328.3943997-1-wenst@chromium.org>
References: <20260724084328.3943997-1-wenst@chromium.org>
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

