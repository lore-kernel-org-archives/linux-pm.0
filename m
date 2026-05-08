Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE53DDDCA;
	Fri,  8 May 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251512; cv=none; b=ZIYUS9sN7OkiDOxmjjHpdKFdwJ6PwL97S/3nXp6HhFMJ7X1BRg7h2Z4svJfj+Ic3q6J8teTO2aoCST2TpmEZS+CS4s+ibYBG9RtFGeRcMsJCY14irJV6EilAuLiegAMrhZsCThlR4M/m6gVn6ennCdxBnOfVn9+juMtJoVLMLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251512; c=relaxed/simple;
	bh=Gc2EfqV8sZA7GNGjeo8ktTlOSUPHU+xk+RIV0oZnSN4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VmRC8CXlfxfn2QFpNsvKN+L2APuBjJ32HD+u4NgIHzio4hbjXi4WpxkENjYbRCaY7Gtpc8Fk0QmdY7ab9HoQ1rEI7b/r6GQEBA9KxTF3IZhDsQ0FdRdQjGO7hgfgMJE2RFykhTCQ4C8SCm2ZFcHOGv3Bo9T5E4GO8RHVDwqzEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LX/bfmcV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LX/bfmcV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778251510; x=1809787510;
  h=date:from:to:cc:subject:message-id;
  bh=Gc2EfqV8sZA7GNGjeo8ktTlOSUPHU+xk+RIV0oZnSN4=;
  b=LX/bfmcVYoTv5yZ/bpxopEz0GxKHqrG7zwjYkEghQU2lXYenf0Pcloge
   iSyEf4sAKC7uCP7i+alXCM6j/f2Iebtvz63ApyfCRtYEogyE8uUCjSG/9
   tqLiTecnQ28ZHe8YJ5mMF8909of+0Ut1o9TZ+hgneWlbx291rPn3AJDV1
   SkoxWX/D2/vzXWoO9oiQj5zWchGr4k3HSIZ3AvpIEpw/UKKH8g13olpL+
   Aqm6nVsI7Gp6sZKZdp9ybDC0wjjhW0OaOBWBf2E1enYpU9tHSVdE64Pqi
   J7rd0FHfVCUvUJvUNLFztnPbQuCwfn2Jy07Oxk5oPDi8r32KUt+UVZkT/
   Q==;
X-CSE-ConnectionGUID: KF/eAaqHQyaLkGaPFIHdJQ==
X-CSE-MsgGUID: XwIZ6aFnSbq30tT0mIqcbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="81784869"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81784869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 07:45:10 -0700
X-CSE-ConnectionGUID: t9bDG4EHSwart9p5/vmwjQ==
X-CSE-MsgGUID: EaTERD+NQkaG3f7cKB6HDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232443853"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2026 07:45:08 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLMRt-000000000Ch-3amj;
	Fri, 08 May 2026 14:45:05 +0000
Date: Fri, 08 May 2026 22:45:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3dda17d8701a8aa01fb888bdaf702e581bab656a
Message-ID: <202605082259.cARsSRNn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3dda17d8701a8aa01fb888bdaf702e581bab656a  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 798m

configs tested: 215
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.2.0
arc                     haps_hs_smp_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260508    gcc-12.5.0
arc                   randconfig-001-20260508    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260508    gcc-12.5.0
arc                   randconfig-002-20260508    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260508    gcc-12.5.0
arm                   randconfig-001-20260508    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260508    gcc-12.5.0
arm                   randconfig-002-20260508    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260508    gcc-12.5.0
arm                   randconfig-003-20260508    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260508    gcc-12.5.0
arm                   randconfig-004-20260508    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260508    gcc-14.3.0
arm64                 randconfig-002-20260508    gcc-14.3.0
arm64                 randconfig-003-20260508    gcc-14.3.0
arm64                 randconfig-004-20260508    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260508    gcc-14.3.0
csky                  randconfig-002-20260508    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260508    clang-23
hexagon               randconfig-002-20260508    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260508    gcc-14
i386                 buildonly-randconfig-002    gcc-14
i386        buildonly-randconfig-002-20260508    gcc-14
i386                 buildonly-randconfig-003    gcc-14
i386        buildonly-randconfig-003-20260508    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260508    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260508    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260508    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260508    gcc-14
i386                  randconfig-002-20260508    gcc-14
i386                  randconfig-003-20260508    gcc-14
i386                  randconfig-004-20260508    gcc-14
i386                  randconfig-005-20260508    gcc-14
i386                  randconfig-006-20260508    gcc-14
i386                  randconfig-007-20260508    gcc-14
i386                  randconfig-011-20260508    gcc-13
i386                  randconfig-012-20260508    gcc-13
i386                  randconfig-013-20260508    gcc-13
i386                  randconfig-014-20260508    gcc-13
i386                  randconfig-015-20260508    gcc-13
i386                  randconfig-016-20260508    gcc-13
i386                  randconfig-017-20260508    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260508    clang-23
loongarch             randconfig-002-20260508    clang-23
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
mips                      loongson3_defconfig    gcc-15.2.0
mips                        omega2p_defconfig    clang-23
mips                         rt305x_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260508    clang-23
nios2                 randconfig-002-20260508    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260508    gcc-9.5.0
parisc                randconfig-002-20260508    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260508    gcc-9.5.0
powerpc               randconfig-002-20260508    gcc-9.5.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260508    gcc-9.5.0
powerpc64             randconfig-002-20260508    gcc-9.5.0
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260508    clang-23
riscv                 randconfig-002-20260508    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260508    clang-23
s390                  randconfig-002-20260508    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260508    clang-23
sh                    randconfig-002-20260508    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260508    gcc-12
sparc                 randconfig-002-20260508    gcc-12
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260508    gcc-12
sparc64               randconfig-002-20260508    gcc-12
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260508    gcc-12
um                    randconfig-002-20260508    gcc-12
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-14
x86_64      buildonly-randconfig-001-20260508    gcc-14
x86_64               buildonly-randconfig-002    gcc-14
x86_64      buildonly-randconfig-002-20260508    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260508    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260508    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260508    gcc-14
x86_64               buildonly-randconfig-006    gcc-14
x86_64      buildonly-randconfig-006-20260508    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260508    clang-20
x86_64                randconfig-002-20260508    clang-20
x86_64                randconfig-003-20260508    clang-20
x86_64                randconfig-004-20260508    clang-20
x86_64                randconfig-005-20260508    clang-20
x86_64                randconfig-006-20260508    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260508    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260508    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260508    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260508    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260508    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260508    gcc-14
x86_64                randconfig-071-20260508    gcc-14
x86_64                randconfig-072-20260508    gcc-14
x86_64                randconfig-073-20260508    gcc-14
x86_64                randconfig-074-20260508    gcc-14
x86_64                randconfig-075-20260508    gcc-14
x86_64                randconfig-076-20260508    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260508    gcc-12
xtensa                randconfig-002-20260508    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
