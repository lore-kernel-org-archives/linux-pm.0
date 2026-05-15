Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925647DD78
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847088; cv=none; b=NTsfygQVpK8zcuSMBGmO++YlCG+fIX/yasTG8i4nWGVT563etI1ijf02ojWPQCCdPr9ndWB/vRqWIHYKhlNf5OtUCWbmcCjTbptd0ES6FjnILRlypMdLI8mw2wHgtS8KS2xb/hcUOUUV9t/rUEUArAeurf9OErefpRTa+2p5HOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847088; c=relaxed/simple;
	bh=yQAWJBywT6pwqGJLKFwuedfSMNGXnwkl9Ism4JarDpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOgxxRAvhrkcnw6Hjh4EcNxEPGJUuvOJS4JRHb36OdV57RzD7uR6UYBIUYePvJiWQZuGuZy1yeuR1+NWfY5iAevl1thsdQwb05GIr7HzqdRyiCeb1cmYaGQ4DhDdAOEnBKICF8WqibcEDaVQ6Oy2SQs5QcRZAqE/vjmGGy8mCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeRYgX69; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVZ7MEFi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeRYgX69";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVZ7MEFi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FB11gn1847946
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dEMWb3CKiGmBJqcMxJUz+Micd4CN6K2YYETwoBGc6kg=; b=YeRYgX69CVp1RTMy
	3uoFCAnJNW3U9LUp3+WLIDD1NWbefBnXMApn4+qPufnndd7gjdsFY/68s4+7xIhz
	EFiU3WGsS8uiA7RYKv3QKS8V33KVN1OuMeJ67doqghVf8XVIc87R4EjbIWeof/fw
	KL2Ynhoed73Tv8KTeZIQJGnfq6jMJSwf4OuXaaJMTQY1rY9ikyHjVYPinzQV+rdr
	Ff5pJ7BIFYh834GyDNMbogG0BTepg49tn8viwMPKShbU4nSE4ndQaGsaH/lLtgJ/
	VLdQSjn8J6FiYLGR8PAyqgak9KYt994C1ZFCG6ikMRLqNlmBQkhymGqvmka7pYPF
	Z6EebA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t34m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:25 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6343b1bcbe8so4239375137.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778847085; x=1779451885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEMWb3CKiGmBJqcMxJUz+Micd4CN6K2YYETwoBGc6kg=;
        b=WVZ7MEFiTHD33NoejhDSx+hRQmWmv0WYmfA5EwLoI00Ja0EF5xBUcnAN64tplXVmlt
         rIBt3qqtVHXg1YkNLNBOQEDnsK4Q6HxiOZXGWVy5SyvrkZU3ZJOM481Hm1ObpRJru/W4
         YBWCqVtEptU+4nhA5QjSJVrDbasDOsnTy4snHAT+kzge/qIK7sz5vg7PqFQ6nT8dNQW9
         15Wa6JndXSw24E+yEYT7Tj6gkzfBCGMxnaLjpnIqaJ1WZbO/nzCM9s2VlBPMqCKrvUU/
         RWnN4/lO42ojqdt53WiEB0/T4buPKDU3WWdiJa332JP5ABHAr5dIsG4FNoUNVsPWm73z
         aKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847085; x=1779451885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEMWb3CKiGmBJqcMxJUz+Micd4CN6K2YYETwoBGc6kg=;
        b=EB4Kjw1v8Q72h2iOCauLfTD2kdOqCSkrU+lNatipF6dP3jCEUSd2ht0zrnpBtxpP5p
         S1K9nrdKdP+sWPuZQ3kedDZNIQNtf0VlxrLemW4Ykq/sLJ10qzTR857hJHAuoeJ0NNz6
         LJHre2DoovOz9D72oVq/CTUwRrVSQ/z5JPLPxhhdqAkLUVrWDVLcqNgRkHt9s0g1E9qC
         4t3cHVp+Chu3jMTTTF88JVHxYUuqHRVKL03AljrdorjM9BHfO6e8uW1MEEz2rjwMGLLa
         /9f+6WYYdNFvFcmm7pWwqFGbIP6k/NNz59txjGalP5QYvSzBZpchL1obgYxUQrhYCqbE
         NX1A==
X-Forwarded-Encrypted: i=1; AFNElJ+ULtqUmu100b2zHy3uAPLhJlvDre6iKUlxWbJecFBxLVNj/ZSR3+fkAJnuA5JIoNSDUYtJ/egp3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrksBNXZNXj4izWnz9xCebsuQP4/OapDbJfLakv/+EN4tPQP4v
	XMJeBVZ6uvvxNVn0NOWjZGMW7ZlNK7gyTvz1Whujo/FHQTb7u1QZOk09efFvzQdnWZ2U5+TWrVS
	LMOC0tfFPgwBBD0pkzwzx+Sx8g1nMkVJz4wA2OwMLIevgo0lJ3Q6Za5UV6ClDYA==
X-Gm-Gg: Acq92OEJx3hoBCKQsw9SoMMiCwTce5QsNeUc3GXnko/OyiVBg3QW1hzCWiT7ZpXFeMc
	O/J7QyWT9OjNQg1+sBUOWdvjtqi/9/w+nDhrNWFZdulp8kKQETwODU06gPbsubTikLDU2d4HszF
	WX3qAD4NkIbkko4ZB32w8S5XwSbpeWecxkAksv2pDg9shcDryQ4EPvBxhMecT4SCGs0dFleZ74u
	Zt/0C916DL043aDkBH/ekQvKD5XYpHBVLPtUVUIk4MQjuoZDMr4D2e1PJTW1N17MktS+lNpDIKN
	1A/b57YJf2VCWbuFM9pGAYBzDatefCdkTknOMezvlvmkW9nwBLiYoC+YufeZfzYWPErotVtgCJd
	uX3BQgDz7MttlkaoXL8aXR19WaXM6ZGQGqXsojrJ6RYl2
X-Received: by 2002:a05:6102:3f4b:b0:631:28c1:1554 with SMTP id ada2fe7eead31-63a3cc0dc23mr1573650137.1.1778847084861;
        Fri, 15 May 2026 05:11:24 -0700 (PDT)
X-Received: by 2002:a05:6102:3f4b:b0:631:28c1:1554 with SMTP id ada2fe7eead31-63a3cc0dc23mr1573593137.1.1778847084298;
        Fri, 15 May 2026 05:11:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm66855685e9.7.2026.05.15.05.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:11:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:11:06 +0200
Subject: [PATCH v2 1/3] interconnect: qcom: Fix indentation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-interconnect-qcom-clean-arm64-v2-1-adeebc73596d@oss.qualcomm.com>
References: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
In-Reply-To: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yQAWJBywT6pwqGJLKFwuedfSMNGXnwkl9Ism4JarDpQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqBw1mhAma1Kk7FbCijArenpJeNhTmVnIGkALV1
 KtJL8knmb2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagcNZgAKCRDBN2bmhouD
 12QYD/9aaKMboLXLPWMgjwnKO2Be23qM/DK4PugY7JAqiYGANjGhjx9rAtxPlW1S9LIvvzGNgco
 9cfzcqQbdDYAVJP77tdtbL+UoOJ7i63UmDGeQsijiMrUGqtvzWK3D9R3nd179lJCauo0tzUucEK
 eA8PUEFnVw8DTKzLbnFKLCSbl7eOAUtkJpO/5eL3Wp1oaFQX9jBEWC9X75N9rHnZ6fq7fiPGWly
 +GDSO9SZ2vS0sLUZlBqeR4y4HqzHRzO9n73Ip713ouscPK0F8mJjzRmEEI+fYUfc7z/narbZurB
 KxMUeIF11FRX/2WFrS1y7Q5z+TCY2P1ri59s3l1fOLXjw4yi5XwacviJ/oTDp30AofSAvzai9PC
 84Lg9OkUFW2C0NEHIOqXZt7+67OHVf8Jotan3Dr3bby7lI6eJ3vgYox2xGRNtZH/mjplWbeo/yW
 HPyuvfnv3uMOIFB7XC2qG4AFFCrJbDL4u0BqKCoezCsy1IgwigkCtJ+KOCnDmFHqwGcWj8cxiQi
 t6O18lZKtdFlxf6gIR24UbY8E/lWAAklCZq8+joR+yyipoFovQqCQjf5XGqucPQbB529Tvs+XWt
 9llMzWTvdq1HdJcPXdBHRMrSTrdfdnzVIcSXXsX/wQgXujI3qGQRykwOQXl/6MBAnW4iLPM4ePQ
 Xd9i8x2Bm8L1bog==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a070d6d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UCTw9GvNnafMAvUb21oA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyMyBTYWx0ZWRfX8Y+eoCvsoSia
 ycwJLPX5iaYPR/8A+UtvI++19R7WfkALNAXXCRj04Zc5Bsw3FOo4IUgVaOfpnHgG3ZA39ABspCA
 0XZ5rM5p+b09niMSpPyfrnsTM09kAU4pzGYt9k3heMCnJUhYtQEd1yXxjogT6ruRDdo5UYS/Dvo
 +ID3SOk4mPy9SRsnJ++UAR4y15ZOYssjSpIPndXexdpOryITVBV+cCp1LqotzH55dRcanxboeJy
 aL+kIoayh9zW7Pbns8pWZXxGIB0T732XSO7Ve8d4HawX9jzPqDmN0vnN2WMf8p+BlSOyu4t2mtZ
 KK5JhPAbJp9+SA73R/mBm+OXU9fYnJ47yc2nPDwRjaKfI02onF2pDim/nA67mh6MbdUSxngTVVY
 R681eJ6mfNXFQ5+iyB9kc5Swgu109WYRuYJRNTn3P/XbUZYUDiEioXQJ0FLEA7/6pmtx5T4CeSg
 C5q/vPj59a9lFVExSyA==
X-Proofpoint-ORIG-GUID: gMlV3ESXvg-Wd-Hz6nI0umM-EdoUFOSL
X-Proofpoint-GUID: gMlV3ESXvg-Wd-Hz6nI0umM-EdoUFOSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150123

KConfig entries should be indented starting with one tab, so replace
spaces with it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 786b4eda44b4..871663bfd094 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -9,22 +9,22 @@ config INTERCONNECT_QCOM_BCM_VOTER
 	tristate
 
 config INTERCONNECT_QCOM_ELIZA
-       tristate "Qualcomm Eliza interconnect driver"
-       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
-       select INTERCONNECT_QCOM_RPMH
-       select INTERCONNECT_QCOM_BCM_VOTER
-       help
-         This is a driver for the Qualcomm Network-on-Chip on Eliza-based
-         platforms.
+	tristate "Qualcomm Eliza interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on Eliza-based
+	  platforms.
 
 config INTERCONNECT_QCOM_GLYMUR
-       tristate "Qualcomm Glymur interconnect driver"
-       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
-       select INTERCONNECT_QCOM_RPMH
-       select INTERCONNECT_QCOM_BCM_VOTER
-       help
-         This is a driver for the Qualcomm Network-on-Chip on glymur-based
-         platforms.
+	tristate "Qualcomm Glymur interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on glymur-based
+	  platforms.
 
 config INTERCONNECT_QCOM_KAANAPALI
 	tristate "Qualcomm Kaanapali interconnect driver"

-- 
2.51.0

