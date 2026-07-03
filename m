Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E03C8724
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076660; cv=none; b=WBIA5L1SsnbmEgKXTt3zqYXMKyFaygt+dEj9yMyTJTcCTyRup0FuBijDMBsXQpwoHbCoeG04qYdFYx8CAdv/xSna5w6oni7BSkrswUFR6HtWgzg5FVFtb5bU6qQNert2mJFXI4OlAmUF4bmzvD6u2ujEga6qUZLlg8xW9wKf0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076660; c=relaxed/simple;
	bh=StLYhAjRY3Tk0UVrkWuO2kk43YeFTxpvsEJRpOxBLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3LpKd84sAM1sGaNX1A0ON+YVNcRGwidxNwF6QUr0RS0OxKpR+jH6B+luakfKPLOIFmAazrBbZtDnPaknzKG/IUBucvexuoL12tbb7zWkoJZjEbAqJQJbCIOkQZyeQnqmRq+2mpLn87aD4oo3Tm65nY46fD24t+C3hmdDGrvokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T4Ombv5i; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T4Ombv5i"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab973140bso5203155ad.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076655; x=1783681455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4WWH0bleuNmTAqXa1RwaMnEajgDvtrfpYNFP62ibWI=;
        b=T4Ombv5iv8fxAxhPaQs5Oy89RIe2pPAShePk0y3q6bRkaOO+maflECFvlRd98RY75E
         HgdAr008Nkfv8SoaMAwnWay3PHJo5+kMKfBuZWxb7GCbA7zrrmCeRKuB3t84jBwzSkeA
         1f3GW0Dk5KRt2AifE3MLYyXOUqx/hYJk6WVPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076655; x=1783681455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4WWH0bleuNmTAqXa1RwaMnEajgDvtrfpYNFP62ibWI=;
        b=Gqi0w4sDTG5COzt94H8h4B4POlXE4eppUAEhHYVd5VxxPNwSAXHIl7aukid2doYzo9
         1wulUkSp3db11pdzp8sRXWIQsjf6Rb6drvpfIcpim1OxrTrZ2ztOKIP1gQ2Y1mFaWVsv
         MazLQDE0Ql6jgxzwP8pERmr0LDz4MMNDK8yR2HahLc7Gg2xFmvrZqTn7Bqk2ywIM1rmF
         1NiqQtwlioU7PuA4C5OUyacQJXWYy7APCfSJSnkDtPr0nR5FmTz8cCCZ0DtsxUgCEaJT
         NhQbFSpmFo8HfYGwvwPb6oDcQkY92QxQoVdR46vRFh7eWmYvkEFs18p7TWJCDaLV2RNv
         drdg==
X-Forwarded-Encrypted: i=1; AHgh+Rpsgkm0uhNqZGmA6IENH/5v1tQwu9xBniLXe2sw5j4pZsGvsNQ9ADvm+PQQZJn5jm1znY0pkgwKTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxZ5cJCLKPmBSrYvIKjJEAgTcKe0Xnin0Y0cyi1SGP2O0wzJ9
	iQ+3dqzqyRrgb+5HOHscQLiyyQ6gqfzEMUEl2ZCiSY5Sc5fEjGWRMtEXV7aFDJ6ifA==
X-Gm-Gg: AfdE7cluQV6BwBC+FvSkBsAVrGdTyvzvNWzuN9MXrgv+7xTh1XrUyo+OBew1SXdif/9
	xRyoXq4aHuf2eCqqOedoL4loF36dgYcjIOI7kpyvOpL0GzGrXOh/mo2K+JfiQ0CVYgQBwpVZCmV
	i/8tPifL4RjV1Vhy7p0va9kUmcbiCYvDVsXPmELyLJc8dcEgFUROzuSlQPVWhkxcYAerc8UVAUY
	rep1+dgplvaXsMs8EEowQAzxWSzBcOrcHg0EyBC5VzxX3tsTFlDK1k0W/RL8wXpWasbKHi/kLOa
	DawWmnOCJ6blbnrAA+wF0Pk9YQG6s1Bib3MYi1rhKCayuvjHjj1luOcp1rEfjdS1DbhxHSJOqpW
	3pBsK/lK16UCTgVktgMZ4n/6a+Gy3fbNRbIDE2GcnTnmWCUl/EAulOhV98psesyTRwddnCKbVxf
	FfPFEwN+TJgQRZ8nV+ZuGMtWVvMi/0I8AMs6oET7UlYiDEKdaOYLb/iInntK+ZBPkAZyqBTQ==
X-Received: by 2002:a17:902:d58d:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2cad7a013f5mr21135815ad.25.1783076655443;
        Fri, 03 Jul 2026 04:04:15 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:04:14 -0700 (PDT)
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
Subject: [PATCH v3 09/13] dt-bindings: usb: mediatek,mtk-xhci: Switch to ports for USB connections
Date: Fri,  3 Jul 2026 19:03:10 +0800
Message-ID: <20260703110317.1283411-10-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

