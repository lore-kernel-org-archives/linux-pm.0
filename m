Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4B3C4178
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165710; cv=none; b=c9Sy9Xlci8KlQl4PeugE4E77BTxW+qxmqXtD90bZ9LOJ6KA0awgQmd9V0seYmK1BmNh7/UyYQxgmanUJX1KeizVf4onaYfKwtiBzlyWIqrl9b/x5hF2DKyAo0sFfwx85u2zKE26yo9JgFmv/keTzMAQcMKddxhbsVMvbgNS/y2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165710; c=relaxed/simple;
	bh=szx38dk7eO7FpCFIXCdeBV79GbDa6G0K3KhI7GR7yMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfJfpIxdkPyAiomLTqdKLaBIlQqPrKfNX/EtifIT8vt+Ms+Ylb7zuYCKcLKsbBD0G4HpK+Cmjdji18fgz1F10CmGkVEkukPRDDz+tfMPupn87gKOyTtqpKTNvQqDKCRNTv7HpeKUqV8bIpgJeGrYZ/DM8BA8aM16VQyq331cQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YBNXFwo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OFHIyg55; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBNXFwo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFHIyg55"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UGhA4W3635675
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D+HCzmgZuzP0sZVwn+sOEAlTZUisDMNqv33YeVPjZVM=; b=YBNXFwo69NQ7hhyT
	itWqKqjTE3E74niXyVWrZJHbnHE4jQeUUOIUw599BXqXfw2+AoMj/leboxsvgfou
	UqvUxDFs826UMvOqOlVIR4BofeTtfq9wd2MTI9SAcBht+ewK+6fn0toNIXyMXC2/
	Ut4TsOieWkU5zAIp7+YInrEDxZFtg21kuEXbNSLv1je0vSzFdjCupzkgNx9DDt/H
	xo+nL22wla/8a9ltrKmJlbrvfeRf7HkAb6fJHwOSZb0prSHt5gAh7bon2DTLQzZe
	/JjVM8R5WZsxFmQqn5cQNqIEEKRMHKVuclkAR08dp5GR3AHLJimInQrsfk06hcKn
	cHcQAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efs2h9jnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf1845bddfso21756605ad.1
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165708; x=1780770508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+HCzmgZuzP0sZVwn+sOEAlTZUisDMNqv33YeVPjZVM=;
        b=OFHIyg55piYopCdpL5kihM9APrW1Qfq1m2U08M4r1YaLxftmBDj+Z4y1TB3L2oackc
         3NK6pDR++wQ1tWMJcWSSei9q+c1cVyryzn26/QIu7MI6zLcDCwZ9WvOtC5l+A98GTWJM
         PO1CukXWQ4OBJW/TuRJAd4tB7AE4g85oh9n4kQOVviW1gFdXdf3qxzvcVfJ1hE66CkE9
         FwNxC1kJxHaktD/H5ikj6Tj0w0T9dIDkpjDx5SF+g3MnsAq3/tUFpomxYGG494Ti7gNJ
         N8kPn/xg4vmQd+SAe5VT2u/wRoieyuycjMUb01Ymw6db0prNg2pjVmPgOjb/zwlDd+2j
         yBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165708; x=1780770508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+HCzmgZuzP0sZVwn+sOEAlTZUisDMNqv33YeVPjZVM=;
        b=ne7bWDGbXjLA59o3PYFzDnXsMLpFuLWgX6sFLbKNsAlT9wFBnZzzyNdOTPex9nmibP
         5ncCe56LTHNBwYlA6vtaX4i792biEuuVsY4Zac3nCunAwaF7e2qhdnsHemvl5YAff+N4
         bcjBZiDAvwEDfZsESC6rJhi9OLNEtL4t6FWGLozkfSkIqiE4J//OWN3oxgodycvZ18zx
         LVaso/SBvmMpHX/Q5pIKXLRngIksEKuesnuUS0f9BjlIlwb3KNXEO7cbajBbpQk5kMVw
         bcQWFedYZzHVEibQJi8hzmOne7Gfgrw+GgdQyrWv5dHE/cRkzLKdF1wq5kw6Uqi3o8nq
         HORQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zkLIEgmX0Zgz0s8Vm58WHLEA9ZQ5r8BIqC7TV2/SiQUXYeuICDERUKuNjfO1norCR505RRcJINQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6yA9T0RFW7DtlqFeJkuKnBKNf9mD1MfmjFNU6fRaE/KfbaSrs
	yxbXQXHyEhqm48J3u+T2bhLn5ye1QPScrJ21QOB62T7JRZX4Wm18iAwtOEv0krn0RAOGsF3DyJj
	45PMRz/fkz1ZeWG7xgYbo5AaPorC9JcqOkq6Gl5fBbbSfuJv1aIxypOJffR3WIw==
X-Gm-Gg: Acq92OGsEGTQmbVW/xh1rvzYq0JpV4wlg6j6ANEoOYScpDOjuSDlU/qQOaNjNG/b7cY
	rLOqPmuzsgArswEnreoCavwX9upd7EHJS4m5OlM9VlP41GU+DH1kbiGjESqn9Lh3orX/DmZ4i8g
	pdiE+owc4Wz7NLhUVyEz6XH1QrdeAqhX0bAceS1LRcOR4jtrxFbK/uyD3WnkuIbGE1JzS5Vx0pu
	mPf2A2ux46cRj9QAZBYB3BSU4l7XilttCz6W+oNnCja5mKg3pIclyZjAfK5GOLiZoK4+aI+jlnc
	mOtKwsmnr3Hs90QjZzLkZzqQ/ahqD4Yly7HZ59vA05DSr3H/hz581v6kYy4K3wH74MUgapdZdPR
	l4eouafbQqOo0pU6pXXhExR6mK2dvjY4TnM/eAjqgG113yAs=
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr56498585ad.17.1780165707748;
        Sat, 30 May 2026 11:28:27 -0700 (PDT)
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr56498415ad.17.1780165707285;
        Sat, 30 May 2026 11:28:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:26 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:24 +0530
Subject: [PATCH v2 06/10] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-6-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=2211;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5A79pcddnRcu6d01V9L1rukvuSe4x6q+6eyE6jTLb9g=;
 b=r7bbRuyLvwN1pjchzJaul7Z78pPorFr8QoDVS2AY9Doxsz0i7SAi5DjpHc1SFm4uM539uvC2k
 4VRZtRUKUAuCdm8N6xAnXzBVs2q6zK+gLeLPOdJvszvxQYfqbHicGfP
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX2klaUqHpxf4w
 OB/oJW7AFmQXmIdlSdCGHTWGOa6Na3qLdXpZnwH5T98j+VAfPhuADvGhV7mIGUgLjIqWh0w8k66
 IU36wR1myqOBmSl5Soai9Jrw1MJvfXlTH2cqeBFgkvpeI038W6yKs7IxszNu4j1DsRmgRDIlxyl
 jfLPCvj/v1UAwR55peEqV0tzsuZpae3VcX4NyoKXCzQa2YYwKgih+wCQWxJ6/7I/kN3wUlcOO2X
 yD2imcKeAuu/qxaFfYobWb9EsTjmOUQzrWttIrS56XfeRbv65FEbUrFFoR6ZG/fx2uE4bZiCqVa
 ULHvotg+oDR3LDZGILUb8PEUlEvB3NT2Kkl8bIQPISYyjRTRB6ORBg1AQvONpYSFotZSEHLpg6U
 GJf9XAmy8I2w6ka6v2ByNn8DAhHCFTg3At3HhS6AMgL1SUL33W1v6xsfyrS92UJcg6WKTpr+txe
 iBn019K+Ohr255H0uYA==
X-Proofpoint-ORIG-GUID: 3u8yC5W_g4_4mZdAYhXf9C-Fh44rpae2
X-Proofpoint-GUID: 3u8yC5W_g4_4mZdAYhXf9C-Fh44rpae2
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a1b2c4c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 6c0cfd73cb70..10a6e9f3b5a2 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -413,6 +413,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 263 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lmcu {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+
+		interrupts = <GIC_SPI 287 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <26>;
+
+		lmcu_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		lmcu_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1

