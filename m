Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CB2DCF61
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270457; cv=none; b=J30+24aUDkWmdQIGDhBK7KK7N1ikfXi5LGB/lxHZNQCwY8g+aMgjYqCxGCgbMUZIqNJPYZSNHhIeXMPMNy3ZtERNLC3wW/UFZC0ounq0yUQxR4JibSW2E/4toni9I6YFjw99CB9UjqQx16RBFfhIIzOsyrYARr5m/DAxy40HHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270457; c=relaxed/simple;
	bh=XnlKrBm20/VNbLExDtA9XB21XZ9ga3CjEVdRTPM8dPQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ibA4mD3r46qfZOnej4YjPjD9j730RfcD0nI2y5LTfyuAdwE+TKTWOiL80r43UYNVc4Fjp+C20Cc3VKg/YhjliV09cQH8SUhzuaxm7N5CLEs3lh4ZL2fV9YZDAk5tbOTnTLC0GSaNTbwXgkUKuex5MXWaxbbz5tuoRN9I6ahcImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6bLeD5I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IlJBYE4k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6bLeD5I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IlJBYE4k"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Bnij21478565
	for <linux-pm@vger.kernel.org>; Sun, 5 Jul 2026 16:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZefyJoUxrrCLKryhkIBNsi
	lLO1/PWO8oOj6x55T8Ecs=; b=N6bLeD5Ib8JH85KoQDmTi+vd3i+8mwvf0obBvQ
	CTo8OI18yMF4fzLFxYTi2madogGjogZ+NklgdVM5tmJpJ0s8sA5Su9x+AudxtcQx
	/XMgARW4I8U571W1IRODM4bRddIB5Xsycd1hQx1az9uaf3Jkqn3Fpx99HqJPvLdc
	y/3cu9ZqdWT6i163KCBpaEC6f4z0qrj8cUb96KjlfZaJhp4Gnvxqsz8Y0O/CHPPQ
	Zl1eNslYWJjeYTxYQkqZdeKg6Q3YJr71X1ST/jTergMOJ4fm1f7SQPcLfbhgk5sO
	pv/IzFvsQygvFFfgSBH35ZsODfZZ5A06FZmkJ60hd4hBUtNA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txejy4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 16:54:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894391f000so5529987a12.1
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783270454; x=1783875254; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZefyJoUxrrCLKryhkIBNsilLO1/PWO8oOj6x55T8Ecs=;
        b=IlJBYE4k5RiiF1eBheEb0oG49bj6T5t8pYCWbnbfifHT1BaWtlx/6iSd5qAUACjslj
         7EA8LYKyaG0jl2om6b1GRaOJjJIjPT/JEe4U5Jm/Euq2TRy2LlT1rW2+KGwv5sSo9SS5
         Num9gFVN80rOfP232c9DBE6DFGSmzfFzfbV0ZdlqK6VcnrRpzIVX8uGcnffu4Jz0v5Cv
         klKKq5L+HO5rTnGN0hngJmRkzZZ9sxfwYjCrkfCCVV/Mqj8gQIHi6l3J0lye0wP880Mb
         BTgRrljlav2LCY7mhiokTiUy+9CEi4yCdty8p3xd6FyHNBOMjPEKXX2M0TQtHhPYqzg8
         zMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783270454; x=1783875254;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZefyJoUxrrCLKryhkIBNsilLO1/PWO8oOj6x55T8Ecs=;
        b=pPBRNi3G+FGCaKdL/86zDC78Z5ukHgsUlda+mgXIdFSLyv9LtTX68OZ4xiIOBqjFPg
         zEUQcdFkVVxW8pifD7IY9dTMSh//LY+u0Fs/0SY8j13kUBkfhfGei+6K2TWcX0U9SzUx
         AH7fFYvsou2CsaQKvr02qyM7Eh8Ovlk0at9vhWImXkipZUAVaFyfD5pMABbq+rIHbn0Z
         ub1gauzkpoOrlFbSoCyIiUqsz49BmrcUeOQ8Q2+FpSBTAb5fUiYUd2dDUBab1bq740A/
         pSFE/Vnp23Ds+zIW8XksfLF9l2y1HyfZq89AGBvmj5bH802x9tGYF3ox+5gfsKuy2V9C
         EGjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsxikS8WClGS2q1/6YYa2ZY7366fKBDgcl257B25IlOQ/jDzhyj+4jFTRVWDAxvGBQK8PUOp1tSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrddOFFgQRvH9On8HFHVDbxQ15eWv6twvWtBc1x9XDgiUoG4iI
	2TuGlmOK012xV0h4mul7u30P/2VP9u0nP95qkLs27m+fmIs6KOtFGRwWr3Cino030GZecl1kmdn
	2X2s4zbGSa0l7o8KWW3+KRyzA57NExWtPQHYrciqERljRs0iwYvp5+6hV6v0hlA==
X-Gm-Gg: AfdE7clqCIQyLVgoHHBC0k/CrqgpFpDLqxrmqU8pvZO52Fq13FR85KZPUcs8qAqix0u
	CqlDBxGu0pGiNrWJZN0zh75IOePgxk5lg9k0RNB2KdnsGVD7Y16/ne2CPJuSHaYnFb+fSoebf42
	+1myoxCWmBiIe0LDcUNmnNOSJM/5dqDHoaatelOYplPNsDEcynUIJjplvLyEmjL34ynRwOHlXYr
	6VJT6Pnp9iWPw8TmcC1CEvzaXXx1wV9V8RlYsp9vwZvRO1QMWdfpWtImVJokiO8xEskrmvVZZMs
	qiOcjikyI4Qsh0XM9BjTNH169CzNSD2maWr16XhrOKPho/FnXmZVD5hTwEM0l9jaa38RoCorrE6
	KWwXOZ667Y2nINf/gbxkmTXAx74jLkA==
X-Received: by 2002:a05:6a21:494:b0:3b3:fdb0:2295 with SMTP id adf61e73a8af0-3c03e1a89c8mr7573850637.6.1783270453747;
        Sun, 05 Jul 2026 09:54:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:494:b0:3b3:fdb0:2295 with SMTP id adf61e73a8af0-3c03e1a89c8mr7573829637.6.1783270453299;
        Sun, 05 Jul 2026 09:54:13 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm38253593eec.12.2026.07.05.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 09:54:12 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: [PATCH v3 0/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Date: Sun, 05 Jul 2026 22:23:32 +0530
Message-Id: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyMSmoC/23N3wrCIBQG8FcZXudQ96fsqveIGOrONqPN0k2Ks
 XdPF0GDbg588J3fNyMHVoNDx2RGFrx22gwhZLsEqU4MLWBdh4wYYSUpaI5bGLJK1Koae5xTUiv
 JDxJKhsLH3UKjn6t2vnyym+QV1BiJ2Oi0G419rXOext5XLjayp5jgjEvBeMNlLuTJOJc+JnFTp
 u/TcFAc8OyHYOWWYIHYE9ZIoTjlQv0hlmV5AxYKrH4CAQAA
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
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783270447; l=5109;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=XnlKrBm20/VNbLExDtA9XB21XZ9ga3CjEVdRTPM8dPQ=;
 b=mS0oXYAemY/9xl9m3tbNwkBcx+OYtnfhJ2n/JFxqoYWIVFY+iboOuX4F8CMxMOYLz7bEpjNtJ
 uHkbEJce3mbC4wl5dVM59ILaohZYYiYQpd/OXF6KrRSmEAdj33tVlAs
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4MSBTYWx0ZWRfXx3CypZyor+Eh
 36MDyIBjGVeYMjdli5Npb5VrxKjD5b2NSiKpg15xSQfM66FWd5f/0J+Bbn5HZ4IDGKww8bL6CCV
 8B75k9vGKZ/6mJeeHn4cVspL33ZU2Tg=
X-Proofpoint-GUID: UrVA6oufILuKiMORA_Kqz5iNgGdWbLWW
X-Proofpoint-ORIG-GUID: UrVA6oufILuKiMORA_Kqz5iNgGdWbLWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4MSBTYWx0ZWRfX3LEoQJbH7DT8
 SpiOM63tJV4pomsJUiN21gQLNkIxeGQC6croiZk1wJu5zgVcIfofLk9UWxBlDFyeruLdzHdZzOI
 fCM1c6uJSBU8Xly5knAop7dFlMUHsXY7Aoqju++/IsS8Mfolxq7n6T5+WpUPXgovRg+ykYasbbw
 HwEWUFrtkkwKJZm2PKfZqxhwJWqeqT68/l0Z3gyWoCJfm6O5WXGghY0w++mm+SiZMmUeVWqrnB+
 kwwGd7dYpIFgBZ8u6O9/KHPQbzEQ6qP4beIn/LTfvJI3Z3rtnLVG3Ato8O2r1TNk5xcaGfGxwpe
 y3VpuFd2k5CzC9DhwP+Qp+RJ8nvsJ/k4VaIxHMKIJfoMx03OiXeeuvHlBYVDj2Cqerw9rOyZmEN
 Jd1Y8+Xs5rZLmnB0syIrdmdEGJYOjr6+QJorb5LQtNEZtlMIYtcqDiUurM+XeWHf2MVhsO6V4i8
 sLqVhizf0JSFJ6QBW5A==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a8c36 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Y40OH6ZSaRz8CUe3D6IA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050181

Support for the main PMIC5 Gen3 ADC driver has been merged now.

In order to complete adding support for the Gen3 ADC_TM auxiliary
driver, some more changes are needed in the main driver, mainly to
improve its shared interrupt's handling mechanism.

Patch 1 simplifies the interrupt handling in the main ADC driver
by declaring the interrupt as a shared one and dropping the logic
used to call the ADC_TM notifier for handling ADC_TM interrupts on
the first SDAM whose interrupt is shared.

Patch 2 removes an unneeded print in the main ADC driver.

Patch 3 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
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
      iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with ADC_TM auxiliary driver
      iio: adc: qcom-spmi-adc5-gen3: Remove an unnecessary print
      thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 drivers/iio/adc/qcom-spmi-adc5-gen3.c         |  69 ++---
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 425 ++++++++++++++++++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h |   2 -
 5 files changed, 454 insertions(+), 52 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260514-gen3_adc_tm-410dcb98be62

Best regards,
--  
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

