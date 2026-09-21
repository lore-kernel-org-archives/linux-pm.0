Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331E4EF132;
	Mon, 21 Sep 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012472; cv=none; b=eJFysZVLuEzB5iBUL+/c1AZMvdrPTgY7kZlOFHrixtqmUVkfmLkz9xzglhPwxHM2nf7KLvMTd9JcF9j3LBqez8RKmVDv6m+/M8Nb5TY4UmvdbxRgGy2ItnF1h2bUm4GEi7rCfFwQIun4bKwJoBdAu+xq0DqKWkQ7kBVI8y83Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012472; c=relaxed/simple;
	bh=XJUWXai3NGQrl6BmBe415DDG5B9+v+F9ewCj6wOg3Rs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KJouj+KNYrXbuvMnelDoMTQl6iZZEMAOivzW5Yb+uWQyx8Nf5Hn1tOlEtX4BuzXHa5+wNn5dgpccyse7iUKUpYIq9Sqc0+kAZrR5mMlDzC2iDzhcxC4B0dtvztzMMhwmFTlUdUnGm1aGLA9PHx+0MkTZrLOT60GzVMosJw+F5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FE75wbCk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FE75wbCk"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHIGc72980923;
	Mon, 21 Sep 2026 17:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EMC8mQv0wFLlc7jz2NBUPf
	/RNv6GfLGtNHKmMEyuVB4=; b=FE75wbCkKC8ShemOPcpmIYzsERNiqJnfFC0kTg
	hCrYdJfkyUYkoxqzXYidIOzlsUI4vrykft4CHRwN1SPVpbWmuTb+kFD6zI4PMTKQ
	40O9/Q7/u5Sf4wPc/J4Crhy0euXtwOOP0XGzWQDMYuJzcqQGTMxQFCG8JJiZKFlk
	8UMNJ3iVIL5jYuPggbKB7fosuTPi1ocz458FdS00PEpcuj3hUnCcGTt8BUWr9DVG
	7BynEIeVJ8pLbJzqas7ocN6MW4XMBcKcxGQelygfFJUFQPVPyzHoU8yebjyX2SXz
	nryOXcwLVh23MRQNdOkxIYc1t0w4yEa8jRd/Yd0iryRZqy8g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8v50335-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:40:41 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHecCR1524331;
	Mon, 21 Sep 2026 17:40:38 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LHebcp1524318;
	Mon, 21 Sep 2026 17:40:38 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH 0/6] power: reset: Introduce the Power State Change Reasons
 Recording (PSCRR) framework
Date: Mon, 21 Sep 2026 23:10:25 +0530
Message-Id: <20260921-pscrr-framework-v1-0-a5ebe994a98a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAlssWoC/x3MQQqAIBBA0avErBN0qLCuEi3CxhoijREqCO+et
 HyL/19IJEwJhuoFoYsTx1Bg6grcNoeVFC/FgBo73aNRZ3Iiyst80B1lV9j6xlpjyZOFUp1Cnp/
 /OE45f8hEz0RhAAAA
X-Change-ID: 20260921-pscrr-framework-25f48818efe8
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Francesco Valla <francesco@valla.it>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: xcQoLLrEIZaISC3HtHcSTqorctzMn9VN
X-Authority-Analysis: v=2.4 cv=B+0sQ+tM c=1 sm=1 tr=0 ts=6ab16c19 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=CLK3zoHpSqvGHLCE9XYA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfXwOQzQmbIPRZP
 05VNrefEz83RIUvklq94cZvtaadkEHuCZ9XERZsO2FVV+pUo6k2qcpmRIZS3A7w/AqvYAHbH8id
 lh3KvnIg2lfEewOGJSBlzhY5uIK0WHM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfXys3YWd174wR+
 v3s2ZP+DOQKnreBa7/r2ERgV5QDBRvnpxeIPUuMgblr32Aqt6yviZy4SRaZ+OHsZaFvW8pkEezf
 weYncHtueky6jT5naNhhgz20TVYk9YH3dEvJS38w+hwNT9Ebxd1TrlVmWhTCsN23GJavPTzBhYN
 Qpn5iu8tX6LmAGchLLii2MdDo00Hwp5SAzK82+k8VSoJipcyxy42GXxnCRQ9RL4+lRf3MeP8GDO
 GcZdVevN2v0KuhfOmwlep6FEgvPj/791OvqBJ+OwwQU6FrndiC8yQUelqIhrb+fp1JZeb77gt2h
 R5Ud/TIRd1WIA5xkWquQmlJOvBmVTnkupWe1PnZ6YvOwAtqzj2FdmJ06ThDuhYhJ5dqRn8pSt1w
 IyoOanYvkOcPY6xOzK/I+t8DkOHmAgvwbJDqVQXKZmxriQ4bMpUYXde/n4rb5mgPoGdDEOJkMU1
 Pb+XcQt3/pXb+Gyieiw==
X-Proofpoint-ORIG-GUID: xcQoLLrEIZaISC3HtHcSTqorctzMn9VN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210258

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

To: Sebastian Reichel <sre@kernel.org>
To: Benson Leung <bleung@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <groeck@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: chrome-platform@lists.linux.dev
Cc: avaneesh.dwivedi@oss.qualcomm.com
Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>

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
 drivers/power/reset/pscrr/pscrr.c            | 633 +++++++++++++++++++++++++++
 drivers/regulator/core.c                     |  16 +-
 drivers/regulator/irq_helpers.c              |   9 +-
 drivers/thermal/thermal_core.c               |   3 +-
 include/linux/power/power_on_reason.h        |   5 +
 include/linux/pscrr.h                        | 107 +++++
 include/linux/reboot.h                       | 108 ++++-
 kernel/reboot.c                              | 165 ++++++-
 15 files changed, 1183 insertions(+), 22 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260921-pscrr-framework-25f48818efe8

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

