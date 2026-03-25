Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7509D322B7B;
	Wed, 25 Mar 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477355; cv=none; b=qtMgbhJMX5q+6LYfunU8YS1hvupoUcpeTvf6WpMs0DRcwjsWcuN7NFz9moZq1sZPsjwYjoiQHlwYzRosSe8Z3Tx6czenkjJMVUJ72w4V9LY9Yt+fvpGP7PEmjoQTH1fItvxWWUmvPWhYGg/t8mF69EPdSKfcy1MZDg+XCAVFT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477355; c=relaxed/simple;
	bh=2aya4qzSBOnrqFcF0qCiQffRH1oUsnDZtVMTEa3jgnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBzY1qykXeZgqFkQi60g7qryJ/32A899e0A7amhiloGBM+/v9s33LGFY84Ku9aHqapBGH4sEul5nOjQp7UocvkR1fyBX/CpZZZA4DVngP0XDS6hPtxafgNICQfSfMxytztzj60PnYBDb4QC0VgH0XmQAMhHnVStHx8U0huEhf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml0wSrig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml0wSrig"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 405E1C2BCB4;
	Wed, 25 Mar 2026 22:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774477355;
	bh=2aya4qzSBOnrqFcF0qCiQffRH1oUsnDZtVMTEa3jgnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ml0wSrigpR2DeHga6KHr4v8dLcTUo6ZEco/FPiw8erY70q6kzf7ChYRCbB2s0ofgb
	 lyASFqjbGMUfN5L6AdvdLHLN7ekJi2XNYkYSeRz73uM+dINv+ffNxuhLPoY5sqgm1G
	 GEr3N5/5sNx+cHyIGzHr6yMKnnTbnzkPkufn4cWvHLeR9XAOpkOmZKfTLzO36OYgsP
	 cBW53YtJBPDamav8JExn4XpIJlywsnnNtXUSkG6HWFHaIagdQaLq7AnYGwqPdyBJ8B
	 mkqQoVWtVaal+uwX2jwTyhi+eI5Y7kLlw69SuVKN5XhyndQ8uz28iY7hhuQmKOOWS+
	 sTBdrObXYChgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD4109E529;
	Wed, 25 Mar 2026 22:22:35 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 25 Mar 2026 22:22:23 +0000
Subject: [PATCH v9 2/6] dt-bindings: usb: maxim,max33359: Add supply
 property for vbus
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-max77759-charger-v9-2-4486dd297adc@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774477354; l=1273;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=xHGJ1Vk5ohekxV/HkgsFaQ5FhplVGnbXa8tx/HTuhSE=;
 b=CTTOsuHGqVUcu4uWfAFuYbSqHf/2gLAtRaF9QcKDjxZI511TxrXnXqTcN5uL2O40X58LVgvhg
 2xQrghgR95LAiEQ4UxBVsFYDj/kEO+8Q7PFMWxrkTvQlb05IeA8qpkG
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a regulator supply property for vbus. This notifies the regulator
provider to source vbus when Type-C operates in Source power mode,
while turn off sourcing vbus when operating in Sink mode or
disconnected.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 3de4dc40b791..e652a24902ea 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -32,6 +32,9 @@ properties:
     description:
       Properties for usb c connector.
 
+  vbus-supply:
+    description: Regulator to control sourcing Vbus.
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x25>;
             interrupt-parent = <&gpa8>;
             interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            vbus-supply = <&chgin_otg_reg>;
 
             connector {
                 compatible = "usb-c-connector";

-- 
2.53.0.1018.g2bb0e51243-goog


