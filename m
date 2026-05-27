Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9C3A8741;
	Wed, 27 May 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904543; cv=none; b=gi1AuYFMR5IdZbec3XGuZg7IqnUo6AN38SCvaQbIpyoaK76eaB8O7hIp1WRVQspwmrdrG+GbMBfRLan4lKlnWGR8Ml5ZAXFi9ZyjaZCJYyDMKPlwmCD7Q/0QN7M/X7zD7avRSy/s1GSEFFax3DOmuhAnuFBxsnu3a/0tCPNJu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904543; c=relaxed/simple;
	bh=5g1x+u2cw+oVokz9sX8bH0WKp0vu/iJa7txpSzGoqRI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mrGZjX65c2a4BAe7FbyhJ99FtKCLuHhQKebnVmwowNP0BFoyskVTwelpq0oFo/Othy9BxDM/0xLHFTRJ9glDyK76peFAk8m5X24G0OvbjdQjpPqvwCBQB/SJ1poxd83ysmrw8gISfWXEXxwRM6xF3CN7NEf36ZitbaSvxpFJzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzSeUzAk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzSeUzAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779904542; x=1811440542;
  h=date:from:to:cc:subject:message-id;
  bh=5g1x+u2cw+oVokz9sX8bH0WKp0vu/iJa7txpSzGoqRI=;
  b=UzSeUzAkm0V6iA63tKduJpzhY86a78sfDDUKsax4v/wlWcnNMyL0gU3V
   CyB+wNDQBOIqniQh6N8PHNESno7MT3RV/Y6I59Ld4ZvOR0qN0YjweH4/c
   R4VVYSDXunnMAXo7n/FDNwzgzRqj/5fRSgDu2fRqAx6OvP5NiPb6D6Sf0
   WOmGhKNiJ/jk3zRY/GvfwKn060m5xBi6IhuWUOWi1JbJUIH8G19gMwsm2
   pEQgpFhJlXSmGyUU73uKIuigTcWNJv/2PJh7Mamoqh/75XxwPoeYVA+Lw
   eKgTMQgXuIkmm3342HBd2Yurhcc3NkySHr0MTMQoWt7KqfU5amUtRxzR6
   Q==;
X-CSE-ConnectionGUID: GhlQwWBsT/e1jl2N0ooSdQ==
X-CSE-MsgGUID: H64lCE3RRE2aSulwg7EKUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91050017"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="91050017"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:54:34 -0700
X-CSE-ConnectionGUID: CN8ICdwzS3m+X2CXZAyDEw==
X-CSE-MsgGUID: QyX6qFPRSHO5/39xgBYLOQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 May 2026 10:54:32 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSISc-000000004Hi-0KGx;
	Wed, 27 May 2026 17:54:30 +0000
Date: Thu, 28 May 2026 01:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 1b504fc632399a915b94541d2915825687c524cb
Message-ID: <202605280158.BkYngJri-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 1b504fc632399a915b94541d2915825687c524cb  Merge branch 'pm-cpufreq-fixes' into fixes

elapsed time: 1549m

configs tested: 82
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arc         randconfig-001-20260527    gcc-9.5.0
arc         randconfig-002-20260527    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm         randconfig-004-20260527    gcc-11.5.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch   randconfig-001-20260528    clang-18
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20260528    gcc-11.5.0
nios2       randconfig-002-20260528    gcc-8.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
openrisc                  defconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
parisc                    defconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
riscv                     defconfig    clang-23
riscv                randconfig-001    gcc-8.5.0
riscv       randconfig-001-20260527    gcc-9.5.0
riscv                randconfig-002    clang-23
riscv       randconfig-002-20260527    gcc-15.2.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
s390                      defconfig    clang-23
s390                 randconfig-001    gcc-11.5.0
s390        randconfig-001-20260527    gcc-12.5.0
s390                 randconfig-002    clang-23
s390        randconfig-002-20260527    gcc-11.5.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh                        defconfig    gcc-15.2.0
sh                   randconfig-001    gcc-15.2.0
sh          randconfig-001-20260527    gcc-14.3.0
sh                   randconfig-002    gcc-14.3.0
sh          randconfig-002-20260527    gcc-11.5.0
sparc                   allnoconfig    gcc-15.2.0
sparc                     defconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
sparc64                   defconfig    clang-20
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um                        defconfig    clang-23
um                   i386_defconfig    gcc-14
um                 x86_64_defconfig    clang-23
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
