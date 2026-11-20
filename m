Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166437;
	b=Qo0MvmImJkQCWEwBtLSi2VgrU4HYsKmg40IcSVNr0ZeVV866pRhfAXoxqy9r0QHuOn1h
	 q0nUJUzkw3XhbR4GijxyPhL7u9cEal3zZ9kJRX4U8EXFk89OJ7In1WddNt6V8QW6a8XX9
	 6fvKkpZfblQHJte5tj5UgRXr0BbkaTczjOE7uNOqE8lYnMQLO+4P0PYPd8QlulK+0v8g+
	 9OWPw3ikCz/PyEmIyNeZeoLgsRyt5QY7DKqITLoXjxReJ/KC6Jf5h+0ODSXuK/q2HtUFh
	 efQmb3W8fPm8B6WyWCXRfEmjAKlhVK7am8HhP5Fa8BxcktpyufUDdlxQOvQIHvTGLdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wcw0ND+GzCK33jb32w8A00FDx0OWOEPXUg7F9W5QCHY=;
	b=DP1wFM/Edc1uQULykh/S6pghysqtrruP4Dh8B3ECy2tx27fzGtXQmVcxmytc/QTyYASh
	 Pccu+L8OiWssA176zPm2laUCcz8eitP+rwUYWXIW0vPlLGReM9d45bVsSp8lJCL0v6zv9
	 sXWrZAXaP3WxXsCVaCXZNImOU2k2Ij8/YibEQgRf3iKWDhgVPbbagED31DcsZ/xoeEcn3
	 6/KUhHcN8Csrn7JomC4FDj2rsgblj9wJpdEMGbSJw3eo1RCfrASIPjCUS8/WZZ+jJLOSP
	 YH7Gu6YdjS0791jSvCced1D3ZNPDxqlij1IFJqKuIXYSJUxZSHBtSHwTEFvq+mNUIKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WxzCL4+v;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NDA4mbaA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D32606A333
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D32606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WxzCL4+v;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NDA4mbaA
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fDgB3320720
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wcw0ND+GzCK33jb32w8A00FDx0OWOEPXUg7F9W5QCHY=; b=WxzCL4+vHkMZN1nK
	IpHOYxmmWVnEJ1NemOahvFUnVyhLBkfZ7RWwbIyO+pif/cy8xVw/yRiwT7KRWJGs
	sbo9lkSjIeN7eEiypwN7f0wQHTjr4TIO0Ybv26FDvPaTx77f85m76x1L9o8eXD7n
	exX9RTZTTXxCyPpHhb0S6aftGtXK8uzJMUnICfvHJnjX4e97wREqI/0lWzFwTcZc
	kr7ZxE5R5dnlq8pOEkxUy87A29ueKsdFB4JufOunLfi1DUDWQpEe0KZMmKGbucDn
	Vj3ol8fV704BWLW9HW2fAH9pBFMaNA/rQujoiBbCQ6Qv1+PMa+fm9ifgztZ70s+7
	jobyFg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2frhs1fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0619b1fe5so738473b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 01:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795166434; x=1795771234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcw0ND+GzCK33jb32w8A00FDx0OWOEPXUg7F9W5QCHY=;
        b=NDA4mbaAHTplyBEbOeZF18QsQIGVplHyuDVN1ypPWi3+KJqJ6f+djltFAQwWy3DWoa
         bgVBubI/Uq8U6qzAntqDk1CyJRdAbKiYhnocpbl+Vws4Lm3WkaLvsqqJlMwuL6fC1YSX
         4qs2UqDT9Sr161RxQWnEWhpvGKWU0/hMLx2+BbyeKWBqkvqKa/W4YRv4L8KC9BN0s+qN
         nCI3iy4mQkKSDgqaxWvyC7N121RcWGdZp/7Ogt36LzSzAmdLamxpJt/O1MW4pvds/W0i
         gCZ/31i1rV5szC9ZZA8SuqaD7Y+UVOR2XWqxkmHW1ihobQU22i2CHXKkUishFSUuw/BD
         qfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166434; x=1795771234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcw0ND+GzCK33jb32w8A00FDx0OWOEPXUg7F9W5QCHY=;
        b=cOH4/W5q6zusdJywY0q3X4gTOCN7xlE1y8mgD9xdbWtrdFcEkVrWgQJ7NaYjHQ6B1+
         n+IOs6eiVtwod/128TbwlOXwklwUTGynGg6JdZzrR2AgOKT3MUE+4rs91FHvCJCvjNyt
         fGIURMEWvlI42g2USZMIya9PzxmvtppH3aC7a2jJIRlgZJ08qbB/Q4qSGNiQ3WkvqxsC
         yvZJh82z/lxcK1aUTnt6U6KeKOkuz9CJtCiLw1wulHWOJ0s4PCFwB6dbs82yTnoe2cFK
         ElzAtiTNHkH1m+zEykLKCvmoH85LJtjxrqfoMkkmoOAo05RXi/o0AarfcEN8He3bDf2l
         euOg==
X-Forwarded-Encrypted: i=1; AL+hErEX01H1qpmmE1VzHPxzAyFX4ml5yc28HBeCeVOMs9VvrjNU+KnsIr9C91jmrSpdtgzyj/TMCdA/BQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/gwdTleNlr7p9hvf5RebZfo6w4/NwcTv9I4YgEBDHkrk8usWS1
	rv+lW/LN3/80XNFzOOsX5gKuhSrd31NG0pof6sfIV9NBGkwV2ElUdOeUSXkAIksONJcoHUhaYdj
	gxWxnRq+Fcm4nS8lzEl75ZW6ehTJAnefl+o6D3H8qPZYYs/UpCTA6irYiiGqX6A==
X-Gm-Gg: AZFdTZdWrAQCbR9gXWjbwwPPn/pNBlozjfu5bmk6mJJEPN2H+ErmTyvggUibMfZq9O4
	cIiGZkR4waHNGC7OMnpvpGgjrFExcvbRJGA/Z+Ufca08tcSOcFcrKu+YO5TNba3PX2Lc+0t1dsG
	+c1KqGO37FOlVkXL41pXbsOa4KsA9rHI3PnH+rXsSo8F46E2GK4GlvIcoVno1QuYwV035CZjdCn
	5TKuuDZQBbr6SZ2LCB+tiE/edTA9UZri/bjW0jNS5y7CUMqA7rTi3LxOUZO/dPktDVzihQoUTey
	qIzbhvXtazGcVL4hYJT2BEpu3cdVrClAjGTcpdIo/vVHG90YJo/4NgTWstZtKSd+ciCHTUnCbaJ
	zzHxIp/RHVLESyzMD62Ffbl0DgT6aUqpMMnedodTuOIHLIyjyXjf4h9i5+YE4sR/gZvg8
X-Received: by 2002:a05:6a00:b86:b0:874:705d:f63d with SMTP id d2e1a72fcca58-8c87c38b5ccmr2207856b3a.31.1795166434454;
        Fri, 20 Nov 2026 01:20:34 -0800 (PST)
X-Received: by 2002:a05:6a00:b86:b0:874:705d:f63d with SMTP id d2e1a72fcca58-8c87c38b5ccmr2207839b3a.31.1795166433996;
        Fri, 20 Nov 2026 01:20:33 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm1186994b3a.48.2026.11.20.01.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:20:33 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:49:42 +0530
Subject: [PATCH v2 2/7] iio: adc: qcom-adc5-gen3: Explicitly assign enum
 values used in hardware
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-pmic5_gen4_adc-v2-2-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166413; l=1103;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=OeUK1LlAVHR+3dWtPipLhOdiDli8ETGZqQ9NaC67ymE=;
 b=UOC7miGD6bJJXRuGg4fOcSL+CHhXt7dJhjl2cezWjwXwuEqSS6IRwc0GFCp1Tj67Te/sgWv6F
 tZucRdomXcAA4AttWYp1wBRsrfzAzd9bE0L0BwpFtDjewNuqKZ39Eqy
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfXxORbp4rtpV9Z
 PnRxt3TOKzqMnVZzTt181ugKO8F6JSjCJfaMYNgYlpfQboLYfiOw2b/Zw1ZSWmpYMx0LDaZdeQu
 UM9bRXG+6r1JGH3plIKpYQYHsDxC46M=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6b0010e3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=se6siFrRNr6BEeX4t94A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: EwH9Ifo5BmohR4N24ugnPSvYGmFqK2PR
X-Proofpoint-ORIG-GUID: EwH9Ifo5BmohR4N24ugnPSvYGmFqK2PR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX9LLObwHaDcGB
 Wa8XBEQLRV19+c7Z8zSIqtNp0t3t6QiiPxGFMGiELMiCbQJtLCe5Y+sy8LRAIF/GvNb+eP9X1aF
 R2eeEkejGiGSDbWebQ36uswznYLiE3lVATS7Wh8fSTHUVwPTTtHeVFWHQeCQXl76QKsu0yYBsb7
 cpTTSaRUqG8VPHrKV+hKNUEeSXAaavZ3w9LHLG06Wm7WgKDYosRQMQiGNbr9UlwXOZt8mZFKCij
 XD0FRDaWopbMmQZSDs+81eUheVj1iaEbOQrS6k+qfxuzeA4tBgmlcgLcBgizlftP3K/+jgs/yT6
 FWALDudF8tf0ER7NEClf5fp7B4/n7WHztI8q9Ywzt+attWzEDXdxW5S34jbbjNVy/3NdaboUFLe
 bYGBNwkjDO973ZUixtmaEwjWByhCXyBx7f/xdRe8awtxnxwnMIDMpafWTdiy3e+TsQl41wQqJ3x
 fKdKTMAOs88x8YeL21w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200037

Give explicit assignments for enum values meant to be written into hardware
registers to avoid errors due to later additions in the middle of the
enums.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index b3e2c2f50e8f..ec7238e93396 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -104,16 +104,16 @@
 
 enum adc5_cal_method {
 	ADC5_NO_CAL = 0,
-	ADC5_RATIOMETRIC_CAL,
-	ADC5_ABSOLUTE_CAL,
+	ADC5_RATIOMETRIC_CAL = 1,
+	ADC5_ABSOLUTE_CAL = 2,
 };
 
 enum adc5_time_select {
 	MEAS_INT_DISABLE = 0,
-	MEAS_INT_IMMEDIATE,
-	MEAS_INT_50MS,
-	MEAS_INT_100MS,
-	MEAS_INT_1S,
+	MEAS_INT_IMMEDIATE = 1,
+	MEAS_INT_50MS = 2,
+	MEAS_INT_100MS = 3,
+	MEAS_INT_1S = 4,
 	MEAS_INT_NONE,
 };
 

-- 
2.43.0

