Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBB3C2B95
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776342; cv=none; b=DH7vkdSTrfJNRlwDWWFREgXrsNR/StUALY6hYIm//e2+5sLClM4AJ4WNw+hzLoOVJ0/X2S5XyjD1ptHiSQ8iuyefnNEoDWrG2C23LOhONlNC9LLTaXiQ/m1TfTVQEHGyPxS4VQ6Sca2jZ/yYe+i5g4ZZIlQ5wuTIrCYw+IXjVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776342; c=relaxed/simple;
	bh=a6J73i3BLLiiLJbhVGmtLZBGyyh81AmvWwY+3jK2F30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7gSXs0dxyi/4GMjCAYrwDq6kimAEc+zK7EkG/XL4EC9/APR/yTbtzW2hSkcHXGd0AWMs1adY5dLCRO6ZAgNSql/8N7za3kM3Tj/zn2RveSn5ua5AsrkmgN8B6VIW+i/Y9MStuTAxYPQHgekgOd972PiPKY4FOSuhEjUIKv9vqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RfrFlNFx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IUvIqnEM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RfrFlNFx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IUvIqnEM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BAnKZH3656392
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UY7lvIpIs/FUEPgKc0WnwCVEzxW0RLZHtuHcLxdMFR0=; b=RfrFlNFxGg74hUY8
	0iPemRqnaeIsE0536mdi7KybxHe6DHgHOF25P8GXGExmF5ee6cBP8hboRvb71rqL
	l2HmvQy7Ujd9+wns5Jljikn48kfszEvIkGm6yIQ0zhOAjjxV7yz0uxNQM5Fx9vtf
	rp/H38W5iN+SpA393FYe9I9xQ7/x5/X2A5AdA9m9Y2OrBcs09R7dm6v9IOKBsHms
	vmPbIZobnEiaj2NYO3I+YLBWGaRe5zrZ0nDZB3S1WCQ5n7HBy+d2BpbWxg+o6MS8
	EAyRi84XdVF0zi4RrwLk6hmmt1ZJo8uoSk8dx/tsADj5N1CdYEK0JUumSRc13TaH
	Bc23Vg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr0uh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so20266771cf.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783776336; x=1784381136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UY7lvIpIs/FUEPgKc0WnwCVEzxW0RLZHtuHcLxdMFR0=;
        b=IUvIqnEMbV6WqJiwi2RNs/xkB1zCgafDBmLZ3HWH8OIM1Iajbanxh79LADGlv4KOSz
         6jV25OSvyPfDlLOsApg6the/sKQrAU2H09al2/bts5SZelrot+dkDfNIe1npsZJyubMk
         SEt7OFj8QZyBSTSFbLG7Ct1VqKpM4RrhCcN0yKWCx5M6TyVczB0H6rLuLcL2rS672F5B
         j3ZO78KWHuvNVO6Pkj6EdG/g19IIS0IvkXZMs2W3UBldE7C6LxGU692iBUeHezr2qe7f
         DWs536VOZquzFc5dISjzbtqwKqmi6n6zllg2BRmSm2UnOuTVTjOYsv2BW/clyIb9D1Kk
         GnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776336; x=1784381136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UY7lvIpIs/FUEPgKc0WnwCVEzxW0RLZHtuHcLxdMFR0=;
        b=iRry4icm1if8C2YEIf/xdMP1sSs8SACNmSAs0etKR1yJqjIeAiK6SVWkPVX9MvMyvr
         O5m3kNSENMWSgtq3DM/uI8wYmVbA5yLWqoTz8tR6qDWkUzPs3yOygREuCnOU+hDZn5zU
         oGShMP00CxkzRoi9I4mk8clxut15biDqPPTlgoS2V+rxToMSsHwjji9NFnoxwWqS5XdK
         YUcleXRVP6R3PIBwRi2Wb+n2JmchuQ+ZyNELgiRUh/9Dq0qUwZmWjpKk/A086tl+Iaju
         jvplltq+2gsfWsbJTtfLNL+UfIkeGfpKSO/RjoBefcQK1mWJpbaj4Z6vYwYdQyISw8OZ
         Mrtw==
X-Forwarded-Encrypted: i=1; AHgh+RrYYpP+4TOc6IzgXszhToJxmIZ1mO5vWsYV50Lb6XvkzNlE1idzj4kmcZHng25ogD5hus0NxDou2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7grtrlifoqYzFdAgNGMlheYSkGdJVsVYXfSI4rCh7wPkjH7oL
	n01muB3PK5blYlQ/N9pT4I9tay4i863H5nw7Nm1JK7VU4WDVYy65N5lQRfdvG19gvsL2opg+4DT
	ihF+6fT84W3G2bZuvflA4ELCh70162bqrG5ZckqE6mBmi0otIpybgy0doPagohQ==
X-Gm-Gg: AfdE7ckOtd2C9BtXluO3kcyHqAEKpTP3+1DdUZSHd1MLOfFEPl2AvwnIHEOyOJ/a86P
	Gebnd3uQ0JWtHTuiL6n6/Qx1wT2dfwoSO5zdNR/d18kaWOC8hm4kcASYiR6mq5emRyRzoW0McuR
	bkcpOyD9YlSk3s93yRt6DxaD8Md24GsTGcOS91SLvcxOXz+YJ/M8iIKL5em6dgbdMyJJZ4W4Dr0
	hgTNy0hJGRyTexWkIV6DTazBLjxE91H5DM+AeYToMPK3C+SLfhvLUlic58gRlgNTd0BSGyqcJVT
	SHNMK1SlGXIlqzGnNNXYaWhYbvAAjzwPakroYNeeDnHB0neLyRFX8hUrfrRj6+3imU94kax1WZM
	8HRqghi6qwi8mHYkr4BrOd1IoOJWdAo6nqb4=
X-Received: by 2002:a05:622a:4111:b0:51c:9e6:ec3c with SMTP id d75a77b69052e-51cbf247d79mr27632291cf.58.1783776336415;
        Sat, 11 Jul 2026 06:25:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4111:b0:51c:9e6:ec3c with SMTP id d75a77b69052e-51cbf247d79mr27631991cf.58.1783776335928;
        Sat, 11 Jul 2026 06:25:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm67915265f8f.14.2026.07.11.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:25:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 15:25:03 +0200
Subject: [PATCH v2 3/5] soc: qcom: Make important drivers default
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-qcom-soc-kconfig-v2-3-4a907e064281@oss.qualcomm.com>
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
In-Reply-To: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7794;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=a6J73i3BLLiiLJbhVGmtLZBGyyh81AmvWwY+3jK2F30=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqUkQ0KNvV3x8kKw6SvHXpcMsuQaxyvrM4xOcfh
 9cA34YGUemJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCalJENAAKCRDBN2bmhouD
 1z6CEACJla2JllgOpEkjuazvwEzwokRan7eKp8hhAAOXD2rWz1FxR6a9NyzcanLNm0E7F5rVzwI
 9fteIiyLB8qmnhDIVpQxoEVGJYiTEVdFASBoNEWGogH+SH/F1Nd5JCkXbKk/nGZOhntaz48dSdL
 eYVTMxzuua70YRU8WJvw6chQXqmNtoW6wnNdYQsnqx0tdCESsMNqk/EFf5VCwrNXXVTWcVABHkp
 QGEi5Z35CmBuSjXUuHxDCBPApqgpFp1uDL9WXYih9NQ0KnFxN2Cevfbjs0kL7yVlyxJEMkVvdk6
 uZu3nCPm6GKvzzLiAxaB5LbTBn7G0PfvoXwIiUMeUOv8eK4erQMlMyA1+SNejt1qW+5pJIO3Ln9
 UG/IPaS7SBul2LOqEn2CgzKfRAxLujRJ5MlASZighDUt2XD0rgw3SjHZNSq+Gp86//0Lx5gCy7b
 vcjmOGkKPlaR7d/oOQkjsyc8W1iI4nWFJLjI7lK41EHVK8Jq++TveH6wHMA0tqX8bnn4mXL9fhR
 wsUBSgq6L4UO9hxhZQtOilbc6njk6RHIlRHgFiVQQSy3QjESjyZkONFgoUEnL0Xe9FdoU/rD24M
 0/IjR0Wq5MfTpB/LuoxkMyuQaIitV0CqTMEN6nl5QkNP9VeX8Ablg/q0tfm5nL+N5rMF+0HMm+a
 08Us6TlkmGnChRA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfX0XxFmBwpqbWu
 30RQSOANTMoGDQK2/q3B1yeWg8jJCbTT91Hiw3zTwfMiC61fRl0j/EP5IKAm90dXk7e94K5riWI
 J/1Tndfpm+nH0XnQEG4TX9h8oP7zWEY=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a524451 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=WHtqhdIPiO6dFDzXXL0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: XSD5BIgF1HBwh9gRg-RyEWQq8TJf0Xgj
X-Proofpoint-ORIG-GUID: XSD5BIgF1HBwh9gRg-RyEWQq8TJf0Xgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfXyUE4HlsdA1xM
 I7u0CwVqit3K37lr3i669cq1IwP8tp/QQ8afrCj6fBXUdsS2ZFiYI5HjnovlLf0YdaQvXgI3FOv
 492tyARi496dz6Eu0GP0ZW215HZyt8TgQx+tpBrVip4GR7fwTfCc8jm/jgyj++ERFzr2+ifZ2QE
 /ntCxm35EDdGUxCdAHOJrfM4/4XDEj8V+119m3FmF34JmwGUIT3+AYo8QTQAZ/xzQdi8vi5dN45
 MtQBeZRet1bmmcXPE6N+AAy3LQQ6KQZH1sV0quCDucQA/BzB95k3vhftVCi4HGzr7TBz6plkjon
 E3hgluhsdKkCmEL3SAsCdEP2xDpHe/b1TFdc/OQC4K91qe2Pn7qGbMVJhulmi7d6dmeibWyCuKH
 tjENfeh7iUh82oPreWI4JpkhZNiRUkdtdpW3Xyt+/Y5FvFBIYywdsyMnd9/ynGce1xIKAXl5+lu
 qkmP2yWWqXboqzjELYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110132

The drivers for Qualcomm SoC components are covering a basic or
fundamental SoC blocks.  Usually they are required for booting or to
achieve basic expected functionality when running Linux.  These drivers
do not represent any sort of buses visible to the board
designers/configurators, thus they should be always enabled, regardless
how SoC is used in the final board.

Kernel configuration should not ask users choice of drivers when that
choice is obvious and known to the developers that answer should be
'yes' or 'module'.

Switch most of the Qualcomm SoC drivers to a default 'yes' or
'module' for ARCH_QCOM, to match existing defconfig usage.

This has no impact on arm64 defconfig, arm qcom_defconfig and arm
multi_v7_defconfig.

multi:
+#define CONFIG_QCOM_PDR_HELPERS_MODULE 1
+#define CONFIG_QCOM_PBS_MODULE 1
+#define CONFIG_QCOM_AOSS_QMP 1
+#define CONFIG_QCOM_APR_MODULE 1
+#define CONFIG_QCOM_LLCC_MODULE 1

qcom:
+#define CONFIG_QCOM_PDR_HELPERS_MODULE 1
+#define CONFIG_QCOM_PBS_MODULE 1
+#define CONFIG_QCOM_AOSS_QMP 1
+#define CONFIG_QCOM_APR_MODULE 1
+#define CONFIG_QCOM_SPM 1
+#define CONFIG_QCOM_LLCC_MODULE 1

The change will however enable by default all drivers for arm or arm64
COMPILE_TEST builds, whenever ARCH_QCOM is selected, which feels
logical: if one selects ARCH_QCOM then probably by default wants to
build test it entirely.  Kernels with COMPILE_TEST are not supposed to
be used for booting.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Enable also QCOM_SPM
---
 drivers/soc/qcom/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7207814cac85..4e6eac2769e5 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -20,6 +20,7 @@ config QCOM_AOSS_QMP
 	depends on MAILBOX
 	depends on COMMON_CLK && PM
 	select PM_GENERIC_DOMAINS
+	default ARCH_QCOM
 	help
 	  This driver provides the means of communicating with and controlling
 	  the low-power state for resources related to the remoteproc
@@ -29,6 +30,7 @@ config QCOM_AOSS_QMP
 config QCOM_COMMAND_DB
 	tristate "Qualcomm Command DB"
 	depends on OF_RESERVED_MEM
+	default ARCH_QCOM
 	help
 	  Command DB queries shared memory by key string for shared system
 	  resources. Platform drivers that require to set state of a shared
@@ -38,6 +40,7 @@ config QCOM_COMMAND_DB
 config QCOM_GENI_SE
 	tristate "Qualcomm GENI Serial Engine Driver"
 	depends on ARM64 || COMPILE_TEST
+	default ARCH_QCOM
 	help
 	  This driver is used to manage Generic Interface (GENI) firmware based
 	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
@@ -47,6 +50,7 @@ config QCOM_GENI_SE
 config QCOM_GSBI
 	tristate "Qualcomm General Serial Bus Interface"
 	depends on ARM || COMPILE_TEST
+	default ARCH_QCOM
 	select MFD_SYSCON
 	help
 	  Say y here to enable GSBI support.  The GSBI provides control
@@ -56,6 +60,7 @@ config QCOM_GSBI
 config QCOM_LLCC
 	tristate "Qualcomm LLCC driver"
 	select REGMAP_MMIO
+	default m if ARCH_QCOM
 	help
 	  Qualcomm Technologies, Inc. platform specific
 	  Last Level Cache Controller(LLCC) driver for platforms such as,
@@ -65,6 +70,7 @@ config QCOM_LLCC
 config QCOM_OCMEM
 	tristate "Qualcomm On Chip Memory (OCMEM) driver"
 	select QCOM_SCM
+	default m if ARCH_QCOM
 	help
 	  The On Chip Memory (OCMEM) allocator allows various clients to
 	  allocate memory from OCMEM based on performance, latency and power
@@ -110,6 +116,7 @@ config QCOM_PMIC_GLINK
 	select AUXILIARY_BUS
 	select QCOM_PDR_HELPERS
 	select DRM_AUX_HPD_BRIDGE
+	default m if ARCH_QCOM
 	help
 	  The Qualcomm PMIC GLINK driver provides access, over GLINK, to the
 	  USB and battery firmware running on one of the coprocessors in
@@ -129,6 +136,7 @@ config QCOM_RAMP_CTRL
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
 	select QCOM_SCM
+	default m if ARCH_QCOM
 	help
 	  The Qualcomm remote filesystem memory driver is used for allocating
 	  and exposing regions of shared memory with remote processors for the
@@ -150,6 +158,7 @@ config QCOM_RPM_MASTER_STATS
 config QCOM_RPMH
 	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on (QCOM_COMMAND_DB || !QCOM_COMMAND_DB)
+	default ARCH_QCOM
 	help
 	  Support for communication with the hardened-RPM blocks in
 	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
@@ -160,6 +169,7 @@ config QCOM_RPMH
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on HWSPINLOCK
+	default ARCH_QCOM
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
 	  The driver provides an interface to items in a heap shared among all
@@ -169,6 +179,7 @@ config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on RPMSG
 	depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n
+	default ARCH_QCOM
 	help
 	  If you say yes to this option, support will be included for the
 	  Resource Power Manager system found in the Qualcomm 8974 based
@@ -189,6 +200,7 @@ config QCOM_SMP2P
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
 	select IRQ_DOMAIN
+	default ARCH_QCOM
 	help
 	  Say yes here to support the Qualcomm Shared Memory Point to Point
 	  protocol.
@@ -199,6 +211,7 @@ config QCOM_SMSM
 	depends on QCOM_SMEM
 	select QCOM_SMEM_STATE
 	select IRQ_DOMAIN
+	default ARCH_QCOM
 	help
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
@@ -207,6 +220,7 @@ config QCOM_SOCINFO
 	tristate "Qualcomm socinfo driver"
 	depends on QCOM_SMEM
 	select SOC_BUS
+	default m if ARCH_QCOM
 	help
 	 Say yes here to support the Qualcomm socinfo driver, providing
 	 information about the SoC to user space.
@@ -214,6 +228,7 @@ config QCOM_SOCINFO
 config QCOM_SPM
 	tristate "Qualcomm Subsystem Power Manager (SPM)"
 	select QCOM_SCM
+	default ARCH_QCOM if ARM
 	help
 	  Enable the support for the Qualcomm Subsystem Power Manager, used
 	  to manage cores, L2 low power modes and to configure the internal
@@ -224,6 +239,7 @@ config QCOM_STATS
 	depends on DEBUG_FS || COMPILE_TEST
 	depends on QCOM_SMEM
 	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
+	default m if ARCH_QCOM
 	help
 	  Qualcomm Technologies, Inc. (QTI) Sleep stats driver to read
 	  the shared memory exported by the remote processor related to
@@ -233,6 +249,7 @@ config QCOM_STATS
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
 	depends on RPMSG
+	default m if ARCH_QCOM
 	help
 	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
 	  firmware to a newly booted WCNSS chip.
@@ -242,6 +259,7 @@ config QCOM_APR
 	depends on RPMSG
 	depends on NET
 	select QCOM_PDR_HELPERS
+	default m if ARCH_QCOM
 	help
 	  Enable APR IPC protocol support between
 	  application processor and QDSP6. APR is
@@ -253,6 +271,7 @@ config QCOM_ICC_BWMON
 	depends on ARM64 || COMPILE_TEST
 	select PM_OPP
 	select REGMAP_MMIO
+	default m if ARCH_QCOM
 	help
 	  Sets up driver monitoring bandwidth on various interconnects and
 	  based on that voting for interconnect bandwidth, adjusting their
@@ -266,6 +285,7 @@ config QCOM_ICC_BWMON
 config QCOM_PBS
 	tristate "PBS trigger support for Qualcomm PMICs"
 	depends on SPMI
+	default m if ARCH_QCOM
 	help
 	  This driver supports configuring software programmable boot sequencer (PBS)
 	  trigger event through PBS RAM on Qualcomm Technologies, Inc. PMICs.

-- 
2.53.0

