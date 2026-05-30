Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4FA3BF676
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165688; cv=none; b=hC9Kst0xzTmtFQsZH+RN/jUVhMMc/8l2NHF32PPN+bBQnlunlcPHKt+dzyOaYBBSUimA4KgIulsPU1jKwQMufl+I1Izqn+Uz/WHATx7oKAmiV2e13cqbIDaO6MJpZLkZEL9pqBz+MczNsd+EqUNuKS+hkdGjEi+ak+ILLbKOpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165688; c=relaxed/simple;
	bh=xt8fdY5E19585IRxlf2tv2dOaGtOy/UcGSJMOtFMvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gG3ssaNWu9cHqgJPGNnco8JM3wQaCXXxMxpPrG/1n3NQMRjjONRDHbUSXx8gEW88sdIRdKJOh0MaHGrjDTnPp8CVoNbK8TyBRPWRFVzGGK6M0KJQidmgPLU0+SywlhtQ/T+F4uRm/xqa7c2wXvVggOUh2aJZM9eadzqRLeNYMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hb+nW6Hz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4VYxBi4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb+nW6Hz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4VYxBi4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOS5K3280285
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=; b=hb+nW6HzBo6aCPT8
	AFWEK9qfbgYfr+nQ5QZoQubMiVtcQLZbqHH2vYpq+b7n96c+3As720L+eaLXD/rw
	yiV2XghXgKgBRaU5xYS7kbFAIws/lyG+IdyNfSV6fMssvMhQ98IxcX9BGdYXzPt+
	47BBqm7L1W6kz/BONgAoehEWqg0cOuGOQKqoexBkkcxhK3t+yoVTkwoFse2EKqsf
	uvJgSc3cuWiabe0bzLvBH1xEbhVNSYqMLhJ2R2wjJHCEaAtEwsW+o6/1S7FR3YUT
	0Gw2iL9qbqcV/MKjzAXr2cjHoh6DmdOyNmrppN4eCHcvMD13F6N5gnId+BKGvAyN
	e9SY9Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7f9ttq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso129983365ad.3
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165686; x=1780770486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=f4VYxBi4QXIuVFatOTji3aEc7iswGE083B0DsSITlKhO+71bCFoQ7TjpNzZY5ox1q5
         n/peM0zi0SAV2O3ppjJvYHU7W9JunuqZDwG9GeAaCunQwjLsiOkmmiIXpvLehxTLvztu
         V419bIMLypP/0YqVV/KsYfHhIz/3nfwV5OCmbZdpnOeS4V4dpeTFFo5zu9DZ48YAL+xo
         ySrml4sl0CbkVJJMPw07lrM7mtI3N3lHKyuq3ORBTRIEeppl/qbS8vzozy3E2R73suk6
         aDEVu5oEh/UY9qEVSG/uWmkKKevkf1nxmhvDWwInPZTnp7d6ZsIG/QMWD6YGQ5LOP0Rg
         e6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165686; x=1780770486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=Ea9ozh02y7n8aKEMN609dCrPEBSIAZlIrMYsWAKNWOx1UWzMlBoJ3+bc3UsQ/m/qiO
         BlZamd0EWTzeSELmJneOWJDbpPuJr1XqqTndN1YpP4v/v7urTLTPXc8ATRL/9NzjL1Vk
         1WAJpdv7fyoOcS7hR4k57HESGPLpxdITG029Hx/dVCeo2tYDroqxXPEFupS4kok5xqqi
         C4Lj45paNCY7tsBRpLXZCJarc2T3k4dmVz+0eKqVamXHqqaJfSuV1DZcqrQ8Ns8OKrzW
         /dEs0drWs7BWR3Tc0X+TiJXO3N2jnmjWM3DrhQx850EtLaTTLtS8T9k5GZ2mY1WdOJFr
         RKKw==
X-Forwarded-Encrypted: i=1; AFNElJ9yxUQMy84CvQWSEASlo217hTVLNE46YTuXjGu2nRuvKOA7uIbU8+8ozpee3e2oBJvOU3X+kYcRNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2fF/gRAscHKmtSTdJJQYwcuAeKHkr72vXOwNXovC+VVU13xuq
	AYmQZimHSdm6Vq1He2VP86pMBforOzalxwbjqsCHYLCCBfrXcNnvLbwTChUiq0XcYK6zjpT0MPm
	QWQ1x8VQqKYCDWyaVUhUUOOHbpcE9bSq1LRp7O6LyW62sziMyKIKLAmH2O2WrJg==
X-Gm-Gg: Acq92OHKDNqcfcSyhdbl7pKR0fLyWZynFTVg7T16CuKAARhXDdp9UEqruVZ2gXYAxpO
	N1zRtaSfLPo1+UxJC52GKL66XtfaKG2+rc2QfX4f/t4aWJwI78DSwr9EIYBzRlR0cloH9vJVYK3
	gttDGonWTxBdWK+QW4hmzt4Jl7sK6mc1zhGtPUqcurkzTOYqq5RxIR1UetBkiDtkHZcHJUErq65
	IuLcpo6OiZMJyWAH3ZthgKZOO8Q4/rzz/wc9DOO2awhwn7VQteFNd2qnAqOXK+fTVRrNHxe+tNE
	n6HEakQMFnsJ71DvjwVGzEcGYgAPtH+mW5citdj6Ws+b1q6Isq8Pf5NoUVnAt77ekGyOweWb0Z8
	asxQQkHi9N10HzSnEYIeJGnvW6HdQuuUAbxCn1JJ9LJKW0Z8=
X-Received: by 2002:a17:902:d58d:b0:2bf:2e93:c624 with SMTP id d9443c01a7336-2bf3686777amr51626595ad.27.1780165685884;
        Sat, 30 May 2026 11:28:05 -0700 (PDT)
X-Received: by 2002:a17:902:d58d:b0:2bf:2e93:c624 with SMTP id d9443c01a7336-2bf3686777amr51626215ad.27.1780165685449;
        Sat, 30 May 2026 11:28:05 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:04 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:20 +0530
Subject: [PATCH v2 02/10] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-2-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=1062;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=MfVD9NAJt+YvcfkJInifeQ/jWKYZMhdr3T/JUeWSDbk=;
 b=JfFkzKPOnxwJefF+ophXm/+6E3kPCWDQLamcirvNXm5y2bmtoWo49z64nFfax6b/sazioFKpf
 /V4tvER9/JMCoFcXKnc0dKFm5uw8jict7X34IeJuXg1bCBw2ue3Whgb
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: vHXiBd_JJCxB-aF49DAws6ap0Popq1OH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfX29NLcTQDConB
 tz1iyL5ycRviu6nEN5Sg/NNnsccrzam9aLTZ0TsrJPiNZIV/5ZZIVGEw1QD/B5jsaTAHNLdGY3S
 Ve8jnxT82gzE4z6VVNhB9BO9/PfoiNGV9wOqi/5X+UbNQaSf4EDwcSrW1yvRFUK3ewZl8Z9wxAe
 hLEL0IYIOMFTzGs+qw3pKQyJcZEtuLK3SCi7fsST1YKSJ+Ssbzee9W6wscF664d5ODWgStNSGvQ
 fHixhIexb4nhsP0pJta6h1HiOrG33uG1dJM7vUAK27V+Y8LaLKLfF2oeKVXaCurWynCoar8jfPv
 w5uPUf0YmltbMgKE7E0TV8lDO1HWkqjgi3grz9L0t4UfildpFXYwfAWCi54FHXvAEZWR1+N0An0
 vIE0Th6TSZIAuFBRElD5jrpDATSxTP4+QWKMt8JpWmAknLsBjsEo75tdAwQv9HzMxlixJ8N55He
 WE/dkpizOdNQIskPqVA==
X-Proofpoint-GUID: vHXiBd_JJCxB-aF49DAws6ap0Popq1OH
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1b2c36 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605300199

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ff64225e8281..8f6c937e44ce 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -52,6 +52,7 @@ properties:
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
+              - qcom,shikra-cpu-bwmon
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon

-- 
2.34.1

