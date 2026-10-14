Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE9492E26
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009199; cv=none; b=KypLyLhioWde3ZRwohTVMXtMP9i+qQs7j1O1Ms7KQonF9dH1i6aSNNm6Rns+CfdP8CN8X0k0AG9+zj/zYlmUrCkqcal0biHYQwXslf/3OhYiohVflI0CD3ugSYbFM29jbj2OH5GxxmL7SLTLQtlHTGTePmB3es+B4phPoxg4RKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009199; c=relaxed/simple;
	bh=IgIWJkIvDljwWhjJck8LxN+9j7nLYQ5ROq5KxOp1k/Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ayktC+1DTKm5CgCfrBJ15Onq43DGhHzbMD3VbqgOjmVGWI0+2JSKneo/mrNpoHa2YZRlGNXveijdNZOTIYenXyjRo9J8VhtmS0FJSBM2QDe8DZ+eWERuNUmXlR2rX4nu5ZzZKih8tRlNYo9vxyLRX1XbLfv5uME4Pgvr9FTNYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xG1FUnKa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oIkrlO8n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xG1FUnKa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oIkrlO8n"
Date: Wed, 14 Oct 2026 20:19:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeS7eJVZg1V4d6n7p7tfyt4v1NL/j+GEJIpdICmUF5E=;
	b=xG1FUnKaFKxQlq9E6KytKEme50e0rLClH+QzItHV0PB/t8MOhGQdN3eEZFFqJ9lLXtfsOJ
	gS5Ca7CyZbF8qIcq4WUc+w4ESx5w+TJqC9F1tnJ6qFm7gGipJ+m03lWe41AS29/eAmOiTZ
	DlSWN8jerk93j5OMjJJXLZ/nZoVHjp+ApHU2CuC9taGiOXLfxp1harbBWKoYxHaW9ZQrVF
	abEGrqCJIB7zFFVgLRAyPjLccNklPgPQDxbZlz8t73dF8WWyuekNvlckcUnoh1NdSS7gwQ
	+YEX71hZ2bsoeJXixjYbMNLHBNFeC/lw2uSGJBbu3M00/Hdga/Ddg4WKNxjIVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeS7eJVZg1V4d6n7p7tfyt4v1NL/j+GEJIpdICmUF5E=;
	b=oIkrlO8nD8keq+IeP+e+sj/F37zV4feMH1Fdwkeutz6hM8FsOt0XPA4Wd+TJIuzpnphFnh
	/dFq32CnTHbFIhBQ==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/linux-next] dt-bindings: thermal: Add Google GS101 TMU
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Peter Griffin <peter.griffin@linaro.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200919468.2666337.17118439006360102773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     ddb39deb06e0f816bba0cbcc3a658661df308f8d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//ddb39deb06e0f816bba0cbcc3a658661df308f8d
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Wed, 03 Jun 2026 13:00:16=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Mon, 28 Sep 2026 17:59:24 +02:00

dt-bindings: thermal: Add Google GS101 TMU

Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.

The GS101 TMU utilizes a hybrid control model shared between the
Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
firmware. This hybrid ACPM TMU architecture is also present on other
Samsung Exynos SoCs (e.g., AutoV920, Exynos850).

While the TMU is a standard memory-mapped IP block, on this platform
the AP's direct register access is restricted to the interrupt pending
(INTPEND) registers for event identification. High-level functional
tasks, such as sensor initialization, threshold programming, and
temperature reads, are delegated to the ACPM firmware.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://patch.msgid.link/20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org
---
 Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml | 69 +++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/google,gs101-tm=
u-top.yaml

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.y=
aml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 0000000..75560eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos ACPM Thermal Management Unit (TMU)
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description:
+  The Samsung Exynos ACPM TMU is a thermal sensor block found on Exynos
+  based platforms (such as Google GS101 and Exynos850). It supports
+  both direct register-level access and firmware-mediated management
+  via the ACPM (Alive Clock and Power Manager) firmware.
+
+  On these platforms, the hardware is managed in a hybrid fashion. The
+  Application Processor (AP) maintains direct memory-mapped access
+  exclusively to the interrupt pending registers to identify thermal
+  events. All other functional aspects - including sensor
+  initialization, threshold configuration, and temperature acquisition
+  - are handled by the ACPM firmware. The AP coordinates these
+  operations through the ACPM IPC protocol.
+
+properties:
+  compatible:
+    const: google,gs101-tmu-top
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB peripheral clock (PCLK) for TMU register access.
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  samsung,acpm-ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the ACPM IPC node.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - "#thermal-sensor-cells"
+  - samsung,acpm-ipc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/google,gs101.h>
+
+    thermal-sensor@100a0000 {
+        compatible =3D "google,gs101-tmu-top";
+        reg =3D <0x100a0000 0x800>;
+        clocks =3D <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
+        interrupts =3D <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
+        #thermal-sensor-cells =3D <1>;
+        samsung,acpm-ipc =3D <&acpm_ipc>;
+    };
