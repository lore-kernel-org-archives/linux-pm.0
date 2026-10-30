Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329560;
	b=fQl1DOB3/CXTHf2gs/yNl7BGMu0jHjjksr/fGDS33uR/L7JyxOh2Ihq96ufi3fFmWm7m
	 e/pzUTJ4sI16w17PwH88DpjSlwTNzXuMvkck04XMin+qJvRm5GSQI5PTaEtSRDJQB9Nji
	 jG/EykFnSDGgSCqW5rVJ1L1lIdVQBi2BejrDIHxeKCwbTpZfhggzM4QBwWtAAUCQcWIKu
	 qXUuNKfrObIdzlGmcSVEEIqupMMPWr6/VVyKS5NEC7H9Hb0B/ilgkJi3Yb7o7nhqfdsAN
	 k+VTRWx1UPx0+mU7/oVRdjeimoWiJxeoa4yGLC4O2KsmmWxl7A05W28MOqpVKvJLZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329560;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=J5o+vS2sFseJ0w0aq53vuXL1agaw29iEkhnsgC1EraU=;
	b=3Kyqy9EKvUsZTrz8Q9nO0tLMCKaSdU9VPXlXqMBO82sM3K2NHgCJMra2CWyRyPNaKChF
	 9xptscifi5TqxW+JOIhN8DOkrUqYtAWucrathBQp+Nu1X3E5sj4MpyTfmxsxJwB8g6bW+
	 U1WzP+gk3kLlpAvjQbL8vRfdgQdDB6OPhGD4xRfZ7mzwby1UkTIq2vrhGYPjiv7s4v34B
	 i1q3oW6pRvAx04lwCYQmRHsK+Wxf3QMV5PHkEBU2E1Kit/0r+veX5gqW2Q+EfuhxrDzrd
	 BKNWQxMarJIZK0Ni91AEkCdZxZSuvbbXriqs0P/fNWAWf1j7yssMc/mKnUpYm4y0Agw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i14ih63S;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAB606A31A;
	Fri, 30 Oct 2026 03:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CAB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i14ih63S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793329558; x=1824865558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HR0bqqnm3JToKLFjHr4IOsPwBlJA9AXWb2bpdyZTk1A=;
  b=i14ih63SUtOpJ5G+d66c869dgzf8P8XbxPShDFeAHjG7j+cEyyKenMJl
   iNFz+zgCeA7y8iV6y+p1SGsLqqPWCLiwt8a9d1BEHFfM3Le/piqvm+WhY
   vPk11Y//5TIByXrPZ3r6z22CRdVESoW2KYLZqnQOvlupXgzmOLdTlIIwk
   1+ZZqJIvR8a0YlX8lfSsM+FyY7FgOtJsN2wCvuo0LYm886AQI4L7fPd20
   R6l3Q8rib6xBwBi1VUnfQ8WyuIJOBPbBWSA0+yuVg2mONw1VQjoRaPGcA
   Z+zW3yt98AssqHdXcsws5ogX41fBbUUli5Cr8eUzd5kljiWGESiq898ni
   Q==;
X-CSE-ConnectionGUID: cWyOJHOYQcy7fkcPd5oObg==
X-CSE-MsgGUID: XBb0kxmfT7av29LvInD88w==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2078971"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2078971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 20:05:57 -0700
X-CSE-ConnectionGUID: eaUC7HoDR9ieae7t/4olPg==
X-CSE-MsgGUID: vnYUXE8dS8u5fZoGo5ZMOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5335307"
Received: from senthil-nuc10i7fnh.iind.intel.com ([10.223.163.42])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2026 20:05:55 -0700
From: Saranya Gopal <saranya.gopal@intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com
Subject: [PATCH] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
Date: Fri, 30 Oct 2026 08:35:15 +0530
Message-Id: <20261030030515.3127310-1-saranya.gopal@intel.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When first_ec is NULL, acpi_ec_dispatch_gpe() previously treated any
active GPE as a wake source. On platforms where an _Ixx GPE is shared
by user-wakeup and background events, that can cause unnecessary
wakeups.

Return -ENODEV when no EC instance is available so the s2idle wake
path can handle that case. On x86, check active GPEs against those
registered from _Ixx methods. Preserve immediate wakeup for active
non-_Ixx GPEs; otherwise cancel the SCI wake request and dispatch
active _Ixx GPEs. The common s2idle path then synchronizes event
processing and checks whether a driver requested wakeup. Lookup or
dispatch failures conservatively request wakeup.

The non-x86 fallback retains the previous any-GPE status check.

Fixes: 46767b17fda3 ("ACPI: PM: s2idle: Add _Ixx GPE wake indicator support")
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
---
 drivers/acpi/ec.c         | 10 ++++-----
 drivers/acpi/internal.h   |  6 +++---
 drivers/acpi/sleep.c      | 18 +++++++++-------
 drivers/acpi/sleep.h      |  8 ++++++++
 drivers/acpi/x86/s2idle.c | 43 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 64ad4cfa6208..8be572af4115 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2155,19 +2155,19 @@ static bool acpi_ec_work_in_progress(struct acpi_ec *ec)
 	return ec->events_in_progress + ec->queries_in_progress > 0;
 }
 
-bool acpi_ec_dispatch_gpe(void)
+int acpi_ec_dispatch_gpe(void)
 {
 	bool work_in_progress = false;
 
 	if (!first_ec)
-		return acpi_any_gpe_status_set(U32_MAX);
+		return -ENODEV;
 
 	/*
 	 * Report wakeup if the status bit is set for any enabled GPE other
 	 * than the EC one.
 	 */
 	if (acpi_any_gpe_status_set(first_ec->gpe))
-		return true;
+		return 1;
 
 	/*
 	 * Cancel the SCI wakeup and process all pending events in case there
@@ -2195,7 +2195,7 @@ bool acpi_ec_dispatch_gpe(void)
 	spin_unlock_irq(&first_ec->lock);
 
 	if (!work_in_progress)
-		return false;
+		return 0;
 
 	pm_pr_dbg("ACPI EC GPE dispatched\n");
 
@@ -2212,7 +2212,7 @@ bool acpi_ec_dispatch_gpe(void)
 		spin_unlock_irq(&first_ec->lock);
 	} while (work_in_progress && !pm_wakeup_pending());
 
-	return false;
+	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 40f875b265a9..8a602dea402e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -236,7 +236,7 @@ void acpi_ec_register_opregions(struct acpi_device *adev);
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
-bool acpi_ec_dispatch_gpe(void);
+int acpi_ec_dispatch_gpe(void);
 #endif
 
 #else
@@ -256,9 +256,9 @@ static inline void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit
 static inline void acpi_ec_register_opregions(struct acpi_device *adev) {}
 
 static inline void acpi_ec_flush_work(void) {}
-static inline bool acpi_ec_dispatch_gpe(void)
+static inline int acpi_ec_dispatch_gpe(void)
 {
-	return false;
+	return -ENOTSUP;
 }
 
 #endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df98471..9366c3d927c2 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -787,13 +787,17 @@ bool acpi_s2idle_wake(void)
 			return true;
 		}
 
-		/*
-		 * Check non-EC GPE wakeups and if there are none, cancel the
-		 * SCI-related wakeup and dispatch the EC GPE.
-		 */
-		if (acpi_ec_dispatch_gpe()) {
-			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
-			return true;
+		/* Check EC handling and other GPE wake sources. */
+		{
+			int ret = acpi_ec_dispatch_gpe();
+
+			if (ret == -ENODEV) {
+				if (acpi_x86_s2idle_check_ixx_gpes())
+					return true;
+			} else if (ret > 0) {
+				pm_pr_dbg("ACPI non-EC GPE wakeup\n");
+				return true;
+			}
 		}
 
 		acpi_os_wait_events_complete();
diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 9c3cb109c5d2..955e9c22bf0d 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -20,6 +20,14 @@ extern int acpi_s2idle_prepare(void);
 extern bool acpi_s2idle_wake(void);
 extern void acpi_s2idle_restore(void);
 extern void acpi_s2idle_end(void);
+#if defined(CONFIG_X86) && defined(CONFIG_SUSPEND)
+extern bool acpi_x86_s2idle_check_ixx_gpes(void);
+#else
+static inline bool acpi_x86_s2idle_check_ixx_gpes(void)
+{
+	return acpi_any_gpe_status_set(U32_MAX);
+}
+#endif
 
 extern void acpi_s2idle_setup(void);
 
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index c278ea14c0b3..979684950f24 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
@@ -24,6 +25,8 @@
 
 #ifdef CONFIG_SUSPEND
 
+static DECLARE_BITMAP(acpi_s2idle_ixx_gpes, 256);
+
 static void acpi_setup_ixx_gpes(void)
 {
 	acpi_handle gpe_root;
@@ -47,11 +50,51 @@ static void acpi_setup_ixx_gpes(void)
 
 		acpi_mark_gpe_for_wake(NULL, i);
 		acpi_set_gpe_wake_mask(NULL, i, ACPI_GPE_ENABLE);
+		set_bit(i, acpi_s2idle_ixx_gpes);
 
 		pm_pr_dbg("ACPI: GPE0x%02x armed for wake via %s\n", i, gpe_nr_str);
 	}
 }
 
+bool acpi_x86_s2idle_check_ixx_gpes(void)
+{
+	acpi_handle gpe_device;
+	acpi_event_status status;
+	u32 gpe;
+
+	for (gpe = 0; gpe < acpi_current_gpe_count; gpe++) {
+		if (ACPI_FAILURE(acpi_get_gpe_device(gpe, &gpe_device)))
+			return true;
+
+		if (!gpe_device && gpe < 256 &&
+		    test_bit(gpe, acpi_s2idle_ixx_gpes))
+			continue;
+
+		if (ACPI_FAILURE(acpi_get_gpe_status(gpe_device, gpe, &status)))
+			return true;
+
+		if ((status & ACPI_EVENT_FLAG_STATUS_SET) &&
+		    (status & ACPI_EVENT_FLAG_ENABLE_SET))
+			return true;
+	}
+
+	pm_system_cancel_wakeup();
+
+	for_each_set_bit(gpe, acpi_s2idle_ixx_gpes, 256) {
+		if (ACPI_FAILURE(acpi_get_gpe_status(NULL, gpe, &status)))
+			return true;
+		if (!(status & ACPI_EVENT_FLAG_STATUS_SET) ||
+		    !(status & ACPI_EVENT_FLAG_ENABLE_SET))
+			continue;
+
+		pm_pr_dbg("ACPI _Ixx GPE 0x%02x status set\n", gpe);
+		if (acpi_dispatch_gpe(NULL, gpe) != ACPI_INTERRUPT_HANDLED)
+			return true;
+	}
+
+	return false;
+}
+
 static bool sleep_no_lps0 __read_mostly;
 module_param(sleep_no_lps0, bool, 0644);
 MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
-- 
2.34.1

