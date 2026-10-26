Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051110;
	b=kIfUiezHh8OsLSkgN8k6LLFmZ1T2w1+ZYAvHC22cy7RGSKc03ed9+6Kdno3kAz3GSxYt
	 hPMWMUui8Om8fRdDIKdClmvdL8LnmITfunLd7H6yNuFwcA64zFWZ5HmByeiwGNm5XTfF8
	 eyciBwV39CNQ31eo+HHrozlMceztaHLJ29NW+f42DkXxqs6CufYArFbCWhHRVmxP/G7xy
	 dpIPe27dupYlCqVqwjd4dJ/XNyMxBqwmhSyzVllwDptV/ZDZf0PtZUb8rk0wvs0kszE3w
	 cZ53v6jg7AkYnJ3jIgAXyl922zx29qbsvQ7SniFKHr67pHNQuQKPoHHamhakX+J+z9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6W2C5IplodH9p+zbg0ncY61FJ1aii/GuvQjvTf4ZsVE=;
	b=2a/L9Uq3yN8j3LPNPkwpimizYWx5vHYPjoGEbj5bvwl4lwQ+RFPwxwVMaYzpIjk/xuoQ
	 6X0oLWOV5x8y260k067AadxYvZPRVfMUWopiAXdB2Jsuh3qS9fx/Wx4Yt4JJYMllSVRyR
	 enfdKFLHxG22a9yCxXld1dfPnWIgtNeQlG/N5w1c6jli71MZfY9gMTGtycCQ2R1RQBHPG
	 RGG4UjGSTdehuLdnaw39xWaP3riWiOyf6+boNKhnsHjM+Saz1OdMypYOQeD6TbJ0RKokg
	 aJMoiBSsbM05Be05eCN0fSTBfqjtj0QWS9yF2FbbKTHCf0Ou9j+7+e2hzq7XIVjzBLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lbviEIMM;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A560A260D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 735A560A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lbviEIMM
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35f036b17easo9422800eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051109; x=1793655909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6W2C5IplodH9p+zbg0ncY61FJ1aii/GuvQjvTf4ZsVE=;
        b=lbviEIMMtwlSR27hH1gLuiEww03/6gUnquti3tjtSHbHIvz/450DkqVwxQFBN0bxNo
         CKs7PmgcCx4ycdYMaw3/6TfDx8HdrZfFbKNOgM/GSkL6aQeDuXJfCi6UeX3V9Zy+IUZ0
         fFOwnv4G7YBMlnwXjC5qBScX1E9WL2hFsLLhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051109; x=1793655909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6W2C5IplodH9p+zbg0ncY61FJ1aii/GuvQjvTf4ZsVE=;
        b=xR/soj1dDC5SmwwcERR3T6Wo+3mLytcExI/Ne9EIh9ZHUfVGzig5hsYCj9PMKG7oIP
         G0nRNYPQFyzpTC9vglWN6b66IlnHgcmppdnH6gyapLxd6egjfM4RO94iJPaP4QA9O326
         roTUNKSJVyu3+Dv0BJcxFDVe4o4U+f5Eafr1L2aqAJX4/Lcx7MFZoRCXLqCAK1Sd3mvj
         iVdgzpMACGn53/RJIDczvK6Z//Pdh+cEXOz3u0tm4BCSeWjzjZUEY6wiKuIdD03ANO2t
         xA587Hl8XEv/4hPThyjL6I9rXDUplpdF77rp343qUO4Ofgv43wMeYoQEfosttY70Ps/n
         Hv+A==
X-Forwarded-Encrypted: i=1; AKwUvByI2m6DtDaTqc33ZvdEBFVAEAdMTy2x5FFgwS4vkmKeHhsRk63TC5o+oGLHI+86Tk8i7LAJQv18IA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKHKRgeKf043uG+ynPZnTrcHsR0ve50q4L7FGMiF3ZQTXBQWhQ/
	YLLQqUj05qc3UrfWa3P48uB48usiDR2eXcuoHkzN29RQwDl2dwrD72Gjg2cjpE7zug==
X-Gm-Gg: AYBFou1hjKi8nw/wYeegbjjFaqNqTti+tXivXb/gHRMEcwGL3k88kjTuNMwa1plTROh
	MGTXDLm0jEjXFElWTRy8h84FqFaUgA7I+Vpcl1vg6vM70oEP1E3DGrHRy5n6GuvhWFcvzwWGV7N
	f+nlBvbMMzAkhVQVE1392p7M4yWPqJO5CQTAOlB7CHBKgNZ+00eoyP8SV87G0TTGZLn8PizDdC0
	vsRbHL0eXTf5N9/mR0k29HK4s/x+upx9kngXmBtasrtZYDlKQYqJ2jDb8f99acORShV3d+EqDld
	OxS16JQudo7Z3HXXZyEVMGMWLB7YQyVDxKAHLSII7suQY6HECbWjjYuFy8nAfgoJZz4DRNxtUqc
	ro8+rnoKu5pj+YXTwtdbFkFU8wjWRJKSWgv2TmpHd5Rnw/3x7zj05IU5ZER9XGYQEw9LxpOgSUQ
	S21/uwVGA4k0qyGYaEYgMwHj4smr05oP1qBBxPFULPRTyWcGCRuS+xuqEgYE1MhyxAWJRQN2D0j
	NdJDdTc/qCVlvrhWck89r95wI5rIU05O/kMDr/K0o0p19tuzyK2q8SQSy6EPJgqhZelds5lIDRh
	e/sEewu9JD6zzKH8L94=
X-Received: by 2002:a05:693c:87dc:20b0:350:2a5c:56c with SMTP id 5a478bee46e88-369e84b1873mr12192158eec.20.1793051108206;
        Mon, 26 Oct 2026 14:45:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36a026e04a0sm9389605eec.1.2026.10.26.14.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:07 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/9] dt-bindings: soc: google: Add Google Tensor CPM binding
Date: Mon, 26 Oct 2026 14:43:40 -0700
Message-ID: <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
References: <20261026214359.3122870-1-briannorris@chromium.org>
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

The Central Power Manager (CPM) is a co-processor on the Google Tensor
SoCs, as used on Pixel phones. CPM supports power-management and a
number of other features.

The Application Processor communicates with CPM over a pair of mailbox
channels. CPM provides clock, power-domain, reset, and interrupt
services.

Notably, CPM manages other services that are not yet included in this
binding -- some attached PMICs, an RTC, and more. For simplicity, we
don't try to describe and support all features all at once.

Because it may be useful both for reviewers familiar with the downstream
Linux support for these devices, or for future developers looking at
adapting/improving/adding further features later on, it's worth noting
some major deviations from downstream bindings:

 * CPM does not sit on the soc bus, and does not have any IO/reg region
   of its own. The downstream bindings included some not-quite-related
   hardware resources in the same "device", to aid doing some similar
   things in the same driver. For instance, some power domains
   (specifically, the GPU) are not managed by CPM, and instead are left
   for direct-register-access. Such a domain should be described
   separately, and not within the CPM node.

 * Downstream bindings tended to describe every CPM-using service as its
   own node, with a (fake) mailbox-phandle back to the CPM node. We try
   as much as possible here to avoid separate nodes if we can help it.
   And see the next point:

 * Downstream bindings tended to describe every individual clock, reset,
   and power-domain as their own sub-node, with various
   software-describing properties as part of each node. These properties
   are inherent to the SoC, however, so we avoid sub-nodes and instead
   just provide appropriate #{clock,power-domain,reset}-cells, and leave
   the per-{power-domain,clock} properties to the driver.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 .../bindings/soc/google/google,lga-cpm.yaml   |  74 +++++++
 include/dt-bindings/clock/google,lga-cpm.h    | 191 ++++++++++++++++++
 .../interrupt-controller/irq-cpm-google.h     |  16 ++
 include/dt-bindings/power/google,lga-cpm.h    |  79 ++++++++
 .../dt-bindings/reset/google,lga-cpm-reset.h  | 175 ++++++++++++++++
 include/dt-bindings/soc/google,lga-lpcm.h     |  54 +++++
 6 files changed, 589 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml
 create mode 100644 include/dt-bindings/clock/google,lga-cpm.h
 create mode 100644 include/dt-bindings/interrupt-controller/irq-cpm-google.h
 create mode 100644 include/dt-bindings/power/google,lga-cpm.h
 create mode 100644 include/dt-bindings/reset/google,lga-cpm-reset.h
 create mode 100644 include/dt-bindings/soc/google,lga-lpcm.h

diff --git a/Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml b/Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml
new file mode 100644
index 000000000000..546e6c7fff80
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,lga-cpm.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,lga-cpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Central Power Manager (CPM)
+
+maintainers:
+  - Brian Norris <briannorris@chromium.org>
+
+description: |
+  The Central Power Manager (CPM) is an on-chip power management subsystem
+  found on Google Tensor SoCs. It has a variety of responsibilities, from DVFS
+  and power management to resets, PMIC control, and even RTC management. The
+  Application Processor communicates with CPM over a set of mailbox channels.
+
+properties:
+  compatible:
+    const: google,lga-cpm
+
+  mboxes:
+    items:
+      - description: TX mailbox channel for sending requests to CPM
+      - description: RX mailbox channel for receiving responses from CPM
+
+  '#power-domain-cells':
+    const: 1
+    description: See <dt-bindings/power/google,lga-cpm.h> for power domain IDs.
+
+  '#reset-cells':
+    const: 2
+    description:
+      Each reset is specified by an LPCM ID (cell 1) and a reset ID (cell 2).
+      See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
+      <dt-bindings/reset/google,lga-cpm-reset.h> for reset IDs.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+    description:
+      Interrupt identifiers are assigned by CPM firmware. See
+      <dt-bindings/interrupt-controller/irq-cpm-google.h> for interrupt IDs.
+
+  '#clock-cells':
+    const: 2
+    description:
+      Each clock is specified by an LPCM ID (cell 1) and a clock ID (cell
+      2). See <dt-bindings/soc/google,lga-lpcm.h> for LPCM IDs and
+      <dt-bindings/clock/google,lga-cpm.h> for clock IDs.
+
+required:
+  - compatible
+  - mboxes
+  - '#clock-cells'
+  - '#power-domain-cells'
+  - '#reset-cells'
+  - '#interrupt-cells'
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    cpm: cpm {
+        compatible = "google,lga-cpm";
+        mboxes = <&cpm_ap_ns_req_mba>, <&cpm_ap_ns_resp_mba>;
+        #clock-cells = <2>;
+        #power-domain-cells = <1>;
+        #reset-cells = <2>;
+        #interrupt-cells = <1>;
+        interrupt-controller;
+    };
diff --git a/include/dt-bindings/clock/google,lga-cpm.h b/include/dt-bindings/clock/google,lga-cpm.h
new file mode 100644
index 000000000000..6d5a5567226d
--- /dev/null
+++ b/include/dt-bindings/clock/google,lga-cpm.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H
+#define __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H
+
+/*
+ * LPCM clock ID's of each SSWRPs
+ */
+
+#define LSIOS_GPIO_CLK			0
+#define LSIOS_MCLK0_CLK			1
+#define LSIOS_PWM_CLK			2
+#define LSIOS_PWM_CFG_CLK		3
+#define LSIOS_CLI0_CFG_CLK		4
+#define LSIOS_CLI1_CFG_CLK		5
+#define LSIOS_CLI2_CFG_CLK		6
+#define LSIOS_CLI3_CFG_CLK		7
+#define LSIOS_CLI4_CFG_CLK		8
+#define LSIOS_CLI5_CFG_CLK		9
+#define LSIOS_CLI6_CFG_CLK		10
+#define LSIOS_CLI0_SPI_CLK		11
+#define LSIOS_CLI1_SPI_CLK		12
+#define LSIOS_CLI2_SPI_CLK		13
+#define LSIOS_CLI3_SPI_CLK		14
+#define LSIOS_CLI4_SPI_CLK		15
+#define LSIOS_CLI5_SPI_CLK		16
+#define LSIOS_CLI6_SPI_CLK		17
+#define LSIOS_CLI0_I2C_CLK		18
+#define LSIOS_CLI1_I2C_CLK		19
+#define LSIOS_CLI2_I2C_CLK		20
+#define LSIOS_CLI3_I2C_CLK		21
+#define LSIOS_CLI4_I2C_CLK		22
+#define LSIOS_CLI5_I2C_CLK		23
+#define LSIOS_CLI6_I2C_CLK		24
+#define LSIOS_CLI0_UART_CLK		25
+#define LSIOS_CLI1_UART_CLK		26
+#define LSIOS_CLI2_UART_CLK		27
+#define LSIOS_CLI3_UART_CLK		28
+#define LSIOS_CLI4_UART_CLK		29
+#define LSIOS_CLI5_UART_CLK		30
+#define LSIOS_CLI6_UART_CLK		31
+#define LSIOS_CLI0_I3C_CLK		32
+#define LSIOS_CLI1_I3C_CLK		33
+#define LSIOS_CLI2_I3C_CLK		34
+#define LSIOS_CLI3_I3C_CLK		35
+#define LSIOS_CLI4_I3C_CLK		36
+#define LSIOS_CLI5_I3C_CLK		37
+#define LSIOS_CLI6_I3C_CLK		38
+#define LSIOS_MCLK1_CLK			39
+#define LSIOS_MCLK2_CLK			40
+#define LSIOS_MCLK3_CLK			41
+#define LSIOS_MCLK4_CLK			42
+#define LSIOS_MCLK5_CLK			43
+#define LSIOS_MCLK6_CLK			44
+#define LSIOS_MCLK7_CLK			45
+
+#define LSION_GPIO_CLK			0
+#define LSION_CLI_INT0_I2C_CLK		1
+#define LSION_CLI_INT0_I3C_CLK		2
+#define LSION_CLI_INT0_UART_CLK		3
+#define LSION_CLI_INT0_SPI_CLK		4
+#define LSION_CLI_INT0_CFG_CLK		5
+#define LSION_CLI_INT1_I2C_CLK		6
+#define LSION_CLI_INT1_I3C_CLK		7
+#define LSION_CLI_INT1_UART_CLK		8
+#define LSION_CLI_INT1_SPI_CLK		9
+#define LSION_CLI_INT1_CFG_CLK		10
+#define LSION_CLI_INT2_I2C_CLK		11
+#define LSION_CLI_INT2_I3C_CLK		12
+#define LSION_CLI_INT2_UART_CLK		13
+#define LSION_CLI_INT2_SPI_CLK		14
+#define LSION_CLI_INT2_CFG_CLK		15
+#define LSION_CLI_INT3_I2C_CLK		16
+#define LSION_CLI_INT3_I3C_CLK		17
+#define LSION_CLI_INT3_UART_CLK		18
+#define LSION_CLI_INT3_SPI_CLK		19
+#define LSION_CLI_INT3_CFG_CLK		20
+#define LSION_CLI_INT4_I2C_CLK		21
+#define LSION_CLI_INT4_I3C_CLK		22
+#define LSION_CLI_INT4_UART_CLK		23
+#define LSION_CLI_INT4_SPI_CLK		24
+#define LSION_CLI_INT4_CFG_CLK		25
+#define LSION_CLI15_CFG_CLK		26
+#define LSION_CLI16_CFG_CLK		27
+#define LSION_CLI15_I2C_CLK		28
+#define LSION_CLI16_I2C_CLK		29
+#define LSION_CLI15_SPI_CLK		30
+#define LSION_CLI16_SPI_CLK		31
+#define LSION_CLI15_UART_CLK		32
+#define LSION_CLI16_UART_CLK		33
+#define LSION_CLI15_I3C_CLK		34
+#define LSION_CLI16_I3C_CLK		35
+
+#define LSIOE_GPIO_CLK			0
+#define LSIOE_CLI7_CFG_CLK		1
+#define LSIOE_CLI8_CFG_CLK		2
+#define LSIOE_CLI9_CFG_CLK		3
+#define LSIOE_CLI10_CFG_CLK		4
+#define LSIOE_CLI11_CFG_CLK		5
+#define LSIOE_CLI12_CFG_CLK		6
+#define LSIOE_CLI13_CFG_CLK		7
+#define LSIOE_CLI14_CFG_CLK		8
+#define LSIOE_CLI7_SPI_CLK		9
+#define LSIOE_CLI8_SPI_CLK		10
+#define LSIOE_CLI9_SPI_CLK		11
+#define LSIOE_CLI10_SPI_CLK		12
+#define LSIOE_CLI11_SPI_CLK		13
+#define LSIOE_CLI12_SPI_CLK		14
+#define LSIOE_CLI13_SPI_CLK		15
+#define LSIOE_CLI14_SPI_CLK		16
+#define LSIOE_CLI7_I2C_CLK		17
+#define LSIOE_CLI8_I2C_CLK		18
+#define LSIOE_CLI9_I2C_CLK		19
+#define LSIOE_CLI10_I2C_CLK		20
+#define LSIOE_CLI11_I2C_CLK		21
+#define LSIOE_CLI12_I2C_CLK		22
+#define LSIOE_CLI13_I2C_CLK		23
+#define LSIOE_CLI14_I2C_CLK		24
+#define LSIOE_CLI7_UART_CLK		25
+#define LSIOE_CLI8_UART_CLK		26
+#define LSIOE_CLI9_UART_CLK		27
+#define LSIOE_CLI10_UART_CLK		28
+#define LSIOE_CLI11_UART_CLK		29
+#define LSIOE_CLI12_UART_CLK		30
+#define LSIOE_CLI13_UART_CLK		31
+#define LSIOE_CLI14_UART_CLK		32
+#define LSIOE_SPMI_CLK			33
+#define LSIOE_CLI7_I3C_CLK		34
+#define LSIOE_CLI8_I3C_CLK		35
+#define LSIOE_CLI9_I3C_CLK		36
+#define LSIOE_CLI10_I3C_CLK		37
+#define LSIOE_CLI11_I3C_CLK		38
+#define LSIOE_CLI12_I3C_CLK		39
+#define LSIOE_CLI13_I3C_CLK		40
+#define LSIOE_CLI14_I3C_CLK		41
+
+#define HSIOS_MPHY_REF_OSC_CLK		0
+#define HSIOS_MPHY_REF_TCX0_CLK		1
+#define HSIOS_GPIO_REF_OSC_CLK		2
+#define HSIOS_GPIO_REF_TCX0_CLK		3
+#define HSIOS_HCLK_CLK			4
+#define HSIOS_SYS_CLK			5
+#define HSIOS_T_CLK			6
+#define HSIOS_LP_T_CLK			7
+#define HSIOS_MPHY_CFG_CLK		8
+#define HSIOS_UFS_CFG_CLK		9
+#define HSIOS_PHY_FW_CLK		10
+#define HSIOS_PCIE_REF_CLK		11
+#define HSIOS_UFS_RESET_CLK		12
+#define HSIOS_UFS_LP_RESET_CLK		13
+#define HSIOS_UFS_ARESET_CLK		14
+#define HSIOS_UFS_PHY_RESET_CLK		15
+#define HSIOS_AUX_CLK			16
+
+#define HSION_USB_CLK			0
+#define HSION_DP0_CLK			1
+#define HSION_DP1_CLK			2
+#define HSION_PHY_FW_CLK		3
+#define HSION_PCIE_REF_CLK		4
+#define HSION_U2PHY_REF_CLK		5
+#define HSION_USBDP_SUSPEND_CLK		6
+#define HSION_USBC_NON_STICKY_CLK	7
+#define HSION_USBC_STICKY_CLK		8
+#define HSION_USB_DRD_BUS_CLK		9
+#define HSION_CSR_CLK			10
+#define HSION_USB_TOP_CSR_CLK		11
+#define HSION_DP_PCLK_CLK		12
+#define HSION_DP_CFG_CLK		13
+#define HSION_U2PHY_APB_CLK		14
+#define HSION_DP_VCC_CLK		15
+#define HSION_U3PHY_REF_CLK		16
+#define HSION_USB2_PHY_RESET_CLK	17
+#define HSION_USB3DP_PHY_RESET_CLK	18
+#define HSION_EBU_CLK			19
+
+#define DPU_DP0_PIX_CLK			0
+#define DPU_DP1_PIX_CLK			1
+#define DPU_DSI0_PIX_CLK		2
+#define DPU_DSI1_PIX_CLK		3
+#define DPU_DSI1_PHY_CLK		4
+#define DPU_FE0_CLK			5
+#define DPU_FE1_CLK			6
+#define DPU_BE_CLK			7
+#define DPU_AON_CLK			8
+
+#define GPCM_DPU_PLL_DP_CLK		0
+#define GPCM_HSION_PLL_DP_CLK		1
+
+#define CPU_SSWRP_TSS_CLK		1
+
+#endif /* __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H */
diff --git a/include/dt-bindings/interrupt-controller/irq-cpm-google.h b/include/dt-bindings/interrupt-controller/irq-cpm-google.h
new file mode 100644
index 000000000000..26d83bfe39af
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irq-cpm-google.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for CPM IRQ.
+ *
+ * Copyright 2025-2026 Google LLC
+ *
+ */
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H
+
+#define CPM_IRQ_RTC_ALARM_NO			0
+#define CPM_IRQ_AOC_MIN				7
+#define CPM_IRQ_AOC_MAX				156
+#define CPM_IRQ_AP_GDMC_WAKE			157
+
+#endif  /* _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_CPM_H */
diff --git a/include/dt-bindings/power/google,lga-cpm.h b/include/dt-bindings/power/google,lga-cpm.h
new file mode 100644
index 000000000000..4b35c59df2cc
--- /dev/null
+++ b/include/dt-bindings/power/google,lga-cpm.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H
+#define __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H
+
+/* AOC */
+#define LGA_PD_SSWRP_AOC		0
+#define LGA_PD_AOC_CORE			1
+
+/* AURORA */
+#define LGA_PD_SSWRP_AURORA		2
+
+/* CODEC_3P */
+#define LGA_PD_SSWRP_CODEC_3P		3
+
+/* DPU */
+#define LGA_PD_DPU_DP			4
+#define LGA_PD_SSWRP_DPU		5
+#define LGA_PD_DPU_FE0			6
+#define LGA_PD_DPU_FE1			7
+#define LGA_PD_DPU_DSI0			8
+#define LGA_PD_DPU_DSI1			9
+
+/* EH */
+#define LGA_PD_SSWRP_EH			10
+
+/* G2D */
+#define LGA_PD_SSWRP_G2D		11
+#define LGA_PD_G2D_CORE			12
+
+/* GPDMA */
+#define LGA_PD_SSWRP_GPDMA		13
+
+/* GPU */
+#define LGA_PD_SSWRP_GPU		14
+
+/* GSW */
+#define LGA_PD_SSWRP_GSW		15
+
+/* HSIO_N */
+#define LGA_PD_SSWRP_HSIO_N		16
+#define LGA_PD_HSIO_N_USB		17
+#define LGA_PD_HSIO_N_USB_PSW		18
+#define LGA_PD_HSIO_N_PCIE		19
+#define LGA_PD_HSIO_N_DP		20
+#define LGA_PD_HSIO_N_EBU		21
+#define LGA_PD_HSIO_N_EBU_CORE		22
+
+/* HSIO_S */
+#define LGA_PD_SSWRP_HSIO_S		23
+#define LGA_PD_HSIO_S_UFS_PREP		24
+#define LGA_PD_HSIO_S_UFS		25
+#define LGA_PD_HSIO_S_PCIE		26
+#define LGA_PD_HSIO_S_SD		27
+
+/* ISPBE */
+#define LGA_PD_SSWRP_ISPBE		28
+
+/* ISPFE */
+#define LGA_PD_SSWRP_ISPFE		29
+#define LGA_PD_ISPFE_PIPE		30
+#define LGA_PD_ISPFE_CSIS		31
+
+/* LSIO_E */
+#define LGA_PD_SSWRP_LSIO_E		32
+#define LGA_PD_LSIO_E_CLI_GPIO		33
+
+/* LSIO_N */
+#define LGA_PD_SSWRP_LSIO_N		34
+#define LGA_PD_LSIO_N_CLI_GPIO		35
+
+/* LSIO_S */
+#define LGA_PD_SSWRP_LSIO_S		36
+#define LGA_PD_LSIO_S_CLI_GPIO		37
+
+/* TPU */
+#define LGA_PD_SSWRP_TPU		38
+
+#endif /* __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H */
diff --git a/include/dt-bindings/reset/google,lga-cpm-reset.h b/include/dt-bindings/reset/google,lga-cpm-reset.h
new file mode 100644
index 000000000000..d147296dbffc
--- /dev/null
+++ b/include/dt-bindings/reset/google,lga-cpm-reset.h
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_RESET_GOOGLE_LGA_CPM_RESET_H
+#define __DT_BINDINGS_RESET_GOOGLE_LGA_CPM_RESET_H
+
+/* HSION */
+#define HSION_PCIE_PERST_RST			0
+#define HSION_PCIE_APP_HOLD_PHY_RST		1
+#define HSION_PCIE_INIT_RST			2
+#define HSION_PCIE_PWR_UP_RST			3
+#define HSION_USB_DP_CFG_RST			4
+#define HSION_DP_PCLK_RST			5
+#define HSION_USB_TOP_CSR_RST			6
+#define HSION_PIXEL_CK0_RST			7
+#define HSION_PIXEL_CK1_RST			8
+#define HSION_U2PHY_APB_RST			9
+#define HSION_USBC_NON_STICKY_RST		10
+#define HSION_USBC_STICKY_RST			11
+#define HSION_USB_DRD_BUS_RST			12
+#define HSION_USB2_PHY_RESET			13
+#define HSION_USB3DP_PHY_RESET			14
+#define HSION_EBU_RST				15
+
+/* HSIOS */
+#define HSIOS_PCIE_PERST_RST			0
+#define HSIOS_PCIE_APP_HOLD_PHY_RST		1
+#define HSIOS_PCIE_PWR_UP_RST			2
+#define HSIOS_UFS_PHY_RST			3
+#define HSIOS_PCIE_INIT_RST			4
+
+/* LSIOS */
+#define LSIOS_CLI0_I2C_IC_CFG_RST		0
+#define LSIOS_CLI0_I3C_IC_CFG_RST		1
+#define LSIOS_CLI0_UART_IC_CFG_RST		2
+#define LSIOS_CLI0_SPI_IC_CFG_RST		3
+#define LSIOS_CLI1_I2C_IC_CFG_RST		4
+#define LSIOS_CLI1_I3C_IC_CFG_RST		5
+#define LSIOS_CLI1_UART_IC_CFG_RST		6
+#define LSIOS_CLI1_SPI_IC_CFG_RST		7
+#define LSIOS_CLI2_I2C_IC_CFG_RST		8
+#define LSIOS_CLI2_I3C_IC_CFG_RST		9
+#define LSIOS_CLI2_UART_IC_CFG_RST		10
+#define LSIOS_CLI2_SPI_IC_CFG_RST		11
+#define LSIOS_CLI3_I2C_IC_CFG_RST		12
+#define LSIOS_CLI3_I3C_IC_CFG_RST		13
+#define LSIOS_CLI3_UART_IC_CFG_RST		14
+#define LSIOS_CLI3_SPI_IC_CFG_RST		15
+#define LSIOS_CLI4_I2C_IC_CFG_RST		16
+#define LSIOS_CLI4_I3C_IC_CFG_RST		17
+#define LSIOS_CLI4_UART_IC_CFG_RST		18
+#define LSIOS_CLI4_SPI_IC_CFG_RST		19
+#define LSIOS_CLI5_I2C_IC_CFG_RST		20
+#define LSIOS_CLI5_I3C_IC_CFG_RST		21
+#define LSIOS_CLI5_UART_IC_CFG_RST		22
+#define LSIOS_CLI5_SPI_IC_CFG_RST		23
+#define LSIOS_CLI6_I2C_IC_CFG_RST		24
+#define LSIOS_CLI6_I3C_IC_CFG_RST		25
+#define LSIOS_CLI6_UART_IC_CFG_RST		26
+#define LSIOS_CLI6_SPI_IC_CFG_RST		27
+#define LSIOS_CLI0_SPI_IC_RST			28
+#define LSIOS_CLI1_SPI_IC_RST			29
+#define LSIOS_CLI2_SPI_IC_RST			30
+#define LSIOS_CLI3_SPI_IC_RST			31
+#define LSIOS_CLI4_SPI_IC_RST			32
+#define LSIOS_CLI5_SPI_IC_RST			33
+#define LSIOS_CLI6_SPI_IC_RST			34
+#define LSIOS_CLI0_SPI_CFG_RST			35
+#define LSIOS_CLI1_SPI_CFG_RST			36
+#define LSIOS_CLI2_SPI_CFG_RST			37
+#define LSIOS_CLI3_SPI_CFG_RST			38
+#define LSIOS_CLI4_SPI_CFG_RST			39
+#define LSIOS_CLI5_SPI_CFG_RST			40
+#define LSIOS_CLI6_SPI_CFG_RST			41
+#define LSIOS_PWM_IC_RST			42
+#define LSIOS_PWM_CFG_RST			43
+#define LSIOS_GPIO_IC_RST			44
+
+/* LSION */
+#define LSION_CLI15_I2C_IC_CFG_RST		0
+#define LSION_CLI15_I3C_IC_CFG_RST		1
+#define LSION_CLI15_UART_IC_CFG_RST		2
+#define LSION_CLI15_SPI_IC_CFG_RST		3
+#define LSION_CLI16_I2C_IC_CFG_RST		4
+#define LSION_CLI16_I3C_IC_CFG_RST		5
+#define LSION_CLI16_UART_IC_CFG_RST		6
+#define LSION_CLI16_SPI_IC_CFG_RST		7
+#define LSION_CLI17_INT0_I2C_IC_CFG_RST		8
+#define LSION_CLI17_INT0_I3C_IC_CFG_RST		9
+#define LSION_CLI17_INT0_UART_IC_CFG_RST	10
+#define LSION_CLI17_INT0_SPI_IC_CFG_RST		11
+#define LSION_CLI18_INT1_I2C_IC_CFG_RST		12
+#define LSION_CLI18_INT1_I3C_IC_CFG_RST		13
+#define LSION_CLI18_INT1_UART_IC_CFG_RST	14
+#define LSION_CLI18_INT1_SPI_IC_CFG_RST		15
+#define LSION_CLI19_INT2_I2C_IC_CFG_RST		16
+#define LSION_CLI19_INT2_I3C_IC_CFG_RST		17
+#define LSION_CLI19_INT2_UART_IC_CFG_RST	18
+#define LSION_CLI19_INT2_SPI_IC_CFG_RST		19
+#define LSION_CLI20_INT3_I2C_IC_CFG_RST		20
+#define LSION_CLI20_INT3_I3C_IC_CFG_RST		21
+#define LSION_CLI20_INT3_UART_IC_CFG_RST	22
+#define LSION_CLI20_INT3_SPI_IC_CFG_RST		23
+#define LSION_CLI21_INT4_I2C_IC_CFG_RST		24
+#define LSION_CLI21_INT4_I3C_IC_CFG_RST		25
+#define LSION_CLI21_INT4_UART_IC_CFG_RST	26
+#define LSION_CLI21_INT4_SPI_IC_CFG_RST		27
+#define LSION_CLI15_SPI_IC_RST			28
+#define LSION_CLI16_SPI_IC_RST			29
+#define LSION_CLI17_INT0_SPI_IC_RST		30
+#define LSION_CLI18_INT1_SPI_IC_RST		31
+#define LSION_CLI19_INT2_SPI_IC_RST		32
+#define LSION_CLI20_INT3_SPI_IC_RST		33
+#define LSION_CLI21_INT4_SPI_IC_RST		34
+#define LSION_CLI15_SPI_CFG_RST			35
+#define LSION_CLI16_SPI_CFG_RST			36
+#define LSION_CLI17_INT0_SPI_CFG_RST		37
+#define LSION_CLI18_INT1_SPI_CFG_RST		38
+#define LSION_CLI19_INT2_SPI_CFG_RST		39
+#define LSION_CLI20_INT3_SPI_CFG_RST		40
+#define LSION_CLI21_INT4_SPI_CFG_RST		41
+#define LSION_GPIO_IC_RST			42
+
+/* LSIOE */
+#define LSIOE_CLI7_I2C_IC_CFG_RST		0
+#define LSIOE_CLI7_I3C_IC_CFG_RST		1
+#define LSIOE_CLI7_UART_IC_CFG_RST		2
+#define LSIOE_CLI7_SPI_IC_CFG_RST		3
+#define LSIOE_CLI8_I2C_IC_CFG_RST		4
+#define LSIOE_CLI8_I3C_IC_CFG_RST		5
+#define LSIOE_CLI8_UART_IC_CFG_RST		6
+#define LSIOE_CLI8_SPI_IC_CFG_RST		7
+#define LSIOE_CLI9_I2C_IC_CFG_RST		8
+#define LSIOE_CLI9_I3C_IC_CFG_RST		9
+#define LSIOE_CLI9_UART_IC_CFG_RST		10
+#define LSIOE_CLI9_SPI_IC_CFG_RST		11
+#define LSIOE_CLI10_I2C_IC_CFG_RST		12
+#define LSIOE_CLI10_I3C_IC_CFG_RST		13
+#define LSIOE_CLI10_UART_IC_CFG_RST		14
+#define LSIOE_CLI10_SPI_IC_CFG_RST		15
+#define LSIOE_CLI11_I2C_IC_CFG_RST		16
+#define LSIOE_CLI11_I3C_IC_CFG_RST		17
+#define LSIOE_CLI11_UART_IC_CFG_RST		18
+#define LSIOE_CLI11_SPI_IC_CFG_RST		19
+#define LSIOE_CLI12_I2C_IC_CFG_RST		20
+#define LSIOE_CLI12_I3C_IC_CFG_RST		21
+#define LSIOE_CLI12_UART_IC_CFG_RST		22
+#define LSIOE_CLI12_SPI_IC_CFG_RST		23
+#define LSIOE_CLI13_I2C_IC_CFG_RST		24
+#define LSIOE_CLI13_I3C_IC_CFG_RST		25
+#define LSIOE_CLI13_UART_IC_CFG_RST		26
+#define LSIOE_CLI13_SPI_IC_CFG_RST		27
+#define LSIOE_CLI14_I2C_IC_CFG_RST		28
+#define LSIOE_CLI14_I3C_IC_CFG_RST		29
+#define LSIOE_CLI14_UART_IC_CFG_RST		30
+#define LSIOE_CLI14_SPI_IC_CFG_RST		31
+#define LSIOE_CLI7_SPI_IC_RST			32
+#define LSIOE_CLI8_SPI_IC_RST			33
+#define LSIOE_CLI9_SPI_IC_RST			34
+#define LSIOE_CLI10_SPI_IC_RST			35
+#define LSIOE_CLI11_SPI_IC_RST			36
+#define LSIOE_CLI12_SPI_IC_RST			37
+#define LSIOE_CLI13_SPI_IC_RST			38
+#define LSIOE_CLI14_SPI_IC_RST			39
+#define LSIOE_CLI7_SPI_CFG_RST			40
+#define LSIOE_CLI8_SPI_CFG_RST			41
+#define LSIOE_CLI9_SPI_CFG_RST			42
+#define LSIOE_CLI10_SPI_CFG_RST			43
+#define LSIOE_CLI11_SPI_CFG_RST			44
+#define LSIOE_CLI12_SPI_CFG_RST			45
+#define LSIOE_CLI13_SPI_CFG_RST			46
+#define LSIOE_CLI14_SPI_CFG_RST			47
+#define LSIOE_GPIO_IC_RST			48
+#define LSIOE_SPMI_RST				49
+
+#endif /* __DT_BINDINGS_RESET_GOOGLE_LGA_CPM_RESET_H */
diff --git a/include/dt-bindings/soc/google,lga-lpcm.h b/include/dt-bindings/soc/google,lga-lpcm.h
new file mode 100644
index 000000000000..d1944afff2b9
--- /dev/null
+++ b/include/dt-bindings/soc/google,lga-lpcm.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
+#define __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H
+
+/*
+ * LPCM IDs of each SSWRP.
+ */
+#define LGA_LPCM_CPM			0
+#define LGA_LPCM_AOC			1
+#define LGA_LPCM_LSIO_E			2
+#define LGA_LPCM_LSIO_N			3
+#define LGA_LPCM_LSIO_S			4
+#define LGA_LPCM_HSIO_N			5
+#define LGA_LPCM_HSIO_S			6
+#define LGA_LPCM_GPCA			7
+#define LGA_LPCM_FABHBW			8
+#define LGA_LPCM_MEMSS			9
+#define LGA_LPCM_FABMED			10
+#define LGA_LPCM_FABRT			11
+#define LGA_LPCM_FABSTBY		12
+#define LGA_LPCM_FABSYSS		13
+#define LGA_LPCM_CPU			14
+#define LGA_LPCM_CPU_MAIN		15
+#define LGA_LPCM_CPU_CCM0		16
+#define LGA_LPCM_CPU_CCM1A		17
+#define LGA_LPCM_CPU_CCM1B		18
+#define LGA_LPCM_CPU_CCM2		19
+#define LGA_LPCM_EH			20
+#define LGA_LPCM_AURORA			21
+#define LGA_LPCM_CODEC_3P		22
+#define LGA_LPCM_G2D			23
+#define LGA_LPCM_GSW			24
+#define LGA_LPCM_ISPBE			25
+#define LGA_LPCM_ISPFE			26
+#define LGA_LPCM_INF_TCU		27
+#define LGA_LPCM_GPU			28
+#define LGA_LPCM_GPU_REMOTE_FLL		29
+#define LGA_LPCM_GPU_REMOTE_SENSOR	30
+#define LGA_LPCM_TPU			31
+#define LGA_LPCM_TPU_REMOTE		32
+#define LGA_LPCM_BMSM			33
+#define LGA_LPCM_CPUACC			34
+#define LGA_LPCM_DPU			35
+#define LGA_LPCM_GDMC			36
+#define LGA_LPCM_GMC0			37
+#define LGA_LPCM_GMC1			38
+#define LGA_LPCM_GMC2			39
+#define LGA_LPCM_GMC3			40
+#define LGA_LPCM_GPCM			41
+#define LGA_LPCM_GPDMA			42
+#define LGA_LPCM_GSA			43
+
+#endif /* __DT_BINDINGS_SOC_GOOGLE_LGA_LPCM_H */
-- 
2.56.0.307.g5fe7bd680c-goog

