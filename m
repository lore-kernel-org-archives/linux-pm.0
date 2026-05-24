Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33C3195FB
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652182; cv=none; b=kg/Peo7mjMFsaPZrdldHjFsigFyAzIR8bTcESH53W0w34qOhB+/BYK4vuAHcXxTSx6FEHptOuw4HFFdIkd11ZK+aHJ0KOzi1LSkYmjCGEyJrq7GVeW9+KVvp167r57VgeGokEM/HZHvF4MLeywTqgs3vNVTvRCCmu+sZqm0/3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652182; c=relaxed/simple;
	bh=xt8fdY5E19585IRxlf2tv2dOaGtOy/UcGSJMOtFMvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucx/PAOWcvXQ3vhrJCUMuOZVSMyxriVU7us84spAR3IkXm/d4IKdG1br6uidO/QADXI9Hv5pxK75mUlrCbf7bp/MdgfA1udXFtKn6yBsLIJUYyvFv5BhhGTuh42H4Zq5n9msPJIuvT6ySXQBvyGEANH0GoMHXMCdO6/4ScKPKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qldi2ZGT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AUKVJJIe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qldi2ZGT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AUKVJJIe"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OIe8kS4083774
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=; b=Qldi2ZGT1tzOY/PB
	yxsmbJyWtPfWNTz5HQff8DhOsrcyM+7945g1GDtpZWB/sIvb/ZpljzF0LnyehR1l
	Mx2FJFpfHCZmlxaZiSitl5p2/obW4W5RllFTO0HZWIZdcvG98dPKbbcvhcKhdp/r
	p1GPQr8M1hCw7JkZm/Lxy4ToL0sgWR/qX3UizZZUkNptbs0cIsVfVt68DssgiRrS
	WWIgrRv5UQzEpybuCSjZikeZ3ICOsHUn2u6Y/ydvJCUpuebtZb8uhY6QDFOvJ8cw
	Kp4ehgXt6a9DoOmbfqeasu5vtjLw0fJ13ptWAHaEuEmeOeRLcFYNai/Iu6qkZM1D
	LewO/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386m2qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3692f395339so9036799a91.1
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652178; x=1780256978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=AUKVJJIeQzwwt76iNIzs3bMdcTlOpD6zH+PMK+FNRr0fuG2BE0ByC16yY0Cn8cIrG9
         sBK+PwfLITSzTzOLph49j0YXy4rqTjM1MtHNlwW7R4GWeqM9plb+PWNR6/EafXb5oS6h
         c9xJKwtIhFJIpwp+9TSKhsnZYtbMx4eTuZMkgmgym3aTOUhpNMdAcoBKfUIFopG+F3l/
         ONMa016CGTl5pg4NlJo0+1I93Wf6UQi1mgya+63a6io2n3+sKk9RtgbHbMDcv6G4JYq5
         rRn8RX0y9aixhWqm0npAk+TD6NcBXAoepFGFTYy+XUcR/uEp/O3gU+DcsPhaoMkGgOkb
         tZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652178; x=1780256978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=mYxrVEaQgrbQsIULBAbUkulQDH+JKbiHcSBZFCJl1q0xPn8cbCHEJ56yCpVdHK+aba
         KXUZVsgA8Xp6/UffFiK1P1JCLpggVQmf8+/DBpRUVF6ONf95XYIM/xJOnu2zcIcJBL6n
         7Qxj26zIZrggg3UW809ywR1zpVkAx/13U6KVgGd4jllyemCNTuFsPg09c0zFIY/YDh0X
         1oEJguPgai/AmXwmaNQ3zkq8GppCTvTpObJSL2YOlPCioPW8ecGrJ9A2lPcOEuZr4uKx
         PuKjA9yX8+EHX4YpGAJH5fHiNjIbG9/653GbiNUxj/ruiLDiSl8fv2apzRy3YTIBcwzJ
         aKYQ==
X-Forwarded-Encrypted: i=1; AFNElJ98a5b+h+lS2CfsnvJqpVVuR+3RH/x7ANnD1YpVcy98MuGyOGRTI0XvB0utBPlShP2RkDZOGKn5Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2A4IhhZS8VZv9yP8KpQV6Tutd8xhVZ8wbFuX6Aj0MquPOcAg
	FMSfSKOOszjBpDP1Ak/X6ndWuNap+evcm7oFFMB3BQvO+FTy9wAdD0s1xRMWy+2Lv+X0MklwpRH
	jLxUI5+MXfuTrX4DZ9YWYal45R8wJ4gToOVx1TvVqr0Wo0LnbsGjRIIKspFVzqw==
X-Gm-Gg: Acq92OE8i2sMwnaDqVrMHGjfVi7HkgqhFeMOf5c5xU9CUdIpLbS1UpscQ4n6yvL8BYM
	Z/Y4zQaQ4FZuP3oUPWclqmo0Hf6oXNv0RzrioGT72/NSKUzTyUrGFcktHj1xH6E2QsmcIHm5alq
	R7h2fMjaaGM8lBrouztnDmLRb+1mmK3sDhbHgyizZHja5p1ybwABWzk+H0R3HRw3tJgS3cotsun
	u+9Y+LNw5zi1YEOnhbT0ebowFTPq7uDQyQRxzffGWJgdUNzGVzfoUyXkUDeB95pVqyP4yd88IOY
	QClYHj2hcOfaPUFZJ7xbG2SnkS2lDixBSWqGixd673m0dnbbveKdj3Oma1PMZPFHkqpkuyeNxgU
	Ex+dgM4g5Ddapar4SwCFvqwJGh4H/3DYbslP3
X-Received: by 2002:a17:90b:4c87:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-36a6762542emr11236364a91.19.1779652177379;
        Sun, 24 May 2026 12:49:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4c87:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-36a6762542emr11236340a91.19.1779652176837;
        Sun, 24 May 2026 12:49:36 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:36 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:06 +0530
Subject: [PATCH 02/16] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-2-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1062;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=MfVD9NAJt+YvcfkJInifeQ/jWKYZMhdr3T/JUeWSDbk=;
 b=29RL4I7Ux9+C57dyAQnhNhFTDoo4eCONKIcb+Dm+cyWsxoYC8iISBS1CA1Yg86kt9nuCErdyM
 u6duK4QOoKHC+Qksbo0V8tjo0h8UF6NIh20Wpemx3XoZQ9tLQH/r9RF
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: KDFNIr1MTsra9f8kHugL0-AqgGC8IXZe
X-Proofpoint-GUID: KDFNIr1MTsra9f8kHugL0-AqgGC8IXZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXyfGvgVYxDpZy
 u/uZPtrT4Fe0GVBB8+Tfb3QhE31Ni2t87ie9Sf82EWfp5XY6AE1s/kcW4R2FrD5uIMXevOQOHHT
 uhSUwYnOyiPKUQBRUXHOLFxqRz0Dbd9hmOhqlmQ5hz7ZfM657KaBFdDHtY98DFX3bMjWzPP8t5y
 ivEb23FCgA8IuugBNWxVvcZuxUhIsWJgCf9+sdKF/gzLKI/+0j0ZoqcipYu4z4a2el+NKAy0sZL
 CYGulNQqbeG+1TOw4neVOcYA0O6CLlxvpCnx7MzMgByjapj0eBKNEfa9561TjkuqjJyjE0fCoEe
 dTAFxMxSJaMDxsQCinUfsJrRpwOoaryjQIDVx1VHEBkWItL0tpVh1F1RHachle7/C/YcaYkIeEX
 zunrdtW0l82n8KGzVgI3NOZO+nCJ6Emi/KVXh2EB8J5tDQ9cywmOoGWQtikGfyXkghnnn8lPcDk
 J8yZanyDjQJ4NsuGf9Q==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a135652 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

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

