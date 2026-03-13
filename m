Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507CB3D903E;
	Fri, 13 Mar 2026 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428018; cv=none; b=M8z5tHYIaZddI4i/spgsL8BOT/U0gwdce1sEprNIk3O9odqzzPonzZ9WBrXk0p+lxNawl+eDWymtkMS9nTzcKT/vBG56eSN40jTkYSbX/TYEKpYaUpUiLcwK/6VaJkVlS4fqzBW9qVJCiMYbf3rWoiNIDzjE00VD/aPHFiiq2x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428018; c=relaxed/simple;
	bh=VKxqxdjMcrRyCofRSwhPtbJGkrzo/t0l5eYwrH/moOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbJ4dvrTU/35voDJdaV7oX1VgbMLTARBbRMjgJ85PuOojdH+uuJKOc6GMdG3ti6BckmNvOv2qqTELerudfhOu2gbMhwWGdVEWZjNoqipoVyMm4Rmt+9C5wexvqfzK5sm4echmr8Vz6XO7zfbtG7c52AaleNwgi23s0LLub0NXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9C/VIFw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9C/VIFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428017; x=1804964017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VKxqxdjMcrRyCofRSwhPtbJGkrzo/t0l5eYwrH/moOo=;
  b=g9C/VIFwVfSLPi2Uao0b/5m9vrJtlEYYuyjhts0tMpWPg0vA2JfL/tJF
   oSGu2Xcoy6GK/lcv9kSasis3V9w1/JVVGtypJISfwcM47pzdL65NwfSvr
   GzVBDFyVclk5uih4/IV9wT3ddUxf0s+r1r4m2QWq74ZeCOEm9hyxNgd5l
   +sozMHOiNiFS7mHwclbtNXHZl+6jkmVeP6mysHKe4j5yD2kpLnC0xWs/o
   eiZf9DVdeCJoY8crjTh0C/Fosd0DOgzkTgKdkojtkoxRw5Q0jg96N79LT
   OxiO2A3bByShw+WZlW7YspcP9h4CiHi/h7ahB4DMWK050rzoSUzDgtcvf
   w==;
X-CSE-ConnectionGUID: HRZfMRDnQr6WuHhMlu1bpQ==
X-CSE-MsgGUID: +CNK2inJQTGf1mLdhxmalw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74242237"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74242237"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
X-CSE-ConnectionGUID: DR6Uwb+fSImY+1b8bRq7uw==
X-CSE-MsgGUID: z99txbWwRrWjuEp4eq5A3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225709169"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 11:53:34 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] powercap: intel_rapl: Move primitives to interface drivers
Date: Fri, 13 Mar 2026 11:53:26 -0700
Message-ID: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RAPL supports multiple interfaces (MSR, MMIO, and TPMI), each with their
own register layouts and bitmask definitions. Currently, the primitive
tables and bitmasks for all three interfaces live in the common driver,
which requires interface-specific handling logic in shared code and makes
the common layer unnecessarily complex.

This series cleans this up by moving each interface's primitive
definitions into its own driver, so the common driver no longer needs to
know anything about per-interface register layouts.

All patches are no-functional-change refactoring.

This series is based on top of the earlier RAPL cleanup series:

  https://lore.kernel.org/linux-pm/20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com/T/#t

Patch Summary:
Patch 1/6: Remove unused AVERAGE_POWER primitive and RAPL_PRIMITIVE_DERIVED
           flag from the common driver.
Patch 2/6: Remove other unused macro definitions from the common driver.
Patch 3/6: Move struct rapl_primitive_info, enum unit_type, and
           PRIMITIVE_INFO_INIT macro to intel_rapl.h to allow interface
           drivers to define their own primitive tables.
Patch 4/6: Move TPMI primitive definitions and associated bitmasks into
           the TPMI interface driver.
Patch 5/6: Move MMIO primitive definitions and associated bitmasks into
           the MMIO interface driver.
Patch 6/6: Move MSR primitive definitions and associated bitmasks into
           the MSR interface driver.

Kuppuswamy Sathyanarayanan (6):
  powercap: intel_rapl: Remove unused AVERAGE_POWER primitive
  powercap: intel_rapl: Remove unused macro definitions
  powercap: intel_rapl: Move primitive info to header for interface
    drivers
  powercap: intel_rapl: Move TPMI primitives to TPMI driver
  thermal: intel: int340x: processor: Move MMIO primitives to MMIO
    driver
  powercap: intel_rapl: Move MSR primitives to MSR driver

 drivers/powercap/intel_rapl_common.c          | 206 ------------------
 drivers/powercap/intel_rapl_msr.c             |  99 +++++++++
 drivers/powercap/intel_rapl_tpmi.c            |  53 +++++
 .../int340x_thermal/processor_thermal_rapl.c  |  72 ++++++
 include/linux/intel_rapl.h                    |  33 ++-
 5 files changed, 254 insertions(+), 209 deletions(-)

-- 
2.43.0

