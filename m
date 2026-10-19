Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8E44E67A;
	Mon, 19 Oct 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395567; cv=none; b=Bka9vDWrkfEna9l5O2tS7M4qqDdzdaN6Z1NJx4NFELsWAIGX1+DyzO8dlHrUheHclhXigVjpTYWRnyZ+CLGh8L4zX4k+yUn8UAcqRn7YuKMAG8Ke8nZhxbzOxITZk/lP+O52OYJTxrB9KYlS7cKvIBRSz5hh8gTe8ATMEAiOU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395567; c=relaxed/simple;
	bh=gL2YmfoFYykYB4bZma5fpkbl6BIy55xbdci0wxkySwo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nlAhHE2W/iV11buYwJ5BZ10CV5uMqbwofdQpSCOfC+F2ff4XJLtMqiU5x6SJLfK2ZepMSbj64gLppQeaIuhMbrpYzjGwc6xVGrAUOzCncJ4L+zXC5BrO0eFJZgFfHxuofGj3a50KWgX+tC8tYQTdf1nWRL/3WLB3wXSAQQe8gfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYZonYwa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYZonYwa"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4kHgf1182585;
	Mon, 19 Oct 2026 07:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+Si2+qz9l+cztqd7Mco0n4
	83oDbVPXgCL0sTI7w2ATU=; b=TYZonYwa909sn5pjV+HAqDURdbd9UAJK+YODhK
	p89ZeTa3vl3F3NgV0LeIhS41AkSWFWUaSYOfVJhJoqkW7/QHeryvPy7LWiYARLG2
	9i3uFRUUryzNkvWkvMhM0DmI7iejTWypDV+abIoqbkIu9xr9f6+3kmoWte9IvbHm
	PzqtlBGk1Y9USVVwNChTu8q6SD290Yrg2AxZNNG2U5KVMssJvSS4vptisOR5KjQM
	+KwL2Pc4zzElnBlOdaWOgPSaJ3jY8jyET5d/1pu3Xl9OUcoB4q2SKZnxwD8NSYVC
	WSzlCvuG2JtOtpj8ut3EwvJVCrJgQ0w2fsDWo26VTjxEdBTg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se5d7d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 07:38:59 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J7cu9r104246;
	Mon, 19 Oct 2026 07:38:56 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69J7cuGV104238;
	Mon, 19 Oct 2026 07:38:56 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v17 0/6] power: reset: Introduce the Power State Change
 Reasons Recording (PSCRR) framework
Date: Mon, 19 Oct 2026 13:08:31 +0530
Message-Id: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfI1WoC/2WNwQ6CMBBEf4Xs2ZK2QBs98R+GAy2LNArFXUUN4
 d+tXL1MMpOZNyswUkCGU7YC4RI4xCkZZQ8Z+KGdLihClwLQUht51KWY2ROJntoRX5GuousLr4x
 RlakcpNVM2If3jjw3yQ+BH5E++8OizC/eYUpK+wdLBSFFYUrttbUOnasjc35/tjcfxzFPAs22b
 V9ADhh1uAAAAA==
X-Change-ID: 20260924-pscrr-framework-df3c1661565b
To: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Bradley Morgan <brads@mainlining.org>,
        kernel test robot <lkp@intel.com>,
        Francesco Valla <francesco@valla.it>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 0HyA_D8yTZECZFy-SLwJHnzHh_LRSgNu
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad5c913 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=CLK3zoHpSqvGHLCE9XYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0HyA_D8yTZECZFy-SLwJHnzHh_LRSgNu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX8fWFFJz/ujHl
 SM09MXtFewXaBXB+gADw47CNjfda1CX9c72sgGty43oLZOQgMN7sI3ywlvPTZR0KeO7vowr2Ww7
 eFYmdUWCIYL7z+hPJ2sYnXO7apI3EJM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMCBTYWx0ZWRfX1IHdEOoynv9U
 F5UZq0nmBj6/z96uAMPid3W/o7GAaaIhr4ewtnZZe5O6x+ETleWrF3mzhdBDNIYF0ZHzKFk7vzo
 KddoYjwqLOEE5uV5pZTps1MoVGD6JMeaPayn6EIgujk4VMilUQ4S358K3l/NbgQ2VD1F+0nctS4
 xZSQVFLNgBe/ZVZwPp3YzVJovRTt0ql1bd+nFFL7MvsOnbBIN3lwki4MMUtb0nqVABOBrB1J1T+
 i5vIxAQxH2aYVbYV/44arWOl52JuxXXj7CBGhm0PcT167WQ8X7bM4/rnzyuLutezXGwJc0+jjXx
 b6pRNoE26wh+/sXpddDPIGEh0wpO2DN4jG8OyGctMUbCPjFSbRfjtIypM9eqoyO91KarX46CoS0
 I2ynQGJDfr44tiwB2cdUS+2PqvqWdOrRSzbBcijkdcVhb0D6gR6CiRK2bv+MsZTGLEfCeIB+fxf
 Z3us0+MyXAXlPcRKNWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190030

Hello all,

A system power-state transition - a shutdown or a reboot - rarely has a
single, unambiguous cause, and no one component sees the whole picture: the
PMIC, the watchdog, the SoC reset registers, the bootloader and software each
only know their own part, so there is no single source of truth.

PSCRR gives these sources one central place to report side by side. Every
provider keeps its own view - several providers, and several reasons within a
provider, can be reported at once and are deliberately not collapsed into a
single "winning" cause (a bit of a minority report). On top of that it adds a
software-backed recorder, so software-detected reasons - under-voltage,
over-temperature, a watchdog pretimeout, a panic, a controlled reboot - are
captured too and survive into the next boot.

The NVMEM-cell binding a recorder needs to pick its storage is still
deadlocked, and several projects already need the framework, so this v13
posts the framework, its reboot/reason infrastructure and the sysfs
documentation only; the provider drivers (NVMEM, PMIC, ...) and the tests
follow separately once the binding is resolved. One built-in provider,
reporting the bootloader's device-tree /chosen/reset-source, is kept so the
framework is useful on its own without a new binding.

For followup drivers, see:
 https://github.com/olerem/linux-2.6/tree/v7.2/topic/pscr-v12

Changes in v17:
- Fix macsmc-power build failure reported by Kernel Test Robot due to
  hw_protection_trigger() API change.
- Add Reviewed-by tags from Bradley Morgan and Daniel Lezcano on the
  PSCRR framework patch.
- Link to v16: https://lore.kernel.org/r/20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com

Changes in v16:
- Add Reviewed-by tags from Bradley Morgan (patches 2-4) and Daniel
  Lezcano (patches 1-3).
- Drop the unused PSCR_MAX_REASON macro - Daniel Lezcano.
- Rename from "Invalid" to "Invalid reason" - Daniel Lezcano.
- Link to v15: https://lore.kernel.org/r/20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com

Changes in v15:
- Add static_assert() to keep psc_reason_descs and PSCR_REASON_COUNT in sync.
- Fix pscrr error codes: use -EOPNOTSUPP for unsupported recording and -EINVAL
  for unsupported reasons.
- pscrr: add comments explaining safe lockless provider access in sysfs
  callbacks (Matti Vaittinen)
- Add Reviewed-by tags from Matti Vaittine.
- Link to v14: https://lore.kernel.org/r/20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com

Changes in v14:
- Ignore v13, it was mistakenly posted as a reply to Oleksij's v12
  patch series.

Changes in v13:
- Rework pscrr_provider_register() based on review feedback from Francesco Valla:
  move the pscrr_root check before allocation and narrow pscrr_lock scope.
- Carry the series forward with Faruque Ansari as author and Oleksij
  Rempel as co-developer, and vice versa where required.
- Link to v12: https://lore.kernel.org/r/20260731095959.296056-1-o.rempel@pengutronix.de

Changes in v12:
- Drop all provider drivers and their tests; post the framework alone. The
  NVMEM-cell binding a recorder needs to pick its storage is still
  deadlocked, and several projects already need the framework - so unblock
  the core now and let the providers (NVMEM, PMIC, ...) follow separately.
- Rework into a multi-provider design (per-provider /sys/kernel/pscrr/
  directories); add reason tokens and a built-in /chosen/reset-source
  provider.

Changes in v11:
- add missing break reported by kernel test robot <lkp@intel.com>

Changes in v10:
- add some add Reviewed-by tags
- regulator_handle_critical: set pscr = PSCR_UNKNOWN for default case
- make g_pscrr static

Changes in v9:
- Remove redundant pr_crit() messages before hw_protection_trigger()
- Replace psc_reason_to_str() switch with static const string array
- Mark psc_last_reason as static

Changes in v8:
- Use DEFINE_GUARD() and guard(g_pscrr) for scoped locking of the global
  pscrr_core struct
- Replace manual mutex_lock/unlock with automatic cleanup-based guard() usage
- Centralize backend and locking state in struct pscrr_core
- Prepare for future multi-backend support with clean encapsulation
- Improve sysfs documentation

Changes in v7:
- document expected values in sysfs documentation
- make write support optional

Changes in v6:
- add sysfs documentation
- push core part of the reset reason into kernel/reboot.c

Changes in v5:
- fix compile with NVMEM=n and potential issues with NVMEM=m

Changes in v4:
- fix compile with CONFIG_PSCRR=n

Changes in v3:
- rework to remove devicetree dependencies
- extend NVMEM to search devices and cells by names

Changes in v2:
- rename the framework from PSCR to PSCRR (last R is for Recorder)
- extend the power-on reason header and reuse it for the detected reason
- rebase on top of v6.8-rc1

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
Faruque Ansari (6):
      power: Extend power_on_reason.h for upcoming PSCRR framework
      reboot: hw_protection_trigger: use standardized numeric shutdown/reboot reasons instead of strings
      reboot: add parsable tokens for power state change reasons
      reboot: extend psc_reason with power-on and reset causes
      power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
      Documentation: Add sysfs documentation for PSCRR

 Documentation/ABI/testing/sysfs-kernel-pscrr | 108 +++++
 MAINTAINERS                                  |  11 +
 drivers/platform/chrome/cros_ec_lpc.c        |   2 +-
 drivers/power/reset/Kconfig                  |   2 +
 drivers/power/reset/Makefile                 |   1 +
 drivers/power/reset/pscrr/Kconfig            |  33 ++
 drivers/power/reset/pscrr/Makefile           |   2 +
 drivers/power/reset/pscrr/pscrr.c            | 640 +++++++++++++++++++++++++++
 drivers/power/supply/macsmc-power.c          |   2 +-
 drivers/regulator/core.c                     |  16 +-
 drivers/regulator/irq_helpers.c              |   9 +-
 drivers/thermal/thermal_core.c               |   3 +-
 include/linux/power/power_on_reason.h        |   5 +
 include/linux/pscrr.h                        | 107 +++++
 include/linux/reboot.h                       | 108 ++++-
 kernel/reboot.c                              | 169 ++++++-
 16 files changed, 1195 insertions(+), 23 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260924-pscrr-framework-df3c1661565b

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

