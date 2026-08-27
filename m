Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391548550E
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848839; cv=none; b=HqRBrJN4XHhzEchJa5/JhYopYIaaX5tX1ce+4qZV0FVdFRwBEJ1/gQb9eMrgQyDkyKxvaD2aCJaKmp40qRrDbQHtMsUZHAPjQj/kzGO+45NsDtr3M2M3ySO9rup2oitxdg9RyZ20319nNtoGWFudAOWxB3kyTlIWTs7JWfjO5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848839; c=relaxed/simple;
	bh=VMPk8iPi43dEtmYkKXt01Gm+7aUp6TmVF3AL6pfOShE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mc4yhM3ihKKsenkASZkUoziT6UqW9KcWz4yoF5iHJDZ7Semy28Iog4Wq7LXEvK+RYKRyFJtxdVJtf51QcDuU39fOcLsl2FUYvnPvlblGNJEZ5j0ZTYURCy2iqzlTMBFNlhrh5col9vlhxaxZY6/TwWXxI67+9C9oXdZANtmdU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZIz7gNZh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XFwUxMkY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIz7gNZh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XFwUxMkY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbh3I865952
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1CyKk8AZ6pREhlf/bx2YZm9z4JF80rBaz1RtOIA/3FU=; b=ZIz7gNZhskc8aILc
	bxHHRGHVCTVHcxR+fdwonbQlkc2xMG6Bj5l1Ww4O65Rv23O0ZsETh+185LDlOiIZ
	dwH80625bwDxPNGfd89YQnldI+qBE3j1KpCkhr+achh4lz/lMMsJHCXjAuYtvx/t
	gNVxzl3rvOomBl0lHWgzGQZVra/2MKlPOMrzxUiVLlcRI3V8gkZCyW9CsKfjE5c3
	lUEUvSAnxKtL6jSbZKCS57SqfFExVlb5+aZTHFMHCC6WcCI+wH7usBq1tJYMggck
	aT+SG/rGUpcU61SgW+NGd6FJzusQ8ui6ASFz2j/rs/4hwPDNRaaNGebQWfPuFIc8
	84Fb9A==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgv8rkf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:40:36 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7f4e52682f0so152871a34.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848836; x=1788453636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CyKk8AZ6pREhlf/bx2YZm9z4JF80rBaz1RtOIA/3FU=;
        b=XFwUxMkYJokW74lkZ5o/78L/CMoOfuEjcrv2MCkLSjWtz5GNXIIPjuPeBHwgz/Y8+d
         IWgjIW5eC4vqyzauEZ/pP9IUopztL/vlwqYtRTDJz8nxIzNmUZ+YuZL7YGtIk44pfdIs
         AqDJPWwhgPPsHeaUDybIaPd++dd6vJZKKaQKDHvdJGv9KTa5t278Etu9i7R56WHkqvRq
         WO4Y4DpJiCZAm02Fg1EydtQoptPbZkR892WifxOJz2c2d3bWLoDfS+phJS0G+XBKBeZm
         k6i7oiL8QFPdAUZWm/X8ooOJFSPo/O1Jlb0DCUHoxs45m+uvIchEBAsKklx0VpNQWlE6
         JTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848836; x=1788453636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CyKk8AZ6pREhlf/bx2YZm9z4JF80rBaz1RtOIA/3FU=;
        b=LSN80rYkOHyqQzWFdeYKS/jbQdb1Mlgvnw+2ZIT3dy/ycxmZMleeoewjKWyMvGYHiS
         0ZEl0XuZsj74QUZhxcQP7S8XqgHN4V+GJBahKi8+/TWDh1aU6pXlyfFzej+1fmiYOa+d
         8VHm+pSaZFF3jPEWzkTVT2s+kkZjwnQ6IqRNPMrij1j4iuVGIM50EYNDr6ce1KSSeon3
         01HteVlgUYVMTYNM61ddUNiUErKJO+S8jDLMrMb8EkZykUxu3l06Ce1vavEoBk1RAv8v
         fRUjIC2t5vtuklOe+IE8H9jfKt6KG2a6o70iz1L3gZd+Zzzpu9XPoFqPJrY22NIHCSbL
         Y4cQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWQQMVILBmrGGCofWI36C6TlGlpUo6Pw0634K6Z7DHUodA2CQmSFoiG3si4Rz3jQgr9fZhegBZOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nSqaPrNUNKlw2rlHJZaL3O3gOytJHeSZYP7S8qGhom2/NqW7E4
	emRD1VsQ0Ex8sx7X3tJo9+yU5Twhl3iZ2wadIvFccKufZU0DRNnRVxz0AhrUOVAWmF3yAL4bnTx
	EEQgN8eRi8EKAkUxEQCn/86u80ub2atTAsszbeWMUQI0DGQlsZhb4F2UCSjruSg==
X-Gm-Gg: AR+sD10kZEe8+BTNhElxRyrXShhr30Bl/EmmrtkhI0yIfv1y032sYT8oMKRuxuGm+dz
	UIWoAuWXrADGa6Pv0EX2MSbZH+Vr5VEdk+IBPQ1Fepib/N648aJrTWNSwPJ4uMoeTkImpatAToR
	0QVZLiI7ogFZ4zlQ+rsg6SepJL3zQWQRDppop0i0783rfpevesUG6WwgrI5jkN0nJbwTxlkv+Xo
	L0l0ZNxRS9u/iUw7BRTOKYAKpx/NkRM3WckAl6s48QRVsk61qb23Sh8icri2eQN6GkqgTksgNXI
	yOuyvahyVika0kCsAEDqrjcupGMR0ZN3UvtK/pxfeZw1UuXa5QvGxruJ6vtp4o3CvV9x/wZ5GqD
	pvS8cdO58yMIKiQjumZfIuHWjzeJKmCWBnMDkTDxvFJpYKXQiDWIUvqumFllps9tyU7hSkk5Mf1
	zQX5cTs7wwI4u4uqDXf8LYZ28=
X-Received: by 2002:a05:6820:618:b0:6a0:f44b:1265 with SMTP id 006d021491bc7-6b1a035e476mr14878594eaf.4.1787848835996;
        Thu, 27 Aug 2026 09:40:35 -0700 (PDT)
X-Received: by 2002:a05:6820:618:b0:6a0:f44b:1265 with SMTP id 006d021491bc7-6b1a035e476mr14878512eaf.4.1787848835490;
        Thu, 27 Aug 2026 09:40:35 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:40:35 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 22:08:16 +0530
Subject: [PATCH v4 15/15] ARM: dts: qcom: Add initial device tree for Kuno
 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v4-15-dd34f235fc1a@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=12320;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=VMPk8iPi43dEtmYkKXt01Gm+7aUp6TmVF3AL6pfOShE=;
 b=SPbz05t3R8boKbDajcmBt7Z66jqziTESt5X5RZnlljA91R+TkwG0nj3SOxGLNyD7pHFtzTe+y
 AZbRkSgMRSQBlNcf+1WEz/9RZpp8mj8iI7RVY+T2Vzb1gFRsNQzPeoB
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: 5clDwp5RyooLxs79cg4BXJOH8g6siHGl
X-Proofpoint-GUID: 5clDwp5RyooLxs79cg4BXJOH8g6siHGl
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a906885 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=lKFnvmfiA1OmcLezn0cA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX11wNCfR4ZV49
 1BZ4ux+gyUEhv9/6dsOdSEGtQoGkNOICyxPe6M1kxdCq3BS5rgHqmGP4UB77tvXRPwEXksQgqyv
 NCYA8deXyoYaVM72nLWRuKcssYpZCkflQxAIDcTLwpZJOh77sTglRNKVJOJUfHWNTyz44SmxUWN
 v/+ZN7uenM8DzlfbhbxYWdC0odRgW+MUPaqynkwqwrOVHEUh3t+lVtjJvECqUZqNKziWiPG41Fs
 isu8qi2yexYhqsviGB5FblE6cHlBu9q+muV5u9kskfm+n/XIdgiVVD8LsMx0JZnWAz3sRw86obj
 iBCyj3u8VRL92poUPwyL48fbFix/CDJGVsYYYgZ2P01/Rv+PRL0n1mmq1RnunvnfPYzXwZ36D94
 Hk8kk6Y9Jaf/kBc2r5J3qtwGYSP3RUpnDcakJ22ndtYHzJkpzn/j13C/KNt4gM/Dz1t/YXNqSBD
 +NLH0z20czEJwl+EbGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX1tazIUANSaUh
 IBHuyk4R7cO7M0gJ+CleH/A6ecf8o0btFjf7AwO0VczRZZlZrX7+JJhcY+0b7X1OamA84EI2FR1
 BH+3qWKZ5EIlzmDUtQwsLaogvf9qrpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
index 000000000000..d0c6e3f21a14
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
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <38400000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
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
+			cpu-idle-states = <&little_cpu_sleep_0>,
+					  <&little_cpu_sleep_1>;
+			power-domains = <&cpu_pd0>;
+			power-domain-names = "psci";
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			little_cpu_sleep_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-pc";
+				entry-latency-us = <350>;
+				exit-latency-us = <450>;
+				min-residency-us = <1774>;
+				arm,psci-suspend-param = <0x40000003>;
+				local-timer-stop;
+			};
+
+			little_cpu_sleep_1: cpu-sleep-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "pc";
+				entry-latency-us = <550>;
+				exit-latency-us = <750>;
+				min-residency-us = <6700>;
+				arm,psci-suspend-param = <0x40000004>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			cluster_sleep_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				idle-state-name = "cx-min";
+				entry-latency-us = <750>;
+				exit-latency-us = <2350>;
+				min-residency-us = <9144>;
+				arm,psci-suspend-param = <0x40000008>;
+			};
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-kuno", "qcom,scm";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* Bootloader will fill base and size */
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
+				 <0>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
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
+			clocks = <&gcc GCC_SYS_NOC_USB_SF_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
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

