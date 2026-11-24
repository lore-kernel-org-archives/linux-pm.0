Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795542213;
	b=pn2oci0yYCRHI3Is77CG+YjHVyStOpTNBR/n8wZg9AeVBASmcTXAaHDLSUUWfhHOaeoz
	 q2P52VBn9yp8gajer5I3d4wfQcSVswEfXv5cwalPlJVY+k4GrAk6YNzMrL0OYua6Ub+BZ
	 Zm1VxsINSoYl5FSCvs++WsPZJNtScdEN2o93VsjRVWX5xm+eVjTwheC/2yNaTZ52TRD6F
	 5OHnp5dU2QogBk8psPEL8HFPHOf1gLz18FRd9vvWQcJ91Uhaq04gP200XFFqUHr+0t0tR
	 rGc26LiBDWjm/DRkUm9ZV3DnlpslQvk9GVGKua9tBT7UhNGVJXvqud+uipxzmt6qoAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542213;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AvAtdQ9JzgRGhEaJ9kUoTUCtxq5S9HTZEZpJk4MbDN4=;
	b=3bOTU8NimJg/NixA9J+c9LPlGJf9iUV9vUMLicuMftvNYtgsaCeulTfBSvI0FZ4GLmD2
	 ltiNaui5aFdKGl5XHwgQknojQUvLljTqqqjaMys8IWo0yKzOBJIUUNVC931AeFdPKwWqv
	 dmgmS7o1fiq2192YWAn4F0N53ftrTn7GiwKBkmaFxVfgGfghVJhPmfcQvJIfFBsudPvnm
	 F9qg4virmgJ1qc5b4dIR8AG3ORyczDam9QbG4xgoGKaCpBEzD96AC8N7lbTf5du+02RNC
	 5BEtHxL9WlK0734q0XbGBXWpA4/Pr7tAQPQIRn52HtOphZAelqYIXWLBR4YTn3O4EPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70rX1Q2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021A606A681;
	Tue, 24 Nov 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70rX1Q2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795542212;
	b=JNCQgOWeCZnPjrPbpNgaCaCXjmT8FXJOc9q8Xrq2g0dLFrC+bM/6aQ+wYYEjxBoP+Tlk
	 MRk0c0p2c4F3aAARVjBRc38iqtlqHTaaYpzl2dWxiVqbvGrZUcUbp/KwmGYTFLbWE5kgN
	 DCKOQEcBURxLBLovMxnrfLMkGBCwKOIRmZ1KVhVPP6Pm0lH+JfWqg6ywTErrWDzr4UnWB
	 FnNkOsWOg9UtkIulV+8Im6uHh4m4AZ2wigAoLU2a2hLNw3+U3J6fpK6FV6915ESyTO2D0
	 63kZ4lqygo/C/noXCWfI32CoJR2LTiDLV6LaVnbgCDQretwYdkIj7nC9JXy0c7utXRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795542212;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AvAtdQ9JzgRGhEaJ9kUoTUCtxq5S9HTZEZpJk4MbDN4=;
	b=Za0yt7k9IOjbUGaLVJ3WOVlO3L4DaR9YdjJo+pO53k5A56rj7FXeEgx68G9U3nPzswmn
	 HuF4YmI9utqIQS7k6UNjd9ElqMZ+N7DaVtok6G9q7ejRfOLBdoW5SeH8UlytN0WdJpU89
	 SKAKA3N8+DjiI6Ohz/Ama++56wBVXr2eskpbu8+Jsa2Cq+EcTsrfjVz2/93aZJD1TgH7q
	 3Ce9/OX3QZm8VUd6OZxA87gbKs4GgtjcVD76QWJE3asJ/vLe+cLOI4ixsSpMxTFt582+7
	 ZEMrpny5B75P1fUIsHBLXAyDOOyoLgK3+kB/o1iwAWn+Fg7C+fn81gw/+phJSUjesPA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4C0931F00A01;
	Tue, 24 Nov 2026 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542212;
	bh=AvAtdQ9JzgRGhEaJ9kUoTUCtxq5S9HTZEZpJk4MbDN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E70rX1Q2m2zgFps7m2W25Lm/q9NuBLUHxi0frO3VPPd/uU1wysWnDl1RnJo0V0sKT
	 OQjQt9ZC0qUnXhYf/jJ5nh9P1j6n5g/N/SGYlPYxjtmlcOm1P+2WrS+P2Kn+8mxHdN
	 R7TOq2ZJ2EyoEgUDkbCik1u5R8TorAOMBH48uxXzhTI/9bcQyUDhcqSnlfmj61+Ww5
	 UvSRHxl4Amm35aREy3qLk8uQRRk6rEwe7ziQHuqEtEjI1M9w6POfo8pGxjW7gkIVQ/
	 gqw99ScOaxPjPN7kfHyZfG11Kvj4VJLZfU3HqLZICB+qv6CwoNmn2cmbQtk+sDyUUj
	 HN+Ao1FaRFWgw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D4C8E4CB28;
	Tue, 24 Nov 2026 17:43:20 +0000 (UTC)
From: Armandas Kvietkus via B4 Relay <devnull+armandas.kvietkus.proton.me@kernel.org>
Date: Tue, 24 Nov 2026 18:43:20 +0100
Subject: [PATCH 1/2] dt-bindings: power: supply: Add Maxim DS28E16
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-ds28e16-v1-1-bed431df0578@proton.me>
References: <20261124-ds28e16-v1-0-bed431df0578@proton.me>
In-Reply-To: <20261124-ds28e16-v1-0-bed431df0578@proton.me>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Armandas Kvietkus <armandas.kvietkus@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795542200; l=1712;
 i=armandas.kvietkus@proton.me; h=from:subject:message-id;
 bh=cPg7Cg+cHTWnzByN+nzFNB6aPtM09Gw/8/P3zoDCNl8=;
 b=kzZxpgDdA7EeVTVwXiwOhTzYrMG9nPBDB/huvJe0pBDOzoz0qpBa6HQCPgvg+VAoEt8CgfwQC
 pJVyeqjVCCKADeJZ7xft72XZ3Vw9vtlqcvtBXoqoSLTfn2E563Lteq8
X-Developer-Key: i=armandas.kvietkus@proton.me; a=ed25519;
 pk=wuqmImJ9sKlDVcwALOvfGhjj7G8EBjjM4TpCdmlrAf8=
X-Endpoint-Received: by B4 Relay for armandas.kvietkus@proton.me/default
 with auth_id=974
X-Original-From: Armandas Kvietkus <armandas.kvietkus@proton.me>
Reply-To: armandas.kvietkus@proton.me
Content-Transfer-Encoding: 7bit

From: Armandas Kvietkus <armandas.kvietkus@proton.me>

The DS28E16 is a 1-Wire secure authenticator found in some battery
packs. Its decrement counter page holds the cycle count of the pack.

Signed-off-by: Armandas Kvietkus <armandas.kvietkus@proton.me>
---
 .../bindings/power/supply/maxim,ds28e16.yaml       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds28e16.yaml b/Documentation/devicetree/bindings/power/supply/maxim,ds28e16.yaml
new file mode 100644
index 000000000000..b381bdf68239
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds28e16.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,ds28e16.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim DS28E16 battery pack authenticator
+
+maintainers:
+  - Armandas Kvietkus <armandas.kvietkus@proton.me>
+
+description:
+  The DS28E16 is a secure authenticator inside some battery packs, for
+  example in Xiaomi SM8250 phones. It is connected to a GPIO that is used as
+  a 1-Wire data line. Page 2 of its memory holds a one way decrement counter
+  that stores the charge cycle count of the pack.
+
+properties:
+  compatible:
+    const: maxim,ds28e16
+
+  onewire-gpios:
+    maxItems: 1
+    description: GPIO used as the 1-Wire data line.
+
+required:
+  - compatible
+  - onewire-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    battery-id {
+        compatible = "maxim,ds28e16";
+        onewire-gpios = <&tlmm 25 GPIO_ACTIVE_HIGH>;
+    };

-- 
2.56.0


