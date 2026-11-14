Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655347;
	b=oiquEEICF0+2s8fYQOR11SlLe1B6S2VmECI3ZmnSZTxg+bwP4BkoIpGhfQEUtwiiqIcY
	 ycThdoO71PXKFML4wVvWyLSU4ph3Kxdy9gAdTOay5Ef9ej5/FW1xuOTtB87KtLQoxGwOl
	 t0eerrIVg+Z+oSdf2I/D8NSP8CDbT9pCKOkPUdBSNUk1dOoGpyLxxX6NpXN6K2gctQh6b
	 eqHRVgY6/Ny5lqBKShzr1+G2FrqQJFfK2Oan9JrTAiTNQvAirc3/tqWxcJ/kvg7JX2IGC
	 02Y8uqle+qhjelk88d0I80+5e/qcvkvqgJ5TmnGETm0tVqIat5zeBMUGapbnGKdD3NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3PPbwIXTSfL5INVkpoXipMr1LonhcpwjQNS0NDqz+/s=;
	b=Xg0+T25Zp3B0hjQGU2oglI5ygmJSFcMCfObsuItnEqrTJHpuoDV71f08NMbl/gv+UUv7
	 WTk/8saadoczk69m/39NYzVdoFFluAQauMYsDFWFX4t1L7KelQ08Lnf/N/gP4g2BxdmyJ
	 cH0ZCcD0CMp50ZoHxs5h9EGUmM6L4bsP2FUgSX6y5G055mnHc1gN+UVJTstTMBLJQmxcw
	 rv1bHoYt8zH8Xw3SjmZLCK27atDQTeBRkK5gWnOPEjojToxV9SIKtcKaTITQs2fdhGXe6
	 RTt/qfipZy0dDZHMJI0LFr4TNrUYvxnvSJklx9YqHQN6e65WXt/pDvsQmCfwCz6wCHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="X/QRd9tY";
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7E606A887
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97F7E606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X/QRd9tY
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so952898b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794655346; x=1795260146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PPbwIXTSfL5INVkpoXipMr1LonhcpwjQNS0NDqz+/s=;
        b=X/QRd9tYzMUrGM9ds4MFgmgnjgzlmMZQUvIuQQBK2gHq2xohb8KhWkuTSwbaJ74Zud
         UO9hYbk3WsKBa/AlLsZ5050aLkPgC1SNwvlVCpqzMuq6n2k84iJqmjp5Rm1UCcT3op+y
         RNQWzpZYbLmhwfEu6LcRUSg9ZERYaxvr7r5pPGBbHl8Gtpeq5uVVksUcIfOHDZWPslku
         7nYUyJ6/UWupvH5mxF7aOntC4A5NmIYdcmBI/AjUtwOM+2P0z9QrWqvVSMTn30+8LVEL
         sHtHLcNvup3KATG570d3LQ5Moy3R5T6+D2vBEJuTvAUlpEOp5EYSqHZ7DwipYOPn/5mL
         4MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655346; x=1795260146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3PPbwIXTSfL5INVkpoXipMr1LonhcpwjQNS0NDqz+/s=;
        b=lZUxAGAI92lnkXGscxfoNAOGx7BqO1JYzI5rdcJoLzAU68e/jmY+49FTheZuu5MLrq
         aUuvnA4F70TpXWiXtJaKjhXqV3Q1HrWGbxzLKV4xB0/0tMTG/KJuav5P9256Ucwbhjvv
         0J0qeFNoR7N/IoaC1H73rv/c0gUFqVGqbDF97npBAmwUSH8NQX8uOsPueSXKgOeTfDfP
         FqQgO3QVhF0cgejUetBdOxLHAxl+pTiW31WuMLJiCdocbCsJntW4OQaoH9w2Bp9zZTfC
         Td3BjLGbM6e5Tr0VEVWeTmJd1d65M56l0SodiuJ0k1Saidu8lJb34Azh6ngIsm2UFU3g
         dtRw==
X-Gm-Message-State: APuU4Z/iPi1jxMInXsYbrGFXroxxyl+pcbZzvZOLCEZwbqrSXiLCm5RT
	aS9BnigzfAHagauP9udRXa5Sgb8Cu5Etnm1W1/bUfU/CgbyxVn+xP7Dl
X-Gm-Gg: AYBFou1/tdGDn0ozamKiXtSJn575U5SE3pqyG6DCyaRtxyzv+NbANC4fvVRzR3Anvtn
	X/Xc7dj/A8w9oQhfv5wuzA5qT4o3cY0I+uqamkBYHMil4nD5coL+0nEBvDjgD7rx9bF+pNXrrjG
	yXJqhbOKciIeiPQtW3VjJJSSphMdx+5TpPneGwRwSD+uV45Dxh5rbvlOvtucLAePPy1Kz78jpHx
	lft1n8P9sqvuY0yvhnzF6kTcdh+RUo/wGckLhEqVaP97mXRD0+TCkQWQivaiJo2bQmXBgy7gv2Q
	ZuHwT+EbZSm8oeZcw/geaE+mcVHakRsdQLUtpMvl/eUjxIP4Hw7KzQfH29hOEXo2fC3GQXJej53
	Chbwrgwk/miB0g5iS8Rg7TRzJTAASXeQbGuS+2MJZs0ub/fASRqFJfMP70A175qqZsMdETtMZt4
	VvQ1kB06VnS1h3thUfbn9ZEopZAdETtN+b90xTNIlqaAAL7purh3XJ5yMnhx8P0+KV3zrRbLPxT
	BvjkGxnsewjiCK9gT7asqXIElyLhM+oB6Wl2jc0TVxchXMR1n95/oLTTQZddDWT89bSdvr51v6d
	PEXQeL5imvO7bD43bn3eiGyBumpKMBYoj5tmL7M+ah9VGcv7J5IA2DE+lKm3WiWLHRiFRp5niK0
	NuZVpeG3vScmTBo1rU/RMgmfwW79Au/ASowIQ8CqWY0Qvfc3leP2ZvvNNLkAF3UuiodgRmA==
X-Received: by 2002:a17:90b:3146:b0:3ab:f38:2b43 with SMTP id 98e67ed59e1d1-3b1b0a4513emr4900156a91.34.1794655345714;
        Sat, 14 Nov 2026 03:22:25 -0800 (PST)
Received: from localhost.localdomain ([118.68.25.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm3981142a91.3.2026.11.14.03.22.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 03:22:25 -0800 (PST)
From: Adrian Nguyen <thenguyen1024@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Casey Connolly <casey.connolly@linaro.org>,
	Adrian Nguyen <thenguyen1024@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: Add Qualcomm SMB1351 charger
Date: Sat, 14 Nov 2026 18:21:54 +0700
Message-ID: <20261114112155.85068-2-thenguyen1024@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114112155.85068-1-thenguyen1024@gmail.com>
References: <20261114112155.85068-1-thenguyen1024@gmail.com>
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

The Qualcomm SMB1351 is a switch-mode battery charger with an I2C
interface. Some phones use it as a parallel charger next to the charger
in their PMIC: both take power from the same USB input and charge the
same battery. On the Vsmart Active 1 (SDM660, PM660) the SMB1351 is
powered from that input alone, so it does not respond on I2C while the
input is absent.

The SMB1350 has the same programming interface, and the two can be told
apart by their version register, so the SMB1350 gets its own compatible
with qcom,smb1351 as the fallback. The version register of the chip on
the Vsmart Active 1 identifies it as an SMB1350.

Document the chip with the battery it charges and its STAT output,
which it can drive as an interrupt line. On a parallel charger,
power-supplies refers to the PMIC charger whose USB input also powers
the SMB1351. The SMB1351 can also be the only charger of a board, with
no PMIC charger to refer to, so that property is optional.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adrian Nguyen <thenguyen1024@gmail.com>
---

Notes:
    Changes in v3:
    - Drop the Assisted-by tag: since commit 1e035297ffda ("docs: remove
      Assisted-by references") the cover letter carries that information.

 .../bindings/power/supply/qcom,smb1351.yaml   | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb1351.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,smb1351.yaml b/Documentation/devicetree/bindings/power/supply/qcom,smb1351.yaml
new file mode 100644
index 000000000000..468899c15fa2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,smb1351.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,smb1351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SMB1351 battery charger
+
+maintainers:
+  - Adrian Nguyen <thenguyen1024@gmail.com>
+
+description:
+  The Qualcomm SMB1351 is a switch-mode single-cell battery charger with an
+  I2C interface. Some boards use it as a parallel charger next to the
+  charger in a PMIC, taking power from the same USB input and charging the
+  same battery. On some of them it is powered from that input only, so it
+  does not respond on I2C and loses its configuration while the input is
+  absent. The SMB1350 has the same programming interface, and the two can be
+  told apart by their version register.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,smb1351
+      - items:
+          - const: qcom,smb1350
+          - const: qcom,smb1351
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The STAT output, which the chip can drive as an interrupt line.
+    maxItems: 1
+
+  power-supplies:
+    description:
+      The PMIC charger whose USB input (VBUS) also powers this charger, on
+      boards that use it as a parallel charger.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@1d {
+            compatible = "qcom,smb1350", "qcom,smb1351";
+            reg = <0x1d>;
+            interrupts = <61 IRQ_TYPE_LEVEL_LOW>;
+
+            monitored-battery = <&battery>;
+            power-supplies = <&pm660_charger>;
+        };
+    };
-- 
2.43.0

