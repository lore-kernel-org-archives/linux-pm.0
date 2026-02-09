Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B802264D3;
	Mon,  9 Feb 2026 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770680597; cv=none; b=hc1CcSxr1mZ5YK6trK0JVBMjW13L5hjmo/3Rygd2rc2UoVY4ifk9HgebqiwJrwiLNK+gr6VWjwjUv45RMkxPQafCaUjXmxhSWbChPHzRME7WkgfFVdJe3uLGLxLk51xILhsOz66Qlen6PWzrkYgkdv1Gmxg/mL9ckndIx0bt3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770680597; c=relaxed/simple;
	bh=M+HntxgdXL+stp25upW8vr0XmT7TRUjfT8tfFf52PCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neILV4AVJU8gMLB2kx8vTC5KSR3TbnlrJTqCc1D1bgEBxfvsGWAFufIieXYAGFKaPwsklS3CDPI5lpvi4HhatbA9yxZwrIYIuci4mtDrbkspaZgXkf18qWbjAUYGgfdAhzGfu2pJKHu0BSHYbn+eCKZgrX+J/RF8xjR7XejI/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnG4cjgw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnG4cjgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770680596; x=1802216596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M+HntxgdXL+stp25upW8vr0XmT7TRUjfT8tfFf52PCM=;
  b=LnG4cjgwtuMxB5ayAPguIk7+pZvm25OJvt6aJKPpI3DA4OIPSHqfwEHc
   ukxmGoyzCQIIhYEBjadpHnD8EQFWKCWL/dcYCfDgdTbymIAP3vvFDQBil
   7l+yy+o0C+T0hqXn5FOWRKlCcFeHQLWQHpZ8xpKTURRd9OdbY2oZ0Ti5b
   Hq5vqR8Q7Pj5nAX8xS2OPhhbbOLONi51GJtHts5LA6qlXu70JLfYOE6cL
   Wm4nSor/NST3mLV4oD/HL1ktepwfpNvi28jXiJBpfm4cS42H2j7Yab9e5
   dIDazkFNV5Q7+JnlVpAcnJgADj1qiI/EWHWQHVSWOycJbbjdMGYTZHJmP
   w==;
X-CSE-ConnectionGUID: aBTbFwLiQ4mwqwsPbNI4WA==
X-CSE-MsgGUID: 5u4cfQG+SmWXHVesiOvSwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89385233"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89385233"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:43:15 -0800
X-CSE-ConnectionGUID: 3CgsUpAhTTaUMXaXNu62aQ==
X-CSE-MsgGUID: NBAHA8UvR4a+Kdfxg/oVcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="242351917"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 15:43:15 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Fix RAPL PMU access from non-lead CPUs
Date: Mon,  9 Feb 2026 15:43:08 -0800
Message-ID: <20260209234310.1440722-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes issues with RAPL PMU event access when using CPUs
other than the package lead_cpu.

The problem was discovered when turbostat reported zero power values
when run on a non-lead CPU in the package.

Investigation revealed two issues:

1. The RAPL MSR driver incorrectly validated that the current CPU must
   match the lead CPU of the package when reading from PMU context, even
   though package-scoped MSRs are readable from any CPU in the package.

2. The RAPL PMU cpumask only exposed one CPU per package (the lead_cpu)
   for both MSR and TPMI interfaces, forcing tools to use that specific
   CPU even though package-scoped registers are readable from any CPU
   in the package.

The perf tool avoided issue #1 by checking the cpumask before opening
events, but turbostat does not perform this validation. The restrictive
cpumask in issue #2 was unnecessary since both MSR and TPMI interfaces
support reads from any CPU in the package for package-scoped registers.

These patches:
- Remove the incorrect CPU validation check in PMU context
- Expand the PMU cpumask to include all CPUs in each package for both
  MSR and TPMI RAPL interfaces
- Rename 'atomic' parameter to 'pmu_ctx' for clarity

After these changes, tools can successfully read RAPL events from any
CPU in the package, matching the architectural capability of the
hardware for both MSR and TPMI based RAPL implementations.

Testing (PTL & GNR platform):
- Verified turbostat --no-msr --show power works on all CPUs
- Verified perf stat -e power/energy-pkg/ works on all CPUs
- Confirmed /sys/bus/event_source/devices/power/cpumask shows all
  package CPUs instead of just lead_cpu
- Tested on both MSR-based (PTL) and TPMI-based (GNR) RAPL system

Kuppuswamy Sathyanarayanan (2):
  powercap: intel_rapl: Remove incorrect CPU check in PMU context
  powercap: intel_rapl: Expose all package CPUs in PMU cpumask

 drivers/powercap/intel_rapl_common.c | 21 ++++++++-------------
 drivers/powercap/intel_rapl_msr.c    | 12 +++++-------
 include/linux/intel_rapl.h           |  2 +-
 3 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.43.0

