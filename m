Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECC420463;
	Mon,  5 Oct 2026 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239126; cv=none; b=t5zZ+x715ljbmZODTLmYN6SY77rg84g2Y5zURFh1+fmbi5W6mo1NETo62fXvI4QB8UnmHKvA3azwHCQ5QRU0B5UnRasl0SMnEIkIgq6fDcDlOvQLULjT1i262T+yk0jIHNseHlk7Y8yzIy4S9+6nVObNzzVnZ7B+pYnBRj4zW0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239126; c=relaxed/simple;
	bh=EMt6dqz/oyX0hV3reZ7z50cmHcvyWKCxaYWuxISReao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VpnkLe6BBjLd7VQYyZ/PxN/sSuOLAdR43bTjdBrd9YhzKoOp4o/3lKkovz6Lj7fjD2svWMLwuVX9fPwbM+B6AseVq0CnLRvdhuJgLVBNaf2Pq1ZJUZXNFH/6U6FTETBn7CrIq47/UJ1/8fZqNuQqsc3Uf19ieys1a7V9Z5/wC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W89HDsnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W89HDsnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDEC8C4AF61;
	Mon,  5 Oct 2026 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791239125;
	bh=EMt6dqz/oyX0hV3reZ7z50cmHcvyWKCxaYWuxISReao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W89HDsnQ4zJ9GqMC2aQLJmXhvaS/hXaWPHKbHr3gkyKFgyF7kNI5NLpKXbtW7kQhP
	 eoiANA9rOCYeVP9YD9XjHem6Whbh1vNo3G7vRKOwiIzyJenvc5gvwaS74SpD/OB/Yw
	 49XPmPqTGXiBfLfONV8dY9gAt119Lo7TcTLaplQNpxj1RixmZiu4WABxAZicsgnMRY
	 UFNq/SvXjUoZplnsc5JY92gPqirXlEh9/D3vNDxn3um3F85/AXrufFDP6Dv4jif5Qr
	 nSic1Fl5cnLhG48pVxUSjst9Mk4XUemvY+6m+wv7Kxk0I1YF5PfwCJnHxkaXsTfEK8
	 uSAs5GTC8kKrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4818CA5FF0;
	Mon,  5 Oct 2026 22:25:25 +0000 (UTC)
From: Serv Pol via B4 Relay <devnull+servpol.tuta.io@kernel.org>
Date: Mon, 05 Oct 2026 22:25:24 +0000
Subject: [PATCH 1/2] dt-bindings: power: supply: Add GL.iNet GL-E750 MCU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-gl-e750-mcu-v1-1-499d2e31f786@tuta.io>
References: <20261005-gl-e750-mcu-v1-0-499d2e31f786@tuta.io>
In-Reply-To: <20261005-gl-e750-mcu-v1-0-499d2e31f786@tuta.io>
To: Serv Pol <servpol@tuta.io>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791239123; l=2280;
 i=servpol@tuta.io; s=20261005; h=from:subject:message-id;
 bh=H7uqR2k0sKISYlRblSwjWKrBqVMzecHmO4gYPBxy3Zw=;
 b=xutWf7SoAUI29EWuNuI56TDPwetjyU7bjxjIK8oW6+i2dwBzX1C20pK5szA5MY+atm46J1jYx
 hoeEIxFaWk5A3GHvSxKPrPQHO3bWP1TaB8ZwIUWD0LR/+ynyM1G1HxO
X-Developer-Key: i=servpol@tuta.io; a=ed25519;
 pk=2HCjaqYjXxgwTYu30Nem9DOHT8mtKgjitt1vEXKpwrE=
X-Endpoint-Received: by B4 Relay for servpol@tuta.io/20261005 with
 auth_id=1120
X-Original-From: Serv Pol <servpol@tuta.io>
Reply-To: servpol@tuta.io

From: Serv Pol <servpol@tuta.io>

The GL.iNet GL-E750 (Mudi) travel router has a microcontroller on the SoC
UART. It drives the OLED status screen, monitors the battery and reports
when the power switch is turned off, a few seconds before it cuts the
power. Add a binding for it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Serv Pol <servpol@tuta.io>
---
 .../bindings/power/supply/glinet,gl-e750-mcu.yaml  | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml b/Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
new file mode 100644
index 000000000..a7ea4dde8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/glinet,gl-e750-mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GL.iNet GL-E750 status MCU
+
+maintainers:
+  - Serv Pol <servpol@tuta.io>
+
+description:
+  The GL.iNet GL-E750 (Mudi) travel router has a microcontroller connected
+  to the SoC UART. It drives the OLED status screen, monitors the battery
+  and reports when the power switch is turned off, a few seconds before it
+  cuts the power.
+
+allOf:
+  - $ref: power-supply.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: glinet,gl-e750-mcu
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        mcu {
+            compatible = "glinet,gl-e750-mcu";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d..247432449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11105,6 +11105,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/gigabyte-wmi.c
 
+GL.INET GL-E750 MCU BATTERY DRIVER
+M:	Serv Pol <servpol@tuta.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
+
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 S:	Maintained

-- 
2.47.3


