Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BF36196B
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971619; cv=none; b=gQ//P/5UQN92qzpw6cplq+5DmxuG44GDioM2dsSzGJl7jKiWPm4xIAfawFW1NzldXwPwVuXkYb08r69HI3fA8Mn9RBtMNvL1zQhFBDLwlquvu25wKwc/zfd8B9emCi87c+wMKm//mlVqayD85Bdz6n0PXFchHhJTQblsX4NjCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971619; c=relaxed/simple;
	bh=yQBFMi0V1Q/34XT7l2xkr/OPRTO8ErCo82SZzAZN8PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ui0E6Cli3UrEvIuPrtZ+q6Ueu8/gZ6EPO24vvsO0uO3odwHP4mgc2iOtrPcZBCpZ5ozeuSEI1DOUMAKZ+2aLWdevbFsk2w4Pi4pObJc6I4F2YcYnDynLiFlQB4BSvGl/Meh/dbgqbXQM2tnD7tBDhUmSFNq8s5PsRH2/Zafuh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFBULBpD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxbVDTzA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFBULBpD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxbVDTzA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZRYJ3551319
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3TMnVyIqj4oCOoXs32jIk9PhLPoRy53h9I9OmzdXVzE=; b=JFBULBpDRvWijOZu
	nK5Ju9lbxSXz/Oyo+REGLyqeKRSpKZYiCdg88TLy1wsg+wY6+FSeD/84976D7owH
	Yu8o54Vl2TtHtiAZ3h3DqrJCgEtZxb8951653I/TLSNFZirvz0IVXcO4yLVzDbEM
	iaphkMCFg4o9K4ROlFPaZH8XJzxGVf1y5/gdOVrZ9mf/N3E6D7quOf0IDfe19MCK
	6bvQbP3mzBCTq5jzhml/u67n5KOmZmm+9OdfjVrHA5z/Oa00UiVvFh/O4s8IOTeI
	Mo9W7dyyQeEesPcya5lSE18R3oPHBdPrCKnuZ+hh20UScrbVeBk/jIRsYVj6acmw
	vC6UQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs84xg8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dc7337e2a7so33992515ad.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971615; x=1790576415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TMnVyIqj4oCOoXs32jIk9PhLPoRy53h9I9OmzdXVzE=;
        b=TxbVDTzAXUU3N0vprDEv6wpbyRHmH45ma6SWMMpVAPg7FCIe9oyjcrm8TV88YdutLS
         O9OOUnE3VgB2wp2rv69i3eBjtyq1tt4iT77vBf3095G2YeiCEQApCka1rPeGFBFMrPdw
         n5BB4QcyxcF+lkv1+WO2tiUBgsDYz3uUoZeTwLgaiEFaa264KjGXRNedGmWWsyPF2Z0G
         TbOvz4M5cdk0+ywTE34Q2Q+kQgDtJmNXRzn0gOIZw1L8qFBKT9WsHw5DTEjT5tKzV0wE
         gw8nuvOqIi8BjCOOkZs+6R4KHGeOJCVZpQ7POk5RsrgjIDB13MNtqdcsHaFrKuUeKPKv
         sMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971615; x=1790576415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TMnVyIqj4oCOoXs32jIk9PhLPoRy53h9I9OmzdXVzE=;
        b=Gr3OretlzI/5xsLj7nGcS0cGPMoBy/cY65gUH43S2gMZdJxYRK/vcsuGmyp5HdrOgZ
         s35zBVI7YWpJrqgl9J+lgWrnvbxk4fFizoqTlz3nrkMb2hdS+AI5HqkzRFsBPPJoWAIj
         rpohxOFn3uThGvpGNCCGpb7FFCgdwwKSp8Ophz5DX2dIg1fRVTxZDIA7G0cc1tjVzYXt
         K7nj2WJX6DxCJSXdZqsccoABZY3OulCV3K2yBQCiWInGdCI0F07ko1yijAYj0TPdIDv0
         QHpN9qX5kL4v1xenXhf8dQdgNMJs1MKInlsIMvl2FTh5fwFVZjeqT8MhPne8yAVtw+eK
         ouWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlb6uQ8pxNd60jPKDFTmZ4jZK97b5Clm4HIwwbYqJlXE+p5byVJAUCQZnM8bBohznCUEcEjqG35A==@vger.kernel.org
X-Gm-Message-State: AFuF++kQdW1/dliWaCVQZ/IYrux1uK6Z9JtaFBKeActZvNT/J9Gk+Yda
	H+KoIveNVIDJ/PeKwbugwGwv6Y9wmqAf/Sx6hENXYMEAChEaqbINfxiiH/BfaoW7GU1gB1cEdyQ
	4TacYnGlaGdm4KPElZ5h/W6E879unA+U0qLwr6exroyA+zx/FrjrKlKZBO+huGw==
X-Gm-Gg: AYBFou1r8NB4nmeyy9e0Uwh/YiDWAX8KqL/Dl+KEYgk0UPGRwk7Ok9osC4E77IIK4YW
	XxMMebzdMedyzCpdJHECtLjMCrMIY92oEiPXXsVCWa1LSx3hzcPyexmyKDDE0XDE/XROCZ9hds6
	534s2bsYE07MBUqakCD7PhcV/0B4j8/t2hLi8Pkc5A3VbAMMZuFnjuOD9a/th/nrwyadODkL3oc
	XEdeBmrlhDG7HyotMSHIwJFFdb6NLtvlSniEdBqSMUC5g/wh2IP7b1nFsOKHWjswHcOl30NW9ow
	3Wsg6khnc2lj+5DpSl13DkespoVlROvywGGcb1N+CO7pvGNyD8I3QqJAStk2lqZ6+BUmkGpoWTV
	lysCONpgu6ATH3A9jn9/qxV9jXJIRgG5E3GFHvQ5Y/WtSfVm34NuvkTt2cJXxDCB1JSa5E/jaQa
	CQ3shWKS76UpqnYRW5UPQka7GTIge+oxDXNQ==
X-Received: by 2002:a17:903:19f0:b0:2dd:7593:8634 with SMTP id d9443c01a7336-2ddb1b0f7efmr138780565ad.13.1789971615508;
        Sun, 20 Sep 2026 23:20:15 -0700 (PDT)
X-Received: by 2002:a17:903:19f0:b0:2dd:7593:8634 with SMTP id d9443c01a7336-2ddb1b0f7efmr138780115ad.13.1789971615035;
        Sun, 20 Sep 2026 23:20:15 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:14 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:37 +0530
Subject: [PATCH 04/11] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE
 clock to GCC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: kVJuM7QJLh4Ww55mBOktzz2M5qTTXBuZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX6NJ/XqrCnIXX
 aB+KGhNVa3Vmb/bR/sLzX95+WsyyNoqvWleyrYQCs3/AeD/C3Zt9yualyHl2J7AnTdX1P1jTOSr
 QbJYREV5G7/C6AO/dC0KkcKi0r8I92Q=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6ab0cca0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3OI4E87EZh46DsEagTIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfXwnnq5EnYi/wM
 kwarh2WO45BI+SL6AzMtDxSEWWnVIXOZw50evEqWp37mmU+AXgghkp/kwdQ7acLutKNw5UKJNVq
 MJZ7Qum4EMXN/HVAVxnOX7ZjspKzDkA/UZy/Bzxr2NjzBHV4GlzgOE9UOnU3POe79RA+s3uyoj5
 cGtnCF8Ru9ylIo0UcXcvkG9vMbONW0bLq46tE/TxItyjCgIEXJPK8PI8QaufehZSe0zBElEYCip
 v/FAeNVYSL7tFHFziAMhcjx9X7IpzETNF6idd5IToIG9OIXBFleMsXG5KQxorz78zvbJDgwqcpR
 99V9VfaU2MYluLRTsYMjzjWzrnOKyLf+S68iaZ88haL69pgSr6EcEoxHgCbzgdD1+yAxdKrJiYE
 +z2qeK29tAdlsDZgpHYgwvxf0M62r+bnMI4B6AcmEetuWMxoEX4/3dlA29sS0s4bRERu6cindN5
 zHdGORhV10/FHFidvHg==
X-Proofpoint-GUID: kVJuM7QJLh4Ww55mBOktzz2M5qTTXBuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210089

Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock can
propagate to the USB controller.

Cc: stable@vger.kernel.org
Fixes: a98bfb31f676 ("arm64: dts: qcom: ipq9574: Add USB related nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 5a5bda5f21a1..dd1dcd955c95 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -428,7 +428,7 @@ gcc: clock-controller@1800000 {
 				 <&pcie1_phy>,
 				 <&pcie2_phy>,
 				 <&pcie3_phy>,
-				 <0>;
+				 <&usb_0_qmpphy>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;

-- 
2.34.1

