Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344E3A9862
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591703; cv=none; b=iC3aP3O+q0Anoz65umyMSLBPsS65nmjq84IyAsKY57CXbZl1wyzbqvqiMTmJhA2d9Eikh8uXJ/d07JI/MV6pUZJV/7mq6rUxenEwaNyTzasnWPWvZpDHZakWwfQRxb1T9NMsGqmPFIHL7Id7CjwfCi+AH2T/fY7/HLXLtrhiJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591703; c=relaxed/simple;
	bh=wXEQdSaGgvvhyTZjCrPo1di1ubN2oQfPidI6Nv5ympY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jv2IE2q3HP1TIAde987v0g5xQ74HfPSqpsNROvsiGof7P8Fs4HS9ImUCCvfWBvBvo1dKK2GeGmuK8ChjgXaN071NqBcrV3zUGdO3S1fKDnng7u+2LVvV8YVyTAWzKeRV9gLlGTnCUEuhrvdGpApUyPCX8kiPCzh+Noga9RsoHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxuarqHa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bbYm7Pns; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxuarqHa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bbYm7Pns"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCgxQn1410134
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDUShvlFUbelpVH62uTctBCJSsxe3CkA10mFD4Q5XSE=; b=pxuarqHaLncNCyB8
	csJZQJr10cTRRjezO6EfKVdqXv1TvwnJ1M6o7CJd2jF4+5Que3FusbIkwkA+oZ7i
	M1p1Q/1pgAMH/vVaqVwEa/3EouDwR8uwfrvcpSP32Cudz9akVa1SADbdyXfWY30B
	fp5/7xKGVQPz6+yx7gf87QPEnz6WPqqA21mgmxU+2y/uFek6H1G7Veawc0klE3ie
	/CIFU2DAvhgERYqlLJ93bhxAK7JErNWbM9kzv+aHUv5f6EwiI8Ed9JsV/DMqlSzE
	rXmcLkxItmNmMK8EYWRWReSiOQEkyaREK4mLiZvp6hz7p38o2K5wC0ZNWrh9roud
	FZZQmQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f303ew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:15:01 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-631a49033bbso1290037137.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778591697; x=1779196497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDUShvlFUbelpVH62uTctBCJSsxe3CkA10mFD4Q5XSE=;
        b=bbYm7PnszEPrUvba+UHjzg5B9mUXPT1S3zMeeeU7PA1/7I6cIN22c/8kTjZu7+zqD/
         yO3m1hBZoQA/9hTQETT/rYMkxp7gRv4UDZzwVWrMxlhM2fPcqqwIJ6NwBVkmkKHTzpWV
         gG5gYCtqLkJ/iFxceKZNtK6mHSnAP7S99743fWnpOdUqXgZJKGr6Obj2Sv7M/OTqLe04
         bweE2WhZNe7KICaacy/3WfTinUdIwQX3zSUtveUkO++yIcTjc+D2IfoqZgbqmv9WnOYf
         uQ7gd609un1DzVFQWY71P+QLkqGgM7UYCjF/m4FwzXQ2/jEB/lGLzc0e2K0A3SDHJJpG
         +Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591697; x=1779196497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDUShvlFUbelpVH62uTctBCJSsxe3CkA10mFD4Q5XSE=;
        b=gfRoMGiaJ59NYoq/bXG2g3pwZ3aOilSNaml9lAbJZQ7+mBjYhAdUojErTAa8804PRe
         VGFwxNWBOFkkj91ScEQDFmXOwRzFDfDEHMzF2aiVbM7Fe7KERfPgVjc3U++yylsB1oN0
         qd6qK3Lqt+9VnHwcaonxsQx38mTC3cXxuz/sJmqDEoULyXozDIn7pZKWzXxoLR8Kj8a1
         Y/shF5CbbjeHCQIeBHrTW8l1es+VIQ7A6n8a6tcQf77oLeiaNRr9FkWALo8c+EEoMyKk
         7lf92zsHfZjbK4YRwBbwdD5+H0uVDmvj+4wc3Os/EtqfvgCoMkkIy1okC6KxIOLVbkYN
         PUxg==
X-Forwarded-Encrypted: i=1; AFNElJ+u+5cnG3OrRzhwomwM94zF8uyWaUpR8WHgxOV+7hrn5Rf9R8QZBApvPdaX+VDayWchcvwbUkgNiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3D7klyuGt78Yc5KmRK3g/3Hm9rWq+EYnKdw978if5CMzzqeq
	CcB+4KuraLkddwbwZa7TmnM8F05IolpKU0ulHRmCuh0iXW7c0vgAqDlKsY+ZbwEetPUjFqwgm6t
	oS2lV3R+jT3YBq5q1dSWyRhB/wEweQDTkoxS72Oyp3MVUbQ0KKle0mllO4eNLfw==
X-Gm-Gg: Acq92OECXHxtOAKZcWlvLMLj92G4TbojTH6z3wXYGRBrEGekPDuzBwRE1HW869rjabq
	S6WkYPU2nPvuhPBwbpAkHKbCSQ9p2UIUldOJ/V3C8+Zcho/8/5oAMSYrf2UfbmPAK3oVfnS8ase
	C4BHBxHU/9tk9NHCAy8biPnCrNPyRK6pH8yz8LRjsHzY/5yLiK8icf1FMRchnCwn/XPjh4DiFf7
	HvFMbkKe4fhTMLNvEwIJfBrNJ9FSZj9ZjYZ2GJAwFz/QibvsUv3k9nlr9fAvsBuMZxxPhZiMq4L
	0IxKSjiANPpgnK9XYCm+M5x9v08HkQJ/KwxVwnxFnCP2C2EfQI86i8hrKFiRJ23V+vvwJ6iq4Pk
	YDkon+DXZcWQuYeqbpc2FJMpMIOIh3lvQkOlHlKCgVMa9Q/UIj+y0w0lBE8/T0Z3IoyNlg4rnzB
	uYOQRiQyPE+4MoertlrMJYvFRl5Ul3PEVGDx8=
X-Received: by 2002:a05:6102:2ad1:b0:631:487a:238f with SMTP id ada2fe7eead31-63613ca7c06mr1105063137.4.1778591696598;
        Tue, 12 May 2026 06:14:56 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad1:b0:631:487a:238f with SMTP id ada2fe7eead31-63613ca7c06mr1104996137.4.1778591696092;
        Tue, 12 May 2026 06:14:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f395d5sm35163281fa.10.2026.05.12.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:14:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 12 May 2026 16:14:50 +0300
Subject: [PATCH v6 1/2] arm64: dts: qcom: sm8250: sort out Iris power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-iris-venus-fix-sm8250-v6-1-51856dbef83c@oss.qualcomm.com>
References: <20260512-iris-venus-fix-sm8250-v6-0-51856dbef83c@oss.qualcomm.com>
In-Reply-To: <20260512-iris-venus-fix-sm8250-v6-0-51856dbef83c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wXEQdSaGgvvhyTZjCrPo1di1ubN2oQfPidI6Nv5ympY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqAyfM06MHkt0moDhI5mKTZW7jOm76u1NtvyfO5
 84Rk9+KImCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagMnzAAKCRCLPIo+Aiko
 1YAsCACDBh7fPyk71x4p9J3O7KsF5Ma/aNnd8AazJcSXJuqQ2wrw+jfoBVedICMuvvHdqO/Alb7
 YGZmgsEwA2h8UNCsjEruM/GXZCv+mDwHSs5ceaRdMTaaKYrIi8qNj0pq+VIXTiExhpzc3NI++7y
 M8pqCaeue/6PVtwq689utB9Q/pI+68nACq1KKhZXm+sWtZbuZ//FrhAcgPybUzmk0zZ1rhxQF5X
 n/0dUz/WvOJZ0T23YTlnUcRGcLqnphKo/AvhnM7d/9COjTR+xUsfWvsL5DluNtVv8rjOrc93/9Y
 HX3cyLuTBVzqgpDbAOqNhM9s2i55fIFr6Rls5AahdkgXOO9I
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: PFeH7o71RsqCkAnnWfVJAN8X4mF42F0H
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a0327d5 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=rGr7YpdD5vYbGY1z0rMA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEzNiBTYWx0ZWRfXyN9scqUl/6lm
 6zxIDKuDs2m5epZJbbqq5YAg2Cbt6nNF6eRMNPEh9/zkREm/Pl2J+2vbLypxgx7hEy4KW48+/b4
 l7MdUyiPrA96DfHLc5SkdvAc/McRrdZpgbsoXixCDhjXHCvOUHYN20SrujuGatPxT/sk+fZPX91
 Hf/o6ehbQUEPlUOF3OnYeqi/uDIf0z4LzpY78pd/MqEQLu5mhonKVs0ITXmryc41D5mMqeyesbt
 jeVnw7Ogd9O1qrdXP+CbPbSTzYgTHz/OV5bVTN0d+98XbzZBFEGPcThQ8j0DvOiPCJ2okuhCE3t
 m/pTWVue+/cO4Z2na2/+YBoDtV0bemzs4Wf7RkpdghVlLmZN33cww9DRk1cHDfTli7R/VNT43s3
 xRdtn0RCj5C0h1sH6XZKczrXffAAW/gqwZAlk/tefZLHhsUGbc8UurvTYiKT8dnMEK99Q4QYasj
 6TNXMdFBd9OCpMi9daQ==
X-Proofpoint-GUID: PFeH7o71RsqCkAnnWfVJAN8X4mF42F0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120136

On SM8250 Iris core requires two power rails to function, MX (for PLLs)
and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
qcom: sm8250: Add venus DT node") added only MX power rail, but omitted
MMCX voltage levels.

Add MMCX domain to the Iris device node.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 7076720413ab..1fcbd400a3be 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4326,8 +4326,12 @@ venus: video-codec@aa00000 {
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc MVS0C_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd RPMHPD_MX>;
-			power-domain-names = "venus", "vcodec0", "mx";
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mx",
+					     "mmcx";
 			operating-points-v2 = <&venus_opp_table>;
 
 			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
@@ -4353,22 +4357,26 @@ venus_opp_table: opp-table {
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-1014000000 {
 					opp-hz = /bits/ 64 <1014000000>;
-					required-opps = <&rpmhpd_opp_svs>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
 				};
 
 				opp-1098000000 {
 					opp-hz = /bits/ 64 <1098000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-1332000000 {
 					opp-hz = /bits/ 64 <1332000000>;
-					required-opps = <&rpmhpd_opp_nom>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
 				};
 			};
 		};

-- 
2.47.3

