Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1D3CFF4B
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034943; cv=none; b=QSfqTRvzjOM9b31hJfJv2IVn1czryrcmRZARH4iku1CmmSB+JtZHUupdEO37Jgpcmu/3QPAZ4QtHtVIJ/9zrJ8qbYR7kiJMFS4JxsuaC2cXE230jwJMoSOBAkZxuR72yAfC2x+gXt31XA7beDnYd0GJgnDEmFgrq4RbgDzKginM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034943; c=relaxed/simple;
	bh=tx0he3/MmcRXd/XIsxErZQP8p/i8WWMq/f0HSUslY5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgW/Pm9LlM7+1i0KxfnhBp6LDBHpvprE2le4RMKmEmuGtAMW4aPcK5CXdFWL6Cv26F+XuRnU5iOneLoONlZUjBf5PDzfaU4dLY9QLDsjxavT1JFN/hmUEncMRyT317UwPlDCpqfQPHxK0oCtGFINOgWhOsMhCbUh2vt1bCqmiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1hNxi+x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jgLYwplU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1hNxi+x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jgLYwplU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317wNTa719339
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 09:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/BBPB/FSLYg0K2Rdi+KbCC4Oq8XCYRTZKAKMV1mBmtI=; b=B1hNxi+x7UJMlbqX
	IF756CFx0sPtkld4EmSCDviV5XSMECNSOjv1IsExBYVjnh++8cDRFW7Alt0g+p3+
	Iyk8CavOw+A1McYfgZhC4oKsoiyFBJ8UpSdKesrlA0ZMjA2CZKZqRfBBcQBOCbvO
	odRApzqCZkburuTjb6JqGPuDkZmkEN+iE+DDT0w53lT98nuS4FJUr2LsW2UDxdTi
	PKx+pAv902e0kn8g95Fk96LpwemFPm7hfdfLU05wkKX2iLw7nel82ylBP162CTEP
	SYO2fHS56gaajfRzvuYkEo1CQ3DFnJz6CPDV5k5sKCkciTPYSVdDEo9a3l9HWjp2
	HvCCdA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcsu891-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 09:15:40 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12721cd1a2aso7098079c88.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775034939; x=1775639739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BBPB/FSLYg0K2Rdi+KbCC4Oq8XCYRTZKAKMV1mBmtI=;
        b=jgLYwplUGGP0erSTU3J8ZBPclBQ8EKPP3FvZqzEAt+j7T4MCF1UD4q97ackhGB5eJ5
         G7nTs3IYdnwsFqo34NZQO1U2S80Go69MaYrq4KxAfm7eF5FmD5sOMqmad1bDdoUKwViO
         eDJ7eIRreR8RkUmrLrNJhf1/2Mmmn6tOPvSbuS9Ow6JcLTfODfbAyjNXeg80MFqeNlrp
         H3T67ve+XqlDOZUsYkLIWTr5nx2f+T1ez0eyKvT5BL0t+IPNFqjUGwCRmYx2Kekms9h4
         SckGtH+Rzypp/OPdkJ4l0DMSEdEVxMGoK7JS+XRIqnEQrdkeWsfCio8yDCPBL/pviIsT
         cE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034939; x=1775639739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/BBPB/FSLYg0K2Rdi+KbCC4Oq8XCYRTZKAKMV1mBmtI=;
        b=WdbW3I58QPFbcoUjDUM3wThK+xIb0sdKfKcYlhKi5YUKBrb80R74K/6KG/1758xETF
         3VXFN/4v0SIJW6AawvDJZfS9YY6QVtGBFqwPJUbdCPjUGAGgGDjxcMIX6EdgKlCkpARp
         EetiuMmTEDa9E1Q9Eieiw3DtRY/JCseOrSZnTgeT9B3AB5iO3qUgF/Nl/aRYJ8ZhPDlJ
         i9CUoWSK60Mri8zOu7t9ZNFY6SLGcVKLGRyDTQZJP5s+RjSpc4vaNAVmSvt0k/IACabs
         LByE17lL59sgmpC34MKGHMkAYOJ4hVTAYhp/5x3wMZXDOHXnBQgv9hP4MP8YyTFdxNFt
         a16A==
X-Forwarded-Encrypted: i=1; AJvYcCWRbMQ+bENI7Gl9Q+7d9WG59NIEUaTvP1WI4rI7UEee/wixnWEBtCdkoPmUpMq6bBp0wwmD4Jz9qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpyB1H0lXs9UbGeQn1U4AOSBgnDxOf/OOqmCN9OL63xNfrJAJ
	yXuD3lca4CSqXTCwx/WorPswOu7GivBqeX7ZkT4oz0kDCzptYgmYWvASA7YckGdkPG9zJdz5wQP
	z4MT3ajEe0N6ILeDdQs39grVfILQGHgeUVtgj0E04XkdgkslBpHTHOg+014TBMw==
X-Gm-Gg: ATEYQzxdKcXtOnJWxe+Ero8yqt+MvBJgOGIxko88f5mGilTipe8fs7YAvGyaOrvU4FD
	rGxRti9WLs7j42Uup1ecaAICSvrbGLG7VXBvrytx+/pwvcne5dCgqUyS5I9vEYlx/6GfhF+7Vp3
	hZt7YKh9eUOhakrQE1UPkrR9JuM5sdUABipQjsGWOsg/TMmJwZKG8Cvi54XxICiqpCYTl2lJOLh
	1VMhv+vYwkTLqPaxgIR6r5G0/AAigEstYAi/tfrF5SkZnD0Gn8tDTt6+JUJEsqq4xAJhF99A2YG
	/UvHOooIKubpO+O/vgMqDPdrq1CceZ6bABr3YLr/atIliymgy/h3uUu+PMcGUgm+gCYR69XfmmN
	Tf7kHI1DPX89BAt4RlvqQWBL5M9JMl6ykHbzwwXEUgymuYQ6Gei8yH+ubbCs/N6BGRvRBvKmWoA
	==
X-Received: by 2002:a05:7022:7f12:b0:12b:ebb9:1c18 with SMTP id a92af1059eb24-12bebb920e6mr34940c88.31.1775034939280;
        Wed, 01 Apr 2026 02:15:39 -0700 (PDT)
X-Received: by 2002:a05:7022:7f12:b0:12b:ebb9:1c18 with SMTP id a92af1059eb24-12bebb920e6mr34926c88.31.1775034938658;
        Wed, 01 Apr 2026 02:15:38 -0700 (PDT)
Received: from hu-fenglinw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm18285025c88.7.2026.04.01.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:15:38 -0700 (PDT)
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 02:15:29 -0700
Subject: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: Add Hawi RPMh power
 domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-haw-rpmhpd-v1-1-c830c79ed8f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775034936; l=744;
 i=fenglin.wu@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=tx0he3/MmcRXd/XIsxErZQP8p/i8WWMq/f0HSUslY5o=;
 b=QesnCfG3bmd5H8wD5oO0AgsjYZw7/8oOfl40RuKe5J5FLfFsm6JMfe56Qs71Y9RBpeWBjaOqi
 KFxFmOqWLJqCbDIec2rVmRp3NgZTNouH+nI7qEf/F2mK1f+V2o/I1+M
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=hJdt3E7o54lql+miD2GaxwF74cDyhgNwMbmFOZ46bRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4MSBTYWx0ZWRfX3pSm3MTrw+fj
 sN+Ub+6wktRxlz9jbd6qcp8nsbrWgSAqtdWjKIJhDqkkR4Chq+3bC01SS48UmakXyMxt+rXFNRk
 8h9R/hgx/SNMBsJyt4Bxn9xAI9TnzhkJDfgEt6RVjhGpCFlAeFPhg3SRQPT8NvSTRHRh8J1L2uK
 cFxYa0aYlvkv7eF+08ir1KM4HxU/B0w1Ii9+pIW0QLHbEMMQwmcKlQzJFpKFL4fW9WENVqsEi23
 ZOrhcPe2Cz5XN8WVuxrPOCJK8UZci6aB/7MYVvdYjxzEoDPX6BNn/eZoPFPGpIaY2NcIUgaE+S1
 e5gNwWWEZy6GqBPNnr6j8mSQAGuPVVHefmFQ8a3mAWqfhRT/K5CDk+YTwkJ9Hu9WMKG9jkSfy9u
 BoIJZh7XG0o7YFc2xhK1+YtSrfCoRVQAHvn8DhyUk7IJ50KqJMIfFxIzL78vtabKF+eDqtWQC/P
 BdFjA6UM0V3iRFYRqsg==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69cce23c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hqjnkh-R_53NPVJCVN8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: NRvAHnvQd3Mjsi8TAUjQTHB0KMNEID09
X-Proofpoint-GUID: NRvAHnvQd3Mjsi8TAUjQTHB0KMNEID09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010081

Document the RPMh power domain for Hawi SoC.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 27af5b8aa134..35a0e01c2015 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-rpmhpd
+          - qcom,hawi-rpmhpd
           - qcom,kaanapali-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd

-- 
2.43.0

