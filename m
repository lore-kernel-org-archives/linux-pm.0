Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7947DFB2
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847090; cv=none; b=Ltgk+1hprxB+7oTaCZ3S9i5GG4ZJgKy+A6qmT/9IGxfHV0Fpt9DdMYg7/xdEAI9MRYVGaz8X0YbpMAhLsA76nTO528swjKnCedDjdql2QiW1CxKyATSV7HxFIkRav+u1fDxkt3frjupbqPEcOw15cmJSoyLZ2hYQx8ZnevrI/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847090; c=relaxed/simple;
	bh=QgA7hMYiL0NMPsaE7GnQwbdQ1ORYkk6fa/nxUYRNjRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3iD5PwA7mcJCstrZTYVcDOHq/VNdBoQUA5vG76MfccmNM+FdeN/A6IOAodtiISQo7naxSCoO9pZhtqWP6lduVQBCEWj69tzXYWEGr266FR2I1hqFHcrpFk4fNByPlP+xJVGpzXLIXNtveGKEO17PtMFLJYqtPsFa+ENmMbpDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J2p6nPE0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=irlh2MLJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J2p6nPE0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="irlh2MLJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBUdUL3797373
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ke2yn2K1eROwjLrYWp2XmHA3NXmS/bE3CBs2p+d3EKk=; b=J2p6nPE0+nzklB5q
	NzVlRFJ6hfaO83Cj0KRDLwQQjWSPmqRB3g6312Pi4ESwJ05JM6gzuYsbRasQvp1L
	WnSUJT0zjGHPC3Ef5fb6QbE2TM2c3Kxd4g5VQkzWcuZ25kwC8NYs8PNV750eZdIn
	/F7WSDJ57BTnr3xSlY09Q+TWMBs38j/aD3e4ZgXITWcwxowCYvHf7WKCn2ow4M0y
	0VH54sYlFgRs3sZnznKRMDw5zx7Pj5cJxNnkx65MvmSAw9IxXzEnoiANJB7uPjol
	f1brdLNMwi9a2AV5/MqG6pwqDi9vIjDYaAkQvYw17vGt8aKI8QZVYJq6iNltjZCc
	m2a17Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1su45t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:11:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-63136f3c5d6so10378777137.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778847087; x=1779451887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke2yn2K1eROwjLrYWp2XmHA3NXmS/bE3CBs2p+d3EKk=;
        b=irlh2MLJ4eoAL37PlRwBUTttqvBLs0hbsP2fUvYy+eSw+AQCzy100iMYgMPjZi+KpN
         sx9s+nY4Qlhb6LEbqJ7wk3wgw5KjsVMRxg0wyA6wDy5HrfEuSyNN5ROkjysFqQuP8zY1
         dFBPHXdtZ4m0u6xxlQmymXwhX+Vcuo0e6jtRqBSaW4Df0eY/IstpU70JnrpBuNznr0d+
         MGeZgY4vEzPaepF5NORh1uJCuPGR7ST0FUgOD15u2VCqt6Td6zusvO/5rBR1R/QpKSLu
         Un5fvydx/270y9uPD5rHHoB4x3LsO7eAQeqnl9I9+VQlYVHY0S3hdpUi43lJRlNDbscS
         krTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847087; x=1779451887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ke2yn2K1eROwjLrYWp2XmHA3NXmS/bE3CBs2p+d3EKk=;
        b=bNodg6+CJj5KoTLhYuX4colnaDJ5x01oLMLDJi1yWnrrpwQ2Pqj2woralKmlYBht9o
         IqybaDGsWY3ntBjpMAUmmluzjvePcDsBZaQjXsV0kjBw5kJ7DAMED1eWof5N/ZThEYmf
         Zux/kjjrWfadlGr2LEbJkSCcxL0YoK0EBBQ43L7bX6rrS/eoITy+W2YIBxfrVmEZRrIB
         COmZ+SOfNrgK/Gxe6I1feNSDFcBaykvc6hjSyix9LYXnAp62X8bnEHGb60oGrfqmF0Fl
         qxEFJzmYKXmhYvxtVxJ3Oo8RIpE0YriscBaQdHv9bq5JB9dalWNqKDxDbC4HvFfw5836
         OFdg==
X-Forwarded-Encrypted: i=1; AFNElJ/r9y0Bg8Jy6DVG3EBzX7Y0LdB9ds/mleVaUPy2/oF6ndhiTjRlSLoR+LdDXDh+beDU8tW1SykIPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNO6VebIWoYAnajxnBFGbRG5gPinQH6/0O9GeBjV9Zb1twypU8
	N/fcqhWcXRl4h7yIXLjAl2D8SFeTu+g26+/wOkJD4pKrDL1W5UcGG9AQ6/tqSasNPKsPooek80K
	CIvwYLhyRG5T3fVQcScupNiphpU23E/o0AMDcLe5B4TiFPlavoQHG0bDtU8roeg==
X-Gm-Gg: Acq92OFKN0zJ98OOW9liD6l3/4qXHVJRNaQasM9mjUP7ZI56Cw29IHbU/8IblNpeeeT
	3QxUvK7l/nTcqtLGq9YlO452VHdm6Am+bdD4XfkqJrJqDf76MCg0Gl7Y5OKkMcVrjQiRnywGbos
	rx4qDvUn8SMvHcvCs9EtrqVaf+XGrCxYxG0f9Qvtd9eDSGQyti/LNDRwxj5teQkHwXYA/1Y6mXJ
	Y3HdB4azorJaTYYF4t3odsuIbPy5G7iL1kbcGmbaaS0Uzsiwf0jHbtXv22Ie+OYN4XoOVsB1Gik
	zf6IVKPtA5DwvBDKy9GNY4ZH4aBgaLjMocmW48ApHeTK1D6LHTh6L7/l1zH9HT5OfaGBRDLv/Vj
	iwkSZg8UIdyWfiMNpif1VYXaaUtBkBTifY+Tg4aUeXEyi
X-Received: by 2002:a05:6102:5124:b0:632:78bc:2bdf with SMTP id ada2fe7eead31-63a402a06cfmr1906466137.31.1778847086560;
        Fri, 15 May 2026 05:11:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:632:78bc:2bdf with SMTP id ada2fe7eead31-63a402a06cfmr1906399137.31.1778847086091;
        Fri, 15 May 2026 05:11:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm66855685e9.7.2026.05.15.05.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:11:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:11:07 +0200
Subject: [PATCH v2 2/3] interconnect: qcom: Restrict drivers per ARM/ARM64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-interconnect-qcom-clean-arm64-v2-2-adeebc73596d@oss.qualcomm.com>
References: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
In-Reply-To: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12464;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QgA7hMYiL0NMPsaE7GnQwbdQ1ORYkk6fa/nxUYRNjRo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqBw1npsbr8ZOHtPi/gl9depJd8N3KTPfiKErea
 cI0MKkkRcWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagcNZwAKCRDBN2bmhouD
 1/1pD/4tMP18moI/MbgsQCAhK8AlatLsWMctQGZ3EVzH06/2AZb+VOpNzeKE9SWpLpxY04eFZEn
 5d04C1VHJ6cD7CQU+joj/G3gYGSTtxEGRr54eInTb7rvyQ8cZWkMM177B1/zwwRO8GmMrCs9K+/
 eKAgUbJXNi+QJHEM3HaX+oAeqeHXlgIXi+pOBH0TE+UTZHb5uaAPQq6zrkq6QYrVz4wxy4gfge4
 q1Hu8G+MJaxUkNxQTG/4QKhIBXxZFJj87hYTcyp6U21sfn9KmnifF5kya/uOc8UT22zQ7FWKKtw
 s55Vt37PDjYX6TwlSNBbtNswCYDkV+hzQdRS4GTmv4DOmuhfVyI+dTC8sEkCBHthyybEPTmd4tQ
 S5Ftb/hofUKTOXi0U27c2xuSKGKTlUh24eYegCOruOlGIlS/yK/hWduZO9oJMOfgQ2Fp5jSxQUN
 dPzxNLGQIHkM7pZqI82kg5/0oenQUKHzL/22UylIGgU6LE+P5JvQa9Enh1tI7OwaSl0Xm2x2kn+
 zVlEb71HmxWKKS27vv890WoGIzS4o2y2mQnnHjisIYKsIhnXNasvr0VZXdVCVTJ2nVIeTKpDAB+
 cvsrXCACySQbIHnrI9qiPG5Kl/rwrKrCIJOb51gbyaJqUutO8zu5gCF1C5AVIkpiVku71icGD9j
 60SlthUuURF7wzA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyMyBTYWx0ZWRfX/8DHADj3uN8T
 /mELpvwZS1hhNQ80n91lPnR2ag0vSVetcHDMnuf7UNKjPlxqz/ch9vRBqBwCT400HzHNxlQZ6i9
 5ojFzdzTtLCsjK/bv1yB7D8g70rhWQqX+E7uCbdMDALtfZodEIaAwW/L3jOkU9SH70az6KH2Tac
 7vgqPVVM58BaKf4PZelLxgSAWvJV9g9D2p53vQ5iaURuw2i/Jgk5YVUH/5GBBrf+oQaE0a4wGCr
 4IPwJ3rRFniA5OUcGv/CZaqei18zDS2HFDS+zp7KJuPM/PUZ+Z5zLh10pFz++omsQBOaeanfuDz
 iU0nwU7r3kB/3R49LVkaNRncebtD3/cMR1LmrAJgplBTq1STPK9w8OKY0l6bpx1QEIoDcGyZcOu
 hEnUBB/5jNuAgI58gROvBYRe2V1zeutQxXe0+mjY0g9YYfGnu0HXSqnXO5aYlxFg+cXvFmh5tlR
 YxpBmAdMz1T40hubyfA==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a070d6f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2cCFUbKDXYVN_WJ3cWAA:9 a=dKjGhJZ7t35VoLMX:21
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: gRbY54Bi3-r4YdYjdSIEH4G80T686Q31
X-Proofpoint-ORIG-GUID: gRbY54Bi3-r4YdYjdSIEH4G80T686Q31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150123

There is no point to allow selecting core SoC drivers like interconnects
for Qualcomm ARMv7 SoCs when building ARM64 kernel, and vice versa.

This makes kernel configuration more difficult as many do not remember
the Qualcomm SoCs model names/numbers and their properties like
architecture.  No features should be lost because:
1. There won't be a single image for ARMv7 and ARMv8/9 SoCs.
2. Newer ARMv8/9 SoCs won't be running in arm32 emulation mode.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 871663bfd094..b2c4272ae48f 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -11,6 +11,7 @@ config INTERCONNECT_QCOM_BCM_VOTER
 config INTERCONNECT_QCOM_ELIZA
 	tristate "Qualcomm Eliza interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -20,6 +21,7 @@ config INTERCONNECT_QCOM_ELIZA
 config INTERCONNECT_QCOM_GLYMUR
 	tristate "Qualcomm Glymur interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -29,6 +31,7 @@ config INTERCONNECT_QCOM_GLYMUR
 config INTERCONNECT_QCOM_KAANAPALI
 	tristate "Qualcomm Kaanapali interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -39,6 +42,7 @@ config INTERCONNECT_QCOM_MSM8909
 	tristate "Qualcomm MSM8909 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8909-based
@@ -75,6 +79,7 @@ config INTERCONNECT_QCOM_MSM8953
 	tristate "Qualcomm MSM8953 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8953-based
@@ -84,6 +89,7 @@ config INTERCONNECT_QCOM_MSM8974
 	tristate "Qualcomm MSM8974 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
@@ -93,6 +99,7 @@ config INTERCONNECT_QCOM_MSM8976
 	tristate "Qualcomm MSM8976 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8976-based
@@ -102,6 +109,7 @@ config INTERCONNECT_QCOM_MSM8996
 	tristate "Qualcomm MSM8996 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
@@ -110,6 +118,7 @@ config INTERCONNECT_QCOM_MSM8996
 config INTERCONNECT_QCOM_OSM_L3
 	tristate "Qualcomm OSM L3 interconnect driver"
 	depends on INTERCONNECT_QCOM || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Say y here to support the Operating State Manager (OSM) interconnect
 	  driver which controls the scaling of L3 caches on Qualcomm SoCs.
@@ -118,6 +127,7 @@ config INTERCONNECT_QCOM_QCM2290
 	tristate "Qualcomm QCM2290 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcm2290-based
@@ -127,6 +137,7 @@ config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
@@ -135,6 +146,7 @@ config INTERCONNECT_QCOM_QCS404
 config INTERCONNECT_QCOM_QCS615
 	tristate "Qualcomm QCS615 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -144,6 +156,7 @@ config INTERCONNECT_QCOM_QCS615
 config INTERCONNECT_QCOM_QCS8300
 	tristate "Qualcomm QCS8300 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -155,6 +168,7 @@ config INTERCONNECT_QCOM_QCS8300
 config INTERCONNECT_QCOM_QDU1000
 	tristate "Qualcomm QDU1000/QRU1000 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -178,6 +192,7 @@ config INTERCONNECT_QCOM_RPMH
 config INTERCONNECT_QCOM_SA8775P
 	tristate "Qualcomm SA8775P interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -187,6 +202,7 @@ config INTERCONNECT_QCOM_SA8775P
 config INTERCONNECT_QCOM_SAR2130P
 	tristate "Qualcomm SAR2130P interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -196,6 +212,7 @@ config INTERCONNECT_QCOM_SAR2130P
 config INTERCONNECT_QCOM_SC7180
 	tristate "Qualcomm SC7180 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -205,6 +222,7 @@ config INTERCONNECT_QCOM_SC7180
 config INTERCONNECT_QCOM_SC7280
 	tristate "Qualcomm SC7280 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -214,6 +232,7 @@ config INTERCONNECT_QCOM_SC7280
 config INTERCONNECT_QCOM_SC8180X
 	tristate "Qualcomm SC8180X interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -223,6 +242,7 @@ config INTERCONNECT_QCOM_SC8180X
 config INTERCONNECT_QCOM_SC8280XP
 	tristate "Qualcomm SC8280XP interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -232,6 +252,7 @@ config INTERCONNECT_QCOM_SC8280XP
 config INTERCONNECT_QCOM_SDM660
 	tristate "Qualcomm SDM660 interconnect driver"
 	depends on INTERCONNECT_QCOM
+	depends on ARM64 || COMPILE_TEST
 	depends on QCOM_SMD_RPM
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
@@ -241,6 +262,7 @@ config INTERCONNECT_QCOM_SDM660
 config INTERCONNECT_QCOM_SDM670
 	tristate "Qualcomm SDM670 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -250,6 +272,7 @@ config INTERCONNECT_QCOM_SDM670
 config INTERCONNECT_QCOM_SDM845
 	tristate "Qualcomm SDM845 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -259,6 +282,7 @@ config INTERCONNECT_QCOM_SDM845
 config INTERCONNECT_QCOM_SDX55
 	tristate "Qualcomm SDX55 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -268,6 +292,7 @@ config INTERCONNECT_QCOM_SDX55
 config INTERCONNECT_QCOM_SDX65
 	tristate "Qualcomm SDX65 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -277,6 +302,7 @@ config INTERCONNECT_QCOM_SDX65
 config INTERCONNECT_QCOM_SDX75
 	tristate "Qualcomm SDX75 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -287,6 +313,7 @@ config INTERCONNECT_QCOM_SM6115
 	tristate "Qualcomm SM6115 interconnect driver"
 	depends on INTERCONNECT_QCOM
 	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_SMD_RPM
 	help
 	  This is a driver for the Qualcomm Network-on-Chip on sm6115-based
@@ -295,6 +322,7 @@ config INTERCONNECT_QCOM_SM6115
 config INTERCONNECT_QCOM_SM6350
 	tristate "Qualcomm SM6350 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -304,6 +332,7 @@ config INTERCONNECT_QCOM_SM6350
 config INTERCONNECT_QCOM_SM7150
 	tristate "Qualcomm SM7150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -313,6 +342,7 @@ config INTERCONNECT_QCOM_SM7150
 config INTERCONNECT_QCOM_MILOS
 	tristate "Qualcomm Milos interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -322,6 +352,7 @@ config INTERCONNECT_QCOM_MILOS
 config INTERCONNECT_QCOM_SM8150
 	tristate "Qualcomm SM8150 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -331,6 +362,7 @@ config INTERCONNECT_QCOM_SM8150
 config INTERCONNECT_QCOM_SM8250
 	tristate "Qualcomm SM8250 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -340,6 +372,7 @@ config INTERCONNECT_QCOM_SM8250
 config INTERCONNECT_QCOM_SM8350
 	tristate "Qualcomm SM8350 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -349,6 +382,7 @@ config INTERCONNECT_QCOM_SM8350
 config INTERCONNECT_QCOM_SM8450
 	tristate "Qualcomm SM8450 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -358,6 +392,7 @@ config INTERCONNECT_QCOM_SM8450
 config INTERCONNECT_QCOM_SM8550
 	tristate "Qualcomm SM8550 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -367,6 +402,7 @@ config INTERCONNECT_QCOM_SM8550
 config INTERCONNECT_QCOM_SM8650
 	tristate "Qualcomm SM8650 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -376,6 +412,7 @@ config INTERCONNECT_QCOM_SM8650
 config INTERCONNECT_QCOM_SM8750
 	tristate "Qualcomm SM8750 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help
@@ -385,6 +422,7 @@ config INTERCONNECT_QCOM_SM8750
 config INTERCONNECT_QCOM_X1E80100
 	tristate "Qualcomm X1E80100 interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	depends on ARM64 || COMPILE_TEST
 	select INTERCONNECT_QCOM_RPMH
 	select INTERCONNECT_QCOM_BCM_VOTER
 	help

-- 
2.51.0

