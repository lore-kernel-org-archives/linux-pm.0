Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565186;
	b=nbtYWTRuK+VPSh1R/zRJpMs8m8w2nJPW7nrBtuTjiGH9WNlz/QJaFROeBXnnWCiklP4b
	 DZhev2Fag0KRnWQLSZxQ6sBXXDNPBrXngOL05/8a8v95k0iJg8pSlhaM34k+UFJVyeSYl
	 owrRW4soHfyltSAOzJ6NmYTvWrYeb153ySEsa2UvrTJx4DU641wDT8TYj/Ee7ZiRjdM+9
	 hZ2XE7zRzkym+/LiNXQrEVk0FUvW+c7wz6CgiZHwHhmYZ8lL+Hfb9kHdwvYgUJfIzahVR
	 VKXtkAyL+wjLUeDNC42pNu1m9D22xbVauBK1ZVKEF47Ad7XRp7weLv527tmUGXzZjmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CK2W4+wUnESJRPQMuOkNCLCi5VCZ9oTd0r3qBFZs0Ls=;
	b=q80k7srswvTPRPkGB+IYNotUfiB+3ewbQi3O2cF/MoWz2Nvs25RW2atmZa7xmBsGrNjK
	 ICEfSw3ILioGslqH158GHJZLQY5jbg8/XRQGhn0e/KLAcZILVpQMSoz6ncRCLKmxvbWDM
	 YL5a2zjJGIyGwvr/6XuirtJU/jay4shQOPTq+WOZXNa2tSVpah7ym2z2qL6rDDWEEGg70
	 CtDMog4eKlLilxGEdBssUeNapzeVniBJ/x85MYpuFuwBbFUHcdHqk/qbMumsy4y89riRB
	 GzA9V2+OGETc6pKU14/bDzIFWmbsq0Is/n+YvgkXyMVzWfuK9fkEb+Gv7WAlDrHQ94g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M7PgpiVY;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E6606A337
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395E6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M7PgpiVY
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38692f62b22so5466074eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565184; x=1796169984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CK2W4+wUnESJRPQMuOkNCLCi5VCZ9oTd0r3qBFZs0Ls=;
        b=M7PgpiVYnCtcZ3Alr1XGilrLJFcT1rPKExZ/YFlJcZoxQCneu7EcbuiqSHE/UZWqsb
         qQxVnZKDTArRTY+ZbW4zMC4eHL9Jn0LgxVbmlj6S7KIRl/BxP3niB/MApn0Ps8Giq3xc
         K9Zc+9cgkiuNK3t3ntMDdP+ROQ18ox38DMp1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565184; x=1796169984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CK2W4+wUnESJRPQMuOkNCLCi5VCZ9oTd0r3qBFZs0Ls=;
        b=wLsmSdiS4PNdCd+AJxI3RGA5JiA2tQiRf7L++DYgvr3XaXJoHn82+41QoZ3OXFH3x3
         hH1v688MdF+XsDLu7uWjwcrD8NMP2BTLiXD0XWujOVQtF3lC0z3gufLxxMioOHMSUdai
         7KMN78Xkq8Y+puM7Sh59PMuX2SJVYozwlrpW5uhMsUBejhBXNfrz6wnnk56C+ya9jnu1
         5dVRrmSg+jwy1duzQAFXG24pFsKiBkZxmMlpMkwIlZ9TNWl73LKX6Zlc/PTGYYL1+BwQ
         ddnEGXbrMz7QYLbpVFff9Ovp9g14WhhxuHeklvptmrrhRJzBYGJhrIsudhi3+pZ1Rm1u
         2ozQ==
X-Forwarded-Encrypted: i=1; AL+hErGgH5bTnWvfZ7vC4bj4zXt3umxGX3NFPXoy58KvS9h6lKpjYV2KGOXcv0goXXYzJJSTDWoJYqEZ5g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zgiIXEkM/Odv9/ghaqlqQ5S6OMGlhyHk3DaLnK+e4C4BdYDCN
	HsZiRaLA1BZQBBtSakyKdkIbgs6thidjRT9NZfHgySb/Y/twxPmrnodbV2HPeyZquw==
X-Gm-Gg: AZFdTZeItJ0H2rgNS/fC9Ex3VygHPc73tnmYSE5O8S1amADWlOHtGbBFyuRrzPQjGYK
	1algkXpzNByoB50zr7JvTT2UbazoCYzfk0fGTScxczxEtBxYD9PWdnHYtMmdqr4awUR0ADJ3BOE
	xNGdZUra+fb2VqI0UZ0Xb4X2OBUeAVeIRmTnGzDpmB57flsS0JjWdhzaWwIqNNif0H1fpdnCT35
	uhLdH69JNxGk70Y96Eo2wICdccH493j9mBBchaZnb2gBM0UyOZPE//qPfCd5xEVxNydk9U88ooY
	PFXpgB/7rvPwUnTqK431I2vTbE1mNOnX+aFQt7N8UXwLM/eqPPSvtP6kS3ctoXhu0HYZ9XMdhXR
	xeH040cuUQgjYgKhR5QVP2HmHLzJlzHyBnQFeETTlowuhlFGy+9bm0PLbhU5jouExdQ/1dY1wHF
	AzOLegG2jpGr56f/POWY2GRURzsT3mC6vp1eGkP/fpWTJPR08s25pOwoSVrWhVwZODDZ1CPLMwD
	a9/Z0eSvX93qJL4pdEM2FWqxGX6CCfqLsrE4m6xoBuHvK0Aqwjn8JrWIRmCQR4dir0Ys1odd9C4
	Y1OTQe7B535oTS9Dm9GCpFTBEzjnjCY8vVhXNv9i+lBaSFEIBLtA1XwXrpnhMRETjnIf+hkUVyt
	KgPDqlj/svc48Rw==
X-Received: by 2002:a05:7301:460f:b0:386:c850:1f25 with SMTP id 5a478bee46e88-386c8502211mr2425231eec.21.1795565184021;
        Tue, 24 Nov 2026 16:06:24 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-38566fdce48sm51405808eec.14.2026.11.24.16.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:23 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	linux-clk@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/9] dt-bindings: power: google: Add Google Tensor CPM
Date: Tue, 24 Nov 2026 16:03:35 -0800
Message-ID: <20261124160343.v2.1.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261125000349.3385325-1-briannorris@chromium.org>
References: <20261125000349.3385325-1-briannorris@chromium.org>
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

Notable features of this binding:

 * Resets and interrupts have a naive mapping to their underlying
   resource on the remote (firmware) end, so they directly utilize the
   firmware indexing (LPCM ID + reset ID, #reset-cells = <2>; and
   interrupt ID, #interrupt-cells = <1>)

 * Clocks and power domains also map relatively directly to CPM firmware
   IDs (LPCM ID and object ID), but they have a more complicated
   hierarchy, non-uniform characteristics, and even covering multiple
   service protocols (especially for power-domains). So these use a
   1-cell identifier, leaving software to perform the DT-to-firmware
   mapping.

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

Changes in v2:
 * Move bindings to power/, not soc/
 * Make binding prefix/suffix pattern consistent (no LGA_*; put type
   first (CLK_*, PD_*))
 * Consistent naming for dt-bindings headers
 * Drop unneeded IRQ number dt-binding header (these were simply naming
   documentation, at best; I inline these into the DTS instead)
 * Drop unneeded reset number dt-binding header (these were simply
   naming documentation; I move the macro definitions directly into the
   dts/ folder instead)
 * List properties in alphabetical order
 * Flatten clock IDs to 1 cell

 .../bindings/power/google,lga-cpm.yaml        |  68 +++++++
 include/dt-bindings/clock/google,lga-cpm.h    | 173 ++++++++++++++++++
 include/dt-bindings/power/google,lga-cpm.h    |  79 ++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/google,lga-cpm.yaml
 create mode 100644 include/dt-bindings/clock/google,lga-cpm.h
 create mode 100644 include/dt-bindings/power/google,lga-cpm.h

diff --git a/Documentation/devicetree/bindings/power/google,lga-cpm.yaml b/Documentation/devicetree/bindings/power/google,lga-cpm.yaml
new file mode 100644
index 000000000000..a11b76df23fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/google,lga-cpm.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/google,lga-cpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Central Power Manager (CPM)
+
+maintainers:
+  - Brian Norris <briannorris@chromium.org>
+
+description:
+  The Central Power Manager (CPM) is an on-chip power management subsystem
+  found on Google Tensor SoCs. It has a variety of responsibilities, from DVFS
+  and power management to resets, PMIC control, and even RTC management. The
+  Application Processor communicates with CPM over a set of mailbox channels.
+
+properties:
+  compatible:
+    const: google,lga-cpm
+
+  '#clock-cells':
+    const: 1
+    description: See <dt-bindings/clock/google,lga-cpm.h> for clock IDs.
+
+  '#interrupt-cells':
+    const: 1
+    description: Interrupt identifiers are assigned by CPM firmware.
+
+  interrupt-controller: true
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
+      LPCM and reset IDs are assigned by CPM firmware.
+
+required:
+  - compatible
+  - '#clock-cells'
+  - '#interrupt-cells'
+  - interrupt-controller
+  - mboxes
+  - '#power-domain-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller {
+        compatible = "google,lga-cpm";
+        mboxes = <&cpm_ap_ns_req_mba>, <&cpm_ap_ns_resp_mba>;
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <2>;
+        #interrupt-cells = <1>;
+        interrupt-controller;
+    };
diff --git a/include/dt-bindings/clock/google,lga-cpm.h b/include/dt-bindings/clock/google,lga-cpm.h
new file mode 100644
index 000000000000..a390297449d7
--- /dev/null
+++ b/include/dt-bindings/clock/google,lga-cpm.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H
+#define __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H
+
+/* CPU */
+#define CLK_CPU_SSWRP_TSS		0
+
+/* DPU */
+#define CLK_DPU_DP0_PIX			1
+#define CLK_DPU_DP1_PIX			2
+#define CLK_DPU_DSI0_PIX		3
+#define CLK_DPU_DSI1_PIX		4
+#define CLK_DPU_DSI1_PHY		5
+
+/* GPCM */
+#define CLK_GPCM_DPU_PLL_DP		6
+#define CLK_GPCM_HSIO_N_PLL_DP		7
+
+/* HSIO_N */
+#define CLK_HSIO_N_USB			8
+#define CLK_HSIO_N_DP0			9
+#define CLK_HSIO_N_DP1			10
+#define CLK_HSIO_N_PHY_FW		11
+#define CLK_HSIO_N_USBDP_SUSPEND	12
+#define CLK_HSIO_N_USBC_NON_STICKY	13
+#define CLK_HSIO_N_USBC_STICKY		14
+#define CLK_HSIO_N_USB_DRD_BUS		15
+#define CLK_HSIO_N_USB_TOP_CSR		16
+#define CLK_HSIO_N_U2PHY_APB		17
+#define CLK_HSIO_N_USB2_PHY_RESET	18
+#define CLK_HSIO_N_USB3DP_PHY_RESET	19
+#define CLK_HSIO_N_EBU			20
+
+/* HSIO_S */
+#define CLK_HSIO_S_GPIO_REF_TCX0	21
+#define CLK_HSIO_S_SYS			22
+#define CLK_HSIO_S_UFS_CFG		23
+#define CLK_HSIO_S_PHY_FW		24
+#define CLK_HSIO_S_MPHY_REF_TCX0	25
+#define CLK_HSIO_S_AUX			26
+
+/* LSIO_E */
+#define CLK_LSIO_E_GPIO			27
+#define CLK_LSIO_E_SPMI			28
+#define CLK_LSIO_E_CLI7_CFG		29
+#define CLK_LSIO_E_CLI8_CFG		30
+#define CLK_LSIO_E_CLI9_CFG		31
+#define CLK_LSIO_E_CLI10_CFG		32
+#define CLK_LSIO_E_CLI11_CFG		33
+#define CLK_LSIO_E_CLI12_CFG		34
+#define CLK_LSIO_E_CLI13_CFG		35
+#define CLK_LSIO_E_CLI14_CFG		36
+#define CLK_LSIO_E_CLI7_SPI		37
+#define CLK_LSIO_E_CLI8_SPI		38
+#define CLK_LSIO_E_CLI9_SPI		39
+#define CLK_LSIO_E_CLI10_SPI		40
+#define CLK_LSIO_E_CLI11_SPI		41
+#define CLK_LSIO_E_CLI12_SPI		42
+#define CLK_LSIO_E_CLI13_SPI		43
+#define CLK_LSIO_E_CLI14_SPI		44
+#define CLK_LSIO_E_CLI7_I2C		45
+#define CLK_LSIO_E_CLI8_I2C		46
+#define CLK_LSIO_E_CLI9_I2C		47
+#define CLK_LSIO_E_CLI10_I2C		48
+#define CLK_LSIO_E_CLI11_I2C		49
+#define CLK_LSIO_E_CLI12_I2C		50
+#define CLK_LSIO_E_CLI13_I2C		51
+#define CLK_LSIO_E_CLI14_I2C		52
+#define CLK_LSIO_E_CLI7_UART		53
+#define CLK_LSIO_E_CLI8_UART		54
+#define CLK_LSIO_E_CLI9_UART		55
+#define CLK_LSIO_E_CLI10_UART		56
+#define CLK_LSIO_E_CLI11_UART		57
+#define CLK_LSIO_E_CLI12_UART		58
+#define CLK_LSIO_E_CLI13_UART		59
+#define CLK_LSIO_E_CLI14_UART		60
+#define CLK_LSIO_E_CLI7_I3C		61
+#define CLK_LSIO_E_CLI8_I3C		62
+#define CLK_LSIO_E_CLI9_I3C		63
+#define CLK_LSIO_E_CLI10_I3C		64
+#define CLK_LSIO_E_CLI11_I3C		65
+#define CLK_LSIO_E_CLI12_I3C		66
+#define CLK_LSIO_E_CLI13_I3C		67
+#define CLK_LSIO_E_CLI14_I3C		68
+
+/* LSIO_N */
+#define CLK_LSIO_N_GPIO			69
+#define CLK_LSIO_N_CLI15_CFG		70
+#define CLK_LSIO_N_CLI16_CFG		71
+#define CLK_LSIO_N_CLI15_I2C		72
+#define CLK_LSIO_N_CLI16_I2C		73
+#define CLK_LSIO_N_CLI15_UART		74
+#define CLK_LSIO_N_CLI16_UART		75
+#define CLK_LSIO_N_CLI15_SPI		76
+#define CLK_LSIO_N_CLI16_SPI		77
+#define CLK_LSIO_N_CLI15_I3C		78
+#define CLK_LSIO_N_CLI16_I3C		79
+#define CLK_LSIO_N_CLI_INT0_I2C		80
+#define CLK_LSIO_N_CLI_INT0_I3C		81
+#define CLK_LSIO_N_CLI_INT0_UART	82
+#define CLK_LSIO_N_CLI_INT0_SPI		83
+#define CLK_LSIO_N_CLI_INT0_CFG		84
+#define CLK_LSIO_N_CLI_INT1_I2C		85
+#define CLK_LSIO_N_CLI_INT1_I3C		86
+#define CLK_LSIO_N_CLI_INT1_UART	87
+#define CLK_LSIO_N_CLI_INT1_SPI		88
+#define CLK_LSIO_N_CLI_INT1_CFG		89
+#define CLK_LSIO_N_CLI_INT2_I2C		90
+#define CLK_LSIO_N_CLI_INT2_I3C		91
+#define CLK_LSIO_N_CLI_INT2_UART	92
+#define CLK_LSIO_N_CLI_INT2_SPI		93
+#define CLK_LSIO_N_CLI_INT2_CFG		94
+#define CLK_LSIO_N_CLI_INT3_I2C		95
+#define CLK_LSIO_N_CLI_INT3_I3C		96
+#define CLK_LSIO_N_CLI_INT3_UART	97
+#define CLK_LSIO_N_CLI_INT3_SPI		98
+#define CLK_LSIO_N_CLI_INT3_CFG		99
+#define CLK_LSIO_N_CLI_INT4_I2C		100
+#define CLK_LSIO_N_CLI_INT4_I3C		101
+#define CLK_LSIO_N_CLI_INT4_UART	102
+#define CLK_LSIO_N_CLI_INT4_SPI		103
+#define CLK_LSIO_N_CLI_INT4_CFG		104
+
+/* LSIO_S */
+#define CLK_LSIO_S_GPIO			105
+#define CLK_LSIO_S_MCLK0		106
+#define CLK_LSIO_S_MCLK1		107
+#define CLK_LSIO_S_MCLK2		108
+#define CLK_LSIO_S_MCLK3		109
+#define CLK_LSIO_S_MCLK4		110
+#define CLK_LSIO_S_MCLK5		111
+#define CLK_LSIO_S_MCLK6		112
+#define CLK_LSIO_S_MCLK7		113
+#define CLK_LSIO_S_PWM			114
+#define CLK_LSIO_S_PWM_CFG		115
+#define CLK_LSIO_S_CLI0_CFG		116
+#define CLK_LSIO_S_CLI1_CFG		117
+#define CLK_LSIO_S_CLI2_CFG		118
+#define CLK_LSIO_S_CLI3_CFG		119
+#define CLK_LSIO_S_CLI4_CFG		120
+#define CLK_LSIO_S_CLI5_CFG		121
+#define CLK_LSIO_S_CLI6_CFG		122
+#define CLK_LSIO_S_CLI0_SPI		123
+#define CLK_LSIO_S_CLI1_SPI		124
+#define CLK_LSIO_S_CLI2_SPI		125
+#define CLK_LSIO_S_CLI3_SPI		126
+#define CLK_LSIO_S_CLI4_SPI		127
+#define CLK_LSIO_S_CLI5_SPI		128
+#define CLK_LSIO_S_CLI6_SPI		129
+#define CLK_LSIO_S_CLI0_I2C		130
+#define CLK_LSIO_S_CLI1_I2C		131
+#define CLK_LSIO_S_CLI2_I2C		132
+#define CLK_LSIO_S_CLI3_I2C		133
+#define CLK_LSIO_S_CLI4_I2C		134
+#define CLK_LSIO_S_CLI5_I2C		135
+#define CLK_LSIO_S_CLI6_I2C		136
+#define CLK_LSIO_S_CLI0_UART		137
+#define CLK_LSIO_S_CLI1_UART		138
+#define CLK_LSIO_S_CLI2_UART		139
+#define CLK_LSIO_S_CLI3_UART		140
+#define CLK_LSIO_S_CLI4_UART		141
+#define CLK_LSIO_S_CLI5_UART		142
+#define CLK_LSIO_S_CLI6_UART		143
+#define CLK_LSIO_S_CLI0_I3C		144
+#define CLK_LSIO_S_CLI1_I3C		145
+#define CLK_LSIO_S_CLI2_I3C		146
+#define CLK_LSIO_S_CLI3_I3C		147
+#define CLK_LSIO_S_CLI4_I3C		148
+#define CLK_LSIO_S_CLI5_I3C		149
+#define CLK_LSIO_S_CLI6_I3C		150
+
+#endif /* __DT_BINDINGS_CLOCK_GOOGLE_LGA_CPM_H */
diff --git a/include/dt-bindings/power/google,lga-cpm.h b/include/dt-bindings/power/google,lga-cpm.h
new file mode 100644
index 000000000000..b9c5037728f9
--- /dev/null
+++ b/include/dt-bindings/power/google,lga-cpm.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H
+#define __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H
+
+/* AOC */
+#define PD_SSWRP_AOC		0
+#define PD_AOC_CORE		1
+
+/* AURORA */
+#define PD_SSWRP_AURORA		2
+
+/* CODEC_3P */
+#define PD_SSWRP_CODEC_3P	3
+
+/* DPU */
+#define PD_DPU_DP		4
+#define PD_SSWRP_DPU		5
+#define PD_DPU_FE0		6
+#define PD_DPU_FE1		7
+#define PD_DPU_DSI0		8
+#define PD_DPU_DSI1		9
+
+/* EH */
+#define PD_SSWRP_EH		10
+
+/* G2D */
+#define PD_SSWRP_G2D		11
+#define PD_G2D_CORE		12
+
+/* GPDMA */
+#define PD_SSWRP_GPDMA		13
+
+/* GPU */
+#define PD_SSWRP_GPU		14
+
+/* GSW */
+#define PD_SSWRP_GSW		15
+
+/* HSIO_N */
+#define PD_SSWRP_HSIO_N		16
+#define PD_HSIO_N_USB		17
+#define PD_HSIO_N_USB_PSW	18
+#define PD_HSIO_N_PCIE		19
+#define PD_HSIO_N_DP		20
+#define PD_HSIO_N_EBU		21
+#define PD_HSIO_N_EBU_CORE	22
+
+/* HSIO_S */
+#define PD_SSWRP_HSIO_S		23
+#define PD_HSIO_S_UFS_PREP	24
+#define PD_HSIO_S_UFS		25
+#define PD_HSIO_S_PCIE		26
+#define PD_HSIO_S_SD		27
+
+/* ISPBE */
+#define PD_SSWRP_ISPBE		28
+
+/* ISPFE */
+#define PD_SSWRP_ISPFE		29
+#define PD_ISPFE_PIPE		30
+#define PD_ISPFE_CSIS		31
+
+/* LSIO_E */
+#define PD_SSWRP_LSIO_E		32
+#define PD_LSIO_E_CLI_GPIO	33
+
+/* LSIO_N */
+#define PD_SSWRP_LSIO_N		34
+#define PD_LSIO_N_CLI_GPIO	35
+
+/* LSIO_S */
+#define PD_SSWRP_LSIO_S		36
+#define PD_LSIO_S_CLI_GPIO	37
+
+/* TPU */
+#define PD_SSWRP_TPU		38
+
+#endif /* __DT_BINDINGS_POWER_GOOGLE_LGA_CPM_H */
-- 
2.56.1.831.g720f3f5937-goog

