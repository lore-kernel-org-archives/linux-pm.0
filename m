Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CD426D09;
	Tue, 31 Mar 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992007; cv=none; b=nR7U1h8VJSn59QdrAtUOgQIl0btBr2kW27bYVseKmiwRpag5j05xayieexZHytw1IwILER8UAE97wkAX/XNseqr6ihpaPCFU5796STxwOckCmu6q9e1GmVrVw0cXwrR61G37jGNKZbSZiHi2W7x4BrRxaa3yfGYZtmPnoGv5WwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992007; c=relaxed/simple;
	bh=q8BmGde5zfndcM/RCzlDnZ75dQ9TB5bI/vnuudyKx6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7yiOVr6zU+WQrU95JyUvLsgyW+ziGFrfnLuL5kLmK+Nn6taoJ4GJ0JO8hxbVSg0JbvPnW2toy5hHRhmqDd/vpzBL469GSDKG4KUrQuPL/LyAjkGDURta4dO1hVQijVTCnWACjBOIWfWmeQnnDG/k9ZSfDZ0yF2k4GJcaqVkTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDQ0gF9L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDQ0gF9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774992005; x=1806528005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q8BmGde5zfndcM/RCzlDnZ75dQ9TB5bI/vnuudyKx6A=;
  b=gDQ0gF9LHzmALDKt1w7jWWD6KpQaRm5Dj8YPlxrII3Og6GXNAcupxpJq
   chqo6wp1fixz4VV99aMqmF/GBO0gPGv/PGVVJP5jGByG57XGNIupBGM5x
   pBqPf1GnaESy0zkWEZBfN2dn6cWUMtqBDEqgAQ6RdvrW8+Ib/3lqoPJkV
   XTuDBMvTVXAgeHtXR3KQ9RPKozAHzdVo1c2nbKddlCZFdQPV6m3xkzb+T
   3ldaPpUrRCCZwsd+aU29blXT6I9PBQGhY7kORXWJ52sMRyylikVLvcnnd
   /rMtsMEdGMpgIIYHoczfu3MATTs+f1GPQ8ce92formaFdOIPAhUEroYNA
   w==;
X-CSE-ConnectionGUID: U3rbBHa6T+ezGQsRkLagvw==
X-CSE-MsgGUID: lHxa+DQ0Qg+dtOpEGWpIuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79625008"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79625008"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:04 -0700
X-CSE-ConnectionGUID: 0x72BcD1RwmvTd7+L0XE1g==
X-CSE-MsgGUID: ROELW2OHS/eIKNbLG8aKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221627101"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:04 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] RAPL fixes (for linux-next)
Date: Tue, 31 Mar 2026 14:19:43 -0700
Message-ID: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,

This series consolidates and rebases patches from three previously
submitted cleanup series that were dropped from your linux-next due
to a circular locking dependency issue:

  https://lore.kernel.org/linux-pm/202603300921.b5dc709c-lkp@intel.com/

The three series are:

  Move RAPL defaults to interface drivers:
  https://lore.kernel.org/linux-pm/20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com/

  Move RAPL primitives to interface drivers:
  https://lore.kernel.org/linux-pm/20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com/

  Consolidate CPU list in RAPL MSR drivers:
  https://lore.kernel.org/linux-pm/20260313190052.2370963-1-sathyanarayanan.kuppuswamy@linux.intel.com/

The circular locking dependency was introduced by a patch in the first
series that registered and unregistered the PM notifier dynamically
from rapl_add_package_cpuslocked() and rapl_remove_package_cpuslocked(),
which are called from CPU hotplug callbacks leading to circular
dependency between PM notifier lock and hotplug locks.

That patch has been dropped in this series. The PM notifier
registration is kept in rapl_init()/rapl_exit() as it was originally,
and the remaining dependent patches are rebased on top of this.

This series is based on top of:
  https://github.com/rafaeljw/linux-pm/tree/pm-powercap

Kuppuswamy Sathyanarayanan (7):
  powercap: intel_rapl: Move MSR default settings into MSR interface
    driver
  powercap: intel_rapl: Remove unused macro definitions
  powercap: intel_rapl: Move primitive info to header for interface
    drivers
  powercap: intel_rapl: Move TPMI primitives to TPMI driver
  thermal: intel: int340x: processor: Move MMIO primitives to MMIO
    driver
  powercap: intel_rapl: Move MSR primitives to MSR driver
  powercap: intel_rapl: Consolidate PL4 and PMU support flags into
    rapl_defaults

 drivers/powercap/intel_rapl_common.c          | 421 +-----------------
 drivers/powercap/intel_rapl_msr.c             | 392 ++++++++++++++--
 drivers/powercap/intel_rapl_tpmi.c            |  53 +++
 .../int340x_thermal/processor_thermal_rapl.c  |  72 +++
 include/linux/intel_rapl.h                    |  34 +-
 5 files changed, 522 insertions(+), 450 deletions(-)

-- 
2.43.0

