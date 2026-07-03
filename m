Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6B412296
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091144; cv=none; b=mJ+jZpQvUZF5g6Qp3S1Vl9rE6PxPxTc/PAw5VKCenVK2+5IxdXZE047a72+QhI2jJnGEzqUI4NUCUVwKdJ+Maddtb86UOiZ6PJ8bHQPOCu/8leWZ+l2iKztF6dTMcPYdnKuPr5SYsNdMyU1XY9IinLU3L4HiRe2wsJfQioqbI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091144; c=relaxed/simple;
	bh=2JNfmkrDXlzcvSizv/iAqx3lfl6qRnhrAE7oNNSShdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rz36TenZNV+Xq80GABJZVlsLXc2RlDj0UC7oD+952C5CK0R3XY3zG/bOE1nxThL/he76Wze6zIsaMFymxplhOkNtqw15s4HpCmSvWCafkeIlf3X5wWy+5hgPXd7Qemw4Se/zpD7zhCW2bJ0vfk8xOh9NeItnNpNtgRNkE4dGbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SsieaRLS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bJoQmGSc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SsieaRLS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJoQmGSc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BRrh63136151
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 15:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ymd1YdLxXbtUH6VcGFjA1u
	H5awiZ4CUoXHPYrby/Xn8=; b=SsieaRLSdLfL5RPxXFNoz3G7Fi5vTs89jcFp9X
	SVxukLqjMdIjzIVFqLb4guYkqH+n8vLqw0AGn76wq+8aNl3dd2F7YslNLdmlLsYD
	6UqO1J2QCwbvajiWhDg/MYd7QCbB4w5UQz5wv4YcgWtWxE69ZXyrMfuMFEeZSBW+
	SuDBuDYBqecyQcAmBoCrZS4Kf4XDolaU4tyFj/NKtVff9vvthwUm8KPjpKI4aGUc
	tweI4b/7DpPxNDTy3WOVxlx2AqnFAgDRSM3YBQXl6nV1WbZMlbgMIkxaQJt8Tg7S
	zgT3Ctcq2Z476NgHGIjXiNDMRDCktTRxpsSPQSuZPZPcpT2A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5aund-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 15:05:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so1032209a12.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091137; x=1783695937; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymd1YdLxXbtUH6VcGFjA1uH5awiZ4CUoXHPYrby/Xn8=;
        b=bJoQmGSc+z8BROsLUj/PwOcukwu+hUmtv/msTc4jenLId47YQELuxzyQ65QN+YtNAY
         eqvGihzS9Hmx8zLx/SE4jONtSEJ0D/oA4Y+Z/ECxRVO9vSCjMisHCFMQ8eQXv82aKjy9
         4/PVVTu6v5G8Qxdb/39BDF7VuHuXQdkplK7wtPYMNXSppZvkt/JuARXFvwN7zrxjs708
         FX4t3PrJrt1rOrcyNVvwpzWWu2FWigSAa09tpEQ1fDB744LWeSFcvlT0AYyBOy7AxOPY
         vUOcSuVwIAkRgDKeWp0CwTd4K59PnXaKJDJixCWtrwDdgsdkrS+4DjsMFsHjp2YuOqsa
         RL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091137; x=1783695937;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymd1YdLxXbtUH6VcGFjA1uH5awiZ4CUoXHPYrby/Xn8=;
        b=FtYbGt3JBM3+DUP6lNasMHzROa7DdpplkRf1akYkluwlAjQDx76b3BenNOYr9s4iq7
         7042h+NKcjknp1TnH919vUPhZd6Zq3G0wEKwjn15ragQXJNm/ewTyY9jKKGnRgqnUoEL
         x+V217176WQSpPNh94xTWvd26YAxJRiO/BfPbyRioPJ5qMvd5rZkSWRaXS2Q3zXix06D
         jgJ+Xqw7SKgwr9Ku6J5I3pDQEBCF24uxk0WDv+FmNbBm+SbDFbFuYPH28NtA3c5EpvUq
         NuPbLqCA0B1oB61dHpyBnH8Bge970Xwkya+FsZu1LN4iDOgbEPDCCciyY9l3DFGiwZdZ
         HqoQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Kx6B46GrSXsK6Yepr/6dzLJKQbFgMHMMNZ/Oq9AU0C/psao/EPxX6A6Jqu9WBF7fLlFRczgdIKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUn68b3RLUbZG7eAlBIOl/Xg3VIIiqYV89VI+kgVjhnNG0+6J
	o1wXlYfMYZFEtlrspkM2uQA4uwrU4leEPBsT4yuvxso273awsMbUB2E/4jewfpJ5pE/35Pnn2OX
	60qleff6mQGk9r0heGrAx0YO5GcG3uZiYJMp1ER/ryS0i+vVqsefKSF+qu0H90A==
X-Gm-Gg: AfdE7clj99mtywQj1Itpmvd9jC+IIxLkq9W4Ld9lLQTqCYeJd5dylBMIKKPwBD9Linz
	XSkTpEf+3YzPNQowBx+ac/smpA13SLjh4cXHWCG63VY+EF0fNf6fSddhXVoGr+j0NBJr4xjxV6e
	NZImdO106klhPhnLOe1/BozSzIPZSDN57vYnRm1JzEQkl16MTw+9mTJFnz8nGkLxRmQyjbg/mF5
	bJ1bYCOSfhREsvrZ2VUTljASXnyLRBws1Jb4dmVaOdBTP5lrBvBl5NaQf9FrW9Rh33k2CPLIQUs
	AkH9qKcOneBVaSZKPhc9WrelYhTHhCamV0hfZ+PAaUmk5PtFNbUXaZRvz9sx7i0sv3BeUHrj3En
	2o0pJBN4u6XX2hYIySm0s8MVJytr0DwSbTnGKEeS1ubUE
X-Received: by 2002:a05:6a21:48b:b0:3bf:d1f9:b1ca with SMTP id adf61e73a8af0-3c03c6320bbmr216506637.30.1783091136847;
        Fri, 03 Jul 2026 08:05:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:48b:b0:3bf:d1f9:b1ca with SMTP id adf61e73a8af0-3c03c6320bbmr216464637.30.1783091136224;
        Fri, 03 Jul 2026 08:05:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm32904517c88.10.2026.07.03.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:05:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Fix sticky -EINVAL after resume callback failure
Date: Fri, 03 Jul 2026 20:35:19 +0530
Message-Id: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK/PR2oC/5WOWwrCMBREtyL5NiWJtkG/3IeUEJNbe7Uv8yiW0
 r2btivwZ+DAMGdm4sEheHI9zMTBiB77LoE4HoipdfcEijYxEUwUrBA5rfCrfEDznhQF7EbdKF0
 FcGpolYtdwBaUHlBVGpvogBbyIi3TuTlbRtLq4CBNbMZ7ubOPjxeYsGrWRo0+9G7aLo187e12y
 cTf9pFTRgtrzYlLxrlht9777BN1Y/q2zVKQclmWH3hXCEsHAQAA
X-Change-ID: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091129; l=1942;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=2JNfmkrDXlzcvSizv/iAqx3lfl6qRnhrAE7oNNSShdw=;
 b=wa/RbKyRfhqoKsEoOwy7Ku0Vy+5t4iXcub3dAWFoKrRUmmipC9chaycRNK38K1GiPTvt9gmHl
 FwNxT9h3k/nBTbI2jgcva0bENGK4CpDSOex2Lx0VQA0gLGMfefVLhCd
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX2FiNcpGv0i8R
 P4DYmt//j0lKUAyEY0wT38gx+H830IjTDoKsvrbp/+gr+xydMSW7/+QmUOrp+WfVWZIYqFP7Flc
 82s3gHsU21txKiu5mlnwyQyq27sznJU=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47cfc1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=4GhjkeDSICfBxK9jGEoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: fhpNJ9iQIX2YNz4UTpOQ_KKI_AIKDfy6
X-Proofpoint-GUID: fhpNJ9iQIX2YNz4UTpOQ_KKI_AIKDfy6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX7dyhNcOaeacA
 +4J4palQ/Nq0LmxAl8dbM3dLCqn6PxGFKbd+qwehFvss+lQ6MF2WErDkrEj+dMaRmCvdhyw4i3U
 65iIygLwyj3cvqwtQzIVgHhzEBK6t7YGz8XvhLBsodGxd4jCfZvIMpczkUPP/equDcZKbzq6Sxi
 SLNpooWTcsvsAMDorFF3BB2tP4+/7kD0yX57fvklx2hsEvMDcR5cNJ78+kb9b4gNqk8F2lth/y4
 q6laGS/XSLRvYE+DoBe7zA4D3bR2hjbHDrHWF/JGzClWNqiOl6wqfRq5qdiLEV4WwEgA8IvGsU6
 L1K7Y3KRcWPypxjhD3NorHZ6wOLW2Z0z3LulRnGXFVqNHEC8CF3fjXAT1dkdPstTCpXHb4v1Xe2
 dDhGkUIcCR6+mEF/Wgh1TE4A4Ps7lyGygOspDemuG31gn0fhKWgspkNWms3gEGSIzdYigTK+mrF
 Qmc5jIM8zyGDiCc+nKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030149

When a runtime PM resume callback returns an error, rpm_callback() sets
power.runtime_error on the device.  All subsequent rpm_resume() calls
then return -EINVAL immediately at the top of the function, permanently
blocking any future resume attempt — including those triggered by
consumers trying to power up their suppliers — until runtime PM is
explicitly re-initialized.

Unlike suspend failures, resume failures should be retryable.  The first
patch fixes this in the core by only setting power.runtime_error when a
suspend callback fails, leaving resume failures transient by nature.

The second patch fixes a pre-existing issue in the spi-geni-qcom driver
that this scenario exposed: pm_runtime_get_sync() was called in
spi_geni_init() without checking the return value, so a resume failure
would silently proceed to access hardware registers on a device that was
not powered up.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Reworked the fix per maintainer feedback: instead of calling
  pm_runtime_set_suspended() in rpm_get_suppliers(), fix the root cause
  in rpm_callback() by not setting power.runtime_error on resume
  callback failures.
- Removed other patches which are not needed now.
- Link to v1: https://patch.msgid.link/20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com

---
Praveen Talari (2):
      PM: runtime: Only set runtime_error on suspend callback failures
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()

 drivers/base/power/runtime.c |  8 +++++++-
 drivers/spi/spi-geni-qcom.c  | 17 ++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

