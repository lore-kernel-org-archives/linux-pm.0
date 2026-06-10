Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5A13C9881
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080920; cv=none; b=syUkXN17C9h4ArifhyS3TR2C6RTIHsLLluqKN3nUyVGDoZSiYlFKJYQHCKSHimH8cwCzrroAjYSLm+i9iZSsDfopwNUVwwqdt2dOnAF5jLVCnA+DG2bD4KCVxX4BdpIMpUHimzr4LDDT4JWCt3e8UoSiLR2hyr1Uy81NjDDySc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080920; c=relaxed/simple;
	bh=K4CbRZICEvXlvZnsotKBa841gnqFgA+6O9aKcbgn718=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrVv7VWKlaTYq3/qY6hAQ9pGKxIejsARJHaQYsbVS0nTq3tqYQo8C+ihBaz5ySq6OeyZnNoKS4ye7JhcW+lIYiRcrpGNRqO2Xr+8mfgfw2RyD5zx0gM/IChkPQEED9dUUtwN+/APtetTMCsi07cRznSSy6S9JP6yLCnB7Ni05Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oU9OHa4q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oU9OHa4q"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf22d29dabso43398785ad.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080919; x=1781685719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ie5n/VZ8V7UrahMrX/rnRRNTfb3tFqqez2pnqYi7Q4=;
        b=oU9OHa4qwepub7JawaNuseJsLw8+JEKpBAUataCn6hqsatICp9JYzO1zwduBlLWBoF
         JLG4dIiQ1ER2t0IRzTq4VoAJJCDAtHujaHIzL7U+Jxi+8mYIbWyzwBOtPDy2Zaabv5HN
         3183s6JrqtLAsmqy/UQB826fjUCfbOz/DZi8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080919; x=1781685719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ie5n/VZ8V7UrahMrX/rnRRNTfb3tFqqez2pnqYi7Q4=;
        b=ohaHlrFjInjVVJd+eWVtIXglOBG+GNCVaQYCq5XpTcGrN9dSVGldzWNvgKtjPGVL/O
         9DPa8m37TyNyrBbxCkdaDr++9gRVoKLyBk8sxN/ll95BKSg6f/ZeXpdw7PpizfawPVCJ
         R5uiTt0KUtkYe6v+fMi2UmH44Tt3r2mtnhRkOqXpiFEdzbkdTrNGcT2YkCy+pRpsEPyR
         h/x44Rk/rul6BvdwaT0zkzvJSPxIcYxbH/M+vwiGrKXV28d/cBkB16je+dTGqUI3LQ+7
         itO7oOLR368u2+GRbygG7+eyCidis4ZdauxPcnTFShCUMMc6G2NIQvUnz2YuTtBpEPOJ
         is3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7Q+uwUYkvBllMORhukDyNm6tanfq6adcyRzGIJ/qQEXNVwWQHnAemWkKXkn8OhQ0df6sSFo1XrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6L0o1QlrI2LEYVcbJiw7o6Y32f4WVYRNPUsmLXuwApuPPaKUh
	L1YXgRTZIQNhjmSiS4b9hO5TqezR5TwMvcZHLG2hJ3n273EFYmy71niS87pf/2u5nQ==
X-Gm-Gg: Acq92OGa/PpDE6hK++PZvnXZc29do57wIBcTke89HcFWzbzHg4IhobE0j16AMK2JhCz
	EPISDV+s1Eg4nIECddgXVSOQMX6rwWPcr2AuVLxnTIoCmhN2Z6DoP7tVsmMY4lUkDT4QIrdUOGz
	oMkndxvSXxTBrwV3Btnfln93Q0OafuBWiKziQQD4HwYN9JxrInmY8h242IQxUlA1tipNZkqJ8fB
	fYkKTWoH1+d0PtkUquKOKuliqevlLo7xV2nlSWYM3kPnu9OHgmwj3vfe2M7gpIahfCxAxnut3CN
	YB+WJPcLtWgnGUCcdoaSSbn+wxjOCfwSxY+SUAtLw1KOoaKYVjRe544yFv+XvBl4JQNDokC1Dvy
	FlNXdaBlJl/ZFGuMIhWX5385CT+Aks2Z7+L/Oh/0eRdwXqh09YKx+DRs4X1rh44231PvgmhljB7
	hzFmIb4oADcIXsH/vLJId6XSVa61rOy3pOSgqi3AKH6Y+mUuGEe3FVQj5pLyzQHvJh6zqXfrGnV
	8Nd5qGK0D7jX4cqfY4BiAGCD9FP
X-Received: by 2002:a17:903:3bc5:b0:2bf:2015:5b94 with SMTP id d9443c01a7336-2c2a1bafec0mr80534305ad.3.1781080918758;
        Wed, 10 Jun 2026 01:41:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:41:58 -0700 (PDT)
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
Subject: [PATCH v2 09/16] dt-bindings: usb: mediatek,mtk-xhci: Allow ports for USB connections
Date: Wed, 10 Jun 2026 16:40:43 +0800
Message-ID: <20260610084053.2059858-10-wenst@chromium.org>
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

MediaTek's XHCI implementation supports both USB 2.0 High Speed (HS)
and USB 3.x Super Speed (SS). The block can also be synthesized with
either HS-only capability or HS+SS capability.

For example, on the MT8195, the first two instances support both HS and
SS, while the latter two instances support only HS.

Allow a ports sub-node for describing USB connections. Port 1 is Super
Speed if the controller is SS-capable, otherwise it is High Speed. Port
2 is High Speed if SS-capable. This port mapping scheme directly matches
what the hardware returns in its capability registers.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 75ecce3bdc7a..d6c75bd20b78 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -184,6 +184,19 @@ properties:
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
2.54.0.1099.g489fc7bff1-goog

