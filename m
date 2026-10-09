Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003334D4873;
	Fri,  9 Oct 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548126; cv=none; b=RFGEnXqPRSd+ojvWUCf1c2WSGS9KFS/4DPdtKIJXqItZuhPMEpYnhAxI0sbc8+ZuhqeJbYvkEAbSNxOHP8s7nU2KUWX2flG6h8/almgjp7sTMPuRO1fjRqo3JkOm5TxFrpX9QANWebAqcGxqaWIBcT7EdMMoG6pLzbM2+xbARAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548126; c=relaxed/simple;
	bh=pxoM37qQrnzHR1Ott9w7BWJG6UXekRvss5J9Il8IiME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3IaZPhKMv1zK+LPxjRSuDxmMvVEB0/uk/I1xWuViSfqnozldqwjpAbWogPTqIPOkcas6SR0MwTJVVu19wLpf2fWlfX4J/fa1/+SRkDwcNrhlHTfJN7lw7H0N1Z9UTyQ4h1NGb6YMFBhgPBeokPrpeuSWrF7rec7GhZh+b45HV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhVRVeSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhVRVeSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488C01F000FF;
	Fri,  9 Oct 2026 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548111;
	bh=YmZ0yJHie14bIXV5WA5IAqbzSShTvMSKctXnC5rUdh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NhVRVeSQhmlACXm6A7ETYx6o2Hi9E2rfzYBIVSi+2mI0zkaYN+2uB3bko1Piuw97E
	 3S+6SkZRC/ucANtjOEkS0Yi48toIkJaerZyulyzI9wJ9SndOcnOvlbnNBlA3N1C4rW
	 w481sgTjhKQBTMsPvawRuMvZ0/lC9waED0nA2jZfhgVrIAZ9uAfn67LRjyhlb/4f3t
	 Sd/L/uzzsAHhSJLpr7qqA2rK/sgQF29duxay8yQT3b9qcGIsoBR1B2FAxHLbFC1a1l
	 uNdJL7inlzzlWb0R8xEaO7XRHMXwnMqlFPfqMVTEuUycJXZuXZlW0mc2LBjtQvBGNl
	 UR3M8UpqA4pHw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 09 Oct 2026 14:15:04 +0200
Subject: [PATCH 1/3] dt-bindings: power: Convert Ux500 PM domains to schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-1-5eb1b90bc35e@kernel.org>
References: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
In-Reply-To: <20261009-ux500-power-domains-v7-3-rc1-redux-v1-0-5eb1b90bc35e@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

Convert the legacy Ux500 power domain text binding to YAML.

Move it under bindings/power.

Reference the generic power-domain schema.

Update MAINTAINERS for the new path.

Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ------------------
 .../power/stericsson,ux500-pm-domains.yaml         | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 42 insertions(+), 35 deletions(-)

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
index 000000000000..bf83ce332674
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/stericsson,ux500-pm-domains.yaml
@@ -0,0 +1,41 @@
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
+  indexes defined in include/dt-bindings/arm/ux500_pm_domains.h.
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

