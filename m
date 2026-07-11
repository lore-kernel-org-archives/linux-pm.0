Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6993C7DE1
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776343; cv=none; b=LAi+lk12J1pqWFc7vPFHhTsILIcIz6ybqJY2p5DfJyDmdJOEG53zjKTjYlDVtV8jUm+jFk8Pg6CNwWzH9nAP79nq6huVVj/nmy6BKabYyhn4XMJBzVqKaE0zkrPCI9Xmj0vQ1cK8NpI1k/HVFRQOi4K52KCbb0r1LEL3kuJKrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776343; c=relaxed/simple;
	bh=5QSQGqiyXRwrFcknIZuAVjqWPj3lMvMMcCM69qrmlkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUfQCCt+2vzfuC570JRW19reIaP8S3b8tfqTCLAy8ptzJThII2vS5897F5xuqNlgh8PtETznGDx8Qt990NakvORsf3HHIM7FkTzS459c3PWYo7Tr1YIsmvRkF7TGYcFDN30OCr0C3r1kgfciAM6U3JYjsCYQYx9OfUwAaFMv7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=my/Hit0W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XzkWZDnM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="my/Hit0W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XzkWZDnM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BAnHA03433908
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dR6f9gGXTOpY1sSwJBhl1gsRgCY5tMNroo+cgHnCkC8=; b=my/Hit0W8oQw+kgb
	Y8/Xmj0eT3EKvTrO2UjkD5KHPxMNmFl//QsI7V9bqpnvK2AuQsEkRjDD59GI+xDy
	HPRxRhpCie95q/UjSdAg7BpYatyvP3BwWtDUhe5HbE7g4hfe0nFF00zRrw8liLx2
	TY9ihNfkkqEJs7uO4QFymVGmfj4W+bODMb3DsyurOqmij4zsf5rLd5uWMqN+Jcze
	LGaTU09YF5unY4RoHw/W0MyqGP2guQU5+4uB3nFMUpjkEojBMg3V06qKtiZsrI26
	T64IZ3DXm7TDfhdBbwuaDJxXYpVktBO7z2WOg7H13iRWdLOwri6Qpgn91pNv+nSS
	W+9VGg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0ggs3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 13:25:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bff5c7035so38480361cf.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783776339; x=1784381139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dR6f9gGXTOpY1sSwJBhl1gsRgCY5tMNroo+cgHnCkC8=;
        b=XzkWZDnMjrTk6TgyA4joV6QBeUKVZha3Tk25/3HGM15ysoO0JFcwydg0PKonU6/Nhk
         /vZn6svdE2JeKMLfhVDxSitd9s3BJBHuhq47sMhI3Y+zynqqD8GJ70j1S3O0z13YGqmj
         y5B6Q1SbXiIVMJHFuaTNi1vJZrp0ooWH32UB2T6Rnxz5bBQU1Q/ChDMXGsUgeu2NsFQ9
         bniZ/ztsizlnWakRBMVjdvzHNQqg++8DT5RDeON0WFod0Gyt8x4W/8O/6dRpLmvV+8N/
         vX2VeumeBbxAaxsyFHjfMOlx3ATKH7ZVSgb3cfz4E8qu2UAvzmTc3YlSjg29EK5R/fnU
         uz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776339; x=1784381139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dR6f9gGXTOpY1sSwJBhl1gsRgCY5tMNroo+cgHnCkC8=;
        b=eRnpaKannlGPYtIPhGNr91nW+pbKA+5pO9/AOerPj3+L8pSLvs3oX+92IJFPVo/Ahh
         Pxs4MMnRj33VR4k5YQbqnIF+xmutS81nrpUqTP3TAX9f/CKHO1jOXpl6mVUCiL/advbF
         iscYuXWdyiYayAVWTFz1mRXL4kPaPYvjBJe2MyRNw6p8SUPmxrFjbLDauovd8zsKWkeM
         jYRgxz+qwlAxWIj/uvTkZO6KfSnfhhz7zI2Dh4ckzoZVTCmh5qebG+2lHg7Rq/s/io1I
         6tBDlwRkWHATGjPNzxbwsT0ce+5mB26N32iiGPmghFuAkyP4DJJAY5vn7PmmImJ/r7et
         g8gQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUGtpB0UBPIWi30Hg14uwKdMh1gV1E+LOImtuFyf6eiM7b/iFVGj+jO0KM9abIGq5u5U2GQ79oXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykhwcRiJigPs0AL7Picgf/dO1dqJWY4cICzSGjJJqsBJJk74+5
	OkkPU4BDCSnhyOPwwYnEa/1xHMQySbP578Z3yldB4pbqgdcZmxuaIlRIdM5vZEufGLq92GSh2pu
	CtG9lAopa7mP6H1c91DxX/6VkfMqyFR7A8xGHQZSMLD/ze/nt3JHBMP4EN+CNwQ==
X-Gm-Gg: AfdE7cn2vxiRaMcboqDAd1VqHNQAdfkBp9XtHBzF0WYZVSSozqopsO8s/qe2l5qOAtJ
	VmGg8vdFd+55iEbI3TYVy+Hao64dtlOxkW6QeDbjbjWASDxuwQ9R3YOsjGjo8GqIobtI/P6TFua
	ZvaOtUhRAAw6kdu7xta5nJHWS8pOj+AL3OcbNVEEp2bac7Od6lOl+i+r3f6LlWde+0Kn9xcQ/q0
	R36VWAQYYWNdix4CxdjVcHvs6sXuRTzcHXAwfrG9jnlxsg1zcvNlcygKlGlCq6NKsbE0mKrgNJ6
	+r3TqudUmWs2v13t7jQLq8e1mt9JpcHQJ7JpAXNqT/K1XvSjNiFaS5gIgNP2cN1EsuhkPlXBwU3
	WXI4etne/gwNEPccivnBgtQMs32FuQZM1zBA=
X-Received: by 2002:a05:622a:1b16:b0:51c:404:af7a with SMTP id d75a77b69052e-51cbf132788mr29297111cf.31.1783776339413;
        Sat, 11 Jul 2026 06:25:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1b16:b0:51c:404:af7a with SMTP id d75a77b69052e-51cbf132788mr29296791cf.31.1783776339064;
        Sat, 11 Jul 2026 06:25:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm67915265f8f.14.2026.07.11.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:25:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 15:25:04 +0200
Subject: [PATCH v2 4/5] soc: qcom: Avoid SCM and SPM for cpuidle drivers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-qcom-soc-kconfig-v2-4-4a907e064281@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5QSQGqiyXRwrFcknIZuAVjqWPj3lMvMMcCM69qrmlkY=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGpSRDSiAdKjB1yDVw1E8Bu0DseOe8OnxtDMnq5daC1yT36B9
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJqUkQ0AAoJEME3ZuaGi4PXxQkP/R2M
 t3ajECZUoBV60x8A65VR7AVtMhajrFiMk+Fbll0gPPcBdT81gOYtdycynJqsyvXGJugrntbOhiG
 CUZMNZNyr8fG4OB+pGINE25XQYeB3yre8eavG524z8O9xlI5i1WVgyPTxPh4opwg2+NRGMoPHzB
 +W4e8BNnnZlMZcgD1rZ+HEGdeRx6o4+gIzjZQ1V036REJGDwojSdlA3auY/UloaPznOIpdRvSHC
 5RnqgwDyR2ry8d1PxoxlJ8Y3AdXpIv4KCQEkLpf4Qr0AYFqeaAQBFptf8tdB8M0adGB/JrXpWfX
 OdLeEOvnGon06/97lYAOyrI/PPVModV1aCoNyBHLLdeeOwFAhe1vwxdGjoSh2yerf4G5bc+yGvB
 gLw16lx2sYfwifABkDjOtLVnSLrAAYa6j3qXEt+z0o6ytLC7Ft8YBFcTpITL6APhYb0/lCEO+GG
 W+yEE2RKbvbT+57t5In/mmWGSRe57OE94bHRz9BtxKXDIgf7W5YA+DjVL2/z3q46aPPq/Sn3iLa
 dDd8UcDTxZ5ADarj6+iE49ldjPautgpIjYVDT9QuiCUkkXfz5V+jCiR6H+snmiIwljMd7ovGmmP
 27yOANSiu3Hb9VC/472OzM9Jf9npOQsZx3sZ1mOOlXpR6CcQjg23OF8dkJXPAKxYV0BUtMnNIcd
 3KbR0
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a524454 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=0Q2KlgmO6JzD7cqg6jEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: mu2xOIdYDIea25QiW0lsZXoll8CHwJmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfX0/QAABHfkwk9
 Di9kUK2xWApx1M7s1+jsZGwUusVLY05aA5gyZRUvgpRsgkAsNuMch1u1tPwsjd08hFTXxC/n//y
 9Rb+YsGk7aDTFcQiagHhhkbm/ExbwhHjazM/wyx2vdC/nUFsquHzR+GIA9kLJ3QUz10//DTdXiD
 OhtEBEfHDI6cv+VyNxo2smCYFGFGP9WVW4twHNo7tTDNNpfJMybGKBbbYRSgb2k1Vtk8Wp3vO75
 nWZyzA5vtljeJibjx1J4sQmHmvkUmRSjb90MIEgktUkP33OzwpwX9UFSKMGWexrPcA36CVXpN++
 zgnMJRiTpzR4IY4z9z7ojuAMhc96LBgfyZOkDKhGg9uJNxfo/H8pgR45Hs7tOWdeFIrQjD/tzp2
 4G0CdC6lkeKbkCSn/+gKPIkGxvUj8Hhq6yQeOAp2Qafx5i7vmnROVB7IyktnyNgIvIQk2yJQKOl
 FJLkoyw5gsR83n9/B/A==
X-Proofpoint-GUID: mu2xOIdYDIea25QiW0lsZXoll8CHwJmA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEzMiBTYWx0ZWRfXyYynzpYAT+bG
 UG3x2RfBtLy7GgQ6CoV43/1UqiQvzGGrJp0dj5mJEvAL+LjA5p9iYHWtfkLMvF0BcTvZLvmZT4O
 PL6t5OIC/wZFop4Icngvbetfw5cn2eo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607110132

QCOM_SCM and QCOM_SPM are user-selectable drivers, thus
ARM_QCOM_SPM_CPUIDLE should rather avoid selecting them but instead
depend to avoid any possible unmet dependencies.

ARM_QCOM_SPM_CPUIDLE does use symbols from SCM and SPM, and since it
cannot be built-in, the dependency must be as built-in.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch after suggestions from Konrad
---
 drivers/cpuidle/Kconfig.arm | 4 ++--
 drivers/soc/qcom/Kconfig    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index a1ee475d180d..b88b01aa5829 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -120,11 +120,11 @@ config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
 	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
 	depends on ARCH_SUSPEND_POSSIBLE
+	depends on QCOM_SCM=y
+	depends on QCOM_SPM=y
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
-	select QCOM_SCM
-	select QCOM_SPM
 	help
 	  Select this to enable cpuidle for Qualcomm processors.
 	  The Subsystem Power Manager (SPM) controls low power modes for the
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 4e6eac2769e5..fd4d4ecd2df0 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -227,7 +227,7 @@ config QCOM_SOCINFO
 
 config QCOM_SPM
 	tristate "Qualcomm Subsystem Power Manager (SPM)"
-	select QCOM_SCM
+	depends on QCOM_SCM
 	default ARCH_QCOM if ARM
 	help
 	  Enable the support for the Qualcomm Subsystem Power Manager, used

-- 
2.53.0

