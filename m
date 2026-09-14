Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0737997E;
	Mon, 14 Sep 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386882; cv=none; b=lT9mTRy46EbumaeoS7Gnk7W5VmoloXWj5JleYMR1In/r8tqqnQAGglXnJ40EEPLi7K2ne/W8a0kCj1XF59cxNFknSpIM89WoW3ghEKs8cqpaQlmRjcKkKPdN/WG+VqNSFcCuV/OyZQE9vMjxdFlBruhrVJD/+J7wayiU2fIHSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386882; c=relaxed/simple;
	bh=kpdN43rxYrQvQ0zg4egNsb4TXwpK6/OxNuoDTLNYOfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FP+bl4HkmKhQfBJwNK3IFs6vddiWmJsTS+0nnJZ3VyC3I2UCVcR1eEaXLnMBIet+kOopopsiLAiAaXl58q1m7Uh8m0qmyD80sShRjDIkedCaM2WDsNkAmRUjC+xtPqOI/aDa1Giz1s0JGF93ynI49WqxQPQWssSr8Cq9g45rZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWAiG/Z8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWAiG/Z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379D01F00893;
	Mon, 14 Sep 2026 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386880;
	bh=wU0KK5QEwgR6QEGVXQPMkCvJi1ly8SJYcgWVupCFs8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aWAiG/Z8YkrQ7EC/iV+eBB6dlxyxgS84qMkxQgEAwpQ7R/qLqUHthiO9kJRmHX9st
	 08ZJvT+InyclJVHxQRdXsRVlhB/9BkPpxLjLFcoRhBolEUThn9hIrUgGUCSg9O2zeT
	 7mcszA0JTcc/HlU+4nTzJnRrBoIotbSO9Pi0F89Ay/6yUjl9ye5QeDZC8LUaBhvVm0
	 7O4DxvWouKQB2hm0vHBIeD9i328L0qw16Rg5HpwRyJKi5dqtIK5Sti4MN7hTqv3Y8+
	 nD9ICW9tZHOVjChGWmoJmcg/Eb+jIsAGVIYGYbfBQIlWF/XdSfQNtRG5zW/FFspDtM
	 77GhR5WynZ9cQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:29 +0200
Subject: [PATCH v2 01/20] dt-bindings: power: Convert Ux500 PM domains to
 schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-1-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Convert the legacy Ux500 power domain text binding to YAML.

Move it under bindings/power.

Reference the generic power-domain schema.

Update MAINTAINERS for the new path.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ----------------
 .../power/stericsson,ux500-pm-domains.yaml         | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
deleted file mode 100644
index 5679d1742d3e..000000000000
--- a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* ST-Ericsson UX500 PM Domains
-
-UX500 supports multiple PM domains which are used to gate power to one or
-more peripherals on the SOC.
-
-The implementation of PM domains for UX500 are based upon the generic PM domain
-and use the corresponding DT bindings.
-
-==PM domain providers==
-
-Required properties:
- - compatible: Must be "stericsson,ux500-pm-domains".
- - #power-domain-cells : Number of cells in a power domain specifier, must be 1.
-
-Example:
-	pm_domains: pm_domains0 {
-		compatible = "stericsson,ux500-pm-domains";
-		#power-domain-cells = <1>;
-	};
-
-==PM domain consumers==
-
-Required properties:
- - power-domains: A phandle and PM domain specifier. Below are the list of
-		valid specifiers:
-
-		Index	Specifier
-		-----	---------
-		0	DOMAIN_VAPE
-
-Example:
-	sdi0_per1@80126000 {
-		compatible = "arm,pl18x", "arm,primecell";
-		power-domains = <&pm_domains DOMAIN_VAPE>
-	};
diff --git a/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
new file mode 100644
index 000000000000..72c39c083efb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/stericsson,ux500-pm-domains.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Ericsson UX500 power domains
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+  - Ulf Hansson <ulfh@kernel.org>
+
+description:
+  The UX500 power domain controller gates power to one or more peripherals on
+  the SoC. Domain specifiers use one cell containing one of the DOMAIN_*
+  indexes defined in dt-bindings/arm/ux500_pm_domains.h.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    const: stericsson,ux500-pm-domains
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/arm/ux500_pm_domains.h>
+
+    pm_domains: power-controller {
+        compatible = "stericsson,ux500-pm-domains";
+        #power-domain-cells = <1>;
+    };
+
+    sdi0_per1@80126000 {
+        compatible = "arm,pl18x", "arm,primecell";
+        power-domains = <&pm_domains DOMAIN_VAPE>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..560079711469 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3273,6 +3273,7 @@ F:	Documentation/devicetree/bindings/arm/ux500.yaml
 F:	Documentation/devicetree/bindings/arm/ux500/
 F:	Documentation/devicetree/bindings/gpio/st,nomadik-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/st,nomadik-i2c.yaml
+F:	Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
 F:	arch/arm/boot/dts/st/ste-*
 F:	arch/arm/mach-nomadik/
 F:	arch/arm/mach-ux500/

-- 
2.55.0

