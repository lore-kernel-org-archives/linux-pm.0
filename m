Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820833AB277
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965773; cv=none; b=DKLDUci9LB4bfg9TmpWxeJpgX1P53S9PiWLNS8X0M4rWNNSzHociWpB9Kg4z4ujqgAtriogWya6dj+R50sQuSqpU8hXQObA9WYm4XBIZUTKWVw783OIG2/GVtOxbq2/tYM3Vv3bWBPXYW3YfpTOcoPJmCqJ3HSBApRv5hVFcYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965773; c=relaxed/simple;
	bh=C9YhEHRpWNsd+pGliRQKbP4Jj+f9q2ex+MgRiiQYy1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVxTprXcOcUbilQmRCK2iKanLnREXT0d1grIp30KfGXi+FzHjqVz2Ezd4xXFgUrVCmWLnMb2NnpUhXNyhj5h8vhhKDKAvKbmghPD8PDUqH0pQhekfJAX94cR3zw5SCbUGzlys9Xj5Kq2crinV1l5wz+kANLBxZ01Z+XCh7g28Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0+U7g1x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CaZI/n7N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0+U7g1x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CaZI/n7N"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NHR4K42709808
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 17:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eu7l7VxgpEnPFkcoT5OAEbU2fMjUYSr1dSr
	YnvTxZ1E=; b=X0+U7g1xeOUFc0lM3fDhSzHLz1VF3wopvDl3cqFiHDLH3nDuUcT
	DeCDBHkvGQ4D73YRbXSkjPihxJaC1PkQr0k5Pfb9n+Cr6sjw4jQ0w/P7wEzwfmRa
	G+cAZXtey4gds2g2wUjQglqFysU/KIruP3D9f7UIB6VlYCb07q6x5bwmhfAc9+TR
	V6UeZ3C1dNKyKynu9XoACK2SQ0vuycUwaNdGcRU48mX+VIHUMjO3h7CcDRWJPla8
	cy8/jWaF/A8dZvI7ityrnASvt1FpvAMPTraHZwE+rHOYAZoUzF1YNNEJKl2j+DGJ
	5zbzoKJY4BJlnMremMoIjN57HLFaRoZoDJA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqqu9r18s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 17:36:11 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-60ff08dfb37so3451069137.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776965771; x=1777570571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eu7l7VxgpEnPFkcoT5OAEbU2fMjUYSr1dSrYnvTxZ1E=;
        b=CaZI/n7NChPxZFSLMYiQiLTM7kaManVYCN2a2hBdfYJto98W0eVOCisz8Vc67g4OUK
         FHwp1v+HltwVYrOOrLJmyUVeZnhXomrFQtR9I8kv8UtaQgZ9QEbRQ8b6belvErAAwTgs
         He+GzksDdRklCZpbZ5OBlthiFJ6fd4pMPh/Qbmgn0Qgr+r2lpiD9LK3goTnsn/YwpaE6
         pzDxWb6mcb03pUqf8xh1qEmTlgzG2QNdmP5FcBEm3QwTC/MewaWwGh3P4RjCvQXDpFUd
         vYkpUmepkN1WOAejVIQ5+dZrFlhlK8xY/RkCYQmRGF/DJqrZEyUyetqd1survIYakJTs
         nNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965771; x=1777570571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu7l7VxgpEnPFkcoT5OAEbU2fMjUYSr1dSrYnvTxZ1E=;
        b=q5gIWyWmi3ox0D3V/Uq26nu7jIPr4J2NiWFvzLsKxMvZfUQ7dhOO19TJT6PIP42PCp
         VzCgKna59Bsxch8K0bCPZOwocxE+itUXaAB6CNe7BwqHbu6nKWmmfCyhz6nONlFBK2a7
         L4upwzCHWj+ABYgIdSLcqpBQvg/42G29jzrGA9CPng2hX2r52+3zkxo6dTbcBaaDlmsG
         9WYVnOt8KWn8TiEC+w2BkytsCdxEnymZhz+qkxMtzn2+25zTPUThcyorMMzhxE3ExnAt
         4bGaAXRFTgbAcvlhoS3sMntzDxcWvwkfsNDuG9wQAglLQv5I3yPjmbttXPsczp1GSZfv
         bVDw==
X-Forwarded-Encrypted: i=1; AFNElJ8UAxa68nbe7i8MuqQshtpuZ4uCufSYek9zLTV785gxHrgMdzZtPIEDsEWQuZCYKa5NWeMzD6rKSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hSXej+suJDfiz8J33yqhZGDlUV5hGmcHJ8cgg+DqPSXl94iu
	SN5u2DkPo0aE81DKiagxujtlCrY66YVwKdquA3bjro8EpMF4ORrXaj6DPK6ifNBCWlOvFUGL8W1
	fG773NeQHLUgyLsA6imxzG093K1qyCYQizDxjNoYWmLx3krKLOkciEbjOiJLqkA==
X-Gm-Gg: AeBDieu9IrHfSDGl6RLshjY+CQSvMhyxmpnx3r1oVT0G5vgEDZRj1HF7tYDhx6nPA+5
	shPM9gd+5faWwF1Z7suB1MTX1v8DwCMH9LWaM8msd8tYRlVf7LZl3To3wHvq9OyMegSWQiMAhK+
	HmLFDHOu3uziICvQzcYShQDL0tLM7Z7bGjnwlQzm8TVj13tdANCw2e9/PkP8ngZYw5cjpkNj21J
	W4tEafEQd0ym03n/Qmnbi+9gPoecZ6TQmxw9op80orXN2WaPAh+Qg0OW6EeUvEHDQD5mV/bfxgK
	sOS2FLoNbDW2FlcvgbE1R15dktMVsDKpoXk3EoljxniWK6IAl6j89zkrnFbACCZk0ia2kd2g2YD
	CKfiGcX6y33QFeUgPPLB77Oa5kIo4tzeGLfKyu6w69wt9Cb4=
X-Received: by 2002:a05:6102:38c9:b0:613:86e6:b2d with SMTP id ada2fe7eead31-616f7c5f0camr11549893137.21.1776965770979;
        Thu, 23 Apr 2026 10:36:10 -0700 (PDT)
X-Received: by 2002:a05:6102:38c9:b0:613:86e6:b2d with SMTP id ada2fe7eead31-616f7c5f0camr11549878137.21.1776965770506;
        Thu, 23 Apr 2026 10:36:10 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm54297104f8f.13.2026.04.23.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:36:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] cpufreq: qcom: Unify user-visible "Qualcomm" name
Date: Thu, 23 Apr 2026 19:36:08 +0200
Message-ID: <20260423173607.92564-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=C9YhEHRpWNsd+pGliRQKbP4Jj+f9q2ex+MgRiiQYy1w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp6liHGahYfMMaWMwqoAmSNlsy4onY+v1QSZmsI
 xav1s0jyX2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaepYhwAKCRDBN2bmhouD
 1xa6EACBqLP7wqtJRWRRJf4kI8hLAL78pNuzAlsuyMr0tAAvGSLrBYgIM017ifZ21GKpicsAXec
 KSLMeAPOfQTRXjcuJHoiCMNWBgna2InbX9T8+JfEwQr6qKtlB7dbAkd1QgazAgpo9ZCLs/5HqmH
 QImMDeyJF71JHFrhY/knVFwBD0VbJuJGd052gD4d3RXN4B7xt0K9ziUMZ+gIfuPVOBCJ34YeKr/
 LqPKBqP8HnXg1h0ah1q1WEAYQG1TWZrp3PbQGJ8szgIIUCBras3GOw6Q0arU95XdSl548P7nuL4
 ebSvVy2zfWftZdWibaX/+E3Naa/uSGHGS5pVyGxz6B2tn5lo5teXZS3RS8CKXQQ6AZWmWNlxk9Z
 jMI0ABbGKxf7BAzYGWylk2k//iuxroTivzbIO7sbazugzD/3wA/2crhKwUBbl2f2du97jKpd9yo
 Vwf0Cqcez8L8DhxiqjUu2OM6Ay50DXDX/mstGNk+kvKs5R1lA2HbGZt3d8R8DEZkbb2/t0tG25n
 YiIX+1ivYDjrKTrWXgm8orv7CyU08lyPePgFTxQQL2Ko/EKhVe56levtMuV6LKouW5Uy9Er8A6v
 EVYlCXaPr+Pw6HODCRUWnap4D/UGsmXXe9HL5PwSQDFm1JeEiTUQYAv2hpP9Qvd1lhd5VyTFjFo xObkia5e4XATY/g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pK2X9wU4vNFQHMujdfJYNu_N7G4WPPsc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MSBTYWx0ZWRfXyz+hv7+ncNPO
 v7doo5Xfttbeuuw5D4gDWVcTwysf8G/rslhnFOOGcSTs83YkJftEPs3qoVGfmwPuIJq2VmSqiIY
 TOYzE8bM9PPMInWpFUuhX8qlKgNPc2vTYTOjR2nV7BsyNmRZZsbz/WVdYgn1gl0Wvp3Mm0TcfVh
 5sZRWG2T5lkQ42y8742dA3PQQ/MSedRMSlTPf7i3o9F5TsKq+qhdJEUcDcedgbv5bdg8n8fz8Tn
 09AtyBjNGov8ygWtrGkjqwfDscuEY3p4LDloC9kNJL5JBztt5wpbJwPqaLHVqpxbQT1YoIuEedU
 EjaehbgCeJbL3jS8L+gTkITWNWTsiqK6ii5uYM54ZyjcjuMl1v2DDSLB7Iu3ib011ocOGL3lynp
 QwVOmCyIxhF78pPoubOOog2N63Eqh1icslWoqVqTIq80+UqAcRwrOr+79IA0WDaGK7fJo26EEmM
 VhKLesiJtZ6BgM0Hl3A==
X-Proofpoint-ORIG-GUID: pK2X9wU4vNFQHMujdfJYNu_N7G4WPPsc
X-Authority-Analysis: v=2.4 cv=QJNYgALL c=1 sm=1 tr=0 ts=69ea588b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fRH1FL4upxs0yR-D3sQA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230171

Various names for Qualcomm as a company are used in user-visible config
options.  Switch to unified "Qualcomm" so it will be easier for users to
identify the options when for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 47c9b031f1b3..a441668f9e0c 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -153,7 +153,7 @@ config ARM_QCOM_CPUFREQ_NVMEM
 	  If in doubt, say N.
 
 config ARM_QCOM_CPUFREQ_HW
-	tristate "QCOM CPUFreq HW driver"
+	tristate "Qualcomm CPUFreq HW driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on COMMON_CLK
 	help
-- 
2.51.0

