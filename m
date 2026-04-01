Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074873D1716
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034946; cv=none; b=TKtlQBQJxRFAYomhYp1YzvDCWTfO2CUfK1BqUwRZWkXCMkr4ZKr5yHFFdV15GrS67jqps3vQ5MzrIrWXOYvMGNyrgqDb0vlqiQ1kOHSjGHGf9ZOGxX6M/OwtpsSccHJEwW+P967CIO/5ttbn8pBTrL4sWRG4mZp2ql5N3Y6G9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034946; c=relaxed/simple;
	bh=YHz3yjLtb8sqsosw6lB47Oo/jKdiK3b8BkaK9I02Lco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tL98OP3wPCqvbk9JoCMBvlbX7QU8nls/jWR4nGVHqdEB45NDCIBbTEmY+SkK+sNXjLNeC8SFAkYm5hqOvvKBrWmkPXbyn88k/FO8cVdcI7qxKSkaDOzKB4tC3GXYah8sdgGjosDcZ0dAUWskkzY6JyzILpupRI8p8VYAcW75SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADFjXN3A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gV1Ddga1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADFjXN3A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gV1Ddga1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314Md5I3363191
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 09:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dmND3vym+H4eupAgbTKmroPv0kbG8hplfRA+5WuXsFI=; b=ADFjXN3AKwTqwGwk
	en1Da4swYrwn99OG8xCwyAks+uF5PO3GOBIwBsKh1ctM99zn4WRYF4UDnXgVVgDQ
	9BJWPbz9MJZf0s4V3o/yTzpeOgjkGx6nIYzrnYWTYeprrbk1gIz3D+yoycCuxKmo
	H0uhT8G3TT6BJGeOZh48i0S6OI+rE9ZaNLkNj1uoSWwaVPy66bpokaEzi2sU7yae
	8MprfaSqn0JfX28dsqKlWFj1AgKcNacBt2p+sU3fFKqmHRtRhLR3XzCuJtjCzAbn
	5//+ne7PZGWhWD2WCuNkIGZCm49nLfQqBd5wlIiMfu1TAxl9j7x784OjO4jUJnVW
	mbYaKw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddjmbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 09:15:42 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-127337c8e52so12281418c88.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775034940; x=1775639740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmND3vym+H4eupAgbTKmroPv0kbG8hplfRA+5WuXsFI=;
        b=gV1Ddga1dQNCWy+d8ABKu3Y1OCrBcjVzID0GAYdbQApdaegQ5Tnvj6gzL7BHRy53Mc
         r8Omrk66GvO6d6jXtLVD+YiiQSXPVGJz3aNMBV3pq7Xq6wF72UvWTbt4yvPVOUFJpFAE
         /BNbFGetjJ2NwlMzO5ftSzXQEXtsurfHDjCUQVz2nFt01MZBuUGAdwAqWc+dLOpMMB5Y
         bBm/fdlSmcnXZVvGFyDxnUO3IfM2BIjoLDIvS9GAGmViVSPtnDUuPYd43WIpSyB/HJzc
         ewZoG8+dysog7tK1ug0ei+qHYezvRqjLgC/xeoop62+vaaufS19zzFcpgBckZ7F/v0/K
         VsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034940; x=1775639740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dmND3vym+H4eupAgbTKmroPv0kbG8hplfRA+5WuXsFI=;
        b=msuRjvDFwD1LZ+LP0mVbqedEWBfqpLXLgUcc11WephJfgQvliesFg6Xt2Rbeqjhee3
         c6QKpxtUGWK/fLDfom82h6lZhPPg1+qPU30epLu9D0FMfZaiTyE43D4d7z+ew9PAr1jF
         C6dSgzz4sGA1mDpMAOuDxtIJ3gWI4cqaPngwEO5QDTFBwKt5CzzuoX9hAIn5IMJUdscl
         wj1hIV+Z8Ck05WV3+4jNYQ1WnbBotWYLIXapAE6GbYHc3DFlx2GKf4L96oC8AbUuH/TW
         Kic+4G5hYQUVY/3hgYj1z62KYagE0HEXSznY1Qvuv11z/aPMKfw/C5X6ge+dajJNAPkK
         gUKA==
X-Forwarded-Encrypted: i=1; AJvYcCUZeDCwiiIUJMPjUYrvaC+Jx2WQzafEu8kgXO8/rlSPlZQx2l+47fL8mQ+l+dvVCobX0+rYd2yqHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP2AK34+DpKFeb7QDxS+/7hOpmz1x2QWMo7I/7IMBjJvaZp7F9
	OMGa2DAmAAy9sQB+A2NG5qBlbADBem7NVEFJl1paCnnr4vT/AXMoFpYLiJA/SO6sfEJs3+f0abS
	ppmlnfxFLFB8Hml3D+0aGsmUpNPaYs8x5duSkqFAkFdW0S+C+6cnAm4pcCcqCXw==
X-Gm-Gg: ATEYQzxxLok/GzKNAjHFIUibvY5rfD0EDYbMNtmwZbCS7xWF7FWmMGTBnDXH5f0G2sD
	4QNp5Ap4MSkvCfu9Vce6svzZZ9k5TaLh6BRrfMFb+1aVKxNqIZzzSbMQr7EtxZta7R433m7N1S7
	ntTfcq8tveXJ3iStOya0RO5qj5ICqaGExVJC0Dy4zW/cQz2E7uX+XRMk5vckTpWaIP7LGuYgOja
	gPBHPuzrI/xPQR6eZsx2kmx7nwaAnBRSEesb9L1aT2OqzZ3Z0I+a6o3Fx9YbBSBG6EIdrwurz/E
	W0ZyL4fRSZorVZBJ517UTtAX1lMWj1bIV19dt3b815lSa9zrcuZ9FfT9cKm6LhpH0s0fanBApj0
	cOCwO1yW/mXBukP9g3v72gsR8iiA+Z0kkcKPSsx6vFpVawWBeanuNdNukobM2efrHRn6EJ6Va0Q
	==
X-Received: by 2002:a05:7022:6720:b0:11b:b179:6e17 with SMTP id a92af1059eb24-12be65988efmr1727436c88.34.1775034940440;
        Wed, 01 Apr 2026 02:15:40 -0700 (PDT)
X-Received: by 2002:a05:7022:6720:b0:11b:b179:6e17 with SMTP id a92af1059eb24-12be65988efmr1727413c88.34.1775034939787;
        Wed, 01 Apr 2026 02:15:39 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm18285025c88.7.2026.04.01.02.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:15:39 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 02:15:30 -0700
Subject: [PATCH 2/3] dt-bindings: power: qcom,rpmhpd: Add new power domains
 and new levels
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-haw-rpmhpd-v1-2-c830c79ed8f9@oss.qualcomm.com>
References: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
In-Reply-To: <20260401-haw-rpmhpd-v1-0-c830c79ed8f9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775034936; l=2615;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=YHz3yjLtb8sqsosw6lB47Oo/jKdiK3b8BkaK9I02Lco=;
 b=VHfodnIwHHEGlGxhc89GSXtzs0Z60QLWCTNTsJeUbi7mbzFa6SiuLuZA25dnVpDymBNulu171
 1fHu2EFTwgiBbanjM0lOWzJVPqTerKnQ9aX84i4CAU+g201pCrGMOsp
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69cce23e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=4n-pkbnfJJqo-f5U7OAA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: _jfo5tT6L8K0H5A5Bj6G0gTbXNKw4-Ba
X-Proofpoint-ORIG-GUID: _jfo5tT6L8K0H5A5Bj6G0gTbXNKw4-Ba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4MSBTYWx0ZWRfX+p65ls1yKeBK
 DocSCQMhnbPfaFa4ZirhRW3yyEnQ5TwldgQZT+D4UBeT0xVQP+izA5+MPgYtXTa1BYLLB/ankeP
 zw05fWbChHCni2aDQib1e+fUTc370EmMUzlntr5SG8p41ogMb+7WLaZbYagGDSLg2sl0v5oAv1Q
 jlGS/bsAhuVeVwJac47289+E9rGcbmP6tB5DW1uk1U+UeCHP/y9wRuxqwP8f2fHM5h4ASF0r1gN
 KxhtATOVxTxae9451r5/USfNl1Zboy6iZMqffY9EmbEukLEzuaZU+wCrYhw6IDmrUEl8i9s8He5
 ObazmsFOtp/XIqUIGvn+Grhbakt7w2TX+TRXfxmPhGUySzv0w3mcxlUvxHVsjmGRXNyhk7741tU
 vfO90ZZHj1QClsq1eQXE4b6eCfGAjzUyUrtSL/LRJ0/uuQ3b+x4/aSWpdzFml55Kxl4d+MkM9EV
 xPHs4K2v/RIRSANAwYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010081

Add definitions for the new power domains which present in Hawi SoC:
 - RPMHPD_DCX (Display Core X): supplies VDD_DISP for the display
   subsystem
 - RPMHPD_GBX (Graphics Box): supplies VDD_GFX_BX for the GPU/graphics
   subsystem

Also, add constants for new power domain levels that supported in Hawi
SoC, including: LOW_SVS_D3_0, LOW_SVS_D1_0, LOW_SVS_D0_0, SVS_L2_0,
TURBO_L1_0/1/2, TURBO_L1_0/1/2.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 06851363ae0e..67e2634fdc99 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -28,15 +28,20 @@
 #define RPMHPD_XO               18
 #define RPMHPD_NSP2             19
 #define RPMHPD_GMXC		20
+#define RPMHPD_DCX		21
+#define RPMHPD_GBX		22
 
 /* RPMh Power Domain performance levels */
 #define RPMH_REGULATOR_LEVEL_RETENTION		16
 #define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D3_0	49
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D3		50
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D2_1	51
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1_1	54
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1_0	55
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0_0	59
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
 #define RPMH_REGULATOR_LEVEL_LOW_SVS		64
 #define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
@@ -47,6 +52,7 @@
 #define RPMH_REGULATOR_LEVEL_SVS_L0		144
 #define RPMH_REGULATOR_LEVEL_SVS_L1		192
 #define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_SVS_L2_0		225
 #define RPMH_REGULATOR_LEVEL_NOM		256
 #define RPMH_REGULATOR_LEVEL_NOM_L0		288
 #define RPMH_REGULATOR_LEVEL_NOM_L1		320
@@ -54,8 +60,14 @@
 #define RPMH_REGULATOR_LEVEL_TURBO		384
 #define RPMH_REGULATOR_LEVEL_TURBO_L0		400
 #define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L1_0		417
+#define RPMH_REGULATOR_LEVEL_TURBO_L1_1		418
+#define RPMH_REGULATOR_LEVEL_TURBO_L1_2		419
 #define RPMH_REGULATOR_LEVEL_TURBO_L2		432
 #define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_TURBO_L3_0		449
+#define RPMH_REGULATOR_LEVEL_TURBO_L3_1		450
+#define RPMH_REGULATOR_LEVEL_TURBO_L3_2		451
 #define RPMH_REGULATOR_LEVEL_TURBO_L4		452
 #define RPMH_REGULATOR_LEVEL_TURBO_L5		456
 #define RPMH_REGULATOR_LEVEL_SUPER_TURBO	464

-- 
2.43.0

