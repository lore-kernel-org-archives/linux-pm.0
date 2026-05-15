Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AD43C051
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835754; cv=none; b=o8G6A1ddcpsWYvx450tLIcAAiMsRgM1yYXVjatTnfPV7aVgA1e8I/hmakQlKck439bEO0Sms8KHzBrPSx8llwIYyUozEYshkWqnz480btKh/k/MgNCsslz0cMMNWo1qwWfXjK8LA9DaLdRkv0qkbpkH3a/3Ba7W7VW/Wr2cSu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835754; c=relaxed/simple;
	bh=QRpARmRr4aby8NmbN5psePJT0Yr58c8UhxRZ326x/uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEb9mYda4Ppyapyah9ipJffu0Bd1oGZIbQ0urFy77MXAaTjUyM0qb+xD8puYkC6/c6uThOP2FbJFz8ZejymTFlPcwZsp8Muxv6rQ4/RHe7AiGMjUohxI+Wg3arjqkHaAUdnp4JayrxbNkHyelOod9JqlMxj1u/36YVp/k0lcXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XVBLp6dG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVBLp6dG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-365eecc5885so8880866a91.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778835752; x=1779440552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISYKmXVI5dGO3RCkjTpj/otEcK5TE9KEG1oM+kKbrzw=;
        b=XVBLp6dG2w7uoyWmBIp0CYnnZjzHEo5WWhiovnBtiqtfWfWsFkeB8ysWTXF7+3FrXi
         nacf+BfQBjFV0t/UnuegJ8R1AK3vR7Z5gNksPxUHh0wPDNMKy9DJQ/JoI6ERLFHaBRko
         rzOSjwKD6bz7wtRj2BDy/wgaxwuPbmAQGNqP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835752; x=1779440552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISYKmXVI5dGO3RCkjTpj/otEcK5TE9KEG1oM+kKbrzw=;
        b=jf9XCUHWs4Eu+aLUKEg4vzqV7rkSetJGr4kTt1s70Hyhvz0ZLFz07fD3COvj04iMw7
         Yxh9XEbBKoTJi8W8rbZh0iHIJxllhiZYCAJ4sW0RVXc1Ttu88k3xayte4JDcw49Xe3DT
         Kl6bPAfXKVXX6GWcEcTtUd/d5x4m0Nrt1ZYx3WPpnadnHbzd8lDiStVsr/rkHkI4ZtF6
         nshD6YGwStvmrVlgehAV0AYU88IZwJLD551x7KBqt2xFXhCBfgESMX23HwZMB5itHfpU
         yzUNPK2TZdIpaj3nxHXJXfpaIpTx2BIqCOxh9s+2mTcC1DX3bT248ZzqH7AB/MvYCku1
         JKBA==
X-Forwarded-Encrypted: i=1; AFNElJ9qv61cwFBaYwYqU+ye1LtbhSG7sCy9xVsL0R7tMZ2Wl3I1DoRSAO6l7g8G5nvu8PiWSdBgc1aZTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnithfsOF49PZVC1aSss2+Bds4TK0c2tv2rKeCSCYUf6Uw8gl
	f3Yn7kkCS8RD6Qk+/04JYm65NQgJ5Z11Ku4q8YB/3qAxRqf54EaSx6xiQrmJlU5PnvPyJGas9rF
	6BX8=
X-Gm-Gg: Acq92OEWIBzGuXMjgtZx+4pyMy35xiSG2a8fDMSZD0mznq5+SUI6ETQH5sXn2n1rLT+
	fwGkwyhEhWdqZCKpN+ruBAxow0FW2yCoByFCPrVHJKDp1PDWJ8LioiLXmDd6SIhlDzDIswf9hRA
	D7v0z7VTCJadz9aFRPqG2K82sVsA/y3L58R79BleZ7tv77dTRaajtsnj16xuhPRXMCBNa5Evg9z
	L+KFWoIMqBpm4NZ5yhwczn1j64rZnrJLpF3NwV1STzNS9GxJKWBfq//nQ4Joc67izoDrg8t3MnD
	NfHD+dhTKs9Z12XIx5rAdc69OjAgLBCd5gSm//gxWcqbcdFwWfXtHTvKwyzxixcE4UH8Gg+tFWw
	jxZjMcCRNvg2dYhfwU3xo7F0dUFYL9EGWFAY6GILsCX8X/POoRmla3+8sFbnnecSAb7l/Ucn5F3
	/PYcdv+RkZYfFjlVhBi2XJP6XZAGVhdtK2ZMUL0w62b6Q7rbh2UinUFIxRPRxsR4BpdZlXXoYtX
	zfdqdsH8HeoycOdgfY=
X-Received: by 2002:a17:90b:5784:b0:366:479c:59e8 with SMTP id 98e67ed59e1d1-369519dfe40mr3451397a91.8.1778835751725;
        Fri, 15 May 2026 02:02:31 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b3d8:e32e:c2fc:c31e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2076537a91.7.2026.05.15.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:02:31 -0700 (PDT)
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
Subject: [PATCH RFC 07/12] dt-bindings: usb: mediatek,mtk-xhci: Allow ports for USB connections
Date: Fri, 15 May 2026 17:01:43 +0800
Message-ID: <20260515090149.3169406-8-wenst@chromium.org>
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
2.54.0.563.g4f69b47b94-goog

