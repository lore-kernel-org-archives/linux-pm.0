Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D619C566;
	Tue,  5 May 2026 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955628; cv=none; b=NAU07PUaVXnF/1wumkaeUV0h3INxb7krCzb89hul3XM5JX8r0NcHxjeLJ7vJdaYIOibGURWSm/vD9sJYpjVxI8D1fgnHwAglVkLoLBRnuhpVdbqi82JauEcP+ewnNFiXHqdyyOIplEyDemj0/b6j6URDoBPd4DwcI/sCQce/Xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955628; c=relaxed/simple;
	bh=wis0HhACv7dgYZmVfuwg47iMgk851xU2/vjJ3lil1Ms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sFRXDqHvtdyBUqYzwfZyhLqScIiTq0RrZkqlOvh7TGZ/L+fbZvL7v9uK6nQvTuXd5tS7B9WLwIwWEx1ycdwsd5PKX0Fm16Gtp3PqzV6k3Eak91jBQJ3+ALQzv5HQt6lnx7EZskzIroysjNAFrNlKbA19KrqicqHkF9TSDFJyItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBDlbkdQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBDlbkdQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955627; x=1809491627;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wis0HhACv7dgYZmVfuwg47iMgk851xU2/vjJ3lil1Ms=;
  b=YBDlbkdQ5NyhHqa7+w+yoAIUjXqeeCfG3ageK9V1YhZBZ6wXzSf3xnIH
   8cll/mzkb4x1XH8PBBWr94LXg+yzWrsGbCEi4L8moo0cI5zHZNwFzqyeO
   es9MidQXtF0igdKxmfXuWSt3GwHt9H3PGWvEpgSvDLp65DChzlHNqOrFa
   JBCCN4DFySaAciYqOp/eOLgb6tJ24zSDNWTh7pRo6iMRQtVmW57E5Re6n
   kt0718GdpeUsRAGz9uHeG1qg0GbG4XNLfs1ToBxwkdogBskqVmJFxYFqy
   M7sV2rvy+trNAAsgx0BKB/CKxF/+hITgAKMNM9fWw9ILkE81HQ6wz8PZK
   w==;
X-CSE-ConnectionGUID: 9i8x4pAgSKGO3yxuf5bjfA==
X-CSE-MsgGUID: pkowvb5rRmKT3VQfqvE6hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78841279"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78841279"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:46 -0700
X-CSE-ConnectionGUID: HZk6lfYdQWCuS2y830xX+Q==
X-CSE-MsgGUID: gTWUKJkIQri/J945hsqEyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232565201"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.35])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:45 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/7] Enable NVL support in intel_pmc_core
Date: Mon,  4 May 2026 21:33:31 -0700
Message-ID: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces two new features, enhances existing
functionalities, and adds NVL support to the intel_pmc_core driver.

The first three patches add new attributes to improve Package C-state
debugging. The fourth and fifth patches refine current functionality
for better support. The sixth patch enables the intel_pmc_core driver
retrieves PMC information only for available PMCs. Finally, the last
patch adds support for Nova Lake platforms.

v3->v2:
- Move common helper code to patch 2 to avoid switch code back and
  forth.
- Remove unneeded empty line.
- Add #include for BIT() in nvl.c.
- Change pmc_list to be const variables.
- Change PPFEAR_MAX_NUM_ENTRIES to 13.

v2->v1:
- Add a patch to use __free(pci_dev_put) in pmc_core_punit_pmt_init().
- When using scoped base cleanup method, move variable declaration and
  assignment in one place.
- Simplifies logic and remove unneeded offset variables.
- Create common helper function to used by pmc_core_pkgc_ltr_blocker_show()
  and pmc_core_pkgc_blocker_residency_show()
- Add num_pmcs field in pmc_dev_info struct to store the number of PMCs
  available in the platform.
- Use lowercase letter for variable in nvl.c().
- Fix typo.

Xi Pardee (7):
  platform/x86/intel/pmc: Use __free() in pmc_core_punit_pmt_init()
  platform/x86/intel/pmc: Enable PkgC LTR blocking counter
  platform/x86/intel/pmc: Enable Pkgc blocking residency counter
  platform/x86/intel/pmc: Use PCI DID for PMC SSRAM device discovery
  platform/x86/intel/pmc: Add support for variable DMU offsets
  platform/x86/intel/pmc: Retrieve PMC info only for available PMCs
  platform/x86/intel/pmc: Add Nova Lake support to intel_pmc_core driver

 drivers/platform/x86/intel/pmc/Makefile |    3 +-
 drivers/platform/x86/intel/pmc/arl.c    |   13 +-
 drivers/platform/x86/intel/pmc/core.c   |  137 +-
 drivers/platform/x86/intel/pmc/core.h   |   68 +-
 drivers/platform/x86/intel/pmc/lnl.c    |    6 +-
 drivers/platform/x86/intel/pmc/mtl.c    |    7 +-
 drivers/platform/x86/intel/pmc/nvl.c    | 1539 +++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/ptl.c    |    8 +-
 drivers/platform/x86/intel/pmc/wcl.c    |    6 +-
 9 files changed, 1748 insertions(+), 39 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/nvl.c

-- 
2.43.0

