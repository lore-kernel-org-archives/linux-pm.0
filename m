Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794136948;
	b=ToTDHzFs08ntnuhCBADwpDnT4lCPHkl7I4FFBd0eewHcN2+8LB2P97T0bLz1NrSWk50O
	 8aiJiKkmXMojPgdTeCO5eZfvdk9sMLvmwrJE/F2Bych014wed+gYbkDN1GJw+L6WxOA91
	 Gghn25w9uXvwY/N3dotltt2PoQibiaEpnUO9oT3P8XDOzmEelTEx/24MrA68oLZoNf5ib
	 O9fqJMUbdVo6QOcA5xPJtU2iHJbaT7FMzowkNE0Uy26X6/BHsslaBym4R3SLr2pOcXqHi
	 2j5z9WRClFFGzTfYmndHDXOXL1aPvph29k2N4hWm8kURwYk5b4oeDNann2Bzg09XfDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136948;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=30rCFzNr9gY6z8lRfGlzbPoFTDqBDmH9lBypvenCwWI=;
	b=QPcCQinYT62U4Guw20hlhq/1Wu+Fni7FYs9u1tRHv9g9mH8h3ytB3L3Fw1NsHlcafc/N
	 3M2xfSCdGSolQtpAXFo7Dna/dFcQleC8CV3lvaFjSoDWRc+9W3Y+AnnDaAJKyZcK4X/+w
	 T5sYzB5PZTP1dEbISJLrD8/n3A2IUZkpd3EXea+9PxSHYJk6f54RrEyx9Udhb6WAuW45i
	 5aGYIc/yj8u8wnH43jrx0VOj92wmxvzarQlKrkYesmoGlopkOBrUwXG+XpK5ulLNh0Zkb
	 +zGNwMhYBmzWBg+vmpeacktJkLI4GGxI1laZwPlbfZsIXfPyt+PbhmMyBmqfmYsSY9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOR8xuDd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB1606A333;
	Sun,  8 Nov 2026 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOR8xuDd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794136948;
	b=lOmS75wEtHiInCYxXBJTj/HjZeQ5Zr0tXqUEhbwee90t+q1O2OagCj9GvtMLKyqeKFuD
	 jTIzowGli86mtz3hH2PXdCrI+Bkt5JrrOLzC+0alcaqeDqjtPqP25rFEoHGaZ5TCTlkf/
	 VCkdiehcm1kJB6nx2h3gdYtY58F/6Fog2YcK5xkNfiRnad2XvVIljxWzxUUELDNGvYZtX
	 1dgii8FIGSvTZs8CT++sK30TET8CsXG7TSj+qf99Bqu30HyERkUOb8yCUOsGNuxpIX4z6
	 dGWshdGZ/J1eqzQ4sJdABUWUyoVKvR8tVQWfMtYlkHomQl8tSa3dlfkUeUHYk7oMd3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794136948;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=30rCFzNr9gY6z8lRfGlzbPoFTDqBDmH9lBypvenCwWI=;
	b=fX+g2fGl5RrdOKw8vAGNb9KJxu8AgbCGyiKy6UZx6S6YGnl6DkVNWnCz0sRaoZDpRNbg
	 oyS3/PSXuJYU0GoOh8x5tvI7U1hExAMc+98i1NLwDg/Y5O0MCaRg7ln1Is42tuGurq7BV
	 raF/FWrdDiLH0QEY9I5StLjYa9G5fLXbYxcsVcFQ20T4QbYhB967s8UuhLyL14VqTA3Yr
	 weq8zmbvs+ZON2eBksz95NxahTfR6+gjwDgdBC9tg3WL9+8HdNaxd3JnJL2rdS36IOww2
	 4yfUS3ST+UFHenHBNOukevRPkxmm7PQtQoL6tbfuO9igFB4ocYFXKcPcjPQqddrUArw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F1D8D1F008A1;
	Sun,  8 Nov 2026 11:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136948;
	bh=30rCFzNr9gY6z8lRfGlzbPoFTDqBDmH9lBypvenCwWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oOR8xuDdu9dp0jYASM/2d9OxF0vvcTzKGurfIouZV6U4+FImVyq8Ow8bGw+5nD68+
	 eCZj5DIsG36JwwvJQ2o0ohd7604dFpf6MbNY8gwjfL8y7HfWpif1r/yporpZopeFXw
	 PasrjkEFVgIPCaQ4TG2GxpcmGnNnKtOrwgbJbus2j1CoPsC46U94JYLg2Z3ehq5/e4
	 IjUSz9bvC76gTC5fd4WvdkwOmbR3926K6LIoiQHIRNM/B9oSDVnaPRWL+NBRRiHgp0
	 7T3sQlvxwgfiZ5JQK5Pb7WP0kv53tS6JLSiKyWqvEoeafirrGwwGoq/1AkGiEzU5l+
	 PGNSpXcdpGKlA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87BEF47EE3;
	Sun,  8 Nov 2026 11:22:26 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 12:22:25 +0100
Subject: [PATCH 1/2] dt-bindings: power: supply: Add Silicon Mitus SM5714
 fuel gauge
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
Message-Id: <20261108-b4-sm5714-fuel-gauge-v1-1-c659b6c0884a@dxdmail.cc>
References: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
In-Reply-To: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794136945; l=2545;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=Cmh7YjU6/OabK3s0Tan26kUaXZen4FX7P/sskBlVdP0=;
 b=i4iCortCNP29TqalR0jK9yohaOIfM5L3HjlJHL47n1R9XTWJmh+DN7gyPc1B7YgVeMMcLSnIJ
 x7vjEp53nlmCuXaUVO2DQIacLXFXyVBzMC/cbuQqQwsAkJcO1F7Mdfp
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

The Silicon Mitus SM5714 includes a MUIC, a charger and a fuel gauge,
each at its own I2C address. Add a binding for the fuel gauge as a
separate device, like the MAX77705 fuel gauge.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 .../supply/siliconmitus,sm5714-fuel-gauge.yaml     | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuel-gauge.yaml
new file mode 100644
index 000000000000..777b64bade5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuel-gauge.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/siliconmitus,sm5714-fuel-gauge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus SM5714 fuel gauge
+
+maintainers:
+  - Nizat Mikayilli <nacht@dxdmail.cc>
+
+description:
+  The Silicon Mitus SM5714 includes a MUIC, a battery charger with a flash LED
+  driver and a fuel gauge, each on its own I2C address. The fuel gauge measures
+  the battery voltage and current and estimates the state of charge.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: siliconmitus,sm5714-fuel-gauge
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fuel-gauge@71 {
+            compatible = "siliconmitus,sm5714-fuel-gauge";
+            reg = <0x71>;
+            monitored-battery = <&battery>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..2875017d21c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25713,6 +25713,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml
 F:	drivers/net/wireless/silabs/
 
+SILICON MITUS SM5714 FUEL GAUGE DRIVER
+M:	Nizat Mikayilli <nacht@dxdmail.cc>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuel-gauge.yaml
+
 SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>

-- 
2.56.0


