Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210104;
	b=y4XXzW6JyCNox7nlJ96bTbrfiq/rNaHZJ0DgyJuDw6YIl6M4STUuj5wknxJr54OuwMss
	 azgSTLG1HpGULr7/8tuArQwi3ytMJBa5h6oEAhnyZlOsSuM6+w4N2TTYb5TYWv2rOxQOz
	 jMLTTQmODRoxGlh6MztF4n1JsNPqMs+xb69g7XEQTB1xYh/pTF5Ot1ZLsXb/LHZypQWF8
	 Jys4CfJi0fIE36jT18oFKzJw+0feahkc7YOvcKb+x7tryguPaaV5TeaoE0nIa482+pIJP
	 VxHbY2+ObpykZegCV3cGEca5BPHBupwQxXQuDlgtyjIiGStlY1S1CO7kqld6yxJ7MVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LXePsUP69J9BLo04WPbdbC0T2RsRqLHGKdkvwdCquvE=;
	b=Mkq2d7qC5eXhYcW2+46X4LrFNttlTLJpff0bsqMGWMK0UOHS0yO+QOgXH+VJuLbF+yuw
	 yLKkbZB4TKTw8rOEY9Dvvqg3i+T1KFvzXdLOffPSov5J2gVO2vE1UC1p0MuRbbCFYsgtD
	 ZFbX5NJqg89AA2tVENfrjY6NPmjg8M6jWlqwrTX4zGF+1nrCW8NuA20mI8uN4CiMRtEFl
	 dcvVXCBtPVyueFDx1NK10wZCpTeNHuc8TrQW9vT/LySw/VIv99B4stACVAtozGntl85R8
	 IwvJ0c9CJhOQI3TgRNHAocgyLwX3srFf6ELnqjn8p8fhPsjglDm3DTgNANr5M8dn4kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SCnC5M/q";
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0A606A692
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C0A606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SCnC5M/q
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-46556b9e02cso1005635fac.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795210102; x=1795814902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXePsUP69J9BLo04WPbdbC0T2RsRqLHGKdkvwdCquvE=;
        b=SCnC5M/qXfGSwGlKHnAFp/USEX4r2rxKw9pO9HZA0e4JG6ASuVP/47BZ4tZNXgydL+
         fs5LHuWg7QaHHoHr29o7uypV7g5KIpLpDLoPo2wNyQsIo/KYNj2l1SKvcJU7CJs016Dy
         n7VvAsaCTCiLGUP/FSrE4aogb25Mc4mP9ucgt6ZGi9kve9611vOZ2UCf9oWvO1ofbL3B
         nCyUSa/dCrKPm6aJtna2kU0WuWiSVJw2LFnmSv6z4jZzo/dOYadt1wMFxjdAQb4N9WLH
         l9j51wP7ahoANpuslO8qaTeKpF6in4E27hpsBLt4bx91Xp5piFCKl84QecIj/0FwSlP2
         r2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795210102; x=1795814902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXePsUP69J9BLo04WPbdbC0T2RsRqLHGKdkvwdCquvE=;
        b=reJR/L33ebAjk9xiw+OywIqeouR/Yxv5qSw9oi044QYI+EapUqnCIO5pMuS+/mxok+
         1iVxAJ/OMg5Omo1D6RV+pVSYzbr9rIZZZ01Z8eLpkzUP54kplgq9IveUaOz3htEZMdfr
         EOlrZ7JWX91VpYhKERVvXRMhMxhDzXrNOm1mv70LxEb07ldIGg8mxP4BuqBPAgYDeDuu
         A8fMQRqa/cyFc1YCzQJ/RO6GT5rmvy2gjo0gSOUllUc9tfRCMNkU14cMIHZrl44CvrXi
         vPNHfJWP3iSvkpa0UYF7GclvdHX8UKSkwC4vQfdDX+bD8WcfpfyqfkbF0ymZAkIzrAW1
         GlcQ==
X-Forwarded-Encrypted: i=1; AL+hErGiEeIuAIILFTTT9oxgogzNeKHmU+EHu7otdB+P7tMjSZGu2pO3skGH88abrzsABQaRXgg9WA1jnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IQAdhLEhQ0NyN8GFndZZg8Iz3fWHyQ9NKiIigSHNM5a6ebLeE
	WSGqExEW5tzuDRRijtFEOIvxUOOtbFioRB6n+hBvy3iLKEDcX3kQnppm
X-Gm-Gg: AZFdTZflqn3TNtTkGw5jHDLxo6zkObcCMUhBTZJ5wEhm/N/FNU+9ByqUD300/SfEks7
	TmCCF17I8wNYyl1MxS33g6dGGiYLRywIvvKUaqGwG56Q0eRGO2Gd5NVThTjJGWe2BviNJqZQnsu
	unF/0MAg3m1UiZafCWUCEt7ntBKIqYrua7Flm/aaQ7CTD4/vz0wU+Ub3MV5T4idStmR4U7pz/JI
	cISzYhccmpZrnuwCSQ5ItBOkHUKy3zu5gXR21VslAlgYSI94zmkSkRb0TOjlzRQE6cspSG2aJCf
	vzMVgG1K5qiI9xZXlWTQJH4XiSJksyNvuDwkvmAP56sFusGB7F2Lo62d+cK3iE55D+pzIdCqHzt
	aVJS5MSctEalmMrxy12YFneMu6if2WRHxjoSNFDuGDG+JAwt+Mr8shnbRCL3UMRdJb/yVz+nfgW
	PaKKWqEJfaSGlZ63vdVH5RODhfZ6y+wK5y3Kj5D3gNWGtfoNOvwPsYB/X8bJkC3n0AW44e9PM/m
	GwN/hGtBf/B9xiDIO86k/lmE0k9941paCHrMVW3qJH4ydrMDdcf0bi2r/4ELS9jv9YyCnjE4flX
	ARK1cm7ZmFKp87KZDTjl3YFJ1fIBMQ==
X-Received: by 2002:a05:6870:9d90:b0:4a8:15a:b062 with SMTP id 586e51a60fabf-4bc84f170d6mr2947268fac.25.1795210102525;
        Fri, 20 Nov 2026 13:28:22 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d766sm3774126fac.2.2026.11.20.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:28:21 -0800 (PST)
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
Subject: [PATCH V2 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
Date: Fri, 20 Nov 2026 15:28:13 -0600
Message-ID: <20261120212815.35663-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120212815.35663-1-macroalpha82@gmail.com>
References: <20261120212815.35663-1-macroalpha82@gmail.com>
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
index f7bde324153d..dce7c51e4e62 100644
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

