Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77A4352025
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292563; cv=none; b=JQQMslUEhalk+GXw88xALP0XzhTHuktOAk9eSjv6c914gr9ebRI3RPhu17wzNoug6vHjkpanBEaUprghCr99f1ScUqo0b/W4+19rPKe5Vsxgb/9QnbvWRoiIurhPRJPRri6kie1wi0ttYQ/ythPR+tUMHp1fDakVm0LmFKqWBrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292563; c=relaxed/simple;
	bh=fuJ7RYob/XeS0IiBQ87VjGhOgfOvaD8Chjbj+Bos3PU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZG2byV9quPDxB//2+8aInnJHrhP1LxTFQb26E2htfjPk7rlntf9D2cUPIB5Fz8y91rXXD9MePEXXjW6EP9VPRbKdaqWr2kwK3jt+0RQcxJF+JS/hhVUXMCElyPDZzwqO/SX5OiErGP6gsDUnpraARqE8Wk9faC5j6X/mJhwobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVAQZkDZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVAQZkDZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so32495685e9.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292557; x=1779897357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjMonU9wF/NQLoHYxrgXPEmYrT/le/JonEK29SqHe4E=;
        b=LVAQZkDZXdOZrCyzR+Dcg7Gr/EF3tIpkwR6StAFXpNoFlaF1Kh0+czNEmh35uon0+n
         +sycTKTiS31yZESSnzs4CMnQqkRkwUtKL3Wc6ppNYQK3hKWo8vGkiq7APk7SuDWmTOeD
         +13w4UXvBwDwLR+Y3Nli4SyphN+RPlez5m+BV714WZl9BEHmOzDJYNjBoji7dUb/al7R
         q1dAkHqRXGpvz2WxaQxwv3SewbXvsGI1FX8jtdLySdoRsffXfVkR0GB3dempPk9Hqz0w
         gZfRrPsp/g9EXYAxmNoWMTtabiwGKbvZ2OVmTj9LzAQDNshQSs9hoWj83ufasg3yTv04
         qFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292557; x=1779897357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pjMonU9wF/NQLoHYxrgXPEmYrT/le/JonEK29SqHe4E=;
        b=MK2HNIgutkmKhl72a0vp6lF3YTSdUCI7zxgwkczI5120BB4ssjFlxzQ6Onk2xkUpen
         47pUHLL6r5btW55mvDvWB4O4MBcLhqYqOSzdRHA4GS/jBW0X7czPHiFvE06wJ+1ePvqY
         2eFRi2SGd3ctgdXQOoOg56QZy81Il3G82V7BKXOgenPucxjRbiKGzmMb2qAZaPTaJJGZ
         dhelBFblfu8OoPqGGnx78sdmCFFa45Piqt+kxDAdFMi/+Zi+G89kMaKjJ3cqFLUoieJh
         29wS/rfh76fEtqpCUkRa8jGHuZKoIZBcBrpmyFdKByE5tW9+Qhkw8EhdXc69w9+8gYs0
         xGzg==
X-Forwarded-Encrypted: i=1; AFNElJ80PyVzyy7mNhwYAd9yWXers8JabuaSKQG9pvIaDmMg0bBUu4sit1gA1xIwFcjN0iX2Z69EfXY1hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+hGnJNe4ULNECvokFmnObwCfWyAa2VJXL/lzViZOcLv3E8VC
	EjIByke2qZMxUO3ddbTKrtFkYjqm/DGp2oPwTTdKr/Xr6YTROdvUPZfC
X-Gm-Gg: Acq92OGA/pMS0ZEzzXGYUXBdLFPTYH6AqJoqsGmpOoFSteYBAPuTx74fdFVq9k0bRWo
	+5L4LEHUKwCAFKePMhgCGcHJPYAs1jLp+KOWswY7OtzJbgHJmkflMAJ1/eDUvtCs1Um/T6PKWQT
	PgJdGX8jEoGhQZoYiy5kL98blodArj/hWnyP2gINfEC5HcBhLdBMemJjfrjBxFDDyg6y6lJpJnE
	zRzK2Ya5DPhKt/1tg3SgySa+eGPdv/4aNo9ABXahwCCPaGUndoffbWHkvCQ6d8pm5UfGx5DgLhT
	0Qhewi/8brBhzuwBwPklag50TpChQIQor2e3n/sHnPVSiSoSMHuDkpGle/UOMvV81R6JvVHsh0R
	MU4PLrp7lkdT8BLx28cDKUh5/MkWeBxLayNIOtRNrxAU4+52ScLbF6sIi5ukayvjQyX9W/jT+J1
	pFcNKqxnHkcgsbk6WJTYMDFPM+uYOWdWsMw+59E0Q6r4GwuA/rVMaypQESNWas65M=
X-Received: by 2002:a05:600c:c4b7:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-49033d46279mr995145e9.9.1779292556741;
        Wed, 20 May 2026 08:55:56 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-22-5-99.retail.telecomitalia.it. [79.22.5.99])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fed253f93sm132123215e9.16.2026.05.20.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:55:56 -0700 (PDT)
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
Subject: [PATCH v5 6/7] dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
Date: Wed, 20 May 2026 17:55:19 +0200
Message-ID: <20260520155525.22239-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520155525.22239-1-ansuelsmth@gmail.com>
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
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
index 67c449d804c2..cc564dc7b414 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -19,15 +19,29 @@ properties:
     items:
       - enum:
           - airoha,en7581-chip-scu
+          - airoha,an7583-chip-scu
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

