Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF549F10D;
	Wed, 23 Sep 2026 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164366; cv=none; b=SVZjvNzUyPnb5OuDTk5PEuur6LWBw1T5E6S+VESmcp3xuL2fnk6dUB5tWABEWGtjjSEwAYArdB33If5XEJzHocLUkllY73tRrmm/st4EwqbwrY5lrgaR+ix2VO724ji5Qsj6ucSAT8LLuaa9ZibeG16GtLqRR8OqoIBCl06BTOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164366; c=relaxed/simple;
	bh=pRBoDwm+hXbNgvkCq0UMM6iOsik44TmlbYaHoFXQ904=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pi0qI6MwgEyfKC586eBWfH2WC4ywNmqQt+TeSP5kG5vnyAdCN716zV2bZGU8tVNEqsIa5NQXQnZdQ8YkHjaWNfxTMM0jCLtP8HdGs8w713l49fz1gXEvrFEfSnTQ4OP/QNd2A9NYsusw8xqkklLOCYrJuv5+H1HVLN9Lq4Xildo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzALtcS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzALtcS/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9322C2BCB8;
	Wed, 23 Sep 2026 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790164365;
	bh=pRBoDwm+hXbNgvkCq0UMM6iOsik44TmlbYaHoFXQ904=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SzALtcS/bElt5UmQfBT2TFCgq2+/WwkvHbETSLmyxUfEY5oGxajIrAfhivw5vkB1Q
	 qLN28M7PeX00+qUUFew7Cmkx5waGc3wD9O0sNT2GQfavyAOUBvfCo8ZzYW2H192xQV
	 ZflbtrSiI+62xl0By2DPng+YTFyPrXg/lDWMtJj/f/P9XBNDMqb2JJsrVq+CkBKoC6
	 k8PoYaLBWH8piV+EpJaZgV27KLvxza7B0ljkgY9wOZchodnI69dii9lx7jgYzb3lnT
	 I+Ydihka0FA0AwC5XxjLUT+w8Gq2a+aSk3Kvn7TQzKXCmEASbraoQE6dz4U2U3gW5E
	 +bt7p5ZttfZnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9940BC98307;
	Wed, 23 Sep 2026 11:52:45 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 23 Sep 2026 13:51:02 +0200
Subject: [PATCH 1/2] dt-bindings: thermal: amlogic: describe bus clock for
 t7-thermal
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-fix-t7-thermal-clock-v1-1-7d4c4682f182@aliel.fr>
References: <20260923-fix-t7-thermal-clock-v1-0-7d4c4682f182@aliel.fr>
In-Reply-To: <20260923-fix-t7-thermal-clock-v1-0-7d4c4682f182@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-pm@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=J2Flc6GT2BuQ4CMvkke4xIIVWFYzKvE68xnnn2N8gnk=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9bmvZXNnXxeEo+0NX7eWV1vf3rqYrafP8QaNEMTnx19c
 Db9q9ScjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAikSWMDFdefNDdvPTZ4d3l
 3AGh0lNTNatfNxWdyEiw5J63ZNKmVGFGhiOnD69uevihd+mR7yHz5D+In+frbXv66ult494/pg3
 6NxgB
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The t7 thermal sensor needs a bus clock, in addition to the existing
functional clock, to gate register access to the sensor. This bus
clock is specific to each sensor, unlike the functional clock which
is shared between sensors. The current binding only describes a
single unnamed clock and therefore cannot represent this hardware
requirement, so add clock-names to disambiguate "bus" from "core" and
make the second clock mandatory for the t7-thermal compatible only,
via an additional if/then/else, to avoid breaking other Amlogic SoCs
that still use a single clock. Update the t7 example to match.

Fixes: b1c8ccdbd4e9 ("dt-bindings: thermal: amlogic: Add support for T7")
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 29 ++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 8cfa44dcda58c..e72cb39ac635d 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -32,7 +32,15 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Bus clock, gates register access to the sensor.
+      - description: Functional clock of the temperature sensor, shared between sensors.
+
+  clock-names:
+    items:
+      - const: bus
+      - const: core
 
   power-domains:
     maxItems: 1
@@ -72,6 +80,22 @@ allOf:
     else:
       required:
         - amlogic,secure-monitor
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-thermal
+    then:
+      properties:
+        clocks:
+          minItems: 2
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
 
 unevaluatedProperties: false
 
@@ -94,7 +118,8 @@ examples:
         compatible = "amlogic,t7-thermal";
         reg = <0x20000 0x50>;
         interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clkc_periphs CLKID_TS>;
+        clocks = <&clkc_periphs CLKID_SYS_TS_A73>, <&clkc_periphs CLKID_TS>;
+        clock-names = "bus", "core";
         #thermal-sensor-cells = <0>;
         amlogic,secure-monitor = <&sm 1>;
     };

-- 
2.49.0


