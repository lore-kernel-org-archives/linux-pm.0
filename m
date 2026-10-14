Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4847F791
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009179; cv=none; b=PJ5cptcE9HWYjjnCPWuexjITMPYnKhuPL7NgkOM8rdra183hM1y98pPt6Dlf64ZfvKWHZ9shZVHckJRSyls9ylS8Jw5+05RA3Pg5IvF3xdFazO6UUgTjkWA8wIhAEimQM/516sYgENOOssf72o1IBleCBITRg2NqqVxaEtNG50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009179; c=relaxed/simple;
	bh=TiyTyKlgH8isy5YpHa7vsjoj2Uif0KNt2MkpJLk2D/Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nOALEQOB1KY+BDfKuPQ2p1w15wv2tvP2TuAK4UP4CSa+yntWpc2kUiE9bA/F5XBv06KBudBNok8LH06Z48UiPZL06FcXVy7lnqAgmB8SVxUVXek862Cez65DQONx98OqTobZ4FK0yCUV+k+GqchAKdBG8BHVWmfQedyqoGqAZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oxWmE9c7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbQ4op87; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oxWmE9c7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbQ4op87"
Date: Wed, 14 Oct 2026 20:19:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9P080eUnXi747rxWwvWJZfACAuygUj0R9cOAmwnogs=;
	b=oxWmE9c7UVJTDIYKllc0BYsNh7INlzAm1ImlphiZ4fiucrzketCwBjKxX4IIxCTCWrgGW7
	/FuKgYMlnJiju5p+e9MIIBsUYzFn8H92Lgf8l4UDWACVzolvL9DnEs0k36D24Q4fW+FmgZ
	CeMv5KrQ/0Ex3KjNS95QGWe5pF/evJToS7UK0Xx+x3FB0QZz9h70Hulfd/PRQbafGE5V8U
	vIwVxay4SI8gEPG3+MAAmbtU5L3rqtKnyYY/rG4OwpYgbQRXCSxAIYTCIkqejrOkI+8R6L
	7Qk0O+zGjygh7qxp2sZgVKohusOEmn6OT+OO56sTTxX+FSizzUkgK6XBJeWz8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9P080eUnXi747rxWwvWJZfACAuygUj0R9cOAmwnogs=;
	b=vbQ4op87EodgBXnQhaTiyqn3DXSXO7VWu09KgglF7uRvs309LIIOODeStCHMlXKleYADlp
	RLphy2pfAeeCn6BA==
From: "thermal-bot for Ronald Claveau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: thermal: amlogic: describe
 bus clock for t7-thermal
Cc: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260923-fix-t7-thermal-clock-v2-1-bff7a09eb487@aliel.fr>
References: <20260923-fix-t7-thermal-clock-v2-1-bff7a09eb487@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200917372.2666337.11776634864294244788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     8195b945794ca3a917131b8a5368bb61e687c927
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//8195b945794ca3a917131b8a5368bb61e687c927
Author:        Ronald Claveau <linux-kernel-dev@aliel.fr>
AuthorDate:    Wed, 23 Sep 2026 16:37:50 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:41 +02:00

dt-bindings: thermal: amlogic: describe bus clock for t7-thermal

The t7 thermal sensor needs a bus clock, in addition to the existing
functional clock, to gate register access to the sensor. This bus
clock is specific to each sensor, unlike the functional clock which
is shared between sensors. The current binding only describes a
single unnamed clock and therefore cannot represent this hardware
requirement, so add a second clock entry and clock-names for clarity.
Make the second clock mandatory for the t7-thermal compatible only,
via an additional if/then/else, to avoid breaking other Amlogic SoCs
that still use a single clock. Update the t7 example to match.

Fixes: b1c8ccdbd4e9 ("dt-bindings: thermal: amlogic: Add support for T7")
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260923-fix-t7-thermal-clock-v2-1-bff7a09eb48=
7@aliel.fr
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 29 ++++++-
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b=
/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 8cfa44d..e72cb39 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -32,7 +32,15 @@ properties:
     maxItems: 1
=20
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Bus clock, gates register access to the sensor.
+      - description: Functional clock of the temperature sensor, shared betw=
een sensors.
+
+  clock-names:
+    items:
+      - const: bus
+      - const: core
=20
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
=20
 unevaluatedProperties: false
=20
@@ -94,7 +118,8 @@ examples:
         compatible =3D "amlogic,t7-thermal";
         reg =3D <0x20000 0x50>;
         interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-        clocks =3D <&clkc_periphs CLKID_TS>;
+        clocks =3D <&clkc_periphs CLKID_SYS_TS_A73>, <&clkc_periphs CLKID_TS=
>;
+        clock-names =3D "bus", "core";
         #thermal-sensor-cells =3D <0>;
         amlogic,secure-monitor =3D <&sm 1>;
     };
