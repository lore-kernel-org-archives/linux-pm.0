Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD433C1970
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846829; cv=none; b=hQpUfH4GAtJaUPPHolm5JynJEyZGboYl2cT4FdLf4CBaRGd49OSCoz2cw9g9BMwMTpSEJd/zk2kliftBH0gr1GlCP3lo8laZ8b/5g8bN2j5S0RUAA/jgqcCVMeup1zmjVZA2qIAkuCS0hrHfhTDecbiXq49z64oj5aYL8j81KPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846829; c=relaxed/simple;
	bh=rylEUKbgwwHeRjA0WoNIWuxgWdZxa5IldWTbxUUv8+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFqsTqnwIQ+dxZaj0w/9X/a+MtQtmMKvOZeLwQT/+LsUyeRZy6LXhsGFT3nbP1K1naGNcN2aMK1+vrh9eo63e+aGYnztVzDSIGQ1GUIT71aZtymPBJlRaFzl4HTwOzh1M3dZ32pBYf61Bog0JbfiZSf2hPHV+65peBr3RYfHLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VEa09hAU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DAS06bo0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VEa09hAU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DAS06bo0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5DaLI2123746
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 08:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KST2d59Unaq+ppV4P9iqg7KgECLNrAb1amf
	c3JF3ilU=; b=VEa09hAUwj9rBQ+4kgBM+a3217kGst1mHEynRpoOc7Ss1IuO397
	11VuEbbvNP23kg1lQJLS7JfpkNf/WS4xT+LxCxMJMafaUeqavMs2A15KKkRkDXT8
	3jo2v28ThWBUkS6yEC1oljNBrzLO0QZjG9kCosGbIJuCKKk6LR0OcGIoyzP+8t8j
	hWageFbamHoJ+gLJfULVKU+SN3yEYvxLTF7eNdF2XZix2IZNJQIX+mDzCwkcvStw
	9XitK3oSSbhPAGM+KR7tJ+MqvVwclX94+GSk3L/4ZbV//eS3ZRvlbfuLUB9XqcrP
	aBh2Pi9rMWUlB8K9NwQcnUxH5GPwLnnlLPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenftg1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 08:33:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fae95c82cso3335921cf.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776846826; x=1777451626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KST2d59Unaq+ppV4P9iqg7KgECLNrAb1amfc3JF3ilU=;
        b=DAS06bo0eTH9vIXX5In3IO2x6s7ceAd+Pj4fuG1tuRWVgLNJ8GPrGZo89hO4IW5ebQ
         bg7T2vp8dtO8sfskTvNXl15APH56jX6rclmKQkvSwd23XWkWUiEX926jrnIthc0eoDZ7
         QNeXdQzKthATvvjGbx1VvPhFdfwHVkfKZH1ipULN957FBYoMA2Um6pedSQeTFG0b+kZC
         J1b/GalHcrtgmD6nFy1VF+dhRdC4ToLfDj2pMdfXMePli2HWmIByewjOrzsRPS+IWmbS
         Cy294sk9Mw5VsAz1Kt1pA7XfhyX1WBoZmbQrScH4v/fSM0Z3yWVmWVNaHJ+dxotx3QlG
         PTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776846826; x=1777451626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KST2d59Unaq+ppV4P9iqg7KgECLNrAb1amfc3JF3ilU=;
        b=qg1sdPMhuNzVjYxqQ558yYo4dmP7Q0olqUqyH/6YdsjHm/dkCPKTPQH2sYPiyIVE+i
         7ph6ig4SPeq2xyXaX89vrh+EglMX6gLF0I7mj2BWDNXi6P09kr9KJds9W1WPnQAqgAsX
         RoZKp6GzOvMjecRv+7jxL9Z8KOGB4D73JZ8x+j1puJfq3RIwrQ2hxu9wDEFw7Og+43An
         k9QMWY2HK7ycZsWyNPpWpxOqK6vw5BGCPpNMKyo5rFl0If2YHNo8BJ7DVCemBXgIVMLA
         2B/cTvb6Q7fmdpHaw/amFaEwIWN295dccOn2YRCtCThKGrMxaCS3DY0AnZcofogtJqD0
         DzTw==
X-Forwarded-Encrypted: i=1; AFNElJ9viw4Eumab+hIBWspi2rxA/vXLYGLA+wnXF8IKO/ihNEajlSp/C6iI+JADdTO++LJe4J4RlmFkFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwVNKbd6KRJ0di/jwRrhuDJcpaCOLre77Bm72OXovdck+zb/d
	FtrYeW7zhzRZBm0BylhvZCKediSYoZALmAhtECqRuMOFVdfVA7In0GFWncOxOTYrK6j6g6K9VX8
	pnEdySKuPYILIzi5V/WmspNHoKykZNgtP0x+129omM4SYAMDGfzefKs+J2K7tuQ==
X-Gm-Gg: AeBDiesva8ZnO/wi6aOHtq2qpzL396ruUwbvxJiu7/HFQPKXa8xmBhPZMTKVcA71jNk
	GLLFZEyAmqwt7FmOUpunzprg4JRD4xVs6lzQQB1LLATeQV33EZ6Tzf7SLbsxZq6khIkIlTMyway
	MBJzOD+V/+vDydVPYXQx2jYaQW11FgLQLH0/pMhL/osODMEVZMi123Zqzt1rNQQd38m2UKI8lTy
	OXXndImNidongABSj0j5nHll0pgBSFSvVGMCiQMMvydzO4W8nQwAZWksGT03BZAzfERKWVKVoxO
	0EHN0VfTl/iLocGCYIEuMqIKdqQF86jfBLtKfrn92UuaNN6uD7Dbi1gIJlWOG/2K5do3GUbEFE2
	XhYus2UJmaxB/vt0D+i/3gg1hLwt5xyPDQNW5SkoiIMxuy0c=
X-Received: by 2002:ac8:5712:0:b0:50f:c26d:f314 with SMTP id d75a77b69052e-50fc26e28a3mr18829871cf.57.1776846825638;
        Wed, 22 Apr 2026 01:33:45 -0700 (PDT)
X-Received: by 2002:ac8:5712:0:b0:50f:c26d:f314 with SMTP id d75a77b69052e-50fc26e28a3mr18829571cf.57.1776846825187;
        Wed, 22 Apr 2026 01:33:45 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm43546621f8f.4.2026.04.22.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 01:33:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] pmdomain: qcom: Unify user-visible "Qualcomm" name
Date: Wed, 22 Apr 2026 10:33:42 +0200
Message-ID: <20260422083341.84390-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=rylEUKbgwwHeRjA0WoNIWuxgWdZxa5IldWTbxUUv8+s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp6IflxahORMoRUI39K2uOeZPQxfoifYoSKoDFA
 AcLMjqAv+CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaeiH5QAKCRDBN2bmhouD
 1/+/D/9WzwcOYsXsDtnLE0UBvKnjHD8Z9zvOoca3S4ybdArW9FnedgD//msZuvJZt4wvUvymgdd
 z+fMo2mN5uZxsYXoaNW/IF15jf7u5zBQzJHUuj96qMAjcxFEWNJ5ZWvbP0Mp8c+J9GscfiBS+MS
 8OcwD5OD/MhSimXXeRjt1JTaOvpGm//gdcG7h0csNfLH5fWloBIfe+KFdnggTIyroriUke/8cnG
 sudaiHICg6CD/wPGJzAoU01+LELe9GEKhUVDfvlETXyGY9ukzP3fLnj1biSxO91h8qSFb1biylo
 BttEICehl0wOIiIJ3GiOpzkgr7IbM2YrCGK4RNn1ep1SbT00ydCDYnvyQNr622MZ5/sNvI2l0cf
 o6P/BmlMzbTojKO4ICgVEwJTade8cvd7d/ti86tp4B3WZp3XP9GO/qwLZ0unfmU66y7JXJzzPYH
 iPZ0lMli8m7nHRIrfTvuoTPfaz5fvkPYsTAHE9vp93FhnEnzJvA9q4azA8vkLpZyQfYYL/zFnob
 5W0eF7A4Ra7XeEl7q1wzm8jJkH4e5INdta3YmoNkUf9gJHSLu3ObEN9icveg5U1U31kpXKkMc1B
 +VxVVVLZjLCNgv3ANvhrlYCj08hW2cJiSCvyjMRZi4YQ/5nO55G02YcvX53lKFodeCnJxatgWX7 zcLVZG8v2hz2M2g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdioyBTY c=1 sm=1 tr=0 ts=69e887ea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PweoiM3H775_Lt3OcnoA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: iqcE1b212jgXiTYERER6kJIvKJR8ZuHP
X-Proofpoint-GUID: iqcE1b212jgXiTYERER6kJIvKJR8ZuHP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MCBTYWx0ZWRfX4URwzGboUR1d
 pkp6wm6/zT310I67IS2zvQzfyFVy9rqI4DSWcdiKndyhiU95vJvosOlQWBKm+Fl8jAuazRigJrG
 GlBrOQOGzhjusQKnA5zlcVamRbSQyKXUxH1SEsvQrfAW4CCpGtj3I3I9WbILBEuWl0yctZQjiLM
 TW550YeeLWwWUNFTcw0MtGPqEmen/4MipOWwbsVhO26DQxQxtvyvXjKQ8H3IAzP2A9Cydtgs1oN
 6J0u5bxRhZ74B6qYmCc8Q+TJ4aqynI3okd3bWP6qzWbIuuPQf7CZtvrWgMR8BHAkno/0nEi84Ck
 CavloJ27a0yWSuylkqrg00KRbULI8Ei4XVU/6bp6iO4DfnLRpSagoBBJk5JChBF0aHOFgGjmtwR
 Tef40a1Use/0/sBOofUL/hwWnF+boRmBoTF+XUbUI15IEB3P4FbWMqqjbD41sJA0sh3C5ReeydM
 gALacj/caTvh1LP5siw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220080

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/pmdomain/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/Kconfig b/drivers/pmdomain/qcom/Kconfig
index 72cbcfe7a0c9..4abd43a88d08 100644
--- a/drivers/pmdomain/qcom/Kconfig
+++ b/drivers/pmdomain/qcom/Kconfig
@@ -2,7 +2,7 @@
 menu "Qualcomm PM Domains"
 
 config QCOM_CPR
-	tristate "QCOM Core Power Reduction (CPR) support"
+	tristate "Qualcomm Core Power Reduction (CPR) support"
 	depends on (ARCH_QCOM || COMPILE_TEST) && HAS_IOMEM
 	select PM_OPP
 	select REGMAP
-- 
2.51.0

