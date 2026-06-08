Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6CB36A03B
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924254; cv=none; b=V01cdQkPRoxOHnH0hUjiWD6pp3Iz3A9RFYuG+mY1W/ZMWicRUG86DCeFI8U6HwPe7MnykbtfeQGPAsK7XzHJiFjcxaQBHuiwIjYx0nTHGwo8n2IhcxeRxTpcC0kF+pmEFJ1bLiC6q7q5FleuICcgw6gkXbJ34LDqiCuQ0W8wDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924254; c=relaxed/simple;
	bh=9nJ4RWVS4xD358qxJqQ8mIalRRMghPwYWOD3PcvvDzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPZo1ERBwjSYaeO09/FTH2O5/IBR0kXYeazkoEXbGFcfSKWWI5+bWMQpqMTZ5aq/b+nYCj3JpVc6YjmwDyXD7zUFYUVRGN3ZImKQ4/Chn4ecJsdJkog8N7Ss4+601b9V2Hq2aBI7n3+cugI1mg2IxwYcLIjgbfELnJhoJ0KnSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ToeN8+DL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xxn8HxqO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ToeN8+DL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xxn8HxqO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9Tb33038240
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=; b=ToeN8+DLKCltdiOf
	QYvKO6TWXiRhb2XgeqvhBwzN2Wmoo+Yk7SL/hHDmlfMdxvV2u1pVTXmFbfbN86ki
	CA0Y0iwGePGa/3lHvIoEGuFhywavLko0EgnRJi1PetEf/DMAb2OpWkTo+kKDCNfM
	/AfsUiD52AYVDDPrsqUfxnk6yp5uENsbQjnv2rD4Sx47ROjtu/9E+w838VdzmAaz
	nhxsUCrPHWd9afG+hPlR9qIwCZtXxsF4ycTPRUUa6qoL+rIVSBMwd6rscXJyKQ48
	02HuCwMaVvJaWL+Z+CfpN/6RVZHNSP5o16l7+jj2zIjAKyB1w6IuqBdXoSWU9zcQ
	OHf1HA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8jkh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:10:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2befec3fd8fso30120125ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924252; x=1781529052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=Xxn8HxqOTpl7nKV3xK1sK9RpjzPJMOMKZ1FUlrqcc7EciyYPkneXGd2EA1g4os6Fd8
         4mjCl/+WPjS+93cSkCMmtidKW6EY/FwydB4qj5lYtuUTDyGlfp21n7R+saa2O4QXzQTy
         kJ9rvs2XHEQH83UvraYSDPn84fALFW6VHhdBJNJq0qEaf8uXLFQq9zMxQtIoS2osTN9R
         UJNRN5YB0N9ffkCiMKHAxg4HW56cfOWvTXMh3DSWpxsaqZinYbxxuQct/VG+zBBxymOU
         J577LvOPeeVtZxGaisilwjhttbZw7mQnrSg1JUXbod8K6nPY5MWs5sjl9MxUO9/qfuMb
         J5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924252; x=1781529052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=CrgriFofdcnzdrtQXRIO75F155ahP6XTNLIDnH4suHhTWYpJ9mXq5bcWPp5F06zv2p
         no+aZAQOwD6bSJ4e1rv6AHHBzKKocv0+JCvbGqANPrPe8wOi12zOK44XD8cAg36xhhQE
         zscdRRIpOdf8YwKnXcqMPlLoLbU9nceOoCnO2VI3V/8i8AEkrVbk6lOa+fD8yBripFs2
         P0QtrBv+N1cUXcmjz6rl70Rqe5LEvP/4A/xUp+naH+UP2+MWI+ilMFYf2Ee2EN7bCjM/
         SgeZmSr7W/k72oE/RF02AyhaTHKpaaEw1PadlJahq0oPO+6SWipRhrV6a94hMwtF3FvD
         rtQg==
X-Forwarded-Encrypted: i=1; AFNElJ9eeLWGv9dzIpga5m3K40qdZHwP8Aw4aoQypRQiY0SGsuh94rd0UslHSDdkhkrpF1wb56K/DlN+eA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SNJ054/xXDBmHC1Yi4ZKfPHOFQFhrUlhJzCKdRUFSONyQuXw
	msQqwNqetqTV34F9tssHtJHR1W8Xbr26vin3gbL26ouaGHcXGpX603aSbAuXpVZfr6XDWUtoPp8
	8LHwELbc8GE9ZsafbZsCqjYk6ivl7NCyi/iE+yvd8XTMl5JosRlMeg9syhWnDGQ==
X-Gm-Gg: Acq92OEGyF3koik5v6eIUmMxJ+MMvrzQOzMgxSyyQaE/gxQoZCl7vEDgwQ2gL+rPbih
	NLPr+QdXDOcGSDErL/6yoFyW1zTfi578Ot82L89AbERqHkQGM8pDl9ipgV3doZhtRh7iCQi6Ps5
	lZ5vXfTi7LDZYWif3y3/Y5BItL0lUtAZngFNe4bZc90WDpOapiNUaF5/LQOCA5EJhHObMWCSZkH
	jlZMxJOY+h8F8PltXifvhxMTsETSt7scmO13USRCHH/HkolTUEqiLk65FPQjQ7H+NMQVliIYkb2
	uStBFuyeuIRh7w0k0IJpm19csglHG8pd0XxftoKw3hdaJDz0/qaFFf3/CcuOgjyBYjpCsnePGxf
	g+jXlc4/qneuZn5X4ynIjCqz+IoZj0mBZ3jF9swMc4SBfkNg=
X-Received: by 2002:a17:902:f606:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2c1e810e153mr176408035ad.26.1780924251956;
        Mon, 08 Jun 2026 06:10:51 -0700 (PDT)
X-Received: by 2002:a17:902:f606:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2c1e810e153mr176407605ad.26.1780924251482;
        Mon, 08 Jun 2026 06:10:51 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:51 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:22 +0530
Subject: [PATCH v4 02/10] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-2-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=1132;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ie2wM60+tAThpQPFlruvov7NzPvO75/SEoFhbJfHGt4=;
 b=tNkS0s8Bu4a5n5l/WlkzXwkGjZxfxwWSDn+0OvPTRAaen3Spmk3CD/7q+v/+CPsg4O/e9t2jk
 hXG9g5vRbKrC6qR9FtrD95X6awPWXaSBT3PBCEd5nCvjLnhQCqswj7n
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: OtSO8OE6rhOnBoUeD-BeL7mxIykeJAAs
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26bf5c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: OtSO8OE6rhOnBoUeD-BeL7mxIykeJAAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX3Z3R/LOy9QXn
 twtjcZAdIZHpYaF48Xdu0+ahqqj5NPTLaohkKnCcHxkxgX2LAV6rbA26eC6+QxtCzuEsakNKw4q
 GJfsySvMhXpqSL7TOvGlW/A/wYrzBJW0fgcFRQCVMpFIVWqFpzCh7Z6SVWulifTVS2X/TymdRkN
 eT9NnNw17dFcR+VLvexq6z7eGOyoMiAjYHuJPmTpq2wYuH1cLB2QV++Xt7TFNSvcgyEZeOaZRQo
 9O0meTgzQdT6k8mqWkZCZ9MV6fg1zvziKvFXBOyA1LSexcO8bkSQKxpDMeX+uTn2WLlVs2KMhlF
 zp3HkEKxBgMjjlJTrH4K7JYccdLPZU5qt/q42XWN1S4BXySoX2SBZo8Hs3tstL6to5bz83BoFQU
 xHPByNdhNICn0iximr3gLcDUAtb1S8IRCI990xvsDBbaPO5Mw+yAYRozNsBRdUOR2kwldasHl4r
 40s2R+ixAoUNnb84Xng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

