Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794411301;
	b=q4kI5mezJbJD7piC2tFXJMpwYgvkdvvsa8idbAXcb7kkpfVTxLac8wUc9qJ5YeFytmDS
	 qieqXJn986nIK/aln6hJSe8Rf2BmQmo9RG+4qA7bAGZg/vFYyxfhdbRd7KDthvhDIaHls
	 7eO3+DuxvGMzWT9XDtZq/ZcPjSEoEmrYoQ3z69cwqXMbHSIyq3cs+U/c8+eo5zwnVGhI3
	 COIeqC1U1G190N0zyDArtr6upOuB+f/TYerfnIIalg9Rz45uwt6SJxpxrOKuW4JMgmhA5
	 tsYjlTWqi0SWkAlh3/0p/3riQmju4GKPuKTEehr3+j0v6mpFRGLZGm8K5CdRAulYz5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411301;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QAj6gtHaGtEaBXpANO4ITchfgvOEsGwGT9yZbvqX0MY=;
	b=xunvzytcO3PhjsNKV6m4CgMWquSO/DQhd7q3HYGGsjiW08V/nZ6VQiE4H3dCyAgFiM7l
	 +HZr2lKPgsVfcU4s/wzSR9bs6VTzIqbOXkoTMZ2tdRIvlXrCyNxT9agIPbrQbcmMMzG5m
	 KWTQn3O7yN6Od74GbBz0t8goW9WDFOPAse5fNimRx4MUE+0CHKCFQUc3G4JlYDh3B2HYi
	 duk6heMoRPfy2jqSdDMw25vLFA6fg/rywPfM8sm7NetG2/6kn68spDreiNmXLw5T1pQCV
	 YXMqnsPfSBtCyQ83aMkrLG2xxp1BPLlltsMmFA6HK5q2ufWeLH6VVrdfUSO2tcIGqdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hv0fsQzP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C27606A326;
	Wed, 11 Nov 2026 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hv0fsQzP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794411301;
	b=kZol0yB2JntlXuppNvipiOppltI6PEusx0mLpQ3Pv19cyN4aP9DmMwKbdlZGplcTv5Bk
	 pGPqBGKfQhhFV7Yc+m8L8gdKJTtSS7Mt/E1D7YfK34jAV3T9W+SSV8SVa5guZXtJ59+De
	 DPDnhuVx1SG3sxooXfJqBJTb1ksWIEXNmTzdaCehjNnI+5Gp4lVqOYmDyOxfwq72+5lDg
	 BEo3TrrCbFAldoUAD5KT8XJXF7P1k6dl4ZKXqrmPoSqvnf0z2lI8KiNW2zBgbSHv1gTLs
	 2l89wUeLJmycIEcWCBcS6K180vd1MbPc30kmcKujPXOnrQBrKWfB0DcVdxys6L2+LjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794411301;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QAj6gtHaGtEaBXpANO4ITchfgvOEsGwGT9yZbvqX0MY=;
	b=t7vqQ1zxO25bf6PauAT2PMBB59Loz3g0fXGL1CntAVUyUSLKCql9/gHGIcr1kWDKukgr
	 HH9zldBCkvLGJYptPJlqnld/QTc/GH1nAET3MpBOYr/v5a+X1szFHf5d+j8xT0joLAB++
	 MpDCQF5/9948wCW9hPPKZ2bYusPZZ2t1RGZEwcUGhzNoMdF3kM9Mf4u6AaOy0q60hwqHi
	 U0ikAn9v0F32Wa7Bj9Z1ZcW+wAHKQdVDwS5WLYlEi3Vcl43o7p7uoNQOPHtERflizOzEF
	 p+kE74TzL4cDEPIsVZJKrRPjicnkT/hGuxPFPQkwd9NNl5qpjHJc7R4AWooD3+MncpA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 94F051F00A05;
	Wed, 11 Nov 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411301;
	bh=QAj6gtHaGtEaBXpANO4ITchfgvOEsGwGT9yZbvqX0MY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Hv0fsQzPiAlCa45UL5CUToud5m22ud5BQcf+KmDErqoPikvcytsVQGW7HBNvkGOWt
	 LfRFgG2WHHsBWStMWTC7QpbiQZc/lO6s07ywkcCiWsYOOHGzpykjA+eC5U9ss/yEl6
	 fErRD1TplXc1DXQ3YzGo7bMUHBN5u6uB2EH2Lig+5Gg8dCR6PQ6J63+909eOfMukKa
	 ETfTN6kMK2ob3Jbf0SXq2p/vsPLz/qsdZbbbOx1wsCWBPwL+P5rMRfA0HqW1a3QqTn
	 1jP3LrUJYUtcjBsvkl1SkfxIs2A7LU1C7bkja9yeTBUKC1x9yxVu9wiSdSwAkIb8rz
	 7fnXJerZGLzQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 13C2949000;
	Wed, 11 Nov 2026 15:35:00 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:34:59 +0200
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
Message-Id: <20261111-sm5714-fuel-gauge-v1-1-b9d163fff6ff@gmail.com>
References: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
In-Reply-To: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794411298; l=2367;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=l9dRAjJonPbniX5sdrRnnL5yQqFuAZe21X2uph8Yb7s=;
 b=oBEF4DLZSmYt5qhnuCWRprl7mJpMOgHC+cZY1+lCyQmqM2f2vWsfHYW1skKFWv3IpKTgwsCg/
 ThQzAUvqTk2A52gsXON6Thy64SeI+6Ts8BpCm01d0GwDdnd5HXFEkw5
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com
Content-Transfer-Encoding: 7bit

From: Asdlerto Korry <korryasdlerto@gmail.com>

The SM5714 is a power management chip for mobile phones that combines a
charger, a USB Type-C port controller, a MUIC and a fuel gauge, each on
its own I2C address. It is used in the Samsung Galaxy M52 5G.

Add a binding for the fuel gauge. The temperature measured by the gauge
itself rises with the charge current, so an optional ADC channel can
point at the battery thermistor.

Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
 .../supply/siliconmitus,sm5714-fuelgauge.yaml      | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuelgauge.yaml b/Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuelgauge.yaml
new file mode 100644
index 000000000000..af51db8cf13d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/siliconmitus,sm5714-fuelgauge.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/siliconmitus,sm5714-fuelgauge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus SM5714 fuel gauge
+
+maintainers:
+  - Asdlerto Korry <korryasdlerto@gmail.com>
+
+description:
+  The SM5714 is a power management chip for mobile phones with a charger,
+  a USB Type-C port controller, a MUIC and a fuel gauge, each on its own
+  I2C address. This binding describes the fuel gauge, which reports the
+  battery state of charge, voltage and current.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: siliconmitus,sm5714-fuelgauge
+
+  reg:
+    maxItems: 1
+
+  io-channels:
+    maxItems: 1
+    description:
+      ADC channel that reports the temperature of the battery thermistor.
+      The temperature measured by the fuel gauge itself rises with the
+      charge current, so the battery temperature is taken from this
+      channel when it is present.
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@71 {
+        compatible = "siliconmitus,sm5714-fuelgauge";
+        reg = <0x71>;
+        io-channels = <&pmk8350_vadc 0x14b>;
+      };
+    };

-- 
2.25.1


