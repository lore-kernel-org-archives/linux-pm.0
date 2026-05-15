Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F541B36D
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835272; cv=none; b=ad+yq8J8QE6eC9kZ6BjREQDN5cdEzzt3n43Xe8gn/d3+l5KRb4DwyYNDvntcbTuVXoqYPfNwAPRGwb/X2p9vG8swOs8ulgk3t4cA9AqKWtqTKHRe83fHmtjdrT8vKzLOEztt+bZ017YFkeM4BRNlrywPJBpBUL0UeigG7D3SuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835272; c=relaxed/simple;
	bh=YcDJyn9rIONO6oEbtZZMIm+i/fZJuEbzbh31wPgtal0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dIdRk3LDpB28Z+Eb/mC4or8xE169Rlqr87BrFFRraOdfig+ND9i+jsmJRaXEIVhqs32dUrsX9y9h615HEDxg/we459Db36qmb3y7xnNO/UPt7BL03rLAOESgvF1hMvnuRsOonNVEXJGkZCp/ywEzk3VR7jqvKoQhfJQAj8sA/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q4MVX2Zi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=el2IAV6P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q4MVX2Zi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="el2IAV6P"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F51w1r4008229
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=grC1NjBQw/UNNMT02lFWEm
	BvNqc13klCnISjYjkt/04=; b=Q4MVX2ZigxHHw9Eur8m+4juOSjENPWNv9udcJB
	vgecJzsV17TxRs/Unk5JtXyUfkkE3HfutABiyipy7g6J7uBc7d4DaSa35+vOKe9F
	4LojAUo/74SNB6C/uZYPsp5uhWkpmR9B2l1IoVtEkWqFd4Fd2XJzx+cOqgv9q2DK
	BHAUOVbucyhBxiPLe4c7y6UgHch3GfHkIvJJN9BYieiWT0L1ELKzPRlItfb/GM2U
	gJ5BWmpKWdEC33dc2NT0ZkAame1wyw2Er4VwWbTL2jfJGlgfiRr0XHtnIM9Ub3pE
	OYcZjjhfp4RIiGPxD+ca2ZrkwLp1g2/FfgVD3mkqsWQn2DGA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1stg3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:54:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso4707619b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778835268; x=1779440068; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grC1NjBQw/UNNMT02lFWEmBvNqc13klCnISjYjkt/04=;
        b=el2IAV6PcBFJMaVscZBttOY3OVMEY72hBdbfYH05O/kyKuhtdKzlZGwdv0+UnL0UcT
         cSJt6Ibz9dQA0M2qK65mbPVjnzRKOwA5RNCDkbmZXiNI+VLR+LRI8ueST+YjpYJRlSIX
         gJv8aKhSNj3IOmc3BCfN0Yqw4GxJ79gxkxp59x3hGc85LcKmQENGzq7Ws6E5ma2+wbyP
         /RVtaJnGRsXm6KVBmK4f/o1em1gwQYyYg8OZVUDdes7B73X/Cw7xL+JA74UE0mXHgTHk
         enY2Yy5mk35jrksY9Gww+NOf+zSyhK/g7E5maUUuBHCdOg2KPd83mreIk/upLSSBSivq
         EsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835268; x=1779440068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grC1NjBQw/UNNMT02lFWEmBvNqc13klCnISjYjkt/04=;
        b=WAj0o6yH3ChyyBgDU0getqM3h4IE+kH4ruUwYUprqJrLpX4Olbda2fZr/VOW5dCcuZ
         lRfNUYDsd2h5fFIpsC3D5ycITa9kEsfskrnwNTIc4RYc7G7y6bfWF0k/1Otq1mZ3Qbre
         EKZHxbfcg7+IliSxRCJggmS/dadIHSGZRfrUrLLXYwBoTfPIdREjUEFsjdG6LqOBlm2z
         cL+GHiEkcCGxdlT6BiGCRyCGniy+vXqCxGpy8nhvh5HQ9hDyqmuTowHbslOf1gKYIWfv
         fUSLKGTayLSD+LC030PvSyHOlDjFvt+IhUWYIQJEqvie4gDzZU8pvm+AwTyuZiwIpxhk
         MxKA==
X-Forwarded-Encrypted: i=1; AFNElJ9LnIHz7Ra6a5UqGjS1mEvSZzr7rRgdf1LrkA+t50RpCv8/KMcJNPxZafptlgo3noog9T7u6OnxGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGYWg1prI1eb+Wpz3PG6zno96k90RZ+SZ/efUILhC6Io+agcf
	sCiT7XH3r3/4vWPAZWYFkrGFv159JPTEy05TnuAnRTEQr60W/kf/Bf2+Z8ZqkKtkBwd2Y37Bbdg
	Og8kpqxI0nxry1HFueT3LlEtv9ov7zW7c/YpF3aouThGMffPsU2gtPFORUv5aEg==
X-Gm-Gg: Acq92OF6APh13O5XuiDiYIyMORyZYnGMHcjjLh+1SjbY3xQzNZz0Y/aH1xSHbHcpU57
	xh4e6cJBfVX0IHPSW3KRCLDpfAmbuGYbJOCs/DKUYqQ/pBzzanDUFMK8JtB6urr2b4WaXj4Uo2F
	QNOQV8qTboQa0IVmy4eEME4vxlwKO/4PA9AReXQ5x7h8conTk5Aby6LWzRJA9io9NL6L+o0fXhD
	CwuxrnzWKfo5Fy2XJOKlIXBAmhuXRvqGVKSUAlmxjKzu7gheR5mtDZ0sgpIu3uKYoq0GFNSTSWe
	LZCaVq4HGhNp41sesKnXtnl2Hw6hv9617ysEuBQB73CBOIKkP2ucVPNwm+VM4JrISN28/XEXhgl
	eAksY7RcgixgpzdvZSX6xY8WsOlx8KhOKJLdChYKY
X-Received: by 2002:a05:6a00:e11:b0:837:a211:4ed0 with SMTP id d2e1a72fcca58-83f33de8025mr3411622b3a.41.1778835268440;
        Fri, 15 May 2026 01:54:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:e11:b0:837:a211:4ed0 with SMTP id d2e1a72fcca58-83f33de8025mr3411588b3a.41.1778835267924;
        Fri, 15 May 2026 01:54:27 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc9asm6766426b3a.53.2026.05.15.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:54:26 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: [PATCH 0/2] thermal: qcom: add support for PMIC5 Gen3 ADC thermal
 monitoring
Date: Fri, 15 May 2026 14:23:43 +0530
Message-Id: <20260515-gen3_adc_tm-v1-0-39ba29f9b4ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABffBmoC/yXM3wpAMBSA8VfRubba5k94FUm2HRxltCEl7264/
 F183wUeHaGHKrrA4UGeFhsg4gj02NkBGZlgkFzmPBMpG9AmbWd0u80sFdxoVRYKcwmhWB32dH6
 3uvntdzWh3t4F3PcDa63o6G8AAAA=
X-Change-ID: 20260514-gen3_adc_tm-410dcb98be62
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835260; l=4001;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=YcDJyn9rIONO6oEbtZZMIm+i/fZJuEbzbh31wPgtal0=;
 b=EdFFv+r7ozQuSWPgFIaH07XU6vJL40Cl2BfHlbCQ/AhY9cU3/U9YKg8t3fLlmMYUF+b9+TBII
 YXiSeuHwEC1BiMhe1AZ6MqtndodBW26cqoOYLo5KyENFYkZfN+kK62P
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-ORIG-GUID: _e28aU3RgTj8wJZCeg8YqREXZ-yrZDn9
X-Proofpoint-GUID: _e28aU3RgTj8wJZCeg8YqREXZ-yrZDn9
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a06df45 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8
 a=t6WtGzA2ZKrDIJVor40A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=IawgGOuG5U0WyFbmm1f5:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA4OSBTYWx0ZWRfX7vd/G9oWv8gg
 AL4tAQnRojlUjBtoZEObEj+dJ0GAXjfpd5t6+RTE3HM1LWvCm90caGg1KepNR5R22UFWGnTS0AP
 kGGmt398ZKV+2iqRdHiqgdv7MiITsAChusCKGk9LJ1rTo7p+PiR20+dg76dUpbdcIXX8XQgRF31
 paFYQGUL2EBkLmbXsT8jOz82NDUX/D/QAYZRlMY88qNajekS2G+07bAbYbWZfrEcNHR5i+xgCAp
 ZdeBEXWW1VoFs7MSsxNKyOfTQwnNr2TGRP2HsA0VnyLE2tuNjp/1f0zkt+JIkLWFiSpg0kwxnl1
 BWgfYkpOKbQTygHpwi2BHjLMw1eq5JifcUvdC3ynk0wSBvQiU7a7lI5OqxidaHqpbx4Q761mraO
 S0sQWIwKAJttX43aNC0eTG58+fG/FeMcVfyb1CuPW1dxC81SeUQFJOXbsewB2/CCXTsYuzTDbt6
 f959PpRu8fTEpwNhE7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150089

Support for the main PMIC5 Gen3 ADC driver has been merged now.

In order to complete adding support for the Gen3 ADC_TM auxiliary
driver, some more changes are needed in the main driver, mainly to
improve its shared interrupt's handling mechanism.

Patch 1 simplifies the interrupt handling in the main ADC driver
by declaring the interrupt as a shared one and dropping the logic
used to call the ADC_TM notifier for handling ADC_TM interrupts on
the first SDAM whose interrupt is shared.

Patch 2 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Link to previous ADC5 Gen3 patch series: 
V10: https://lore.kernel.org/all/20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com/

Patches 1-3 of the above series have been merged now. Patch 4 received some
later comments which are addressed in this series.
Patch 2 of this present series is derived from patch 4 of the above series,
with some changes.

Changes since V10:
- Added patch 1 of this series to make the SDAM0 IRQ a shared IRQ and
  remove ADC_TM notifier, as suggested by Daniel.
- Made following changes to address Daniel's comments on patch 4 in
  previous series:
  - Added IRQ request call for SDAM0 IRQ, marking it as a shared IRQ.
  - Split interrupt handler into main and threaded IRQ functions.
  - Removed workqueue used in IRQ handler and its cleanup, instead use threaded
    part of handler for same functionality. 
  - Removed callback function exposed to main ADC driver for TM IRQ handling on first SDAM.
  - Removed workaround to capture temperature causing threshold violation inside interrupt
    handler and then return this on next get_temp() call.
  - Removed all error prints in interrupt handler and updated return value to IRQ_NONE
    in case of errors.
  - Removed explicit check to disable ADC_TM channel in case of (INT_MAX/-INT_MAX)
    high/low thresholds being set in .set_trips callback.
- Also addressed Jonathan's comments on V10 patch 4 related to header file inclusion and for()
  loop iterator initialization.
- Dropped Reviewed-by tag from Jonathan on V10 patch 4 due to significant changes made now.
- Added a status clearing register write in adc_tm5_gen3_disable_channel(), missed earlier.
- Moved cleanup action to disable ADC_TM channels in driver probe to just before IRQ requests,
  for proper utilization.

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Amit Kucheria <amitk@kernel.org>
To: Thara Gopinath <thara.gopinath@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: David Collins <david.collins@oss.qualcomm.com>
Cc: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>

---
Jishnu Prakash (2):
      iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with ADC_TM auxiliary driver
      thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 drivers/iio/adc/qcom-spmi-adc5-gen3.c         |  52 +--
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 437 ++++++++++++++++++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h |   2 -
 5 files changed, 455 insertions(+), 46 deletions(-)
---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260514-gen3_adc_tm-410dcb98be62

Best regards,
--  
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

