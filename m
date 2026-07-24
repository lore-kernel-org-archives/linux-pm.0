Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03293AB466
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877585; cv=none; b=U1loSVBogzHneEiMOcH5s6c8vGXJAIYWFtmEo4WCjeYuKo/vLaaH6ZatftqiTGUXcwatP9KJWOw4JgvdIYaomCZMlT/CD8fhRtjcYbhsXObAL9Gl28KpdDBoeb3O0qNsRLw4hLznoZi8hK3F6UHB1PaZkQkZYXyD5ZsSI7f+c0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877585; c=relaxed/simple;
	bh=Yo9zeGbwbXV4rUNiXUL8lzuk9/G4RJrD++wGm42RLkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XU5YGRj9IouiIYcXUccwd6aVVESOX1n3gPRS/pBN2gZ93wEBHxJgejS58Rxlk8FlJRKd+cH6WBaqouPVDblRlfVnmoBeZfGUMWxsTfhUI7uUt7FTmenm8cwDr/z/CQYcCIjCnkmGPHEFYrCn6m6B8lDYtTxOlI8JsmiWXe+NqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNjt6WWH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXuoWpsx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNjt6WWH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXuoWpsx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lOZ31869163
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zNUV/8sm81bezTrvcZDm6VKxqfl3WlqL5X0WFl+eir0=; b=KNjt6WWH5tvWXHe7
	unp+sXXcCLjGMuI07DlpqLnEuuZXxTbUeuBRjiFsDdILuuYdT6RQn67fhXiTDbnn
	1aNbWS2ZakqlYwG2BK0QFViz7UIx7V8dMELyVBz9DApu+AWSKN6YynjDr37j90I0
	FkmjaPqC7NzrAqRbzFP/F/PY1ghIyIpf8UGtcDzUdgK3MYkX1Lri0k5OXQGRi5U8
	/Vck3er5tUHatkQMKo0SfbU7fWPIJpMH5dJGg7QQ7m5c0lXDH4xhBHqEvAQGNHu2
	gyeinpp3e1p8LAlj6bhogJ5aqft+nvxtHTtK2zcdg5i5jvbMDxaUsJJ/uOGFJe8M
	PJ78Og==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw8mtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cae455cf6dso2481005ad.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877581; x=1785482381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNUV/8sm81bezTrvcZDm6VKxqfl3WlqL5X0WFl+eir0=;
        b=SXuoWpsxcJLLrDUkgFbd++IL9gyMwvNwHa6+x56TNXVh4S0SYG3TftZDbREsG9OM34
         ICNgJUJlKJ4fUporLdCkB9KlNu2/c2N4atVDGmior2tXomQA/snYZajvMpEyIqdJqluB
         XZEGJIrZQ4ifksyQy/uzuCqEbNeSgxfbWjZPWszgDym25kBHW+UQ8Lt9Xx2DAy1cg+OY
         2OyESZAUtp5/g72UEKGC4z5zzPrxsgvtKps3poW/wZfhBfDh2hk+jvXqMVsWtpsH3v1U
         YWCVeyZcFcEioGXD18es/VyHrLFRaPQkoHuyaFtwX429rXbTin2dZ3MeND/+Hpv19QXG
         e0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877581; x=1785482381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zNUV/8sm81bezTrvcZDm6VKxqfl3WlqL5X0WFl+eir0=;
        b=hocHb9qVia3PJ9SZxksQe2Vi0JtFuIQzHs4GZR0dFYfpsLlZV+dcPO0WS680R7qX9B
         XSEHpt1dUZNxE+VyTrIdoA/rZiTXBp6+Nierd3W+7uIarruk9NN7IsBdsqFIwh8UeXbX
         eCIrTIKh++CwLVerZOVCdTd5wA5Z0d0uyjCV2p5/Ve3mGH4poGYGJZVeAnYkVlN3ypjA
         7I0Tou0dzFvtXhqQkdME00YmlX9zYKslX3rxBZdfTRHl3Z9aiB5cMKMEndCq6ajAJEFh
         1mkwZiu2MF7RVXPaHtFi7iN2QXSBcwco330ICzZc54sEY25Zpr3/QZMswWyrzL6gy+dU
         A+Xw==
X-Forwarded-Encrypted: i=1; AHgh+RpUz++ttO1MHVDT1+7YQ000SDoPggeABuxS+w1bwORK1KcmgAAG2noJIzQe4nDcC3+Fy2D9DN9DrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQBnitcf1+ECR2w6BcL4+TMt7xcBKZKL4J01/6Anu63YtluvM
	mwHHYFSad/pGaBN2DI9JKWjNyA3lq+PmKnOInsLkjm6aKFJxWm8TbybHMhJ21mMmRtAu0K+kzs8
	49UD6IVHYuqxG3teFAa2Uz50i+f6FadhXCTinZz7SS6GMTVn5BKYvRsmLKwQUVw==
X-Gm-Gg: AR+sD13yIbfy4ZxAxXdJu28Jc4v6U4IgjH4ADUHfyxOjcMcWXPoXmrVP7zkO32xegFb
	zbHagwdz0wjYVf9Cm2g6okJwxvR8U3TbHYDNAvt5A0Nj/1COUFG9v2nbB6BW8Qy8odnQAQzE4nW
	I2Tw6IYua8PB+e6AUSta1lgl10GF3loRFHu8DB2PbiAdjsuwEDSbVre1kdlpzfx1B9afbKWsUMZ
	8OSabWSV8ci3RTNzAcYCmmWIKT72itIapd2eueJE1hXTIjAkab0RWDKMXE8JC69UsbLnQLQaJQd
	v4Va2yfnkeGBFIqUrRh8hAjXJdOOJOItdFsS0lYSgIvIkOs+ffwhhXR0inCcYhju5QND2PT9ZP2
	DFNuMxDlyNpN0uqDLWnH1KSqn8MZErWP60nK8xthA8hmVZ6S2xlPKSU6Dm7JRG/Aq9fpIicCMaZ
	LCV3e4X7Afeoz+GoypPfJe8nFDxEA=
X-Received: by 2002:a17:902:e850:b0:2c9:9a19:df with SMTP id d9443c01a7336-2cfa71dc761mr69959985ad.18.1784877580527;
        Fri, 24 Jul 2026 00:19:40 -0700 (PDT)
X-Received: by 2002:a17:902:e850:b0:2c9:9a19:df with SMTP id d9443c01a7336-2cfa71dc761mr69959385ad.18.1784877579885;
        Fri, 24 Jul 2026 00:19:39 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm45993805ad.33.2026.07.24.00.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:19:39 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:48:13 +0530
Subject: [PATCH RFC 08/10] arm64: dts: qcom: glymur: Enable
 LLCC/DDR/DDR_QOS DVFS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-rfc_v8_scmi_memlat-v1-8-cb732bcff1f4@oss.qualcomm.com>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784877514; l=2333;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=aJgvkeU1hYS46AIZM4QP3B9a00RqrtIO/xjx76HW+fg=;
 b=hyNDpepWQq8DZW50Hf0XKBhuQW9YP8x4gP2ntWFWx1ni2fW0+zMs1ZDdZWb3Acb5szBESdj+M
 y7/hPXttUVHB9YFZsF5+60PtQo990FpWQysl1rMZga50QkgkPksdsW+
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX1oZBJhY5FlDy
 UMXGovMhX0lfjT0s6jBrRu502ew62pzOcrgUo0J63DHlRvqKHa1/cC2zaQGj3sIiQrpKt4TLvUB
 MbH48n/o5I2cESWb9D2Z4+CskL3Lacn7TzScB89yjFqSWV0F1vII3B3whZfw1GhT3OuyMYF5YJ/
 e8zbXCImsRRZwkPVcUxK5vxj7PB8S2OkmPNNJWXsd5E0i5uNY0FLBiQ753emHIp7VnVp07NtLjh
 UvyMOouXy7YouvnSJgg0gx3q4aFwL+ts5PIXbWOrk1ehjXz7acfzR+qI4vWDlB+wQT0pmdP6g99
 boKNOlGYhFgCX8a9CfPOek56kRXhe7cE0yisvzXD9wqrJv5Ae1PFnRE+ucmFAxjz8YNxuH3GATk
 OKNI2VG19MI207apg46E9tlUM+SU6v6qBIB7NR3jrd0ACHef2v0zxtoD7GrEr7obCGjTB5sRzYg
 EadNpUjjDb8SiMGIzgA==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a63120e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-olaiSHPbsRiaquSn4UA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: iqQEMlx7eRIRti-xrjY0yXhzOb4oQeOl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfXzIemp0FlXnC2
 DKjuhbyIh/6UkWfO21JGY+5vfhbcMWTiSIm0TFgiBw9pAJ1pfKM/d9uHVi07fRe70l1oK6UTuvi
 yShhlf8/QqT5uy+4brgAV2SMDqR173o=
X-Proofpoint-GUID: iqQEMlx7eRIRti-xrjY0yXhzOb4oQeOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240065

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

On Qualcomm Glymur SoCs, the memlat governor and the mechanism for
controlling the LLCC and DDR/DDR_QOS frequencies run on the CPU Control
Processor (CPUCP). Add the CPUCP mailbox and SCMI nodes required for the
QCOM SCMI Generic Extension protocol to probe and get functional bus DVFS
on Glymur/Mahua SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index f32af66a3f1c..32ac471e6727 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -420,6 +420,20 @@ scmi_perf: protocol@13 {
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
@@ -7658,6 +7672,13 @@ pdp0_mbox: mailbox@17610000 {
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
@@ -7842,6 +7863,26 @@ rpmhpd_opp_turbo_l1: opp-416 {
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

