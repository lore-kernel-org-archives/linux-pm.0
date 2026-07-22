Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE81480DE3
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719647; cv=none; b=Z8YUG9GxsRqsRsgGBTy4d8q7nmbgQBS7u//O+H1ToBwUfbMUUxTKE5VuFaYU7mXqrimdqVAOCPHti69gjDM3pm3BEn0wGsXsOTHTU1ElOtbpzWRfiwLlBmptNki7AZE+PGV356eKxL9YtmSfomxyiOMeUcmSeauR9HiNxH8Y3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719647; c=relaxed/simple;
	bh=kmkGsqLClKltGgmx2ZFGSlei16yqugauZtjl778tICE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btLiXIsXTaq9adlScM8Bwu9VNiODr6a7fIn5C6o6K0QrMqIvElKhtBlSjttl0O5WzWQQ8uRZc3rQjJpZVDizn7fc/pD2G5fq2ZTRYLEslzTwmqmgR3hPZ/xusLVnVLFTf/ULF5/Sft2Gh5nYrJ6D6aQdM9OuuwCkBvBDSWICsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RtLGsSzB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GryaVWmU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RtLGsSzB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GryaVWmU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8x9Y8401202
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5M1LRmAykOX0G96PBHdB913frohKOxohz72tFSL1lVU=; b=RtLGsSzBYtJlpR2C
	wNJFdYffjmolVgjmeWSiqF+rDJTYEqvKQtsDLArAMH/jsntJ+3z6NUgsu3/axWaA
	GHUj2vQTi/d71NsYpoDrb9vOejwkvwg8aDNZ0E8390tRVkbihbpHVf6N2xzwT42B
	P1I7VW2SgaCidc4aWr3m6KYJfNJ1jfpO/iFd7NF8Ep19qS01E2eVZSqi3sE7AOsy
	sk8ATHNAKgx7mtu8E2NmWKAKDfBAmGwaLf0DBUhDdUJjle+F3zxJYWUOIm0NrKEs
	p1eX06jH296WbM7/bTO9+uUGQDxICz6St+fD2YOdgmFpS9yvpMa6sBldjf/HooZF
	0NGLvg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt798qtq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cd01a14e81so180622915ad.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784719640; x=1785324440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5M1LRmAykOX0G96PBHdB913frohKOxohz72tFSL1lVU=;
        b=GryaVWmUqIgOIPR1xYw6Cvp1vqNqSQpm6t7RWaGNZriFwm6RfPZvy3eTz3C81Vut0f
         4UF+2MhHhNkUa0khjBqDr5lCTI8KGRqLfLMrjME/WDOOe+g3lnYW6g9yieVgK9UFTbSt
         tLhCBS7sk7wtQDLPNGEGcXxG5G6aDHvQKQT4RMfnE/cVZ3o1vgwYZ45KFfC4XkJ7RhyR
         kyJCW5svQ7pI9sqMkJ7P3EL4EPQ57hRztpPuATcFjoDbBfa8Q1mEL1cBFR3dWqz7g33E
         dVV/45orfzb588WFasTjwHY+/9fm1ARMB8zzhzkJW3jDe/vRJaC14eFSlWwVMfN47RMS
         H50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719640; x=1785324440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5M1LRmAykOX0G96PBHdB913frohKOxohz72tFSL1lVU=;
        b=QhqOCUCNoZsmPr3L0SP3O4+iow8x4n7oFLPcAFAGrAgnFQu1NuOyhd28w69kzuJrXM
         rok+0yJt2+10IUsAb4YQ+PXRTTyTsfG9T/tsk6740HG/2P2BHtIr6rtgCO+XVdwHlfu+
         bQ3V2tQePCvqSboxFBAVCUeDF0mMB5IxbXs6OVN7ic0D2LisKtq+caNNEhgfUnKh/F79
         e0dqJUB9kEOJ7jzHXdAfe4qivK575u/0+0AwhNhBxa58L9BEPfvDOY9eo/Otm1RodFe4
         yw0DWjlTCFae2Ce9AbhwV2L6q3FueYAtuudkIiUiQmyyhihGMiZ/LlcZTn9xNhuIeBr1
         AoKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIIPSaq4zJ8TDubuED8B1x9wRDpcrF5em9tQUGyPx+mvjBFK1zAD1VU8bI7Lw/4ONaUTZ1Z1a4IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgJmgGVm+6xi26fV94OnHF53a/P8Y3mhuWZ5cArL0pzdcpg7Z
	b1jkR8u2PHauehkiAZKp2SaLpTXXUIz08rdgSiTMxGoMpto0VCfWlvXtas0bbMcWU3AFWkBR/jX
	WoZROaeM62mAKR/9EsyE8rNvhFd7epVgbWaf6coc+ie/SIJMjwdl+29gv6vVOLQ==
X-Gm-Gg: AR+sD13C3IC2FpPNPa0CtDJvHoC8bpUtB6PZwKFgq1olz2bKzm1A55s8lJAQ4K6nkFd
	pYsfhnLhoR9JmoT7J3o27obXC5Wp3ADjcZsP4eXjoOYSsfQ+su424phIJnYImXWK7nbuTSjHpew
	rwJNk2Vzy4NmiMdNUqqy0BCvFdKltjxoUrWhu4hHRhsTjbqVZx9c0jjcGKwGKfL7iWMnJDC9SSH
	cf0QbNiQmHJx58y0QaTihCYMDoj8R8iGakJmAzLyLbJtrctxKnQd9oXJCmaVa87j9/e1nqwf/gW
	dN41IO6eV3PuX/eug5wITRYwi3xm+LFVRlguGFkvi1oXQGjnQ+GwH6O0Kr1CcPYKkcC9k/hfGea
	Lkahf6QHz61KAephZSD0=
X-Received: by 2002:a17:903:1b6f:b0:2c6:a172:55a6 with SMTP id d9443c01a7336-2cf3481df5bmr259252715ad.9.1784719639908;
        Wed, 22 Jul 2026 04:27:19 -0700 (PDT)
X-Received: by 2002:a17:903:1b6f:b0:2c6:a172:55a6 with SMTP id d9443c01a7336-2cf3481df5bmr259252265ad.9.1784719639474;
        Wed, 22 Jul 2026 04:27:19 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e65f3sm13143995ad.45.2026.07.22.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:27:19 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:56:37 +0530
Subject: [PATCH v4 1/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-gen3_adc_tm-v4-1-011981f756c8@oss.qualcomm.com>
References: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
In-Reply-To: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Maxwell Doose <m32285159@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784719625; l=1235;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=kmkGsqLClKltGgmx2ZFGSlei16yqugauZtjl778tICE=;
 b=pUrAWjkvl6OeiuBC9hlzdFTTXKMvK7YjJQRMmcM/adHAc5PvrD+RWIO5SFKXzgV7XScvLjgk4
 LYh7y6QOF0eChmN8nEkRjkcfntzLNHrP6bz8kmzouKoQ+j9s/wuuALx
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a60a918 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=kIsQgyr_JZXbD0ExW-kA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 0S_ZfkZWSaOAiftUoe33uwiJN1AG0QBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX4IBKHSJ2IF2n
 BSimRHS9obBsZJ64+AYxIqSwA66/sW0eSMyt7YRBMNgAytILYZkInY8wxeK9BEgEgUBT0OYa5rJ
 AYCGdtk9fBcji382sWm2eQx5OHijxEmaa82sKeRrRBg2SFVN6rX/uoNlWrEt0MAAdu8GvJ7nvD5
 DXVCzdEjzKF9aOglLc4b4TNePWQijj+9hz840H46sKb9OGizRmwE8lKzFY1o7XSVoqSDaRsPWOS
 MfaGiZOpqWih8mY1TAICqBA74n9mpMAjVCQEeHIlQO5hfYiAUOaNNoKb6emPNE/6Gped2kw6z5p
 KnrwDFSbVxzkdx2KJakdBF66EvZ5ksSghmUqQ5X4lEloZlV2fXfVW0SPylDgRxL2BMXdy2cI1um
 0wsZ+rWysR4y9XRoubHFudJeIDxOBCpvhlNesPcg8LWGMdyvRabuuFq+ord/4qBJgU9wocKhOgk
 X1oTYkw1o4Be26pppVg==
X-Proofpoint-GUID: 0S_ZfkZWSaOAiftUoe33uwiJN1AG0QBE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX2P8ojw5pTiP8
 j7NqrjaggLN/M+ITQzGfzmnDo6+ttZHswbuSvyrmcIHHwTyf8weVidjlvv9ooGpirk8aSy278CN
 Id/MIatSGiHf1c4MKHbEbcbDSGXEfS8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220111

devm_request_threaded_irq() internally prints an error message using
dev_err_probe() in case of any errors. Remove the error print in the
devm_request_threaded_irq() failure path as it is not needed.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c56b650fd8c0..2eaebf6b34e8 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -821,9 +821,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
 			       adc);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to request SDAM%d irq\n",
-				     ADC5_GEN3_VADC_SDAM);
+		return ret;
 
 	ret = adc5_get_fw_data(adc);
 	if (ret)

-- 
2.43.0

