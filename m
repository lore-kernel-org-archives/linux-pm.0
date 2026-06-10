Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512923B71AC
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081574; cv=none; b=DF96vnyY47Q3g0wM+XE29iu8p69h5qXIyhWmOL0yE9lX9GxMgNPNmgQF2KXKTvrNlyENrOAJW+tRApVDkCF0BAsECjA+siRvZbnitcrtRauZU7jK/bKzBR0mFTqQL2ONlToW2A76V5SwZ2kTu9h5Ngn8BtY27wDNbVXSrx8xPQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081574; c=relaxed/simple;
	bh=mcI/q+LhnTwFsgpuGRD41S+Cl+laWlV+orMRVBKD6W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVMihTvHZbFBhsLRJJ3HLd2LkKVjxRU+NuzTRex6w3oWp95QE2cecdmRdmqDoUImtuEemN5AGzfKID8u3THDuMMBppiMTwc1FwLssilDqLeuBV5FxqjvFLBorEg6NxdkjB8Z0sulVgb9G4c5mzE+pRkgavsDFda8LKSThF0Vk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mdg5+8jK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elh3IY4y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mdg5+8jK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elh3IY4y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7iFvk567782
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oSuOxyqohNyFghg6trX5SYjSHgMDEUyPSbSYNvimIaQ=; b=mdg5+8jK1Yod+3UB
	MKGxGgARMLz8SkRgI1AC+ffOj9duVH/OAfHgUH2xzdvKJ5raF5UlbOTRlhLIt2OH
	SP8NzjxFrruVUr5sJ/lOpv2SsTniOF8KJfVteZuBtFvA1iiNNNSx+xPCkZ/f7RsW
	sEaFXWH/neuPjJASaEeHsK0l9OSqjmhoOpMPWtM4JIzKZPpLVUynlxDvTG7cHFA6
	+awq5dCep66R4z1/tDoHRKEonOzEXNd5iBRs7yuAeMaCtVlXU37po4qSxyVP/qRg
	OGPtoIY3txYizcUplhvHvwlA4Rz1nLd3fxv2fEkjo0+rAdYP85vLs+0eXSjKxdFV
	xhePCQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jwts2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b35fa876so79040365ad.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781081572; x=1781686372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSuOxyqohNyFghg6trX5SYjSHgMDEUyPSbSYNvimIaQ=;
        b=elh3IY4ySrbmlLm9peNP78J+QMmJPpwlWmLCzwqy/ZSpq7HlJFbTxgfTyKxy4+HuU3
         5NcrVusSykm/WIceVRVks4CRI/+Ci8HF6awHyHCk9PIl9hRzC9u3ABXMxAKcy+H2S0ww
         7wMl7bguotUI+kU4iOGULVnc5tcg8QKF/dMZWUiDepigrDN86nwteUpsPHMwsnfmq7ST
         CJ/y0EJwzmVVps46DACJCGQVKoNClhMlBdA3P/xBUgGZbTlYNjY29ZwRgjW7NIyixM3p
         KzzCf0daJXwtMAkk+gPwux9o1lm1szNVgNXJ5+lrrJYd79HbdVaI2G5Xm0aejb5IGUET
         Tj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081572; x=1781686372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSuOxyqohNyFghg6trX5SYjSHgMDEUyPSbSYNvimIaQ=;
        b=JNmvS56ci8Q1qPGLrhaB3wC9cG+6//N/ZfwHvcqr6l4hjwfcR7RXCHgun7ONiwJPGO
         wlBtSk73YNb17NkdtiYyRWEAsFlmceKLhOXbp+Tm+aD+NkKtkk/PHXWiDDv9G0YYcEGX
         Qa/plxTEWThCkb4O44MrqgMRoed1RMLIhxOLYrYMigiAYnAwi0Si7m1+Oh1ghKgt955S
         yAlfQl5jQq+LmNebSn5lmNzNUa6L5JmPVeGs4qwZH4txg9U4620OxKwRfB9xUGwAQXdR
         WTNVEG9LmsNHK5w957K+sTfkIrpzrN56QRgb1mF5ppo67JKLfrG5/m9LENAroOj5y4Hq
         OeKA==
X-Forwarded-Encrypted: i=1; AFNElJ+bWOhVS2rXZwBwLvSrXQjO5Z4RkGM3LEI5MfpYOD5Ivgy4V0Gocc4bsBEs+S9770smSeUnDV4pDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGo10zFdImh4JyIxPm339BnefLOW8goiXeeVtARSx+zwoLC6H
	PDWlyFy3O8A49GfvCsjgFnu2VMdmPMLv9FCrBW9iS2+Kosd122tfO5d8q9qn94VfVlEU8Cf1kea
	+5ej1oJ4QM2nK+nipn6U3IPcWTHjIFHyis0FzOtGFYHGfFJzAAMHUTbSHwnHVow==
X-Gm-Gg: Acq92OHXsMIN0jbURJ3f9WdIrjrJFIW+FZwOok0Gw7nsklVvCDgTIuxA2WaWITAi6Gq
	jWtw8fX7Sy+q3C1QNg6gfwmwsCr36Zf2bNks32xm35cg23iEL7cH5KbCWiT+pSgWcn1ZPmEtbBh
	OSOHmiRcr2Gqki85AjDdqp4wDgFzcpKqrTwacXUC0jxUYn1DsuDb55z2VAXOE17QKHZie7FveiV
	7+tVijLzjz5KheM/Tj7TvH56ve3vMzG4kxYSskI1Rq2hfMP7yCcp5GCn7E/txTDZCQSSg0qK5Rc
	xQMLekOwd+msOeh8BtyFQ0fkuDn2+z1UwWzDX7XBZk2KqgesmBhPqFWFCa64bllu8r3dyTYxfAJ
	hdtYcN/L4SoYqD8plQbyhSh/fpPASVf4E/1Jzo06fw280YGAhNxDPRXhiovDBwl19scudQ21QSC
	6R52rMsRrDHo+aHT5jj0f+PoroUX2SVuzGIikF9B8QJKDhKMKjTQY/qZInm/0=
X-Received: by 2002:a17:903:908:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c1e80ff89amr302918965ad.31.1781081571977;
        Wed, 10 Jun 2026 01:52:51 -0700 (PDT)
X-Received: by 2002:a17:903:908:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c1e80ff89amr302918445ad.31.1781081571486;
        Wed, 10 Jun 2026 01:52:51 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8acasm114618175ad.45.2026.06.10.01.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:52:51 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:21:35 +0530
Subject: [PATCH RFC v7 8/9] arm64: dts: qcom: glymur: Enable
 LLCC/DDR/DDR_QOS DVFS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-rfc_v7_scmi_memlat-v7-8-f3f68c608f25@oss.qualcomm.com>
References: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
In-Reply-To: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781081505; l=2333;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=4Fx1VL1dpIFfd4Qo0Yj/taSxtHb2Ax1sJaQX5XeZ+Cg=;
 b=BjKyZHKjCreiepd6S07vHbcdWfLq7M5XFoZPL3rzrC1KJGYL3mrnWvPRBNOAo0xvsE9tz7sup
 Y1kMzGHyWhRAn852ChSaz7twP6WkOVL9Kxk3S+FaEq5bGeKkbeTRDZI
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-GUID: 72f9kZGqVT7IjpJzW3rdN37vqEd487j6
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a2925e4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=-olaiSHPbsRiaquSn4UA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MyBTYWx0ZWRfX/daTFzcMc0R+
 UFuFJEgWTdNfpMdvToxdGP8ut/DZzyEsHY1F8ncJH77NCmNS65ux0gL4jVczliQm6yDyZgo0Tew
 WLvkalLhfrfPNXimcLBsgINFUjACWiBYSi44OByI2Ry3wUpmKPeiqcgwR2Y+YjituB2ngloj9te
 untAq7vGT8HCsNwmIK2Qk3erKQclA/iOam25gGU6Uzb0raMabKXg1/MJj+aT4tgZ4226fzcUVDD
 Wjr1M2WHFlCSDt3mOpLF7l7w8WRlCos3FvYaQaheEbjwMFjBczNStRkcq3oKK73EIEPzqSWioXu
 RTpHY1qsnsOZ4WU4xn8skZLSpeyQkpvsd0sM+iacTovSnSQw9fofVwouIjuPtoADe7EqKa6VFrD
 /CZq+bcBL+2LO0dLWoLoM3D9u0h1A+qslp001m4sUctHspwesLfNj7l8PqUZnagssXoVkeNvx9M
 9rb/uP2xTRVoTRa4brA==
X-Proofpoint-ORIG-GUID: 72f9kZGqVT7IjpJzW3rdN37vqEd487j6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100083

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

On Qualcomm Glymur SoCs, the memlat governor and the mechanism for
controlling the LLCC and DDR/DDR_QOS frequencies run on the CPU Control
Processor (CPUCP). Add the CPUCP mailbox and SCMI nodes required for the
QCOM SCMI Generic Extension protocol to probe and get functional bus dvfs
on Glymur/Mahua SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 20b49af7298e..c0edbfefc39a 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -396,6 +396,20 @@ scmi_perf: protocol@13 {
 				#power-domain-cells = <1>;
 			};
 		};
+
+		cpucp_scmi: scmi-1 {
+			compatible = "arm,scmi";
+			mboxes = <&cpucp_mbox 0>, <&cpucp_mbox 2>;
+			mbox-names = "tx", "rx";
+			shmem = <&cpucp_scp_lpri0>, <&cpucp_scp_lpri1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+			};
+		};
 	};
 
 	clk_virt: interconnect-0 {
@@ -6919,6 +6933,13 @@ pdp0_mbox: mailbox@17610000 {
 			#mbox-cells = <1>;
 		};
 
+		cpucp_mbox: mailbox@17620000 {
+			compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
+			reg = <0x0 0x17620000 0 0x8000>, <0 0x18830000 0 0x8000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		timer@17810000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17810000 0x0 0x1000>;
@@ -7103,6 +7124,26 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		cpucp_sram: sram@18b4e000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x18b4e000 0x0 0x400>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x0 0x18b4e000 0x400>;
+
+			cpucp_scp_lpri0: scp-sram-section@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x200>;
+			};
+
+			cpucp_scp_lpri1: scp-sram-section@200 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x200 0x200>;
+			};
+		};
+
 		nsi_noc: interconnect@1d600000 {
 			compatible = "qcom,glymur-nsinoc";
 			reg = <0x0 0x1d600000 0x0 0x14080>;

-- 
2.34.1

