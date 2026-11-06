Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969946;
	b=ZTa35X5UKOCCtyn3W8S8KJrhE866C0QwdykFllRJHShJTqsTwdLccnXmvw/qsa2SV2u3
	 bW3HbApcCkxtkWzRGfDVIYRq2fLsSNp1hVH9+Pz3PXx4xv/KHDHIa8nN31ft8qfuDhJkE
	 8zXDWjBZWOyuYySaEfyKggajXnbCUh7Axh5uVmJiwX9rVPyFNVIJZ0uESkI3ReVl805sd
	 ruy4eXMbDGe5LOZhe6YB2e6ma0gz0AxmuJTu1tp+0VMCQa/axZnbr4zW2K6+Op/livqcR
	 5oc7dpP81UK38YXktOdOF3spYX/VzlAyiI5roN/nOn5Kd1/V+Uv2Mqfa266goVKyXiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969946;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vPtjdLiKO/Ati7pY8AaqVFbauWBfD/pZ1ZqpyNDK4qo=;
	b=5XDxELqTvr6vfmAlmSLeapDvUPQW68dfNsy6ueNO34g4aSojggjjReO5eoybqfoRYXHZ
	 A0NxiIOurC25PVYHs4KAnoaAMiJQLKzMk+h3qLZPcmsgvPjnPB/+cElrZ9lMABRMbzWsI
	 tojrch4EVikxEXV43FDRAaWIB+udmX1GBPVfiRMPJT3UVLjB+PxzQR3q4bKnPVT7kZoQF
	 aEzZuFg9UyurjLe7aatOcWS3xe+LJ4mkbLfoXmclBx5Q3+Ov46bXxE4nbTlzIpYQ26vQr
	 foKZpmTjsg+gaO4dFpf3nDEOvIQiEhhp/h6mzRHk9bHxjqeeheJsDWk02UFK+pSBH0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Ljw/9XVB";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE4606A326;
	Fri,  6 Nov 2026 12:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AE4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ljw/9XVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793969945; x=1825505945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qswi56liKTAx57hwhw9cy6zNa/7IdbWzaDP8NEQ6i9Q=;
  b=Ljw/9XVBrjbp/XWSIVu3CJuyEfN7e02u140BOJMUXHBUbMylP25VsbSb
   E9/GllANtJq6LGLTk2yJwYRP8lHLBX704y128E9YMpdGJuq8sqK0+qxSH
   mWgzrktkEFIKo6rcmr8efjxLR31s/+r5PcM/s9Y1rmgZr2xp+E4S7Tng8
   aPnIUGYNV58t+sVt/dLiVYdPjqlJrIE2wSHNouf2HoYw3V0Vm2VADYI+x
   g5mv6MCEK/zsEGbeXNHkT+I7r+g5h3z2IoPutOLTXa/CUdHUFrqT7zbpg
   NsjgWkD3xCGE2kTfiCVbFuBxBDv9RYbs2+HjnoBGmtj+edOyJbLpWRGU6
   A==;
X-CSE-ConnectionGUID: EvgM0OdOQ+2jInbFn7lJVA==
X-CSE-MsgGUID: /r2kws+PS/SsWNzZ1ugzWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2658877"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2658877"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 04:59:05 -0800
X-CSE-ConnectionGUID: iWSQ/PFuTH+MI32Q85KGKA==
X-CSE-MsgGUID: 4baLhtxdRCqmtjyLQMiisg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7438465"
Received: from senthil-nuc10i7fnh.iind.intel.com ([10.223.163.42])
  by fmviesa002.fm.intel.com with ESMTP; 06 Nov 2026 04:59:03 -0800
From: Saranya Gopal <saranya.gopal@intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com
Subject: [PATCH v3] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
Date: Fri,  6 Nov 2026 18:28:14 +0530
Message-Id: <20261106125814.1112331-1-saranya.gopal@intel.com>
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

Make acpi_ec_dispatch_gpe() return an int and return -ENODEV when no
EC instance is available so that acpi_s2idle_wake() can handle that
case: on x86, treat the first GPE armed for wake via an _Ixx method
like the EC GPE, mirroring acpi_ec_dispatch_gpe(). That is, report a
wakeup if the status bit is set for any enabled GPE other than the
_Ixx one. Otherwise, cancel the SCI-related wakeup and dispatch the
_Ixx GPE if its status bit is set, so the events behind it can be
processed. Drivers handling genuine wake events are expected to
report them via pm_wakeup_event(), which the common s2idle path will
catch after synchronizing event processing.

If no _Ixx GPEs have been armed, and in the non-x86 fallback, the
previous any-GPE status check is retained. If GPEs are armed via more
than one _Ixx method, the first one is used as the wake indicator and
the remaining ones are treated as regular wake sources.

Fixes: 46767b17fda3 ("ACPI: PM: s2idle: Add _Ixx GPE wake indicator support")
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
---
Changes from v2:
 - Restructured ret checks in sleep.c as per Rafael's suggestion to
   cover !CONFIG_ACPI_EC case that returns -EOPNOTSUPP (Sashiko report)
 - Drop the open-coded scan over acpi_current_gpe_count that conflated
   sequential GPE indices with raw GPE numbers (Sashiko report)
 - Mirror acpi_ec_dispatch_gpe() with the first GPE armed via an _Ixx
   method playing the role of the EC GPE, so the existing single-skip
   acpi_any_gpe_status_set() is sufficient and no ACPICA changes are
   needed.
 - Follow acpi_ec_dispatch_gpe() for the status check and dispatch of
   the _Ixx GPE as well, which also drops the error paths that
   requested a system wakeup in v2 (questioned by Rafael).
 - Add a comment describing acpi_x86_s2idle_check_ixx_gpes(), including
   the role of pm_system_cancel_wakeup().
 - Preserve the previous any-GPE behavior when no _Ixx GPEs have been
   armed for wakeup.
Changes from v1:
 - -ENOTSUP replaced with the correct -EOPNOTSUPP for !CONFIG_PM_SLEEP
   case

 drivers/acpi/ec.c         | 10 +++----
 drivers/acpi/internal.h   |  6 ++--
 drivers/acpi/sleep.c      | 11 +++++--
 drivers/acpi/sleep.h      |  8 +++++
 drivers/acpi/x86/s2idle.c | 61 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 10 deletions(-)

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
index 40f875b265a9..d5435338d6ca 100644
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
+	return -EOPNOTSUPP;
 }
 
 #endif
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df98471..09bd661187b6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -761,6 +761,8 @@ bool acpi_s2idle_wake(void)
 		return pm_wakeup_pending();
 
 	while (pm_wakeup_pending()) {
+		int ret;
+
 		/*
 		 * If IRQD_WAKEUP_ARMED is set for the SCI at this point, the
 		 * SCI has not triggered while suspended, so bail out (the
@@ -789,11 +791,16 @@ bool acpi_s2idle_wake(void)
 
 		/*
 		 * Check non-EC GPE wakeups and if there are none, cancel the
-		 * SCI-related wakeup and dispatch the EC GPE.
+		 * SCI-related wakeup and dispatch the EC GPE.  If there is no
+		 * EC to consult, check the GPEs armed for wakeup via _Ixx
+		 * methods instead.
 		 */
-		if (acpi_ec_dispatch_gpe()) {
+		ret = acpi_ec_dispatch_gpe();
+		if (ret > 0) {
 			pm_pr_dbg("ACPI non-EC GPE wakeup\n");
 			return true;
+		} else if (ret < 0 && acpi_x86_s2idle_check_ixx_gpes()) {
+			return true;
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
index c278ea14c0b3..b79bf0fa9a7f 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -24,6 +24,13 @@
 
 #ifdef CONFIG_SUSPEND
 
+/*
+ * First GPE armed for wake via an _Ixx method, U32_MAX if none.  On
+ * platforms without an ACPI-enumerated EC, this GPE plays the role of
+ * the EC GPE in acpi_ec_dispatch_gpe().
+ */
+static u32 acpi_s2idle_ixx_gpe = U32_MAX;
+
 static void acpi_setup_ixx_gpes(void)
 {
 	acpi_handle gpe_root;
@@ -47,11 +54,65 @@ static void acpi_setup_ixx_gpes(void)
 
 		acpi_mark_gpe_for_wake(NULL, i);
 		acpi_set_gpe_wake_mask(NULL, i, ACPI_GPE_ENABLE);
+		if (acpi_s2idle_ixx_gpe == U32_MAX)
+			acpi_s2idle_ixx_gpe = i;
 
 		pm_pr_dbg("ACPI: GPE0x%02x armed for wake via %s\n", i, gpe_nr_str);
 	}
 }
 
+/*
+ * acpi_x86_s2idle_check_ixx_gpes - Handle an SCI wakeup without an EC
+ *
+ * Called to decide whether or not to wake up the system when an SCI has
+ * triggered during suspend-to-idle on a platform without an EC instance,
+ * mirroring acpi_ec_dispatch_gpe() with the first GPE armed for wake via
+ * an _Ixx method playing the role of the EC GPE.
+ *
+ * Report a wakeup if the status bit is set for any enabled GPE other than
+ * the _Ixx one.  If no _Ixx GPE has been armed, acpi_s2idle_ixx_gpe is
+ * U32_MAX and this amounts to checking all of the GPEs, which is the
+ * previous behavior.
+ *
+ * Otherwise, cancel the pending SCI-related wakeup, so it does not cause
+ * the pm_wakeup_pending() check in the caller to succeed by itself, and
+ * dispatch the _Ixx GPE if it is active, so the events behind it can be
+ * processed.  If any of those events turn out to be genuine wake events,
+ * the drivers handling them are expected to call pm_wakeup_event() and
+ * the caller will catch that via pm_wakeup_pending() after synchronizing
+ * the event processing.
+ */
+bool acpi_x86_s2idle_check_ixx_gpes(void)
+{
+	acpi_event_status status = 0;
+
+	/*
+	 * Report wakeup if the status bit is set for any enabled GPE other
+	 * than the _Ixx one.
+	 */
+	if (acpi_any_gpe_status_set(acpi_s2idle_ixx_gpe))
+		return true;
+
+	if (acpi_s2idle_ixx_gpe == U32_MAX)
+		return false;
+
+	/*
+	 * Cancel the SCI wakeup and dispatch the _Ixx GPE in case there are
+	 * any wakeup events behind it.
+	 */
+	pm_system_cancel_wakeup();
+
+	acpi_get_gpe_status(NULL, acpi_s2idle_ixx_gpe, &status);
+	if (status & ACPI_EVENT_FLAG_STATUS_SET) {
+		pm_pr_dbg("ACPI _Ixx GPE 0x%02x dispatched\n",
+			  acpi_s2idle_ixx_gpe);
+
+		acpi_dispatch_gpe(NULL, acpi_s2idle_ixx_gpe);
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

