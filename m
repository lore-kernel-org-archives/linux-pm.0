Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19F38B153
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305617; cv=none; b=hUeklwXz723mmQZ/gQBVh0ZWZY23Tginc8tSc3x6CgDmOp9tWPXB5fDAz2Zd7Ljjng29zg+l6oOGPyws0nlsDhP7I2xTHAWJ9W9V+cHAZq/s9IXpDHU807TpQIqGvqm56MRH8y6hhCGOjjQ2KOfnWdNi7oDutPH7IQT0Iuko5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305617; c=relaxed/simple;
	bh=W5y1CEZ8x3weotGzpcVAX62nHF7LuH3mbybRf8eZOjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umOGBC0ssv9BgRxajCOiFFhchesfEnwbaI8/ms8YHYd1jhW2VH+Webgwk6j7mGNXhPFldk3vOxbq8QN6S9MZ0Q+6ERwFS46BwnuIpda9GwI9m9/7i8tPhywWnw9V5enzodR5C3/NeoYSPq7269eCnuSVuz+Mn5/thDQIhjqIazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxt0djq5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxt0djq5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439d8df7620so522336f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773305614; x=1773910414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9h3ep8VhznVsw3SqQhxmTvwP9SBQRNbuVaMM8ratic=;
        b=dxt0djq5Si7/svubjp2K5r70eANWE7Ywu9V+qI0WQ55DtsX4d3zw0MPmlWQSRFNLkQ
         9r9JKi9esaHXp2sJDClQJgcdNW85ZMK6G0md2nN1v5eTUJkA7C9wm2+FZ0uokssUVhjd
         Jq5nRaCRpWEjWji8FT2VvqZiHMFfX4/pBy/MiVFa9D3hyk0KziU6vZ9JrifbNhz8bIJ2
         fhZzxddGA+bJEYnNPC6pHOr0zEL4HAW4PRT4RsuPuTWLNmipeQxPN0d5ozF+AvCOJQzx
         gwb/54h+qc4qFyFMgUs8rhkP2R6KJ10k3mkxxLuWVBBCrk2hZa3yFxT3IsBatO4Uxc3S
         GIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305614; x=1773910414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9h3ep8VhznVsw3SqQhxmTvwP9SBQRNbuVaMM8ratic=;
        b=EB+IZ17Wt+DEP6IUDDUy5An9EB3gAGDbP+CKDzxCsm0NyUOLpT2xtcKWi8yNeKnctE
         l4D/vuVonMa0t3dB+Z8Nb2iziQBXVfWy6O7R022RHm15+I9Ex8smgM46jkYdYqqe96e+
         gqsZsOGwVSPwr9i+MkCT4VcW3UUanji4OkfB/Tymbx6X1D8hMZ2oMPdM5bl/zk1gPmR+
         S73AIOKwIMGmYtzRjIyQYxNtp0zvQXGvH4Tb/a0GKwSArutb7kCpK5vhKo0Xc7f4isGq
         sXWcJPocT63c88MZwYaxI38PhHIxUrbLdPOg+vgGfpaHgFfZsNnmCj8UsCJBuI4fOP7b
         Vezg==
X-Forwarded-Encrypted: i=1; AJvYcCWsSraJvfEjEeT+oY37UAlSbR88jXC8mRxpYk8gFfyGOdzp9WwYAdUhD0MnKPLKX3O6E45qbpnmJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdcTewIM7dKyJMuG1reBivQrwl8CCh5Kqii3DvRdXCv7JW4/s
	EbcsFzQd+UmvSQGKtlpxd0uegxkph6IfW1T9OCEt8RnBCOvOKyK+EOEq
X-Gm-Gg: ATEYQzwPmHd9h9tiigl7R6qS/HvURxOU0Ao/x6s0pL33uaSou4KO2y0AkWEBLuI8DOD
	Nb8J7CxhAChbfs3BjMUD2alu/QVkwqL+5Wi7ZvFcF0YcjFYVj/DR4Ts03Jqvcq1DygrEenWroCc
	1tmiytshswzQmbqHf0Z3+yX812pNfkiT6a44GWiA/Icw+ehFZFfiL3w2i7KyI6ZEjzZM0wMfzpo
	UN7nZPoNbc4Vxv7cS/mPLFgJ/1gqdSlxTDAlNpPxjuSYP6axSOK0uTCPst5zVZyHMV4OqfVwQbV
	iHSWCw9iUpxvxtqb+ytEec9RozGkRwMuOLTSXVse8CdBJwUYacTnF6KlIqP7//HK0x6+3Fu//bX
	gSVWquaw3jv5ByipkQUitlsJXGweqEDjJssBMYNJD/p26KnbCt35sKNuwTTqUK/XQt0y0ugJVya
	7ji03XBeB2KI/c0VnOwGulXyA=
X-Received: by 2002:a05:6000:381:b0:439:b2d9:cf35 with SMTP id ffacd0b85a97d-439f81dec1bmr10881977f8f.8.1773305613993;
        Thu, 12 Mar 2026 01:53:33 -0700 (PDT)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe226473sm5449162f8f.32.2026.03.12.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:53:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: mfd: max77620: document optional RTC address for MAX77663
Date: Thu, 12 Mar 2026 10:52:57 +0200
Message-ID: <20260312085258.11431-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312085258.11431-1-clamor95@gmail.com>
References: <20260312085258.11431-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document an optional second I2C address for the MAX77663 PMIC's RTC
device, to be used if the MAX77663 RTC is located at a non-default I2C
address.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/mfd/maxim,max77620.yaml          | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
index 85d7fe0f9f85..602711865274 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
@@ -17,7 +17,17 @@ properties:
       - maxim,max77663
 
   reg:
-    maxItems: 1
+    description:
+      Can contain an optional second I2C address pointing to the PMIC's
+      RTC device. If no RTC address is provided, a default address specific
+      to this PMIC will be used.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: pmic
+      - const: rtc
 
   interrupts:
     maxItems: 1
@@ -192,6 +202,16 @@ allOf:
                 maxim,suspend-fps-time-period-us:
                   enum: [40, 80, 160, 320, 640, 1280, 2560, 5120]
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: maxim,max77663
+    then:
+      properties:
+        reg-names: false
+
 required:
   - compatible
   - reg
-- 
2.51.0

