Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9003F8EAF;
	Thu, 28 May 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981311; cv=none; b=sH8+phFp7cKEN2oLJ0S7TXlJHRP9XffXF+0ITjnAF8Q3/QExw0U3TGlNpGjhlARSR9ERw0LgDqVMFOubX249wX5j9xStu9utn5VRddxxOFORUtV9VhSqREbST1Rip6iTyFm56/0rToKxtF2p+E2xPK7tIjRyPRPEkld840w2mwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981311; c=relaxed/simple;
	bh=sbgbN5et6lPL53iUMBbkOwiCET6rPb90p8S0xtg33Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jl7UdzJyK+bS3fS371aMNRZgOcO4VAspk7g27FlrVFZ93Fhe0o6h1pNXe2yqT4Kx6cGGSXBaZdQublU1vkMsP3BonbXgRa+yzzrgj4qY/4UhLE2fH6QrxMyQylSblN6Jn1CoQhGAr1TLj44n+NXEcEBKr8WD0p+zQb7bZ3MGYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPjcQpoe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPjcQpoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779981311; x=1811517311;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sbgbN5et6lPL53iUMBbkOwiCET6rPb90p8S0xtg33Lk=;
  b=hPjcQpoeS8xxf95HRY6Xybl2PouEO7XupWcxojfzHvOQRTMSJiW2HLJl
   vTWFDQ5BJmpZcr0c71Dp6/1lHJiuVGxjLkZtyIfbQ+cOooQvV5zDb+CFi
   9+s5fUh0wUdxzGPOACZ43a6kjD9VdxoWavs98R1Ii2S/xOYYT2njI9skg
   Wh4zcUlXV8xWPtPinll3n+UrZ0h6UJ3kSidmWps8C6ENcS/gWnNEM8jrM
   FVYsjJUGkNsL1qsyDTQLLC930OJwaWN4RfkMLMqB1K0YwUuTfz5VfxytC
   nj/M3pZ5u5PKRWdxdy/5OJ/MG+7xibhiop/nNIuVN9zTXm81Cvh4fr38C
   w==;
X-CSE-ConnectionGUID: 1Fy/5c2dTmGysMaAH3ZvGw==
X-CSE-MsgGUID: cCDysPogQoKJym5xIlLtMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80887350"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80887350"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:08 -0700
X-CSE-ConnectionGUID: 9+2uK/o2SVigcB+bCHhABg==
X-CSE-MsgGUID: ruB+1k/WR8m/c4zEE6yU6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241536857"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:08 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 28 May 2026 08:25:46 -0700
Subject: [PATCH v2 5/5] thermal: intel: Add a syscore shutdown callback for
 kexec reboot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-rneri-directed-therm-intr-v2-5-8e2f9e0c1a36@linux.intel.com>
References: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
In-Reply-To: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779981967; l=1597;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=sbgbN5et6lPL53iUMBbkOwiCET6rPb90p8S0xtg33Lk=;
 b=Poy+ZzyVDFUIakpnd06w0jYnauvbHWVV+fJ8sfcJ++fTHs27r1M/kSh3pOp8zLtVEhCJQ3tyb
 GbUBZ1wovy8BO+CQ46i6WxblMKmp+ofR12Lyopf5749hkcZGsFAXPpR
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
Changes in v2:
 * Used the disable_all_directed_thermal_pkg_intr() function introduced
   in patch 3.
---
 drivers/thermal/intel/therm_throt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index d4ea795e3c3b..14ac3c892f2f 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -796,9 +796,15 @@ static int directed_pkg_intr_syscore_suspend(void *data)
 	return 0;
 }
 
+static void directed_pkg_intr_syscore_shutdown(void *data)
+{
+	disable_all_directed_thermal_pkg_intr();
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

