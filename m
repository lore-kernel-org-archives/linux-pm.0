Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142647DF93
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847100; cv=none; b=KSxaWXNhhSyxitsHO0a04jhdNPDZHhCWrS8q/HEhhcCNZbm5AlMkGZ8qk7R2I3GyHsJ/c421X+Jh2Pxnk2fAP3csh7jN5YHj1usxrSRXNTo0bKJtT/QNu0eHXFhUqiVj/3y7OwjVYhp1zFYgOKt8ZI4dzFHZwpNb4Pt+XqC2ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847100; c=relaxed/simple;
	bh=gdrFliH4JwIF1pRuxXj/l2fpx4b/l4K4qaME/RKYJRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyYXcm2nxoWWdaJ2Gmv6Oacbmd/foVgM5m++QFTRpMzN6MB0FE0ABAaGQeQKsTqehUvzLCKBNYx6nqmK9D41ubM7Rv8/2TAyD0WJWLkstVhuzNbQ5IIUH1aPKPlul0Wvv/HbFqIWRUVri2+et/ZPIU/uuFklL2wHJTC0aXIF3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTwNQOrH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z3tWFe+G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTwNQOrH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z3tWFe+G"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBGKIr3512832
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oCOsasDawVrQWTPiXvcD18NlLj9WtkVfANzKNJcSpDo=; b=VTwNQOrH4Kk3NVgs
	0d2RqxG3C/G6x9OVPpT3fxbDJDlWAPeYtzXCGDKVXoUjnJpj0qDf/4Z3hb3vOa3G
	+vMSpCCkYrfvfUy5m+nGVKyAO1uI7jVeUH7KrynWqMCuiOhvF0tmbCCkZy4GIliv
	a/LrXMXb3TvH3erKClXHf99eLgVAkmE0V6a56PJjHodbcitcVVkFy8oC4lOlSIlo
	fvSOcCGJ7IXquRW5mkZCyglQQGjR7p+nnMwMAAdVNXuaEdPHhKN0+6vUqZiTPRPi
	gD00rf1kxyg16AWfiBH+cNtDtKOddEj665e4I1QtdAcalC2dMlNz6bhdEYDfhcvM
	WZLbyg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vb60t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6313c9d983fso220007137.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778847095; x=1779451895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCOsasDawVrQWTPiXvcD18NlLj9WtkVfANzKNJcSpDo=;
        b=Z3tWFe+GybAFKVUGHW7rPi2XJBCRe3tUVoWTKPaPpOsy6VUiqUE9ex3AwahCWHddDx
         Q9RKGqsABrtU24OM3fV1ABFyTErYZFCRofmT8zGZS5wixEuSNGRFyBNZjlcqSJ4gNKJQ
         ou6sv7ULxFxl63WuZAf+uaag9pJsbx3xnzorCuYD7yICxbHxT9SDQqRwPdW0xoBdNQHO
         0fEM1YALuO7vM78jD7eLxFkWZ3zk197V/083TvXyna6FIZCR39/M07LlLuWJelJJodVo
         F8uVNJdayHz7uC0IhcGVgrLw3IRGwPCN3NJgwb+OB2gb1DMPGpYpNjzUviyMJTW0BGu0
         DLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847095; x=1779451895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oCOsasDawVrQWTPiXvcD18NlLj9WtkVfANzKNJcSpDo=;
        b=MdnBJq3osanbvv//B9DPE2lawu/bfKtyR3aRGoDIXFxhWQSqL4szJyNRFKXQQh2gKl
         fA7TRV9i/zqNaH5YBBry5AbarIu4c7JRHaisCx/eLAKGfejdooni+hqZ6Chp/IhVS1Lw
         EQrWpEEyymBWkucVuiItRawiGL3dEW15dYD8QYugqg8pIKEVHm5yZjixGEJ6n19CR4sz
         SsLo2K+tWcY9Cstp12/CvoFMkKbUf+0DMisnIIxCuHAXGrinkYhL6wkclBgLAIJFQJBh
         BHBQ+o9EPWERiHEs9vWqP9gqmcgd+YWPm0+/J0n9uCIoqGe5VAgVSMGqtr+cQ7q6XJI4
         lHvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ve/SiVk9Qcra0QsaVnqfj48VKLfoGFGR+FfTt9rcSwau+gatcmK7rtMRNe51ZyyWN7c2EquLRzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4yY980Z1/UmrfZIlB1gvMPGxgp4L6LYz+QA9wB3d+XQIh49W
	aWv/aTtuaEwpGlvKbLN3QlvbkptfyHkzqxEUg0sdb0lpWbE1f6xp4g9jsSZ9e4f1j6Sgx4nX4a4
	EUkDe5+viYFksJxlC6wUm92sblawFEn+Itvl5C4hpwDqOef1cSeoM5kjwOdNUuw==
X-Gm-Gg: Acq92OHhFMqrYIwJRMD7m6EtUUVPhoa5YeWf+zN9W59UJVI/C4RtMmFgSdwchlmKaZD
	0pR8199+CTJkRJBTdmUAgRRmHgysqoUpyHVHstw431MXEdF/NPCi4xlzvN65Ca+6VSmXQycc5+i
	N1Pyr2yqir1IPJa9QFXAgMd1ElY0NQ0qpmN/psOQAboZREn8no7LGxQeOKZOiFfCwJ7o11xugZU
	TqlOK/q0/1/a0VgWWce0qyqIZXLHKxmgotuefl66HVWGnEqgvXWGQC/yQtfALFdvVqcQo8yFg8C
	6mZfz05O/x3EKPC/tD8f5kyvkYIj/a+RLMP4v/b/i+rPgTHUgj/2I3sbeTXgC8oo6zDmm4A14j7
	awTztyojhI5Frvu5v41CUudIbRLMhUIJoLGKvvB5inM6g
X-Received: by 2002:a05:6102:2921:b0:632:4af0:4133 with SMTP id ada2fe7eead31-63a3f391c51mr1405373137.18.1778847093359;
        Fri, 15 May 2026 05:11:33 -0700 (PDT)
X-Received: by 2002:a05:6102:2921:b0:632:4af0:4133 with SMTP id ada2fe7eead31-63a3f391c51mr1404828137.18.1778847087687;
        Fri, 15 May 2026 05:11:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm66855685e9.7.2026.05.15.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:11:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:11:08 +0200
Subject: [PATCH v2 3/3] interconnect: qcom: Make important drivers default
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-interconnect-qcom-clean-arm64-v2-3-adeebc73596d@oss.qualcomm.com>
References: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
In-Reply-To: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15234;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gdrFliH4JwIF1pRuxXj/l2fpx4b/l4K4qaME/RKYJRo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqBw1oSXOkSwek4fb7EvXHEX+nW7kvbBLQg9+nr
 a7AjGYiDRWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagcNaAAKCRDBN2bmhouD
 17V3D/4oE4jPewYRq1H0L4yL6Vsaqf+0LhQnAuoTwtkIt2KlvhZd04wVzKvst8RexjXCcH01efn
 uFEdJ0ETly3GsDt0QPK5DTyB6DtoHJDS8Q1ZRO2D5QP9Mi91rEuBs71823B9eR1nBc/gLJFTnfI
 iX71DE7d1gYx9N4z5Yc4tKJ1D5tuiKeIEh37Wi7qOGGz/3xxibP44KSpP5jBEgfDacTbVXbMRVb
 B9LF/kVYxPpL/Qah916WXmyTfBU4Qx+iW02fxBeMCM3W8B/iWeHct3x9bFsEZ8ZzHr0Wqzu28GF
 05wUBywdxht6gpzfyc0Rxlif4DGIS6o2BmOLdFk8v93I527ePIrO4i/9QVz86500yPrvmeIPmdT
 IABn0cKVdfVH1p9C4wNjxy005Tt1bOU86Z4vS7YCHi95qsrLuLMQDAok8kVovScjZbO65PQkDML
 XJ3tDs/liMPK63Llehyj1ZJ03C/Lxv3/keR40cgDbWkIKNoNSe/Zyej0PlUl9w9u37C9oad9sBI
 PpjyKruN8xjwbRoG0MN2y7HoyEza6i7Zm4YuUEDj2rdeRlBkrCyse//8lj4u67ZgubDeH9sJehw
 oYK01tCBCcb9daEsjvRKrm7kuZkPiK9kFDpl29azOGMXsoJG8ymQw7el9/1jQ0Pib5Nvlq29sOu
 UZ/h0sDMhAQCyyg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyMyBTYWx0ZWRfXxD6MM8GDrBNh
 FoCu+1fwnvuf25a6PKXuqkCz5PPNOcYmzodXFYFVjir1La+/+Ni2BIbuJvOAS6JU+RDy3bDQyDG
 XkZYDT3casEJ/hyvViTV5Z4f6zeFGn1IJW9YuYEMjX2Ew/Q1Scp6xnnNa1qraQ8WJOHhQF39v10
 x6lUR5cVfXCWokdJZ+X6agQ6M+Z9K9xmdsSId116aJYtBXs5leWvlfE708miyd/0zFTBw6VPe6f
 +JQGzOkkLbEc45N1SVBWlazRHix/u8amzoNao/A+n4QkKfuIyUzy40SXQjZA2dRqIjRAW7NFW3G
 IBfCo9AcVp90EpPTlHlMTClAVxA5NP3bcA6yHdgjn8yx8OBKT1+YPB1JtUQvnmd7wvg4EA0Tsi+
 3agpd9+rZ/yxZelpQUjbLk+8Fl1uRfr0MKqB+rcvWcuWXq6E/pzpCAC/m3lbsUe1eV54r+WGzNJ
 4KBrbY34YLdIdR/ji+Q==
X-Proofpoint-GUID: yoE-OBFPHYdhAVG945-XD45E7YLFvL1d
X-Proofpoint-ORIG-GUID: yoE-OBFPHYdhAVG945-XD45E7YLFvL1d
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a070d77 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=O8YRFC0p4ozDlASnGw0A:9 a=-wcPzy_K7TQbbHLX:21
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150123

The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
basic or fundamental SoC feature: bandwidth management between internal
SoC blocks.  SoC can boot without these, but power management or
performance will be affected.  These drivers do not represent any sort
of buses visible to the board designers/configurators, thus they should
be always enabled, regardless how SoC is used in the final board.

Kernel configuration should not ask users choice of drivers when that
choice is obvious and known to the developers that answer should be
'yes' or 'module'.

Switch all almost Qualcomm interconnect drivers to a default 'yes' for
ARCH_QCOM.  This has impact:

1. arm64 defconfig:
   a. Enable as built-in INTERCONNECT_QCOM_SDM660,
      INTERCONNECT_QCOM_SDM670, INTERCONNECT_QCOM_SM7150 and
      INTERCONNECT_QCOM_SAR2130P, which were not selected before but
      should be, because these platforms need them anyway for proper
      functioning.

   b. Switch to built-in from a module INTERCONNECT_QCOM_QCS404 and
      INTERCONNECT_QCOM_MSM8916, which as modules would not make the
      platform bootable in most cases, and INTERCONNECT_QCOM_OSM_L3,
      which when module might slow down boot considerably by having
      caches running at slow speed.

2. arm qcom_defconfig: Switch to built-in from a module
   INTERCONNECT_QCOM_RPMH, INTERCONNECT_QCOM_SMD_RPM,
   INTERCONNECT_QCOM_BCM_VOTER, INTERCONNECT_QCOM_MSM8974,
   INTERCONNECT_QCOM_SDX55, which as modules would not make the
   platform bootable in most cases.

3. arm multi_v7 defconfig: Enable drivers necessary to boot
   ARM 32-bit platforms, which are already enabled on qcom_defconfig:

   a. Enable as built-in INTERCONNECT_QCOM_MSM8974.
   b. Enable as modules (other dependencies prevent from built-in)
      INTERCONNECT_QCOM_RPMH, INTERCONNECT_QCOM_BCM_VOTER and
      INTERCONNECT_QCOM_SDX55.

4. COMPILE_TEST builds: Enable by default all drivers for arm or arm64
   builds, whenever ARCH_QCOM is selected.  This has impact on build
   time and feels logical, because if one selects ARCH_QCOM then
   probably by default wants to build test it entirely.  Kernels with
   COMPILE_TEST are not supposed to be used for booting.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

I propose the change to go via interconnect tree.  It might conflict
around defconfigs, though.
---
 arch/arm/configs/qcom_defconfig   |  3 ---
 arch/arm64/configs/defconfig      | 31 -------------------------------
 drivers/interconnect/qcom/Kconfig | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 03309b89ea4c..451f2c4cec55 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -271,9 +271,6 @@ CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
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
index e5f1901ee408..4909a8824ec8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1848,37 +1848,6 @@ CONFIG_INTERCONNECT_IMX8MM=m
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
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index b2c4272ae48f..dd3ef920a16a 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -2,6 +2,7 @@
 config INTERCONNECT_QCOM
 	tristate "Qualcomm Network-on-Chip interconnect drivers"
 	depends on ARCH_QCOM
+	default ARCH_QCOM
 	help
 	  Support for Qualcomm's Network-on-Chip interconnect hardware.
 
@@ -14,6 +15,7 @@ config INTERCONNECT_QCOM_ELIZA
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on Eliza-based
 	  platforms.
@@ -24,6 +26,7 @@ config INTERCONNECT_QCOM_GLYMUR
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on glymur-based
 	  platforms.
@@ -34,6 +37,7 @@ config INTERCONNECT_QCOM_KAANAPALI
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on kaanapali-based
 	  platforms.
@@ -53,6 +57,7 @@ config INTERCONNECT_QCOM_MSM8916
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM if ARM64
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8916-based
 	  platforms.
@@ -81,6 +86,7 @@ config INTERCONNECT_QCOM_MSM8953
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8953-based
 	  platforms.
@@ -91,6 +97,7 @@ config INTERCONNECT_QCOM_MSM8974
 	depends on QCOM_SMD_RPM
 	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
 	 platforms.
@@ -111,6 +118,7 @@ config INTERCONNECT_QCOM_MSM8996
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
 	  platforms.
@@ -119,6 +127,7 @@ config INTERCONNECT_QCOM_OSM_L3
 	tristate "Qualcomm OSM L3 interconnect driver"
 	depends on INTERCONNECT_QCOM || COMPILE_TEST
 	depends on ARM64 || COMPILE_TEST
+	default ARCH_QCOM
 	help
 	  Say y here to support the Operating State Manager (OSM) interconnect
 	  driver which controls the scaling of L3 caches on Qualcomm SoCs.
@@ -129,6 +138,7 @@ config INTERCONNECT_QCOM_QCM2290
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcm2290-based
 	  platforms.
@@ -139,6 +149,7 @@ config INTERCONNECT_QCOM_QCS404
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
 	  platforms.
@@ -149,6 +160,7 @@ config INTERCONNECT_QCOM_QCS615
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs615-based
 	  platforms.
@@ -159,6 +171,7 @@ config INTERCONNECT_QCOM_QCS8300
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Technologies, Inc. Network-on-Chip
 	  on QCS8300-based platforms. The interconnect provider collects and
@@ -171,6 +184,7 @@ config INTERCONNECT_QCOM_QDU1000
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on QDU1000-based
 	  and QRU1000-based platforms.
@@ -195,6 +209,7 @@ config INTERCONNECT_QCOM_SA8775P
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sa8775p-based
 	  platforms.
@@ -205,6 +220,7 @@ config INTERCONNECT_QCOM_SAR2130P
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SAR2130P-based
 	  platforms.
@@ -215,6 +231,7 @@ config INTERCONNECT_QCOM_SC7180
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sc7180-based
 	  platforms.
@@ -225,6 +242,7 @@ config INTERCONNECT_QCOM_SC7280
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sc7280-based
 	  platforms.
@@ -235,6 +253,7 @@ config INTERCONNECT_QCOM_SC8180X
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sc8180x-based
 	  platforms.
@@ -245,6 +264,7 @@ config INTERCONNECT_QCOM_SC8280XP
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SC8280XP-based
 	  platforms.
@@ -255,6 +275,7 @@ config INTERCONNECT_QCOM_SDM660
 	depends on ARM64 || COMPILE_TEST
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm660-based
 	  platforms.
@@ -265,6 +286,7 @@ config INTERCONNECT_QCOM_SDM670
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm670-based
 	  platforms.
@@ -275,6 +297,7 @@ config INTERCONNECT_QCOM_SDM845
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
 	  platforms.
@@ -285,6 +308,7 @@ config INTERCONNECT_QCOM_SDX55
 	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx55-based
 	  platforms.
@@ -305,6 +329,7 @@ config INTERCONNECT_QCOM_SDX75
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sdx75-based
 	  platforms.
@@ -315,6 +340,7 @@ config INTERCONNECT_QCOM_SM6115
 	depends on QCOM_SMD_RPM
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm6115-based
 	  platforms.
@@ -325,6 +351,7 @@ config INTERCONNECT_QCOM_SM6350
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm6350-based
 	  platforms.
@@ -335,6 +362,7 @@ config INTERCONNECT_QCOM_SM7150
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm7150-based
 	  platforms.
@@ -345,6 +373,7 @@ config INTERCONNECT_QCOM_MILOS
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on Milos-based
 	  platforms.
@@ -355,6 +384,7 @@ config INTERCONNECT_QCOM_SM8150
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm8150-based
 	  platforms.
@@ -365,6 +395,7 @@ config INTERCONNECT_QCOM_SM8250
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
 	  platforms.
@@ -375,6 +406,7 @@ config INTERCONNECT_QCOM_SM8350
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8350-based
 	  platforms.
@@ -385,6 +417,7 @@ config INTERCONNECT_QCOM_SM8450
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8450-based
 	  platforms.
@@ -395,6 +428,7 @@ config INTERCONNECT_QCOM_SM8550
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8550-based
 	  platforms.
@@ -405,6 +439,7 @@ config INTERCONNECT_QCOM_SM8650
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8650-based
 	  platforms.
@@ -415,6 +450,7 @@ config INTERCONNECT_QCOM_SM8750
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on SM8750-based
 	  platforms.
@@ -425,6 +461,7 @@ config INTERCONNECT_QCOM_X1E80100
 	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
+	default ARCH_QCOM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on X1E80100-based
 	  platforms.

-- 
2.51.0

