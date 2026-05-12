Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B63AA9D8
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591705; cv=none; b=BF/T7b73B/WWJZcftAZht6qdq96xD4CSoXlcszUFz8hnDoh2VPGQFyjstIGFHXivHlQ3583z+5ooP/s6NtMGiCrcsri0ac3EktLJTHC934HwSfKppCZpys+CUUw6Wb1IqrMXQX/+FR5AjjujAR0AMYrIvyrWx+bZrLft9bPcaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591705; c=relaxed/simple;
	bh=vngOrHkgNad1Q4pt3o1jl/qHUnWu7b24wMujj5oCGFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f70jF+jxhpDDfQjNLCK027TTA4WlqewSFFMX33yL2lBRtsQlS390yEs3f2ctrxh/E7+oC3Qm23WSvujX4AQ4aio88R5p4rYE3JbmrRrT3M/F8sGgdRxwlidKYROg9oPMO4CN4mNpIdh1jNjLIfKhPg3xeX82tsp8n70BnTn05tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vfd6PmCB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZEypaob; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vfd6PmCB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZEypaob"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCL256545266
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fDo1vV7+IOyQcOn5Aj7RJ30JqBUruSiA9OfWyU/LZEo=; b=Vfd6PmCBfd+Rg+jg
	6RluTjMnnwSC+KO6mMAwb1VhwaU+ETxHk1On4h29lWOAvELvVKushktz/DactpZH
	aZpi+ZYncxm/KAlJPw1z29B6OKjsifsIhaXHvJD/4QE1C2EF2DeE0mMfQ7a4dkT5
	/B8CGl7H2zDBoXz/m7NWcpy9C8wQjcrCuyYP40tqix3p2xrL51dFiXPMua2F7NPv
	ktd8z9LhM6x9Mp1/P3L4CNMP6DbqU/PNhPVjfHfdttlRr7s/LqpsH+AIPZTMPY9Y
	D/jednpjaJ9TbLescHV0RXQEF2boCk5FHCQ2O3W2OTssKsGJkP2WI9utFiLmcy86
	OEkvow==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e444sr5rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:15:03 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95d5f0ac588so1939264241.3
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778591702; x=1779196502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDo1vV7+IOyQcOn5Aj7RJ30JqBUruSiA9OfWyU/LZEo=;
        b=TZEypaobp60AKwUlPncDRpWO8xAmNnHBTZmsuKP30nLJSCMAHUNSf5V/LWmuVt7L4h
         KYQjRbRVJeQljjY0tcRhFgaP9KjOs/c0ZshXQ+IyLABO46NSWAizlCPQK07pCVF31npo
         sek86r6xjVDo+2Ep/UJcRlcfJYRVomWMLxCZqJtJS6qid1Pyed+w5DCJ65lh8NyKbWA4
         D4YStcOaTRYPSRUoLly5wehT0FR6g7G3warj143NALYfbuWUie4eoOa66nYfc4tFgjWD
         eMIdO/kmn7etx1T2ave0GVwbYr6Eju+athYCL5Jgog9Mlj1GOv6Qkdwju1KQHN2hcLAr
         cXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591702; x=1779196502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fDo1vV7+IOyQcOn5Aj7RJ30JqBUruSiA9OfWyU/LZEo=;
        b=QygzficSoEkbIFdgxxsSOVBLHEZdhxqQOl+eRWX+E8hBcujlw6C7+v9KDlt4ieDno1
         tgSvtqAUtxD1Git939aBapqXhlXGRRW3grpHehkj+/PJ1oAirHqjdYIt7pWLHhGe3QXY
         VPo2Bc8ZWfNcJiv5sWsWX9IOdN5NYZ09L2zrj3nhtoVCTjI/9ufOr8n8O5InjdAgLP9W
         RMcgb/t9R+Q5um2O05nvfzCvTmd8VlG8bD6SJyJ6CkIBYztJXXnD/PVOGK1GpkrcIEa1
         zy0rqTA/FPMePnuLVvyh1CtfQbs/XRbdD6kuV44stw1dWKrotnAJr6vaFZnQVjJnVo4x
         519g==
X-Forwarded-Encrypted: i=1; AFNElJ/Ow7PD1HlYojrq1MTmwDsIXIde+UMDm7pcPuPOsxH9f0GnVI+Km9fSyiG5lST4x3+mVd1voCUTVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ro43IMcXiERm8uPUb9qCjuXMOtM3KhCu4wPrYIngQDFMAmDJ
	mmUbBG8wKGLsic79QS2HZHgKEv3bwsoxpOSH2yitfV/lUjuIdb/9qCBowvdaJYzqQmo0jDLKWdL
	QZNmdb/5znjGUbO2mhiBPz1wQ+bYSGGL+Sp9xH4N3tuXao3Ebtvo+Ld6nBFXGDw==
X-Gm-Gg: Acq92OG1lT1QUCo+TXiDywnhxgC9MIv/3FzY3ZHZ3rSpNENLrHrnkVPfX6G5yFsIAB9
	pasNYCRdngGEPqxTmQQksjY3f6i5tlkYjnU7eeXp+B9xXtupfR4EM5jifYs4oLScMohVzz8HV7B
	p7jZ4MtNXSfw8uUZNr1jz21bpLHNBwUxK66nCTG6hAkWphGq3bxLyXGSDd5gtWhE2ehu1vipsWV
	7TsJCGThFfKFpf9dF/XeRt2199A2yAA/gGuw8jdeH48TQEcYAWtDHY3D2S/YA2A313TWqGBzh/V
	okyPOwHCRgLZuyImUZeJ16KWmvXMU8NawxzwAW5WcBJLz4Dz8ZKCW4a48bsuJu7c3oVea8ihGrQ
	GoKbLQI4XaZYrz15OgQALjqSO0FhCNU9wCKTUnuOJl476Xl2RR6c1DFR/MBZCzacCxWQIGHOyLr
	LWlEY/30eSKbp4Dl9vyv2aeG++JTysj/dx6eQ=
X-Received: by 2002:a05:6102:dd1:b0:608:9a34:c8ea with SMTP id ada2fe7eead31-63615810378mr1185920137.10.1778591701765;
        Tue, 12 May 2026 06:15:01 -0700 (PDT)
X-Received: by 2002:a05:6102:dd1:b0:608:9a34:c8ea with SMTP id ada2fe7eead31-63615810378mr1185809137.10.1778591701211;
        Tue, 12 May 2026 06:15:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f395d5sm35163281fa.10.2026.05.12.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:14:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 12 May 2026 16:14:51 +0300
Subject: [PATCH v6 2/2] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-iris-venus-fix-sm8250-v6-2-51856dbef83c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vngOrHkgNad1Q4pt3o1jl/qHUnWu7b24wMujj5oCGFQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqAyfM4ux+oBQwIZEZ6sAiS58J7gOTOLKiw4t+w
 A5ZjUc/POWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagMnzAAKCRCLPIo+Aiko
 1XgnCACOk+6lr+9DepHGfXKgOi+V2oxMVbImOmk50sdWQH2yW2zGxO3qMWy8WDKyKFcYwDTVMGE
 bbhvZOrvJe3WNY6XGx08fVJ6nb2jJlHJ35F13lYNj/faKykaE/e6tNIjkLRALQ7x2lNuViH0woS
 JXBb3+VF7VNK2oxsNktug9TrUpq2rTot9dFilMmlV+A3qDd/4k1uRmRFiqPTyT9W8tEERKuIo+B
 /gj5V0c8PgMrzptJLAZdln8bLe4NDEyi07YLT4m+OApasGBFAQ6viNoxnKsG/vA9USyorLdJety
 u149cXE1vBy/nq6wWDaZSEJXjGA/PKIYl7BNSc53rjLpPt6m
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: HL7FezKvxqqa7C_wBckj9Oy5GLmHSz2A
X-Authority-Analysis: v=2.4 cv=OcKoyBTY c=1 sm=1 tr=0 ts=6a0327d7 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=EQKuo8RqpatckOKiKW0A:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: HL7FezKvxqqa7C_wBckj9Oy5GLmHSz2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEzNiBTYWx0ZWRfX6palXBuqcfFO
 oonAzHBq0o91Xt+L1NsfnzupLa/rgxcA7ld4uCGSDKJg6fHguPh97lFq5VOFUAnt75Lnb8+QHvl
 ddxzWuCqVKHyyHBJqnwm0ajaj2TyQ6MgCVX2e9W9LPus5EGWq+dYoQWfGXetjxebEZQkCPZuCLs
 wqt/tyEjGNcjfDV8rRS3DISM0T7raHoczctMLSo3VlSbP/LoVlZpH8ka1TAMAP5OoRXcBf4r/u4
 oME6KrrQIonTdwZ2Q39sra1XJNU4BbeHUUrnpbjce8ggbp4RUf4nGvsP0yZe8GFVDnohUfY/dZ+
 zUDwAuMJJp7ODX7h/iEDUzyMetp2TYbx1Gm6MecVwyD0Wg5UaFg2J/E6m6x6kkXcTxZdF6vuH+l
 R07830qwBXEvU3kzLzbXZH1VLV5eyplspVUmosQdtpM0XUvT4ph/+3qHVZNy9i5tQyn6woahRhH
 yh1/FgDfTg3FG8UnojQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120136

The OPP table for the Iris core is wrong, it copies the VDD table from
the downstream kernel, but that table is written for the
video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
rate setting (which is clk_src divided by 3). Specify correct
frequencies in the OPP table.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 1fcbd400a3be..9ef6f3df2d48 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4355,26 +4355,26 @@ venus: video-codec@aa00000 {
 			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				opp-720000000 {
-					opp-hz = /bits/ 64 <720000000>;
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
 					required-opps = <&rpmhpd_opp_low_svs>,
 							<&rpmhpd_opp_low_svs>;
 				};
 
-				opp-1014000000 {
-					opp-hz = /bits/ 64 <1014000000>;
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_svs>;
 				};
 
-				opp-1098000000 {
-					opp-hz = /bits/ 64 <1098000000>;
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_svs_l1>;
 				};
 
-				opp-1332000000 {
-					opp-hz = /bits/ 64 <1332000000>;
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
 					required-opps = <&rpmhpd_opp_nom>,
 							<&rpmhpd_opp_nom>;
 				};

-- 
2.47.3

