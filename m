Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B732720C;
	Wed, 25 Mar 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477355; cv=none; b=sfyJdQlEktCBBjBz1h4UHv7nOGGRTm2sHO4oiCOJkRO1yWHfEuYzHs9JRSfOY7jkep1hMB/CD8D7xLQbLsFdb9IRrtkvlislmfAbYVlXH/HbsGyoR15KP0Hno4A47wQwke2irtiBn6CgNBmFIAKZe/Yt5u0NjxstOxXGeOaWPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477355; c=relaxed/simple;
	bh=9UCX6c9kBue4B3sgbyp0P1Fi4/nUyuZVOM3nKzPEbWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBtjSlKDqziHM9iiIYV3OhYVP7VVZJd6SA33VJWL4POjT+LDHG3J4S0BpDUYJ9T8saWWCDg0d3vwtEE2t3oI4JzRWvx3MGXaSffoH99FoWsole9GCxKRUWd0BNbu6KmdQJ97PZ/KrXdME71SlumiDhl7OY+ePeBF0MvYCPevVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXpL4/p+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXpL4/p+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C08C116C6;
	Wed, 25 Mar 2026 22:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774477355;
	bh=9UCX6c9kBue4B3sgbyp0P1Fi4/nUyuZVOM3nKzPEbWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LXpL4/p+3x2GYazbMumdPJ2u0s4HQn9WONBeVb9KuNqoRECEJnYzgV62TPBISI4HI
	 Iqp790T4+F4A9fD843kXcVg1Som7DXB2K/33XuNn9DPJEn4YVnIyZzc7K9k8Wg/tYt
	 ENIDnHJ5i863lJbZSYBcOfmFSCaTc6f9ZZwIE/A/HfSXDgrxyAwW2DqiTqGlE3be6e
	 DiW3UTchGsxv65duWRfMxOqdFJ/g6pd5Dt1cBmqBHpDltPCmTy7iIsQbhRnJCfL1o7
	 s5CmltsEo8KIfquu2hNIOL7UYXxekWnsjQRfyOVPCI4+aw1KgvKaAQpnoalH/axvB1
	 QQoXKCthNx2ig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B6109E527;
	Wed, 25 Mar 2026 22:22:35 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 25 Mar 2026 22:22:22 +0000
Subject: [PATCH v9 1/6] dt-bindings: mfd: maxim,max77759: reference
 power-supply schema and add regulator property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-max77759-charger-v9-1-4486dd297adc@google.com>
References: <20260325-max77759-charger-v9-0-4486dd297adc@google.com>
In-Reply-To: <20260325-max77759-charger-v9-0-4486dd297adc@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774477354; l=1898;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=vVEQb41vA+t6rlDPrzI7KwMZCc1WnDQaHQOICIfZd9s=;
 b=3j8YrSqS2bsLk/cq1k+cPifauF6cnA/HvyVgV3zfi6ELmpRQH1eCykwiBpndv7iy2yRq7X+Nb
 dlkLgbGkw+XDPWm5EOdSmAvy1c1LmTTfrfNnRNTWTGW2hotstxIGsab
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Extend the max77759 binding to reference power-supply schema, so that
PMIC node can reference its supplier. Also, add regulator property to
control CHGIN (OTG) voltage.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
index 525de9ab3c2b..42e4a84d5204 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -16,6 +16,9 @@ description: |
   The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors, USB
   Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
 
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
 properties:
   compatible:
     const: maxim,max77759
@@ -37,12 +40,18 @@ properties:
   nvmem-0:
     $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
 
+  chgin-otg-regulator:
+    type: object
+    description: Provides Boost for sourcing VBUS.
+    $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - interrupts
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -59,6 +68,11 @@ examples:
 
             interrupt-controller;
             #interrupt-cells = <2>;
+            power-supplies = <&maxtcpci>;
+
+            chgin-otg-regulator {
+                regulator-name = "chgin-otg";
+            };
 
             gpio {
                 compatible = "maxim,max77759-gpio";

-- 
2.53.0.1018.g2bb0e51243-goog


