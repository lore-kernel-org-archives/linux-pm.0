Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92F3806C9
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776334; cv=none; b=dXqF8Tunt1n6tyq6/rAh4MWGd1fQg7tnPvn22MjT7/vr7Mu+fXx7+Ia/H+rx1hoj+pFqVWdSx+ed/x7QBnk4OrSIRA38oIKIASw9OKfZLDC3+S2CuCtM1amuRA74ZbEfeDQvUeiBuWYDKwf9RWkdlpPpdpfNMV2KBTTShwOt50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776334; c=relaxed/simple;
	bh=EkLipRueXJUHKJXq0g3EN4lVQPNdcpx4M11gIrvYJDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTootU2TiMtUBTViaIFIvZ89/ef+owLDMLc2RSqrWK7ALUdWorAXutEmJFLUJ+6j2kEog13RGdBWjgXQ2+pVpyv9/SjsAtL9+dG89VcsL8PvSKCLkeIFiJWeGrJPzjxhFlgTZmb2GumG7twjebQ2mSc4Hl9mE3hGEu1PNoLvyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h77dVIVY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pm6rRv8k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h77dVIVY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pm6rRv8k"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BAmQ6e3720594
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i8D6kVHaQNnTyo5CXqpqHFG5LAhJZ68bONVDPWniBt0=; b=h77dVIVYK5i8kVCu
	NFPnEnY1lStwk9iKe69ow/P74DeK+fUnoAc59Moqcg7vrSzTmcs62ZB1Wu4VnbTu
	JIAlQwjjpRw8+AdRaRwv+7y+cgyGlC16UFaQ+1C/wEcCw3F7MPxKgXx601+gCLmE
	pUo9vBhviFPnoAOCsQSur0wZPkqXjHOfmLnfLRhkj7T6khINuvYhd6JTZifzwoJ/
	42ta/XR1Mh1zJIYXK3OTfwr5mtgEqx13m95XDv/ESj3tRzL+mp30q8+aVIp2ltM9
	04D/VdcLXuRzVzKgKq2xSGq4GNSsQ6AEefzFQHENBJ6cGRvuTxgkFx2GGcZXuOF9
	A+zT8w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeaf8uqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8b0a08d2so17246661cf.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783776331; x=1784381131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8D6kVHaQNnTyo5CXqpqHFG5LAhJZ68bONVDPWniBt0=;
        b=Pm6rRv8kXmwyF9UM0djzOPmS57tb84HYID8d5euVr3hip/HhiX0R6Qxf0sPdAre0Pa
         HfO28/5GXF53AF7zmUNjDTEkoYoBPWy0E+ju4C+9GBHVU7jz74MVHfQz+M68pstK5bkv
         f6ssiTz9lRixJJqbimQSzovQ8rDCJElj519AoSSCPSwPQUxWzBOg05HVqSWvsiY5+U5Y
         nOdVPexisDr3SBCyjcshzjXUR9P0N0F3qQzF/DOyCjef+6IepzgLR4Erc+EYUlNcNLY1
         MeVdCYufNcrJ7KHS9M7R1DC+UM1+dRnsCxuxS6DeHfgQ744gD/IKzBgw6c02VB4VE/U3
         73oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776331; x=1784381131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8D6kVHaQNnTyo5CXqpqHFG5LAhJZ68bONVDPWniBt0=;
        b=mfVVzzYneoR2b8PfgjxQ+RrYfSYqEVBFbIL0ZPCuyKyu+jhAc3Zp3MQq/U5LChBT8w
         hzt+2OinwIMa+/T0tOIzFcSRIUCu9oKtA/9FlMfdDaydQpN33aj3vRtb7OvO0xefvy3D
         1DQIshynOkVq/lgwNOKvw1vJmOfg8ok0wdRfyJDPBkMehyu9cY/RUXxJ5kLMqNwlMqDR
         uig2KMqRthEZLIIiBFncvw1fRUrarzSMOyM5ZxiuTKQRWsHJAfjL/AuZTwnpojkRd2K4
         up+lvb+o7UATtVzShMKBL1cVVoi4+3y7G3isaVA4s6g1QGNgi8IYJ/zdeJTVtSd79sqA
         +lFg==
X-Forwarded-Encrypted: i=1; AHgh+Rq34KGKjr1uwVkZA7MU9ZUSbmgQO1W3TWlqF8auKthlgmiaW73jlcZMCN8dhUftm+GheLKp5za6Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqFOVJlqYud2/5knb5TEVGmgYCZnd2MRpxFjCIw6ymTFq06Us
	ydXBKAyDJGtYobbx/0Z+WhXUGgHNOtqoypBK7Auyd0moxmb8PZr2miiSDetH/6J42yvxsDLttI6
	qMxQi6GAl9cTJzAMDLrkVItd/ZYfkgn9PFAoBu9+QQ1ipx0v/8bB8FOcN1X82UqLga6SJQA==
X-Gm-Gg: AfdE7clfWGzueoBF86uRlcZWw2W2Q2s7TtN3PsFbKgFzJbUvdaLvFBnTwgw7eM5scsq
	OWDNp5RVHp0q0dzNban7kJm02/3DQo5Blu9ltf7US43IaV51fIYyP1Bh4I+2CvYrThYgcASkMhQ
	JtevDxejSbUOe+u20OyFzXcSB3qRMRpv+1aCQP9uiQBJGtfzJ3AAlVv9c2asSWHyeGUDei/T9a5
	Rz7UhVDsreG9t3Xsn4SJG6zX6MrUhpVTvLrmL8KrEnkbePujlh2bADnnA9vt6uv+6MkjKyXGPU7
	Dqr2AMSqy7OqpReuVnyQcveDgi72mb5wos5RDiW+HH6oXK3eHUNg7XPEQItNe+6Me4hLhyN38aG
	iMK8TOyBBuIfMDxg6CufLBKlV+qv2nQMh2B4=
X-Received: by 2002:a05:622a:994:b0:51c:7b13:6300 with SMTP id d75a77b69052e-51cbf3800aemr27714061cf.86.1783776330817;
        Sat, 11 Jul 2026 06:25:30 -0700 (PDT)
X-Received: by 2002:a05:622a:994:b0:51c:7b13:6300 with SMTP id d75a77b69052e-51cbf3800aemr27713861cf.86.1783776330396;
        Sat, 11 Jul 2026 06:25:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm67915265f8f.14.2026.07.11.06.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:25:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 15:25:02 +0200
Subject: [PATCH v2 2/5] soc: qcom: Restrict drivers per ARM/ARM64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-qcom-soc-kconfig-v2-2-4a907e064281@oss.qualcomm.com>
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
In-Reply-To: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=EkLipRueXJUHKJXq0g3EN4lVQPNdcpx4M11gIrvYJDo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqUkQzPZzW2S9+7bCciPPKrpO20kz0faDdIIWbX
 nGnmpQA21mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCalJEMwAKCRDBN2bmhouD
 13WXEACOQxO5M5Jg10KOjiNPgbJKw9bq31KJNzteK53hRWH7+ZWXSthj/cIjGtJ4XLnGPPLga12
 QSMju5Zi3sraB1cbzNHmaWtEpi438DPG9aqRgxYi0RvHDu5rn11R621ijeO7XNf3YCvF8BttCda
 K30I7C2JSOWM+i4azyz7BwLa2BmebwLIpNHE6T492z6soaUheNbJ6XY8bYmikXtq+KBkAyWKyww
 d+WPk9nmu6Efr3Lmnjnoaajp97zZH+Wm/qNS5ZseH4bv3BVHeYgvcUrNOfiR7Zirnvh1StEz6Zb
 N/8z7iX1NqtsOizBrlbJ5QCCX6yLN4OZ7ly8FMKEXvshtMJijaFkRY/ZdxNlLFS2au0yw55giCl
 s+eOxdgdRVRTpYw49IkiNOn8S1An9wDP0t3542peahmUDeGQHMrOWFjueMw0jMV5pYlWCTTClxk
 pU/4yOu1OeqTTdrXTrA6CBR4bbTAyBGL6beT4BYBeemF3aeJOUxhs8qxScaKMT+XDzv4NEf8cXW
 inyrFEw1ES3r3zil0O3PHlGFQ6xUh/Axuwli1vAOEMenQwvYg/o0RjeJgFEKvUthCEexDylC8rc
 T6dozFFN7d3vWiDHg7L9/P6e6dzMHqIObNhO5w6VPNkfFMPa3Muh3xIMh3jjNYKShFk92Gc9ku6
 gcM9mA+NuIiZAxQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: vgWe4CCi2Z1rxEPVbmEhjUuxnMaCOOhy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfX3GkxEJbbKPrV
 BuSclDv2TIMWzg7yltG7lRt7Sp8AypWIFYXfgjloTNXBoEf/Sg+5hPjZyTw65C83EQFL9V/QOB3
 ETNctBQhlAkjJzWf9Ryk68vBFGCfMtpDYAeXUgEsuZ1Ln1/JzVxFIKKIqt9UVfLnLUp9tTJvsok
 r6XjxRlpSgiaPMkdrAY40w3Ni83b2i00xWgdfLaNMiZr6zaU93B2imenQA5+K8l/6xr41CSs+Xs
 7L0o285GmSEO3wbJQhNkGOY5e99KfRciVDcfVpMXoeJ8o65PgMn4KyrWQaf/YC9F7KZiX8+ZZJB
 W2/JRztqidfwUW/pbpGNP2mtPZ+AZ9tSr6IUv1ozc74SjJVxJ2xySBl2M9LGj2t2EntwZVYDc5V
 EP7fUHL1W/JLCYlps9+mFBBrpRsZOGyoYVhZaGYGahLONsVVN9WyLvEe1Awboo623UMF8DoitRA
 5NMndhEKrrQXwNAp6bQ==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a52444b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_aRwxzdhAbM48nF2t_MA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: vgWe4CCi2Z1rxEPVbmEhjUuxnMaCOOhy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfXyMparmWXoIg0
 5T0p7TTdopmL7uRwu5jcC+ZDWqIlwo38dd5kiauAOU8Kgs3BmYpw0z8cf+XNV8fF33sQPVgK4pH
 G9532aTXK1ay24klJrN1ihk1VicSQL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110132

There is no point to allow selecting core SoC drivers for Qualcomm ARMv7
SoCs when building ARM64 kernel, and vice versa.

This makes kernel configuration more difficult as many do not remember
the Qualcomm SoCs model names/numbers and their properties like
architecture.  No features should be lost because:
1. There won't be a single image for ARMv7 and ARMv8/9 SoCs.
2. Newer ARMv8/9 SoCs won't be running in arm32 emulation mode.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Do not restrict per arm64: QCOM_PBS, QCOM_APR, QCOM_LLCC and QCOM_AOSS_QMP
---
 drivers/soc/qcom/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index f3d9c9d776e5..7207814cac85 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -37,6 +37,7 @@ config QCOM_COMMAND_DB
 
 config QCOM_GENI_SE
 	tristate "Qualcomm GENI Serial Engine Driver"
+	depends on ARM64 || COMPILE_TEST
 	help
 	  This driver is used to manage Generic Interface (GENI) firmware based
 	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
@@ -45,6 +46,7 @@ config QCOM_GENI_SE
 
 config QCOM_GSBI
 	tristate "Qualcomm General Serial Bus Interface"
+	depends on ARM || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  Say y here to enable GSBI support.  The GSBI provides control
@@ -104,6 +106,7 @@ config QCOM_PMIC_GLINK
 	depends on DRM
 	depends on NET
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
 	select AUXILIARY_BUS
 	select QCOM_PDR_HELPERS
 	select DRM_AUX_HPD_BRIDGE
@@ -247,6 +250,7 @@ config QCOM_APR
 
 config QCOM_ICC_BWMON
 	tristate "Qualcomm Interconnect Bandwidth Monitor driver"
+	depends on ARM64 || COMPILE_TEST
 	select PM_OPP
 	select REGMAP_MMIO
 	help

-- 
2.53.0

