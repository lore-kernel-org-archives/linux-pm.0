Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166614F9FB
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311094; cv=none; b=W8G8c//yufJdc50dANssceOnbs/u8bHpUp0d6QkI9Iyt3sHJPYKAoyw8h/mOD+Sne/WHUEDwMlKMAktIA5RzjlrYqunZH1xW7gCUXM8gsmjmU1djok6xJAJNIHv8/CeU0YuWHqL/Babz6FMOU+ObM1q0mLYxvIcSfx4yKhw8gGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311094; c=relaxed/simple;
	bh=8tSrjSEctrELGYdxKKPYShR4TxJ0d51LBO+dSM9b1Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUAXCqgrCsbYFx6spiX8Vu8lZUfxTkwM55/3vejl9Rqh34Uh/T1EnKtbnV6uDEEg6KZjF+IcUfZcbYwn6MfMDZR9KIyxg7kLriOZVWez2CWWDsKU2CZ2HEWrF9oSra8HjO5KJLSPxAXB0w4fANJE1fP3riUDs4M0OekFhRH2hVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RG3qecOQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VbZ+JsFG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RG3qecOQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VbZ+JsFG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqXWk3634280
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gcMmeQeTt0vPXYhZkgPaoPSS4C/8s4GILVGqLmRQBys=; b=RG3qecOQkaDTHSL4
	xgp4ZiTS5rrtr5Rz6bHfj0v8xU08DtquU/reYMwmV6yvVHhGI63vk0MNERahhWeJ
	7YZqnSXrscG5bLqyv7nLGls8/HoQsySkP7oOeHetM6GaO0tbczzru0Wc4MaO2ro8
	vDdA0flSyX+d8stjPaOYZPtIrbssdnPC25MRLpJE3nbjS57wroQXtdJ9G0e4Czte
	fYPcn5I41s2sOwFjdg8BL3gPK3Qwlo7Xa2UyQVdHpDxm1uX9aXhWEj8+i4yO5jlb
	3D8BLLoOaIaEG59FKF/8QH9uVLq8QL2J/EogoRSX+fiErL1AsfUcm0BGtx2O64um
	ZlUDiQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4jhh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b3544bc7bso10976451cf.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774311087; x=1774915887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcMmeQeTt0vPXYhZkgPaoPSS4C/8s4GILVGqLmRQBys=;
        b=VbZ+JsFGwjHYOG937HkN1HLLwohlqADwGexalkzxZU4OQBFwhp0UyBCX+bSQRWF6ys
         +QPN5j+vF93iKrzPjzw2fxvB/1GOJZFVWbtl6dfuy1VmnXUDCfuvnYb+E8/r0xfRkLue
         /4MKt6Qs1DqIXECqjINxVGG8lcI/DGtzNID1E6lKFk53H0lkPI0KGNC++4pMWl6M6/Fy
         00spB6cEtwB3WrcELHYp+Kz1ziVV1a4pLVXJVo0I3X8i0rpFDokSroYIH4qJ2dRCKJEV
         gVodOyZ/3+zebIL59ARNXX1uk5IIfGSMr7V3RqzRoMQsP4X+K/YpZigwrv2buBbilo5l
         0J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774311087; x=1774915887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gcMmeQeTt0vPXYhZkgPaoPSS4C/8s4GILVGqLmRQBys=;
        b=ElBfXBK63MbXkzPXVcFICc6f70FVIIVkDh8dHeHjyf2TBn9TKSjTYtSFHySbH5LFxT
         96PiIZs6Y6d4tKnTMX79SPYzRH5CfXlWk05wglUKcCautrZ74c1Kawu93Kny7prJhEKI
         o5kgSrdv6j46yFEZtzcu0m9japZOxKwlpSN5sZraeg4uwd88KfSsUtsSP3WJcqcXON5+
         j7iamHLQYrlI8HqBeHffTIzYPCOgeIL0YDlx6DDjtZ1ggiDZ2iNs09LaQEgT2GeWI9eW
         SLiSzN/S6pGEunBIIGhTFydjC+8V420xbtb5jV4NnTNeXAWSgqzyVH6GCm16AJ8BP6lw
         83cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVM5pkpiVo9fo09oq5Xth2AtDfsghyZpT5h/g19C5fnQmXUcYHXTSxmQHSjwPIK3EtcYoVTGg76g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvt3tRxYxgmXlgo204xeFjWl6bulj52uUrEn039Q9IYLygioex
	tY2J40aI/+sDrfAPGcc4nx+CL80OoAA3wIfF9FqYBHyJCbNqVghaHzafClF3Ykjj6ZQyg+VeXSr
	LyhMoSu/513k4n7uL8JvTN7zCfEcVD5b1K1t88/JyzGPLfNTsVSqrxEdzA+MUIg==
X-Gm-Gg: ATEYQzwiLTSiAjyLhmtPh3HZSvI1q6OCIva/Svjm3iSZ+AJaXOPcPpg+ONulyrbV664
	0zeBEQgv6iOAoLQBpCga/6PpppHGXqfC+Ey+f5uHxyMOlRMeHh8WQgwxi6KwaJaASbUUigOUEe/
	HncdbI1n/SohVMGC4F7EJLSQRYtA64r4GCfKHabsUkEhteulkJth4O6icKuI9H8K8Zq6QOuK7Sy
	4IkBMUcwunZJyj8mh1tp2hWJmQM9DD7wpxRD6UJ+2rFXcBjOtKLt+pGi0tgpBwm9kYWnhuXtLDa
	i6zCqn5UecPTD1gtygngt9gqI1ppvUjUc4VqryELuCAdppTHymHNHTeT5ztIljt9ngzOGKf3YSa
	pdv4lCe0YflCW1hF9shDyU2z7IaG0XsTwWbuvIWJh3v9moTKFeI8UyoKEPsuEVVqeeZo/Ae1b5I
	sRoLGHkGto6ueAQ12iPL31dUV61FTKneSteh0=
X-Received: by 2002:a05:622a:1c15:b0:50b:4435:5dfd with SMTP id d75a77b69052e-50b4435710bmr197436961cf.1.1774311087365;
        Mon, 23 Mar 2026 17:11:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1c15:b0:50b:4435:5dfd with SMTP id d75a77b69052e-50b4435710bmr197436641cf.1.1774311086912;
        Mon, 23 Mar 2026 17:11:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf99820f6sm30339021fa.19.2026.03.23.17.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:11:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 02:10:45 +0200
Subject: [PATCH v2 9/9] ARM: dts: qcom: msm8974: Drop RPM bus clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-msm8974-icc-v2-9-527280043ad8@oss.qualcomm.com>
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8tSrjSEctrELGYdxKKPYShR4TxJ0d51LBO+dSM9b1Kw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwdaIRnJghTI7Tp6JqqPF+fMO4Ob3Szr/vaac/
 QSs+5tRH5yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacHWiAAKCRCLPIo+Aiko
 1clIB/9XPkTyJ4KuDtlJiZENLt+iFlaFmToPS8SnTFbZ5gEbQ5a3EJqooOzwp8+aPMiBRkdVVmC
 tsJq8pS12CWhBCfuPPiMvo7MR+5z2OlY562s5pZlwAUk12BIUzMbuRy4C3LkSTdwBV4itBEd7lC
 qvX9yyF8HE3S1Qa4XUfufl1D13Bnh9GeDPBh32vOjBUnPqOIAqm9PQ+4DEum6g2Kk+l3Vf8AQrp
 dvAGgMzr220a22Pam6BnjSwyg8Jio/lLWDVL1zPDcmFzSo/W1OYXh8dcDV0m7XLkpfqyWRLsb+h
 ruRwPgFg20qCvR68ePYu8hk1qkzCuxx+vfBAHRoHp+dsR3q1
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: -NLGNYM2TzPaoLabyrjZJJo1ysz0Blxg
X-Proofpoint-ORIG-GUID: -NLGNYM2TzPaoLabyrjZJJo1ysz0Blxg
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c1d6b0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=h6rqPeke2OkJn0bzelEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAwMCBTYWx0ZWRfX3OF46vzJtOiG
 kZteZuWsj94gvhDwzWlgTvwOhqFkfMsbmPhozTOYxrMyJi4Bpa+PG2PuoOHdKcCEL/d0IruIrDw
 wPmA6x8buTmwHU6vvnBLwOPUIkjeVOelBoewHo48wUYhacBYZwXpal7+s3IcnFh0eMnteVfAj2w
 Kjwq4Bdd+l7G71G1LOtOsUxXPKbQom2YE+Xw5Qg3ZAv239q83QiSFn4X1TbhZVWY+77sQoXdBJh
 g5FXm6BT9hkTZ96owlyVxdgql5+l+oKslFZ+y+KDEkhPVFKYvo1dJhBLk7NkcKxlBtnQyNVwZiR
 lQ1vJPVcqbfL3dchS7amOHGOmkZE8sM/y+WSvUU28aTmaoFIz6m6z5aNgl9436fVtOsYliSckLv
 nuwPCI9/+c2EVIP6eEAFXGxBu6y/xBq1jJFznC4yIrHvblRgxV+oh2gYjQG/Wtuh00UBvJvZqpr
 rqBY/g7wd1Wt7SCwSyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240000

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
index 2a82ddce94a2..95be1d2e214f 100644
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
+			clocks = <&mmcc MMSS_S0_AXI_CLK>;
+			clock-names = "bus";
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
+			/* core clock doesn't exist anymore, kept for ABI compliance */
 			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
 				 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
 			clock-names = "core", "iface";

-- 
2.47.3

