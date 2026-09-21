Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1D4EF133;
	Mon, 21 Sep 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012473; cv=none; b=umfp7rqot/cHuyuGcxYmO9cgaoNdRMiQuPMIp6cuRrB3LN3qidNFDB3Y35ao/Ajy/fO9jp56nkIAhcauRocmk9lKiCtX5ZO75Kgod/6soh6eQScdUQ6XpylqygR66NjhA2v8LSP+yxRDeCkM0f/758si3rhUW/Od3jN90gz2JVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012473; c=relaxed/simple;
	bh=3JNuDbC3MYiW0wD9BU0cQBSagn2V8MECWlf42eQnG5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NUkuHOF7/TZppq9VBvtzQlECI4IHKfM8BEWmKjGpGrkHUxFx4OuOzAWFuexw+iRIp6tHd1lRaSA7KMhmM6mrpR40fIpPL5XKYoDXmoUv6BmJeV4IGDHJixLH5mEFoGRDgbnIkH5dn1fRHfmZjiijgGUsABx/tfVQMFO2GiIykAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJba6/US; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJba6/US"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHNDCm1313647;
	Mon, 21 Sep 2026 17:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D6NbZZHpPoqVn4Ft2AC0hXSIRwrxMSla9Aj6VmbIubU=; b=gJba6/USGTfg+l/N
	eweT4QxrowPVnYBVI6SXB9HqAnZ8YdZgitdI34RcpPddDOcyC2tsgtaKcKygP6Qi
	l9Jy2Jvq9yzW8xCMtrvHMrU0BnIOl+p/EK+iSJA45q1NCE6AY/UaHsNV863xRMrD
	nSs/nyKCl87nUK3OBl0nCSPUoRgQXZ/VtHz1FnrXdEj3JtBNkXldsoVMkojBoAYf
	R2AQICZQpyo6wVFE+w/VUTmW7wveLiqFo9tNlEE95V4YdW51JIuj7S/FxgeCVFXo
	DlUj8RnKvHo/BnP5Fl/mRG+FKwFnT1c05IMNpH1PcsjWfUL7TZPAIMX6/l4ze/8t
	m+FznQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8xer27v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 17:40:42 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHecvS1524350;
	Mon, 21 Sep 2026 17:40:40 GMT
Received: from hu-ffaruque-hyd.qualcomm.com (hu-ffaruque-hyd.qualcomm.com [10.147.245.31])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 68LHebcu1524318;
	Mon, 21 Sep 2026 17:40:39 +0000 (GMT)
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 23:10:30 +0530
Subject: [PATCH 5/6] power: reset: Introduce PSCR Recording Framework for
 Non-Volatile Storage
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pscrr-framework-v1-5-a5ebe994a98a@oss.qualcomm.com>
References: <20260921-pscrr-framework-v1-0-a5ebe994a98a@oss.qualcomm.com>
In-Reply-To: <20260921-pscrr-framework-v1-0-a5ebe994a98a@oss.qualcomm.com>
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
        Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: CAL5cIxUEIVy-S-qB5gVP8l0FZKgUHBS
X-Authority-Analysis: v=2.4 cv=PZhqFShd c=1 sm=1 tr=0 ts=6ab16c1b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=F-jeClLd32UZZCvIPigA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: CAL5cIxUEIVy-S-qB5gVP8l0FZKgUHBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfXwvoiXW3WjZxg
 3xfJqo7NDg7Yj893zUt2ro0liCNpUUKfFJpYCMKWOI3nyzR6LH/gGMV7b7OwkTGV4nP73Taem5+
 izo8jVEfMMz56ULd6v+VBrjYJfo8IBWflkH+gmqAPyT9Qs8eZAeot2iRCQH3hhaDjh9oh1rKpKO
 jF2c/92QxbozaSpbGKRMWALuY9MYcXG1z8bALUesPtAdcOyolIfUNHmO1iAMhjNuTlaTZza8biS
 k2T/d2rYItMAzo204gr6w0cNFz8qQideLSowDeShR9wqDl0cOHonx8J4jFrSECl6cqeC9/HF6uZ
 9ZFKVKaODLfhscp07w9s6h8blLGyblggsYqHoG/GdnyI9y3UhU6Me9rEmjeLvsBWd7O+8A9PIKC
 6cV4wOZR08YZGoAYHw6B/MGQzRoDtR4rH248a61OEi0Tc/JWw5+JTvTonR/4uBCybQ/bjK3Lrcu
 /MFt2d2wbzsZXhzOpZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI1OCBTYWx0ZWRfX4Qj86GTpqsga
 3QsWNjwF2IbBufCaOhXD/eh67GM13xajdJIfT8znX9BXbFhV5/GzhKusMYJaPETquLMbgp1sN1T
 X4GUoB2gGiTcTNROxNGyuA5Wcz6kr8w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210258

Introduce the Power State Change Reasons Recording (PSCRR) framework: a
generic mechanism to record why the last power state change (shutdown or
reboot) happened - under-voltage, thermal, watchdog, software-triggered,
etc. - so a postmortem reason survives a reboot or an abrupt power loss.

PSCRR is built around providers. A provider is either a hardware reason
source (a PMIC, SoC reset controller or watchdog exposing a reset cause)
or a recorder that persists the reason across a power cycle (an NVMEM or
RTC scratch cell). Each provider gets a directory under
/sys/kernel/pscrr/providerN/ exposing its name, backing device, the set
of observed reasons (as tokens), its capabilities, the reasons it
supports and - for recorders - a record policy. The reason set is
deliberately not collapsed to a single winning cause, since resets are
often multi-causal.

Reasons are the numeric enum psc_reason values from reboot.h, shared with
the POWER_ON_REASON_* vocabulary, so they store compactly in small
battery-backed cells. The current reason (get/set_psc_reason(), set by
the thermal/regulator/hw_protection paths) is written to every recorder
from the reboot notifier.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reported-by: Francesco Valla <francesco@valla.it>
Closes: https://lore.kernel.org/all/178749889134.204450.5740187753642158305.b4-review@b4/
Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

changes v13:
- Narrow pscrr_lock usage in pscrr_provider_register() to only protect
  pscrr_dirs list updates.
- Check pscrr_root before allocation and limit locking around
  ida_alloc() and kobject/sysfs setup.
changes v12:
- rework into a multi-provider framework: one sysfs directory per
  provider instead of a single backend
- add per-provider capabilities, supported_reasons and record policy
- register providers through a const ops table via
  (devm_)pscrr_provider_register()
- report reasons as parsable tokens
- move the sources under drivers/power/reset/pscrr/
- add a MAINTAINERS entry; PSCRR depends on POWER_RESET
- drop Reviewed-by: Matti Vaittinen; the framework was substantially
  reworked since it was given
changes v10:
- make g_pscrr static
changes v8:
- introduce struct pscrr_core to encapsulate backend and locking
- replace global mutex and backend pointer with centralized pscrr_core
- use DEFINE_GUARD() + guard(g_pscrr) for scoped mutex locking
- simplify code using local backend pointer after locking
- prepare code structure for future multi-backend support
changes v7:
- make write_reason optional
- update documentation
changes v6:
- move enum pscr_reason to kernel reboot core
- move reason storage to reboot core
- add locking
---
 MAINTAINERS                        |  11 +
 drivers/power/reset/Kconfig        |   2 +
 drivers/power/reset/Makefile       |   1 +
 drivers/power/reset/pscrr/Kconfig  |  33 ++
 drivers/power/reset/pscrr/Makefile |   2 +
 drivers/power/reset/pscrr/pscrr.c  | 633 +++++++++++++++++++++++++++++++++++++
 include/linux/pscrr.h              | 107 +++++++
 7 files changed, 789 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05215fcc18a5..a7145dbb6eb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21967,6 +21967,17 @@ F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 F:	drivers/power/sequencing/pwrseq-pcie-m2.c
 
+POWER STATE CHANGE REASON RECORDING (PSCRR)
+M:	Oleksij Rempel <o.rempel@pengutronix.de>
+M:	Faruque Ansari <faruque.ansari@oss.qualcomm.com>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-pscrr
+F:	drivers/power/reset/pscrr/
+F:	include/linux/pscrr.h
+F:	tools/testing/selftests/pscrr/
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index bce996bbef28..f24ff89dd94e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -377,3 +377,5 @@ config POWER_RESET_QEMU_VIRT_CTRL
 	  provides this controller, such as the m68k virt machine.
 
 endif
+
+source "drivers/power/reset/pscrr/Kconfig"
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index e31cab4ba78e..c73dc747e36c 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
+obj-$(CONFIG_PSCRR) += pscrr/
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/pscrr/Kconfig b/drivers/power/reset/pscrr/Kconfig
new file mode 100644
index 000000000000..72de82731b53
--- /dev/null
+++ b/drivers/power/reset/pscrr/Kconfig
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig PSCRR
+	bool "Power State Change Reasons Recording (PSCRR) Framework"
+	depends on POWER_RESET
+	help
+	  Enables the Power State Change Reasons Recording (PSCRR) framework.
+
+	  PSCRR records why the system last shut down or rebooted into
+	  non-volatile storage, so the reason survives the reset and can be
+	  read by the bootloader or early user space on the next boot. Reasons
+	  come from software (thermal or regulator hardware-protection events,
+	  a watchdog pretimeout, a kernel panic, a controlled reboot) or from
+	  hardware reset-cause registers (PMIC, SoC reset controller, watchdog).
+
+	  It helps whenever the real cause would otherwise be lost or ambiguous
+	  on the next boot, for example:
+
+	  - the reset is abrupt and block storage (eMMC/NAND) may not survive
+	    it; on systems that can detect the event in time - such as an
+	    imminent power loss with a short backup-capacitor window - the
+	    reason can still be persisted first;
+
+	  - the hardware does not preserve the cause and the boot looks like a
+	    plain power-on reset, e.g. a watchdog pretimeout that escalates
+	    into a panic reboot would otherwise be indistinguishable from a
+	    POR.
+
+	  The framework is extensible and exposes software-defined and
+	  hardware-reported reasons through one interface. Sudden power cuts,
+	  CPU freezes or other uncontrolled resets may still go unrecorded
+	  unless hardware provides the reset cause.
+
+	  If unsure, say N.
diff --git a/drivers/power/reset/pscrr/Makefile b/drivers/power/reset/pscrr/Makefile
new file mode 100644
index 000000000000..e5530a858971
--- /dev/null
+++ b/drivers/power/reset/pscrr/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PSCRR) += pscrr.o
diff --git a/drivers/power/reset/pscrr/pscrr.c b/drivers/power/reset/pscrr/pscrr.c
new file mode 100644
index 000000000000..ab0974d0423e
--- /dev/null
+++ b/drivers/power/reset/pscrr/pscrr.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pscrr.c - Core Power State Change Reason Recording
+ *
+ * PSCRR records why the last power state change (shutdown/reboot) happened.
+ * Reasons come from providers: hardware reset-cause registers (PMIC, SoC reset
+ * controller, watchdog), persistent recorders (NVMEM/RTC scratch), the
+ * bootloader's device-tree /chosen/reset-source (a built-in provider here), or
+ * test stubs. Each provider gets a directory under /sys/kernel/pscrr/ and reports
+ * the full set of reasons it observed - the picture is deliberately not
+ * collapsed to a single "winning" cause, since resets are often multi-causal.
+ *
+ * Sysfs (per provider, under /sys/kernel/pscrr/providerN/):
+ *   name               ro  human label of the provider
+ *   device             symlink to the backing device (if any)
+ *   reason             the provider's reason set, as tokens; writable (record
+ *                      one reason) when the provider supports it
+ *   caps               ro  non-default capabilities ("writable"); empty for a
+ *                      read-only, single-slot provider
+ *   supported_reasons  ro  reasons this provider can report or record
+ *   record_policy      recorders only: keep the "first" or "last" reason
+ *                      recorded in a power cycle
+ *
+ * The kernel keeps the first (root cause) and last power-state-change reason
+ * (get_psc_first_reason()/get_psc_reason(), set by the thermal, regulator and
+ * hw_protection paths). At reboot each recorder is given the first or the last
+ * reason according to its record policy.
+ *
+ * Copyright (C) 2025 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ */
+
+#define pr_fmt(fmt) "PSCRR: " fmt
+
+#include <linux/bitmap.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/pscrr.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+static struct kobject *pscrr_root;
+static DEFINE_MUTEX(pscrr_lock);
+static LIST_HEAD(pscrr_dirs);
+static DEFINE_IDA(pscrr_ida);
+
+/*
+ * Record policy: when several reasons are recorded in one power cycle, keep the
+ * first (root cause) or overwrite with the last. Global, tunable via sysfs.
+ */
+enum pscrr_record_policy {
+	PSCRR_RECORD_FIRST,
+	PSCRR_RECORD_LAST,
+};
+
+/*
+ * Per-provider sysfs directory. Core-owned and self-freeing on kobject_put(),
+ * so its lifetime is decoupled from the caller-owned struct pscrr_provider.
+ */
+struct pscrr_provider_dir {
+	struct kobject kobj;
+	struct pscrr_provider *provider;
+	struct list_head node;
+	int id;
+	enum pscrr_record_policy policy;	/* single-slot recorder: keep first/last */
+	bool recorded;		/* a reason was recorded this power cycle */
+};
+
+static inline struct pscrr_provider_dir *to_pscrr_dir(struct kobject *kobj)
+{
+	return container_of(kobj, struct pscrr_provider_dir, kobj);
+}
+
+/*----------------------------------------------------------------------*/
+/* Per-provider attributes */
+/*----------------------------------------------------------------------*/
+
+static ssize_t name_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", to_pscrr_dir(kobj)->provider->name);
+}
+
+static struct kobj_attribute pscrr_name_attr = __ATTR_RO(name);
+
+static int pscrr_parse_reason(const char *buf, enum psc_reason *out)
+{
+	unsigned int val;
+
+	/* Accept either a decimal index or a reason token. */
+	if (!kstrtouint(buf, 0, &val)) {
+		if (val >= PSCR_REASON_COUNT)
+			return -ERANGE;
+		*out = val;
+		return 0;
+	}
+
+	return psc_reason_from_token(buf, out);
+}
+
+static ssize_t reason_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	struct pscrr_provider *p = to_pscrr_dir(kobj)->provider;
+	DECLARE_BITMAP(reasons, PSCR_REASON_COUNT);
+	ssize_t len = 0;
+	int bit, ret;
+
+	bitmap_zero(reasons, PSCR_REASON_COUNT);
+
+	ret = p->ops->read_reasons(p, reasons);
+	if (ret)
+		return ret;
+
+	for_each_set_bit(bit, reasons, PSCR_REASON_COUNT)
+		len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
+				     psc_reason_to_token(bit));
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+/* Record @reason into @dir honouring the global record policy. */
+static int pscrr_do_record(struct pscrr_provider_dir *dir, enum psc_reason reason)
+{
+	struct pscrr_provider *p = dir->provider;
+	int ret;
+
+	if (!p->ops->write_reason)
+		return -EPERM;
+
+	/*
+	 * PSCR_UNKNOWN clears the slot and releases the latch, regardless of
+	 * policy, so a reason recorded afterwards is taken again.
+	 */
+	if (reason == PSCR_UNKNOWN) {
+		ret = p->ops->write_reason(p, reason);
+		if (ret)
+			return ret;
+
+		dir->recorded = false;
+		return 0;
+	}
+
+	/* Reject reasons the provider does not advertise (NULL == all). */
+	if (p->supported_reasons && !test_bit(reason, p->supported_reasons))
+		return -EOPNOTSUPP;
+
+	/* "first" policy: keep the first reason recorded this power cycle. */
+	if (dir->policy == PSCRR_RECORD_FIRST && dir->recorded)
+		return 0;
+
+	ret = p->ops->write_reason(p, reason);
+	if (ret)
+		return ret;
+
+	dir->recorded = true;
+
+	return 0;
+}
+
+static ssize_t reason_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct pscrr_provider_dir *dir = to_pscrr_dir(kobj);
+	enum psc_reason reason;
+	int ret;
+
+	if (!dir->provider->ops->write_reason)
+		return -EPERM;
+
+	ret = pscrr_parse_reason(buf, &reason);
+	if (ret)
+		return ret;
+
+	/* Serialise the record state against concurrent stores and the notifier. */
+	scoped_guard(mutex, &pscrr_lock)
+		ret = pscrr_do_record(dir, reason);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute pscrr_reason_attr =
+	__ATTR(reason, 0644, reason_show, reason_store);
+
+static ssize_t caps_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct pscrr_provider *p = to_pscrr_dir(kobj)->provider;
+	ssize_t len = 0;
+
+	/* Readable and single-slot are the defaults and not listed. */
+	if (p->ops->write_reason)
+		len += sysfs_emit_at(buf, len, "writable");
+
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+
+static struct kobj_attribute pscrr_caps_attr = __ATTR_RO(caps);
+
+static ssize_t supported_reasons_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	struct pscrr_provider *p = to_pscrr_dir(kobj)->provider;
+	const unsigned long *sup = p->supported_reasons;
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < PSCR_REASON_COUNT; i++) {
+		if (sup && !test_bit(i, sup))	/* NULL means all */
+			continue;
+		len += sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
+				     psc_reason_to_token(i));
+	}
+
+	return len + sysfs_emit_at(buf, len, "\n");
+}
+
+static struct kobj_attribute pscrr_supported_attr =
+	__ATTR(supported_reasons, 0444, supported_reasons_show, NULL);
+
+static ssize_t record_policy_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	struct pscrr_provider_dir *dir = to_pscrr_dir(kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			  READ_ONCE(dir->policy) == PSCRR_RECORD_FIRST ?
+			  "first" : "last");
+}
+
+static ssize_t record_policy_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct pscrr_provider_dir *dir = to_pscrr_dir(kobj);
+
+	guard(mutex)(&pscrr_lock);
+
+	if (sysfs_streq(buf, "first"))
+		WRITE_ONCE(dir->policy, PSCRR_RECORD_FIRST);
+	else if (sysfs_streq(buf, "last"))
+		WRITE_ONCE(dir->policy, PSCRR_RECORD_LAST);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static struct kobj_attribute pscrr_record_policy_attr =
+	__ATTR(record_policy, 0644, record_policy_show, record_policy_store);
+
+static struct attribute *pscrr_dir_attrs[] = {
+	&pscrr_name_attr.attr,
+	&pscrr_reason_attr.attr,
+	&pscrr_caps_attr.attr,
+	&pscrr_supported_attr.attr,
+	&pscrr_record_policy_attr.attr,
+	NULL,
+};
+
+static umode_t pscrr_dir_is_visible(struct kobject *kobj, struct attribute *attr,
+				    int n)
+{
+	struct pscrr_provider *p = to_pscrr_dir(kobj)->provider;
+
+	/* A provider without write_reason() exposes reason read-only. */
+	if (attr == &pscrr_reason_attr.attr && !p->ops->write_reason)
+		return 0444;
+
+	/* record_policy only applies to a (single-slot) recorder. */
+	if (attr == &pscrr_record_policy_attr.attr && !p->ops->write_reason)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group pscrr_dir_group = {
+	.attrs		= pscrr_dir_attrs,
+	.is_visible	= pscrr_dir_is_visible,
+};
+
+static const struct attribute_group *pscrr_dir_groups[] = {
+	&pscrr_dir_group,
+	NULL,
+};
+
+static void pscrr_dir_release(struct kobject *kobj)
+{
+	kfree(to_pscrr_dir(kobj));
+}
+
+static const struct kobj_type pscrr_dir_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= pscrr_dir_release,
+	.default_groups	= pscrr_dir_groups,
+};
+
+/*----------------------------------------------------------------------*/
+/* Provider registration */
+/*----------------------------------------------------------------------*/
+
+/**
+ * pscrr_provider_register - register a power state change reason provider
+ * @p: caller-owned provider description
+ *
+ * Creates /sys/kernel/pscrr/providerN/ with "name" and "reason" attributes
+ * and, when @p->dev is set, a "device" symlink. @p->reason is writable when
+ * @p provides write_reason(). The provider must outlive the matching
+ * pscrr_provider_unregister() call.
+ *
+ * Return: 0 on success or a negative errno.
+ */
+int pscrr_provider_register(struct pscrr_provider *p)
+{
+	struct pscrr_provider_dir *dir;
+	int ret;
+
+	if (!p || !p->name || !p->ops || !p->ops->read_reasons)
+		return -EINVAL;
+
+	/*
+	 * pscrr_root is set once at core init and cleared at core exit;
+	 * neither transition is serialised against this function by
+	 * pscrr_lock, so check it up front rather than under the lock below.
+	 */
+	if (!pscrr_root)
+		return -ENODEV;
+
+	dir = kzalloc_obj(*dir);
+	if (!dir)
+		return -ENOMEM;
+
+	dir->provider = p;
+	dir->policy = PSCRR_RECORD_FIRST;
+
+	/* ida_alloc() and the kobject/sysfs calls below are individually thread-safe. */
+	dir->id = ida_alloc(&pscrr_ida, GFP_KERNEL);
+	if (dir->id < 0) {
+		ret = dir->id;
+		kfree(dir);
+		return ret;
+	}
+
+	ret = kobject_init_and_add(&dir->kobj, &pscrr_dir_ktype, pscrr_root,
+				   "provider%d", dir->id);
+	if (ret) {
+		/*
+		 * kobject_init_and_add() failed: per its contract only
+		 * kobject_put() may follow, no kobject_del().
+		 */
+		ida_free(&pscrr_ida, dir->id);
+		kobject_put(&dir->kobj);
+		return ret;
+	}
+
+	if (p->dev) {
+		ret = sysfs_create_link(&dir->kobj, &p->dev->kobj, "device");
+		if (ret)
+			goto err_del;
+	}
+
+	/* pscrr_lock only serialises pscrr_dirs against concurrent (un)registration. */
+	scoped_guard(mutex, &pscrr_lock)
+		list_add_tail(&dir->node, &pscrr_dirs);
+
+	return 0;
+
+err_del:
+	kobject_del(&dir->kobj);
+	ida_free(&pscrr_ida, dir->id);
+	kobject_put(&dir->kobj);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pscrr_provider_register);
+
+/**
+ * pscrr_provider_unregister - remove a previously registered provider
+ * @p: the provider passed to pscrr_provider_register()
+ */
+void pscrr_provider_unregister(struct pscrr_provider *p)
+{
+	struct pscrr_provider_dir *dir = NULL, *iter;
+
+	scoped_guard(mutex, &pscrr_lock) {
+		list_for_each_entry(iter, &pscrr_dirs, node) {
+			if (iter->provider == p) {
+				dir = iter;
+				list_del(&dir->node);
+				break;
+			}
+		}
+	}
+
+	if (!dir)
+		return;
+
+	/*
+	 * Tear the sysfs directory down outside pscrr_lock: kobject_del()
+	 * drains in-flight reason/record_policy stores, which take pscrr_lock,
+	 * so holding it here would deadlock. Release the id only once the
+	 * directory is gone, so a concurrent register cannot reuse it and
+	 * collide on the providerN name.
+	 */
+	if (p->dev)
+		sysfs_remove_link(&dir->kobj, "device");
+	kobject_del(&dir->kobj);
+	ida_free(&pscrr_ida, dir->id);
+	kobject_put(&dir->kobj);
+}
+EXPORT_SYMBOL_GPL(pscrr_provider_unregister);
+
+static void pscrr_provider_devm_release(void *p)
+{
+	pscrr_provider_unregister(p);
+}
+
+/**
+ * devm_pscrr_provider_register - device-managed reason provider registration
+ * @dev: device the provider belongs to; also backs the "device" symlink
+ * @name: human-readable provider label
+ * @ops: provider callback table; read_reasons() is required, write_reason() is
+ *	 optional and makes the provider a recorder
+ * @supported_reasons: bitmap of the reasons the provider supports, or NULL
+ *	 for all; set before the provider is exposed in sysfs
+ * @priv: provider private data, handed back to the @ops callbacks
+ *
+ * Allocates and registers a struct pscrr_provider and schedules its
+ * unregistration when @dev is unbound, so the caller keeps no reference to it.
+ *
+ * Return: the registered provider on success or an ERR_PTR() on failure. When
+ * CONFIG_PSCRR is disabled the call resolves to a stub returning NULL, so
+ * callers need no IS_ENABLED() guard.
+ */
+struct pscrr_provider *
+devm_pscrr_provider_register(struct device *dev, const char *name,
+			     const struct pscrr_provider_ops *ops,
+			     const unsigned long *supported_reasons, void *priv)
+{
+	struct pscrr_provider *p;
+	int ret;
+
+	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	p->name = name;
+	p->dev = dev;
+	p->ops = ops;
+	p->supported_reasons = supported_reasons;
+	p->priv = priv;
+
+	ret = pscrr_provider_register(p);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_add_action_or_reset(dev, pscrr_provider_devm_release, p);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(devm_pscrr_provider_register);
+
+/*----------------------------------------------------------------------*/
+/* Record path: reboot notifier writes the current reason to recorders */
+/*----------------------------------------------------------------------*/
+
+/*
+ * Record the current power-state-change reason into every provider, giving
+ * each the first (root cause) or the last reason according to its record
+ * policy. The kernel keeps both, so "first" is meaningful even when later
+ * events overwrite the last reason. The caller holds pscrr_lock, or runs where
+ * the provider list is stable (panic).
+ */
+static void pscrr_record_current(void)
+{
+	enum psc_reason first = get_psc_first_reason();
+	enum psc_reason last = get_psc_reason();
+	struct pscrr_provider_dir *dir;
+
+	list_for_each_entry(dir, &pscrr_dirs, node)
+		pscrr_do_record(dir, dir->policy == PSCRR_RECORD_FIRST ?
+					     first : last);
+}
+
+static int pscrr_reboot_notifier(struct notifier_block *nb,
+				 unsigned long action, void *unused)
+{
+	guard(mutex)(&pscrr_lock);
+
+	/*
+	 * A reboot, halt or power-off that reaches here with no more specific
+	 * reason is software-initiated by definition. Record it as such rather
+	 * than leaving it unattributed; a real cause set earlier (thermal,
+	 * under-voltage, ...) is already latched and left untouched.
+	 */
+	if (get_psc_reason() == PSCR_UNKNOWN)
+		set_psc_reason(PSCR_SOFTWARE);
+
+	pscrr_record_current();
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pscrr_reboot_nb = {
+	.notifier_call = pscrr_reboot_notifier,
+};
+
+/*----------------------------------------------------------------------*/
+/* Built-in provider: device-tree /chosen/reset-source                  */
+/*----------------------------------------------------------------------*/
+
+/*
+ * Bootloaders such as barebox record the SoC reset cause in the standard
+ * device-tree /chosen/reset-source property. When it is present, surface it as
+ * a read-only, device-less provider so the bootloader's view of the last reset
+ * shows up next to any hardware or software providers - the framework just
+ * reads the property already there, with no dedicated node or new binding.
+ */
+static const struct {
+	const char *name;
+	enum psc_reason reason;
+} pscrr_reset_source_map[] = {
+	{ "POR",      PSCR_POWER_ON },
+	{ "RST",      PSCR_SOFTWARE },
+	{ "WDG",      PSCR_WATCHDOG },
+	{ "THERM",    PSCR_OVER_TEMPERATURE },
+	{ "EXT",      PSCR_EXTERNAL },
+	{ "BROWNOUT", PSCR_UNDER_VOLTAGE },
+};
+
+static const unsigned long
+pscrr_reset_source_supported[BITS_TO_LONGS(PSCR_REASON_COUNT)] = {
+	BIT(PSCR_UNDER_VOLTAGE) | BIT(PSCR_OVER_TEMPERATURE) |
+	BIT(PSCR_POWER_ON) | BIT(PSCR_WATCHDOG) | BIT(PSCR_SOFTWARE) |
+	BIT(PSCR_EXTERNAL),
+};
+
+/* Parsed once at init; read back by the provider's read_reasons(). */
+static enum psc_reason pscrr_reset_source_reason = PSCR_UNKNOWN;
+
+static int pscrr_reset_source_read(struct pscrr_provider *p,
+				   unsigned long *reasons)
+{
+	set_bit(pscrr_reset_source_reason, reasons);
+
+	return 0;
+}
+
+static const struct pscrr_provider_ops pscrr_reset_source_ops = {
+	.read_reasons = pscrr_reset_source_read,
+};
+
+static struct pscrr_provider pscrr_reset_source_provider = {
+	.name			= "reset-source",
+	.ops			= &pscrr_reset_source_ops,
+	.supported_reasons	= pscrr_reset_source_supported,
+};
+
+static void __init pscrr_register_reset_source(void)
+{
+	const char *name;
+	int i, ret;
+
+	if (!IS_ENABLED(CONFIG_OF) || !of_chosen)
+		return;
+
+	if (of_property_read_string(of_chosen, "reset-source", &name))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(pscrr_reset_source_map); i++)
+		if (!strcmp(name, pscrr_reset_source_map[i].name)) {
+			pscrr_reset_source_reason = pscrr_reset_source_map[i].reason;
+			break;
+		}
+
+	ret = pscrr_provider_register(&pscrr_reset_source_provider);
+	if (ret)
+		pr_warn("failed to register the reset-source provider: %d\n", ret);
+}
+
+/*----------------------------------------------------------------------*/
+/* Module init/exit */
+/*----------------------------------------------------------------------*/
+
+static int __init pscrr_core_init(void)
+{
+	int ret;
+
+	pscrr_root = kobject_create_and_add("pscrr", kernel_kobj);
+	if (!pscrr_root)
+		return -ENOMEM;
+
+	ret = register_reboot_notifier(&pscrr_reboot_nb);
+	if (ret) {
+		kobject_put(pscrr_root);
+		pscrr_root = NULL;
+		return ret;
+	}
+
+	pscrr_register_reset_source();
+
+	return 0;
+}
+
+static void __exit pscrr_core_exit(void)
+{
+	pscrr_provider_unregister(&pscrr_reset_source_provider);
+	unregister_reboot_notifier(&pscrr_reboot_nb);
+	kobject_put(pscrr_root);
+	pscrr_root = NULL;
+	ida_destroy(&pscrr_ida);
+}
+
+/* Bring the core up before device drivers probe and register providers. */
+subsys_initcall(pscrr_core_init);
+module_exit(pscrr_core_exit);
+
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_AUTHOR("Faruque Ansari <faruque.ansari@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Power State Change Reason Recording (PSCRR) core");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pscrr.h b/include/linux/pscrr.h
new file mode 100644
index 000000000000..330d6ac191bd
--- /dev/null
+++ b/include/linux/pscrr.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pscrr.h - Public header for Power State Change Reason Recording (PSCRR).
+ *
+ * Copyright (C) 2025 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
+ */
+
+#ifndef __PSCRR_H__
+#define __PSCRR_H__
+
+#include <linux/reboot.h>
+
+struct device;
+struct pscrr_provider;
+
+/**
+ * struct pscrr_provider_ops - Provider callbacks.
+ * @read_reasons: Fill @reasons with the complete set this source observed.
+ *		@reasons is a bitmap of PSCR_REASON_COUNT bits; set members
+ *		with set_bit(PSCR_x, reasons). Return 0 on success or a
+ *		negative errno. Required. Driver state is reached via p->priv.
+ * @write_reason: Persist @reason. Called from the reboot notifier for
+ *		recorder-capable providers so the cause survives the power
+ *		cycle. Leave NULL for read-only hardware sources.
+ *
+ * A const ops table per provider type; extend it with new callbacks without
+ * touching the registration signature or existing callers.
+ */
+struct pscrr_provider_ops {
+	int (*read_reasons)(struct pscrr_provider *p, unsigned long *reasons);
+	int (*write_reason)(struct pscrr_provider *p, enum psc_reason reason);
+};
+
+/**
+ * struct pscrr_provider - A source (and optionally recorder) of power state
+ *			   change reasons.
+ *
+ * A provider represents one place the system can learn *why* the last power
+ * state change happened: a hardware reset-cause register (PMIC, SoC SRC,
+ * watchdog), a persistent recorder (NVMEM/RTC scratch), or a test stub. Each
+ * registered provider gets its own directory under /sys/kernel/pscrr/, so the
+ * full, un-prioritised picture is visible: several providers - and several
+ * reasons within one provider - can be reported simultaneously.
+ *
+ * @name:	Human-readable label, exported as the "name" attribute. The
+ *		directory itself is core-indexed (providerN), so this need not
+ *		be unique. Required.
+ * @dev:	Backing device. When set it is exported as the "device" symlink
+ *		in the provider directory, tying the reason to real hardware.
+ *		May be NULL (e.g. for a test provider).
+ * @ops:	Provider callbacks. Required.
+ * @supported_reasons: Bitmap of the reasons this provider can store or report,
+ *		limited e.g. by the storage size. 0 means all reasons.
+ * @priv:	Provider private data, passed back through the callbacks.
+ *
+ * Providers are readable and single-slot by default; only capabilities beyond
+ * that (currently: writable) are advertised.
+ */
+struct pscrr_provider {
+	const char *name;
+	struct device *dev;
+	const struct pscrr_provider_ops *ops;
+	const unsigned long *supported_reasons;
+	void *priv;
+};
+
+#if IS_ENABLED(CONFIG_PSCRR)
+int pscrr_provider_register(struct pscrr_provider *p);
+void pscrr_provider_unregister(struct pscrr_provider *p);
+
+/**
+ * devm_pscrr_provider_register - allocate, fill and register a provider
+ * @dev: device the provider belongs to (also the "device" symlink target)
+ * @name: provider label
+ * @ops: provider callbacks
+ * @supported_reasons: bitmap of supported reasons, or NULL for all
+ * @priv: driver state passed back through the callbacks
+ *
+ * The provider is unregistered automatically on device teardown.
+ *
+ * Return: the provider on success, ERR_PTR() on failure, or NULL when PSCRR
+ * is not built (so the caller need not guard the call).
+ */
+struct pscrr_provider *
+devm_pscrr_provider_register(struct device *dev, const char *name,
+			     const struct pscrr_provider_ops *ops,
+			     const unsigned long *supported_reasons, void *priv);
+#else
+static inline int pscrr_provider_register(struct pscrr_provider *p)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pscrr_provider_unregister(struct pscrr_provider *p)
+{
+}
+
+static inline struct pscrr_provider *
+devm_pscrr_provider_register(struct device *dev, const char *name,
+			     const struct pscrr_provider_ops *ops,
+			     const unsigned long *supported_reasons, void *priv)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __PSCRR_H__ */

-- 
2.34.1

