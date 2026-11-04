Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778391;
	b=O7sA71hsLWrCTo9Tdf6TiQ4svkYJziJhMCvPtz/GX65W9ZsskLox9Nb65L9boxFFOZkH
	 uOyfvSyWp7MOM2436SjkPhxPY/rc7oSOWnqIjSbzwMQvJYhsiGidofGWLArezZHKsppY5
	 A1vJ9aempOL8i30yGATgiDfJ0zVrf/EZitX7YCz9PoLc7Vep0P50VIpxhtOZZ7sJWXFyg
	 VFX5xYFj+8LO2iMDoN0VfkNbKwXHKgEKk4o0gF2726ClIREPugm2muVtkIgtPJmsNagnc
	 j0z5TtULKk0RbnDL0fd29dH/xNI18WgtyqkBq3hrmd+bZz76hfWp2ilIPcZjymLk5RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=m52jieKKqnBv5GroLvKWf1SFv6SUy0rMYAbEKd7OWTU=;
	b=EgQZii7+pLvGwF6ZnPZz4KAsJ2PM/fTROrRtzYREjhVKQM0l1vDLkSg5ks22ySTxZCvd
	 K6nyzblgKqJob67UnBdbC/QL+fgQOZqdRorJxO5R8NnIFR+mClyatMpW9wvd/3V7RFAL/
	 mGR5RjIQ0pX5wBQ4jEMNOPvuibTNSniEOpKIPT29b4ymLfa4lZp1gGPoi8BXk8xS4rBUX
	 fDmanjT16xY8AiwGSoHoxx9IpvmPSFVEnPhVhzMLnKZy3oRH/DWNRJ7Mya0KARAzwguhp
	 LOVbZGukHOR22vDZxkexHnc7gpkj5kDyQIzst/CAgciQbBlJJd7SadGRMG11D11EKUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqNlpjnW;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B47606D80C
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 07:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B47606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqNlpjnW
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36cad25b8b0so555704eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 23:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793778391; x=1794383191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m52jieKKqnBv5GroLvKWf1SFv6SUy0rMYAbEKd7OWTU=;
        b=hqNlpjnW+B94JnDPH1Mm+SThPOCO4RIwGSc7I4zusesbXNTNQM2h80tD3ZBje6znFZ
         yVtSJHvAqnRVpZaQJjWBiJd+qZ3hRmNsjpi2sThVFcGoa7K2IeIF48+i+UHj2M7O6/T4
         E39YIGBeYkJ4rlEXTxhBQ7U6suJuJMMYC+w19o9XmSFOSW4cb9xWBeLgjEPhtfVV+J96
         UqywfsXQI/2p3CLjpkApbSqTCraVP3PO7gjKdy4KUeAx5YLxsu5q4f131+I/XFHgGJmM
         /libhKTQxKz3pLOqk+O5PXV/Q9pSWJL3oLf12rxlK9JeGI2NfsWhzTyRMN9YfF91+BMN
         3/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778391; x=1794383191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m52jieKKqnBv5GroLvKWf1SFv6SUy0rMYAbEKd7OWTU=;
        b=R+4VPd6w6IUyPlqHktg9SQTVdPYC1WFgehDMiWQhWz8KVYDTg3UnvVKrCxIrobfxLT
         1EKL4yhmXFj0jMv5f64MMU3XxW5uT9Yx8BvNTSpbxKQBa9cCV6uFjxqwm0KS2XLiVUT7
         g8fwMhFdCSJfHF5eestgUilyGhliBQkJ4OfQ9JFJnFGSY/Zr0/X654sPGlRM34tF2Uaz
         UY9wuXtLMiG6/SfJAnmFzpi7qUqXHyz4R9M5IWlFZLGwTPximaCbaXb7PBIV77LO3Xzb
         GYRgZuLkXtBt/qbDMGBNXL7oFZNqJVc4UTczX6Rs1WipoTHFeshSWj3CPHgOqQQFCPiT
         bfdA==
X-Forwarded-Encrypted: i=1; AKwUvBwFjxdi1/I18a8G0xFzl4JsBfC8i9cxFyrrZJN+scsU8Lw3L5fJV4JIuLx8epcuAsmGaaOwMVQJZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xl7G3EDgaM9V/zCg3b/dNLYP8m3rx/JOJV5oiMBVmSCD9d2tk
	9hAPOlM+R1HRcKm23PMdQ9jFAXbS7GlkT3MmOuZzRb8sj+YXRgh4rZLb
X-Gm-Gg: AYBFou3THMXpcC10KL/E9WTynev12eADfXjKCaAhkkAb1xKa2YsSWDgAocQ31oqNM+f
	xSrIYxCaqP52SwzDpR/BxEygXFpnM4iRU70PgBBWhk2VEPTCaz9DqAhhog4X+Kn9zC15xyMmJm8
	DVJRDkGSA8MHhicsWWN9mFxDg2fWK4g1vQQy1OIJ3PMSzD6VWrZ98fDJJQXW5y7Mc32l2B8H0nK
	KO+pyX6ytfE0WhSSWC4cITKqEJfb8tQnmE+2L1h7CA0IshjaE3Ksqns9JihdSkjA5N6EmCxBUIf
	00xc3cGwXi7LSpgTL22xAmxYSJSZQftKqmGMzEmc7gm2I4X4kYpfFkQlNrrBkvD9K161LFMu1W/
	1iR868vmtAk/y3dgRMdJmS9dJ1r4ICOi1Dr+98eugPoDcoYODXTg7z/Y/dpr0ZWPVPBxyPeoluA
	Ty0Yft8G/gdKSkQB0jnWCGtLO1COaeH9/iZ2SnEJHJbHY8q8tbPb/Ukc47pU6L10daaINnE++e3
	uR89SO7jjGzqH7EvYdHfZrWZnYu+eYLs1DUMV57rDPUtWgamJyH1CTTNJ5PC75id79c+Tiw2dC+
	u3w+F37SOIq98RoqrRHPQs9UbOonrwdvkPQCZ0A9DJqvNKb/gCEaLQBbNqyF1eFOlGRG7QMKdnI
	JW21avQ==
X-Received: by 2002:a05:7300:e9d3:20b0:369:fe81:a575 with SMTP id 5a478bee46e88-36a4243ab94mr27130200eec.35.1793778390558;
        Tue, 03 Nov 2026 23:46:30 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.204.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm4566016eec.8.2026.11.03.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 23:46:30 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 07:46:04 +0000
Subject: [PATCH v12 1/6] dt-bindings: clock: Add SM7250 global clock
 controller
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-master-v12-1-57fbe9eef978@gmail.com>
References: <20261104-master-v12-0-57fbe9eef978@gmail.com>
In-Reply-To: <20261104-master-v12-0-57fbe9eef978@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793778372; l=7988;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=4JR89GKnTTmAoxNgD7NPPZnHUc2FC6CQYNElhDfzy4M=;
 b=NAW4QjvOTSDH0MsrJv9iTeRvOQCUEec+g/b/eTNPmQYQ0qEWsoUCP1JavpZmBrfZ5Sz6r7wfj
 T26D95mS2zrD+eUN1bztBxnJtDnTztZujgRchz8CGsvg0xkDco9E/69
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Add device tree bindings for global clock controller on SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |  13 +-
 include/dt-bindings/clock/qcom,gcc-sm7250.h        | 163 +++++++++++++++++++++
 2 files changed, 172 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
index 5f9aae728..f62aa0c59 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
@@ -4,21 +4,26 @@
 $id: http://devicetree.org/schemas/clock/qcom,gcc-sm8250.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Global Clock & Reset Controller on SM8250
+title: Qualcomm Global Clock & Reset Controller on SM7250 and SM8250
 
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <quic_tdas@quicinc.com>
+  - Sreeshankar K <sreeshankar0910@gmail.com>
 
 description: |
   Qualcomm global clock control module provides the clocks, resets and power
-  domains on SM8250.
+  domains on SM7250 and SM8250.
 
-  See also: include/dt-bindings/clock/qcom,gcc-sm8250.h
+  See also:
+    - include/dt-bindings/clock/qcom,gcc-sm7250.h
+    - include/dt-bindings/clock/qcom,gcc-sm8250.h
 
 properties:
   compatible:
-    const: qcom,gcc-sm8250
+    enum:
+      - qcom,gcc-sm7250
+      - qcom,gcc-sm8250
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,gcc-sm7250.h b/include/dt-bindings/clock/qcom,gcc-sm7250.h
new file mode 100644
index 000000000..765fdc38f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sm7250.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2026, Sreeshankar K <sreeshankar0910@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM7250_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM7250_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_EVEN						1
+#define GPLL6							2
+#define GPLL9							3
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				4
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				5
+#define GCC_BOOT_ROM_AHB_CLK					6
+#define GCC_CAMERA_AHB_CLK					7
+#define GCC_CAMERA_HF_AXI_CLK					8
+#define GCC_CAMERA_SF_AXI_CLK					9
+#define GCC_CAMERA_XO_CLK					10
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				11
+#define GCC_CPUSS_AHB_CLK					12
+#define GCC_CPUSS_AHB_CLK_SRC					13
+#define GCC_CPUSS_GNOC_CLK					14
+#define GCC_CPUSS_RBCPR_CLK					15
+#define GCC_DDRSS_GPU_AXI_CLK					16
+#define GCC_DISP_GPLL0_CLK_SRC					17
+#define GCC_DISP_AHB_CLK					18
+#define GCC_DISP_HF_AXI_CLK					19
+#define GCC_DISP_SF_AXI_CLK					20
+#define GCC_DISP_XO_CLK						21
+#define GCC_GP1_CLK						22
+#define GCC_GP1_CLK_SRC						23
+#define GCC_GP2_CLK						24
+#define GCC_GP2_CLK_SRC						25
+#define GCC_GP3_CLK						26
+#define GCC_GP3_CLK_SRC						27
+#define GCC_GPU_CFG_AHB_CLK					28
+#define GCC_GPU_GPLL0_CLK_SRC					29
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				30
+#define GCC_GPU_IREF_CLK					31
+#define GCC_GPU_MEMNOC_GFX_CLK					32
+#define GCC_GPU_SNOC_DVM_GFX_CLK				33
+#define GCC_NPU_AXI_CLK						34
+#define GCC_NPU_BWMON2_AXI_CLK					35
+#define GCC_NPU_BWMON_AXI_CLK					36
+#define GCC_NPU_BWMON_CFG_AHB_CLK				37
+#define GCC_NPU_CFG_AHB_CLK					38
+#define GCC_NPU_DMA_CLK						39
+#define GCC_NPU_GPLL0_CLK_SRC					40
+#define GCC_NPU_GPLL0_DIV_CLK_SRC				41
+#define GCC_PDM2_CLK						42
+#define GCC_PDM2_CLK_SRC					43
+#define GCC_PDM_AHB_CLK						44
+#define GCC_PDM_XO4_CLK						45
+#define GCC_PRNG_AHB_CLK					46
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				47
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				48
+#define GCC_QMIP_DISP_AHB_CLK					49
+#define GCC_QMIP_RT_DISP_AHB_CLK				50
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				51
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				52
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				53
+#define GCC_QUPV3_WRAP0_CORE_CLK				54
+#define GCC_QUPV3_WRAP0_S0_CLK					55
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				56
+#define GCC_QUPV3_WRAP0_S1_CLK					57
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				58
+#define GCC_QUPV3_WRAP0_S2_CLK					59
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				60
+#define GCC_QUPV3_WRAP0_S3_CLK					61
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				62
+#define GCC_QUPV3_WRAP0_S4_CLK					63
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				64
+#define GCC_QUPV3_WRAP0_S5_CLK					65
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				66
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				67
+#define GCC_QUPV3_WRAP1_CORE_CLK				68
+#define GCC_QUPV3_WRAP1_S0_CLK					69
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				70
+#define GCC_QUPV3_WRAP1_S1_CLK					71
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				72
+#define GCC_QUPV3_WRAP1_S2_CLK					73
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				74
+#define GCC_QUPV3_WRAP1_S3_CLK					75
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				76
+#define GCC_QUPV3_WRAP1_S4_CLK					77
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				78
+#define GCC_QUPV3_WRAP1_S5_CLK					79
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				80
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				81
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				82
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				83
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				84
+#define GCC_SDCC1_AHB_CLK					85
+#define GCC_SDCC1_APPS_CLK					86
+#define GCC_SDCC1_APPS_CLK_SRC					87
+#define GCC_SDCC1_ICE_CORE_CLK					88
+#define GCC_SDCC1_ICE_CORE_CLK_SRC				89
+#define GCC_SDCC2_AHB_CLK					90
+#define GCC_SDCC2_APPS_CLK					91
+#define GCC_SDCC2_APPS_CLK_SRC					92
+#define GCC_SDCC4_AHB_CLK					93
+#define GCC_SDCC4_APPS_CLK					94
+#define GCC_SDCC4_APPS_CLK_SRC					95
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				96
+#define GCC_UFS_1X_CLKREF_CLK					97
+#define GCC_UFS_PHY_AHB_CLK					98
+#define GCC_UFS_PHY_AXI_CLK					99
+#define GCC_UFS_PHY_AXI_CLK_SRC					100
+#define GCC_UFS_PHY_ICE_CORE_CLK				101
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				102
+#define GCC_UFS_PHY_PHY_AUX_CLK					103
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				104
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				105
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				106
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				107
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				108
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				109
+#define GCC_USB30_PRIM_MASTER_CLK				110
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				111
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				112
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			113
+#define GCC_USB30_PRIM_SLEEP_CLK				114
+#define GCC_USB3_PRIM_CLKREF_CLK				115
+#define GCC_USB3_PRIM_PHY_AUX_CLK				116
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				117
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				118
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				119
+#define GCC_VIDEO_AHB_CLK					120
+#define GCC_VIDEO_AXI_CLK					121
+#define GCC_VIDEO_XO_CLK					122
+
+/* GCC resets */
+#define GCC_DPM_BCR						0
+#define GCC_GPU_BCR						1
+#define GCC_MMSS_BCR						2
+#define GCC_NPU_BWMON_BCR					3
+#define GCC_NPU_BCR						4
+#define GCC_PDM_BCR						5
+#define GCC_PRNG_BCR						6
+#define GCC_QUPV3_WRAPPER_0_BCR					7
+#define GCC_QUPV3_WRAPPER_1_BCR					8
+#define GCC_QUSB2PHY_PRIM_BCR					9
+#define GCC_SDCC1_BCR						10
+#define GCC_SDCC2_BCR						11
+#define GCC_SDCC4_BCR						12
+#define GCC_UFS_PHY_BCR						13
+#define GCC_USB30_PRIM_BCR					14
+#define GCC_USB3_DP_PHY_PRIM_BCR				15
+#define GCC_USB3_PHY_PRIM_BCR					16
+#define GCC_USB3PHY_PHY_PRIM_BCR				17
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				18
+
+/* GCC power domains */
+#define UFS_PHY_GDSC						0
+#define USB30_PRIM_GDSC						1
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC			2
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC			3
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC			4
+
+#endif

-- 
2.43.0

