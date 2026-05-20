Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FA3CBE97;
	Wed, 20 May 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269979; cv=none; b=R/MIQOmd7zv1SzGG01Nr3YijNLt+jr+aozdOhRKZ/XWC3QhjYj79YCsHSz+ZDGAYQKxOG2lU/3uVMOTFP8WNh71JssMkED4wn8AkNBUhjDUejdC/jZ2q/0jzmRASyZVFvpzPdhhTXN7Plr2Y9fYZabnIHOSuEIiwzUPz+km/cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269979; c=relaxed/simple;
	bh=m9+avM20bxzIKDaK93ra3fU2azIOhHRiNZXpqVQ1G8A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uYMk4Wz8f8kSaxCXJ7VU+K/99EXYvaQowUYznQq7yNcUD7QnC3T4wR090l9FVorSLa4iV1LXkVP8ylzO/aiWWGLNd+TFmkd70Q2decCS97oZtdeQRQzkRX4rNhmpSMqgPG1AhKH1J0VJ8iCKV7S/ePmHLY+T7Vb1rbxOMLOaD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3EER962; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3EER962"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779269973; x=1810805973;
  h=date:from:to:cc:subject:message-id;
  bh=m9+avM20bxzIKDaK93ra3fU2azIOhHRiNZXpqVQ1G8A=;
  b=N3EER962mmRTyR3rNw+OZdayEkevyJx+ao4VvOtT+cYbQQiYouWGX3Fb
   4EgotQKKpxgX7fXLKgNeOoxCyNYazSB3bC5G3kbX+8fdcTa4+iTtrCIqy
   Mxz7pJkIcT/3GoRqcPVsCugr5AyzSOb+/bTF5MsD+CMMiwwEh47RYwB65
   xpYuB5kFHvdFErhOx3xGl0AsLfYR2QgaO5PcIohifnOFhugXr9PPgxsoN
   ZgWM1qDKMBB+GfMwf2giZm/FujNK/4o0gMP5ibDtHYDEjF3LuJcfwfQK3
   Av2C/s7mnH1yVrXIL+sWiBqS3oIPiK+GKFNNH+gI8Da3kiC+cRXKfjlJn
   w==;
X-CSE-ConnectionGUID: WkO42a7nS9mW40O/hBDXAw==
X-CSE-MsgGUID: okEk0MGQSfiF6YvHAauQ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105622416"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="105622416"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:39:27 -0700
X-CSE-ConnectionGUID: a1erYinVTHGoANvf9aoWjQ==
X-CSE-MsgGUID: Ig++jCK3TxKdi8mEymPMxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="263901130"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2026 02:39:25 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPdOP-000000002vP-3a0p;
	Wed, 20 May 2026 09:39:14 +0000
Date: Wed, 20 May 2026 17:36:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 d9d246eff98a551e2f555d4cc3c4bb1d3af2719c
Message-ID: <202605201713.atlRDVV6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: d9d246eff98a551e2f555d4cc3c4bb1d3af2719c  Merge branch 'acpi-battery' into fixes

elapsed time: 725m

configs tested: 213
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
arc                   randconfig-001-20260520    gcc-8.5.0
arc                   randconfig-002-20260520    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                   randconfig-001-20260520    gcc-8.5.0
arm                   randconfig-002-20260520    gcc-8.5.0
arm                   randconfig-003-20260520    gcc-8.5.0
arm                   randconfig-004-20260520    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260520    gcc-10.5.0
arm64                 randconfig-002-20260520    gcc-10.5.0
arm64                 randconfig-003-20260520    gcc-10.5.0
arm64                 randconfig-004-20260520    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260520    gcc-10.5.0
csky                  randconfig-002-20260520    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260520    gcc-11.5.0
hexagon               randconfig-002-20260520    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260520    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260520    clang-20
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260520    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260520    clang-20
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260520    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260520    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260520    clang-20
i386                           randconfig-002    clang-20
i386                  randconfig-002-20260520    clang-20
i386                           randconfig-003    clang-20
i386                  randconfig-003-20260520    clang-20
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260520    clang-20
i386                           randconfig-005    clang-20
i386                  randconfig-005-20260520    clang-20
i386                           randconfig-006    clang-20
i386                  randconfig-006-20260520    clang-20
i386                           randconfig-007    clang-20
i386                  randconfig-007-20260520    clang-20
i386                  randconfig-011-20260520    gcc-14
i386                  randconfig-012-20260520    gcc-14
i386                  randconfig-013-20260520    gcc-14
i386                  randconfig-014-20260520    gcc-14
i386                  randconfig-015-20260520    gcc-14
i386                  randconfig-016-20260520    gcc-14
i386                  randconfig-017-20260520    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260520    gcc-11.5.0
loongarch             randconfig-002-20260520    gcc-11.5.0
m68k                             alldefconfig    gcc-15.2.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260520    gcc-11.5.0
nios2                 randconfig-002-20260520    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260520    clang-23
parisc                randconfig-002-20260520    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260520    clang-23
powerpc               randconfig-002-20260520    clang-23
powerpc64                        alldefconfig    clang-23
powerpc64             randconfig-001-20260520    clang-23
powerpc64             randconfig-002-20260520    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260520    gcc-8.5.0
sparc                 randconfig-002-20260520    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260520    gcc-8.5.0
sparc64               randconfig-002-20260520    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260520    gcc-8.5.0
um                    randconfig-002-20260520    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260520    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260520    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260520    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260520    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260520    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260520    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                randconfig-001-20260520    clang-20
x86_64                randconfig-001-20260520    gcc-14
x86_64                         randconfig-002    clang-20
x86_64                randconfig-002-20260520    clang-20
x86_64                randconfig-002-20260520    gcc-14
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260520    clang-20
x86_64                randconfig-003-20260520    gcc-14
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260520    clang-20
x86_64                randconfig-004-20260520    gcc-14
x86_64                         randconfig-005    clang-20
x86_64                randconfig-005-20260520    clang-20
x86_64                randconfig-005-20260520    gcc-14
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260520    clang-20
x86_64                randconfig-006-20260520    gcc-14
x86_64                randconfig-011-20260520    gcc-14
x86_64                randconfig-012-20260520    gcc-14
x86_64                randconfig-013-20260520    gcc-14
x86_64                randconfig-014-20260520    gcc-14
x86_64                randconfig-015-20260520    gcc-14
x86_64                randconfig-016-20260520    gcc-14
x86_64                randconfig-071-20260520    gcc-14
x86_64                randconfig-072-20260520    gcc-14
x86_64                randconfig-073-20260520    gcc-14
x86_64                randconfig-074-20260520    gcc-14
x86_64                randconfig-075-20260520    gcc-14
x86_64                randconfig-076-20260520    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260520    gcc-8.5.0
xtensa                randconfig-002-20260520    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
