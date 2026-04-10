Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBEEACD;
	Fri, 10 Apr 2026 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775791951; cv=none; b=BUhrOwgxTFoDftB9ezgltG0T1M2NS92j3+Q9PaWr0+1iR+PgYEIrZ9GVaBuOvWIjIBU2DBxSGNmqkXEohEoUV9uUvEL7xdXZmlnfO0Ev3oTV+3ojvYBAgnCvzdGoXr00Xls2s6C3KkOfjhpLU5EowUt9F//fvovFReAMMOZWkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775791951; c=relaxed/simple;
	bh=6QDRzesef9/DWjOV76ZXjr7Ur5Nsb/dXPrNYjvYY+54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoLsrsETYO9qoaG0xeViNme3Qoa0lMD+uj9JVpVYjgeUZiumauA3D4eJSn3tRICbXyT5mL6DCMNleI4OQSHOZgkWLDeMtNwzqy1/nM+83i/2GO3quVwCi5ehHq4t+Xm5OVHKpdJd/rehNHAW6tcHgkOphvePruQ2gbZEsIFgenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=frBkqzCP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kFuTVizA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="frBkqzCP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kFuTVizA"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fsMn21f2wz9tgZ;
	Fri, 10 Apr 2026 05:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775791942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtCO28FVp+A5Y1qkMDfq1zAwOGQuMizhX9EnObgNJl4=;
	b=frBkqzCPnjYMuJ8KT4RMHwhzjAKYBxekdSCaz8bylrgb5Ef7lDjqX/t8ADX8VntIGO36Mo
	hcO/nZIUuRb+V8zEeTuKtSOusBFZ5gEa6nLzppdI3uC1nKOqRvHXgqwGRdXkb+o/UK2pSH
	k9QlGcZsvt6f80q8OnY58Jj5DCtOe6FK+67MlGnU4AMInGZBfTVeq1BdtwL04B63KkB3aK
	ZaZ8WNsKrLc0LXBhiXw84iWR85QWRYp+jK9IbFaB6YpdeXY12caTze0G1xN/cP3ZOb7RA/
	1SLeuvFriIxBor77+jnL9L0swIqr4gaN9ctdpixftO4crqZylvpasw4pJ8yFSQ==
From: Shuwei Wu <shuwei.wu@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775791940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtCO28FVp+A5Y1qkMDfq1zAwOGQuMizhX9EnObgNJl4=;
	b=kFuTVizAeNNrwybZdteDeYulqtb3Brp5t1QmRYCK1Li1YQHbW5zBpI8+zL4jOVjYTTevsE
	yiBQExwgxpdwrxnvQ69CnDTw+00r2wNlsKdoMEnMludSfXMVuY+7KWrGOe71MEhlGgM7Tk
	yIWArhCCEzLCyUAnAhnXCqCNtEGTJkBcPFMVAdj/jrMbYvY72VsbF0AnDcyMhCF+UIusAZ
	EWkHFDLNzj6t/Zuxrz+JcOx6bt6O+FOxlojRvPwdaaiuim/v4NSd0QOvC2YKF8uv3+nuAV
	cu8VtgRVPjtgCOlh08o0tKUjliI4Wpl0TWFxQr6KjfP2SlwL+iCziG0LmxLZQQ==
Date: Fri, 10 Apr 2026 11:31:36 +0800
Subject: [PATCH v4 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal
 sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-k1-thermal-v1-1-12c87dd063c3@mailbox.org>
References: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
In-Reply-To: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Shuwei Wu <shuwei.wu@mailbox.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Vincent Legoll <legoll@online.fr>, Gong Shuai <gsh517025@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775791914; l=2656;
 i=shuwei.wu@mailbox.org; s=20251125; h=from:subject:message-id;
 bh=6QDRzesef9/DWjOV76ZXjr7Ur5Nsb/dXPrNYjvYY+54=;
 b=9+UdWUn1nW2fYeOu17T9C6cy8Fhyqd3NQTZMc6rAHHKYD83d90h6qWYJj8JzCt2oYkH7dBkow
 0JKiuQVtJ7LB/Iy/zdEcnFx+sj1h/dAXXjdjotSjjfTNhxE+tgnfLJ7
X-Developer-Key: i=shuwei.wu@mailbox.org; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-MBO-RS-ID: e2e04b93066ba154ca6
X-MBO-RS-META: gi673rtbtu9nb1efg3mhore59151utkt

Document the SpacemiT K1 Thermal Sensor, which supports
monitoring temperatures for five zones: soc, package, gpu, cluster0,
and cluster1.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
Tested-by: Gong Shuai <gsh517025@gmail.com>

---
Changes in v2:
- Rename binding file to spacemit,k1-tsensor.yaml and update compatible
---
 .../bindings/thermal/spacemit,k1-tsensor.yaml      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml b/Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml
new file mode 100644
index 000000000000..6dad76a7dd36
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/spacemit,k1-tsensor.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/spacemit,k1-tsensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 Thermal Sensor
+
+description:
+  The SpacemiT K1 Thermal Sensor monitors the temperature of the SoC
+  using multiple internal sensors (e.g., soc, package, gpu, clusters).
+
+maintainers:
+  - Shuwei Wu <shuwei.wu@mailbox.org>
+
+$ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-tsensor
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock for thermal sensor
+      - description: Bus clock for thermal sensor
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for the thermal sensor
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      The first cell indicates the sensor ID.
+      0 = soc
+      1 = package
+      2 = gpu
+      3 = cluster0
+      4 = cluster1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    thermal@d4018000 {
+        compatible = "spacemit,k1-tsensor";
+        reg = <0xd4018000 0x100>;
+        clocks = <&syscon_apbc CLK_TSEN>,
+                 <&syscon_apbc CLK_TSEN_BUS>;
+        clock-names = "core", "bus";
+        interrupts = <61>;
+        resets = <&syscon_apbc RESET_TSEN>;
+        #thermal-sensor-cells = <1>;
+    };

-- 
2.53.0

