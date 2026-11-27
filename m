Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807416;
	b=zCEbmaw5WTYtk48aOCDvT4Fd6s2MeeVuQKAMy0w5DiG8iQEhAsZNN9LlauYP9h0wQ6Z0
	 OZww4+KJdBOUp1jgOL/pSOcOLRBddcDpcHgxfC+bbwjZh/f8EqlZeoXNAje+z3sbbnitx
	 P5H1M5RtXCN560NjqcoxqfZJVP0WfLlNbpQtV2owiv30SMPRWAM4TDLd/gc3WMp27L+n4
	 f4yIZkrTnsmcIKhKrcnxuy27Syn05QTaXWK+ViD+GaphMUcASED9WwQ4Ed7x2kEGErXHu
	 2xDQ6oI4WafW7n80NjCazfnGrlGeQ+J+4xY8AZfVCsBLRZpr3S22P4RGpOokSWnxMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sr3t56lz2ew1ExXZcTsdCaVtIgRa73m8p4gNG8bPmz4=;
	b=bKRYCBoPUBkP9jp/4s6m99ffhbu2DH2xteXov9922fHfpzUG4hzyG5SHu0p4aRb+efw2
	 pJWwjdv02749zTO4sDmvA3uvFAn/jt3J4LQoG1eFL8MYcc6/3aoyvLMy1YcVH9ircNhSz
	 R6dP/LBGU2DMBSaxizTg9ubdSmJMDBOJDAuj3hpuAoduvEaAv+QfFpNrNtrrFJaDkseaY
	 KnO5fVBVGfmgE2Ypd5Fl/J5aeI73v479d2EoDHM88Jad6LtRcZZH9wkHJ/mZR/V3+i/MF
	 jMxN6iiKDOdUzLK0zT7B8nM5YGD8ZlrZUgBXFcrM9dTQgWgalJs6PvBGsK6x2ycxp8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTsMJGKa;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4FD606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LTsMJGKa
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-483c607ccb4so4290719fac.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795807415; x=1796412215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sr3t56lz2ew1ExXZcTsdCaVtIgRa73m8p4gNG8bPmz4=;
        b=LTsMJGKaAjMGdRZnR7RsseuolEWWuGpq1vMKt9y6t/+iWg+J5hcHf1uuKUtvegOQEz
         3gBG2rsyPZMJ1lk07sxsMLSzaMMYSFb26qojP1UGWGd6OhORSzTMewNZv3v4pITB2jzr
         UU2JHvNycTvYE5VcxN13EzCNcbs4uo9iNndE3c7QuuxYlwqLafPPAf0W7nxuikMgextt
         Vqy0YkPAbRktcoovFRO0+PA1mLlMU0gfiSPiwxz300rAupaUoHD5OkCyHdz0PpwoapPo
         c4iDs3DzSjH1PDe+/bSpqcbjAMdKcGUzapgsojOlK6N4meJz6rshkmVwK5oOkmfXgiqA
         p+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807415; x=1796412215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sr3t56lz2ew1ExXZcTsdCaVtIgRa73m8p4gNG8bPmz4=;
        b=BWOrFmCNzpGvkaxAmGEb9j3gEO+r4OMwjlOjU7HqfUlMdLxXcJhjAqKG64pO9v7bY5
         ZAkp6uNDiOEt0Vm5UOCUNMr75g3MA5o0Es464cAKf16E4U4xT2t12fVPUq+wWrws1grP
         t45U8VTwnMvvYQjLQXbkJuII0Xk+csVmh8jlQEZIJAv1HuBaIbZeBX81t2ZHKaMHcU3p
         c4LXS6D0cDUhWcsghzGrK3kyhaT49Rg/gfqL9rel3SH84D9iMBdHp7GocKflZ+pmvIdC
         DZQQQr8Y7D32kKGUAb3lb0vx5qUj+99Ry1yH/UMHm+lQVcGplRr8i6x0b5GxMZAlLdSf
         2sfQ==
X-Forwarded-Encrypted: i=1; AL+hErHA1PiC+rb78ElsmM2k8/hou403VGBorbAwlkf85Gu0mCtvo6ewhioe8yBZUIm9OsOLZAbX1LTerw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+3N5mHGmTeBzVNg0qp3Eo7aDgIRfEEIBQCh5scTzvBfJ+4Ir1r
	xrhO20EZCFBPApd+OeFAtfNrXSep2hrUk84zhlSpMybARe2iOyOgLK7U
X-Gm-Gg: AZFdTZcInBvCJfoDSS5fs4yJgLzQ6fQaNe0OLD3lpbcWrtpnl6u4VA4/jq959jquXhz
	bwqv3PQ7DHnSDIUsx+cVZGpgt9whaBNqQDKyTSt3rGihKUfRYxT036t8BKDmo83krmKPvlhbKLU
	6cce5l+co1pEj67E8eEaFP3xi+6BmLn42We65WK3OqbYXB+kym7ZPFq/9gFU0aAhQrb9xNtThda
	Vvf/njCp70qaSle6yGVOktmKN8vnG3xwbnf5StVRg57rBUvkYw46DXk080SDoKkfLXfUMlp32qH
	eagE8fwFkG3vrJrrbvMiZWaZTZlzcvjEOdSAMHMoPoU6bnEyIuygbOIRFvmpGmnS5P36fe2NE5Q
	+oeT3GhLxw48uiCowcRPm9F8BAQf2cxmgL1On7iw7uX5UfwCA9cTw0xYnIb2VI1MMRlfdCN6Y+5
	h6sediQuzHuDuFyuZxRcK+8wSKtoDNPcD/8BYwDsTalTqtVEwDz1m/MKQdrAnwN8WIS/0/m0g0Z
	4xVVDZEbTb6FKJn6S68WtCYXUfP4MtX57cNs0XSVLxj6LLslkC/5I/ZBHacx2pI/XN0IpSPiHF1
	aD+KvUPa/mWY9rWtuJswzmWhp7BSow==
X-Received: by 2002:a05:6870:828c:b0:47c:c8e6:23df with SMTP id 586e51a60fabf-4bc84f22914mr23087614fac.27.1795807414615;
        Fri, 27 Nov 2026 11:23:34 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm24044850fac.13.2026.11.27.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:23:33 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V5 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
Date: Fri, 27 Nov 2026 13:23:28 -0600
Message-ID: <20261127192330.610452-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127192330.610452-1-macroalpha82@gmail.com>
References: <20261127192330.610452-1-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add bindings for the Cellwise cw2215/cw2217/cw2218 i2C interface
battery gauge. It is similar in function to the existing cw2015 but
with a different register layout. Each of the cw2215, cw2217 and cw2218
only really differ in the minor specs and the hardware ID they display
when queried. shunt-resistor-micro-ohms is a property in use for
multiple devices so not appending a vendor prefix to it.

Update the minItems and maxItems for the battery profile so that the
cw2015 continues to have a min and max of 64, but the new hardware has
a max of 80.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/cw2015_battery.yaml | 41 ++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index f7bde324153d..2db80287def4 100644
--- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -14,12 +14,13 @@ description: |
   phandle in monitored-battery. If specified the driver uses the
   charge-full-design-microamp-hours property of the battery.
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
-    const: cellwise,cw2015
+    enum:
+      - cellwise,cw2015
+      - cellwise,cw2215
+      - cellwise,cw2217
+      - cellwise,cw2218
 
   reg:
     maxItems: 1
@@ -32,7 +33,7 @@ properties:
       back a test report with the binary blob.
     $ref: /schemas/types.yaml#/definitions/uint8-array
     minItems: 64
-    maxItems: 64
+    maxItems: 80
 
   cellwise,monitor-interval-ms:
     description:
@@ -43,12 +44,42 @@ properties:
     minItems: 1
     maxItems: 8 # Should be enough
 
+  shunt-resistor-micro-ohms:
+    description:
+      The value, in micro-ohms, of the shunt resistor used for sampling
+      the battery current.
+    minimum: 1000
+    maximum: 50000
+    default: 1500
+
   monitored-battery: true
 
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cellwise,cw2015
+    then:
+      properties:
+        shunt-resistor-micro-ohms: false
+
+        cellwise,battery-profile:
+          minItems: 64
+          maxItems: 64
+
+    else:
+      properties:
+        cellwise,battery-profile:
+          minItems: 80
+          maxItems: 80
+
 additionalProperties: false
 
 examples:
-- 
2.53.0

