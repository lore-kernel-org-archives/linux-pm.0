Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54623EEAFC
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229495; cv=none; b=QFeV0pjmr7RkRuaBrIoSvGb9YAe0FWUrEynRSSSelhuaRrOkx2dsZG0YS31fkB0wIHWW89PVwxAC2O8xAmiIuu0np5twD5cz0bk4XO5bkD+PlAQCZ8/0KJv1ekcgFPKVgjDNBs3DYVzN68/PSX48cDdF4eQerSPEZWqo/LqvQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229495; c=relaxed/simple;
	bh=7KRlzQ/CYy0m0GRFXFkovzRgNDiKVQyaq7IP7YBW5eU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lhg2iZBjoy5XLcAA5xKkXBpjDlLWU6OHfv2e0O0ov9ETUCk39PQMvazIErHRgE5rCuGpEk1TUbJS3ziGlKnyurySm0oeIku0VDpXWKdMYtEzCHa3PHsU8/4N7saguHqJRt4oOyuRUxLzTEyc27I/dIgaxUEPzh8bFCVwJ0PkQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqbO7TpH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqbO7TpH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so20240715e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229492; x=1779834292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b06Obgvy88lKtCoTzccRlIplQ4+h8fmj3ZHd9P9fJhI=;
        b=bqbO7TpHQvMXjVuO5pLHhPQ79Fk7Qpq/wKfrshkkNI27kf373/AkVhUrIuU57wX9ng
         VYAh8j2vevvBqXhE4g9ttiYjOECCwsdaKMsx6KnIIxmXP2Ymjatl2rgReVk02w/ievZW
         P1Egacr2H0xYoVrpWVyDrq+Vm+K5o6yElYn2th658PKirPpHElmhkxZC0vayauRIWzlC
         4EPatbU1Vh4TJpU0z9fjVfjJm4yudRqpdGDLHN1lxhpsjKAkMTb3uEwSWhJ5p2h8Cu61
         kUaP0KpmtHpxv85yEzwK6nG9+HmL8OKgl1+jp0w8fTc579wdCQLqrtuFlqh3LF2esJKH
         tnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229492; x=1779834292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b06Obgvy88lKtCoTzccRlIplQ4+h8fmj3ZHd9P9fJhI=;
        b=c2cXW3Ds0vkc5WCxynpnfwoY4MqPuxk9eu5O8ytMQtXc7fb2gmavtgSMLzHRUmml7P
         3GWYMFQ61jzk4oqWGvB3kWZ1YEqnIGLuu5XM6P9tNFJQBuSd09c1IPF46XgJSnKWQlB8
         SbTUiQ6lLqkShDAxWiDtxpMbO+jT4nTru4devArOVfo5uF5WM8lGe4s8nlvu2apufbTx
         GSV4ap09qts5JcQDNhOqVZfhgHvXhTrJ9uJSpHKJpWV/4v06pzYcck/75VtHZpyQ0YWh
         CKWIb0pFnD4phOwkgKuKq+yDsgKFTRqSYRufS4eswTiriUg5SIDhtiCqqGm0J7yAdA5i
         TN7g==
X-Forwarded-Encrypted: i=1; AFNElJ9r0As86gy55G/jvRzs6nRG7jHDhEgKh07HBpC60JhXuKcKHNQx3zb10Dj1mcRLB0kTAu0+ynn0dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmsDw8EUqu3e8Xft83SBR7+1Q3kJZmr8eQBaZGTlOhaJ9PCd8
	SLllf7wjfv+CTUB6l7OSBByAQ+TOLBF4lucRvygfL3h8vQnLElyLUGuS
X-Gm-Gg: Acq92OGwTXLLGrakeZ8BY9wnbYIlXc5Ro0p8FrXfJAcQxet3o8gISwZhZ9H6d4eVAln
	+yn+VkIdxLP/s3jMOJIykBDvtp554Km0Vn46GWGFeiME2z2f3DWTfUtQjoSO1L7n6wLFcq4BZLe
	71NbaiPtL58+4CWKfcv+EpCVzC37QK+W3dCZmahwlMau09TD1r7i3Z5mUl2A0/8fxhyOkw0WdNf
	Lkd/QYiTc3UR5edFicJqw60k8CliLXYFa65VHAHfnH2EibdjE6Vlmt0xdkvn9zSYlRqUQJPqLCQ
	3CNh06Z8DeN84q1OwrVVoXXCNsmbiQSoO1LXblbr/ZpUU8mxB5j62QPFWF410cybdv8Z+txo07L
	GWb8ej7cbO+KHyxtZfOZhrhac6peN9rDwZOz33Yqyw5k30xsdHCEG4qLTIGqcuQCyvWrMt+yq65
	3CG0cadbiwQ+M1s1RyZqqcQetIXyXoSch3BXdkqFupwjclkLX5hlVGd924aO/6c7EDNDfNaS8=
X-Received: by 2002:a05:600c:34cf:b0:48e:5990:9698 with SMTP id 5b1f17b1804b1-48fe651588fmr340150505e9.24.1779229492142;
        Tue, 19 May 2026 15:24:52 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm381097435e9.3.2026.05.19.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:24:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
Date: Wed, 20 May 2026 00:24:25 +0200
Message-ID: <20260519222433.29684-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519222433.29684-1-ansuelsmth@gmail.com>
References: <20260519222433.29684-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN7583 chip-scu node.

This is similar to Airoha EN7581 with the addition of the presence of
thermal sensor in addition to controlling HW PIN and other miscellaneous
pheriperals.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/arm/airoha,en7581-chip-scu.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
index 67c449d804c2..0d042fb90a78 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -18,16 +18,30 @@ properties:
   compatible:
     items:
       - enum:
+          - airoha,an7583-chip-scu
           - airoha,en7581-chip-scu
       - const: syscon
 
   reg:
     maxItems: 1
 
+  '#thermal-sensor-cells':
+    const: 0
+
 required:
   - compatible
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: airoha,en7581-chip-scu
+
+then:
+  properties:
+    '#thermal-sensor-cells': false
+
 additionalProperties: false
 
 examples:
-- 
2.53.0

