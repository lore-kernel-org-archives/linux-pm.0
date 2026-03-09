Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7938F245;
	Mon,  9 Mar 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094842; cv=none; b=tZBfykazDVHOlJ15XYc/qoTjrMZkl02MVk2+RzYa5W/JKtIlHKS6TMd2cM0kJzIrSYjgQ52AttVWkspRMjFiE5sM0m1QRWfwkryrqih2HCfx8mb/7y1Tlz0PLnux+lcnEZSyn8TNNkMVLNBQooAuDssdXDtFn3dF263QzLTic/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094842; c=relaxed/simple;
	bh=8Zw0uqU/tIweMW1edd8EIH+/9emWZlcM4cagIgjN+qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/jw0Pd8/sRhHZEMrgnHwuSWjPjbME7oZLgcE1suztE+7+ZmFeJhEorWVN+lLHLEEbs5C/RuC8h6gnpdFzRSiNFvJWqJFXMelwVReHUxoVcTRAbypM/MnuKkBgOOTJvT1nYnJeUMwW+ZliO8PBcZ1c/j1RPr9mB9dcj1RQGnzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXlY/nyw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXlY/nyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773094841; x=1804630841;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8Zw0uqU/tIweMW1edd8EIH+/9emWZlcM4cagIgjN+qo=;
  b=bXlY/nywE2HpopqB9fdhzIibgWCReEKDriMXjevgsFHo3uKYsEEKXcxO
   ZwIavsZ3Qz93L3Qi054ym3DytPq7W9WkigZpgg8lJGcE20+PTAoBOEXw1
   Aofjee6ibGT8Qn4+wQGM5xfeE2hVSV/ZPcXOUNgboMWkAPc1bLFl1h2lY
   SxmP2WUaO0pjr6cVGbtRXeG1yI1zmEk7DtkKWIWByULpg3VhNJFf+4XEE
   AOv8TzBFNmIUGetseHrPhEmPbQabVH2qIREM8pDw1lUjrDKC1ClVHOf7f
   PcxH5iEXjW09vAO7Pj+tgU48fp+VlxyQ199QnrHF1L1URkvKgcSIHeZmB
   w==;
X-CSE-ConnectionGUID: /kJTXgPDQeaRBuBpec130g==
X-CSE-MsgGUID: rD0ikFCoQt26KBkDuGRIww==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74050662"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74050662"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:39 -0700
X-CSE-ConnectionGUID: 7NodZ/QXQSWwNs9zDoobpA==
X-CSE-MsgGUID: dH8nbJkDR4GQtDi2CkNWQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224004297"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:39 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 09 Mar 2026 15:19:27 -0700
Subject: [PATCH 4/4] thermal: intel: Add a syscore shutdown callback for
 kexec reboot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-rneri-directed-therm-intr-v1-4-2956e3000950@linux.intel.com>
References: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
In-Reply-To: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773094783; l=1750;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=8Zw0uqU/tIweMW1edd8EIH+/9emWZlcM4cagIgjN+qo=;
 b=sRbJ10ATjqwaVboZbC++6lG1z5fJpS+1qlVyttnONBCT6PhszigFAHsrovMHhiuurA5J5gqpn
 NzS4FzzYTExAaUMzHHccSG+HpfM+rnrwh7aJySKsBPYSpBcwD4/eh+j
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A kexec reboot may load a kernel that does not support directed package-
level thermal interrupts. Without a shutdown callback, the directed
interrupt configuration remains enabled across kexec but will not be
handled correctly. In particular, if the CPU designated to receive the
directed interrupt goes offline, no other CPU in the package will receive
it.

Add a syscore .shutdown callback to disable directed package-level thermal
interrupts on all packages before a kexec reboot. If the post-kexec kernel
does not enable directed interrupts, they will fall back to being broadcast
to all CPUs in the package.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/therm_throt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index c89485a8cda0..33b0c90cfe41 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -748,9 +748,25 @@ static int directed_pkg_intr_syscore_suspend(void *data)
 	return 0;
 }
 
+static void directed_pkg_intr_syscore_shutdown(void *data)
+{
+	bool enable = false;
+	int i;
+
+	for (i = 0; i < topology_max_packages(); i++) {
+		if (directed_intr_handler_cpus[i] == nr_cpu_ids)
+			continue;
+
+		smp_call_function_single(directed_intr_handler_cpus[i],
+					 config_directed_thermal_pkg_intr,
+					 &enable, true);
+	}
+}
+
 static struct syscore_ops directed_pkg_intr_pm_ops = {
 	.resume = directed_pkg_intr_syscore_resume,
 	.suspend = directed_pkg_intr_syscore_suspend,
+	.shutdown = directed_pkg_intr_syscore_shutdown,
 };
 
 static struct syscore directed_pkg_intr_pm = {

-- 
2.43.0

