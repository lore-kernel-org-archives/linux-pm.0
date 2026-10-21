Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571378;
	b=H5PdPjnMF6ZbNvMz1UpvEIdf12r6Nw/sTQuXSVbjwtBy8cv2SU8IMvFWMomwa/JyqWg5
	 +rzbZecLlRqNoFOFDhrQwMIw1lnfD32nmMXp2f6P270zvMpHgrH8yUTx0ZpfiuVDy3kJu
	 Gq9J4XTwvDqAmtPs405046o9XxtAitG59vBd65Mf+oKIyequANGn/XWa/XkhQSEHBEDJT
	 tXF6nxwjZoJ/8o69Lnl5QNxmWiB1u770vQ1/PHm/w/+mVfGDYCR3XB1YRGXfK6Z5cEX8U
	 yrG65N/hp1Q6AYq7O2N6Vcd7AeoO20Fdy5XEKJOSRFMbaIOhJnPPPsodxlq43Cl2Xwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DFD1bkt16ejdNLLmjMu8b88ZfYjN6Jbfkg0hGxrurxE=;
	b=BVh1ifSJr4yz/lexN0Y47DA+7fBI582scXc06wHnEm69YD7Uk5MH57Dgj1N0gHhBOHI5
	 lWgiN5R5iVOSN/4wvdVtzhaeyNxvQ5sVQ8NgamYnqx41+SPLt4ToZfuMEIgIV437qxyCy
	 iShxWGv/jgwfLzGwQByS0Et/Kn08gs3f6eVYaaxAAmwcNh5CXW8uxEFxFYsr/q8cQGifs
	 ij3qdPgcUOmu3d6jRP6p3qcF+0R2VCg+oiLmZYvg4P8q3By9mhrAd+2E8HPdAmbc+dLcK
	 f/3EzCCRELNoNnLh/wVl2JFvlDQNzjX6M0zvd0LxJAqcuM8JafJQFdDOdEQkQBdPvrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IhTH5n1B;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA29606A31C
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA29606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IhTH5n1B
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35b2c599f43so1003457eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571376; x=1793176176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFD1bkt16ejdNLLmjMu8b88ZfYjN6Jbfkg0hGxrurxE=;
        b=IhTH5n1BAEzIcU1+4ct2ARRUmuXvLa5lwoTLDfPTw5a070TYCjva88wL3iNauAgScb
         2BzyCmw2TtVHPscNk70iPI9UjZkqDdG3wzb72Ztfw4WQoqfApfZmWrKNNofbLyFwpkMW
         /Mi4MnYZa5qbsgIVWDenoSVtFYg44GxGJ7AJnVMCcGubl+lpF+DQYS86hLPgDuapXuyc
         TMOvnAHNA6nYg4On6YOGzuKx3hc+59x/PKcMmd3720X4/66rYiyJwRECINg1hzGI6+yK
         6EMwIEm4wEncI3PtNXIDD8oeKhsDins/AOFGVtfx7vk6TioFrFlFPYBH0hl6Amty6JU1
         h89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571376; x=1793176176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFD1bkt16ejdNLLmjMu8b88ZfYjN6Jbfkg0hGxrurxE=;
        b=Z6jmaqKwPwBaqW/JKsBgFXRmVnPSNbj7ASp9AUJmikQR5WDVQrs4JdF+T8JYWFr8XB
         RS4vGzzYxRZ51qNVXIlEm4idartUAuCiplViY5woOCGCWnIc5/SPdPOdNepvxvNJCFHz
         4QXxPqCkYqSws9nPAc3F1uASGDIqbfZ4s2IHQusIWm4aTIUW2KFmnv7+ymH5JhixWquZ
         mx9+hGPu+92dDMAn+ou1ezssrl5yMeUEq5rp9GvxlgjW/+FoaFLev8CK9LNViyDYP8gg
         h9FhjBGTx6zdlFj+VFGEIREgSWuHtSyMphWL3+ouNdCZMKUle1oivuYhL1p0rS/Z+KP4
         8iSg==
X-Gm-Message-State: AFq9FYJU4EWEv15poX0ORCqtu6a1cdWIkillP7PSv2AGH31XVqO93XxI
	Ox14YzQ8bVL850rDdRRN6i6l5gc3EaawNEpnXfwnGTc95KleI55dWa75
X-Gm-Gg: AYBFou1SyclE+kQMXeSnDUIzg7u/4SkFvfKgjTgSejhSyiv0Xl4NB5AUO1XC+JzrUWQ
	gTCnfzGKrINv/vtoWJ0GwbAIKhTOB58x2PmsNnwGgKMhDwwlkQ8fap06w0fNWv5lec9UtmDXodS
	VcuPLUS3Q4bmRQLtWl/wV5fGNG0YY6uUfFiZpbEA7/I6d6dj4SxwtH7P6/1KpA1+jl4QA2R+4/8
	/cTcU8dxutxhv8p5NVkX8tCRCQgXcbWL9NGwH/rUnBiV/VRICXAshMwUlE3vmVCnkiAdcAi1Tma
	Oi+eCNhK0zFs/NV778i1KYr+MnN19Yvu7VAB+qvHIe4HtC2fxyR8OsGz48V1ZHHmiOQVwcZ2Waq
	YvwuygTQQkIMF0KAd5YQrO8Vl1jdLnzXDr/UdUHC1TCyQKuMmvQbCQED/PdsodAnQ/VCE2aXjeF
	TJ5k5UAxOD0oeb3cvxwNdcuPgSLgpwe0n4SPms4U2GARRfeuAxdPzl5HlTjhkicYxKlqSBmMwVk
	/SjazoklV2kX6vwcV5j1M+jMOL7qiLSYGf9WZBW3CeYX+9voI7ZtqSi1cupYHV7eW3Ty7Zg1ttg
	qtoWa6nW2PfsVG7YLnrj7kv4666K9WPqHHZl2+b5jTdnPg==
X-Received: by 2002:a05:7301:3896:b0:366:2893:7421 with SMTP id 5a478bee46e88-3674d84ddb2mr2458844eec.10.1792571376399;
        Wed, 21 Oct 2026 01:29:36 -0700 (PDT)
Received: from localhost.localdomain ([113.161.48.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm5199132eec.6.2026.10.21.01.29.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 01:29:35 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Add Qualcomm SMB1351 charger
Date: Wed, 21 Oct 2026 15:28:40 +0700
Message-ID: <20261021082841.79147-2-thenguyen1024@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021082841.79147-1-thenguyen1024@gmail.com>
References: <20261021082841.79147-1-thenguyen1024@gmail.com>
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

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adrian Nguyen <thenguyen1024@gmail.com>
---

Notes:
    Changes in v2:
    - Drop monitored-battery from properties, power-supply.yaml brings it
      (Krzysztof)

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

