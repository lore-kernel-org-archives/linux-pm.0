Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917933E344
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139192; cv=none; b=i0W6z5EXWesBumHIqocxp7ccAtgG0I7Hu2ycKKT726nVt/EBrT5S+sxMQk0z7ncnm41KuIANEA+tOSNdpKP5Y3NpCM6+xWY33yikEtcHTKaOntiNQY/9DQtermnUNkAIj6U1HS3xNFRgBcCuj3IGu5J0U4bdpidowjIJOHb0KIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139192; c=relaxed/simple;
	bh=WdAwV2ejL3POz12dfXrN1UH7myAW0uxPAf3hSkyDGTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suw9lP/EdyokmibH4T3SXG0xOcO00t1dy1oldPkrkwnNOj9YDkrkE3nb86EDB3mQCD4cClV2rvfDOsGlGUrdBCNd70bk5TFmXU/7OtBV/1IVGngFar1iccu+7E1U/hG9Xt9wPWNVE1x9EXjSbdyQS/zJOa3niGOIDtIqAnRKW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fBrbb0ZQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G06Tdgne; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fBrbb0ZQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G06Tdgne"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLCit3361811
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Cfj1ElFhQ7U
	CtHccCgOn3S4aPyvBMl1dKXXhKEwS3w8=; b=fBrbb0ZQSVnkfkZJb/AM//ggNz3
	zC9LhBnb2izxgMyGAgmiAROk36w3j6kaDGsKGhU0HSdNzVaEhyqTcwxnFqQ8hcbk
	LTcqbfJjjmu9QWiWbd1ObYfNaNweqokW9irOVjVS4PLTbX6M34HqUkcFkIRo27YI
	1UHt07kqDfGxdsXuX1JlEeYjgwYpGGX2qiVMY9/7JInvGYpaXe7sZ9SplRBu7vO7
	PXQBCZuNTnoDT03TKt60xOLJ+wIdKvuZJUXHiOeBgwRbIVX5u6n7n8KsgtRYvUOt
	cMdVi0Z92o2kIWAD1mmUkGj2EPwa3sCcW6l9Qs/srhiwGrdrPd5ZykP/NUw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870rwpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c16233ee11so7171491eec.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 20:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776139186; x=1776743986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cfj1ElFhQ7UCtHccCgOn3S4aPyvBMl1dKXXhKEwS3w8=;
        b=G06TdgneA7BSSmHvaZwdl4PRONTpkK1/HEMMpTSDA3rvYoBElSA9xmMKismwSv7vVa
         RR6bEpAHtRYx+P0nrTul3bIJLMDGuNju91zC31GPkeMprfgPseqMnxCTnYTnEYFTvwLa
         daT6egVitFv5ImDiSx0DXCt152Ly5o3xnyR2FKfvp2jg6fQNP53vC43JhEt/OL1yQQ4V
         q0LN8k7DrDlLGDGnTi1pSft/5gI0EIKeROD8Lb8C+lCseCIU/orsWY1ptPTvuwNTh6HR
         uDbgbCA+xniVFwrruwcsL8t3tAVqzOXduGPxqE6K3X8aNqzXufdpaBDg7GGkuzBg58Um
         M65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139186; x=1776743986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cfj1ElFhQ7UCtHccCgOn3S4aPyvBMl1dKXXhKEwS3w8=;
        b=h3kH+lPSf0Vskhl6pV1MEFFLG8hHMDpivYOaj5EvInA+6l82klYAmkpJE3EYUmeara
         Rt1ZQ0/CTCDapt2Ecov0lWdDDOUUukdJoK2cyxQ/ssLoG4JWFJmLTA5DpceHfylQcYPs
         Mt+ami6F4vYgdu/uMTgY6RuTH+zTrR322vQY7dowuvipBdwdGR2lk+zp0Y8qA1A9MaaT
         WHel8xufe2EIBIKuiT+/HgGklXDrFd6CmF18Ca2h86cCxvPA7sUEVqi7Ha3FGQzj4nyA
         huz4iREBCIKdHPyNeiiYnVs5DNqqkkWKuuWKGEZCLXoNNhsgHmdw4V1TbAP16vpzWo2m
         UXkA==
X-Forwarded-Encrypted: i=1; AFNElJ+G6+sBu3p5QoucuZ4JOQzDAnmSxs7E8Nxf8hf6ilMBXFubDWBRmXn/T+7Za6Z4im5kBa0RG9Lsig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OnrY1yOuEXTsuWUYzDc9QOmmBSxExICpOdHLQelJi/7z1orB
	ks4+kKpFQpm2u0mahq4jDp9yoW8nJBdP6JpYyPR/ycqe/DKEYv3rBxzAWAtphA0EkFWSzWdnyxv
	ydsqeU+mxnLopsTqhVmVOUagyjmq5Agit7v7ua0WmdVPDnAW1f2rGovJKUSFz/g==
X-Gm-Gg: AeBDievwxazX18K0exn2twWhqDjPeR9wPZt3miE3LEBda57baEjrwC9nHuvz2lhEycM
	6e1t1mqDStjQMXerW2Qb4do8x6hYM5sSOE9xgw9VZV22KVZoKR/K8x3mFVq+oaGJ7iR1B+pJpDf
	CukyoOOUiNKKMKVKOL7EVOhD1Kbzn3/8YlVyww/KV4Crc9we/k0gtXN3UKF712i7Mg1zhJ9VtQU
	HOmP3OCvu5CUtK+wK4lQGdyb9RiijsOeZ3sOCgI0JgjqZJdPTIToa5Ky7JvjxaGhrTIcAAhdivK
	O91NurEFBeIt9OHcDjvzTSVDW17U4UP2cJO7cXHpdhfnjMvsAgPYyOLijkywTwIs/4B+e6e8aXf
	I7OFsj/bDB0JG1hOAGfXvkLP+aDvXb146/kEpMWxYbr2XWXI4ExGxnhm1Kefai9poL3/YYYrxXR
	71PSQxeA==
X-Received: by 2002:a05:7022:790:b0:12a:b932:81d3 with SMTP id a92af1059eb24-12c34eeb76fmr8472612c88.26.1776139185932;
        Mon, 13 Apr 2026 20:59:45 -0700 (PDT)
X-Received: by 2002:a05:7022:790:b0:12a:b932:81d3 with SMTP id a92af1059eb24-12c34eeb76fmr8472592c88.26.1776139185421;
        Mon, 13 Apr 2026 20:59:45 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80acca4c5sm13949983eec.19.2026.04.13.20.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:59:45 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Nord SoC
Date: Tue, 14 Apr 2026 11:59:08 +0800
Message-ID: <20260414035909.652992-3-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
References: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69ddbbb2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=fp39WZOfobdgVpjsm_gA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAzNCBTYWx0ZWRfX3IPbWQWxuECV
 08x74eoPr9s3ibp+RG6/Zdj9ypjSdQ2Et6afONg216xah6ruM6L4kipDQY53rRBn5v40KygTAZR
 glJCUtzwm/kzQLCmlqbmUIM9ZM/S0x8va6KVoAnxicT72TZ53BtwtdV8DH0YnMc2UQlHTTbxRu5
 iPPREZUvakZ4owKinLFnYt3UdANjM5Ouw4ZHyZuqv1WazuYXVuJO/MrJrY9H/U7VJI0ZMDZ9R/4
 t2Z5UQKT90TKk84zw9g7lTWYEjhbiXQqLXkmOV4KR7lDmug1dbp5tYGiCY8rE4fZ/ij/jkLMfnt
 JxSlnv97gaiCfjbgVieXv0YxWLgKD00cpPkJrPANdWaEeUCh6FUwA9ClvDpzF7zHv5L5zU6dYe5
 WqPReA8bjtWVzzKE6EO0Hn3fU5lAHg3zHWVZaC9s8grSw6sgrstxiH9oAnDpPdeif25ZiX6gB7v
 q2iXSDu+YPHitiGC6bQ==
X-Proofpoint-GUID: _ha7n1QjQ3MvTIMLgX0DIFBwmscHqm2K
X-Proofpoint-ORIG-GUID: _ha7n1QjQ3MvTIMLgX0DIFBwmscHqm2K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140034

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Document the RPMh power domain for Nord SoC, and add definitions for
the new power domains present on Nord SoC.

 - RPMHPD_NSP3: power domain for the 4th NSP subsystem
 - RPMHPD_GFX1: power domain for the 2nd GFX subsystem

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom,rpmhpd.h                 | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0bf1e13a9964..779380cc7e44 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -35,6 +35,7 @@ properties:
           - qcom,msm8994-rpmpd
           - qcom,msm8996-rpmpd
           - qcom,msm8998-rpmpd
+          - qcom,nord-rpmhpd
           - qcom,qcm2290-rpmpd
           - qcom,qcs404-rpmpd
           - qcom,qcs615-rpmhpd
diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 74e910150956..07bd2a7b0150 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -30,6 +30,8 @@
 #define RPMHPD_GMXC		20
 #define RPMHPD_DCX		21
 #define RPMHPD_GBX		22
+#define RPMHPD_NSP3		23
+#define RPMHPD_GFX1		24
 
 /* RPMh Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION		16
-- 
2.43.0

