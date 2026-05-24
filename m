Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96432A3FD
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652220; cv=none; b=jjHuqTb/wsP33g4CwGP6D3bMyX2kq2ySVpIJYfvpISLi08gHQngfJDN99DWIJWWydnLYPiu2/ijvWL+W+7EuOc32KbNC7FmGhylFN0lTghcxGJ4SSKuHOR4zsKkdTrR4lSRf7cJtgqtIOevDs1PcNQSy8yKW4nmRF+yZSrIvAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652220; c=relaxed/simple;
	bh=h2561MUTAlBWP9LstFppBlJ737L72NjnE3HiMjLnIww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZwT8KK2e3iyIa7jQky5o39fjgzZpcL6/fB9IHXQ4XGNr8eQd0uRZStaM+QfcYTqb48b92ypd3xGy2l2dpakT9lb1XW3cwETdK3v3Ny3/0ItVoQ8bYA+g/lp4PbSaP4ZFmw1A16CapI4EKMOygSJEr+zyukOSMaodJBM2neF6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PVDyVxsi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWxzHJBi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVDyVxsi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWxzHJBi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O2kb4V3547436
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y+KE1req0AFK4kYUvSBuXjFMHaKhuk1XxVZE4565XCs=; b=PVDyVxsiK+92KTA3
	1sQ8Qi/BMCBPThWVpUuYsztNz0J+/beLWfeKLDr5J0pXm50LEOpnokbqoDq+zFjW
	7dqM8x9r5OnuHVqNuPl51qXEhSSoZeTH6acqlHExmn+Y1kNfKA9B0EEZxTGbVuhf
	7BTqKOweZv8lcynHBQ7ht08kUI8WBnBZjD8JlcbmOgwMpQ6te/DqL8EWGdqVYAo6
	IceHXquy91T7fqqz8RPHeTNMdIG2V/xQu25NtJHKIHeslEpyWh7imDcmTtUQcZg1
	/K7tGE2vbQJwO0zQy7XteEIRzwe4EEZZgwanmIOWBjggfB+EmgP6XUf0jPCl4z5e
	KVBwhA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w3d74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so8702077a91.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652216; x=1780257016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+KE1req0AFK4kYUvSBuXjFMHaKhuk1XxVZE4565XCs=;
        b=FWxzHJBiF2WUGDeE791v1RDQ60u2fJ6Dhw6PZnXJrGMUxGtZbJfn+OpjHGRIgDRMtE
         2gSty7oLedsoK05j4C+2DE3vFHlTHiNvsnhE190Wsly1EGOBphQ5SlUGNpOZ33L4vBK8
         5Nocxn3ejHyLRCYTM6iTo9PFEuQ3dTfxy1xN2OJYsU3ouQXgEcuGA8uKzqvGcVtmxPh7
         LHiebDPKYxCza90Hov4B1WgBJlrrqIcWfSkjsgfKLa2W6KvatszIeAu28ShhmMXJAtnQ
         yveRRTWGRZpN+n8+E9852VEws49ZkRs+FIdd3FHWLmTHfYpS9N0IBncJKEiKbk8qtJGP
         HRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652216; x=1780257016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+KE1req0AFK4kYUvSBuXjFMHaKhuk1XxVZE4565XCs=;
        b=AsItUP3b9gU918Ory3fc6L5EHUQrvowsMqv46jDwC2h1LQR4FpvblMfaXx1BhFD4yP
         h6+3OffKGAIKLk5F+bdTgXLEIzJNpcmz3w0TFRWVbaK2Y4om2YGqzHSr2sdkth8AiXcb
         Bx/SPVZ482N+YDGV5lL0LtEWR0MHJ6tl/+XKDuP7huzlAucOmLzMbjh1ZRbc4EV0DI/q
         02uDU/3LtkLIsdJpVT+QSZ/V2r/VQK79dr2Vyfkq/FGT8r5uOA9eRT1Oex0R7swMdUJ6
         vGPuwJKwCyQS9BL/083ACT3LZA3I7WrpsNJOJA/y9FTqHU0mDLMrUY8dq0idqfGufyWq
         jyZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vhlX1ZfS/brzEvbFdzat3kKxeDC94m+xv5NrRCqcxrXqp3JIGdkNs9BPEb8t0RvP4zium4XgeFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYJSwdSJ8Wr/TNo0n1wz2e+054K8lKw1bPXrbuEP13Z1/fod3
	wF6txNu31ljFjPLh/BX8PNhQnYpN/nC1NVdko6Z/BPFA7wABmJoBMhgG/RJHDmybm+w8z7Ml7o1
	TAwyRE+87kgW4Y1j9O30aItqWADAWlfUHEF/z/wtV0haKjqssZWaEaRagBqtsXg==
X-Gm-Gg: Acq92OE+iiJBR1HHJVCwZG9y8CmP1gMwoozlKuzV29gV9jA8zkrz6ApwO9WK24CxP8M
	BsRbrl89maYqm+q4qNHF0sDtBrdSrYMBtjcetIqlx6fs0RoLI9ijujOyACOR0P+Z8sdZh74csVK
	suDdN/J2toQDIqQcUJWAmA9XvSpAtArdsQXxjuZh0IytXdxA6BMWZFn++SvBKQWMbl4EjEIXpFt
	H5NWGU5Ezf8r/dWM28uQ0GeJmDO8Jrr0vfJyMcUBsdh2W29R4HrtgiNb/6Mk8KC8MsPX9XhSlJx
	xIHIen5hOpHGUDbFlDH8NmPcNQE+09nZ4YDEgvJrcMU3Ltw8S06RKYn/BtM6X0wxSzQZhvueQno
	so2Dt6N43pcyvZNpyLFSt4qRd/XC8PBa1p0xFva2aSrErDTg=
X-Received: by 2002:a17:90b:3149:b0:36a:ee1:fc1c with SMTP id 98e67ed59e1d1-36a674c5677mr11953791a91.8.1779652216456;
        Sun, 24 May 2026 12:50:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3149:b0:36a:ee1:fc1c with SMTP id 98e67ed59e1d1-36a674c5677mr11953765a91.8.1779652215853;
        Sun, 24 May 2026 12:50:15 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:15 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:13 +0530
Subject: [PATCH 09/16] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=5225;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=N2myH3ZS/JYAPq+cEvLA9M1TLJ/FuYAVGQaHhcS9rEc=;
 b=O3e8l/eJsdXMmKUozXX9JNw/zpUBRo2I8Gt/I7iZ63YbLY/mHjcclWZhwD5/uSFxv6NgO2JJw
 8AjiUFKULpQCtHyOXwbM58Om4TJw4asWMcO0+mPdDvhSpJ/MuN2Wkmw
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a135679 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX22L6bgQOKWf0
 A8Pd7xQEZoLdx6su6qRk7AtnvlXPe1sKC2P3YBoX2vIA5qNL+ykJ4a8d2SC/JfXWSK6YXYcgCgA
 Au5zmplBK5jyOohEQvgcdaXUKiYlMZl7y3w1BnqSrzY9xDYU61EZ/6PdRdacs4sZ8ho77PKI8Pw
 Ezt3GnJSgDm+fspB8HhO7MsfH+pPef0ZjmKnnEmAqOuvEycN0WXywV+kYQnEg0u2YxAkd2Kf6WS
 fuchS3QCgOQxWMOPPV/RRJbj3JL8EXlA3FFRVrV/AGEn1zTyfMfr7sF3zJQb1LF7N+psO3AZoBB
 JC9XozExKpJ8nkYHOdgMBCmvGUZkGALORnGbbl5784FzVh4UWnPqNvm218af3B2NmrEjJdOxhL/
 zuvwbFdFN4szXrvhB6XFCFbo+nP91QGk2l+6LzRj1zj2ZumnftURp0/8UXETkD6VSAyX2QgVRE2
 sIqkY5996meqxS2QUaw==
X-Proofpoint-ORIG-GUID: pEugogIdkWsEmq0GglOoJDpjCxVFF5vY
X-Proofpoint-GUID: pEugogIdkWsEmq0GglOoJDpjCxVFF5vY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2ea35e4442ef..96ec5b5c7203 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1797,6 +1797,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
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

