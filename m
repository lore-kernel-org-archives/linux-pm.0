Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D8147012B
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719640; cv=none; b=Xw4NJPzq6c2fIiUFL9NagXBjQGu8GuqVkwA/HW8bXh9oU04HTCgjwxn3UjEh0uDnLsi78gFdNPyAv0am1WGzRqoj1nNfGQiWWyMoWjDW/B4Sxf3thcUgqj/ErVFGJdkd6B4Vb+jxEIID04sQ+2E6wGLakOGrO8xyYAPzjG6M8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719640; c=relaxed/simple;
	bh=SVKyB6oLGF+H5NOCIbgfu1fSC7w0/pK3jij+xHnf0d0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rK6c6iFDoAWYtd4pff1PiHFliFrcB/5bxzrovDncHtKJQ4LBzl4TwYy5YvbGRdBkT1yZjbagNAk9RUTGbyvY4An9C+t2a4wSCmdR0oSiVbCdLhOP00LejQNUqMXswo2b//EpLFJzocisYxFVlIMJNM31I3BczwKGeyyqBFFkHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfFhdKHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7ejhypJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfFhdKHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7ejhypJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8x4FV140590
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0XQFha5M4fQAb2C1vhbXNg
	Zgl9hptmLv1jFZYW4vL8M=; b=hfFhdKHyJBHdppuMjIbN2zZbng7Zdn42JC6u5B
	9enspBJYlPALLweAoTN0u+Fg+ZQbPJj8zk9C70oyHc9/apgP8clEEM6BLVo3GBiC
	SGAkjJ3nHeXw9IQIltiTxqkJxHBGnGrReNxaz/9DAepadoFAXKbVK+NMauvOXXH9
	fSVQdxU4D9JFDRv9IJusDlTgfZ/4M8DVKgrcnY6v01JEB9B1ro6EnGvhcZCpo3P2
	HrHulpudd3WTKcOghv/b+b+zZvAb7EbBeMQQiUafk4THs9x0r464b10E/f/PM0CH
	9P73HbAkzb21TNb6N0HHNJhu3szyicziB+8SCPq88GeyW4iw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2rm9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 11:27:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so244453475ad.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784719633; x=1785324433; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0XQFha5M4fQAb2C1vhbXNgZgl9hptmLv1jFZYW4vL8M=;
        b=j7ejhypJo9EzSNRQuQAJHu/wuBpHYtoi0B/cK6a+93KRhbFAdvWy3LMZx802UeOX9c
         Jj9f7YyQx5unGxR/vIs3cmtoe/FQg31RdMTcdKEg6mj40TFrRAD6sr56nzpliKK/UUCU
         ccADZ9pL5fuSZY7Y+Im4MhkWJZwlcjl6T5rjPqbyUWGR7NjHFAWlxjRcPKQsX1vBD//w
         e7qMuKKYLlqQocJqTwFPMhi0UHYH3YiCfBWOjuQl68xOwFCEATGdetskaR8Tr3xD7rqz
         HFXjuGTfvxhF1KIe4JLBr6YNpWk0BIMN5SQ3Z74NjDDMHQ5DGQmJc7F5IRJ8q7jE6SoK
         V9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719633; x=1785324433;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0XQFha5M4fQAb2C1vhbXNgZgl9hptmLv1jFZYW4vL8M=;
        b=Wvnc29xrdvkp8HAhn8Nq98MtmuLCffu/hVGcV5nbcf1lv9REBtFYryOiKYQuxNNPV+
         U6rgKIOx6pGpEd6EojT+XyYPCTySwQVO6/nr1xdWx4bwFu7wQZUI29pvjXlwxty25CK+
         Von3mnK33kYUe1fu2cyy/8R9rDGgv3lQzaF6dgzCO+SHBkWwFURoVDECeFGKaftejKmp
         XmeYanHL77B7O/uGXZNqhRX8MoXuqPi7XvL5YOnKGqh3LunPrNOi3JkYTo8M4C8fYOLM
         brhxe02DA3uJyclobaQPlFhJJy+OP5VbEOARnxPkhxYNl93b6QR509hwGn8MeamENOME
         IFDQ==
X-Forwarded-Encrypted: i=1; AHgh+Roh9N4/K4oaytHfyLRm2UWsHYGVCxCvMwzhvuYgnDksA/28N51HKQZCmDewzjSkzPF5i7XFPrYRGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfd0RlnT8m/GUS9yhtguQHGEcZs/0rPjyftT7UQQemcZg7lCf
	usH0yUUUEvFOxEBBdSGh8WbC67U8QkAunaaCT8IEE3EmJrT5Dfg0wiSrooQsljhjFEm3Lfl3Cbo
	UwySn2bW4dygCjw7ScYy7CE9c7/jChzDgk7A6kIbR9wnMHSwDEaXPjjsVfm2tTQ==
X-Gm-Gg: AR+sD12EMRlU2BQBQtRYx8p4aGuNTMjwVqOkMOaZZ5hOYeKCTVzaacZiEWYe66CpeYT
	yCwSn7ui4X91rGpvCIbQ9uf88OHZ3MYu7X/BFC3WCm12osBJvb/Gf8aLw8PSteJ/j9amBUNlpWf
	9NG+rcUHgiplUqOraABoYjHO5GJ7HkH8TYQ/BKpKS2XdncZDbvC3AlJvBwsHeF12iLtT5Ocl+2T
	5t/dq7ZwUfAaQ+aobD0gTxCVn7xYaaRNGUddmTzZkzHzAN7/hkaXLnd1SFEK/tlPKMfUDUYVf9y
	YBrk7ETEX2RP2hiS+TDcc78Imx7bv+OeFC1uMM1YT2ffpqU2wVrtC3HLZA/BkcwOUQXK0R+SVTt
	ONTXG/bBydn9HtHHXzeg=
X-Received: by 2002:a17:903:2ec5:b0:2cc:77f3:a927 with SMTP id d9443c01a7336-2cf34961e63mr281379585ad.26.1784719633063;
        Wed, 22 Jul 2026 04:27:13 -0700 (PDT)
X-Received: by 2002:a17:903:2ec5:b0:2cc:77f3:a927 with SMTP id d9443c01a7336-2cf34961e63mr281379105ad.26.1784719632401;
        Wed, 22 Jul 2026 04:27:12 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e65f3sm13143995ad.45.2026.07.22.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:27:12 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: [PATCH v4 0/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Date: Wed, 22 Jul 2026 16:56:36 +0530
Message-Id: <20260722-gen3_adc_tm-v4-0-011981f756c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyoYGoC/3XO3Q6CMAwF4Fcxu3Zm6xCYV76HMWQrRWYElAHRG
 N7doTH+RG+anOT0a6/MU+vIs9XsyloanHdNHUI0nzEsTb0j7vKQGQiIxVJGfEe1ykyOWVfxSIo
 crU4txcDCxrGlwp3v2mb7yL63e8JuIqZG6XzXtJf7uUFOvae8/JAHyQVX2hrQhbaRsevG+8WpN
 wdsqmoRBpsODPBGQPxJQCASAYU1qKU2+IdQLyIRX1+oQBiMoVBpklukH8Q4jjcdoEagRQEAAA=
 =
X-Change-ID: 20260514-gen3_adc_tm-410dcb98be62
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784719625; l=6207;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=SVKyB6oLGF+H5NOCIbgfu1fSC7w0/pK3jij+xHnf0d0=;
 b=l5r/qDOeraOLEEqh5iRn77KjvvbjwYXBVgVnG2fDHYBR6YJUj5rYINCqzfO3gqM1SwB/BNrh7
 6Opus4gcIT8B/PF7nZtvphjGeA7s5qhP8TyD5/jUDJrPeJ/BYdPaFNV
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX78EVkL8ULS4o
 41LHvUnEp/VcppUnkd/AFeLuea/YXgAUEdU6uCrlq/AYMMWQMDHo5qOnAelfcAqJJrrSOpa2iDP
 TcYuo9AkgoePKJgxHa8tPA4bqdPlhKJ+Nz9sV4PJxBo9MzjyaNr8kAGixrHSvnKi7DPiA39cJ8L
 kYn+Aorq1CjoWcuI8tIpsPMtsSYEXizVjmLY7Mt7nPAOIQ9T/Uk5Yx3R7NPxeUgYLeoembvkdKN
 2HyyuQud0/nbuC+zcAm2JJ2COtubUBAejW6XLTt4eIGlqbMNcbjEp1uXHbkWDfpyZq3LcD9ZZ6y
 8CQtDrokoyYLzg/hPsMQQ9vPvwLIahfzZ7p6thgsKPMkBJ3Sc4Aiy0EECXd1JdWh9lT/Q0/u4y2
 /6uYr/kTArAcS+QSPUNZDA5lTjayhpgH8nu9o90LCJOqLZgQ/u+29OkoVyESuJZYGtMNmWReBxo
 EfN0QzmpL02mSUGstaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExMSBTYWx0ZWRfX1o4X8P9HfaPZ
 xT3DgdX3fDpC23KiRBGpTBYA6+2UmST0Da6tFwRPcbaJZA17Qc1hgMYSYwsZi5i4q11l+5MuIQB
 V1kx9MVHMuTgiC5UV+azJjfAVOYx0rs=
X-Proofpoint-GUID: FZKSrajBUTdqfDmYTC9AmgGJOmcj_Hdz
X-Proofpoint-ORIG-GUID: FZKSrajBUTdqfDmYTC9AmgGJOmcj_Hdz
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a60a912 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Tao4X4yWojVMvd1dBekA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220111

Support for the main PMIC5 Gen3 ADC driver has been merged now.

In order to complete adding support for the Gen3 ADC_TM auxiliary
driver, some more changes are needed in the main driver, mainly to
improve its shared interrupt's handling mechanism.

Patch 1 removes an unneeded print in the main ADC driver.

Patch 2 simplifies the interrupt handling in the main ADC driver
by declaring the interrupt as a shared one and dropping the logic
used to call the ADC_TM notifier for handling ADC_TM interrupts on
the first SDAM whose interrupt is shared.

Patch 3 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes in v4:
- Added Suggested-by and Reviewed-by tags in the print fix patch, fixed
  function names and moved it to beginning of the series.
- Made following changes suggested by Jonathan in auxiliary ADC_TM driver:
  - Changed dev_info() print in adc_tm5_register_tzd() to dev_dbg().
  - Extended comment describing adc5_gen3_disable() action in probe.
  - Refactored code for IRQ request loop in probe.
- Made following changes suggested by Andy in auxiliary ADC_TM driver:
  - Removed adc5_gen3_tm_status_check() definition and called its contents
    directly in threaded IRQ handler.
  - Refactored some code in adc_tm5_gen3_configure() to reduce duplications.
  - Removed dev_err_probe() print in adc_tm5_register_tzd().
  - Added temporary variable and comment in TM channel initialization loop in
    probe to explain TM channel index calculations.
  - Made some minor style changes.
- Added more details in commit message of ADC_TM driver patch as requested
  by Daniel.
- Link to v3: https://patch.msgid.link/20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com

Changes in v3:
- Collected Reviewed-by tag from Jonathan on patch 1.
- Added new patch to remove an unnecessary print in main ADC driver, as
  suggested by Andy.
- Made following changes suggested by Andy in auxiliary ADC_TM driver:
  - Fixed the layouts of structs adc_tm5_gen3_channel_props and adc_tm5_gen3_chip
    to optimize memory consumption.
  - Moved IRQ request call for shared IRQ into existing for loop.
  - Made some minor style changes.
- Made following changes suggested by Jonathan in auxiliary ADC_TM driver:
  - Removed inclusion of kernel.h.
  - Added 'at_least' markings to array pointers passed as input arguments to
    adc5_gen3_tm_status_check.
  - Updated threaded IRQ handler to handle only events on the same SDAM whose
    IRQ triggering led to the threaded handler call.
  - Updated buf[4] assignment in adc_tm5_gen3_configure.
  - Made some minor style changes.
- Moved thermal zone registration call to before IRQ registration call to avoid
  NULL pointer dereference in case of IRQ firing during device unbind between
  thermal zone unregistration and IRQ disablement.
- Removed the logic to read ADC_TM data registers in adc5_gen3_tm_status_check
  to capture temperatures that led to thermal violation, as we now rely on
  immediate reads alone in the get_temp() call for this.
- Link to v2: https://patch.msgid.link/20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com

Changes in v2:
- Updated IRQ request API to request threaded interrupt in main ADC driver, keeping
  primary handler NULL and using existing handler as threaded handler, to avoid
  kernel warning for using IRQF_ONESHOT with non-threaded interrupts.
- Link to v1: https://patch.msgid.link/20260515-gen3_adc_tm-v1-0-39ba29f9b4ab@oss.qualcomm.com

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

---
Jishnu Prakash (3):
      iio: adc: qcom-spmi-adc5-gen3: Remove an unnecessary print
      iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with ADC_TM auxiliary driver
      thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 drivers/iio/adc/qcom-spmi-adc5-gen3.c         |  69 ++--
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 ++++++++++++++++++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h |   2 -
 5 files changed, 463 insertions(+), 52 deletions(-)
---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260514-gen3_adc_tm-410dcb98be62

Best regards,
--  
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

