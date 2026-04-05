Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851335C184;
	Sun,  5 Apr 2026 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775375883; cv=none; b=GBt5qILtJlt03R0yGEINoyE4FvIp7Qd3VT9jKaMRfkFEcPnaAm0TmHTTi/ajIM4AFo8H0fOkI6rchyxuqDhL3DTnJzciKoMGta/zeQfnkg1pBEYPnPk8ISoBseWEd7wIuqswPRme7+lY2e+zcOOTIP84cDFx8379gmhCH0dDfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775375883; c=relaxed/simple;
	bh=2IBBdWzap0wuHHtr9wPl/G7boFbFLSHfnrXECYOgp/U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bCXG7xrjK9RcT+Z/8v0YX998k2KGzOZpWIcN8M4sHY7c1GKsCHVmxHoTP8ufG0eb5JzGQ3Ph77hxVXscFBrVhYH/VfySs/vKPTzUbUvzE6h4LAhOjrRPodxPzIW31SkbS0pIrMyoAGjnK+g+3DGaAL26r4ABCGh+nTEp1DAEvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhxU2sLf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhxU2sLf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775375881; x=1806911881;
  h=date:from:to:cc:subject:message-id;
  bh=2IBBdWzap0wuHHtr9wPl/G7boFbFLSHfnrXECYOgp/U=;
  b=NhxU2sLfaBMHldALEv7Aih4nyzamXALeDqSwG7cp17pLf1ba0pTPbvnT
   pW5FCRINPVG+vD9XSvzNYYnuismRQyTIv6A2Uit3LuyywHHiCikaTAEL0
   9u/13Iotv4kKbF/5TFCuEWWrY46Kq/4co+axT6VTqdhte8QJxUctYAcDV
   pgoiFNRC/8AD4uLM1iOR0YFANawJZvlW4PpCz/GhDHPAU1q0BRHn/msUf
   JCGIl1gME3GFeP9NM+v3C2IAgJqLRx7JYfNe3hGAGQsrpR3zC0bbamqma
   NtX+nmeBmAyhTrG7Xqkl8zkR1Y/C41wwY4BL5dRvwUhisQtigediXAkAm
   A==;
X-CSE-ConnectionGUID: fb1+s5IfSrSD4oUOLuP3zg==
X-CSE-MsgGUID: w5Mw9dNFQnaOymv611DlGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11749"; a="80254837"
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="80254837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2026 00:58:00 -0700
X-CSE-ConnectionGUID: VGezY20hQXGkTmcqagiELw==
X-CSE-MsgGUID: IBBAvRdkTLeCoJgKDbCMNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,161,1770624000"; 
   d="scan'208";a="224372209"
Received: from lkp-server01.sh.intel.com (HELO 3afb7d003cac) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Apr 2026 00:57:59 -0700
Received: from kbuild by 3afb7d003cac with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9IMn-000000001xf-0Zvm;
	Sun, 05 Apr 2026 07:57:57 +0000
Date: Sun, 05 Apr 2026 15:57:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6a1d42932a978b706bf626a4824cf92088347874
Message-ID: <202604051514.lk1xQDdn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6a1d42932a978b706bf626a4824cf92088347874  Merge branch 'pm-devfreq' into bleeding-edge

elapsed time: 737m

configs tested: 165
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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260405    clang-23
arc                   randconfig-002-20260405    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260405    clang-23
arm                   randconfig-002-20260405    clang-23
arm                   randconfig-003-20260405    clang-23
arm                   randconfig-004-20260405    clang-23
arm                         socfpga_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260405    gcc-9.5.0
arm64                 randconfig-002-20260405    gcc-9.5.0
arm64                 randconfig-003-20260405    gcc-9.5.0
arm64                 randconfig-004-20260405    gcc-9.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260405    gcc-9.5.0
csky                  randconfig-002-20260405    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260405    clang-16
hexagon               randconfig-001-20260405    clang-23
hexagon               randconfig-002-20260405    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260405    gcc-14
i386        buildonly-randconfig-002-20260405    gcc-14
i386        buildonly-randconfig-003-20260405    gcc-14
i386        buildonly-randconfig-004-20260405    gcc-14
i386        buildonly-randconfig-005-20260405    gcc-14
i386        buildonly-randconfig-006-20260405    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-011-20260405    gcc-14
i386                  randconfig-012-20260405    gcc-14
i386                  randconfig-013-20260405    gcc-14
i386                  randconfig-014-20260405    gcc-14
i386                  randconfig-015-20260405    gcc-14
i386                  randconfig-016-20260405    gcc-14
i386                  randconfig-017-20260405    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260405    clang-23
loongarch             randconfig-002-20260405    clang-23
loongarch             randconfig-002-20260405    gcc-13.4.0
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
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260405    clang-23
nios2                 randconfig-001-20260405    gcc-8.5.0
nios2                 randconfig-002-20260405    clang-23
nios2                 randconfig-002-20260405    gcc-9.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260405    gcc-10.5.0
parisc                randconfig-002-20260405    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260405    gcc-10.5.0
powerpc               randconfig-002-20260405    gcc-10.5.0
powerpc64             randconfig-001-20260405    gcc-10.5.0
powerpc64             randconfig-002-20260405    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260405    clang-23
riscv                 randconfig-002-20260405    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260405    clang-23
s390                  randconfig-002-20260405    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260405    clang-23
sh                    randconfig-002-20260405    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260405    clang-23
sparc                 randconfig-002-20260405    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260405    clang-23
sparc64               randconfig-002-20260405    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260405    clang-23
um                    randconfig-002-20260405    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260405    gcc-14
x86_64      buildonly-randconfig-002-20260405    gcc-14
x86_64      buildonly-randconfig-003-20260405    gcc-14
x86_64      buildonly-randconfig-004-20260405    gcc-14
x86_64      buildonly-randconfig-005-20260405    gcc-14
x86_64      buildonly-randconfig-006-20260405    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260405    clang-20
x86_64                randconfig-002-20260405    clang-20
x86_64                randconfig-003-20260405    clang-20
x86_64                randconfig-004-20260405    clang-20
x86_64                randconfig-005-20260405    clang-20
x86_64                randconfig-006-20260405    clang-20
x86_64                randconfig-011-20260405    gcc-14
x86_64                randconfig-012-20260405    gcc-14
x86_64                randconfig-013-20260405    gcc-14
x86_64                randconfig-014-20260405    gcc-14
x86_64                randconfig-015-20260405    gcc-14
x86_64                randconfig-016-20260405    gcc-14
x86_64                randconfig-071-20260405    gcc-14
x86_64                randconfig-072-20260405    gcc-14
x86_64                randconfig-073-20260405    gcc-14
x86_64                randconfig-074-20260405    gcc-14
x86_64                randconfig-075-20260405    gcc-14
x86_64                randconfig-076-20260405    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260405    clang-23
xtensa                randconfig-002-20260405    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
