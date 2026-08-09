Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B93ADB89
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260563; cv=none; b=MXrtoX1efUSy10nfVrgGt2fJDDdt79Er7dRjfavnUjEGjZx9LklEyagCM9ChST5P5IynN5/4IRC42soQ4219p+sdCJj4FCRDhA+rDk+2G2JGwEr5bnsHAlJj45JsN52BLrs5/OnDkOM/O7oKyF/nxvsbeF6Puwf6FQUZGKiTvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260563; c=relaxed/simple;
	bh=jBYWnprPWiHXi7mypvqXh+amEM9e3+4E0GWt9HZDUCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlRUHSmHbeGANty+BENHswjLUnODH1PcB9k4MJTBHJTvwLrU8zuTkpHjLmI7Vlpej4/Cob7W7kHqcmreMjKCquEIeDKqmpgwMP/xi++RU0+G31r1a6ENl6iO/1YAw/TxYpJjGghl3+ZBW7Blo1BT6MWmkPGCBfC0dBE84ng+wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LD1j9bWx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpylRAUF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LD1j9bWx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpylRAUF"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67960O4D1897126
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GbmByI+LY1ip0RvuOz6PCtWpqf50u1eNjeTJ3JK5wIw=; b=LD1j9bWxxtQ23KJp
	auehKwyzEcSYWxe49G5lQ5v8xZ+ErDCjckd4WhWyPHHpZWlt5qBYOgjfTz2nmkaa
	JU4xmvZSzx10RDnfJ5Wygy1Wjf8sNRygNl/fwkw76We/l7xDqfkKoqkRp84NbW+G
	7Htg4e4MoTZaA4z8Ab0jgRUUlRnvKQ94eNUJaWwOBgmYIflhbkS/O8XWs+aA5ZTh
	zNB5xw6+HmJyd0D1ESzKIWkKxJEsoBspzkpb2exmwRPFYHpLIqo9uv4/5lG97cK6
	7nINAt4hGmZl3YHzOp43EZiFEqNRHkhEdLt8D2Gap4/pbjOX7dV/yx9uT3hjlURE
	tD1GWQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush2j6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:29:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so587734a12.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260559; x=1786865359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbmByI+LY1ip0RvuOz6PCtWpqf50u1eNjeTJ3JK5wIw=;
        b=HpylRAUFSZhuyFisOQXL+lgWimWrT1l9skIolfW4/f3B/Vtc+3F1c/MB3O3hZ0Jr0s
         53hyErZcqpfFPXgsZDWOKHDXYNFbbyLDE0uVBDFzfYN6wSV2W+yXL2HprkBDXW2jq+Ou
         buUJ37YadlGbpgfH8kyXxauTxMzkW3tURZgmZB8gnY6BrYYNHPz1FZ7Y4/myQ4927bTq
         yNP39oueeIorI1mWfse8+SpDJyPGosPYl2Fy1WGYHIyETuTQdWrdLlkf0OACCDuGMUeg
         TVaujjaiMnJxeeRSzCnQzOVbMOZNt1Pfu+17Om6mfnX3OCryZ25Vvn2BwH9RzEYMx3MN
         Q9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260559; x=1786865359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbmByI+LY1ip0RvuOz6PCtWpqf50u1eNjeTJ3JK5wIw=;
        b=nB6C7DLINLnn9Ta2+uulXTTELXy0//4Wdt0Vi8+KEXhQT67q3OKVnC4GnrQKj6TK6d
         kMFel77x/Z9urySjeMsViuhgdRChynuyzMohQCdScm92BrmmMKIZHp1hbk+T7bXnkIzy
         Y6AHSV0f365+Ha6EmDjLNU0v/R1fXL9TWPUGYMvwf/IQ2nsjfvzt01Wxy3SZm0XdlfI3
         Sb5NHVZhUcImyt1QwlvkxHN7RmDw5LGP+eCrTIEH+VW3HGh+TClb0BTt30r43s5zijYB
         8dwGWq4X0teydeBF4+WLx1nEUVCrlwX97nKKM5MSa8kprO6e1/Fhxz1pYNCzCJKs3HLl
         FfVQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHResW3xXtnCrthWIoFI/T5xHJdbf6yEYHCRziVmkD+n3TbVT/OoMaGuyKhbU/6l2Gt90E4BrXEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFigK6RLpT7XSGz8f4xr5BV7qIHVyW1bI/dmFt7POg4IPjy5LN
	YdkAxGkV3qfiU51CQFYq/iPxzm7zsMtimouoON9WyLgOPUDA0CpgKvRvRSLaY2lrulP0yr52d62
	+b6jm2tLh5xHKMTeNhGB/qQhhIWp5GLkCqLu2JuDHOybn1n8RC+eKUi6fxduwtA==
X-Gm-Gg: AR+sD12++YWymeZmBQ50JZO2xtROxZW9Db0Yj8T+sYt8ZQgWZ4qOIuzDGaME1YeB0js
	InZI1aiv16lwn1rxeDhvg+Fi/LRy5j7zTHkS+hNTH1/hNtb5Hw7MT96KQukR+CDrL9gI8p1z4T6
	1I9HeC4MSSutt0rArm0Hn9AikhZg5krG1ulKyigBz14ZwB3zdaBqeahkFnosdkQUL84CDR6js4M
	M8pEYawkrlhJL4zhwP6axLKEkOv0x08AD0CgePZedIiuvbm7aVz5ipZNosKQk/bYf8P0+IhUlfz
	eBHMSmpucdRj808Q8mBInccUmsn/HjHN4QnEl07lD0juzfJtik7mZfhK2yzXFtOO84P6dCb1ijW
	/qqoo6+nZh9uZoo6nD6dbnx/MrQWQ5sszatTmpblZipxK4CsOpZj8eokuxwxnkiycMOpYTgnrqo
	F3XHd8WNRmKgbI0xsyWB/aJXA=
X-Received: by 2002:a05:6a20:9190:b0:3c0:b55a:80ff with SMTP id adf61e73a8af0-3cbce8d8b83mr11787556637.24.1786260559132;
        Sun, 09 Aug 2026 00:29:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:9190:b0:3c0:b55a:80ff with SMTP id adf61e73a8af0-3cbce8d8b83mr11787518637.24.1786260558640;
        Sun, 09 Aug 2026 00:29:18 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:29:18 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 12:57:14 +0530
Subject: [PATCH 15/15] ARM: dts: qcom: Add initial device tree for Kuno SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-kuno-soc-support-v1-15-5e0ede4a0c72@oss.qualcomm.com>
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=12116;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=jBYWnprPWiHXi7mypvqXh+amEM9e3+4E0GWt9HZDUCw=;
 b=14137EW0nrV31ozCKIyGp5j7JSkFfbrh7XfEW00MiAsWXhG8WjrSxLEu7J6fP7MtniKuWMmMb
 IcIsUhieMJRCG6YPdBLdryxxnNdEqaSUCN/ilId78U9SXNbmbADFzSd
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: hyXMwBm_UuBjxGhvZv3J3l3dqRSJFcNr
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a782c50 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=lKFnvmfiA1OmcLezn0cA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: hyXMwBm_UuBjxGhvZv3J3l3dqRSJFcNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX3UWq6SsW6S+Z
 sqgKgXok6etiHpqE2+xdGR+lWze+9lwK+HhOf9oUtL9Nt55uI5YFcMzCSQWdaUZKQ4FiR72qs2y
 kSjdzC9s8X/CQPF3pCpGDfsw0nMD/lJwHvEo+kiiVPAxnovfHz9X493/FWHfw8yO2n0MX+1LrzQ
 9piJw0ns2inzljQJMJRnatmZ1qpkSxFLLD5NcDv/v2diT79a9YARdRy7PXwFKBj1gV+jJkZhAT3
 LhifJnOFO1c4WUeKhTmRuA5wG96hJDuTHF8sqaQkAxCVUNSTuVRw30yocT4LKWqMKx8cEreOAuD
 MhkNytWfcO17ISl1BRK8cJNxIzb1YpUDiYWp2BqO2qM1ELl3BFDXdMA1P38P+X6LRZg1WXBpV76
 WiJmK/mf3K+c/ZFbGexgoCiBJ+GIejiHcYvaR/MatB6duAi+jsYx6YfCOHEPvDvN4nkc3sHdWzI
 ROpeKlOkbGcfnU056yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX0Pen1HxG50oL
 iCqYexssh5+kgL5puupSVVQ9/vB0EkrgVgOJnjcxR7g5CIFaB2Nqj0W8W8FZYnUPURCv7nhd/D3
 O8WoUE9sQ0VCMW9Z57JwHAsAWg5Rohk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
(qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.

Peripherals included in this initial set:
  - Single Cortex-A7 CPU with PSCI idle states
  - RPMh RSC with clock controller, power domains, and BCM voter
  - GCC (Global Clock Controller)
  - TLMM pin controller (110 GPIOs)
  - Interconnect (aggre-noc, cnoc-main)
  - GENI UART console (QUP SE3)
  - SMEM, hardware spinlocks (TCSR mutex)

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/Makefile          |   1 +
 arch/arm/boot/dts/qcom/qcom-kuno-idp.dts |  25 ++
 arch/arm/boot/dts/qcom/qcom-kuno.dtsi    | 423 +++++++++++++++++++++++++++++++
 3 files changed, 449 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 026d5b682b2b..7327a7b8180e 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq4019-ap.dk07.1-c2.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-ipq8064-rb3011.dtb \
+	qcom-kuno-idp.dtb \
 	qcom-msm8226-microsoft-dempsey.dtb \
 	qcom-msm8226-microsoft-makepeace.dtb \
 	qcom-msm8226-microsoft-moneypenny.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-kuno-idp.dts b/arch/arm/boot/dts/qcom/qcom-kuno-idp.dts
new file mode 100644
index 000000000000..c2f6650d3fe6
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-kuno-idp.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include "qcom-kuno.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Kuno IDP";
+	compatible = "qcom,kuno-idp", "qcom,kuno";
+
+	aliases {
+		serial0 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-kuno.dtsi b/arch/arm/boot/dts/qcom/qcom-kuno.dtsi
new file mode 100644
index 000000000000..073dda34e188
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-kuno.dtsi
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/clock/qcom,kuno-gcc.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom,rpmhpd.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	pcie_phy: clock-100000000 {
+		compatible = "fixed-clock";
+		clock-frequency = <100000000>;
+		#clock-cells = <0>;
+	};
+
+	sleep_clk: clock-32000 {
+		compatible = "fixed-clock";
+		clock-frequency = <32000>;
+		#clock-cells = <0>;
+	};
+
+	xo_board: clock-38400000 {
+		compatible = "fixed-clock";
+		clock-frequency = <38400000>;
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&little_cpu_sleep_0>, <&little_cpu_sleep_1>;
+			power-domains = <&cpu_pd0>;
+			power-domain-names = "psci";
+		};
+	};
+
+	domain-idle-states {
+		cluster_sleep_0: cluster-sleep-0 {
+			compatible = "domain-idle-state";
+			idle-state-name = "cx-min";
+			entry-latency-us = <750>;
+			exit-latency-us = <2350>;
+			min-residency-us = <9144>;
+			arm,psci-suspend-param = <0x40000008>;
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-kuno", "qcom,scm";
+		};
+	};
+
+	idle-states {
+		entry-method = "psci";
+
+		little_cpu_sleep_0: cpu-sleep-0 {
+			compatible = "arm,idle-state";
+			idle-state-name = "standalone-pc";
+			entry-latency-us = <350>;
+			exit-latency-us = <450>;
+			min-residency-us = <1774>;
+			arm,psci-suspend-param = <0x40000003>;
+			local-timer-stop;
+		};
+
+		little_cpu_sleep_1: cpu-sleep-1 {
+			compatible = "arm,idle-state";
+			idle-state-name = "pc";
+			entry-latency-us = <550>;
+			exit-latency-us = <750>;
+			min-residency-us = <6700>;
+			arm,psci-suspend-param = <0x40000004>;
+			local-timer-stop;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		cpu_pd0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&cluster_pd>;
+		};
+
+		cluster_pd: power-domain-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_sleep_0>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		quickboot@82100000 {
+			reg = <0x82100000 0x100000>;
+			no-map;
+		};
+
+		aop-image@82200000 {
+			reg = <0x82200000 0x20000>;
+			no-map;
+		};
+
+		aop-cmd-db@82220000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x82220000 0x20000>;
+			no-map;
+		};
+
+		aop-config@82240000 {
+			reg = <0x82240000 0x20000>;
+			no-map;
+		};
+
+		uefi-log@82260000 {
+			reg = <0x82260000 0x10000>;
+			no-map;
+		};
+
+		ipa-fw@82270000 {
+			reg = <0x82270000 0x10000>;
+			no-map;
+		};
+
+		smem@82280000 {
+			compatible = "qcom,smem";
+			reg = <0x82280000 0xc0000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+		tme-crashdump@82340000 {
+			reg = <0x82340000 0x40000>;
+			no-map;
+		};
+
+		tme-log@82380000 {
+			reg = <0x82380000 0x4000>;
+			no-map;
+		};
+
+		access-control-db@82384000 {
+			reg = <0x82384000 0x40000>;
+			no-map;
+		};
+
+		secdata@823c4000 {
+			reg = <0x823c4000 0x1000>;
+			no-map;
+		};
+
+		modem-efs@823c5000 {
+			reg = <0x823c5000 0x10000>;
+			no-map;
+		};
+
+		cpucp-fw@82400000 {
+			reg = <0x82400000 0x80000>;
+			no-map;
+		};
+
+		xbl-dt-log@824c0000 {
+			reg = <0x824c0000 0x20000>;
+			no-map;
+		};
+
+		qtee@82500000 {
+			reg = <0x82500000 0x180000>;
+			no-map;
+		};
+
+		trusted-apps@82680000 {
+			reg = <0x82680000 0x600000>;
+			no-map;
+		};
+
+		mpss-audio@82e00000 {
+			reg = <0x82e00000 0x5a00000>;
+			no-map;
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0xffffffff>;
+
+		gcc: clock-controller@80000 {
+			compatible = "qcom,kuno-gcc";
+			reg = <0x00080000 0x1f4200>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>,
+				 <&pcie_phy>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		qup0: geniqup@9c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x009c0000 0x2000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0x0 0x1000000>;
+
+			uart3: serial@98c000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x0098c000 0x0 0x4000>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&uart_console_active>;
+				pinctrl-1 = <&uart_console_sleep>;
+				pinctrl-names = "default", "sleep";
+
+				status = "disabled";
+			};
+		};
+
+		cnoc_main: interconnect@1580000 {
+			compatible = "qcom,kuno-cnoc-main";
+			reg = <0x01580000 0x19200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre_noc: interconnect@1640000 {
+			compatible = "qcom,kuno-aggre-noc";
+			reg = <0x01640000 0x33400>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01f40000 0x40000>;
+			#hwlock-cells = <1>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,kuno-pdc", "qcom,pdc";
+			reg = <0x0b220000 0x10000>;
+			qcom,pdc-ranges = <1 148 6>,
+					  <9 156 2>,
+					  <17 164 7>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
+		restart@c264000 {
+			compatible = "qcom,pshold";
+			reg = <0x0c264000 0x1000>;
+		};
+
+		tlmm: pinctrl@f000000 {
+			compatible = "qcom,kuno-tlmm";
+			reg = <0x0f000000 0x400000>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 110>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			uart_console_active: uart-console-active-state {
+				pins = "gpio8", "gpio9";
+				function = "qup0_se3_mira";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			uart_console_sleep: uart-console-sleep-state {
+				pins = "gpio8", "gpio9";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+		};
+
+		intc: interrupt-controller@17000000 {
+			compatible = "qcom,msm-qgic2";
+			reg = <0x17000000 0x1000>,
+			      <0x17002000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		timer@17020000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x17020000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			frame@17021000 {
+				reg = <0x17021000 0x1000>,
+				      <0x17022000 0x1000>;
+				frame-number = <0>;
+				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		apps_rsc: rsc@17040000 {
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x17040000 0x10000>,
+			      <0x17050000 0x10000>,
+			      <0x17060000 0x10000>;
+			reg-names = "drv-0",
+				    "drv-1",
+				    "drv-2";
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     /* drv-1: placeholder (unused) */
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS 2>,
+					  <SLEEP_TCS 3>,
+					  <WAKE_TCS 3>,
+					  <CONTROL_TCS 1>;
+			power-domains = <&cluster_pd>;
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,kuno-rpmh-clk";
+				clocks = <&xo_board>;
+				clock-names = "xo";
+				#clock-cells = <1>;
+			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,kuno-rpmhpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp1 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp2 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs: opp3 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_svs: opp4 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l1: opp5 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp6 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp7 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp8 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp9 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp10 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};

-- 
2.43.0

