Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD59497B69;
	Mon, 21 Sep 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009881; cv=none; b=gizDO/uosqPRoead5d7O0glQy0syVVsoOZSEVRqe0vNfhPa29JXX8nIpzHr4CMwOL9QwOwb5G6s/tauKBC9VrhYMqLjYMEOCV2fpHeaVxw8Gka4Z5lUIcKo0FwqX+mBZNJ+i5oMso5UkJkVPvMI53PXXjBv5CuAWfEeTkSsxdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009881; c=relaxed/simple;
	bh=JxkXNBT8EtXW+9F9ou/CElFMC/uPSIzAZZf9FWKbC0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=pSQFmQuFHfu0QSybWMjPLrmDPrW8DjrIzopNrksr5nf/ftXeWCJFA2jBvUW0+t5yscrhzJAlbRzZZ14az6Ywf1IgWowsh1bVKPJ6YFJMZ2plToocc2OUFi5hXFPthmhcUfLUUJTMIqKKyz71GV4jOZz3PZuvG1SEOxh8PTlNZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZDH7gWD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZDH7gWD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFB5Bd2013696;
	Mon, 21 Sep 2026 16:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EG5nGeS2j8hKdXO0q8WP218Im8lJKaYgntnoRDe1LrY=; b=QZDH7gWDqFrrlpLv
	LTD2nxYePW6DRfViCCs3a/fmQJirDAKTxw2te+UAL/RFtVkXWRbOAcEXf8/dBeaN
	kmV6Y6IfYmxGGn8Bac2DCZ3rCnc2pyvov1di1TJ5Cf3herITTFmPdKupbD++x8nk
	Ibxq/L2sPV4zE5bf0EVrUObFNmHtgiS4YYTLUysjYVobQFC+ZkXByOBvfCU3zVcJ
	omakn5wr2yNbUNrkzwYXtDao+NgC4uKAFxwMgT25y+Xv9IyATOcAdS9mv+K8Ud2f
	S5L3ODweJGFScMagNYXJjiUtFBheJfeTVLc2X7t1C1kRA5NnMZRzHVIl4okc+f5Y
	AoECTA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d2bb0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 16:57:28 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LGvNef1464235;
	Mon, 21 Sep 2026 16:57:23 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LGvMa81464229;
	Mon, 21 Sep 2026 16:57:23 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v13 0/6] power: reset: Introduce the Power State Change
 Reasons Recording (PSCRR) framework
Date: Mon, 21 Sep 2026 22:27:08 +0530
Message-Id: <pscrr-v13-0-dfc57fceede5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVhsWoC/x2MwQqDMBBEf0X23IQkYoo99T+KB9FVl9YkbKy1S
 P7dKHN6b5jZISITRngUOzCuFMm7DLq8FdBNrRtRUJ8FhNgxi4HbGX+e35D7wDjQdo1fTeaJ4uL
 5f32t2pwajDJW3Uut6ipHmtqqygotvGScA36eAd34Xdg72mSP0KSUDv4+0pWVAAAA
X-Change-ID: pscrr-framework
In-Reply-To: <20260731095959.296056-1-o.rempel@pengutronix.de>
References: <20260731095959.296056-1-o.rempel@pengutronix.de>
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
X-Proofpoint-ORIG-GUID: M4YgJxNvvrIwcrcCi0sREdxoIYPhBmz7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX5tt4PguxzVVC
 GsRQERhbnxI2XK+RalkY5aeF8/Q7IuS576c4bkItGsATgPfMC7pYqr0H+Dz9CSvn2YvELuQ6E7E
 o223ha2gDVK7mzKe/8D61F4Ye06qFsU=
X-Proofpoint-GUID: M4YgJxNvvrIwcrcCi0sREdxoIYPhBmz7
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab161f8 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=-lTTP2yk7vyb4RmB9s8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI0NyBTYWx0ZWRfX83T/qntXH9yy
 4n4/znNih0L12qmxsvjB2T3Izz2DTIhrCNgXUQ1qT8DS0U+HfvFpcD6sicUt12fdUunMpvDbc6c
 m4vFZEllFrg1b06pif4T1hpjRRu4nOols1ihS6jRKTjUM9HyobsRBgFWip2XZwDhk7jIUIkU6IE
 hj++mwdpsLvfAX2FDAD85gAmNyi+FINqWG6/tTvIkSwd1J7ufuCCor9K6AwO+XnNRMYCBeVmII3
 2AXtEiFK+sxo8tricfPoxRfPC7U/mIjRed65CpAaDvaWXLzR5sGP8kle3tVu1GwwfocuMawVXhL
 z9QBYV4MUefR3b+tadOfTneMNS79uD9f56kywwIg0UVtA0VJFoRDVznLiiu1cVuz5qw65hCPo1W
 v6HYDl3MZheFyrrkrtbCBAGe2omgZvSkCxJyETasND6ffD+25juT4ZZx6yyLvSPPfJ+TKCxX19P
 uh+HpZ8VLq9dIUaN+6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210247

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

Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
---
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
base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
change-id: pscrr-framework

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

