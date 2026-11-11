Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391266;
	b=jBWp8C2YnBYsksYjlv+lLoOowcszGIaw4/R1aWRDP4Hs+V151nOzk/EY4wxvv9wHzYuh
	 3ge9mupZS8VwdTpmSBWxF3Tn6DK8J32xrjYLM91pMmHFE9vCyiqHD0+K89v7tCJvq36YD
	 QSCYBm+Ad+xSAkp18VRvmyv2mTP+q0Fic7BaF1Rb9Hkbv6b2fyTPf6/tpw3aIo4o2qm9n
	 XQsjNv6ixVZa+d+jcZ5VJMGCYw/zCsh/q6Z3XK3+iOuW4H7M6Aahq2fbOAGX5tGFXApp0
	 FbXxb5CeYhufjXkOPLLXgbvXaTwFFfAAhUCtWAfcCxm2hJ8iPAFYw1/sdpytWgydzjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391266;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=E6I5CrtUTnBfJkJUwBJl53e7/2dYuooUxycyuea+tYo=;
	b=QLURyRrRvvc5J2kaaSUcKIWGcNi1G9ZyWCyfWdfthaYRuUsw5SPYUYVdZA2pnofFvTXV
	 9uZDMlWqRyIEywRD+Qa/KIB135j8ZYU8o7I6CUx1RuilqAcFpe8WQTNUIpW6AgWeIFIa0
	 UKWVB7N+hiElgL4d2mDniVXddGrdm/qgujlgwYD+QqdIgKRaspyi17ZkTlEeTUCg+itaG
	 WEOuJkq0fHzdJmvbLQH7fylRXPwpcjGWBgPb0M3jip2Lw1oDM+ekJWxj/vHIhqWoVnxaw
	 a4oeYj3zEZMD/5tu70hzJZY+wAhTPCySq9g4LUnOvOlSX4ThRKGpMdejXH1VjfTA7Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XtI1ioKo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ijsxw+zN;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629760A5BC2
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3629760A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XtI1ioKo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ijsxw+zN
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KPSC864185
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E6I5CrtUTnBfJkJUwBJl53e7/2dYuooUxycyuea+tYo=; b=XtI1ioKoqMl2BG9C
	Gap2EWu+S9eRiEBlHaTD6LTUCfCqIe0gtHrEa+YRcNO2ZGJzv9JW0eyHhMUnV0Ud
	gyd+NcPlpanFmaw65arvOw/g3QJoRrjF731P0p9DiCusRAzaWFipMGRiHBwILPsB
	sbjPNI5SXfpbIipxll2bDI5lZYz3bTZdT9jOdN5NPHAQLfe793K6h1XYQoJR9sIS
	GkYFSSAoKXOgrJL3+q5+p/xkilOvBj5udLw1CPMYYlZgaKip3cVS0hvbCfOwpKyI
	JOpM8Z27K3s5KDPRbVSQs+oBI8Ncs7BkCmr4AAuYpmRDa1nUnsrf3TLnuklDmO5G
	BHi6oA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawhmf7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:01:04 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c55ba309c2so3646269b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 02:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794391264; x=1794996064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6I5CrtUTnBfJkJUwBJl53e7/2dYuooUxycyuea+tYo=;
        b=ijsxw+zN463rlQCtMzFe+ZXp8GYuL8CoT9ZQDxwadeYQ85Au2bHlFzdCr9BpHoGQwS
         Tu4meyMwxUKFxY6cb5bvlqGiZm7d+Ut9Dauz1zIY5WPtUT/oUOBRxKn07R3pggfqn9w4
         wYSqAzO0ZGbWvrY6e3WLGRAhVr/abdu07Cp6O0CSXLfayuY1AYKBskFlXU/Zue7/Ki3c
         RE8kV1mRe7y1ey5ywnd0OzfvwWJXSCOoxC3J7cP2H3dxOO76BFyPENmQH70DoxOUknBA
         XSGF7WjIzJHoMsBMA2jdmHph1gPNGT3w6bccHcKvcMLULk08WoLECXu+c/UPFodNs8du
         CY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794391264; x=1794996064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6I5CrtUTnBfJkJUwBJl53e7/2dYuooUxycyuea+tYo=;
        b=ofLY6QYfRJwK10hjtCuTVgZ7xmlXwQCY9obgTLbg49Dwg1gh/xJ0WDDjjxXeuanmEL
         UGb8YzIbD8fnkLYSxU0hpOfIPyiSath3bb7xQ0WGUawyLJrOehfsttAUQjciVVlFYEt3
         uT1rsq2cWL00KUKVNSQJFuiYF2JJBXOU3HhxoweHfQx7zz64foa8L+b+YxGTGg6lqQW0
         idWz4pw90ErI6+wX857bAiN/QdWFNn+WVPtg+TibR8gxlFj/HMvY7TIwnH87OB4aH+ON
         cHTh88a/XD+CHfUAu1Rh3mJkLJFeZa+Lre76ChCCp/riegOGDcXVuuZTBRNnHUxAJ9mD
         RNHw==
X-Forwarded-Encrypted: i=1; AL+hErHnHRuA/bu0M8aZIliNgjKTPiSBSKkVnqSsGdMWU22Z20O1n6LM3m9YSgiYz80TXTj5+kD+uo9PjQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/BchGe+hcWrBSV0BaVyFlkgUSX9exSs2skZgMvJnsNzAx/4Gl9
	+rq1xhueOPbxnV6lWqicWO0GhNWqK22iwlpcj3kZUVMRd7dsxR57fhcpyX0WfCIdOHIpUHImFpo
	RLB3IBo4S/vRiaRC11aJqnmDi0ISLVm5xUlidj3SSFGbXYFOHP/R0bNcUcOc7zg==
X-Gm-Gg: AYBFou0v5ea/1iyqerqjeCbPMm8Mum2kYr6o3eqmjQu7YaHKP7QfxoAFvjh88Z1FC1Y
	sEwnmghK75uD23o+MOBiteq+cSQOIdDOeoMR6DDBnXgjssh5TijK3fc6E2qW8OGXdCCF1Bk/ixe
	00GltWo3mu7pvlFG4dYVjGCEyhmcI1rPyP+WcGP3FwbJn7y9C+jFRAgcH62vP3VTusTsJu4Q2IL
	8/wpgj2lHtCeka6OcPl7k9aSp7PWSb73OAXioPDVVBMbnAgUIMyB7KFDiLWZ25Jp0GZ0FwScnJy
	NXaifJ8GR6aLse+qL5kwX1VZI1ny0DNu+lhuxIKKXf2pH2QO/JeRPKL+/L/BdPoz0RWDLoPQe/X
	OYiV2FWT/h5VKBVgNRvj1NA3gSq2keEagbta6B/M8FG2lcd/2FtoX6Ivdv1ZK0AwP7JJ3eM41kt
	/aiFWRS83EZiBCufyO
X-Received: by 2002:a05:6808:3a0e:b0:564:5fe0:dd76 with SMTP id 5614622812f47-56b968d6bedmr1556600b6e.18.1794391262629;
        Wed, 11 Nov 2026 02:01:02 -0800 (PST)
X-Received: by 2002:a05:6808:3a0e:b0:564:5fe0:dd76 with SMTP id 5614622812f47-56b968d6bedmr1556549b6e.18.1794391261811;
        Wed, 11 Nov 2026 02:01:01 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm4686111b6e.4.2026.11.11.02.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:01:00 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 02:00:56 -0800
Subject: [PATCH v2 2/3] clk: qcom: Add NSS clock controller driver for
 IPQ5210 SoC
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
Message-Id: <20261111-qcom_ipq5210_nsscc-v2-2-7e2c1dda3ed2@oss.qualcomm.com>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Luo Jie <jie.luo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391255; l=67175;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=cEk+RH1f6ROGByZpGoLvR+Z/Jfx8d+Tf/v5VznF1fdc=;
 b=KD/d56qYgI5+CyT9fTqyvbA3qQri0dgyzE6YFW+nXc7xqPUT3VTLNmXnwDqnJb2hm1jLyy7tH
 KSa0ZkTA2q7BZSfbSMOOe1WlIsEnVVzuV7iCvcl2xq8rxYgNkMM9743
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX36jbuZKFBcRb
 CmNdosGEYjORCAHuWX7+e+2vKSsiRoAXnpu1Rvp8Lop1lujOyThM7qp86gpMS7gmqoA8DvMJnoe
 uFMAw8sl7MvoTiw9qgFcASH8jUPt1ao=
X-Proofpoint-ORIG-GUID: uePe19eFVDSVQociw6LPUyHJWtxbRuEk
X-Proofpoint-GUID: uePe19eFVDSVQociw6LPUyHJWtxbRuEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX1WTvVgl/W4+3
 mpkCwwXeu1HqbRGtQQOf8Nor+F7Zmdy9nrUareUJK9Am1K12NzIqKps7unV71x7ES+n9NRxeM5g
 zKbxcbWx6m4UkrstYWFfJDzjbyMJ/dOM9bkXcRRhqiFbMnEYxAaDYzp39nkzivas67UcTBOHShL
 fgdvvhMHbk2mg3bI58e9iRdyvju0jDTx77TjSIwQ4tl1TZxb/JyWs2wf6ZGuYVdHIjmKvA4E42V
 f/MMxWMPRS3AR/zXjFJ/V+q959Dc037S6PdKmdJisS9/OIRTECFc8PK1oNb4jTt72ORxcbruUDn
 iGnbOsD7uE+zq5bO6Kd+paEH0nQtfvhzP1lNcRKEmkncCLNpjGZzU45xu4GOxmrXkNcC1sdSFMW
 iW2hkQZgzO7LUxgRmtnFkVxsaQexJlY2t/NhZQkRpV8F+PDIT8dctvOwutWJqhKvvITHVZYpTDq
 ZTzr2HLBoKjQ6qj46kg==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af43ce0 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=9NNFwX1Lmsrkzrh2ROEA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110039

The NSS (Network SubSystem) clock controller provides the clocks and resets
to the networking blocks such as PPE (Packet Process Engine), UNIPHY (PCS)
and the integrated Ethernet PHY on IPQ5210 devices.

The icc-clk framework is used to enable NoC related clocks to create paths
so that the networking blocks such as PPE can connect to these NoCs.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig         |   12 +
 drivers/clk/qcom/Makefile        |    1 +
 drivers/clk/qcom/nsscc-ipq5210.c | 2202 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 2215 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e6c58e8b1849..a63f568b1405 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -737,6 +737,18 @@ config IPQ_GCC_9650
 	  i2c, USB, SD/eMMC, etc. Select this for the root clock
 	  of ipq9650.
 
+config IPQ_NSSCC_5210
+	tristate "IPQ5210 NSS Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	depends on IPQ_GCC_5210
+	default m if ARCH_QCOM
+	help
+	  Support for NSS clock controller on ipq5210 devices.
+	  NSSCC receives the clock sources from GCC and CMN PLL.
+	  It in turn supplies the clocks and resets to the networking hardware.
+	  Say Y or M if you want to enable networking function on the
+	  IPQ5210 devices.
+
 config IPQ_NSSCC_5424
 	tristate "IPQ5424 NSS Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index f84d7343a3a4..a0d9b50f2caf 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
 obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
 obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
 obj-$(CONFIG_IPQ_GCC_9650) += gcc-ipq9650.o
+obj-$(CONFIG_IPQ_NSSCC_5210) += nsscc-ipq5210.o
 obj-$(CONFIG_IPQ_NSSCC_5424) += nsscc-ipq5424.o
 obj-$(CONFIG_IPQ_NSSCC_9574)	+= nsscc-ipq9574.o
 obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
diff --git a/drivers/clk/qcom/nsscc-ipq5210.c b/drivers/clk/qcom/nsscc-ipq5210.c
new file mode 100644
index 000000000000..97673d01c956
--- /dev/null
+++ b/drivers/clk/qcom/nsscc-ipq5210.c
@@ -0,0 +1,2202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/interconnect-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,ipq5210-nsscc.h>
+#include <dt-bindings/interconnect/qcom,ipq5210.h>
+#include <dt-bindings/reset/qcom,ipq5210-nsscc.h>
+
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "common.h"
+#include "reset.h"
+
+/* Need to match the order of clocks in DT binding */
+enum {
+	DT_XO,
+	DT_CMN_PLL_NSS_CLK_375M,
+	DT_CMN_PLL_NSS_CLK_429M,
+	DT_GCC_GPLL0,
+	DT_UNIPHY0_NSS_RX_CLK,
+	DT_UNIPHY0_NSS_TX_CLK,
+	DT_UNIPHY1_NSS_RX_CLK,
+	DT_UNIPHY1_NSS_TX_CLK,
+	DT_UNIPHY2_NSS_RX_CLK,
+	DT_UNIPHY2_NSS_TX_CLK,
+	DT_GCC_NSSCC_CLK,
+	DT_EPHY_RX_CLK,
+	DT_EPHY_TX_CLK,
+};
+
+enum {
+	P_XO,
+	P_CMN_PLL_NSS_CLK_375M,
+	P_CMN_PLL_NSS_CLK_429M,
+	P_GCC_GPLL0,
+	P_UNIPHY0_NSS_RX_CLK,
+	P_UNIPHY0_NSS_TX_CLK,
+	P_UNIPHY1_NSS_RX_CLK,
+	P_UNIPHY1_NSS_TX_CLK,
+	P_UNIPHY2_NSS_RX_CLK,
+	P_UNIPHY2_NSS_TX_CLK,
+	P_EPHY_RX_CLK,
+	P_EPHY_TX_CLK,
+};
+
+static const struct parent_map nss_cc_parent_map_ppe_cfg[] = {
+	{ P_XO, 0 },
+	{ P_GCC_GPLL0, 2 },
+};
+
+static const struct parent_map nss_cc_parent_map_ppe[] = {
+	{ P_XO, 0 },
+	{ P_CMN_PLL_NSS_CLK_429M, 6 },
+};
+
+static const struct clk_parent_data nss_cc_ppe_parent_data_ppe_cfg[] = {
+	{ .index = DT_XO },
+	{ .index = DT_GCC_GPLL0 },
+};
+
+static const struct clk_parent_data nss_cc_ppe_parent_data_ppe[] = {
+	{ .index = DT_XO },
+	{ .index = DT_CMN_PLL_NSS_CLK_429M },
+};
+
+static const struct clk_parent_data nss_cc_ppe_parent_data_eip[] = {
+	{ .index = DT_XO },
+	{ .index = DT_CMN_PLL_NSS_CLK_375M },
+};
+
+static const struct parent_map nss_cc_parent_map_port1_3_rx[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY0_NSS_RX_CLK, 3 },
+};
+
+static const struct parent_map nss_cc_parent_map_port1_3_tx[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY0_NSS_TX_CLK, 4 },
+};
+
+static const struct parent_map nss_cc_parent_map_port4_rx[] = {
+	{ P_XO, 0 },
+	{ P_EPHY_RX_CLK, 1 },
+	{ P_UNIPHY0_NSS_RX_CLK, 3 },
+};
+
+static const struct parent_map nss_cc_parent_map_port4_tx[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY0_NSS_TX_CLK, 4 },
+	{ P_EPHY_TX_CLK, 5 },
+};
+
+static const struct clk_parent_data gcc_xo_ephy_uniphy0_rx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_EPHY_RX_CLK },
+	{ .index = DT_UNIPHY0_NSS_RX_CLK },
+};
+
+static const struct clk_parent_data gcc_xo_ephy_uniphy0_tx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY0_NSS_TX_CLK },
+	{ .index = DT_EPHY_TX_CLK },
+};
+
+static const struct clk_parent_data gcc_xo_uniphy0_gcc_rx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY0_NSS_RX_CLK },
+};
+
+static const struct clk_parent_data gcc_xo_uniphy0_gcc_tx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY0_NSS_TX_CLK },
+};
+
+static const struct parent_map nss_cc_parent_map_port5_rx[] = {
+	{ P_XO, 0 },
+	{ P_EPHY_RX_CLK, 1 },
+	{ P_UNIPHY1_NSS_RX_CLK, 3 },
+};
+
+static const struct parent_map nss_cc_parent_map_port5_tx[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY1_NSS_TX_CLK, 4 },
+	{ P_EPHY_TX_CLK, 5 },
+};
+
+static const struct clk_parent_data gcc_xo_ephy_uniphy1_rx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_EPHY_RX_CLK },
+	{ .index = DT_UNIPHY1_NSS_RX_CLK },
+};
+
+static const struct clk_parent_data gcc_xo_ephy_uniphy1_tx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY1_NSS_TX_CLK },
+	{ .index = DT_EPHY_TX_CLK },
+};
+
+static const struct parent_map nss_cc_parent_map_port6_rx[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY2_NSS_RX_CLK, 3 },
+};
+
+static const struct parent_map nss_cc_parent_map_port6_tx[] = {
+	{ P_XO, 0 },
+	{ P_UNIPHY2_NSS_TX_CLK, 4 },
+};
+
+static const struct clk_parent_data gcc_xo_uniphy2_rx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY2_NSS_RX_CLK },
+};
+
+static const struct clk_parent_data gcc_xo_uniphy2_tx[] = {
+	{ .index = DT_XO },
+	{ .index = DT_UNIPHY2_NSS_TX_CLK },
+};
+
+static const struct freq_tbl ftbl_nss_cc_ppe_clk_src[] = {
+	F(24000000, P_XO, 1, 0, 0),
+	F(429000000, P_CMN_PLL_NSS_CLK_429M, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_ppe_clk_src = {
+	.cmd_rcgr = 0x3ec,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_ppe,
+	.freq_tbl = ftbl_nss_cc_ppe_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_ppe_clk_src",
+		.parent_data = nss_cc_ppe_parent_data_ppe,
+		.num_parents = ARRAY_SIZE(nss_cc_ppe_parent_data_ppe),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+/*
+ * The XGMAC PTP reference clock rate needs to be configurable, so the
+ * PTP reference dividers use the writable divider ops.
+ */
+static struct clk_regmap_div nss_cc_xgmac0_ptp_ref_div_clk_src = {
+	.reg = 0x3f4,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac0_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac1_ptp_ref_div_clk_src = {
+	.reg = 0x3f8,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac1_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_xgmac2_ptp_ref_div_clk_src = {
+	.reg = 0x3fc,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_xgmac2_ptp_ref_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_ppe_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_ipe_clk = {
+	.halt_reg = 0x424,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x424,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_ipe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_btq_clk = {
+	.halt_reg = 0x42c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x42c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_btq_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_clk = {
+	.halt_reg = 0x434,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x434,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_switch_cfg_clk = {
+	.halt_reg = 0x43c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x43c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_switch_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_edma_clk = {
+	.halt_reg = 0x440,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x440,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_edma_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ppe_edma_cfg_clk = {
+	.halt_reg = 0x448,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x448,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ppe_edma_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_mac_clk = {
+	.halt_reg = 0x44c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x44c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port1_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_mac_clk = {
+	.halt_reg = 0x454,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x454,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port2_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port3_mac_clk = {
+	.halt_reg = 0x45c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x45c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port3_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port4_mac_clk = {
+	.halt_reg = 0x464,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x464,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port4_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port5_mac_clk = {
+	.halt_reg = 0x46c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x46c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port5_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port6_mac_clk = {
+	.halt_reg = 0x474,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x474,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port6_mac_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_pon_clk = {
+	.halt_reg = 0x47c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x47c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_pon_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac0_ptp_ref_clk = {
+	.halt_reg = 0x488,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x488,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_xgmac0_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_xgmac0_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac1_ptp_ref_clk = {
+	.halt_reg = 0x48c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x48c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_xgmac1_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_xgmac1_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_xgmac2_ptp_ref_clk = {
+	.halt_reg = 0x490,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x490,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_xgmac2_ptp_ref_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_xgmac2_ptp_ref_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ppe_clk = {
+	.halt_reg = 0x4a4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_ppe_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_ppe_cfg_clk = {
+	.halt_reg = 0x4a8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_ppe_cfg_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ppe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port1_3_rx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port1_rx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port1_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+	FMS(378788000, P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port1_rx_clk_src = {
+	.cmd_rcgr = 0x4b4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port1_3_rx,
+	.freq_multi_tbl = ftbl_nss_cc_port1_3_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port1_rx_clk_src",
+		.parent_data = gcc_xo_uniphy0_gcc_rx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_gcc_rx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port1_rx_div_clk_src = {
+	.reg = 0x4bc,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port1_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port1_3_tx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port1_tx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port1_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+	FMS(378788000, P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port1_tx_clk_src = {
+	.cmd_rcgr = 0x4c0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port1_3_tx,
+	.freq_multi_tbl = ftbl_nss_cc_port1_3_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port1_tx_clk_src",
+		.parent_data = gcc_xo_uniphy0_gcc_tx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_gcc_tx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port1_tx_div_clk_src = {
+	.reg = 0x4c8,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port1_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port1_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_rcg2 nss_cc_port2_rx_clk_src = {
+	.cmd_rcgr = 0x4cc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port1_3_rx,
+	.freq_multi_tbl = ftbl_nss_cc_port1_3_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port2_rx_clk_src",
+		.parent_data = gcc_xo_uniphy0_gcc_rx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_gcc_rx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port2_rx_div_clk_src = {
+	.reg = 0x4d4,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port2_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_rcg2 nss_cc_port2_tx_clk_src = {
+	.cmd_rcgr = 0x4d8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port1_3_tx,
+	.freq_multi_tbl = ftbl_nss_cc_port1_3_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port2_tx_clk_src",
+		.parent_data = gcc_xo_uniphy0_gcc_tx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_gcc_tx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port2_tx_div_clk_src = {
+	.reg = 0x4e0,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port2_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port2_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_rcg2 nss_cc_port3_rx_clk_src = {
+	.cmd_rcgr = 0x4e4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port1_3_rx,
+	.freq_multi_tbl = ftbl_nss_cc_port1_3_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port3_rx_clk_src",
+		.parent_data = gcc_xo_uniphy0_gcc_rx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_gcc_rx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port3_rx_div_clk_src = {
+	.reg = 0x4ec,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port3_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port3_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_rcg2 nss_cc_port3_tx_clk_src = {
+	.cmd_rcgr = 0x4f0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port1_3_tx,
+	.freq_multi_tbl = ftbl_nss_cc_port1_3_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port3_tx_clk_src",
+		.parent_data = gcc_xo_uniphy0_gcc_tx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy0_gcc_tx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port3_tx_div_clk_src = {
+	.reg = 0x4f8,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port3_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port3_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port4_rx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 5, 0, 0),
+	C(P_EPHY_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port4_rx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+	C(P_EPHY_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port4_rx_clk_src_312p5[] = {
+	C(P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
+	C(P_EPHY_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port4_rx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port4_rx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port4_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_RX_CLK, 2, 0, 0),
+	FM(312500000, ftbl_nss_cc_port4_rx_clk_src_312p5),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port4_rx_clk_src = {
+	.cmd_rcgr = 0x4fc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port4_rx,
+	.freq_multi_tbl = ftbl_nss_cc_port4_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port4_rx_clk_src",
+		.parent_data = gcc_xo_ephy_uniphy0_rx,
+		.num_parents = ARRAY_SIZE(gcc_xo_ephy_uniphy0_rx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port4_rx_div_clk_src = {
+	.reg = 0x504,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port4_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port4_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port4_tx_clk_src_25[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 5, 0, 0),
+	C(P_EPHY_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port4_tx_clk_src_125[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+	C(P_EPHY_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port4_tx_clk_src_312p5[] = {
+	C(P_UNIPHY0_NSS_TX_CLK, 1, 0, 0),
+	C(P_EPHY_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port4_tx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port4_tx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port4_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY0_NSS_TX_CLK, 2, 0, 0),
+	FM(312500000, ftbl_nss_cc_port4_tx_clk_src_312p5),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port4_tx_clk_src = {
+	.cmd_rcgr = 0x508,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port4_tx,
+	.freq_multi_tbl = ftbl_nss_cc_port4_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port4_tx_clk_src",
+		.parent_data = gcc_xo_ephy_uniphy0_tx,
+		.num_parents = ARRAY_SIZE(gcc_xo_ephy_uniphy0_tx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port4_tx_div_clk_src = {
+	.reg = 0x510,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port4_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port4_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port5_rx_clk_src_25[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY1_NSS_RX_CLK, 5, 0, 0),
+	C(P_EPHY_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port5_rx_clk_src_125[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY1_NSS_RX_CLK, 1, 0, 0),
+	C(P_EPHY_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port5_rx_clk_src_312p5[] = {
+	C(P_UNIPHY1_NSS_RX_CLK, 1, 0, 0),
+	C(P_EPHY_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port5_rx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port5_rx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port5_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_NSS_RX_CLK, 2, 0, 0),
+	FM(312500000, ftbl_nss_cc_port5_rx_clk_src_312p5),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port5_rx_clk_src = {
+	.cmd_rcgr = 0x514,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port5_rx,
+	.freq_multi_tbl = ftbl_nss_cc_port5_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port5_rx_clk_src",
+		.parent_data = gcc_xo_ephy_uniphy1_rx,
+		.num_parents = ARRAY_SIZE(gcc_xo_ephy_uniphy1_rx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port5_rx_div_clk_src = {
+	.reg = 0x51c,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port5_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port5_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port5_tx_clk_src_25[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY1_NSS_TX_CLK, 5, 0, 0),
+	C(P_EPHY_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port5_tx_clk_src_125[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY1_NSS_TX_CLK, 1, 0, 0),
+	C(P_EPHY_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port5_tx_clk_src_312p5[] = {
+	C(P_UNIPHY1_NSS_TX_CLK, 1, 0, 0),
+	C(P_EPHY_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port5_tx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port5_tx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port5_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY1_NSS_TX_CLK, 2, 0, 0),
+	FM(312500000, ftbl_nss_cc_port5_tx_clk_src_312p5),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port5_tx_clk_src = {
+	.cmd_rcgr = 0x520,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port5_tx,
+	.freq_multi_tbl = ftbl_nss_cc_port5_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port5_tx_clk_src",
+		.parent_data = gcc_xo_ephy_uniphy1_tx,
+		.num_parents = ARRAY_SIZE(gcc_xo_ephy_uniphy1_tx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port5_tx_div_clk_src = {
+	.reg = 0x528,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port5_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port5_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port6_rx_clk_src_25[] = {
+	C(P_UNIPHY2_NSS_RX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY2_NSS_RX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port6_rx_clk_src_125[] = {
+	C(P_UNIPHY2_NSS_RX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY2_NSS_RX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port6_rx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port6_rx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port6_rx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_NSS_RX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_NSS_RX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port6_rx_clk_src = {
+	.cmd_rcgr = 0x52c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port6_rx,
+	.freq_multi_tbl = ftbl_nss_cc_port6_rx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port6_rx_clk_src",
+		.parent_data = gcc_xo_uniphy2_rx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_rx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port6_rx_div_clk_src = {
+	.reg = 0x534,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port6_rx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port6_rx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_conf ftbl_nss_cc_port6_tx_clk_src_25[] = {
+	C(P_UNIPHY2_NSS_TX_CLK, 12.5, 0, 0),
+	C(P_UNIPHY2_NSS_TX_CLK, 5, 0, 0),
+};
+
+static const struct freq_conf ftbl_nss_cc_port6_tx_clk_src_125[] = {
+	C(P_UNIPHY2_NSS_TX_CLK, 2.5, 0, 0),
+	C(P_UNIPHY2_NSS_TX_CLK, 1, 0, 0),
+};
+
+static const struct freq_multi_tbl ftbl_nss_cc_port6_tx_clk_src[] = {
+	FMS(24000000, P_XO, 1, 0, 0),
+	FM(25000000, ftbl_nss_cc_port6_tx_clk_src_25),
+	FM(125000000, ftbl_nss_cc_port6_tx_clk_src_125),
+	FMS(156250000, P_UNIPHY2_NSS_TX_CLK, 2, 0, 0),
+	FMS(312500000, P_UNIPHY2_NSS_TX_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_port6_tx_clk_src = {
+	.cmd_rcgr = 0x538,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_port6_tx,
+	.freq_multi_tbl = ftbl_nss_cc_port6_tx_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_port6_tx_clk_src",
+		.parent_data = gcc_xo_uniphy2_tx,
+		.num_parents = ARRAY_SIZE(gcc_xo_uniphy2_tx),
+		.ops = &clk_rcg2_fm_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_port6_tx_div_clk_src = {
+	.reg = 0x540,
+	.shift = 0,
+	.width = 9,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_port6_tx_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port6_tx_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_branch nss_cc_port1_rx_clk = {
+	.halt_reg = 0x548,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x548,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port1_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port1_tx_clk = {
+	.halt_reg = 0x550,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x550,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port1_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_rx_clk = {
+	.halt_reg = 0x558,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x558,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port2_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port2_tx_clk = {
+	.halt_reg = 0x560,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x560,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port2_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port3_rx_clk = {
+	.halt_reg = 0x568,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x568,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port3_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port3_tx_clk = {
+	.halt_reg = 0x570,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x570,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port3_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port4_rx_clk = {
+	.halt_reg = 0x578,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x578,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port4_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port4_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port4_tx_clk = {
+	.halt_reg = 0x580,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x580,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port4_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port4_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port5_rx_clk = {
+	.halt_reg = 0x588,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x588,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port5_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port5_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port5_tx_clk = {
+	.halt_reg = 0x590,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x590,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port5_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port5_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port6_rx_clk = {
+	.halt_reg = 0x598,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x598,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port6_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port6_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_port6_tx_clk = {
+	.halt_reg = 0x5a0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5a0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_port6_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port6_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_rx_clk = {
+	.halt_reg = 0x5e0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5e0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port1_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_tx_clk = {
+	.halt_reg = 0x5e4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port1_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port1_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_rx_clk = {
+	.halt_reg = 0x5e8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port2_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_tx_clk = {
+	.halt_reg = 0x5ec,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5ec,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port2_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port2_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port3_rx_clk = {
+	.halt_reg = 0x5f0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5f0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port3_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port3_tx_clk = {
+	.halt_reg = 0x5f4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5f4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port3_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port3_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port4_rx_clk = {
+	.halt_reg = 0x5f8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5f8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port4_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port4_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port4_tx_clk = {
+	.halt_reg = 0x5fc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5fc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port4_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port4_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port5_rx_clk = {
+	.halt_reg = 0x600,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x600,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port5_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port5_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port5_tx_clk = {
+	.halt_reg = 0x604,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x604,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port5_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port5_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port6_rx_clk = {
+	.halt_reg = 0x608,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x608,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port6_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port6_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port6_tx_clk = {
+	.halt_reg = 0x60c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x60c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port6_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port6_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux nss_cc_ephy_rx_mux_clk_src = {
+	.reg = 0x610,
+	.shift = 0,
+	.width = 1,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ephy_rx_mux_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port4_rx_div_clk_src.clkr.hw,
+				&nss_cc_port5_rx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 2,
+			.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ephy_rx_clk = {
+	.halt_reg = 0x618,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x618,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ephy_rx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ephy_rx_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux nss_cc_ephy_tx_mux_clk_src = {
+	.reg = 0x614,
+	.shift = 0,
+	.width = 1,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "nss_cc_ephy_tx_mux_clk_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_port4_tx_div_clk_src.clkr.hw,
+				&nss_cc_port5_tx_div_clk_src.clkr.hw,
+			},
+			.num_parents = 2,
+			.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_ephy_tx_clk = {
+	.halt_reg = 0x61c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x61c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_ephy_tx_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_ephy_tx_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port1_rx_div4_clk_src = {
+	.reg = 0x624,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port1_rx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port1_rx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port1_tx_div4_clk_src = {
+	.reg = 0x628,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port1_tx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port1_tx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port2_rx_div4_clk_src = {
+	.reg = 0x62c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port2_rx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port2_rx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port2_tx_div4_clk_src = {
+	.reg = 0x630,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port2_tx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port2_tx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port3_rx_div4_clk_src = {
+	.reg = 0x634,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port3_rx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port3_rx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port3_tx_div4_clk_src = {
+	.reg = 0x638,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port3_tx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port3_tx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port4_rx_div4_clk_src = {
+	.reg = 0x63c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port4_rx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port4_rx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_regmap_div nss_cc_uniphy_port4_tx_div4_clk_src = {
+	.reg = 0x640,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "nss_cc_uniphy_port4_tx_div4_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&nss_cc_port4_tx_div_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_rx_div4_clk = {
+	.halt_reg = 0x644,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x644,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port1_rx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port1_rx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port1_tx_div4_clk = {
+	.halt_reg = 0x648,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x648,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port1_tx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port1_tx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_rx_div4_clk = {
+	.halt_reg = 0x64c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x64c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port2_rx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port2_rx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port2_tx_div4_clk = {
+	.halt_reg = 0x650,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x650,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port2_tx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port2_tx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port3_rx_div4_clk = {
+	.halt_reg = 0x654,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x654,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port3_rx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port3_rx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port3_tx_div4_clk = {
+	.halt_reg = 0x658,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x658,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port3_tx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port3_tx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port4_rx_div4_clk = {
+	.halt_reg = 0x65c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x65c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port4_rx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port4_rx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_uniphy_port4_tx_div4_clk = {
+	.halt_reg = 0x660,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x660,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_uniphy_port4_tx_div4_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_uniphy_port4_tx_div4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_nss_cc_eip_bfdcd_clk_src[] = {
+	F(375000000, P_CMN_PLL_NSS_CLK_375M, 1, 0, 0),
+	{ }
+};
+
+static const struct parent_map nss_cc_parent_map_eip[] = {
+	{ P_XO, 0 },
+	{ P_CMN_PLL_NSS_CLK_375M, 5 },
+};
+
+static struct clk_rcg2 nss_cc_eip_bfdcd_clk_src = {
+	.cmd_rcgr = 0x6a8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_eip,
+	.freq_tbl = ftbl_nss_cc_eip_bfdcd_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_eip_bfdcd_clk_src",
+		.parent_data = nss_cc_ppe_parent_data_eip,
+		.num_parents = ARRAY_SIZE(nss_cc_ppe_parent_data_eip),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch nss_cc_eip_clk = {
+	.halt_reg = 0x6bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_eip_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_eip_bfdcd_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_eip_clk = {
+	.halt_reg = 0x6c4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6c4,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_eip_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_eip_bfdcd_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_nss_cc_cfg_clk_ppe_cfg[] = {
+	F(100000000, P_GCC_GPLL0, 8, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 nss_cc_cfg_clk_src = {
+	.cmd_rcgr = 0x70c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = nss_cc_parent_map_ppe_cfg,
+	.freq_tbl = ftbl_nss_cc_cfg_clk_ppe_cfg,
+	.clkr.hw.init = &(const struct clk_init_data){
+		.name = "nss_cc_cfg_clk_src",
+		.parent_data = nss_cc_ppe_parent_data_ppe_cfg,
+		.num_parents = ARRAY_SIZE(nss_cc_ppe_parent_data_ppe_cfg),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch nss_cc_nss_csr_clk = {
+	.halt_reg = 0x714,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x714,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nss_csr_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_cfg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch nss_cc_nssnoc_nss_csr_clk = {
+	.halt_reg = 0x718,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x718,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data){
+			.name = "nss_cc_nssnoc_nss_csr_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_cc_cfg_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *nss_cc_ipq5210_clocks[] = {
+	[NSS_CC_PPE_CLK_SRC] = &nss_cc_ppe_clk_src.clkr,
+	[NSS_CC_PPE_SWITCH_IPE_CLK] = &nss_cc_ppe_switch_ipe_clk.clkr,
+	[NSS_CC_PPE_SWITCH_BTQ_CLK] = &nss_cc_ppe_switch_btq_clk.clkr,
+	[NSS_CC_PPE_SWITCH_CLK] = &nss_cc_ppe_switch_clk.clkr,
+	[NSS_CC_PPE_SWITCH_CFG_CLK] = &nss_cc_ppe_switch_cfg_clk.clkr,
+	[NSS_CC_PPE_EDMA_CLK] = &nss_cc_ppe_edma_clk.clkr,
+	[NSS_CC_PPE_EDMA_CFG_CLK] = &nss_cc_ppe_edma_cfg_clk.clkr,
+	[NSS_CC_PORT1_MAC_CLK] = &nss_cc_port1_mac_clk.clkr,
+	[NSS_CC_PORT1_RX_CLK] = &nss_cc_port1_rx_clk.clkr,
+	[NSS_CC_PORT1_RX_CLK_SRC] = &nss_cc_port1_rx_clk_src.clkr,
+	[NSS_CC_PORT1_RX_DIV_CLK_SRC] = &nss_cc_port1_rx_div_clk_src.clkr,
+	[NSS_CC_PORT1_TX_CLK] = &nss_cc_port1_tx_clk.clkr,
+	[NSS_CC_PORT1_TX_CLK_SRC] = &nss_cc_port1_tx_clk_src.clkr,
+	[NSS_CC_PORT1_TX_DIV_CLK_SRC] = &nss_cc_port1_tx_div_clk_src.clkr,
+	[NSS_CC_PORT2_MAC_CLK] = &nss_cc_port2_mac_clk.clkr,
+	[NSS_CC_PORT2_RX_CLK] = &nss_cc_port2_rx_clk.clkr,
+	[NSS_CC_PORT2_RX_CLK_SRC] = &nss_cc_port2_rx_clk_src.clkr,
+	[NSS_CC_PORT2_RX_DIV_CLK_SRC] = &nss_cc_port2_rx_div_clk_src.clkr,
+	[NSS_CC_PORT2_TX_CLK] = &nss_cc_port2_tx_clk.clkr,
+	[NSS_CC_PORT2_TX_CLK_SRC] = &nss_cc_port2_tx_clk_src.clkr,
+	[NSS_CC_PORT2_TX_DIV_CLK_SRC] = &nss_cc_port2_tx_div_clk_src.clkr,
+	[NSS_CC_PORT3_MAC_CLK] = &nss_cc_port3_mac_clk.clkr,
+	[NSS_CC_PORT3_RX_CLK] = &nss_cc_port3_rx_clk.clkr,
+	[NSS_CC_PORT3_RX_CLK_SRC] = &nss_cc_port3_rx_clk_src.clkr,
+	[NSS_CC_PORT3_RX_DIV_CLK_SRC] = &nss_cc_port3_rx_div_clk_src.clkr,
+	[NSS_CC_PORT3_TX_CLK] = &nss_cc_port3_tx_clk.clkr,
+	[NSS_CC_PORT3_TX_CLK_SRC] = &nss_cc_port3_tx_clk_src.clkr,
+	[NSS_CC_PORT3_TX_DIV_CLK_SRC] = &nss_cc_port3_tx_div_clk_src.clkr,
+	[NSS_CC_PORT4_MAC_CLK] = &nss_cc_port4_mac_clk.clkr,
+	[NSS_CC_PORT4_RX_CLK] = &nss_cc_port4_rx_clk.clkr,
+	[NSS_CC_PORT4_RX_CLK_SRC] = &nss_cc_port4_rx_clk_src.clkr,
+	[NSS_CC_PORT4_RX_DIV_CLK_SRC] = &nss_cc_port4_rx_div_clk_src.clkr,
+	[NSS_CC_PORT4_TX_CLK] = &nss_cc_port4_tx_clk.clkr,
+	[NSS_CC_PORT4_TX_CLK_SRC] = &nss_cc_port4_tx_clk_src.clkr,
+	[NSS_CC_PORT4_TX_DIV_CLK_SRC] = &nss_cc_port4_tx_div_clk_src.clkr,
+	[NSS_CC_PORT5_MAC_CLK] = &nss_cc_port5_mac_clk.clkr,
+	[NSS_CC_PORT5_RX_CLK] = &nss_cc_port5_rx_clk.clkr,
+	[NSS_CC_PORT5_RX_CLK_SRC] = &nss_cc_port5_rx_clk_src.clkr,
+	[NSS_CC_PORT5_RX_DIV_CLK_SRC] = &nss_cc_port5_rx_div_clk_src.clkr,
+	[NSS_CC_PORT5_TX_CLK] = &nss_cc_port5_tx_clk.clkr,
+	[NSS_CC_PORT5_TX_CLK_SRC] = &nss_cc_port5_tx_clk_src.clkr,
+	[NSS_CC_PORT5_TX_DIV_CLK_SRC] = &nss_cc_port5_tx_div_clk_src.clkr,
+	[NSS_CC_PORT6_MAC_CLK] = &nss_cc_port6_mac_clk.clkr,
+	[NSS_CC_PORT6_RX_CLK] = &nss_cc_port6_rx_clk.clkr,
+	[NSS_CC_PORT6_RX_CLK_SRC] = &nss_cc_port6_rx_clk_src.clkr,
+	[NSS_CC_PORT6_RX_DIV_CLK_SRC] = &nss_cc_port6_rx_div_clk_src.clkr,
+	[NSS_CC_PORT6_TX_CLK] = &nss_cc_port6_tx_clk.clkr,
+	[NSS_CC_PORT6_TX_CLK_SRC] = &nss_cc_port6_tx_clk_src.clkr,
+	[NSS_CC_PORT6_TX_DIV_CLK_SRC] = &nss_cc_port6_tx_div_clk_src.clkr,
+	[NSS_CC_NSSNOC_PPE_CLK] = &nss_cc_nssnoc_ppe_clk.clkr,
+	[NSS_CC_NSSNOC_PPE_CFG_CLK] = &nss_cc_nssnoc_ppe_cfg_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_RX_CLK] = &nss_cc_uniphy_port1_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_TX_CLK] = &nss_cc_uniphy_port1_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_RX_CLK] = &nss_cc_uniphy_port2_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_TX_CLK] = &nss_cc_uniphy_port2_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT3_RX_CLK] = &nss_cc_uniphy_port3_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT3_TX_CLK] = &nss_cc_uniphy_port3_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT4_RX_CLK] = &nss_cc_uniphy_port4_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT4_TX_CLK] = &nss_cc_uniphy_port4_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT5_RX_CLK] = &nss_cc_uniphy_port5_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT5_TX_CLK] = &nss_cc_uniphy_port5_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT6_RX_CLK] = &nss_cc_uniphy_port6_rx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT6_TX_CLK] = &nss_cc_uniphy_port6_tx_clk.clkr,
+	[NSS_CC_XGMAC0_PTP_REF_CLK] = &nss_cc_xgmac0_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac0_ptp_ref_div_clk_src.clkr,
+	[NSS_CC_XGMAC1_PTP_REF_CLK] = &nss_cc_xgmac1_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac1_ptp_ref_div_clk_src.clkr,
+	[NSS_CC_XGMAC2_PTP_REF_CLK] = &nss_cc_xgmac2_ptp_ref_clk.clkr,
+	[NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC] = &nss_cc_xgmac2_ptp_ref_div_clk_src.clkr,
+	[NSS_CC_PON_CLK] = &nss_cc_pon_clk.clkr,
+	[NSS_CC_EPHY_RX_CLK_SRC] = &nss_cc_ephy_rx_mux_clk_src.clkr,
+	[NSS_CC_EPHY_RX_CLK] = &nss_cc_ephy_rx_clk.clkr,
+	[NSS_CC_EPHY_TX_CLK_SRC] = &nss_cc_ephy_tx_mux_clk_src.clkr,
+	[NSS_CC_EPHY_TX_CLK] = &nss_cc_ephy_tx_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_RX_DIV4_CLK_SRC] = &nss_cc_uniphy_port1_rx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT1_TX_DIV4_CLK_SRC] = &nss_cc_uniphy_port1_tx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT2_RX_DIV4_CLK_SRC] = &nss_cc_uniphy_port2_rx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT2_TX_DIV4_CLK_SRC] = &nss_cc_uniphy_port2_tx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT3_RX_DIV4_CLK_SRC] = &nss_cc_uniphy_port3_rx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT3_TX_DIV4_CLK_SRC] = &nss_cc_uniphy_port3_tx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT4_RX_DIV4_CLK_SRC] = &nss_cc_uniphy_port4_rx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT4_TX_DIV4_CLK_SRC] = &nss_cc_uniphy_port4_tx_div4_clk_src.clkr,
+	[NSS_CC_UNIPHY_PORT1_RX_DIV4_CLK] = &nss_cc_uniphy_port1_rx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT1_TX_DIV4_CLK] = &nss_cc_uniphy_port1_tx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_RX_DIV4_CLK] = &nss_cc_uniphy_port2_rx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT2_TX_DIV4_CLK] = &nss_cc_uniphy_port2_tx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT3_RX_DIV4_CLK] = &nss_cc_uniphy_port3_rx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT3_TX_DIV4_CLK] = &nss_cc_uniphy_port3_tx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT4_RX_DIV4_CLK] = &nss_cc_uniphy_port4_rx_div4_clk.clkr,
+	[NSS_CC_UNIPHY_PORT4_TX_DIV4_CLK] = &nss_cc_uniphy_port4_tx_div4_clk.clkr,
+	[NSS_CC_EIP_BFDCD_CLK_SRC] = &nss_cc_eip_bfdcd_clk_src.clkr,
+	[NSS_CC_EIP_CLK] = &nss_cc_eip_clk.clkr,
+	[NSS_CC_NSSNOC_EIP_CLK] = &nss_cc_nssnoc_eip_clk.clkr,
+	[NSS_CC_CFG_CLK_SRC] = &nss_cc_cfg_clk_src.clkr,
+	[NSS_CC_NSS_CSR_CLK] = &nss_cc_nss_csr_clk.clkr,
+	[NSS_CC_NSSNOC_NSS_CSR_CLK] = &nss_cc_nssnoc_nss_csr_clk.clkr,
+};
+
+static const struct qcom_reset_map nss_cc_ipq5210_resets[] = {
+	[NSS_CC_PPE_BCR] = { 0x3e8 },
+	[NSS_CC_PPE_SWITCH_IPE_CLK_ARES] = { 0x424, 2 },
+	[NSS_CC_PPE_SWITCH_BTQ_CLK_ARES] = { 0x42c, 2 },
+	[NSS_CC_PPE_SWITCH_CLK_ARES] = { 0x434, 2 },
+	[NSS_CC_PPE_SWITCH_CFG_CLK_ARES] = { 0x43c, 2 },
+	[NSS_CC_PPE_EDMA_CLK_ARES] = { 0x440, 2 },
+	[NSS_CC_PPE_EDMA_CFG_CLK_ARES] = { 0x448, 2 },
+	[NSS_CC_PORT1_MAC_CLK_ARES] = { 0x44c, 2 },
+	[NSS_CC_PORT2_MAC_CLK_ARES] = { 0x454, 2 },
+	[NSS_CC_PORT3_MAC_CLK_ARES] = { 0x45c, 2 },
+	[NSS_CC_PORT4_MAC_CLK_ARES] = { 0x464, 2 },
+	[NSS_CC_PORT5_MAC_CLK_ARES] = { 0x46c, 2 },
+	[NSS_CC_PORT6_MAC_CLK_ARES] = { 0x474, 2 },
+	[NSS_CC_PON_CLK_ARES] = { 0x47c, 2 },
+	[NSS_CC_XGMAC0_PTP_REF_CLK_ARES] = { 0x488, 2 },
+	[NSS_CC_XGMAC1_PTP_REF_CLK_ARES] = { 0x48c, 2 },
+	[NSS_CC_XGMAC2_PTP_REF_CLK_ARES] = { 0x490, 2 },
+	[NSS_CC_NSSNOC_PPE_CLK_ARES] = { 0x4a4, 2 },
+	[NSS_CC_NSSNOC_PPE_CFG_CLK_ARES] = { 0x4a8, 2 },
+	[NSS_CC_PORT1_RX_CLK_ARES] = { 0x548, 2 },
+	[NSS_CC_PORT1_TX_CLK_ARES] = { 0x550, 2 },
+	[NSS_CC_PORT2_RX_CLK_ARES] = { 0x558, 2 },
+	[NSS_CC_PORT2_TX_CLK_ARES] = { 0x560, 2 },
+	[NSS_CC_PORT3_RX_CLK_ARES] = { 0x568, 2 },
+	[NSS_CC_PORT3_TX_CLK_ARES] = { 0x570, 2 },
+	[NSS_CC_PORT4_RX_CLK_ARES] = { 0x578, 2 },
+	[NSS_CC_PORT4_TX_CLK_ARES] = { 0x580, 2 },
+	[NSS_CC_PORT5_RX_CLK_ARES] = { 0x588, 2 },
+	[NSS_CC_PORT5_TX_CLK_ARES] = { 0x590, 2 },
+	[NSS_CC_PORT6_RX_CLK_ARES] = { 0x598, 2 },
+	[NSS_CC_PORT6_TX_CLK_ARES] = { 0x5a0, 2 },
+	[NSS_CC_EPHY_RX_CLK_ARES] = { 0x618, 2 },
+	[NSS_CC_EPHY_TX_CLK_ARES] = { 0x61c, 2 },
+	[NSS_CC_UNIPHY_PORT1_RX_CLK_ARES] = { 0x5e0, 2 },
+	[NSS_CC_UNIPHY_PORT1_TX_CLK_ARES] = { 0x5e4, 2 },
+	[NSS_CC_UNIPHY_PORT2_RX_CLK_ARES] = { 0x5e8, 2 },
+	[NSS_CC_UNIPHY_PORT2_TX_CLK_ARES] = { 0x5ec, 2 },
+	[NSS_CC_UNIPHY_PORT3_RX_CLK_ARES] = { 0x5f0, 2 },
+	[NSS_CC_UNIPHY_PORT3_TX_CLK_ARES] = { 0x5f4, 2 },
+	[NSS_CC_UNIPHY_PORT4_RX_CLK_ARES] = { 0x5f8, 2 },
+	[NSS_CC_UNIPHY_PORT4_TX_CLK_ARES] = { 0x5fc, 2 },
+	[NSS_CC_UNIPHY_PORT5_RX_CLK_ARES] = { 0x600, 2 },
+	[NSS_CC_UNIPHY_PORT5_TX_CLK_ARES] = { 0x604, 2 },
+	[NSS_CC_UNIPHY_PORT6_RX_CLK_ARES] = { 0x608, 2 },
+	[NSS_CC_UNIPHY_PORT6_TX_CLK_ARES] = { 0x60c, 2 },
+	[NSS_CC_EIP_CLK_ARES] = { 0x6bc, 2 },
+	[NSS_CC_NSSNOC_EIP_CLK_ARES] = { 0x6c4, 2 },
+	[NSS_CC_NSS_CSR_CLK_ARES] = { 0x714, 2 },
+	[NSS_CC_NSSNOC_NSS_CSR_CLK_ARES] = { 0x718, 2 },
+	[NSS_CC_DEBUG_CLK_ARES] = { 0x770, 2 },
+};
+
+static const struct regmap_config nss_cc_ipq5210_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x800,
+	.fast_io = true,
+};
+
+static const struct qcom_icc_hws_data icc_ipq5210_nss_hws[] = {
+	{ MASTER_NSSNOC_PPE, SLAVE_NSSNOC_PPE, NSS_CC_NSSNOC_PPE_CLK },
+	{ MASTER_NSSNOC_PPE_CFG, SLAVE_NSSNOC_PPE_CFG, NSS_CC_NSSNOC_PPE_CFG_CLK },
+	{ MASTER_NSSNOC_NSS_CSR, SLAVE_NSSNOC_NSS_CSR, NSS_CC_NSSNOC_NSS_CSR_CLK },
+	{ MASTER_NSSNOC_EIP, SLAVE_NSSNOC_EIP, NSS_CC_NSSNOC_EIP_CLK },
+};
+
+#define IPQ_NSSCC_ID	(5210 * 2) /* some unique value */
+
+static const struct qcom_cc_desc nss_cc_ipq5210_desc = {
+	.config = &nss_cc_ipq5210_regmap_config,
+	.clks = nss_cc_ipq5210_clocks,
+	.num_clks = ARRAY_SIZE(nss_cc_ipq5210_clocks),
+	.resets = nss_cc_ipq5210_resets,
+	.num_resets = ARRAY_SIZE(nss_cc_ipq5210_resets),
+	.icc_hws = icc_ipq5210_nss_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5210_nss_hws),
+	.icc_first_node_id = IPQ_NSSCC_ID,
+};
+
+static const struct dev_pm_ops nss_cc_ipq5210_pm_ops = {
+	RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+};
+
+static const struct of_device_id nss_cc_ipq5210_match_table[] = {
+	{ .compatible = "qcom,ipq5210-nsscc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nss_cc_ipq5210_match_table);
+
+static int nss_cc_ipq5210_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to enable runtime PM\n");
+
+	ret = devm_pm_clk_create(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to create PM clock\n");
+
+	ret = pm_clk_add(&pdev->dev, "bus");
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to add bus clock\n");
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Fail to resume\n");
+
+	ret = qcom_cc_probe(pdev, &nss_cc_ipq5210_desc);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
+}
+
+static struct platform_driver nss_cc_ipq5210_driver = {
+	.probe = nss_cc_ipq5210_probe,
+	.driver = {
+		.name = "qcom,ipq5210-nsscc",
+		.of_match_table = nss_cc_ipq5210_match_table,
+		.pm = pm_ptr(&nss_cc_ipq5210_pm_ops),
+		.sync_state = icc_sync_state,
+	},
+};
+module_platform_driver(nss_cc_ipq5210_driver);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. NSSCC IPQ5210 Driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

