Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8E3290C8
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652214; cv=none; b=jeJa2SGHGkNePOr0tvlp3CwLKXzzYPHSO0FKOIHqfqtVYYpKNlSAlTkvg3Z6NFXAg0eypNfLaK3EfU6a5w9VDVkbYuUlM3r+SQYxW//03KtiEq+IJPYdRFct7dt2K08KDaXWuGM/MISM7ccWHFLU74GiN+faF/BxonBMGqFi7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652214; c=relaxed/simple;
	bh=eQGr0nkxcoWjn7QIUaXrY1By7FGE9D1ix6Kr/LwIqbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boGscfs6OWNq8Ifhf/0eiWR7pWtY4zDH007WtWcHB61IfH4iEKGOjhDFPQD6SKoosfr10cmU4PxlgQAbv8HkyiiyvZL+u/ckv8JDdyiP6ySrJuCgPxHfkhcZe/HOxg+Yv9VDDbBmADQoHJfwGMtWQ9PNziVyd9d3b8wRqh9JbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQlsBWBL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dU4GDoG1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQlsBWBL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dU4GDoG1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NJdIcj3962875
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K3jR+GwNOETbRU/kpT6QGFXH73c8UZDoHdb7nEPtqQ4=; b=bQlsBWBL6lf9jRFh
	NpgOXp3ErGLyyp113rnoPJ9T5TgpkawPDVgEZePtRussoLXPG9RisWQpjZdPYfDb
	nMKTzXhJDI6fQMXmsOsY9Itu456O9U36V7Ow75tw2yy7cABWM1vdbWK3yTqFEuqI
	aLEJjcbYkHjKsIN4jSneP674FQRAZsVni+M6tjSg+petDOAB5hdyraCYrkhvzuOw
	PiRJHJKcRxCa0Zg4pTkm6zKlmAqwVl/Va5mIf/SKawpOr0tqT/7V4BxBA2TJYN35
	y7WsCzj4zXQ8qcXGKxQ0I+3mqxlwTFKS7875hrVl5rHrbz4TOqns2ksLKURvANEX
	2B8Utw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb36t41ua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so9737479a91.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652211; x=1780257011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3jR+GwNOETbRU/kpT6QGFXH73c8UZDoHdb7nEPtqQ4=;
        b=dU4GDoG1SvrV4xEDcM9i/7a91saxCnksqiCyB5ZgqY7cbPB98tCrMvcgHGKJwJ0fSq
         2x7WhgeT5+2X36KbHn+p9MeRV9JVUEyBk4Rg8nltrzDqpMgOzksdmEpgUElzaw58fwtL
         kcCu41IbidE2y1r3djonYj/F51dAf3MdMaI0fywqqZPKdDs8IpqX/X58jSlGAkEJCobx
         TBGwmdMC4JoHtYKfoIjEkJxYSP6LqG2quIqfLpxfD1ZwLqe3S0t9snnMSGPPjOeEt2Iw
         9aAqiYFY0IoXXIy0aOlpyMI/y6NHzLVBQuEM5OAqsU8OrZkGpBtkkZAcgaYsci3ba/QS
         3S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652211; x=1780257011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3jR+GwNOETbRU/kpT6QGFXH73c8UZDoHdb7nEPtqQ4=;
        b=n+HYR54Xi3W7vrz0x7Dck54+39xU0iM7tukOTb6vM18aeCbmVQic6XfPfOeyKEBxbB
         3Xp/hy5Xfl41BdHmQasjz71u7grNyVeIHcXwK4Zs8+NV4JUzuT5oh723wmXKBIED6RUI
         3oQVc928JPbBPU5orjie7yc+UybuCY0+18NQjbDGbkCTdo1v/d1QtgJSgZlNRGgBU8Ab
         Gd+Hk3rrv+Pf3pV6JJ1FeEHe1ySkQrC1IPPlFta0/RVqMRM7NK4MWmyNQDPSu90HK3w+
         UgTZnWLWovFmj9DhHrKmX9D4jt5qw4oZyGCjwHBbvT0RhvJe9E6e6vHt3z7rM9QiJQP0
         1hzg==
X-Forwarded-Encrypted: i=1; AFNElJ+mTrDAHndl9pI3VoO63g4vCo3Q33IQc29TedomVGBeMtep4lFfHhTuHAdS74C8EiYr6FcAiPRzIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGhPaQS2CLAV6cwl9R5R/zzeK/i9skW2MvBacbNb4zzYGjin/
	71kOQGuZ9eJ6RVwMTBaNcUGN8tF0czWX72T10loGDqUmkpwk81u3u2zAFkQANdcKsRdvjzRiUqp
	OW/n9Uvo2CvEbTJEtpYCTMvduMtb3kHRONIg+YOPapMdnjiNFXnUt8WTIwshRuw==
X-Gm-Gg: Acq92OGszQEwc668Nt04k75fr2QRNJSbYVnl3nRHw8paq9eQH2BgE81ccyPXypqVpRb
	5Gmuz63kI42mOVei2bp+QQw3q2Ekn3iPGS7QL79dNJBM+EUWFptPr6TzHp3YlLvAwoZpuIrhyxl
	ihiGMY1+CYiBVdao8ZGYzabnJPreu6pC4vHVBDJtPzfmEnX8ar/dx0M/60mloLuucFXocsOdqBb
	ef+9+yOO4tbYc92JWU8ke/vbBf3rT0b8o0lpPCk6z3SnQqOz8mqQsUWHUMfgrbcjYfj9iDSc4xw
	vBOP15bHZo2QC8fEd9HcNfVehpjOrxGafTcrqLPfBrO/Y3F7tknovYEkbD1vpoDnBl5sZD0QkMI
	v28plEkV2nZajizPJ1b1w076+mI77Vdh1Aphg
X-Received: by 2002:a17:90a:d886:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-36a676f061fmr11575597a91.6.1779652211033;
        Sun, 24 May 2026 12:50:11 -0700 (PDT)
X-Received: by 2002:a17:90a:d886:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-36a676f061fmr11575568a91.6.1779652210422;
        Sun, 24 May 2026 12:50:10 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:12 +0530
Subject: [PATCH 08/16] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-8-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=2211;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=a1F9RbX56fPOp9nyo4wHXXAYQfLg2aWQ/NsEbswCS6w=;
 b=HgxBQkgSNaAg0p/OjKCxSjohsKWoLpkpFORRD6Z1A402t9dXxxfeErjc9p5S4wOD2yqqBKcIk
 1jrSPPL4M2ID3/2kFAP40bZVC3z+xcVwcoopmWtv0joEQd7X/OphVs2
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: YCFdd8MDJppB8dtuLcehTcSaxPkTzzpF
X-Authority-Analysis: v=2.4 cv=Fto1OWrq c=1 sm=1 tr=0 ts=6a135673 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: YCFdd8MDJppB8dtuLcehTcSaxPkTzzpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX7FrQpFnSRSsv
 q7g1Lxhvfb9tK03g6epv3uTcXo+d4Xl+fT1jqdusZOWmazkkODglcyfsdt/v27cy3ZecC8BTopD
 1wl76vfwcQ7YAZBGKd+dqTCsSHaEpS73ab+LoHSaU1VZ7qFX0RADZgPRGoCHtpQ8xgm/1CQ1YI+
 bLjnsqcUkoccQUA9TVmTAzQnX64szOmYm9GfrKhCHy5efuLKg4jUe8D8BWXaUF8IpRA2RP/BKNg
 EykirxwvMLF2k6ESACxCTXrUzwNN/UTGOXrKaC7fINvEevwNX2PuztA7MlRSUUdeUpOFguf3An7
 uNp3Szy3/8f3RCJnYn7xysiWo2hoY3Xw+OIGklvUGcfnpZvFQuHt+PjzNY4A/9y/SxOLO3aZABC
 jBRB9JSWs55LiYC9qBjhrkp1ZNDU/bIDOQwsPqyfsuIiBDzsbBTq0Kin2vSxB21zc8IMDKSYdol
 Szp9U1d7v31caOjHTog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index bb1821e95248..2ea35e4442ef 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -412,6 +412,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
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

