Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468586;
	b=lYhuzT2A9/7as8womJ+2wu2JaBEKv9hHETTdsY317QcN7vJdI1dkE6xdXoYkTJYzKE2d
	 m7pokl31SZHiG7mRsIbYlzHsYulzY+iLiqTkgEoThhUmThK411nq1yksIcYvllvv07aU/
	 KtQNMhBBwer7RPuyj9Ko1JzRu+zbBAxg2oVLgdhzc6YQSenWikNpz+ykZOcmbMC0oMUcQ
	 m18HMgHVZDxPTyU39n02NRf2pLr7O/z40tFpH7FoF2CiJ/+xIRjkagmm+pUGnMoBOKN+j
	 zo2hvt7urO9V6AAmyZoHUguV23qD2vL3yadmiY/LRfEEsZG6Vp5hfFc5YdF+RHhicoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EeCGyqkm0JqSOK4vQP3xUOcJ8X0Mgwj1dqLLK6KYn3E=;
	b=4yC2BA/Zgxbc4Ti7J7pJrkEOr19P5ruj7I0oLbMlL+tZXdSvwxE8mv536557Yyy4KXLq
	 rWjxzEHo3oNgKjVnYDFhNfNndr7USJLLWb01JT6TfIAr6lF7uzhrqKcWndfVhZ5H6an/0
	 hFFj5Q6zbfNlpXIBl0VkS3UgcvqOt0aNDfjvlPnM8aHm2JuKjk77MzFz2NrVQ3bj0tMZa
	 q5zECIdCweISlcdxJiEKr3tN44qI1/LsDELqul15zQKzAWEP68uAkAqjiMYTCkM5fgk2x
	 E10MhqOKO2A8vJ8ibEPgeT+iL+iFz/ZlKdR22FE693oS4yAABarP2UobGMQX86nJc8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOmxHypx;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E71606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 07:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E71606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOmxHypx
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so339154b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794468585; x=1795073385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EeCGyqkm0JqSOK4vQP3xUOcJ8X0Mgwj1dqLLK6KYn3E=;
        b=gOmxHypxd4O4PUIV8u4WBmDa9ZbYNZauWX/5z3f7n4qIiWsDVvKE5ksPpqLRja/Fx7
         syfnGKTMQKsemE9DYKzof9wMvwuaztIhowiACaT0TZDl2pOO81i/quJBa3z/LYcLeLFb
         LHLT3TGVFFu9puCuj5J7I9JfcDHOGL64+8CR7MaaFPNUfRBXnXAQC57Tm8yTM6qXapGi
         ShbuZ7OSvxHpcu/7LR3pJtuh50Q+rJ69QRVvanQmFu5dygF7+yJcjuuClLFJIrfc8bqC
         l1LgjEVXtzdnU0e25i2m6CSiRhIjPPcTq2p9iM6NWTrI8vjlOl6RkQIiXUNbYY7i20HI
         l0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468585; x=1795073385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EeCGyqkm0JqSOK4vQP3xUOcJ8X0Mgwj1dqLLK6KYn3E=;
        b=G0kt7NEmOcGqzOv7XWENumAlEqcE7XJlSAwDLPlKIHZkSusT9uurZwkb7Ufo3Yd2lZ
         B+iYjNQVh4KCmg1P2EJsdYhBzpqGSv66HFLtrfKK0vbATKdBzt//Tq3vjMnbwK49eQUP
         MQ9uTeRES7qYWWWv4IrSy1snGS7gdvulC9iARC+qqu5yvYJBikdC0v4BZ7gjfjLJYS7C
         LMnqVFIOIfl/nGcwnIcNqTuKDQhH3KoNVpMntFtU2BZGGP/crI/hyIt8X5zrpzAcRaWm
         2hiqPRNctZyVqzoVjN4SqIWE58Qs5GIAio1+6m8FQMTaMeAgbXc647iP/wwPixOOxu4t
         UFZQ==
X-Forwarded-Encrypted: i=1; AL+hErFK6dhROwlu6gRw1gYY9hMwh4kjQBnjRPAAE+vURRko+Mn1u3SswndUDOwAqVfUuPt8Mymleuhi+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9X0qSkWtOP3cKxA36LgIp5aVwjV4Om/b3QQQEKAHN+0+bwPtPq
	Hrdkv+4ij0yxCvaZBmnNSOuQiZPh1rHhn1wj97Sx3iqKbfW8azhnWqTM
X-Gm-Gg: AYBFou21pidEw0kd+eQB+vTNZm2nyVFa6oYDANy8aZwMdrSZwH9EuYftrlR5Blc+jpC
	kj3CtMq8b2/QrQ9HhrCO66nRwR3S6LqH1429kwdyrUSeXKZkmmkbeBUQJq09NAzqU6k5lSgLvok
	4ULAgvP3JtRw/pii0ITArEn6eaAJAPVHweeygrJNdzTfnCXdtwUlmHh1oq+/z6JGOfzSDt/4Hwo
	WkNwFvqcfqTaF/rxdDdOejQe9Kry6NYDkGsOGnqyHXlk7Gh2YfSmFuOXEXlasxDlLxNmDl4oY4l
	PzJrdb39dPlo9osWqx5G40P0IsCn7bamNpjs9nZ1YrQD0oGRBTuCcvudvZ8MBjzXSS3rey+38X/
	Qyoaz8pm6+d9whfMZAxpgdX/jeGgo3mHtWgzNVyBZbveR1jOzqF1ysu2YjvQqkxHqiorV2MQn2+
	kjHptLwCG5H/R8t8DPVj1v9oVhjNuabjBOBvbdu29m8IwkNrOv2QPRGbW0wORBD5kVjFy310DzA
	AMW8v3imw66XO9IvMIw36JdPGnMNtMRhRJS9J8TVxlYrpY20Z0ptJR40ssHZvDGOxgJ4tWWaEbq
	4NXU3zoJDeniQLTO64NQWaNRNBvcl63ZND/n3gdTRULbak5ABwLoSKLDxNSP
X-Received: by 2002:a05:6a00:451a:b0:8a9:b07c:7709 with SMTP id d2e1a72fcca58-8bd5cd78ad6mr1206200b3a.19.1794468585366;
        Wed, 11 Nov 2026 23:29:45 -0800 (PST)
Received: from shaunak ([43.242.208.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8dd5b4sm2980797b3a.53.2026.11.11.23.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:29:44 -0800 (PST)
From: Shaunak Datar <shaunakkdatar@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shaunak Datar <shaunakkdatar@gmail.com>
Subject: [PATCH] dt-bindings: thermal: kirkwood-thermal: Convert to DT Schema
Date: Thu, 12 Nov 2026 12:59:25 +0530
Message-ID: <20261112072925.22075-1-shaunakkdatar@gmail.com>
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

Convert the Kirkwood thermal binding from the legacy text format to YAML
schema to enable validation with dtbs_check.

Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>
---
 .../bindings/thermal/kirkwood-thermal.txt     | 15 ---------
 .../bindings/thermal/kirkwood-thermal.yaml    | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
deleted file mode 100644
index 8c0f5eb86da7..000000000000
--- a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* Kirkwood Thermal
-
-This version is for Kirkwood 88F8262 & 88F6283 SoCs. Other kirkwoods
-don't contain a thermal sensor.
-
-Required properties:
-- compatible : "marvell,kirkwood-thermal"
-- reg : Address range of the thermal registers
-
-Example:
-
-	thermal@10078 {
-		compatible = "marvell,kirkwood-thermal";
-		reg = <0x10078 0x4>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml
new file mode 100644
index 000000000000..1f9b97bdd48f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/kirkwood-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kirkwood Thermal
+
+maintainers: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+
+description:
+  Thermal sensor present in the Marvell Kirkwood 88F8262 and 88F6283 SoCs.
+
+properties:
+  compatible:
+    const: marvell,kirkwood-thermal
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@10078 {
+        compatible = "marvell,kirkwood-thermal";
+        reg = <0x10078 0x4>;
+    };
\ No newline at end of file
-- 
2.53.0

