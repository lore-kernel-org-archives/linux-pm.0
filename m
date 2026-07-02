Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655E4DC541
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985891; cv=none; b=LmcQtz8TbIeqI/YsxtFE4IRHF4bS5TJZBYeZrhTARThRc9RUqYpubhlpalbYBLFEgU3rk8ADIp+1LTbVlWcJm9vRLtnM3T2V61YuDRiEGZVoQTtc2BhYtalhy1+V8iJmtOSthXlt+8kIODMjLdEHcJ3nWCSwIZ+Fn4n1c40Qp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985891; c=relaxed/simple;
	bh=gGOcOClOufbjsAy34iXb++FNQ29HyxuzrB0+WRNoYEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ptxw10MEtnvTdoU301kT4UeizXo7IapZAUffeTvElsyz6tDEK06GAYnpOXEeoK14kgwXFjjI96vqBzPLzoiCxBmgXeEoaFGvr5niBthGSTnj7auMe7f5GBLD0mo3vTjW22h+CQogQUXHIt0K5I1vC52//zzskM9CX+Eri2GrnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SHzUaduf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGBN+3t3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SHzUaduf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GGBN+3t3"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nXAx4139672
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjX3LlHlsVHojRvPM71du9cKmTiXYa777UZyKZrMZ7g=; b=SHzUadufY/s3D6J5
	jYV4I9Fu33H4zp0ZZCkYnCHRML12YU1hBgI7kVCduna4xuof76W7U3UxH/U00jDM
	vMXRh99YrhEphKFxD3lUWzgrZKHrh01GtRg5rkmiM+ZwYXxP2jmfHjZLhGIcvzi/
	YjKYEw6L6Yqr6hGkwcKp5fvmy1dFT5Udfmc+aPbVsAZGA9A3clAc4NU7XxcVFCY7
	//AcTQczeLYauPfjCEZkmiOky0wJJ5cxMRt6RL3K6Rw0ifaPbs6ubjDkMi5bNW1d
	qJxRAGFY+5sNttft8JwDr5WYY8hiaLnUvwnpRz+RVbdLaSowBSnzDCd5HGqNo/TS
	65j3rg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr80aa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so2006385a12.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985888; x=1783590688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjX3LlHlsVHojRvPM71du9cKmTiXYa777UZyKZrMZ7g=;
        b=GGBN+3t3ldLB5PiUdSmYtWVGxNGl275sChXZPDJP8tz/RCp9w2Gp7hakWVkg0Kzq7Y
         u4RhKKo8+s4EHEDeptnT4BknolYG1ctRUsxQiwUebXABT4WzNM0V6SgnrK/8SQjFKF1r
         7qinWPrfbEMkp9k7s5ySASTguVMp0UlK3Hv0EBX5l3Y7Xt0lqYA3IcQIF12okCSxIhCH
         I8zZ3Ubjb5zI10nrmEc/st559otaaQ6tyWNviXokQjcDOL8u0oQeOc9EAcl5nPBD1YEd
         H/6dbTZnjCmtmkQ/YrVx6JaHZV9EkbzkV+VfdBvuv7WX5Lqb/hbY7HaTnKMmehoduKUl
         HOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985888; x=1783590688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yjX3LlHlsVHojRvPM71du9cKmTiXYa777UZyKZrMZ7g=;
        b=UR4w2XFLEhQXHQh2g9lrDJxIaOTiPK347b7ToGwbIZlL6ORWnk0xtnrf668tYUIvEw
         II8K0Q53jKM5iXkHdqsa1DEHhvqbkplL6OY71lfZi7i/pNJaWeGHxfLtLj00nwSZuCpH
         TWkDZelQyNwjcXm/Nh0YPlpUbLKYpHGcJ+Ifex77H3AdYQr0MVO2KZZo7vxcakbCdA5v
         8gVRRciGanwUZCh5TwrpIGB5Ak0++fXkBD8OkYgUf/gqKuzXLjyevN+DQUHXMBk3/ae3
         mJDq7f7WUUssN8LSJ/XUajONhk/27DYi8eXC3jieDhCsHMP4M4EBzb3tyQjGdSH9EBRy
         HCog==
X-Forwarded-Encrypted: i=1; AHgh+RpjE3aHV66MriQmsFCFm5nsx2eGSebx39ugLa4I7IHgbsYs4SzfDcntKqZ/6/a815ibtkATXmnJLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcPcAB4p8vA2Ck1IvjiXkKCxP2/8Ps8Hd2M3ee9cIwiGtfR3f
	P4QflVgvqFZD+FJJGGzYEQIXVVwa/yJBVV/k0iDnzWuDYmLavtaZc2czdPepv+yQvMjEWdYcyL7
	DlIM+7cVanfhsUyQiWbhnes2tJ2RhGCnj6yz8r+x5VRFVTlsmKFLHmDqKBuJPvA==
X-Gm-Gg: AfdE7clqaKHlEb9puUymfSjo8J/We0h8iOxlgyghHIa64uYUk3we6BT1KoieL99UyeQ
	Nz9YxsQZvhbheKuF0a/Xmn4k7/rAuW9J7WZuoOMlwbwtcCi6Q8a/h030PRmK/Nt5CTdL1KZ89SB
	sm6LOeY9lfqzdXDV/JwZbgCfzvipQa60J9A1mcQ6xtdVF3vZp7qaLNkWbcv29I8IXYK9pnbTAr1
	hxtoxhIhdLnC3QuRGV4buDdfxSFmGxZxcK0UsaMFQrESKjdeoCW9/F2pPaIs0Yj3Gxrk761Be/7
	BZMjkSPHR+5d/vVgv4F6ktsWgE+g9BzNipxeKQWGfsZti09L5Ccco6OAsdk9MXaJui5+cmkMxXP
	8fWzrYLVOkNd9I0XEskBDmwYD2Q==
X-Received: by 2002:a05:6a00:418b:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-847c072cc3bmr5192819b3a.25.1782985888078;
        Thu, 02 Jul 2026 02:51:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:418b:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-847c072cc3bmr5192768b3a.25.1782985887424;
        Thu, 02 Jul 2026 02:51:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:27 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:48 +0530
Subject: [PATCH v5 06/11] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-6-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=5353;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=cwo48c3pu62HWaDduZIiYL7P/xZdyoCCNEnXn+MP1vA=;
 b=DQcfBfjioB+NXsOP57cL5FsYtDNL2ufF6UUo2FFsmVFL4npp0oeQb6N/oMuvwfG52i3MmpC0n
 sG6Bx5MNDY7B3ThDXMW0PrqDIcYC9Lz9h5kPA6WI7ul6Sa1VfIPqPLZ
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: qe_dYzLZnKPUsBw4MCoyuYU3ZmHRqMdD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX9P+gDxYmCGh7
 B6zc/v2xdNTrsn8ENF2sVaUiuqFLwI2K60S5EeYVnE28h8GP7iCnMBi8TPWP3VihJjgVP77PPhB
 o4pkcxdGc0sPcjzixrhHF0vgysaeXoM=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a4634a0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: qe_dYzLZnKPUsBw4MCoyuYU3ZmHRqMdD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXwzcASlbiG+2x
 R3ZDCyK9/8tD0GhD6ruYAYC1VIeeKvaXXYuSmjZUL8ShE+jGEXGFxs4yxfthfZEEoNdL9ZnDe1U
 coSKRlHhiXdp/bjrR+ZXRFytlLGTajWeKFjNJBhNugSmPqd4Pu51+BJdMoT79/g/3K47QN2pV+G
 l2k3jqii/2RSEMxo8M3969N62AOD5ob/2JG3rxE+FskHxBXNuUBzf6K/28KxxJeglv5SNmqXUdl
 /d4CI/JBHuhy9jkAJs86tnHvrziMy0X/ElPRqg2oyZc/kDadIv3r5I2vevtE/nC2Mr1LZ5T5Kwp
 +9ZDmzA5mwNosNBTv6qzREtpm61A4FyLeJL/Kfwj7kOHmWpujK5WS2zVt3llfhG4ykneEk05Xo4
 jiJ+9eb7hf3LCvVpuCqxgts7j6k8LsPyLDMirTWmSJUeqSB4A3PJtUb3IXe2KWyIfYnteWQe77P
 lZErWisxkglpAp6ILAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 53dddf35963e..12e4281f7b35 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1813,6 +1813,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
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

