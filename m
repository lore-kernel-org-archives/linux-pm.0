Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507140DFCB;
	Mon, 30 Mar 2026 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774829351; cv=none; b=hTdjxQTjg1WklZWe359Y1YHBuUG234qHDWntb0URwb64EgNdl7a8tByF6ZIdeeehxfdufvmwkAdZKjKYLxk8el2TyKwuqbnPcDhiKB+2cwSuApeVjT6FZKZn68bmuRPCY3N7D8gk0khGNnsC58rJrazPiE6uG03vCsc3Da1hcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774829351; c=relaxed/simple;
	bh=qvnAEtfSceI4JyE571Zb+jtVFdGgc0zisfZHRJOrxLg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j5K6m0OQDQsAeLq8J38/fuSqEa2Dyt2TMreayOTnyP+cc75SSYhz5/mc1oBseNy5AOPVMb0tPw1e16DYvOjw79jn5wRF35jiaRm9YBbLq9sJC6ENR8vGU/0zFwv9i5GCpactkKBEAyd2fSmvedOMfKR7U2UMtgMhVBW7JZO1noY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S73xq8Pm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S73xq8Pm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774829350; x=1806365350;
  h=date:from:to:cc:subject:message-id;
  bh=qvnAEtfSceI4JyE571Zb+jtVFdGgc0zisfZHRJOrxLg=;
  b=S73xq8PmXnkWPEFh4nIKgL6Oi+GbauQ58mIRHefD/ehR4+rcnLIqTrzE
   ho2Hub6doYwfzIDAKoA0m13/Nv6sKGdBcS4u9B/pjws+AHkuiymxwHItM
   e7VhP27uEXxtFM616d1btBaseK/8Ov7n8a7cizg7J/unFl5fadz/x2K+y
   etk8Vao961ea6Ha9vULBb3vZIncaJdHclWpi/dWQ0l7zbEv3/rsMf7/He
   hRAOu/lv11gPenzNC8OoMXRyyFk+GrZN7fs5ouYzKO6oNTo+uqyHT82ZB
   BErD5tXkiZJZSyF5ab1iETjJSk8fEgEWP8qRSQ1VHCWNgwQAACvzmcxp7
   w==;
X-CSE-ConnectionGUID: WwxYHOYeR4C5MY0IlI3jWw==
X-CSE-MsgGUID: 534cIUibSMyy13+a9cdTYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="78415809"
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="78415809"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 17:09:09 -0700
X-CSE-ConnectionGUID: 43JFSELLT4mm++e0MuKSCw==
X-CSE-MsgGUID: AyV5K2QkQvmR75hjq3TQ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,148,1770624000"; 
   d="scan'208";a="230695956"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2026 17:09:08 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w70Bl-000000000Qd-1wHq;
	Mon, 30 Mar 2026 00:09:05 +0000
Date: Mon, 30 Mar 2026 08:08:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 86c778fe5cab16f710cd3b71e9982f49b5635e18
Message-ID: <202603300841.oxyHsrPw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 86c778fe5cab16f710cd3b71e9982f49b5635e18  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 736m

configs tested: 216
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260329    gcc-14.3.0
arc                   randconfig-001-20260329    gcc-8.5.0
arc                   randconfig-002-20260329    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260329    clang-23
arm                   randconfig-001-20260329    gcc-8.5.0
arm                   randconfig-002-20260329    clang-23
arm                   randconfig-002-20260329    gcc-8.5.0
arm                   randconfig-003-20260329    clang-16
arm                   randconfig-003-20260329    gcc-8.5.0
arm                   randconfig-004-20260329    clang-23
arm                   randconfig-004-20260329    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260329    gcc-12.5.0
arm64                 randconfig-002-20260329    clang-23
arm64                 randconfig-002-20260329    gcc-12.5.0
arm64                 randconfig-003-20260329    clang-23
arm64                 randconfig-003-20260329    gcc-12.5.0
arm64                 randconfig-004-20260329    gcc-12.5.0
arm64                 randconfig-004-20260329    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260329    gcc-11.5.0
csky                  randconfig-001-20260329    gcc-12.5.0
csky                  randconfig-002-20260329    gcc-11.5.0
csky                  randconfig-002-20260329    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260329    clang-23
hexagon               randconfig-001-20260329    gcc-11.5.0
hexagon               randconfig-002-20260329    clang-23
hexagon               randconfig-002-20260329    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260329    clang-20
i386        buildonly-randconfig-002-20260329    clang-20
i386        buildonly-randconfig-003-20260329    clang-20
i386        buildonly-randconfig-004-20260329    clang-20
i386        buildonly-randconfig-004-20260329    gcc-14
i386        buildonly-randconfig-005-20260329    clang-20
i386        buildonly-randconfig-005-20260329    gcc-14
i386        buildonly-randconfig-006-20260329    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260329    clang-20
i386                  randconfig-002-20260329    clang-20
i386                  randconfig-003-20260329    clang-20
i386                  randconfig-004-20260329    clang-20
i386                  randconfig-005-20260329    clang-20
i386                  randconfig-005-20260329    gcc-14
i386                  randconfig-006-20260329    clang-20
i386                  randconfig-007-20260329    clang-20
i386                  randconfig-007-20260329    gcc-14
i386                  randconfig-011-20260329    clang-20
i386                  randconfig-012-20260329    clang-20
i386                  randconfig-013-20260329    clang-20
i386                  randconfig-014-20260329    clang-20
i386                  randconfig-015-20260329    clang-20
i386                  randconfig-016-20260329    clang-20
i386                  randconfig-017-20260329    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260329    gcc-11.5.0
loongarch             randconfig-001-20260329    gcc-15.2.0
loongarch             randconfig-002-20260329    clang-23
loongarch             randconfig-002-20260329    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        maltaup_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260329    gcc-10.5.0
nios2                 randconfig-001-20260329    gcc-11.5.0
nios2                 randconfig-002-20260329    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260329    gcc-8.5.0
parisc                randconfig-002-20260329    gcc-11.5.0
parisc                randconfig-002-20260329    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260329    clang-17
powerpc               randconfig-001-20260329    gcc-8.5.0
powerpc               randconfig-002-20260329    gcc-8.5.0
powerpc64             randconfig-001-20260329    gcc-8.5.0
powerpc64             randconfig-002-20260329    clang-23
powerpc64             randconfig-002-20260329    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260329    clang-23
riscv                 randconfig-002-20260329    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260329    clang-23
s390                  randconfig-002-20260329    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260329    clang-23
sh                    randconfig-002-20260329    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260329    gcc-14
sparc                 randconfig-002-20260329    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260329    gcc-14
sparc64               randconfig-002-20260329    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260329    gcc-14
um                    randconfig-002-20260329    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260329    gcc-14
x86_64                randconfig-002-20260329    gcc-14
x86_64                randconfig-003-20260329    gcc-14
x86_64                randconfig-004-20260329    gcc-14
x86_64                randconfig-005-20260329    gcc-14
x86_64                randconfig-006-20260329    gcc-14
x86_64                randconfig-011-20260329    gcc-14
x86_64                randconfig-012-20260329    gcc-14
x86_64                randconfig-013-20260329    gcc-14
x86_64                randconfig-014-20260329    gcc-14
x86_64                randconfig-015-20260329    gcc-14
x86_64                randconfig-016-20260329    gcc-14
x86_64                randconfig-071-20260329    clang-20
x86_64                randconfig-071-20260329    gcc-13
x86_64                randconfig-072-20260329    clang-20
x86_64                randconfig-073-20260329    clang-20
x86_64                randconfig-074-20260329    clang-20
x86_64                randconfig-075-20260329    clang-20
x86_64                randconfig-075-20260329    gcc-14
x86_64                randconfig-076-20260329    clang-20
x86_64                randconfig-076-20260329    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260329    gcc-14
xtensa                randconfig-002-20260329    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
