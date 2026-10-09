Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AADA451985
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531221; cv=none; b=Y/Qzdg+GHF1yR5l4c5xJMJIWvscBcHWdnBA3+SXBE7t2SAyDGVTBdNcVaLqfGlGmrxftC+DhABCzFaqPaT1lM1gnQcbvuO4cveZnmKZDTNvPYBLU2UjYSsJ+9XRBovy/QudWO4qNBYU3wHB1HK55KQ7rHPu3bDrNV2DNMf2FVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531221; c=relaxed/simple;
	bh=5mJcWpPhz5V4cVbv/UViMTOOd0qIceb8QnAN5ZLKMmg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye4boiJVMHBYxaeRbQCFCcD/PE4l99CppeGOFip7s+JERk7VvwvvTHcW743jYw6xM7dRwWghdZSDp+NbS47GWk/3XJ5yK9sqt6ns+pfi/xIzhM/fW6+Y1Fhbc3m/5o32bW69mYuHk3Fq3XmEhuXiQo7WK0T047nyo4Y0bchCTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqF0jwma; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqF0jwma"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso54598475e9.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531218; x=1792136018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0GMj/PCcw0jRmoExFmKfgop12tPuP6GJMya0pF2cELQ=;
        b=FqF0jwma4IP5kwzsKggDkN+pLFqQXtFGl0jp5cwO9x1Z+9bRm3sBM9yFNhl6OTLGvO
         j7IP8+ewM33sDskMf9eEKtJYXzmQxaXL8k15yWBvRQooZXhBhWmWehYIQPWfxgEZcnLO
         d2I3b7GN1fTvEkOy4InEbcILDxkS45HTE8MO0zZL/qO8+osqkDRfu5rWCiHaCyFrF2WO
         I0AjMwFO52oczxLKH2xAEUkg03Wurgq8QS29rPDZywg8gbhbFBWuxaWHL8hLnPQ985KA
         4BKKuu4MEjNsnI8It3UFdyiBI6IcIV8fDGU04B4FQmYhomHeRSDjNfNKWxg9AlP+y3jR
         f20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531218; x=1792136018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0GMj/PCcw0jRmoExFmKfgop12tPuP6GJMya0pF2cELQ=;
        b=LK6IK6l3UpkKvpCrJWBRNytdF3ptfW+Z+RnDg3N3LMPhCHiVA2ZjDbeiRXza2l3OEx
         vKauRiBrqufgBGkVIiaOY3pXoUYawsfnlwszGMKgcwhdIh0UMtOWwBmAIkkQynuOxZkP
         /NXBXseLf0TZiExfdk09wITOe3X15ioodH8mKdRAlsLf0AS4mIDpA4C5w1KTrd3g7Drk
         I4GNc4EAnUCW0QecEkPRf8u5Gjj+Pmhl1yV2aq2U3oEla98wZjlFG76ZNykubuJ/1wMJ
         UXfKNpq7xEFQOZePedJ2FGLOW1MHRL+aRYKNU2lLAxwm2OrMoJ6gI6aIX4m6Pc8c4EdN
         6ZAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxy9lMnC3xGRwL/YZKGUdm6mOvGvgDKSN2VkIfj7e60RmgcVGKxz7Hd1gtcE8rp5/1sJlOIUqiFyQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lF2t7HzMVDYVKWHP9DTQJQ9FO1DGnUr53W+02P9OgPrdS5i22/
	p0FS+ygdQkmvdSfzFjdK4Ss3bMN4NrLO/Vu1xi/K5MaAFvGTITh2zg2U
X-Gm-Gg: AYBFou3pvngAIGFnT3sgpLKj0jzDTt5z3e/4yC7Ey6J4iScMo+HNUoQwUku+uTCkMyv
	YM9xDadEJ8fLgAw/+vgY/PJvGof3RCiBbH0XZT1dVqcZVwsTEPkC9IzZq42VdT1jZjy5q+P865F
	kUO8/WDDMyc0Czje1qyEz0SadoKDYoK6sU6rNHJ65NWMTsIQEldKsJ1cnVa2OQSCB8m3LRw7w7a
	ABezhT5bT+9XsbPH9tATQTNPkVqBBMKhMpqdc+vnk1d+ugdlnZwkIiWFxtCR3KVI0hqN7p8iENj
	nmDVeHDH+pT9Ia7nxnPvd94DVMT6aoVpb8UF+X1i417vmheMvkH9Y2SEMd+87+Wsu1xBK/SA3Xv
	YrRcIm58icXpJ9wwCA7P4vvp3V/TRZUE3ENrIH5D5mH27cWbCcFLK9IsxIyR9zMPc8KimCOjGog
	TapDK74nGuqZz6EvDtKAUOBec4FuiToMxGkLa9r3JRxSGAL/q0IH3ke9WQSYV9iWO8Yw8KgMW+E
	dtyDJ8BlBY/bQh9Zxfvi6T3JBgeh8GcayaVi2dSaiaUP1wT2Lvxiqx9zNKmSEyjM27Be16binZR
	VVhh8837EOl1XhXyXA==
X-Received: by 2002:a05:600c:198c:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a18e4cdbfbmr17253525e9.29.1791531218222;
        Fri, 09 Oct 2026 00:33:38 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a18be96549sm55116365e9.6.2026.10.09.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 00:33:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: devfreq: Document support for Airoha Subsystem Scale
Date: Fri,  9 Oct 2026 09:33:28 +0200
Message-ID: <20261009073330.18175-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009073330.18175-1-ansuelsmth@gmail.com>
References: <20261009073330.18175-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha SoC contains multiple subsystems that are scaled to a
specific OPP taking the CPU clock as reference. Such subsystem
can enter idle or performance state based on the system load
and power consumption conditions.

Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...

Document all the required property and provide examples for the various
subsystem OPP + subsystem scale nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devfreq/airoha,subsystem-scale.yaml       | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
new file mode 100644
index 000000000000..2cf7f23a926c
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/airoha,subsystem-scale.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/airoha,subsystem-scale.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SoC Subsystem Scale Driver
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha SoC contains multiple subsystems that are scaled to a
+  specific OPP taking the CPU clock as reference. Such subsystem
+  can enter idle or performance state based on the system load
+  and power consumption conditions.
+
+  Example of such subsystems are GSW (Gigabit Switch), NPU (Custom
+  Risc Co-Processor for Network acceleration), SOE (Crypto Module) BUS...
+
+properties:
+  compatible:
+    const: airoha,an7581-subsystem-scale
+
+  clocks:
+    maxItems: 1
+
+  operating-points-v2:
+    description:
+      OPP table of the related subsystem supported rates that referenced
+      clocks will be scaled to.
+
+required:
+  - compatible
+  - clocks
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    npu_opp_table: opp-table-npu {
+        compatible = "operating-points-v2";
+
+        npu_low: opp-400000000 {
+           opp-hz = /bits/ 64 <400000000>;
+        };
+
+        npu_high: opp-720000000 {
+           opp-hz = /bits/ 64 <720000000>;
+        };
+    };
+
+    emi_opp_table: opp-table-emi {
+        compatible = "operating-points-v2";
+
+        emi_low: opp-400000000 {
+            opp-hz = /bits/ 64 <400000000>;
+        };
+
+        emi_high: opp-540000000 {
+           opp-hz = /bits/ 64 <540000000>;
+        };
+    };
+
+    bus_opp_table: opp-table-bus {
+        compatible = "operating-points-v2";
+
+        bus_low: opp-200000000 {
+           opp-hz = /bits/ 64 <200000000>;
+        };
+
+        bus_high: opp-300000000 {
+           opp-hz = /bits/ 64 <300000000>;
+        };
+    };
+
+    gsw_opp_table: opp-table-gsw {
+        compatible = "operating-points-v2";
+
+        gsw_low: opp-200000000 {
+            opp-hz = /bits/ 64 <200000000>;
+        };
+
+        gsw_high: opp-500000000 {
+           opp-hz = /bits/ 64 <500000000>;
+        };
+    };
+
+    npu-subsystem {
+        compatible = "airoha,an7581-subsystem-scale";
+        operating-points-v2 = <&npu_opp_table>;
+        clocks = <&scuclk EN7523_CLK_NPU>;
+    };
+
+    emi-subsystem {
+        compatible = "airoha,an7581-subsystem-scale";
+        operating-points-v2 = <&emi_opp_table>;
+        clocks = <&scuclk EN7523_CLK_EMI>;
+    };
+
+    bus-subsystem {
+        compatible = "airoha,an7581-subsystem-scale";
+        operating-points-v2 = <&bus_opp_table>;
+        clocks = <&scuclk EN7523_CLK_BUS>;
+    };
+
+    gsw-subsystem {
+        compatible = "airoha,an7581-subsystem-scale";
+        operating-points-v2 = <&gsw_opp_table>;
+        clocks = <&scuclk EN7523_CLK_GSW>;
+    };
-- 
2.55.0

