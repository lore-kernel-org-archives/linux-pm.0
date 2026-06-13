Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460A3A5E93;
	Sat, 13 Jun 2026 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388437; cv=none; b=hfWFy6DS3vCuapCdSBSjauL5h+KVethhjqnnUeWvw+mIEPd6iRjI+bfUtPXyQgqs8Che8YXaX/JBSZAAiY6av0R6YQairyejLKoOlE1j+1TdqRq84WqWDaF5MKdzytIXDIQ5bqySrGEIkh5xRKejpvT7TCKvGdu7kIukD1rflAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388437; c=relaxed/simple;
	bh=Hdddptyjk5qgi1PKb0CqHlrQeu5WJHlHYTSleO5Q3nk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CcuJ0t/4LMTs3TGjui+3gwTHwrioxx9DZBg3X1SfdJnxKcxgBFiHrZaIySAdR2RJBOJfAjKby5vb+UzgZVeAUMflDLCozPvzBC+UqQ3mGMbqcqCczWtbrO5unugWgJ6a8NNOi7HNtP9aEAvDcRGjQEokA5bP67nxYVms2xUKrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ9DBRvi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ9DBRvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388436; x=1812924436;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Hdddptyjk5qgi1PKb0CqHlrQeu5WJHlHYTSleO5Q3nk=;
  b=fJ9DBRviEofqFSXF+bm3+566YWNZUrDr6hx2I+TerlyVPWt3pqloIP9n
   n/dLMHOvONNnwuDbVOaK3tWtTPrxj8nkTPIreKKruuSmUJOza/WDkOdUC
   LuPBkFOHk0kUfhbLXg2OsQDo+/7o0MhuZHdh/ys5vWPDu9rRWj6gMKD+n
   Y/4GjZS5/OyuisahmT6JzfypfzDU797JjPBt/pADv/Frh4rFn7NBBpo2H
   joMuJVbOLL4inlz4BcroGsQ1NpI++tjg5YGC24lQwIP96ABG+Kd1zoU3Q
   +8SpCKUMyaaRnDBiaUL85mTEIaujkAkg4n0QPyThog5CTakkIHDMUHLId
   g==;
X-CSE-ConnectionGUID: 8jXeninjTe+NPeV+Dc6UPg==
X-CSE-MsgGUID: eSxhQ5btSHWE417KuqEV6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029421"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029421"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: NnBfsCZ1SJC7HZon5y9OIw==
X-CSE-MsgGUID: RKGn859CQySL/NLvZWN1Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221853"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 13 Jun 2026 15:17:49 -0700
Subject: [PATCH v3 3/6] thermal: intel: Add resources to handle directed
 package-level thermal interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-rneri-directed-therm-intr-v3-3-3a26d1e47fc8@linux.intel.com>
References: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
In-Reply-To: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=2716;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=Hdddptyjk5qgi1PKb0CqHlrQeu5WJHlHYTSleO5Q3nk=;
 b=YPKlNczyz+xarlGAUs9E6lvNBZ4v3CWoWa56WaivekRTvmwxsLeeGrIYwix/A41N9VnKuzpVD
 eEJY94o/LxJBeNNtlH9/ehoJQFaOIaGpmWXrjPZU3DaCXyEtYlcli+O
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

When supported by hardware, a CPU requests to receive directed package-
level thermal interrupts by setting a designated bit in
IA32_THERM_INTERRUPT. It is sufficient to have one CPU per package handling
the interrupt.

Add an array to keep track of those CPUs as well as init and cleanup
functions. A subsequent changeset will designate a CPU per package to
handle the interrupt.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v3:
 * Introduced this patch

Changes in v2:
 * N/A
---
 drivers/thermal/intel/therm_throt.c | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 45a8ef4a608b..8e259c4e5fe8 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -524,6 +524,50 @@ static void thermal_throttle_remove_dev(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &thermal_attr_group);
 }
 
+/*
+ * Accessed from CPU hotplug callbacks and from code that runs while CPU
+ * hotplug is inactive: the init and cleanup paths.
+ * No extra locking needed.
+ */
+static unsigned int *directed_intr_handler_cpus;
+
+static bool directed_thermal_pkg_intr_supported(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_DPTI))
+		return false;
+
+	if (!directed_intr_handler_cpus)
+		return false;
+
+	return true;
+}
+
+static __init void init_directed_pkg_intr(void)
+{
+	int i;
+
+	if (!boot_cpu_has(X86_FEATURE_DPTI))
+		return;
+
+	directed_intr_handler_cpus = kmalloc_array(topology_max_packages(),
+						   sizeof(*directed_intr_handler_cpus),
+						   GFP_KERNEL);
+	if (!directed_intr_handler_cpus)
+		return;
+
+	for (i = 0; i < topology_max_packages(); i++)
+		directed_intr_handler_cpus[i] = nr_cpu_ids;
+}
+
+static void cleanup_directed_pkg_thermal_intr(void)
+{
+	if (!directed_thermal_pkg_intr_supported())
+		return;
+
+	kfree(directed_intr_handler_cpus);
+	directed_intr_handler_cpus = NULL;
+}
+
 /* Get notified when a cpu comes on/off. Be hotplug friendly. */
 static int thermal_throttle_online(unsigned int cpu)
 {
@@ -585,12 +629,19 @@ static __init int thermal_throttle_init_device(void)
 	if (!atomic_read(&therm_throt_en))
 		return 0;
 
+	init_directed_pkg_intr();
+
 	intel_hfi_init();
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/therm:online",
 				thermal_throttle_online,
 				thermal_throttle_offline);
-	return ret < 0 ? ret : 0;
+	if (ret >= 0)
+		return 0;
+
+	cleanup_directed_pkg_thermal_intr();
+
+	return ret;
 }
 device_initcall(thermal_throttle_init_device);
 

-- 
2.43.0

