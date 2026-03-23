Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FF21ADCB
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228679; cv=none; b=b0u4WO7WUWNcyXJVjxifDtjctLJMwUk/rQvv+eVVHMc5IC7F6O6pvp+07cnCxMoSiAcysgnB9fdG3ZgOLrPhzdVdI168V5xdDSFW/Sy4pHMhw98B3FVz9SQKnW8uPF84tsstqTGg5SdSau1uu9JV99C1+8TSqv2jHsjo2ltrxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228679; c=relaxed/simple;
	bh=+S0IFBZw92HGwmKPKSp5T6BC3eDkzODFf2LEmOeC4hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acSq6ctH3V5EqEl/h53L6TYsm40ceiubgQmjqrHseSe5d9Xun/LcaL2xcX3Wboa7VNe2CRSqTW+p2dCH8vOk7tSQrsuVIie2c/LPhvlAFDE/Phe5PRE6bLnQk5fbKZC1QxgwGT/lrRhkcvQzeL5QT9hZlTWaL62fVIrwfwUq8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=InkhzLxd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AvgTEbCP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="InkhzLxd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvgTEbCP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MMhYBJ303995
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PQ0yY7wANsCbi+N0sJM1csjMHIR4oyLtsNwiNzciyC4=; b=InkhzLxdNrtVKwKD
	QrrIbsE6dS+ZW7n15JUFXCT7rEEGgO3uMYAMADkAGGl1bCh/xk6JDnlKg+2oO6fo
	Yd/hriA/t2zhwvQ84sclpaNXhVJfR6IC3LTQ30F+RJGDezEPD5PY6ir8+qw73g/e
	WZxIFsAJV0O4Z/skjPQbUEI3HebaKw6Ai5jrhp0l0R20YzaS3Kb2GLnGXurieZPb
	NlDmXPccnUQ8rIY/tZCAW8U5WoIy5fmL7jgLvvgkrN2Q/5GvHjgpIhHFetMQydxL
	BegyZ38+kooNQupfHYkMOoCDsnPR1ViO2XNJOMZkSzaJLuLtrZJaMJ4mh5LpIec6
	cTs8ew==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e3dc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5091327215dso57673641cf.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228676; x=1774833476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ0yY7wANsCbi+N0sJM1csjMHIR4oyLtsNwiNzciyC4=;
        b=AvgTEbCPtw66V1+yr2TPDV9ONCNXr0UKPAE61iN2nKqAODZQhBNxqVCk1Uwq134nxW
         FL0aGF6VhkUo6Q7ofAPi4wLpnr4YIM76zEpRuoIE8nLY7kk+7UJgQLNXzxV9Yx7UGgl1
         9tNeOU0LUf7BZXSyk2XhLf1Z6Ja2MgaXOy3uQu2aTv3CpoO+HgAWTNsAN7ax/yWHCzDI
         SFF0co2F1bSypF9WYpRs8BauwShhc+47IrH+8PMA/dLbPfnJtV78C4jkTquvr/MXAsK6
         PPxmPEr1N0/dtnwT6oFCUaJCIR+DN2nnMuQ5hRopGwbxrnaf10Fmt1fw+JpoOZWWecWE
         G0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228676; x=1774833476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQ0yY7wANsCbi+N0sJM1csjMHIR4oyLtsNwiNzciyC4=;
        b=m+l59OilYkNjPAjvjQCuTQ4Z86VdbXeQy5CgL1hK8cAxjh6sL8uNV33DKgd7NU+5GI
         X2QV43pFedrGIJVHuS/iFJRPVfF0FVZzx2pkRvDi8P+immmmtgHQ28t0LeIbMBQleNn0
         d1oA+DV+tg8vnC842xo8sFGbvVQqU9Zrg1deTqkh1I2gbI2jWsbxxztwxkPyaFny0PZ+
         8jAve08UR0jWufWp9vHydRNNL8BJ8b7+G8cK8LLAQDneBdvlUT4LEKxluC8+eKOiVz/s
         xRsr9DfykL5GpfeFU18iiCbibeerXvrk3MdWvXvUVqxWMhZT3UPo2EyjZB2gkmQIUMEz
         qUgg==
X-Forwarded-Encrypted: i=1; AJvYcCXk7Mexbi9OpfXOJvRVKeNbqL/4WjhTgS8/v8O4uSs1iCadV/SvC5hI/IfIa5GDwlpCF2GWGjBuyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs5NnQWeQ7L+ekuhWku+YpeVAWkQxPDn8/1OPNyT+/AqlaFOl
	+R5nil3gaLIs8HdPG0ocsxdRMZXtn/4gGzvjGYIBJzIivv4aSiGB5DzF+s3RWEmLDtpE2i4oGnR
	gebyut2SMDXVzEG6NkeQvEKEKjAdpqpaNNashLYGcGq/wr9/Y693I3F3ZYfpX3w==
X-Gm-Gg: ATEYQzzcs/XOzDVf1pRc/Hvvgqozt0z91EDs6l4JRas55iAlQepAiJsNkOI1o6AAo/G
	ZKLrrfgOz6OLYvSTd7CvmfyOXjgS4zJstGTwWBtBkNEnOXPx/52MFLjEgzvqSqnnhrXGo3L+MD0
	Iz1J6vQGmmBSAuC7J+nYGNCmLflXkY7jpmXwfOjNh1tuqmzTKsn7dEkTaRm1MLKhtiDYKGvL+7M
	Z9gcJhYGBHze7sq03TDx6FBZxIq6gxaDUILqAs0G9V4qDV0xcGXiBhbub7T2AlW0GunkjKG33NO
	uJ6BWWFRlbWuaEeCfdS/GGIqVQkNA3FC3yRDqUWnv1GUPN4UCxUs7F0+to8A2r4qiPVT+ce91wv
	KDUFQOEqA+isPq5uuLAL5Xz3+bIlfM54YC9qACU/vge7ufZF9kpiMnJxHcm1h0tqsm/7GS0/miq
	ev+i4rkCmAMpTnrSlEOa8pK6Qtq9ATO4M1N50=
X-Received: by 2002:a05:622a:1391:b0:50b:1e5d:9930 with SMTP id d75a77b69052e-50b375a89acmr163336941cf.58.1774228675834;
        Sun, 22 Mar 2026 18:17:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1391:b0:50b:1e5d:9930 with SMTP id d75a77b69052e-50b375a89acmr163336671cf.58.1774228675331;
        Sun, 22 Mar 2026 18:17:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:17:25 +0200
Subject: [PATCH 9/9] ARM: dts: qcom: msm8974: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-msm8974-icc-v1-9-7892b8d5f2ea@oss.qualcomm.com>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+S0IFBZw92HGwmKPKSp5T6BC3eDkzODFf2LEmOeC4hU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+aBKfMbLu84rLVA3DW2ssnV4f20E9NUJgi/V3rY/T8or
 aBqUqZnJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmol7P/odfoY+pRSO+LG9b
 Wt1OTWGzk52alZFmuz6my/Ymp9z/nfj+kdurHfEtAfc8PXJlYp42i6YrKOWd37GvStRNSfqyYqr
 VT+uDLnL/nBYdZ4q/dFvarfAI06uXKQUZU001Qj+2eUzpWPgh6/eTFz+X/m7ySq7NdJ1jM9nk7N
 Yf+7LNP/QsEN+uZLhN61SV+VH2pUuFbqyP3f3iXIqej5hWnMdcryOC928YR+enNByetK/iwJwwx
 gtKRwJ5OexzimR/NHb7C3Qta236XdP2h3XSsSaf3nRHHdf//28Kdj5t+LyPp1wwdvVMq2nnLfmO
 3Q/SL0xsfePnI2z+q/hL8jEfpk/JP25nRR/JVlo/9+kDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: n60DD-GigN2zxxKctEDY2YGXsi0AoLdl
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69c094c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=h6rqPeke2OkJn0bzelEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfXzJ2g6tUuBSIy
 oDM+Qz3g1ZX17kmLasa0sU80jhc1pnqWjglwITigRHlBJiT7W4IM1OSfnoaFZ50tz1IuT+W7DSF
 7sMFmBr0RlC5OI6/iQsSU2dlKCm2iTA8RFqf4ZRd+1o45MnsE2UcailM+H8vJ575A4FY0+MdljS
 stsSyRciTWsP2oNeZleUj0PjEkMYfpwdiabzspBfiKGyW5FSUXfnHW6yvU/L/5UiqMXw5dtp62N
 2frznp2hTVeyMLGbaKrXna2PKNBCtN5+9uw+WX41ZBWFzd2bwadwgHbvuBhj5Ufw+Do3zlCfBpO
 D7JY17qJ3SFKb8R0WSCHtvgNN7YyndXz1LEivgxJaAaJk8MEaWXZDRGo1jGzFATMUq0xEhJeKVu
 xK6jhWC49F1iveEE7a8MTRu0GmfOur/37kKCWdLSahu/vIORvHPRyULN5LrPS/EUCQ7BUqYBLCS
 1MHwIGFZxFh+RfqnYQQ==
X-Proofpoint-GUID: n60DD-GigN2zxxKctEDY2YGXsi0AoLdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008

Some nodes are abusingly referencing some of the internal bus clocks,
that were recently removed in Linux (because the original implementation
did not make much sense), managing them as if they were the only devices
on an NoC bus.

These clocks are now handled from within the icc framework and are
no longer registered from within the CCF. Remove them.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 2a82ddce94a2..7060de4fa551 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1115,9 +1115,6 @@ bimc: interconnect@fc380000 {
 			reg = <0xfc380000 0x6a000>;
 			compatible = "qcom,msm8974-bimc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
 		};
 
 		gcc: clock-controller@fc400000 {
@@ -1162,45 +1159,32 @@ snoc: interconnect@fc460000 {
 			reg = <0xfc460000 0x4000>;
 			compatible = "qcom,msm8974-snoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
-				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
 		};
 
 		pnoc: interconnect@fc468000 {
 			reg = <0xfc468000 0x4000>;
 			compatible = "qcom,msm8974-pnoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
-				 <&rpmcc RPM_SMD_PNOC_A_CLK>;
 		};
 
 		ocmemnoc: interconnect@fc470000 {
 			reg = <0xfc470000 0x4000>;
 			compatible = "qcom,msm8974-ocmemnoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
-				 <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
 		};
 
 		mmssnoc: interconnect@fc478000 {
 			reg = <0xfc478000 0x4000>;
 			compatible = "qcom,msm8974-mmssnoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&mmcc MMSS_S0_AXI_CLK>,
-				 <&mmcc MMSS_S0_AXI_CLK>;
+			clock-names = "bus";
+			clocks = <&mmcc MMSS_S0_AXI_CLK>;
 		};
 
 		cnoc: interconnect@fc480000 {
 			reg = <0xfc480000 0x4000>;
 			compatible = "qcom,msm8974-cnoc";
 			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
-				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
 		};
 
 		tsens: thermal-sensor@fc4a9000 {
@@ -2223,6 +2207,7 @@ sram@fdd00000 {
 			      <0xfec00000 0x180000>;
 			reg-names = "ctrl", "mem";
 			ranges = <0 0xfec00000 0x180000>;
+			// core clock is unused, kept for ABI compliance
 			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
 				 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
 			clock-names = "core", "iface";

-- 
2.47.3

