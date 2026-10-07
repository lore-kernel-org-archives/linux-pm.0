Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E73D171C;
	Wed,  7 Oct 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374880; cv=none; b=Y8GSkEvoLGR4TETMFXhaYftSQ8t50oblKLnxgGxTlDi4UgL07dlCUk7mKvwgFb6TFIMqdrdwD5as2JNufaFUwZnP04NT75Jw6SE8czvAiv1nSFRzxyx+W3QjKcWxlg2uOmZ30gZlUCT4CmkTHjngN5OV8vJV1XCduTbMISZ4ItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374880; c=relaxed/simple;
	bh=nPgBo7XNNbqSNft8xzOVmh2uwGFaBeJjY72UFYvG0Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOBZAeACT4SyLfRlRmpblG3hn1Ys072irWygtFMX2YeHfnc1IyyBUZN7IL9DnT2/j4CzVMNQQVEWnWoXmksvw1pp7e99QHth7gF53RSq23cxY+I2zy42+K8ic3K+D/9IBQvxYEVNlCQMDZ1rxbP96CdOgIzkv9xQ+o8EIZhc+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oav3kvzC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oav3kvzC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BVLaB3787064;
	Wed, 7 Oct 2026 12:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CdqCL6s3aRLlxJOxNot9tOrIZiua8b7e3tQ/DCfNkKI=; b=oav3kvzC1ZPJhIqN
	BCZ+5xeRLdskqYNvqc1xZjHZdEZPpV7LoY8+Q7T9KU02BmDYy97djkz9rYzXoeti
	P5OpclpMAPpEsi8BJgJjjdoUSHRLfv2a9AsdkfyvrFCytLNaOPnqdxFmDd+4JLs0
	lSfTrl90iBw6D0C5/2RgRw875zPxN66fWPO1PKLHescygbNTbGYcvJrqg+nmnosc
	95xpmr69iB81Hw3Ha8VrHEcdGedUEvTcyCEvd1zpYgJI+Wg70JdWQyGLL+YI5SkN
	F+n/dGJgFxAhQ7ESFB7SiDFo2QMHs1PsWiHCyUxziI7dH/uZ3f7XnUVOIKKUIOTe
	xlDqqA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcrxq9-65
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 12:07:15 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69776n4B1872904;
	Wed, 7 Oct 2026 07:06:49 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 69776m1s1872875;
	Wed, 07 Oct 2026 07:06:49 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:36:37 +0530
Subject: [PATCH v16 2/6] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-pscrr-framework-v16-2-3642c277bebb@oss.qualcomm.com>
References: <20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com>
In-Reply-To: <20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com>
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
        Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Bradley Morgan <brads@mainlining.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: qhAqzLHjsO0bs-knIWtSd_OFQI7Dyxfl
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac635f3 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=7sc-FwRdcYxzY__InfsA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0OCBTYWx0ZWRfX8fzQ+R7KqaNw
 cmUOrXYD7Vy8dHupeDW1q7Zv2leygUSPSbHNN9AI2DF9phkj7aoe38QEeJLaWdoh9sYJyw/lbXZ
 8ZrssCNZELIFved03ABoZKYyyeoLY34=
X-Proofpoint-ORIG-GUID: qhAqzLHjsO0bs-knIWtSd_OFQI7Dyxfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0OCBTYWx0ZWRfX1lEfzQd9rm1i
 nenHWs6Sdkx7ctsFL/pVCp5bP6gZNrvGA7h8LP5CMSH9vGOLsWnmWRa7v+Jp5zUv7/l2cX5G5ni
 yUHRxinL+ak4Si4Tm69Rd0cFO/rDMSV5hOkptJC/mya2L47L0xEQkqCf693QiBSUFIVZ0j0shgx
 lUStHY9K4TksuHeO3w+7+rDXZXA+6EFNKcn4qZiZ/mR9h9N78nQ767Um+pwgCvBmRm8LRMsQmsE
 uTgSoF3TnY9a2Eh48yz8kGpPE9ICLYjZffqd1+ux9nduYFi1RXlQG1Ls40eUM1CupVF7KwvQdUL
 YNaIhecO/bxpnhjjenrtxXAGrwJoxz75YNdKUQN3oREVvzGVHJrbb4NVV2N/s5cYvKpUY9XEKyZ
 rxWA3r/VdiyvG1etn0HS59Lc9y47ZPksytO5/CE/b3S+5ENsfLecJ09fBgaDsJHTpzZ1sBDt36z
 2S8fM8aJga19iWLG0DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070048

Prepares the kernel for the Power State Change Reason (PSCR) recorder,
which will store shutdown and reboot reasons in persistent storage.

Instead of using string-based reason descriptions, which are often too
large to fit within limited storage spaces (e.g., RTC clocks with only 8
bits of battery-backed storage), we introduce `enum psc_reason`. This
enumerates predefined reasons for power state changes, making it
efficient to store and retrieve shutdown causes.

Key changes:
- Introduced `enum psc_reason`, defining structured reasons for power state
  changes.
- Replaced string-based shutdown reasons with `psc_reason` identifiers.
- Implemented `get_psc_reason()` and `set_psc_reason()` for tracking the
  last shutdown cause.
- Added `psc_reason_to_str()` to map enum values to human-readable strings.
- Updated `hw_protection_trigger()` to use `psc_reason` instead of string
  parameters.
- Updated all consumers of `hw_protection_trigger()` to pass an appropriate
  `psc_reason` value instead of a string.
- All structured logs now go through a single `pr_emerg()` in
  `__hw_protection_trigger()`, providing consistent output:
    HARDWARE PROTECTION <action>: <reason-code> (<reason-string>)

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v16:
- Add Reviewed-by tag from Bradley Morgan.
- Add Reviewed-by tag from Daniel Lezcano.
- Remove unused PSCR_MAX_REASON macro - Daniel Lezcano.
- Rename "Invalid" string to "Invalid reason" - Daniel Lezcano
changes v12:
- drop Tested-by: Faruque Ansari and Francesco Valla; the end-to-end
  recording flow they tested has been reworked (multi-provider) and the
  recorder driver is no longer part of the series - re-testing is welcome
changes v10
- regulator_handle_critical: set pscr = PSCR_UNKNOWN for default case
- add Acked-by: Daniel Lezcano ..
changes v9:
- Remove redundant pr_crit() messages before hw_protection_trigger()
- Replace psc_reason_to_str() switch with static const string array
- Mark psc_last_reason as static
changes v8:
- add Acked/Reviewed-by.
changes v6:
- added in this version
(cherry picked from commit 29591d88486c392e2264de73c4e90106f181b33c)
---
 drivers/platform/chrome/cros_ec_lpc.c |   2 +-
 drivers/regulator/core.c              |  16 ++---
 drivers/regulator/irq_helpers.c       |   9 +--
 drivers/thermal/thermal_core.c        |   3 +-
 include/linux/reboot.h                |  78 ++++++++++++++++++++++-
 kernel/reboot.c                       | 112 ++++++++++++++++++++++++++++++++--
 6 files changed, 198 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 78cfff80cdea..00e98d12ddbc 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -455,7 +455,7 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
 		/* Begin orderly shutdown. EC will force reset after a short period. */
-		__hw_protection_trigger("CrOS EC Panic", -1, HWPROT_ACT_SHUTDOWN);
+		__hw_protection_trigger(PSCR_EC_PANIC, -1, HWPROT_ACT_SHUTDOWN);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 631b55142809..90c406a4a045 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5551,26 +5551,26 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 static void regulator_handle_critical(struct regulator_dev *rdev,
 				      unsigned long event)
 {
-	const char *reason = NULL;
+	enum psc_reason pscr;
 
 	if (!rdev->constraints->system_critical)
 		return;
 
 	switch (event) {
 	case REGULATOR_EVENT_UNDER_VOLTAGE:
-		reason = "System critical regulator: voltage drop detected";
+		pscr = PSCR_UNDER_VOLTAGE;
 		break;
 	case REGULATOR_EVENT_OVER_CURRENT:
-		reason = "System critical regulator: over-current detected";
+		pscr = PSCR_OVER_CURRENT;
 		break;
 	case REGULATOR_EVENT_FAIL:
-		reason = "System critical regulator: unknown error";
+		pscr = PSCR_REGULATOR_FAILURE;
+		break;
+	default:
+		pscr = PSCR_UNKNOWN;
 	}
 
-	if (!reason)
-		return;
-
-	hw_protection_trigger(reason,
+	hw_protection_trigger(pscr,
 			      rdev->constraints->uv_less_critical_window_ms);
 }
 
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5b3cfac28667..712e0ce840e7 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -64,15 +64,16 @@ static void regulator_notifier_isr_work(struct work_struct *work)
 reread:
 	if (d->fatal_cnt && h->retry_cnt > d->fatal_cnt) {
 		if (!d->die)
-			return hw_protection_trigger("Regulator HW failure? - no IC recovery",
+			return hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 						     REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
+
 		ret = d->die(rid);
 		/*
 		 * If the 'last resort' IC recovery failed we will have
 		 * nothing else left to do...
 		 */
 		if (ret)
-			return hw_protection_trigger("Regulator HW failure. IC recovery failed",
+			return hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 						     REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 
 		/*
@@ -263,13 +264,13 @@ static irqreturn_t regulator_notifier_isr(int irq, void *data)
 	if (d->fatal_cnt && h->retry_cnt > d->fatal_cnt) {
 		/* If we have no recovery, just try shut down straight away */
 		if (!d->die) {
-			hw_protection_trigger("Regulator failure. Retry count exceeded",
+			hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 					      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 		} else {
 			ret = d->die(rid);
 			/* If die() failed shut down as a last attempt to save the HW */
 			if (ret)
-				hw_protection_trigger("Regulator failure. Recovery failed",
+				hw_protection_trigger(PSCR_REGULATOR_FAILURE,
 						      REGULATOR_FORCED_SAFETY_SHUTDOWN_WAIT_MS);
 		}
 	}
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ac928c199829..3618986c1cab 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -319,11 +319,10 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz,
 	 * Its a must for forced_emergency_poweroff_work to be scheduled.
 	 */
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
-	const char *msg = "Temperature too high";
 
 	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
 
-	__hw_protection_trigger(msg, poweroff_delay_ms, action);
+	__hw_protection_trigger(PSCR_OVER_TEMPERATURE, poweroff_delay_ms, action);
 }
 
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index aa08c3bbbf59..190b5838fda1 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -178,6 +178,73 @@ void ctrl_alt_del(void);
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
 
+
+/**
+ * enum psc_reason - Enumerates reasons for power state changes.
+ *
+ * This enum defines various reasons why a system might transition into a
+ * shutdown, reboot, or kexec state. While originally intended for hardware
+ * protection events, `psc_reason` can be extended to track other system
+ * transitions, such as controlled reboots triggered by software or
+ * maintenance operations.
+ *
+ * The values in this enumeration provide structured and standardized
+ * identifiers that replace free-form string descriptions. They are designed
+ * to be stored efficiently, making them suitable for use in environments
+ * with limited storage, such as battery-backed RTC registers, non-volatile
+ * memory, or bootloader communication mechanisms.
+ *
+ * Importantly, the order of these values **must remain stable**, as
+ * bootloaders, user-space tools, or post-mortem investigation utilities
+ * may rely on their numerical representation for consistent behavior.
+ *
+ * @PSCR_UNKNOWN: Unknown or unspecified reason for the power state change.
+ *	This value serves as a default when no explicit cause is recorded.
+ *
+ * @PSCR_UNDER_VOLTAGE: Shutdown or reboot triggered due to supply voltage
+ *      dropping below a safe threshold. This helps prevent instability or
+ *      corruption caused by insufficient power.
+ *
+ * @PSCR_OVER_CURRENT: System shutdown or reboot due to excessive current draw,
+ *      which may indicate a short circuit, an overloaded power rail, or other
+ *      hardware faults requiring immediate action.
+ *
+ * @PSCR_REGULATOR_FAILURE: A critical failure in a voltage regulator, causing
+ *      improper power delivery. This may be due to internal component failure,
+ *      transient conditions, or external load issues requiring mitigation.
+ *
+ * @PSCR_OVER_TEMPERATURE: System shutdown or reboot due to excessive thermal
+ *	conditions. This attempts to prevent hardware damage when temperature
+ *	sensors detect unsafe levels, often impacting CPUs, GPUs, or power
+ *	components.
+ *
+ * @PSCR_EC_PANIC: Shutdown or reboot triggered by an Embedded Controller (EC)
+ *	panic. The EC is a microcontroller responsible for low-level system
+ *	management, including power sequencing, thermal control, and battery
+ *	management. An EC panic may indicate critical firmware issues, power
+ *	management errors, or an unrecoverable hardware fault requiring
+ *	immediate response. The EC reports the panic itself (e.g. the ACPI
+ *	notify value ACPI_NOTIFY_CROS_EC_PANIC on ChromeOS EC hardware); the
+ *	kernel only relays that report, see cros_ec_lpc_acpi_notify().
+ *
+ * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
+ *	value is useful for range checking and potential future extensions
+ *	while maintaining compatibility.
+ */
+enum psc_reason {
+	PSCR_UNKNOWN,
+	PSCR_UNDER_VOLTAGE,
+	PSCR_OVER_CURRENT,
+	PSCR_REGULATOR_FAILURE,
+	PSCR_OVER_TEMPERATURE,
+	PSCR_EC_PANIC,
+
+	/* Number of reasons */
+	PSCR_REASON_COUNT,
+};
+
+const char *psc_reason_to_str(enum psc_reason reason);
+
 /**
  * enum hw_protection_action - Hardware protection action
  *
@@ -191,13 +258,13 @@ extern void orderly_reboot(void);
  */
 enum hw_protection_action { HWPROT_ACT_DEFAULT, HWPROT_ACT_SHUTDOWN, HWPROT_ACT_REBOOT };
 
-void __hw_protection_trigger(const char *reason, int ms_until_forced,
+void __hw_protection_trigger(enum psc_reason reason, int ms_until_forced,
 			     enum hw_protection_action action);
 
 /**
  * hw_protection_trigger - Trigger default emergency system hardware protection action
  *
- * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @reason:		Reason of emergency shutdown or reboot.
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
  *			triggering it. Negative value disables the forced
  *			shutdown or reboot.
@@ -206,11 +273,16 @@ void __hw_protection_trigger(const char *reason, int ms_until_forced,
  * hardware from further damage. The exact action taken is controllable at
  * runtime and defaults to shutdown.
  */
-static inline void hw_protection_trigger(const char *reason, int ms_until_forced)
+static inline void hw_protection_trigger(enum psc_reason reason,
+					 int ms_until_forced)
 {
 	__hw_protection_trigger(reason, ms_until_forced, HWPROT_ACT_DEFAULT);
 }
 
+enum psc_reason get_psc_reason(void);
+enum psc_reason get_psc_first_reason(void);
+void set_psc_reason(enum psc_reason reason);
+
 /*
  * Emergency restart, callable from an interrupt handler.
  */
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d177d89fcc33..c3552653a881 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/power/power_on_reason.h>
 #include <linux/rcupdate.h>
 #include <linux/reboot.h>
 #include <linux/sched/signal.h>
@@ -50,6 +51,8 @@ int reboot_default = 1;
 int reboot_cpu;
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
+static enum psc_reason psc_last_reason = PSCR_UNKNOWN;
+static enum psc_reason psc_first_reason = PSCR_UNKNOWN;
 
 struct sys_off_handler {
 	struct notifier_block nb;
@@ -1011,10 +1014,108 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
 			      msecs_to_jiffies(action_delay_ms));
 }
 
+/**
+ * get_psc_reason - Retrieve the last recorded power state change reason.
+ *
+ * This function returns the most recent power state change reason stored
+ * in `psc_last_reason`. The value is set using `set_psc_reason()` when a
+ * shutdown, reboot, or kexec event occurs.
+ *
+ * The reason can be used for system diagnostics, post-mortem analysis, or
+ * debugging unexpected power state changes. Bootloaders or user-space tools
+ * may retrieve this value to determine why the system last transitioned to
+ * a new power state.
+ *
+ * Return: A value from `enum psc_reason`, indicating the last known power
+ * state change reason.
+ */
+enum psc_reason get_psc_reason(void)
+{
+	return READ_ONCE(psc_last_reason);
+}
+EXPORT_SYMBOL_GPL(get_psc_reason);
+
+/**
+ * get_psc_first_reason - Retrieve the first power state change reason.
+ *
+ * Returns the first meaningful (non-PSCR_UNKNOWN) reason recorded during this
+ * boot, i.e. the root cause, as opposed to get_psc_reason() which returns the
+ * most recent one. A later event (a watchdog pretimeout, a kernel panic, ...)
+ * updates the last reason but leaves this one untouched, so a recorder using
+ * the "first" record policy can preserve the original cause.
+ *
+ * Return: A value from `enum psc_reason`.
+ */
+enum psc_reason get_psc_first_reason(void)
+{
+	return READ_ONCE(psc_first_reason);
+}
+EXPORT_SYMBOL_GPL(get_psc_first_reason);
+
+/**
+ * set_psc_reason - Set the reason for the last power state change.
+ *
+ * @reason: A value from `enum psc_reason` indicating the cause of the power
+ *          state change.
+ *
+ * This function records the reason for a shutdown, reboot, or kexec event
+ * by storing it in `psc_last_reason`. It ensures that the value remains
+ * consistent within the running system, allowing retrieval via
+ * `get_psc_reason()` for diagnostics, logging, or post-mortem analysis.
+ *
+ * Persistence Consideration:
+ * - This function **does not persist** the recorded reason across power cycles.
+ * - After a system reset or complete power loss, the recorded reason is lost.
+ * - To store power state change reasons persistently, additional tools such as
+ *   the Power State Change Reason Recorder (PSCRR) framework should be used.
+ */
+void set_psc_reason(enum psc_reason reason)
+{
+	WRITE_ONCE(psc_last_reason, reason);
+
+	/*
+	 * Latch the first meaningful reason of this boot as the root cause, so
+	 * that a later event overwriting the last reason does not hide it from
+	 * a recorder using the "first" record policy.
+	 */
+	if (reason != PSCR_UNKNOWN &&
+	    READ_ONCE(psc_first_reason) == PSCR_UNKNOWN)
+		WRITE_ONCE(psc_first_reason, reason);
+}
+EXPORT_SYMBOL_GPL(set_psc_reason);
+
+static const char * const pscr_reason_strs[] = {
+	[PSCR_UNKNOWN]            = POWER_ON_REASON_UNKNOWN,
+	[PSCR_UNDER_VOLTAGE]      = POWER_ON_REASON_BROWN_OUT,
+	[PSCR_OVER_CURRENT]       = POWER_ON_REASON_OVER_CURRENT,
+	[PSCR_REGULATOR_FAILURE]  = POWER_ON_REASON_REGULATOR_FAILURE,
+	[PSCR_OVER_TEMPERATURE]   = POWER_ON_REASON_OVER_TEMPERATURE,
+	[PSCR_EC_PANIC]           = POWER_ON_REASON_EC_PANIC,
+};
+
+/**
+ * psc_reason_to_str - Converts a power state change reason enum to a string.
+ * @reason: The `psc_reason` enum value to be converted.
+ *
+ * This function provides a human-readable string representation of the power
+ * state change reason, making it easier to interpret logs and debug messages.
+ *
+ * Return:
+ * - A string corresponding to the given `psc_reason` value.
+ * - `"Invalid reason"` if the value is not recognized.
+ */
+const char *psc_reason_to_str(enum psc_reason reason)
+{
+	if (reason < 0 || reason >= PSCR_REASON_COUNT)
+		return "Invalid reason";
+	return pscr_reason_strs[reason];
+}
+EXPORT_SYMBOL_GPL(psc_reason_to_str);
+
 /**
  * __hw_protection_trigger - Trigger an emergency system shutdown or reboot
  *
- * @reason:		Reason of emergency shutdown or reboot to be printed.
+ * @reason:		Reason of emergency shutdown or reboot.
  * @ms_until_forced:	Time to wait for orderly shutdown or reboot before
  *			triggering it. Negative value disables the forced
  *			shutdown or reboot.
@@ -1026,7 +1127,7 @@ static void hw_failure_emergency_schedule(enum hw_protection_action action,
  * pending even if the previous request has given a large timeout for forced
  * shutdown/reboot.
  */
-void __hw_protection_trigger(const char *reason, int ms_until_forced,
+void __hw_protection_trigger(enum psc_reason reason, int ms_until_forced,
 			     enum hw_protection_action action)
 {
 	static atomic_t allow_proceed = ATOMIC_INIT(1);
@@ -1034,8 +1135,11 @@ void __hw_protection_trigger(const char *reason, int ms_until_forced,
 	if (action == HWPROT_ACT_DEFAULT)
 		action = hw_protection_action;
 
-	pr_emerg("HARDWARE PROTECTION %s (%s)\n",
-		 hw_protection_action_str(action), reason);
+	set_psc_reason(reason);
+
+	pr_emerg("HARDWARE PROTECTION %s: %i (%s)\n",
+		 hw_protection_action_str(action), reason,
+		 psc_reason_to_str(reason));
 
 	/* Shutdown should be initiated only once. */
 	if (!atomic_dec_and_test(&allow_proceed))

-- 
2.34.1

