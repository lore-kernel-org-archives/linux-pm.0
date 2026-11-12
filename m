Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492629;
	b=5koQw0k75IXkEztZof/+xuH2k7hUkHD7JHCevPdatYcwXxu0QEXl9Rg2yeTXRW/qVDxT
	 GlqhpT3Amntg0cJ/pXd2eVSJxPEDTrfdi/Y6HojnlPKqjGsEylQnxE7jUGA/KVR1c6vLd
	 1CGbs2dry3/ZBNZCdbydv+/dreEHdPhGFY2g3IXRdn4zaaWTU6Orek9oF5o2NvAFMqI1m
	 4qjZH5hx2fYZ3JgJZg7QAxhHJbeXYbNLWQ7Wqsk45s0jb3UfSc7/Ywil5vPFsxrESwwEf
	 FgjOVwQXmJ+0Zna1oQZvDMwYKL+zGYP6ZDeOq7QWh8vkVVgjGzhj8pCFw/blRsknELA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nxyVT71yJJ39uTDbzVGV1GPiP5/ViVIjOJ9mvPoYFeM=;
	b=yGtlGW2kdjvOt+fU4xL7+vfSPHh69+CQ5g3h+urJ99LqzCWyBXbKXhDaZJ5hEzKFXNG+
	 AyPu8Z4z/w488+IAFUbhzR/AfkKIKWjNpBQIRppuNVP7TZnVTCzih+sSWG22Rlajwla/Z
	 P1belfQasezePLjCeGLrEkRUb4pxSoFnXxmEvH8iQgGnLtvbgxzodq5ImYe1o/w0x4HEn
	 gAmJ6QsI/d1nt85kCO25IRynIEVkoWzBk2uIU3CA1/PrA8BkNQ0y/LduGx4MVsLTQDmjG
	 Z3BDLoH0DEfB6jg9ago+HfDwTs+SP2+UYYTzszCs+qi0dw0/e5vo2l/nOtmm0fPwoUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8Y0FBE4;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3747D606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3747D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K8Y0FBE4
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9e53d011eso31877715ad.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794492627; x=1795097427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxyVT71yJJ39uTDbzVGV1GPiP5/ViVIjOJ9mvPoYFeM=;
        b=K8Y0FBE4DhhNIqwGaGuO5AFTOMp/htbHRE5tS329ho4N7/MfqqxBmgegsD6lOf0KG+
         HgV85XDx1x+bvSjtlprhzh5MCIJgpHfau0JqPLAJzO5jGAN3RUvydN6GBNiNl0ixh/My
         TB/xxX7DnIV3jMs+S3DaswsAD/VwXCIaYEITK3Wg7GMjKOYzWTkoIKCB96BzDNZaPrCg
         axJiZde1qwmo8j6LneZxyYNjSbdtNKPYsgDOnVRhLF6QdBCXE7mj63K1a3YL36Cq77xE
         YZfLFZadVy/OIXy+baVXbj/449OtDMI6quDxcfuWzatuLq0csO5nRcZ1rJRAe4vErmjb
         +hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492627; x=1795097427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxyVT71yJJ39uTDbzVGV1GPiP5/ViVIjOJ9mvPoYFeM=;
        b=hsHlVL4CmU5ct1OHuY3tU7wSdTAipSs5AxkUEg1uOy5VxoDKhTX4ssxINU0ga9AYmh
         6aAVvu7MnvgwKE+F3PQwD1Yagscl5Cz+K3+ZFl792EVTFuz8DqKRDE7LCHokYsTYQ1b4
         PK6+GZq2Mth/Wz9ImceTx0PGbxi1p7dRsqdxrU+r5bXu8HWgY7BEB4o0jAoIyWFpFlJy
         hG8b3RRJTvDmnACGR2ErazWd/dPSuQy7IHlkWadM5WgcEzJpeSpaAao/UPprS2JNUhq3
         WJHDwvB7finPNYWLxjS/iomkHRVe1sOQgRPWdTWWXUUYC8fgrfWaMQRVkOYIk1XxMfRK
         mUhA==
X-Forwarded-Encrypted: i=1; AL+hErEc93CR/koKoRj2gDmooLcUL3IWBMOOrOOBJB4ZtOdrhSYgeix//iAOUDh+eQLiCrlz4a8TnWZnxg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ra76EfjTW2ePjxINxJl+9QQPkC49OZpZ+HFi1YjqY5SdvNi36
	HdQg4DkzQjqTyG682HGtt5UNOKkiNq/fflnm6myJ5BrnBRbp43zp6lPW
X-Gm-Gg: AYBFou3KyJzCwrhura1ZddEfYUXDmZDjBSrl0NKAYxJ8ddRtfQHet7Is93ArjW+DbXL
	ThmIMHlDWjGTtF3oQ1R5X/I4OtW1TEQ7Vo5evzvpSHQRVd2asuHoXs5Eo/RJR9BV0H/GLQX7ru9
	a1voKsmqTgC8NBbWCqbo1K4ssHFqQIbITa90+zYxfkkxQhGgjg0/FEXsG6CoTD4EFNy0jL4G3I6
	yRa7Ix0w/rloZgGlWfNtuXZj0IbcjdyLR3ECx9rUd0cJkg8dqKHV9xt2b57qGePK/GyELXg0axf
	/qBo8l/tBNV69GVZaToZK6J0PrbjheaZ26K02Gr1NDe35EHXpy6wgXs2pV84pgCSxW+/Lqnd35E
	fO88SVeWc0lJEejhgE/B9/WVZfnqSzepGN0OpUwjGnz2qbqSvMUWTz2Wf5gm7gVokgoaE9/13Pz
	lWjPIsVgj6PG4lkC3Vq9nogKtqWSG/xZetrpr8emSCLwD8gcUNE+bkIRwZ3sSIXGYKksdO+MrRH
	2DfVs6COh/airxR2zaUo7FMZCUNFGlGIaUj6SFDcpuVG9fjTKiLaZ1BOdC89rTTDfcxb852pRNr
	Ycj7LR6doDQ//R4x2wVW37f/TvfLclthmapxFoDu3YmJy3Xfgn3a9ivZmXDz
X-Received: by 2002:a17:903:3887:b0:2e9:855a:12a1 with SMTP id d9443c01a7336-2edd7a223camr58869855ad.47.1794492627219;
        Thu, 12 Nov 2026 06:10:27 -0800 (PST)
Received: from shaunak ([43.242.208.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4dc3bsm34861925ad.17.2026.11.12.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:10:26 -0800 (PST)
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
Subject: [PATCH] dt-bindings: thermal: marvell,dove-thermal: Convert to DT Schema
Date: Thu, 12 Nov 2026 19:40:05 +0530
Message-ID: <20261112141005.229687-1-shaunakkdatar@gmail.com>
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

Convert the Dove Thermal binding from legacy text format to YAML schema
to enable validation with dtbs_check.

Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>
---
 .../bindings/thermal/dove-thermal.txt         | 18 ----------
 .../thermal/marvell,dove-thermal.yaml         | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/dove-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/marvell,dove-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/dove-thermal.txt b/Documentation/devicetree/bindings/thermal/dove-thermal.txt
deleted file mode 100644
index 6f474677d472..000000000000
--- a/Documentation/devicetree/bindings/thermal/dove-thermal.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Dove Thermal
-
-This driver is for Dove SoCs which contain a thermal sensor.
-
-Required properties:
-- compatible : "marvell,dove-thermal"
-- reg : Address range of the thermal registers
-
-The reg properties should contain two ranges. The first is for the
-three Thermal Manager registers, while the second range contains the
-Thermal Diode Control Registers.
-
-Example:
-
-	thermal@10078 {
-		compatible = "marvell,dove-thermal";
-		reg = <0xd001c 0x0c>, <0xd005c 0x08>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/marvell,dove-thermal.yaml b/Documentation/devicetree/bindings/thermal/marvell,dove-thermal.yaml
new file mode 100644
index 000000000000..a11611b3c6c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/marvell,dove-thermal.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/marvell,dove-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dove Thermal
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+
+description:
+  Thermal sensor present in the Marvell Dove SoCs.
+
+properties:
+  compatible:
+    const: marvell,dove-thermal
+
+  reg:
+    items:
+      - description: Thermal Manager registers
+      - description: Thermal Diode Control registers
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal-diode@1c {
+        compatible = "marvell,dove-thermal";
+        reg = <0x001c 0x0c>, <0x005c 0x08>;
+    };
-- 
2.53.0

