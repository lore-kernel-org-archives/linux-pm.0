Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EC3E0081;
	Thu, 24 Sep 2026 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233840; cv=none; b=upsAAmHHkHZ/2ZbiFno9A8KB+ubDaKyfGtCp47Pi//2TkuCQD8RxeDWbaOnHV4pnNMIrkSIjtxXSziI40YaC9gb4l8gMzSoftWWBISS3MhDXPgNDkW8mFBhRN4otk9igxLq1dDb5CV8WdyLw5s4DpS1cn5g5IchoPBnQwbgg388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233840; c=relaxed/simple;
	bh=hahpUDk01FPS6LuRN1PtiPfmkXLWrvw4Cjebd5+t7Lo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=IKNZJ5s+IOyQJ3DQQEHP2rSBUe8QAvf1dTSun9oRupdVxySiWc4/XD+6elys3Kt6s5jB2Mhh7fEYP21/HWfQI5whVFtneZFt6uHoOI0oVOQwrRm22QdyOKM2/pLe/Se85RsxY/DgwxADKLC/FkGvKImJs+ke3/S4qajbz3YP7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nAdAm574; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nAdAm574"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O62MH11475908;
	Thu, 24 Sep 2026 07:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mhwbWe/qmwB6OF0rkmSRV2TulSJs4F7s1I7C3Bx7NWw=; b=nAdAm5745NM5AVzx
	Rpvj0JLJvX0EzpGgdeguHVQ8lxZn1U/CIro+H+rJ2xGpbQRElPIMYB7vsylRy1rQ
	CqKeWAuEjTyPiGygPEukOrG9D5AfZGIK98L82A08bDBbQmy4VQgkyyGJi8Oqmv6T
	rmCPfMh8oo47cmPhqDwqjDcBR85i6kCgp3Dgwck9lnaXwhQoPTHxfwO4wwHu7tdV
	jweyptS2gkcwlV03BF99f62oCYfct/bmhFLvzQFUZeTMJO1lzZ2i2MZM2bnjROXT
	+ON62P1q6o3uV2COg2uR4P+/w5vdiO/l1yJZXvvJOtcaaDf4EZJvJHUdJ9SzKz6c
	U9qTMQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvx8ag93j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 07:10:04 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O7A16i2215799;
	Thu, 24 Sep 2026 07:10:01 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68O7A0Cj2215790;
	Thu, 24 Sep 2026 07:10:01 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: [PATCH v15 0/6] power: reset: Introduce the Power State Change
 Reasons Recording (PSCRR) framework
Date: Thu, 24 Sep 2026 12:38:41 +0530
Message-Id: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnMtGoC/4XNQQ7CIBAF0Ks0rKUBpBW68h7GBcXBEm2pg6Km6
 d2lXWvcTPJ/8t9MJAJ6iKQpJoKQfPRhyIFXm4LYzgxnoP6UCyKYqJkWnI7RIlKHpodnwAsVlZN
 KcQUOFMmrEcH510oejjl3Pt4DvtcPiS/tbytxyqipoAWtpdHK7EOM5e1hrjb0fZkPWcjE5T9HL
 hCvhWaMbdud/QLN8/wBz1tTT/8AAAA=
X-Change-ID: 20260921-pscrr-framework-25f48818efe8
In-Reply-To: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX/W0YWb/mveIP
 FYGaAn3FXMKkaVCZ6HtCCtUV+oWmJBoXnJAnU8aeYRekSGlyPjjaMTtgq5qPHWc+eCxIn1JHojR
 7G3i9JYOSfGoe/0a404pd/ECWw0LLJI=
X-Proofpoint-ORIG-GUID: cKWLn0pstv1fOyKSzacbld6k0VY8AfjL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfXwCcT77zT72Y9
 Fd1ZPtjeQtbXoKmoIGQXug71vSXana7kHcEoLkADL6lIdrMq/WBIWj9U09/3yhXpEec3MyA9Xeu
 eiOdb1eh5JQ2eIeP0ATcMHbkdPOI1D5dVRFhWyPhYE1OAuiBrctfHRe4z4d/0fb5srmu/prdwaS
 gTb2sqRYwxwy9bPZNMQ0rO5HzWa6mfoYvrBcUpPBExhfnOTs8xP0ZFRRoN1hosN6kT9fQo+WjiC
 2o8C/vzXU5sbJz7mbr6WcZX1Ba8qJExWUsftpMgQQ+kBXuWaeqMqrksHRGSwr6zW3E3UHZC9u+y
 1q4GRVvGtbbBjPkd/dCkm2PJgfQtyEjyN2oTkVpHG7UpaXpb5S0CmxhqKyuA72m/8gYM3E2tJ6f
 eTKrvTp7FkzPYvzo3xwZzjwmIuEe6cnEfnclIo5uDmAF9z98u8grK8u3pr6TV6v7SBGDxp9TGHM
 xKBpvWDM7cvCtOP0e4A==
X-Authority-Analysis: v=2.4 cv=a6SlZkSF c=1 sm=1 tr=0 ts=6ab4cccc cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=-lTTP2yk7vyb4RmB9s8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cKWLn0pstv1fOyKSzacbld6k0VY8AfjL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240030

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
 drivers/regulator/core.c                     |  16 +-
 drivers/regulator/irq_helpers.c              |   9 +-
 drivers/thermal/thermal_core.c               |   3 +-
 include/linux/power/power_on_reason.h        |   5 +
 include/linux/pscrr.h                        | 107 +++++
 include/linux/reboot.h                       | 108 ++++-
 kernel/reboot.c                              | 169 ++++++-
 15 files changed, 1194 insertions(+), 22 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260921-pscrr-framework-25f48818efe8

Best regards,
-- 
Faruque Ansari <faruque.ansari@oss.qualcomm.com>

