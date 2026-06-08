Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BE37AA81
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924287; cv=none; b=oBkQ93Dw4qVGk8QBKRJHbAakd6CnDB4MgwZPPAjEVcR6Oj1MHHsmJyXXI8tIysKaBSRhPcjuxwDhYlUfy7zEJAwz+Ey/ldXSX7LuMk734Q4Kilt/6lpYweCylnd3Qa4Qg+8O6yG/uceeChVGnBI5xjD8DgEKuzKerbSvpsme+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924287; c=relaxed/simple;
	bh=Y9Enl0Zph26PkTk+LomlG38/z42iBDvGRg5nU5WG7PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2Omyyn2BXbuLMrv66G82pSKdzgV/ymsNWk7Iy0eUJ7pPV00ezRDrTNjrFuWTNgJfknmKsOoL5ieuRqOiGaAReOZEQHgV4RNIHhI6bZG86boc1ULtJ+sOZ8/aOhCBYMxmI5fPMs+Y38CGp69+QtvcPHk4I/36uZuA4YMZC1r8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzWekN7D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gc+TM67B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzWekN7D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gc+TM67B"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBv693459841
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=; b=dzWekN7D8Gi9zRlb
	d0UvdvgsaiC3rwRvvt44OTUroaLXnoW8clHT4A/nDIElf2DiIx2rNDCK2E7qPFPh
	2N8ITTUcEciXrx9SC+Fdd7hHk5t3GvhT5TvgW4d75OU12+AAh8sDSXdDSbN+fF6S
	klU5jTtfTNTJJ+1hV6QBsxMEIMlL138CIqBYeDPUoC7ia0JXbwULeo2TaRkLSePY
	SpZXq2fkSmNwenCIEe516d9Bp0b0zruP9+36EFTD/xDFfBAi06HTOk0zILQ+jWbr
	V51UeKYMEzraun9EWLChCtRf3YJnw6DgjcfMFgYV8xTGBiaRVV6YTM60ZZcuvaui
	B2h8jQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8gses-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:11:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf0d79d41eso34275445ad.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924284; x=1781529084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=;
        b=Gc+TM67BPegqTi4ENZ+1uZd0GFpmCjB6UQ9d1/QabvOKr/ZLx2p1aMBtezBm6Dodhm
         pETwi5bASc14F0b9Hf2pPaIUiaH8/qQxY3KvItJGaHublVMiZGiVyLdSoqpTGVBFYHQW
         4IxdUJlnstZNV6IB9GcAmJkCI6eOPfgBXFDQIBPYUrR4cA9V370YdxZRMX39QqNqWqH2
         QMZx55c9ZXWctU5lYm/OiatNM4hXafQCcw3d542TWSPnJPVhaBpP5tfP6mOeqQoUAQVh
         QLrm76Jgoi/VyiHjzE34UkcrlkDb4/2JmG398XKd9reNX/kKBZWVLxxkXTcrtyIH6A11
         wx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924284; x=1781529084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxUOUnFMum3tGcWpetlvrIGoT2OHDlQe08hnJpSqFJQ=;
        b=jDKPpjyMuJWPtuTZr51SlqpVFArTef3UlniIFLxYLlXtuRthnyywW7XfMb6onGHK39
         4ZP8GIKjZ3gdjRJPoAB4Ss00D5g5mwAYrtjGppxyYqYCAtjHo7PzX3bJmBuXy7tzwkgX
         5BxFq1QyYIfK3loa4JCxgkha3i8t87lstHTvG+DdrYxARtRqZUp/gUeRp7wOKc7dSefK
         sjsVRDWq2Ku7hIM1iKpUa8405LqyQc6lSqsE/RP5LPeZchc/qR2Ne7s7n2AmepEhHFig
         qSoHBUnNmExJ5D4txp3hNYT8KWfcuhVz2cYWSJNq8tSw5LiPpdV2g+5p3wp41RLiCahK
         4grw==
X-Forwarded-Encrypted: i=1; AFNElJ86eNWSFL/eZSiGQR12499slt4L4JEdMYQxgCIObMBRUSEYoU1ptbsTWbsx+XIQQml0RN6u40xMWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Z9c4fMF7YbJNW4QoMdT1GzZASD5vUhHqkB/QZGXRMrjeJUwK
	fza0HX8DlkDfc5BYFIFjLjd911d5xkF+rx7mkDhg4L9JSi+XsTp7i7pukqzJBcvUtUX6ssCHxoG
	pO4z2LbugEu+ZK94iaufKsw46MA5yH5GlMHB1w8cDnqyBSsq63W7+Lh4zqXCl3A==
X-Gm-Gg: Acq92OEwaJFleSphpbC5TYBX1Gaq+ToWYPjulq3xr7orLAFhZRD7CAZ4Io+h9ItvZVj
	UH8x+Vire55OdaWb+IBm85F5KMsS0m5CVGrdvex8yrsfWLMecXfT277ppZlnqx3r3i7B6fcEyXE
	j+2HkTq0RD0Dxj2iw/5OiCAuHHgq2PoKq/klM9nmvcZAf5cn3o08KodtYNNbKwVj0Zb52nXR0fm
	Yk1m+82frECZ9N0Jy3wjSs3Se4d24jOwMrIrXn4RCP038Hy7WfoQiXG/t2Ak4WgsiD6j9mql+1x
	vjuCkLgj/r0+dpM58SqmhiOhyzBq8ABvK96EstkHfeKlGzMk9ObBFy/C6HofpWWcOSjOXAqhtUJ
	Jfnie+ycaDyfLjQI22LCbPDnzjqFeJgOdcAdVZFIpDTcXkIM=
X-Received: by 2002:a17:902:bd43:b0:2c0:ccdb:e031 with SMTP id d9443c01a7336-2c1e7b401fbmr114799645ad.2.1780924283662;
        Mon, 08 Jun 2026 06:11:23 -0700 (PDT)
X-Received: by 2002:a17:902:bd43:b0:2c0:ccdb:e031 with SMTP id d9443c01a7336-2c1e7b401fbmr114799295ad.2.1780924283081;
        Mon, 08 Jun 2026 06:11:23 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:22 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:27 +0530
Subject: [PATCH v4 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=5225;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=IaDoauPJHJLmeg0KCOp3wjoXaMuRxylv+BxtByokKWc=;
 b=Ab649ndMnmGUP8LhgjQw+eo6ASF4OZQlbYe3gvzZLXgz+5B7OhaD1U8njDGyntiXoNU15FdU7
 sC+sSmuDMfSD6S38cuSPlHedORtzvdFjoyeVjWT82iCsqxQ7eczNuTH
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfXxnN3bEmGnK6h
 ieEyKEmNjSX/mNOujNpQcv5nG/F/3Waw17yfkNzRMYSeJ4f9a3KmoSUy/HKUSEi0aYoz9t2+bZr
 tM+IgNxsyEl6YJNcanBFQgsMUsMqDg94Xj+8xr/HoDIAHKa1qmNiFsChN2mcaCs8gKmSJQuzfkc
 vdaHKIigCSzvTzRCfUEDzIIJWqUp0+oKqnqTw4IvqYgiYG4eYjdyEQ0MCHJvGfPw8j3xpgg/Oww
 5qd+meSWSK94WZpIGxtv3XC9OwsIDk93Rv8T1UBfW1VHbi9g1a7zVVKTcWEgwfkpA0c+yQvCq98
 4clEagDjLXbiDjW3B+yGeA06CmLLwURQgqHTM3hA9aIYRLI5AlxQ4BJ1syKRGQ4zcLujGqTNABu
 rg3pPKi+v7baT5d0GpYSCoDH0MHKbrNIbt3UIcPzD6muNGsAROayedd0Oj9KJDrNZgt51gaiuU0
 JRsUAkh/mgPWpEmzy6A==
X-Proofpoint-ORIG-GUID: fmKRDeCVUqP2Gzv5KnUYGFOpUAhADUrV
X-Proofpoint-GUID: fmKRDeCVUqP2Gzv5KnUYGFOpUAhADUrV
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a26bf7c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 219c904fba29..445dd8bb7269 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1798,6 +1798,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		remoteproc_mpss: remoteproc@6080000 {
+			compatible = "qcom,shikra-mpss-pas";
+			reg = <0x0 0x06080000 0x0 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING 0>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+
+			power-domains = <&rpmpd RPMHPD_CX>;
+
+			memory-region = <&mpss_wlan_mem>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 12>;
+				qcom,remote-pid = <1>;
+				label = "mpss";
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@b300000 {
+			compatible = "qcom,shikra-cdsp-pas";
+			reg = <0x0 0x0b300000 0x0 0x100000>;
+
+			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING 0>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+
+			power-domains = <&rpmpd RPMHPD_CX>;
+
+			memory-region = <&cdsp_mem>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 261 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 4>;
+				qcom,remote-pid = <5>;
+				label = "cdsp";
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					label = "cdsp";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x0201 0x0000>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x0202 0x0000>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x0203 0x0000>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x0204 0x0000>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x0205 0x0000>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x0206 0x0000>;
+					};
+
+					compute-cb@9 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <9>;
+						iommus = <&apps_smmu 0x0209 0x0000>;
+					};
+				};
+			};
+		};
+
+		remoteproc_lpaicp: remoteproc@b800000 {
+			compatible = "qcom,shikra-lpaicp-pas";
+			reg = <0x0 0x0b800000 0x0 0x200000>;
+
+			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
+					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
+
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
+
+			qcom,smem-states = <&lmcu_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 9>;
+				qcom,remote-pid = <26>;
+				label = "lpaicp";
+			};
+		};
+
 		sram@c11e000 {
 			compatible = "qcom,shikra-imem", "mmio-sram";
 			reg = <0x0 0x0c11e000 0x0 0x1000>;

-- 
2.34.1

