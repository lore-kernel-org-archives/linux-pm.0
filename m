Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C7371046
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141203; cv=none; b=KBIsg3qxZjPCVobjoAZyv3vY1ihG7kswVNplwqNCs2PGVJVHVlPmwaB/Wyl4bXnLRhek2IT/SUP3cLK8ZVjnALzHEMX9guEUVRnY4yy7IdT3YlpEsHc+w7vmXDUgb9Z7TptyTcJKWrVrrEX5wFh3uaSXHzqH40le4cpUz+u55eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141203; c=relaxed/simple;
	bh=+gXx26kToc5Qsn+X5xpx5KaXlfJuV83OpMJgOHZcMo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzS1869hHLo01bqsOzbFGaVubPuhUOz0XuC5/NADLHF63VTI4M9Aw8Eq2OvLEWZaQ/6H/JVwbMlt/X+VOYYVIxdpgkapXJudEjTyRXib2i+IW7ASX1WQdYcibKFAPvaswba+KXDiTrs93zS6AjgiYHypGtCrMEFnsQY5MldhTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opgvh6ff; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opgvh6ff"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dea72099eso9490374e87.0
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777141199; x=1777745999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFgTexS82Aes4S2KA8waYF2yU7gR1eiSJ6BQPR26m30=;
        b=opgvh6ffORU3cLe/1PaQ+favvlB7G4jQIe586uew3y1GJCK4KNz5+y0yfY5dRoyT3d
         JeOnmNscJg4pwE31ro848Lt0BH71viwmQq/bvPeZ87UT7UoVw5eLDeNQQ+pLEVd+QrMl
         i8eLLWA1xQR3lBjnY3lRQCX7tQ3x53k0v87q8YVr2+QsCesXDt6YzFE4/yFCHm7mMVgQ
         vsP9RwFZZF7vy68aWEihSudVUvfR+rJe9LO5WZSK02Bm9utHAW7K/8EWxVypGVxQ25v1
         B/0rAekKxvjTaKc4I852cbiPJDFGf11PmBjjXpMHMgUrOksLBRVKmYbfm2Mw2pUlW/bs
         z85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777141199; x=1777745999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFgTexS82Aes4S2KA8waYF2yU7gR1eiSJ6BQPR26m30=;
        b=hO0eAun+lBQZKqpJyhZD1mPuFzrNme4fGdxQpvHgG+PuOK9hxgx7ACZDOLji4+vKU3
         gSuKvQTg1TTVWlXwvds97z71dMBkXydvAai1fFdCMFaAv8jZ67a/X4NmXqI158xVlttG
         VerWzwZRKVSa96Uc7mLPZnVpJ7BFwxqOdLRUEHMiMyaBSxUAs5ME/bPUcLl2vF5jRz6D
         R7qxPUNXJC8BvQlhPJPtnJTyAtjVcrVtkzFVFkTXe/bZV6JrRaSqn9Rd1mndppVBkEO2
         7QVpuGgvrR971PwQ4++6x62rRj2XRjzwEmMyXwVlnhnafu5E7xVpGQp3Qbnh91NJCX5p
         Piyg==
X-Forwarded-Encrypted: i=1; AFNElJ/HZPm4UKvANjgGGu6xljlNY39mJyxYph1BDiAsUwOfvbTp9ebmdZTH3ySyF1XUvj88TvdWW7B7lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1G32+77/HLar3/TbH8cepL1COeT+gSuXcpffGo0qtAkJHFvTi
	yzE/N3jgb6R1VR9KssvLmYCgd4W2Ph2n3S2qb/YEjvUEW3abWafcbTpF
X-Gm-Gg: AeBDietqhhG0iBH7ThXohwOqebiA8CTeDzW2YudWo5KIe4QaKk3uTiF2VvUiZHIUgpm
	HuLkTt5mliRTj+yDDa4u4M6TzVvVQmpM6/Jn8vXensI4A6xjwt9c2leSEJm5qalSqZIs3HbqN5F
	9M9xyU+reOY3GI2ZFnFZuxot8RVDlcbnvdMMXb84hwWeBnJ2UpebILZQC9UhveqoirGxyawhVqO
	29+a8ydgZxWiB9drsDWNidWSTgJ065gFQelIJfZ1O3UWr4XVv16S6ydgeREBrAKDZ5O/9GL0qr2
	Uw5o1jezoorwLx/vOTd0wW1J3idrYbspUipn/wZ6diLeD2MTLEBDIlm9RLcrt8D8hfyD+4K2HHT
	oZgWUbui4BRHQxRxdurXdTEvf6eqPNudPtNlLG+y3TPCZ3zrIs+ORS2pAqmmwTZOY28zBeRvL+P
	NGhc3qQA60S0MdPbX4pFCrcBk=
X-Received: by 2002:a05:6512:3b25:b0:5a2:a8ab:ab4d with SMTP id 2adb3069b0e04-5a4172daacfmr11631274e87.22.1777141199206;
        Sat, 25 Apr 2026 11:19:59 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7ad0sm6836577e87.58.2026.04.25.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:19:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: embedded-controller: Document Surface RT EC
Date: Sat, 25 Apr 2026 21:19:35 +0300
Message-ID: <20260425181940.144028-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260425181940.144028-1-clamor95@gmail.com>
References: <20260425181940.144028-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document Embedded Controller used in Microsoft Surface RT tablets for
monitoring battery properties and charger status.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../microsoft,surface-rt-ec.yaml              | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
new file mode 100644
index 000000000000..0fee574a3015
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/microsoft,surface-rt-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Surface RT fuel gauge and charger EC
+
+maintainers:
+  - Jonas Schwöbel <jonasschwoebel@yahoo.de>
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  An Embedded Controller used in Microsoft Surface RT for monitoring
+  battery properties and charger status.
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
+properties:
+  compatible:
+    const: microsoft,surface-rt-ec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - enable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@a {
+            compatible = "microsoft,surface-rt-ec";
+            reg = <0x0a>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <74 IRQ_TYPE_EDGE_RISING>;
+
+            enable-gpios = <&gpio 88 GPIO_ACTIVE_HIGH>;
+            monitored-battery = <&battery>;
+        };
+    };
+...
-- 
2.51.0

