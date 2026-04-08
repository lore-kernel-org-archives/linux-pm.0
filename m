Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2A37AA92;
	Wed,  8 Apr 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686909; cv=none; b=JrA5+ttwzdIRp5woSn4h/2iUKFn6HWSfBbAsFOqEspfxtxFHx1oyVEQ8BKbtE7btmYi5eHzsK8d1YWi010+4dVofwqPJ9CysSom+nOrYN/MQ2tJgsRNOdXmvmBc/Yu4o6QhDZ/78Wf+c1UUD6aY3743MUHHFp35SdkyjzLTaKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686909; c=relaxed/simple;
	bh=cKz70Mx//NYrxAlQyBZiPtaIbAYJRGDw2IkXlKU0zs0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bx77TBd6A+85ya19I5eYoHKAATwY1ariWhb1Nwtu1+MAbVnBVIeXchzOgke1ZidE70SWVC40f/DSKJ7bpwyLnB/ImDUuF/rnaGSxpDAMAxcTgh1LehQjn1ujHNAGl+zwbeEqtEbgntrcA802MgMsGea1UlVAlyyKAfTQYbkUzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJhmLrVT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJhmLrVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775686908; x=1807222908;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cKz70Mx//NYrxAlQyBZiPtaIbAYJRGDw2IkXlKU0zs0=;
  b=hJhmLrVTSAPiY16OzOZbsQ7g3vUYU5m7ftT4XqyJa1XjX8ndotBRZ1hO
   5i3zrBOyHaWSXhwSG+jqK/9CTqk7Y6ZxRqcqV01NZDkGOS4KS8EZaanjB
   qx649wGk9lV8NJKNRckpQ4x3ehu2g3V4ftkTucYOIqMPZx8f1IRDJctah
   RUv/iwZr7RiFYXXLBf13lm9jqQcV5EpJtb7ahuzJ9t4PnDKZ2xURBcghB
   qnH+XoTQap9JSxkFUpYH0d2qvaHDgULBahZaf3iYVOPLrIPTmNR+mQroH
   mcUCoDZcgR+AZ3BNlt6ej0RPRLnyX+Xlv9RR/yiGYX7RmZaMwaMgTlVHM
   Q==;
X-CSE-ConnectionGUID: OiYa0RAAQF6VlaMSEitB8g==
X-CSE-MsgGUID: GFmMoc9xQDWrNLvf5kwBhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88068067"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88068067"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:47 -0700
X-CSE-ConnectionGUID: 5tqIpdyBTC6K3XaLP07rUw==
X-CSE-MsgGUID: UsyWUgprRsWN7O1jFIaSGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223837821"
Received: from aschende-mobl.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.108.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:46 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/7] Enable NVL support in intel_pmc_core
Date: Wed,  8 Apr 2026 15:21:33 -0700
Message-ID: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/core.h   |   66 +-
 drivers/platform/x86/intel/pmc/lnl.c    |    6 +-
 drivers/platform/x86/intel/pmc/mtl.c    |    7 +-
 drivers/platform/x86/intel/pmc/nvl.c    | 1539 +++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/ptl.c    |    8 +-
 drivers/platform/x86/intel/pmc/wcl.c    |    6 +-
 9 files changed, 1747 insertions(+), 38 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/nvl.c

-- 
2.43.0

