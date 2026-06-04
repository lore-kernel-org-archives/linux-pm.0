Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4313360EFB;
	Thu,  4 Jun 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567209; cv=none; b=lexzcrKJnBSsRxZOF0JDKtS2e+wRX0Q+xCIOmes9va8eeXUolLYXezIpH094Nl5C8xq0A0SXqVjKbMPgONjk3y/kSGUaX+gpFKCSpwlQL7mKSXsogG7Pan0mHaM77dvbEAczjzsYx5l2ZcioC98zBypo6v6JuLHBOefEq46jXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567209; c=relaxed/simple;
	bh=hjxeQPXsQra0yLDrHOzeES6S6ocN/OciQR9875BDcbI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s0qT7apMEbwZEwjHpHfDplWGgo63jfTUvyAAhJRM5mTkXe7CPvtbbCHxHq1V3Psf1uo3xve//fE+vnOLckMuAmjNtm8dIt8oPQYVsyXKtyWKqlUTu5vXxDPx1p7YVQrFU94p/sNv4l/HXE0Okdj8Dlc9zCq9lEiTerMavG6UUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccTMZ8cR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccTMZ8cR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780567208; x=1812103208;
  h=date:from:to:cc:subject:message-id;
  bh=hjxeQPXsQra0yLDrHOzeES6S6ocN/OciQR9875BDcbI=;
  b=ccTMZ8cRlL/mkPFZzdAvO5KzDeCpNsBN0jGXDdTijpkx8IwRSSaiAHm/
   Mc56oa4HuSDW8zFOHshFjJdM0JqasjjebIptx/BuRJMz1LL0V3qp0LfvQ
   PiqBF/e0wq1gFcCMFMyAqVsUmliO+jT6b4xY9y+wphw6oQ4pZm30KWDpC
   Ba20fCKgDLZr02YvFNrnpZqlPruzMqbU1DxThVEmgwMJggNYjOzoGmBPQ
   21Zega8TpdmEfyFt35vJVkhzHYHOFiXPM2J8NEM6HG9YgfpHYS+487P0T
   2n5/e6Jb/QcFh+dOdRnmpA82vGdAxm1vTJuPTK6Tqq8O8L+Ro12k0zc+4
   A==;
X-CSE-ConnectionGUID: ttNI5qEJR+62831q4YihIA==
X-CSE-MsgGUID: XQQC24TpTIuol/xQrIybpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81247531"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81247531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 03:00:07 -0700
X-CSE-ConnectionGUID: h5rOxZrGRqSGvx42xAxPFQ==
X-CSE-MsgGUID: ARsDA11CT76ro64XKTiHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="238166772"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2026 03:00:06 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wV4rr-00000000EZA-2MLp;
	Thu, 04 Jun 2026 10:00:03 +0000
Date: Thu, 04 Jun 2026 17:59:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 af69594f56f16ae017248f2465ddd175683ccf39
Message-ID: <202606041704.A7Dqj5qr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: af69594f56f16ae017248f2465ddd175683ccf39  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 2187m

configs tested: 141
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260604    gcc-10.5.0
arc                   randconfig-002-20260604    gcc-16.1.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                        keystone_defconfig    gcc-16.1.0
arm                   randconfig-001-20260604    gcc-8.5.0
arm                   randconfig-002-20260604    gcc-14.3.0
arm                   randconfig-003-20260604    clang-23
arm                   randconfig-004-20260604    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260604    clang-23
arm64                 randconfig-002-20260604    clang-23
arm64                 randconfig-003-20260604    clang-20
arm64                 randconfig-004-20260604    clang-23
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260604    gcc-16.1.0
csky                  randconfig-002-20260604    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260604    clang-23
hexagon               randconfig-002-20260604    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260604    clang-22
i386        buildonly-randconfig-002-20260604    gcc-14
i386        buildonly-randconfig-003-20260604    gcc-14
i386        buildonly-randconfig-004-20260604    clang-22
i386        buildonly-randconfig-005-20260604    gcc-14
i386        buildonly-randconfig-006-20260604    clang-22
i386                                defconfig    clang-22
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260604    clang-18
loongarch             randconfig-002-20260604    gcc-16.1.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260604    gcc-8.5.0
nios2                 randconfig-002-20260604    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260604    gcc-11.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260604    gcc-13.4.0
parisc64                            defconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260604    clang-23
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260604    clang-23
powerpc64                      randconfig-001    clang-16
powerpc64             randconfig-001-20260604    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260604    clang-18
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                          randconfig-001    gcc-8.5.0
riscv                 randconfig-001-20260604    clang-23
riscv                          randconfig-002    clang-23
riscv                 randconfig-002-20260604    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-18
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20260604    clang-23
s390                           randconfig-002    clang-23
s390                  randconfig-002-20260604    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-16.1.0
sh                             randconfig-001    gcc-16.1.0
sh                    randconfig-001-20260604    gcc-16.1.0
sh                             randconfig-002    gcc-14.3.0
sh                    randconfig-002-20260604    gcc-16.1.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260604    gcc-13.4.0
sparc                 randconfig-002-20260604    gcc-11.5.0
sparc64                          allmodconfig    clang-20
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260604    gcc-9.5.0
sparc64               randconfig-002-20260604    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260604    clang-23
um                    randconfig-002-20260604    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260604    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260604    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260604    gcc-13.4.0
xtensa                randconfig-002-20260604    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
