Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398640;
	b=Ry022mvCfjtHLnkWXK9LPA36dIeJ/xZPwoiYFMmOtzy0klKKHKHga2sFJQTCAlmuGd1C
	 uzNL1BJhkT3EqHpab7aq63lhIA4dr62B5cMdap+dLJqk0sFtJdW0PMsO0jGAKoe59+FAW
	 W3DTR8GqwQKTGYm9iNQQljiuGxGzFqr+Ex96APnMHG/hdpQOIwN7oqR+6q5tjTBef+XXO
	 rGIlNYOQIZl2bvs/fF+vRFn8hcUL18qEQp5bQFwXwar8hzReS6Jl8s2Zc5lmhU1kZKKqf
	 IKgi7uqEerDPUw/hnPUuwzQKfdEAjKlulq8amIVNzDN1t0KdaigqfgadylXO+N0KzCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8DwRmjGjcZQoXY2ILH3hB5x2vfhtY7WuYsGRx6Zuzow=;
	b=O+6/jYU1C4Jkvv4YHVENTbbH9u0c8DzB+KjDlsggNz7fCikucpRKWVr1oLRtpHh2i539
	 1FviZ9uJJwfEXZDo/X/17tpY/z3O32SmEzTDqfDGJYSZHYfmurag8i/nX+DHI/2bCgbPk
	 PY3ERu7RpaTJI9TJ0EKICWk5frzX4ne+DsrZfn/7c+1DSrK+oeYZPwYnWbOVqXaXo7mrj
	 MW2lvrdyKmCfB5gZotyzEE8GlOJxda1RQ64mS+TsULT7upjJQidoGCSG/b8jmJaIjwA9V
	 yu+tDtGkYReUXCZIJHN9ZiMQBtfYO0lwl/Xvm9XTGXFI9xroR5y5OJGNC0jqKDvFXyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpdTssoi;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE2606A32D
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 01:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAE2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpdTssoi
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1850137b6e.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 17:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795398639; x=1796003439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DwRmjGjcZQoXY2ILH3hB5x2vfhtY7WuYsGRx6Zuzow=;
        b=HpdTssoicRWOCZQt1XSrQcaLQBJJla9t/d1bwktAM6j6D3O6gM8Cyq7YeZBKzAl06L
         +ua78IfU4jaX2qmYJHPs+KOCUaEbff6kMw9QjhT+qc7Mt5nLtKNBSfHXsSeZMNomkppF
         c1KvZ1l18ClkFavZ77qOjCV8nwC1OggD9GPLl7A4e7sd3z7sijqICL/K6cKQiIouYXkE
         RMYB8et8qkPoOHNjMJkgzotqO24rgtho9dQtTYikB/WLiv1gWzECqu0tLdBQ+Y48hmBh
         xS0xeKoXs3bq7YWxNtOniO1bxMCtRE06GuvKCUw0LuxqZFJXjB1w8Z3JqN1asja4Umpc
         13IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795398639; x=1796003439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8DwRmjGjcZQoXY2ILH3hB5x2vfhtY7WuYsGRx6Zuzow=;
        b=cBsHOi0VP1eD3vGJnGSdCvmhzcqmS9QlZX1VCbDWaaQE2L/nqc+DnT3vkm/S7lS08f
         rF4E74eHQD7cuKa9DhnUcmeVJgDdImwlHiecFuUEZc16TWlv3dJbPuHw9b3Dn+4XAM3u
         TgA0e28CsCG6npk2dUJ6N5pje7EHfH9rhPL7VcWINrsXfrocAsU0oQY9x2U4J+a0Qtpz
         +B3N2NSXVbnFMB0/2ypyFmtjNDaR6itV2zTiISNm6Ui2ffJoaQINdjtaXx7bQleGXWvH
         uUTDDQKD2VhJQOJ147eLR/GZF/cuSXVKSNc9AqqBhF5w1x3s+7QdwZhSUEXyxz1tg25o
         vH9A==
X-Forwarded-Encrypted: i=1; AL+hErG8sVcphJRoOPU4VV8/f8B37iWLk5QlCqkd1YEuV+9ISN3m4txtGn2QEjOfbV9y1ZPVBoc3MWyNBw==@vger.kernel.org
X-Gm-Message-State: APuU4Z94newz2XLSF2VLfqmQHpcQ9HU+CQ17l9qS1bQM87kMOH29F1Hc
	Xx3WyxOIdk1NY5eHylecll1D672jFmj0JQiU7flwtbARkIfMWX+hwGB1
X-Gm-Gg: AZFdTZdlH+tj9h7qDTpNKmrBaGLe1yBkMBFqIyu6a84EiDCO+Izf5CyzGCKlKaN2Pf4
	DF8MzMIb9YJHUeV1Fek/VnuTxYtyGDGwBVhYu04N+v43lhqoZGl83QK/Z2hRUcy5qc2HdfBg0Ty
	2VVw7JaDeAh7CS0BtqN/OjVOeix2sW/QF45uvJFpCJkN48ZLDpX1Usc2/ekNdys2S0kHtxlpz5f
	3/HYHRYQU0EsLHuaidAxFp/40BLCwmVqNYxtv8tD23pcD5o8RGASSSweg0ZQ705e/BG3/bP54nx
	Bl48ZEjdBgfnljt5UUGniUp3tJ20RMNl+9nNkRd5h5qSSBeqRppKP9p3+23XJDXpPX8oGIEH9pB
	BEaQ468H9135OCNwjE9XKo1kHxP5UrYrP2Rkue8OXVn0uytnTrAkZEA+cjm6GxDwtI0j8WGsChX
	b+g3+CipuWVrLXWjTMrubqD+Zo5Io0RZnrWCLKNAu9Cvt3s1AlTDPWKxEqvzmk84UnkD6W7pSnO
	jQxLpm2PeogQWu/TPk6C4l05Ie+r98kjZMFE9BYE9SLxR98WRiIjq4T5u6ydZMqXFN4ucFAZYHE
	3dyF86uDefzrtiOexWtaIMHP4dnY4FWAGNngwZ2JxSrmm6811ew=
X-Received: by 2002:a05:6808:2208:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-57a0dd479f9mr13048388b6e.67.1795398639463;
        Sun, 22 Nov 2026 17:50:39 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm9209484fac.8.2026.11.22.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:50:39 -0800 (PST)
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
Subject: [PATCH V3 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
Date: Sun, 22 Nov 2026 19:50:33 -0600
Message-ID: <20261123015035.369192-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123015035.369192-1-macroalpha82@gmail.com>
References: <20261123015035.369192-1-macroalpha82@gmail.com>
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

Move the minItems and maxItems for the battery profile to a conditional
based on the compatible string, as the new monitors require 80 bytes of
firmware instead of 64 bytes.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/cw2015_battery.yaml | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index f7bde324153d..992cd5f6a216 100644
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
@@ -31,8 +32,6 @@ properties:
       it is to mail two batteries to a test facility of CellWise and receive
       back a test report with the binary blob.
     $ref: /schemas/types.yaml#/definitions/uint8-array
-    minItems: 64
-    maxItems: 64
 
   cellwise,monitor-interval-ms:
     description:
@@ -43,12 +42,42 @@ properties:
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

