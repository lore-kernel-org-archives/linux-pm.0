Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5418DB26;
	Sat, 14 Mar 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524158; cv=none; b=jlkPPUhwZ6g6MtXXungJ0cJwdLoKNldLYeMdBXRaFYaEMlXgJq/xeXeudUcQI/1WFUMGdkR+B99huslHXtKl5OlT6nHqgPrX1V82RPudosi50kpUJxZwJCIu5GaYQ1FPXOJ287aTYgIO2b0r+5fRItL0HqTk7MtCrhinJM/qQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524158; c=relaxed/simple;
	bh=K5jKc+bfoQGgPh8KBEr0OLcmp06yl8CI1lJPLqzYbkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkbpHkwWrfPScr0gUEDAN0mqtXPCB85itOTmbF/5hB4QC34m1PCcApPVJmEmPdTuDHACrHGrLqGo6aXqJwUbsoh8mKxbmCmALHBprzqA8jlwNOsvduhB6Vywv+Kt/ZZhDFjtaMxxlmnwxJEzG8bvFAeSKQM58I/qUH8CBsJ3oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekVHG2xf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekVHG2xf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A876C2BC9E;
	Sat, 14 Mar 2026 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773524158;
	bh=K5jKc+bfoQGgPh8KBEr0OLcmp06yl8CI1lJPLqzYbkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ekVHG2xfPVlP43cP3OdQM/ab0bf1Wn3bo60nUhUoS9IJGQc0zfW2rhS5/iAeR9Xqj
	 pvj/xoQEMmfSJGrtVrR57H7MvZmiDSBlOHGtreqM4GvkrwdPTsgPQXv+6Bc9VMC2a6
	 KhcxlLkLSm/uIM8izh0fLIhpPtSX6GDYeZTuJld7pjOJ34RzW0gX4/igIzmcy1EsRp
	 ZuTXJjHnKE2cziVH62jDMRqr9dwCy8dn+0TBZfKECEN3hWw/xip0gX3oiLzVvC7jCP
	 4l4sYJ4U67lqDbHJIA4shT7wl6KEE2C45G6JcfQuXZBHt9Rt2OF6fwy+nlOF42Gqgl
	 A/ZXr+xnWFF1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2310854AE;
	Sat, 14 Mar 2026 21:35:58 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sat, 14 Mar 2026 21:35:37 +0000
Subject: [PATCH RESEND v8 2/6] dt-bindings: usb: maxim,max33359: Add supply
 property for vbus
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-max77759-charger-v8-2-226ca5f8c7d2@google.com>
References: <20260314-max77759-charger-v8-0-226ca5f8c7d2@google.com>
In-Reply-To: <20260314-max77759-charger-v8-0-226ca5f8c7d2@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773524157; l=1272;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=Hb4ezO3qv6ucXWhfGdtXpd/bi+P5qgWzJCv96jR/Yc4=;
 b=UOC4XbekIsphNyGleCB6JCZ2Zm2kfUcUr/8O8J5wdvWnLoM/8qTWDDsXgO3hJgp5pv04ZsoZ0
 nzQXUgEAibmBxvLH3ekE8HHOOTMh6zRDB4SgVx3RBLVnH5qj8DTUKXe
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
2.53.0.851.ga537e3e6e9-goog


