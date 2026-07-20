Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBC38F227
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784574224; cv=none; b=RD+FOtcF8qD8l1MRHEFP7DUI+t+no/nutsX0QnG92LPLzQU3yXS2F0w7ehyeebHcx+iblRIfW+xSR+wwXglKLK6VxTHw+3KlbqaRsOi/tj3IukqJ2VfmZqkDMp2Sy0AmbiOkMbbQZ7F3AO7KIkDH3aDL8amPsjcDgVQLmsjdH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784574224; c=relaxed/simple;
	bh=JR4Ua1kfTiV8QNLHWvAaewWDC4h+Q/DLdnHAzgTqOfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWT5ew9uujMF11WckPM+lNQIQkv4PEmxVVOUv3x1UYTPt9T1OLNUukvLqxvK7IxhtO8ozPiGPgO+cw+2q/W/RcYNSp1dCj2FbgdYZiIIrDdmPQF6P1xtxiphgosaROpXMjrqYOBoo9EZIqqS2RvlypuX+2zIk7zM9qwOfLWCfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ee9dd5UK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NkLVMGm+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ee9dd5UK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkLVMGm+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KH78be3300172
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iqC1UMQqgc8CPLMgHXDTgheCDiJEX3V1C83nXvjGTf4=; b=Ee9dd5UKiMh0diim
	DZLA45h9K5kuPbDDEtf+J51ane58QBP3HWL0/oz+n87oeSB/JCGVkTRM//6ZjVfS
	WiXIDGH6TO2ga0mV/jP9af2beUDMcy55YtHwlk2ZEEg/t6pIldW7Ll8hLtiLOchh
	CtkhvVmcg9Scd5nPo8QYyona0q1Qv7nlB5ylFz9n86PuAPeno+5MqVo9H4fAmwIm
	ggO/GNKlawhoj7VbkHs5vAm3DJUoQqCsN59naH8MTSO+GuTUGrP0isi9DmlOdMlS
	ZmqvMOuHd10wa76g52bq+5vqLOAmOtt6+mik6c3OS/lVVJ+x8P8Ip7/azmDafAa5
	x/nxTg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxjy5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 19:03:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8b0a08d2so152902411cf.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784574221; x=1785179021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqC1UMQqgc8CPLMgHXDTgheCDiJEX3V1C83nXvjGTf4=;
        b=NkLVMGm+MeFA1WZCO2+eOMGhO/SKUpKZ+hkTYMEcOT/lmYGDUo+vGuLEev5KEd6SXt
         l5p6EjHs+AVJ73YNYRhSE1M/WgSkxUAQNN974Z8X7P3dFTNmj5Yla+2j2gDGp8P7FiYq
         pilfMmr97t5fQBTBTCkACSc32l/357dusY59ZClBTcxR0biA0etkaZGd4oitB8AU2zcb
         ZdvGprNBTrstuU1K+mmNPNgKpNNsmMu/kB8aZj13GFMq3a0t0Q+3BBYbka/41vrtb29F
         8x7QShnOmtCyHMTEIDhIN/9U+8y/12uAz84r3/uAb/vK8HlqPGPJj1g+4MQusdY3xjri
         CtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574221; x=1785179021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqC1UMQqgc8CPLMgHXDTgheCDiJEX3V1C83nXvjGTf4=;
        b=N9myKmDBqDMSCbD6werjKUgWg3xh0RnUo/xobPZwRM49Dy7B9XAzvap5yT6hUZcVpS
         zQ47ZQtjvWZXxfen6gwBV7IXqW+nlnhOnV3/ggSFEcxLo2uapVEXybBVrL5QDvDe31zc
         suMpcGLXGGGvH0HreAaPGF4g7Tn1TWwEn92tCOxXkhym8lghzrPU53dQDXthwi1h6R9V
         dJAKWV/kPFRDGDuMcVt2nM6McSHKq0DGdKZwutpGTS/Qrv5BVA9vEA1+z0gPguanNYsm
         dNYFEPZrGTHp5L7Ku3GsGe1oAUbrVMz1mIyeJzDfcPJdxNOMiHmggLmmguxIrs3ErM0z
         zUGA==
X-Forwarded-Encrypted: i=1; AHgh+Rrdfv+L3yCT62QBG1viJziJqiF6HE+LUJmQi6qUhPyal/4HEW4FjbE2k0UonPIVlY7K1TmvQFYCzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmRcGcw81x0We8YmgiOPcKnTMmsTOKRT8p+9rygU/TWOSe7i0
	UYWSraWWs77B4VCmxE5ffqBex5NH4gAdpgWevBVb2T0lfbgdlODsB2U3MIBiN65L/sB/de00Gog
	2KzkmXr0BU7yLBXSe7d1xwMxby1JyVclGym80AYKxjkCX3v3VXLgzyOFwNzegTQ==
X-Gm-Gg: AfdE7clLDhJK2vz7zdX72rU8lzVTLunSi90DRoyk/bnAC0VJRI5CtzAHw+c7cMz+f/B
	XQPgBrGcJjQUKIJ/llmWNCQttnm3PQp+d2A00oUiLmRcgafCmexZOZy16oG6DX45H5QQhWVuKwI
	UzJ8nTfV0R/Fw4l9M61iSr8tLGi9ELQ/20YW6lMldEI1EB2P/ELSQnYOiPDjPvgf6lXcTbHiG9y
	evd6D0UAcfiYy1/+o8i7uLiR6PGy4Ow81d3Pk5ydGo677OUyOzQ/FBUXvKWwP/c4dn7dUIx92Pu
	8edkKFqsW+3oCdjYEEQRHMoDeB1k6WQWbUdz5gBopqesCk/RhI3p3UF0Ki04Gy8jX8tJUVZzLx9
	dFJpgB8ngoWw6WOIMwU7ofW6I
X-Received: by 2002:a05:622a:1e93:b0:51c:c7:80a9 with SMTP id d75a77b69052e-5213e67fccbmr148137461cf.72.1784574221161;
        Mon, 20 Jul 2026 12:03:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1e93:b0:51c:c7:80a9 with SMTP id d75a77b69052e-5213e67fccbmr148135381cf.72.1784574220301;
        Mon, 20 Jul 2026 12:03:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954aa1a231sm181509845e9.1.2026.07.20.12.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:03:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 21:03:28 +0200
Subject: [PATCH v3 2/3] interconnect: qcom: Add missing depends to Hawi,
 Maili, Nord and Shikra
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-interconnect-qcom-clean-arm64-v3-2-942e8ee7ebda@oss.qualcomm.com>
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JR4Ua1kfTiV8QNLHWvAaewWDC4h+Q/DLdnHAzgTqOfo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqXnEEgrUOpRMy9halmAy6cWzO5c61ytP877DCz
 dFFWF6H9S+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCal5xBAAKCRDBN2bmhouD
 16vbD/oDIiFjy/YVbi5bMN/w9FKQXVNTxdv7WkDt0g6ecjSOdiVJB1Q/u/hb80Y/+st/ZN94tht
 yu/YpdtDOG4+mp98S2EEgwW2RoXI89aPbQ15TywWiM391daJ8s+eFzdpU8VlOuhTOGkSLld5wtR
 uoDYCtD3ltFMZQdd6QjqkOMDCUslEm85Ld7mdRgyazzw8HF6SXDNFtm1qtYoJaFTEm/ZzWowk+a
 xP2cFso6cQDU7meApg2OG6DHbVgkIRblJiSsbbZX6ISBZgUOZmC8/PxWtjoSRsrnx9hBUMt3SSK
 hkM7+rCitFrS1MPL0FWOZXsZELw6yR0O3+UpeXP/tBYjtSjwhAlkfxYmbmxp3oazpo/iyq0gQAz
 tdfdeTaV8IwoMNenpNfUdxZb4Bo1mY5ew+fFwcWRgSQjbRRUYjJGaA4FWNryXJVuKJN6nOYRGfu
 1Z9Abj+BGE1+IhWj0D6NfJMRIaQV8aEKhDLjNy8xYcthJQqOH42mvUvOESsY8gM3MD7VVJvUsjO
 V6NeJfyEvcwzLL3nLUEhtgOSBPWnOnIrNj1K6pe8TS5O4A7kCk4zS3xea11QlIl9lfnxVC+1yP2
 YlAkK28cDTmhBamhny00xbykKyZ+kzGIces+YyZ1oA1TwcQUotmMYNiaUbpQEzj8qQcWGuCnIVs
 hnr/c755Q/Y8oWQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e710e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=H0ku5XqlSbOf5Hpt4WgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfX7Mr5WeQYF9b+
 KPTN+zEBtgrEspJsSwPQ3/u7USrwN+tmm/P/bWNkJxUkK8+0qrTExz5rzJXIhdnxzI9slD4pz4W
 zab2STclTFcmBcFSP0PmT/rF7Co/ePg=
X-Proofpoint-GUID: Igdf0DJdt2yziSyXiwt-G1qUl_5oMxwz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOCBTYWx0ZWRfXyN2c4IvBLbvt
 fbg6kt7OPdayOlMp8fpGSYiKNO54H4Gbe3M5frKn0I6T1HRuIPmiLh+y8w+VkOgSJSEh+7ZFmnI
 EOVvlEIFI3fVC4WIa93dsnxX18aW6DqmVKdMJB/673LagI2IYEQK1bJyPXUacxYP5/qiKw8TYIS
 uqezIJkAdtQkWCWXB2we5TINS5HajerKWCg06bq/LEnpTIyyJcuhkJFbdZAQf/kOZmN7b/pklLR
 dIOOYgp105HOKI4LmBEhYLqJ0ijNc7HUPiLHG9uO6PFb0I6Y7JNDp0muaFLvQQGxQtCD48wVwQr
 fYiTVfPGZUeXPvvMlx74dW20zvj44+bhBdde5pUd9JPpCsyaAfCO9vUcul8+JdkqskbhW6QdNzn
 b4BwCut7W2e+5w31W0b1speqZHuL3na+zwrBBR4/NAFZoqcndxxvA/loe/IEkNXpy3wQybiXG8O
 y6JM7odGMwGd76qieqw==
X-Proofpoint-ORIG-GUID: Igdf0DJdt2yziSyXiwt-G1qUl_5oMxwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200208

Hawi, Maili, Nord and Shikra were added in parallel or after
commit 5b696f065843 ("interconnect: qcom: Restrict drivers per
ARM/ARM64"), thus they missed the update restricting them per
architecture (with the same rationale).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index dd8774d84321..6bc2038de28a 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -34,6 +34,7 @@ config INTERCONNECT_QCOM_GLYMUR
 config INTERCONNECT_QCOM_HAWI
 	tristate "Qualcomm HAWI interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	default ARCH_QCOM
@@ -55,6 +56,7 @@ config INTERCONNECT_QCOM_KAANAPALI
 config INTERCONNECT_QCOM_MAILI
 	tristate "Qualcomm MAILI interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	default ARCH_QCOM
@@ -146,6 +148,7 @@ config INTERCONNECT_QCOM_MSM8996
 config INTERCONNECT_QCOM_NORD
 	tristate "Qualcomm Nord interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	default ARCH_QCOM
@@ -370,6 +373,7 @@ config INTERCONNECT_QCOM_SHIKRA
 	tristate "Qualcomm SHIKRA interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	default ARCH_QCOM
 	select INTERCONNECT_QCOM_SMD_RPM
 	help

-- 
2.53.0

