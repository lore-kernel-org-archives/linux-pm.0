Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782803DEFFE;
	Fri, 26 Jun 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467576; cv=none; b=AdLlIRwgcvy3BRYh7IHvYjQfxlEmbgGsZ+Q2GEpr2tG0w367H/oDvr6N827YuSk9zJ3RaC3+AYTjh8D2H6KAHCQhMTZRgK8Ynup5ij8/RKVcLSST0rmkY8oQi/VSYdhsVQZKQf28QA5hPM05KLdyPYRe4Tu4JbboVMicx2c12uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467576; c=relaxed/simple;
	bh=otgrj9WqQ5JjoA0i+uyBm070eW85yK6iQ9dbtTawCMs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Isa9iHEte6UDLFxnSJSPo+KiulfiHykcgJj+w+SReJo627LG9tUJlvHP94Z965AKlkw6Mmm9vqTVgP9nSsma4zjvUD8nKQsZiU6UhrttOOQxbarxsxiiXBhsJmzcsemYH8IZTbwfr+VMnrXvG+AfzfT7DDDFbkBHpKJnSq744q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ie/D0lao; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ie/D0lao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782467574; x=1814003574;
  h=date:from:to:cc:subject:message-id;
  bh=otgrj9WqQ5JjoA0i+uyBm070eW85yK6iQ9dbtTawCMs=;
  b=ie/D0laoIPKovKRmpLz2c4UfNYnZYx9eJ8FJ6UAxZ4mioMOafbQMpPVl
   K7EzKju72cvjQKXrv9mPP3kZ4oGkAvY3XafvKs2h/iAEgMlK6FrEHzyjI
   pL3guHb3v1sVY6reM9cVbmH01vDns6+tlmrKunFptHk3CHG9aEx3EeSHn
   f73R/8y4koULOzO7JrfYjK9ZclhuG7KqHmeQen9gIvArGJ+RtVIDACNpC
   wTvxyq6ey4l+Nte0jddDIS2hFpR2Bh5bfUzllBgZnGP90P7Fq2Swc2yWt
   3JjnFJSjNwEch2dTmlIbKxS1efeHW0WmgNjTl2RHyPcezn1bxmpq8Vywt
   Q==;
X-CSE-ConnectionGUID: 0n+VunvwQcCJICXabIjbIA==
X-CSE-MsgGUID: Z/d3AkcoSgC7h1WGKDEAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="108805694"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="108805694"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 02:52:54 -0700
X-CSE-ConnectionGUID: wqm/KfDJQTa0UGu5xJE0FA==
X-CSE-MsgGUID: FU+RR7gGQQywLSgJ55cSEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251444694"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Jun 2026 02:52:52 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wd3Et-000000004xy-07Ev;
	Fri, 26 Jun 2026 09:52:47 +0000
Date: Fri, 26 Jun 2026 17:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 852b859dc948dc38efe965a1849d1a09fa46ec97
Message-ID: <202606261702.U2ZHw3XB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 852b859dc948dc38efe965a1849d1a09fa46ec97  Merge branch 'acpi-processor' into fixes

elapsed time: 894m

configs tested: 280
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                            randconfig-001    gcc-16.1.0
arc                   randconfig-001-20260626    gcc-13.4.0
arc                   randconfig-001-20260626    gcc-16.1.0
arc                            randconfig-002    gcc-16.1.0
arc                   randconfig-002-20260626    gcc-13.4.0
arc                   randconfig-002-20260626    gcc-16.1.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                             mxs_defconfig    clang-17
arm                            randconfig-001    gcc-16.1.0
arm                   randconfig-001-20260626    gcc-13.4.0
arm                   randconfig-001-20260626    gcc-16.1.0
arm                            randconfig-002    gcc-16.1.0
arm                   randconfig-002-20260626    gcc-13.4.0
arm                   randconfig-002-20260626    gcc-16.1.0
arm                            randconfig-003    gcc-16.1.0
arm                   randconfig-003-20260626    gcc-13.4.0
arm                   randconfig-003-20260626    gcc-16.1.0
arm                            randconfig-004    gcc-16.1.0
arm                   randconfig-004-20260626    gcc-13.4.0
arm                   randconfig-004-20260626    gcc-16.1.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    clang-23
arm64                 randconfig-001-20260626    clang-23
arm64                 randconfig-001-20260626    gcc-8.5.0
arm64                          randconfig-002    clang-23
arm64                 randconfig-002-20260626    clang-23
arm64                 randconfig-002-20260626    gcc-8.5.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260626    clang-23
arm64                 randconfig-003-20260626    gcc-8.5.0
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260626    clang-23
arm64                 randconfig-004-20260626    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                           randconfig-001    clang-23
csky                  randconfig-001-20260626    clang-23
csky                  randconfig-001-20260626    gcc-8.5.0
csky                           randconfig-002    clang-23
csky                  randconfig-002-20260626    clang-23
csky                  randconfig-002-20260626    gcc-8.5.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260626    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260626    gcc-11.5.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260626    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260626    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260626    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260626    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260626    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260626    gcc-14
i386                                defconfig    gcc-16.1.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260626    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260626    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260626    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260626    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260626    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260626    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260626    gcc-14
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260626    gcc-14
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260626    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260626    gcc-14
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260626    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260626    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260626    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260626    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260626    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260626    gcc-11.5.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
microblaze                      mmu_defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                     loongson2k_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260626    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260626    gcc-11.5.0
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260626    gcc-8.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260626    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                      ep88xc_defconfig    gcc-16.1.0
powerpc                   motionpro_defconfig    clang-23
powerpc                        randconfig-001    gcc-8.5.0
powerpc               randconfig-001-20260626    gcc-8.5.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260626    gcc-8.5.0
powerpc64                      randconfig-001    gcc-8.5.0
powerpc64             randconfig-001-20260626    gcc-8.5.0
powerpc64                      randconfig-002    gcc-8.5.0
powerpc64             randconfig-002-20260626    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-23
riscv                 randconfig-001-20260626    clang-23
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260626    clang-23
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-23
s390                  randconfig-001-20260626    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260626    clang-23
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-23
sh                    randconfig-001-20260626    clang-23
sh                             randconfig-002    clang-23
sh                    randconfig-002-20260626    clang-23
sh                          rsk7264_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                          randconfig-001    gcc-12.5.0
sparc                 randconfig-001-20260626    gcc-12.5.0
sparc                          randconfig-002    gcc-12.5.0
sparc                 randconfig-002-20260626    gcc-12.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-12.5.0
sparc64               randconfig-001-20260626    gcc-12.5.0
sparc64                        randconfig-002    gcc-12.5.0
sparc64               randconfig-002-20260626    gcc-12.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-12.5.0
um                    randconfig-001-20260626    gcc-12.5.0
um                             randconfig-002    gcc-12.5.0
um                    randconfig-002-20260626    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260626    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260626    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260626    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260626    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260626    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260626    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260626    clang-22
x86_64                randconfig-002-20260626    clang-22
x86_64                randconfig-003-20260626    clang-22
x86_64                randconfig-004-20260626    clang-22
x86_64                randconfig-005-20260626    clang-22
x86_64                randconfig-006-20260626    clang-22
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260626    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260626    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260626    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260626    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260626    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260626    gcc-14
x86_64                         randconfig-071    gcc-14
x86_64                randconfig-071-20260626    gcc-14
x86_64                         randconfig-072    gcc-14
x86_64                randconfig-072-20260626    clang-22
x86_64                randconfig-072-20260626    gcc-14
x86_64                         randconfig-073    gcc-14
x86_64                randconfig-073-20260626    gcc-14
x86_64                         randconfig-074    gcc-14
x86_64                randconfig-074-20260626    gcc-14
x86_64                         randconfig-075    gcc-14
x86_64                randconfig-075-20260626    gcc-14
x86_64                         randconfig-076    gcc-14
x86_64                randconfig-076-20260626    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                         randconfig-001    gcc-12.5.0
xtensa                randconfig-001-20260626    gcc-12.5.0
xtensa                         randconfig-002    gcc-12.5.0
xtensa                randconfig-002-20260626    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
