Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645523BB118
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776345; cv=none; b=E84eOoW37SM9RvQMe/EztuclCP8mu+JpEH7pg95nX+jWQK0K7fkXUa8JP2gZNaQrIxEHSINcsm6+aXOFDXgq2UpE02Z4DbHqL3dF363VKaMDmeoHWhw8bGngr2EwW5ARPSqVXbTEcbYB2oeI4vN/78T9EYda+REv8W5G1N7zccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776345; c=relaxed/simple;
	bh=trZ/E4XO26da/mhSb5ySVVyndUZizSNk3tZ3uomkL08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOSW4+I5X5h1wn65QzMpxlKbeLnO0z1wB5qAwZqFs7TWA4/Uydgo5m35vhz3J/f/ldZLe8gXVrSybG+iREfXL4GXyI7343lmSGRossLkq276SotREsmEmmvGEqDaWynwKscjnVnXa4m6KQcldUbcX6sap0Mmexc4Ty4SWahO4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ka7rUrs6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LhhvKur+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ka7rUrs6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LhhvKur+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BAmW4l3538735
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBDVxtwo5G522sp2YomwpfimJG3Bg2W+ONywALKIPQs=; b=ka7rUrs6/xqjYSFn
	vjEKpAhTmyML7ay+HEAZ6lOYCG0Sp375uzFsqQeqmzdhrL7wbnPf6aQ0amM4l64o
	n8hRCM1PRPv6WCZd7ERUH5BZoVhzxnO9afsZcuMHqRsXR3aD43TOd5rxWKCgH7+Z
	h9SeD/hogE488Dc78wURZ0MddJG72+gt2jxcPpUpYEZhiCRlOl768/QWl1o+3wbC
	gr4RZDVuOBx9iupHjqnk02TUW3pbXPxZcsd3LgtXYyeQQMBb09HvbdhU73sf9QXy
	OaKsnP6J32dAIP6r5W7Moy+01DVz5hUddUcHs/chkOrAUSeaorEhNFhpmzg07+nd
	fmVQNQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcgtye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a236220so19901931cf.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783776343; x=1784381143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBDVxtwo5G522sp2YomwpfimJG3Bg2W+ONywALKIPQs=;
        b=LhhvKur+H8Q561rbXMcLvTe6wJtjjspGB+kxL1Rtec7w0D9O1TvxIbxLoYfdF/EbYS
         b8ELkKLA8TjbHSA9tcvWMy2AnJvkcEm/6XSlyZk3b8emLAswpEyP6M1dh8+RPF0UFYpf
         VWDtgfD9rNZopQz0lR4hXujWNg600bzoAXm0rOFO0/flHhH60TEPDuY+yrL2yb7ahrfN
         ci17YujjpXn0Y3FQoJbHLcsF/gWtKW+7MFK/KItnocZHF4NMGeUV8O8tnHELPRxMW0xE
         ZCMTNHE11/phaw+bpcIgLDx8A+4xQ4iooTC55Ej89BVQifl9ljz2szSQVnHbX2U9EkUK
         fGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776343; x=1784381143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBDVxtwo5G522sp2YomwpfimJG3Bg2W+ONywALKIPQs=;
        b=rqD89l7hbbg+J/ReDK/zoy16LUGebB5wJ+OHxAh1DWuYt6hC6aCsIcQR1jJCu3a8X0
         Fnaj5Du5aqMPBq6RlWuujT8MGAmi0FQHeN4i1zNxTBPI4I6Bi+w/ZZVzZLCclK5rOWDH
         i2F4nrab8nC9cTdlxpcARhtuwE8BIQWGnabwLrFR2odEeuQOkoXoDYGAFw9a/OqouCpW
         10lOfBU33sZYtrLR5S3Csk1aQu5Zar9yQN7FECtqsUBDOMvjRyziBBTEle4lH7mJTn9l
         ougTM8KOzCGJRIqXi+4/EIMDH7YDgzl4I7Fb55pVEwz5rmiZEJ+9eDU3gRHkt9whxTor
         E9dQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpp2a/tEDSoxPYbTFOrtqddHx4awtxN2nG/D3Jb+1MVWaSSAgjUrY980I5Ccsp4RiM4srfVjoHDZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQOcvpHOdzXhGhoUpdU8oWJ8esG86cE9UHtn1l0Low/AIMjQT
	5UhthOZ/HVRcd9BeWmB2619ATHDq+HzljZj3S1d9YBO6MJyLsLUFyyYdTC3ZXEJ0AF2lRuzwHMP
	jpXqkU2o36Pw/9tj30s2of62CicdT93GDoZrrxOBzVTa47kmFNZr8vwqrR4Z34Q==
X-Gm-Gg: AfdE7cnpVdtvxuX0rrb5bkKAM+dAUxjeRZWd+IYA1R6yFhQcBcgD2MrNMd5eFYu+s//
	lPr0affim2ga2aZ3r2NKZ571it+wk6tcuS+2SP7R7vWnf2xNukIvzZr1y5hZtux1vejE7DFENXu
	mVWwcaiUWbn5RkQn0AGRnxRQ6qj3gd5CqgEjIHNMkwfoXg0plEjRm/ovzbyEQyJkE9ifXvQQIHU
	fjrSM5gOJBm8n1n9m6cxbaoDzqAn+5fcJTO+F6hsX0+2ANnisBGNqwkI0qtFysfY390i0UqBBfT
	52e8ru+6x/NdF+uKQe3hpia5ySq7fDB9NEFz++8TBFXscTw+cWmuFC3uoZkokBsO7yG0aRviyV3
	ZGGTz58Zee6Vl/H6WoaqAAnZ7xI8gB1V5LWg=
X-Received: by 2002:a05:622a:302:b0:517:6350:ed50 with SMTP id d75a77b69052e-51cbf280b74mr27809101cf.45.1783776342854;
        Sat, 11 Jul 2026 06:25:42 -0700 (PDT)
X-Received: by 2002:a05:622a:302:b0:517:6350:ed50 with SMTP id d75a77b69052e-51cbf280b74mr27808931cf.45.1783776342410;
        Sat, 11 Jul 2026 06:25:42 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm67915265f8f.14.2026.07.11.06.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:25:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 15:25:05 +0200
Subject: [PATCH v2 5/5] ARM: defconfig: qcom: Drop Qualcomm SoC drivers
 with defaults
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-qcom-soc-kconfig-v2-5-4a907e064281@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=trZ/E4XO26da/mhSb5ySVVyndUZizSNk3tZ3uomkL08=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqUkQ1f4RiqpM0ITH/xryaAJr9qgCLPwsVUHAOJ
 S0smNtt692JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCalJENQAKCRDBN2bmhouD
 1yyTD/9fo4hEfWZLWYdwoIT18lw5uGPdnNcv4EEVDTdbusW3Wk7Q3kj/Ao8Gxeu3xVTW/oUoVT7
 0lK9FNC4LY2NeiYhtVIeHH8sKn4c/N6CnYlymMm5rzD9VghRsSD/iiBRbKXqnxUr2yFY1t42K9K
 Frog2+v0nP/fgbM6STr8QINxFO/vcvr8aAXtJSmO8wOII4wo5ftnM0y80EbRk3P21f7fw4+SBtN
 wbenZDUdsLktim5x4mhiPMQCEEI+24EBcrnNo3RN1ypivQUfuM7P//6zgXH3gtqpiEiG7NkYLsS
 VxvMThuIYi4ALuylEeNvb3HXn1e63gxjDVzAT6/T8tIGMd8ISV2gZNgNDixB/GePyTkjeqY2OHy
 e3biRP/M9I0useKfC+y28Wk6NmpmSMKhlyHL0NtMoaBNhi1/Z6XrLOy/N+YtvU+u8B/Fwx0GHK4
 ieIcftFVxS+4mPWbcqFArfSas6OgZ/imal7jB9eix6UkYxdgqSUWMHFfcH9ESUEv3CA3ZmmWkOi
 XYvfgFdHsmc8sxWzb9PNZfgQZmhghYi0nAWRQxQgY6BgYaHLycgdwh5nKa5VW2JkBu714hYEL9f
 TIMmCjv5+E9be+NVgpno12P+LPgL1f54VXwxUkAXkUXne2bLp6sAzbar7wSt3ajMQesyGr06ZTn
 mSyo7V8DuLMyOBQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfXxCu8CMa0WLVR
 d61g0+xPkArpMaOmn6ESWpHMiy2wI3hl9LGc/D7uH4Q3OWccMs5VypXvthi1epFYRSZGcH+5uTc
 f/pegPE4C83dpGysnbV112medFdEWMrsHhCnC/QiCoNJfKZsmw4Ppx3gm0JjHwl8ilG4W6Y8drh
 gyiMHx9fB0mH948lUmnI6NSaL/COKP5TqGllAFleNqPisWmzbNpK1200GbdzqPkK2uflH7SLJOI
 oyR6y0SsTM4MG4oizxYndaAMMsSIWb3bomjRuDN9Kk589w7C//4D0MNEgnnP5mRTSmH8i7oD1GH
 ohtSZZNBZvYO+CXdfrKd1eS87d/ZtJ9P8dv6Jw56sXQByrLDBTCGi99Ax58TZpe4n+QjOWaFRbM
 yh+e4xqLlBys52XF4ury03oNrPCV+2gO8OIyj3jooTc/CdgaCfT66vTvoSFDI1ivbnuH2ZfTnz9
 PlkkBAYsXpxYio1wdNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfX9Ugu8V5fe0wX
 Nf6DWLk8c3FLlvWsJ8kBleytkPJr2VdfB2jOQIlKGbdKAqjZngY3L688uGP2s74DeQBCEupixBt
 +x8dJOrlsA+qQscEVxBe3baInI58NkQ=
X-Proofpoint-GUID: MVJxZPVQzj-NuI-xJHCc4PIDMpJETqCk
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a524457 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=gBdK3KNpVRY46ggoUIgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: MVJxZPVQzj-NuI-xJHCc4PIDMpJETqCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110132

Several Qualcomm SoC drivers have defaults, so their defconfig entries
are redundant.  Keep the few options which choose specific choice
different than the default.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/configs/multi_v7_defconfig | 11 -----------
 arch/arm/configs/qcom_defconfig     |  7 -------
 arch/arm64/configs/defconfig        | 18 ------------------
 3 files changed, 36 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2d6292f8cab3..9347998e495f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1141,17 +1141,6 @@ CONFIG_ASPEED_LPC_CTRL=m
 CONFIG_ASPEED_LPC_SNOOP=m
 CONFIG_ASPEED_P2A_CTRL=m
 CONFIG_QCOM_COMMAND_DB=m
-CONFIG_QCOM_GSBI=y
-CONFIG_QCOM_OCMEM=m
-CONFIG_QCOM_RMTFS_MEM=m
-CONFIG_QCOM_RPMH=m
-CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD_RPM=y
-CONFIG_QCOM_SMP2P=y
-CONFIG_QCOM_SMSM=y
-CONFIG_QCOM_SOCINFO=m
-CONFIG_QCOM_STATS=m
-CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_SOC_TI=y
 CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index df0a0ce5b097..330d28ecf7f7 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -235,16 +235,9 @@ CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=y
 CONFIG_RPMSG_QCOM_SMD=y
-CONFIG_QCOM_COMMAND_DB=y
-CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_RMTFS_MEM=y
-CONFIG_QCOM_RPMH=y
-CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD_RPM=y
-CONFIG_QCOM_SMP2P=y
-CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_SOCINFO=y
 CONFIG_QCOM_STATS=y
 CONFIG_QCOM_WCNSS_CTRL=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dfc52e32802e..bb6afa8a6396 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1645,25 +1645,7 @@ CONFIG_MTK_CMDQ=m
 CONFIG_MTK_DEVAPC=m
 CONFIG_MTK_PMIC_WRAP=y
 CONFIG_MTK_SVS=m
-CONFIG_QCOM_AOSS_QMP=y
-CONFIG_QCOM_COMMAND_DB=y
-CONFIG_QCOM_GENI_SE=y
-CONFIG_QCOM_LLCC=m
-CONFIG_QCOM_OCMEM=m
-CONFIG_QCOM_PMIC_GLINK=m
-CONFIG_QCOM_RMTFS_MEM=m
-CONFIG_QCOM_RPMH=y
-CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD_RPM=y
-CONFIG_QCOM_SMP2P=y
-CONFIG_QCOM_SMSM=y
-CONFIG_QCOM_SOCINFO=m
 CONFIG_QCOM_SPM=m
-CONFIG_QCOM_STATS=m
-CONFIG_QCOM_WCNSS_CTRL=m
-CONFIG_QCOM_APR=m
-CONFIG_QCOM_ICC_BWMON=m
-CONFIG_QCOM_PBS=m
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_TI_PRUSS=m
 CONFIG_OWL_PM_DOMAINS=y

-- 
2.53.0

