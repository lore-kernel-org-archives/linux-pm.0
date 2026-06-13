Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7A3A784F;
	Sat, 13 Jun 2026 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388438; cv=none; b=CTs9SLhK10GFJ6AN/xQInVSQ8f/Uk0Apm8UsSQRvF+OEnt/ClgHk9eBA/eZhwXbCkXTh3jbAEqtMt9c7kR1A1KWCeAzRB0pvgd4p32/4D3Fh2A9dSNMXmO/bZvspOQeqv+R61xj4bQt7ysw282mfbAviLJL4tTx9i+JYT5rctcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388438; c=relaxed/simple;
	bh=QQEBZktthJ/JzDzC7T5jtl0FVIOl32QpnA1y2/gfKeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M79WtXebuzOCU0/cMM/K1SQkEVoYJVY/8mlG+YQW+G7+IWJVWHjpBLbwJwXutpJW4QlOnSAwx2WqVFNmudCRIbXCID8AAOcgfIwHOzlKVOA8f1UhRfSf2Wkqkg5pb7e6rRywOUCXagVgQRZge7A+rijCeLzk+ZKisJ5MlJi/F2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyxApqWX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyxApqWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388438; x=1812924438;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QQEBZktthJ/JzDzC7T5jtl0FVIOl32QpnA1y2/gfKeM=;
  b=NyxApqWXzBQ0cLB9RhYw5aZmfN/hqOkYnA96pTGJCUjUfPss0It0agAA
   NAyK7ZVRFEeo8x8oxwth9deePHPewMGdxJ4ZJIV/GXh8DtwsSY1GoKPG3
   QxPtAyvVrHNQJEZuAbDipSsebNSc9wQp8UVTxWdRQLCL6dUMKvMfL4TfZ
   yWg3SphPGquaK2brwIEmlbGmZpc6V44Xcc0vRSq3YAaWlJdSryx7czYaZ
   cpgG9hyDWot7rgaJgYqwuiv/ehUZTppp6Zrw/c1MvKBjYevRihDmvIuse
   Pc6k0fNI31C+GbJ4n6LFLCiaKk3CIr6XtRReKuMkLDe8P+3i0iaAznKj3
   w==;
X-CSE-ConnectionGUID: GbAbXhn7RnGdeScxa4KQLw==
X-CSE-MsgGUID: F26y/yRrTm2UIl9+ftQWwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029430"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: nOb+J0sLShC/BFSPSjv1aA==
X-CSE-MsgGUID: m9EMtLL5TnmXebyzT21IxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221862"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Sat, 13 Jun 2026 15:17:52 -0700
Subject: [PATCH v3 6/6] thermal: intel: Add a syscore shutdown callback for
 kexec reboot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-rneri-directed-therm-intr-v3-6-3a26d1e47fc8@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=2162;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=QQEBZktthJ/JzDzC7T5jtl0FVIOl32QpnA1y2/gfKeM=;
 b=YJGqOwAQYiM6059YoSKs3uUbPkBopt4NFn9BdvCRUAZam9qJv62sZZxvc9q3uFRW6QKEvlGR5
 odVsHsmcMx+DtQa1+u9dF8V7Ei6ZrxO3x1itsplu4EJ6VRa2a9WUJ0E
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A kexec reboot may load a kernel that does not support directed package-
level thermal interrupts. Without a shutdown callback, the directed
interrupt configuration remains enabled across kexec but will not be
handled correctly. In particular, if the CPU designated to receive the
directed interrupt goes offline, no other CPU in the package will receive
it.

Add a syscore shutdown callback to disable directed package-level thermal
interrupts on all packages before a kexec reboot. If the post-kexec kernel
does not enable directed interrupts, it falls back to broadcasting the
interrupt to all CPUs.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v3:
 * Reworded comments.

Changes in v2:
 * Used the disable_all_directed_thermal_pkg_intr() function introduced
   in patch 3.
---
 drivers/thermal/intel/therm_throt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 916b76c0822e..c2980e88af31 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -592,7 +592,8 @@ static bool directed_thermal_pkg_intr_supported(void)
 /*
  * Must be called with cpu_hotplug_lock held to prevent CPUs from going offline
  * while iterating through packages and interrupts must be enabled to avoid
- * deadlocks in SMP function calls.
+ * deadlocks in SMP function calls. The syscore shutdown callback also calls
+ * this function, but runs with CPU hotplug disabled (and interrupts enabled).
  */
 static void disable_directed_thermal_pkg_intr_all(void)
 {
@@ -735,9 +736,15 @@ static int directed_pkg_intr_syscore_suspend(void *data)
 	return 0;
 }
 
+static void directed_pkg_intr_syscore_shutdown(void *data)
+{
+	disable_directed_thermal_pkg_intr_all();
+}
+
 static const struct syscore_ops directed_pkg_intr_pm_ops = {
 	.resume = directed_pkg_intr_syscore_resume,
 	.suspend = directed_pkg_intr_syscore_suspend,
+	.shutdown = directed_pkg_intr_syscore_shutdown,
 };
 
 static struct syscore directed_pkg_intr_pm = {

-- 
2.43.0

