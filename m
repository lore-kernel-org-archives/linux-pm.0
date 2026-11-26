Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720768;
	b=NN+xwGYOLIxnNPb3RuBGE+S0UsaMxMnJ7Kfldu6gFjPo4p+u55MOvE3vpCNtcEhNj4Wv
	 KzzL8Q1ymp3+4H+2TukawEcSWrNZBX/B3DjTBRKqnqbccr1Dlb2Gcc2uiEg+cjZk1pMfx
	 WsA9kb2zX5sWwBHj2tLB3eAA1GKhWS1450931f4oMaCb8N+8Vj2mV8hNcCkw1Lg8mABEN
	 6hAe8RLBqq+z5OPK8mzURvdhm0QtUzymRrIsWrOTx/QIRDYlusOZFnQZ6FKXi5hfrAwXj
	 XW5FpRS/rvAi9NcWV8iWyA/AGla5ztikXhc58McfU5nI/puoxUfZx8Q2myFw2GP/z7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rkm7nMrRKwRzVgmhVYxHUTIkns0RjHhFy2fC/PXx4iM=;
	b=iAmTpeyKVtYyY7VZlnzSLIXW/L9bzmU5fJ3zeUIGNNDoqPmb7ZEh5NNinUtc3aWC8VTk
	 nvMOxExOb6S8Xv1UEJELqjBdvUzX7I0agT5Q5Xyx13TcdnxFEX8uuJ7gpLwwO3gCzheB3
	 lNgRCis/1CoOTI10GcpyHA6SNSb7HOr4jfjn+GY1wzOgRpw5YvVc+7A3Rbl/y7fbuLnqw
	 a5LSlsK6TLI8DjH4fAMKz5siCSsBMPApEv0ChiX3EU6GaRmOszWlPqfqLhZZQLrOft69B
	 yzbi+xt0dKNRMAqn02eZdT0VfvLn32ph7LsJTCntlNAEh2e/6eLY4ov91swcgmQ0E+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gG5GgK5t;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F04606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 19:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07F04606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gG5GgK5t
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3acec6677so11146506c88.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795720767; x=1796325567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rkm7nMrRKwRzVgmhVYxHUTIkns0RjHhFy2fC/PXx4iM=;
        b=gG5GgK5tth8He/HzZX0vKu6b7/SEmvGf+sNooZWdZl2sxYXUlsqrErMtuxcfYDHsyF
         f04R7qbe/ymvqDNFWgWgAf/YJCCtAYD+fVoGhaRlXY1zfzuZuLjwYRe8qJZDsXI4Z6gS
         R1iMo65zbw/w4YsG8u1GuvjbW4qBlcoUdhwg+Udlcx333870hiAiuCzPf8Ls8ief+/vR
         BtecmQsXmexPv9CSvZvYpBmJPmVmXGfBOvAj6/55Me6UzpsviLL7zUkaqicVMyReXb2N
         jHRyr1kBTr6IDTmpJiBO5/c9b50GdkYLC0T80zFbrcPhxuljMP4jo5/z7mmW6AvHWu3m
         V/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795720767; x=1796325567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkm7nMrRKwRzVgmhVYxHUTIkns0RjHhFy2fC/PXx4iM=;
        b=Qw8E/sEjgjt+mnQNebjVLoRZSEpkQhtmBnVRRF4vrEZ3XcdzMD+N5lmAz5pSvb5PwS
         OeY/+cJNAUJSxtkf5+ReK+cvEhWvsWd6tUVzSdX1ffhZ4hmW6Dj6/bvsVUp3rxwPbxEP
         a2Y9jymdmvRQzsiWgu5f6wERl2C0dKCT6GvtXYUP/S1wx8L1wPLfMLmy/pgrBLdYw8lh
         ECR4DTVQo4OMnqU9HfMBzSSI89SgiramxXLznA4KMCIG6eizqQICromnIk1Cf9pXgBIZ
         gs8MHAOPNF135bCnJv/L1dzjVYlJbT1SkTWk5JnYfpPB99fxVLCnEG299LZbgBVhlJmv
         iFwg==
X-Gm-Message-State: APuU4Z+LO5GovZrS0E206tVsGnCCBCuwUPKcWucg0dMjDygMLMCmnE1r
	J4qo/OghEuc6bFp7GmjpjeLKfKnvsSLE2sDdd1qk0PPYrDMhfhnSRSTu
X-Gm-Gg: AZFdTZft94AlUC6bPWwyj6qe12MvkLDlXOLyZYQaKnY9dOJ1K3dxCvtyoZVADbcNckl
	dCtsVtV8RUfWp/FFDWxiAOpHbkXXBVHR4OM9FMlkyYaDtJuRlxWwspb8dBwunMlufCUSrWgYWXP
	CnFdtA+hZksKwPtPocevSEsR9tVkUw+iJJOtj9kYesQG7PS4ktkJ7OONBib9mPqrM1gTPY+/BCW
	K6NXp/f9iAKgaHbIzfSaJ4ObvGZ2wcXNIZe6pYGioTBZhbOUWygSR6e1cu3XE0l/Bnp7lA8yfE8
	1nGXiC2kDchjhgWWCsztmavW0RS+0PBMBOE5rpZ9a6HnqVhce/eH+LCb159CFs9zbTBsdKjh3kG
	jtOD6zvi1tMnXTNro8sABud9KFMtOSyboD9W6XkDFDKNL6Uq2KWtb2iu2g6pD+vBaJNrifxlTSo
	dkOWB+wJqrgZOvTZdMrrU6vm8MIxMJFrihoXLmuw4tgb6ZfxuwcZvVrs6S5JTuopq2MsUHgEqfa
	HekSZ3N5kyCQd0WGUOG9pZC2LnrVuUdNXuT+UOe0Dm+ArccFvmc7wEwmyRER2ZO8O+Fe7dQNTNl
	XO6IFWacQSdweoK2egA5EnvrKp1TqIdorY4vD6akG1vPLd8Q
X-Received: by 2002:a05:7022:3c04:b0:188:e51:e86a with SMTP id a92af1059eb24-1b5567dd1c8mr17611027c88.2.1795720766907;
        Thu, 26 Nov 2026 11:19:26 -0800 (PST)
Received: from mrprachoday.bbrouter ([2402:a00:402:9f97:e752:d178:849f:9d04])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm61339786c88.5.2026.11.26.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:19:26 -0800 (PST)
From: Prachoday Sutar <prachodaysutar7@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pali@kernel.org,
	afd@ti.com
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prachoday Sutar <prachodaysutar7@gmail.com>
Subject: [PATCH] dt-bindings: power: supply: bq27xxx: Add BQ27Z558
Date: Fri, 27 Nov 2026 00:49:06 +0530
Message-ID: <20261126191906.25708-1-prachodaysutar7@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The TI BQ27Z558 is a single-cell fuel gauge documented in the same
Technical Reference Manual as the BQ27Z561-R2 (SLUUC54). It uses the
same standard command set and register layout as the BQ27Z561, which
is already supported by the bq27xxx driver.

Add a compatible for the BQ27Z558 with "ti,bq27z561" as the fallback,
so the existing driver binds without any code changes.

Signed-off-by: Prachoday Sutar <prachodaysutar7@gmail.com>
---
Tested on a Kneron KL630-based board with a BQ27Z558, using a vendor
Linux 4.9 kernel with the upstream BQ27Z561 support backported to
bq27xxx. Voltage, current, capacity, status and temperature read
correctly through /sys/class/power_supply.

 .../bindings/power/supply/bq27xxx.yaml        | 72 ++++++++++---------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index be0f1f729..28b04732e 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -18,40 +18,44 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - ti,bq27200
-      - ti,bq27210
-      - ti,bq27500 # deprecated, use revision specific property below
-      - ti,bq27510 # deprecated, use revision specific property below
-      - ti,bq27520 # deprecated, use revision specific property below
-      - ti,bq27500-1
-      - ti,bq27510g1
-      - ti,bq27510g2
-      - ti,bq27510g3
-      - ti,bq27520g1
-      - ti,bq27520g2
-      - ti,bq27520g3
-      - ti,bq27520g4
-      - ti,bq27521
-      - ti,bq27530
-      - ti,bq27531
-      - ti,bq27541
-      - ti,bq27542
-      - ti,bq27546
-      - ti,bq27742
-      - ti,bq27545
-      - ti,bq27411
-      - ti,bq27421
-      - ti,bq27425
-      - ti,bq27426
-      - ti,bq27441
-      - ti,bq27621
-      - ti,bq27z561
-      - ti,bq27z746
-      - ti,bq28z610
-      - ti,bq28z620
-      - ti,bq34z100
-      - ti,bq78z100
+    oneOf:
+      - enum:
+          - ti,bq27200
+          - ti,bq27210
+          - ti,bq27500 # deprecated, use revision specific property below
+          - ti,bq27510 # deprecated, use revision specific property below
+          - ti,bq27520 # deprecated, use revision specific property below
+          - ti,bq27500-1
+          - ti,bq27510g1
+          - ti,bq27510g2
+          - ti,bq27510g3
+          - ti,bq27520g1
+          - ti,bq27520g2
+          - ti,bq27520g3
+          - ti,bq27520g4
+          - ti,bq27521
+          - ti,bq27530
+          - ti,bq27531
+          - ti,bq27541
+          - ti,bq27542
+          - ti,bq27546
+          - ti,bq27742
+          - ti,bq27545
+          - ti,bq27411
+          - ti,bq27421
+          - ti,bq27425
+          - ti,bq27426
+          - ti,bq27441
+          - ti,bq27621
+          - ti,bq27z561
+          - ti,bq27z746
+          - ti,bq28z610
+          - ti,bq28z620
+          - ti,bq34z100
+          - ti,bq78z100
+      - items:
+          - const: ti,bq27z558
+          - const: ti,bq27z561
 
   reg:
     maxItems: 1
-- 
2.53.0

