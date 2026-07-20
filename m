Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F19388887
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574226; cv=none; b=OeJUn8GcL8pg1wIYnLjgBOgmRx3Mzsb+BhTxNaCCH3OB/nxTF7iSbqMxnl5OVReLbiq/dT1NhjWACzXVrduURgtgaqbuokxWK1Ka8vO39BYGdNW+JzsMZFA/SzF6fwrNwEmVL3TN7KP/8GrPZElEu9PU2p4FdAYLXCezG53L0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574226; c=relaxed/simple;
	bh=P3qudtq8aL5VayRLTwk45JoQ+Pok+bOMfhCUWilcNIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sX45Mi6UOoW+VpqgIBnjoKZ8TrwZzWKLyFSEpoG0rceR2aFArYkz0UO/0c1goBFARz9KFRXuD7YyVy/bIkuY+dHntvKIDC2zjFTvMguSmVYFzmyMqXuu1uqk3ogDw1tH/zuXx30zGUIb1PgB2J/DlY4/ZJUJgaHWihN4kAO5yG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1lZnIVF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2pmu3Jx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1lZnIVF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2pmu3Jx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KH6dTe3044142
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PuWa4CSJ71smicbQ1SN4Kz4bDAAQ4V0JRNi12E/BNQ8=; b=p1lZnIVFhxCOr2r8
	FwoScd1wsjRT4m8uBZ0tWMo+oovPVm8x6t/HCmP4KYw44iVRBlHpGGGjfuKx5IbS
	J8nYmCtjfQ0ZfS70yyautckKqMe5qikKvg8Xn2OB6ayjpi11z8KO69KJHVpVqVEs
	8xVq5gysj9paRKCOAOKvcm1rB9zLzGxnO8aURJs7CDcaydynPdhjyxpw5hgx3lG/
	a8VwGL9daqjTVwKnc6lCwnz0tIBgN/WwHeMt+bEdQdq7PXvdEDwRuJo7vtgU2t4p
	85fJITwJ628o7Z7rvUdHFczJt3FtgzDCKsrzMtMmvz98uGjkZoybboZ4zdtf/G9U
	fEySww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs02ke9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bff5c7035so100097681cf.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784574223; x=1785179023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PuWa4CSJ71smicbQ1SN4Kz4bDAAQ4V0JRNi12E/BNQ8=;
        b=X2pmu3JxSIZ7zwIfsZFD0nIjGXEltTQDpT64/LBXd9ogzOAvWCh9owtLvKCL9isG6a
         9y6wnX2NaMJxW7yXiWI2RkGtsrWvg363ug0BIfhFJLJU6g1/z3FdfK6tmgdtyyQXblUS
         gfX9mld8yXSRw23fwo8zKiLmhCDEXi2ua4OfLScbKNEkFfoqfnW7MNdGADuMAHIaJhcZ
         +OyKBhNwzm7WlAIYvGmHY2OJ3FHWu7bJf1QYuicr4uVFkBRdkSR3f4T7oZPhuyCQLqih
         2WM23tRQE2sUqhN9xPowUtOvc50uj6lmr6B8AFSYyZ9mgKlKSdj0fLj+sX01YUWHs79Z
         0QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574223; x=1785179023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PuWa4CSJ71smicbQ1SN4Kz4bDAAQ4V0JRNi12E/BNQ8=;
        b=W+RQ1i7kP8JvCI1HmYPbh9GoDCcWrQFZbHl3x4ExvautZbEVIstM33eM9b24lFuyc8
         vv/RqfsneKMQ73o6fiGyFZ6LXqtfCQL5AoFIAVqambm25uH4Tx/booqEeRn8v/VGg7zm
         PUOE1FQjiWk2oyEE4ep15oGe0ixVB2wufiw/neppbdpNG6ekidu3iXRbPBKPNkSRvXRj
         0CjdvnfXrFd9FfReX8+cT37U4nBQzg7eDoiRtZg9uHH48w1/hQfA9A8wZZxqy16HBayR
         8xLJUIK6FQxP5MhC81cdpy0UgHzO2ranVFTgn5JAhmeJYI1dt7h+LW6z+VWn+Z4Ld32m
         b0OQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQOr0LDvDQeXp+n7TeKHmTFL96nUShw7vU9Njtn/JdxSPD1HToYpiAiGs3i7hay3bDDoi3FEFSHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkmdV272cNQQhkpxfIn7bafBM3HeZ6u8az/jSULEoogzs92pU
	MM0zIw1T3Q8ajAMho/Y5AhBU9QUsiTLhBmN9sF10qlvcpoYf4+l6cvkECFV/syB92witGbG96+E
	wmBdnS3VFwjg8vWt0jpZuG6gAIZzmmoZ5QivHW3TSuFqrOCq5tqrEF1rbCDUsmg==
X-Gm-Gg: AfdE7cnwmednxiOmnIXNumwoyWex8RbiSQ4TZET/MN2st8nPJv01z4i+c/lDY3SZ5Pj
	wQ0B+NJGPXF+cX4tkMDgtblNs4JiVEYX5w5munBkEy9uyB2vmETdAd3WK7/Pa6vH2Kyq3stN4CO
	6uNFAsJMXJFxfethOFyonZb15vQ4DR5MKIqQ4z+MLNuwgp1gxM2sTkDlHykoGyIT3HTM4eB4AUJ
	M4IPMWhQvak+xWKclWO6XDYJPWfLkYr//yy4IFlPPO5EfbUa0jCemIE6LEJ5vWfnHzT0scFdH4F
	8cDFaGefFKBR/kip7D/jPaOb6LSXcQV9Xe1gIhZ76S5j0wf8JyKeaB8T7yFRlv65HJndoS+n6ea
	jPIgqVWJ12jgzRVK5mjqH91mX
X-Received: by 2002:a05:622a:5b0c:b0:51a:8dc5:bf89 with SMTP id d75a77b69052e-5213a383538mr134376681cf.5.1784574222716;
        Mon, 20 Jul 2026 12:03:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5b0c:b0:51a:8dc5:bf89 with SMTP id d75a77b69052e-5213a383538mr134376321cf.5.1784574222376;
        Mon, 20 Jul 2026 12:03:42 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954aa1a231sm181509845e9.1.2026.07.20.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:03:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 21:03:29 +0200
Subject: [PATCH v3 3/3] ARM/arm64: defconfig: Drop redundant Qualcomm
 interconnect entries
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-interconnect-qcom-clean-arm64-v3-3-942e8ee7ebda@oss.qualcomm.com>
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=P3qudtq8aL5VayRLTwk45JoQ+Pok+bOMfhCUWilcNIU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqXnEFmk3ZaxFirB5xz6i/Pw9DZ1VgvyXjLIt34
 tqnNQYkUxeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCal5xBQAKCRDBN2bmhouD
 1yXjD/4mBaoS1yc+FLKpo4ORjSJV/YHXAbA4lLPhLCDmemdak9rj+o8HJ1ux406sL80xDANWdoo
 5EwFysLADJzOKLqQhGuHtXZ/TdIwu4to+ICiMVkA8rVBkQIt85odqTQu3oJfSmdRB9/ekLcn3Pd
 XRWHdvJeZXOOaizd5YXhZJ9LUCJajDs4mFuqt53L+xxNdydIC6iYoXQse77AEdyCb83gw5hV0SG
 rr/eK17QkeKI4LbUNPxJf8xR/ZY+1oPAr56jalsE0Ur2NfUvqYsquJmFN8Vmyq6e2haOiKzsPTS
 tu2HJwEBHJze5Y670SLOHaCUEntp+SB15guCTosHIhbC3Y/g6tylka59Bd3tYQS2VdG5iWnD3uD
 g5w55OREhD1DwiqXqopCWLMYIVabxi7LJQIKUcQZ/72SmrS63R0P1XTq4QoJOJJQVlQpP1ANqYu
 NUjm/HJ0fS7Ohw/V7vA6ZdeF5G+UeNa3XCuuhCIhQdtAGf7yn2x7+uuPsAjtO2eRt+MVHwSR4YZ
 YqriIGZAz+LeiSBupq8x/nUIILOZOYzq8Gnjc1KGANXQYWwZF7cLyz5l/nZ80epy5ZlsWevYTIR
 SMDRwhBZL0CyfIvAS5mDI+j/GyD/eeq0hSUjZyRIcpa2+UXqYsHEs63asMnqH/l/ZOI5WkZ+NQK
 GStxJDBZpEHoU3g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfX1sFFLPAzjKX1
 lamXBX+Q1FZFaw0JbzHQ3QJwAzMgyDMlgDRogqRiBElDShtkLR8gJgBrCFBnE3smcYXgu7XSb4p
 IT9YI4yBcLktJmT0oK8Ktidgc0H7HaM=
X-Proofpoint-ORIG-GUID: SUsU4hBTWdE38Tu4t1sl13sf7nIKTCfl
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e710f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=YAWiFM8ZlreF83lw66sA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: SUsU4hBTWdE38Tu4t1sl13sf7nIKTCfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfXz1czgiAKpan3
 8L6p5tDne1DflUfl5a582hGEPD0DwKQ306YK4w3uEuK/iwuxc25N/7bKcMLrvTv0M8+OPb8COW0
 YZQUeQgqedzRjKA/Un9xeFxneYdj/Vwx7bExUM+RCfbAezCIE6NKMdLREKswJwQKlQPDJkh20bx
 dZZ0eGW9aXA74em4WFhZtQxy6rR3dgwyWcULpwj0BwE4E/jJqw2ZfKFQxkVEpdf+pFFTvIGSpE0
 vGkUj8XaM0e+vJk+DI9Op3yJy5BJhS6XmamBkqyY66AZEDtNNFhYGugmLdMFD2y41XO7yB0VX2F
 21WmAp/lgXD3S6p/bq340Vy+OUiIw6a3SbNrEM/lKU+P4V9iC4gmGGQTyrPn8IApMOivCF8jmOL
 jho2/nWjiZr8Iz2MbEatkbDrzmIdsSb9MxsicjbMWyh4s5sRSesilZJm1tGacyNKsSaDL/sMqdY
 AXyDYyTLx+/nO1E0lRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200208

Drop all drivers from defconfig which have defaults in Kconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/configs/qcom_defconfig |  3 ---
 arch/arm64/configs/defconfig    | 31 -------------------------------
 2 files changed, 34 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index df0a0ce5b097..630e31c036a9 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -272,9 +272,6 @@ CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_NVMEM_QCOM_QFPROM=y
 CONFIG_INTERCONNECT=y
-CONFIG_INTERCONNECT_QCOM=y
-CONFIG_INTERCONNECT_QCOM_MSM8974=m
-CONFIG_INTERCONNECT_QCOM_SDX55=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91a3b2cd10b3..b11040fa9cfd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1863,37 +1863,6 @@ CONFIG_INTERCONNECT_IMX8MM=m
 CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_IMX8MP=y
-CONFIG_INTERCONNECT_QCOM=y
-CONFIG_INTERCONNECT_QCOM_ELIZA=y
-CONFIG_INTERCONNECT_QCOM_GLYMUR=y
-CONFIG_INTERCONNECT_QCOM_KAANAPALI=y
-CONFIG_INTERCONNECT_QCOM_MSM8916=m
-CONFIG_INTERCONNECT_QCOM_MSM8953=y
-CONFIG_INTERCONNECT_QCOM_MSM8996=y
-CONFIG_INTERCONNECT_QCOM_OSM_L3=m
-CONFIG_INTERCONNECT_QCOM_QCM2290=y
-CONFIG_INTERCONNECT_QCOM_QCS404=m
-CONFIG_INTERCONNECT_QCOM_QCS615=y
-CONFIG_INTERCONNECT_QCOM_QCS8300=y
-CONFIG_INTERCONNECT_QCOM_QDU1000=y
-CONFIG_INTERCONNECT_QCOM_SA8775P=y
-CONFIG_INTERCONNECT_QCOM_SC7180=y
-CONFIG_INTERCONNECT_QCOM_SC7280=y
-CONFIG_INTERCONNECT_QCOM_SC8180X=y
-CONFIG_INTERCONNECT_QCOM_SC8280XP=y
-CONFIG_INTERCONNECT_QCOM_SDM845=y
-CONFIG_INTERCONNECT_QCOM_SDX75=y
-CONFIG_INTERCONNECT_QCOM_SM6115=y
-CONFIG_INTERCONNECT_QCOM_SM6350=y
-CONFIG_INTERCONNECT_QCOM_MILOS=y
-CONFIG_INTERCONNECT_QCOM_SM8150=y
-CONFIG_INTERCONNECT_QCOM_SM8250=y
-CONFIG_INTERCONNECT_QCOM_SM8350=y
-CONFIG_INTERCONNECT_QCOM_SM8450=y
-CONFIG_INTERCONNECT_QCOM_SM8550=y
-CONFIG_INTERCONNECT_QCOM_SM8650=y
-CONFIG_INTERCONNECT_QCOM_SM8750=y
-CONFIG_INTERCONNECT_QCOM_X1E80100=y
 CONFIG_COUNTER=m
 CONFIG_RZ_MTU3_CNT=m
 CONFIG_STM32_TIMER_CNT=m

-- 
2.53.0

