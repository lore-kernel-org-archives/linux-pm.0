Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503355;
	b=5lLQEZVs8K8SUyiNq39Zl3CFG7pWPKgrx5tv4KEpfvbST7R2yC4c7j81d9Uas2x+LLiE
	 xEeoEGPk48Jv6lenG/L77iV4epZBYeBGfm/+XXxI0tsM4RXkf6S2HrAAWBASZ3BoOpOLf
	 FWokJb3kYket1/momSt4iyDuI1EQFZewBH74SDMYTZ8OCJ8/VOAZNnxZvbz/YcHZAtcRK
	 Czh1+TcAfH9bMbIzL6qVxxNmoJtJ+y0n0ky/kyaI/cFeBE1uPROVh+jUAvEJu8TvOCmXs
	 KUtMf8edmsTMJh4lA/v3InYsXo/myAR1WjvtLfrfaFvvdtQwYsDuoGGFW8Uut+7OfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503355;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pDkrQb08D5M8j1MP1dcWcJZplXdGWPMsv1pB47P3qyg=;
	b=aJvuHa8Mku0Q+A8slZFlGGjNi1cAlZdOjHAwcRQsoJVd3WFSKgDahjxIy3AvtrL7fOWy
	 laqVgKB8RUC81VGb23C+qnz99xZOGvJ0NY4yW2iLaVbDD+YCFiL1ArO16vIeN5JIIyEqs
	 F8pTuKB64gSMBmLMs+emqEOrk/y6+BoTXe87KLhl6l6gaJPHLI1lVbAFqWlqhmwmMdegz
	 +sW+XmQ0kMANcuuI2tqUPz0ooYV6549KUB8xruiUoBffmH5dPoBJMdvuqivzjqJDGJUs4
	 Y6cPfE9gboRa9CNhFAGYS+lXfkjHEKh5em+jHZT5Z1eIp7OtkPEYzDwoP4nuC5LFy/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=l0GZ8dvA;
	arc=none smtp.remote-ip=95.215.58.171
Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B9606A32E
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 17:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9B9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=l0GZ8dvA
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AEUTIZyGb3mCSCpfGc5hg6pIGxMhxghjc7n8dp9pmKU=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794503353; v=1; x=1795108153;
 b=l0GZ8dvA/INoJIxMcEleWaeT2K3Ut8NTJJ4/le6/b6ZXOT08HyAfhGj493iR9A59RnS/jzWO
 Irw1iNb3N7TjjdrpkneMmEy6hblS0bws0HlT0bR8QoAIKZK+0tjjSB87xEEBMQoYb0BKo3Xrkhv
 OBVQfj4+XZjhJLBYkSygo9DNVSYSkxGePKyXmiX0D42CSgB2vUxpB/1GoVYMzeyu00UaLpp52b2
 RJlqqTR3lXO5Q19AuHOsQMS4vArgP+YHqoKrko+1IuMfUCNCGw6RpukF1dB986vh9X3AyIysq9h
 YLGeC8Sk2sOTkP6eSe1Nd+G0sNtWH8c8s2IrUbuJQ3GoQ==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fd5fd19beb92ad4a;
	Thu, 12 Nov 2026 17:09:13 +0000
X-Mizu-Trace-ID: fd5fd19beb92ad4a
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Val Packett <val@packett.cool>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Lainez <marc.lainez@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: power: supply: add Qualcomm QGauge fuel gauge
Date: Thu, 12 Nov 2026 14:07:27 -0300
Message-ID: <20261112170841.2189322-2-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112170841.2189322-1-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Lainez <marc.lainez@gmail.com>

Document the QGauge fuel-gauge block handled by the qcom_qg driver, with
compatibles for the PMI632 and PM6150 PMICs.

Signed-off-by: Marc Lainez <marc.lainez@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
---
 .../bindings/power/supply/qcom,qg.yaml        | 105 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,qg.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,qg.yaml b/Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
new file mode 100644
index 000000000000..79dd18d87879
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,qg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QGauge Fuel Gauge
+
+maintainers:
+  - Val Packett <val@packett.cool>
+
+description:
+  The QGauge (QG) block found in some Qualcomm PMICs (PM6150, PMI632)
+  provides battery fuel gauging through hardware voltage and current
+  FIFO sampling, open circuit voltage (OCV) measurement, and coulomb
+  counting. The hardware has a multi-state FSM (S1-S7) that automatically
+  transitions between active sampling and low-power sleep states.
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+  - $ref: /schemas/nvmem/nvmem-consumer.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm6150-qg
+      - qcom,pmi632-qg
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Battery missing interrupt
+      - description: Battery voltage low interrupt
+      - description: Battery voltage empty interrupt
+      - description: FIFO data update done interrupt
+      - description: Good OCV measured interrupt
+      - description: FSM state change interrupt
+      - description: QG event interrupt
+
+  interrupt-names:
+    items:
+      - const: batt-missing
+      - const: vbat-low
+      - const: vbat-empty
+      - const: fifo-done
+      - const: good-ocv
+      - const: fsm-state-chg
+      - const: event
+
+  io-channels:
+    items:
+      - description: ADC channel for battery thermistor temperature
+
+  io-channel-names:
+    items:
+      - const: batt-therm
+
+  monitored-battery: true
+
+  nvmem: true
+
+  power-supplies: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@4800 {
+        compatible = "qcom,pmi632-qg";
+        reg = <0x4800>;
+
+        interrupts = <0x2 0x48 0x0 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x48 0x1 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x48 0x2 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x48 0x3 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x48 0x4 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x48 0x5 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x48 0x6 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "batt-missing",
+                          "vbat-low",
+                          "vbat-empty",
+                          "fifo-done",
+                          "good-ocv",
+                          "fsm-state-chg",
+                          "event";
+
+        nvmem = <&pmi632_sdam_2>;
+
+        monitored-battery = <&battery>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b253b10dd436..7b76b07ed66f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23328,6 +23328,12 @@ F:	drivers/firmware/qcom/qcom_pas.h
 F:	drivers/firmware/qcom/qcom_pas_tee.c
 F:	include/linux/firmware/qcom/qcom_pas.h
 
+QUALCOMM QGAUGE FUEL GAUGE DRIVER
+M:	Val Packett <val@packett.cool>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/qcom,qg.yaml
+
 QUALCOMM SMB CHARGER DRIVER
 M:	Casey Connolly <casey.connolly@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.56.0

