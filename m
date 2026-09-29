Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367483D9027
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704563; cv=none; b=sVeKG8VbKs4PXD13QyCxg5m8OZUyp9rIS6m8p9sb0YB5MhMmiXBBcHyNcsO8uMy8ubvdFoi481VsK+zspTgnLrWRJKcxEOZzAfCx1eG3uVthYskwXuK8adsAAYd0TkR1y0Yctrveqie75z/AK1ifB3PhCM7WCFCYNQspPbFQp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704563; c=relaxed/simple;
	bh=wK478mWs55/YGrfau3lYBcZH/HDA3wgeH+Nwz1xIGu0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cNXmO8hK3gwBqyBtE0c4+eorKUz94Gn4sYtZi6tbzPXPouAfauf1B2DHMpnfx1r4zofXymm5izpBVBJdqVu3BZGnhOADeqNZAC8LwOmTj637eYkO2J26iDoIkvz4bap+QS+lJxJ26fJgKuHyXqF9GlHi9L/dH1hayTX98jGA8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt+VwKBf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt+VwKBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790704562; x=1822240562;
  h=date:from:to:cc:subject:message-id;
  bh=wK478mWs55/YGrfau3lYBcZH/HDA3wgeH+Nwz1xIGu0=;
  b=Tt+VwKBfieJ5KWcamfVlVKvWfrviC06PYUufb0Mi0mgSulEwWvoq7iwt
   +l6kufjMHwAnbldAQ2HjOXJ3rmG32WGbImFOEe4BKE7YznS0P9bsNoVKR
   KEmW316ScX1VsJyH2mp0OUnd5gcceJnwah+Z/YxVh8ECl0pcgfU8FDBcV
   GqzQ1LOFh4vzPznIsdA9mqGOYZRIHbbxshUU1fNu96NCkDKdhJSOo5JX2
   iqbermUMiEYYY9Wd01W/reojNX5lMdGmcfZzTGNboo1qT/Htjjllv4Dyz
   fqjno0kqf3fQi0kf1f0R4FMyIvOhsms+/f+oJLZX81KH3sp8kR/Mq0GF0
   Q==;
X-CSE-ConnectionGUID: W9KmbwDCR6OlORzZZ+5T5g==
X-CSE-MsgGUID: Ey19zBvQS/yl/YyxNIT+gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90294635"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90294635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:56:02 -0700
X-CSE-ConnectionGUID: XV2GXl7vRMO3sUIDhKJATw==
X-CSE-MsgGUID: o4WTaL/0TxqQyenEl0ihWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280196547"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2026 10:56:00 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xBc3a-00000000Pbk-0jLW;
	Tue, 29 Sep 2026 17:55:58 +0000
Date: Wed, 30 Sep 2026 01:55:24 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 8f83f0474eb9744dc675a9af46c17ef2d03fea76
Message-ID: <202609300121.Stc00r0t-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 8f83f0474eb9744dc675a9af46c17ef2d03fea76  cpufreq: amd-pstate: Update Zen6 client EPP tuning values

elapsed time: 951m

configs tested: 336
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2103-20260929    gcc-16.1.0 cocci
alpha                randconfig-r2104-20260929    gcc-11.5.0 cocci
alpha                randconfig-r2107-20260929    gcc-11.5.0 cocci
alpha                randconfig-r2107-20260929    gcc-15.2.0 cocci
alpha                randconfig-r2200-20260929    gcc-11.5.0 smatch
alpha                randconfig-r2302-20260929    gcc-12.5.0 sparse
alpha                randconfig-r2303-20260929    gcc-12.5.0 sparse
alpha                randconfig-r2305-20260929    gcc-13.4.0 sparse
alpha                randconfig-r2309-20260929    gcc-13.4.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260929    clang-17
arc                   randconfig-1001-20260929    clang-17
arc                  randconfig-r2100-20260929    clang-24   cocci
arc                  randconfig-r2103-20260929    clang-22   cocci
arc                  randconfig-r2300-20260929    clang-24   sparse
arc                  randconfig-r2307-20260929    gcc-13.4.0 sparse
arc                  randconfig-r2309-20260929    clang-24   sparse
arc                            tb10x_defconfig    gcc-16.1.0
arc                     vdk_hs38_smp_defconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                          assabet_defconfig    gcc-16.1.0
arm                          at91_dt_defconfig    gcc-16.1.0
arm                         clps711x_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                       footbridge_defconfig    gcc-16.1.0
arm                              mxs_defconfig    gcc-16.1.0
arm                          orion5x_defconfig    gcc-16.1.0
arm                   randconfig-1000-20260929    clang-17
arm                   randconfig-1001-20260929    clang-17
arm                   randconfig-1002-20260929    clang-17
arm                   randconfig-1003-20260929    clang-17
arm                  randconfig-r2305-20260929    gcc-12.5.0 sparse
arm                  randconfig-r2308-20260929    gcc-13.4.0 sparse
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260929    clang-24
arm64                 randconfig-1001-20260929    clang-24
arm64                 randconfig-1002-20260929    clang-24
arm64                 randconfig-1003-20260929    clang-24
arm64                randconfig-r2102-20260929    clang-24   cocci
arm64                randconfig-r2301-20260929    gcc-12.5.0 sparse
arm64                randconfig-r2301-20260929    gcc-13.4.0 sparse
arm64                randconfig-r2302-20260929    clang-24   sparse
arm64                randconfig-r2306-20260929    clang-19   sparse
arm64                randconfig-r2309-20260929    gcc-16.1.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260929    clang-24
csky                  randconfig-1001-20260929    clang-24
csky                 randconfig-r2105-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2107-20260929    gcc-16.1.0 cocci
csky                 randconfig-r2200-20260929    gcc-14.3.0 smatch
csky                 randconfig-r2300-20260929    gcc-12.5.0 sparse
csky                 randconfig-r2309-20260929    clang-19   sparse
csky                 randconfig-r2309-20260929    gcc-11.5.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260929    gcc-8.5.0
hexagon               randconfig-1001-20260929    gcc-8.5.0
hexagon              randconfig-r2101-20260929    clang-24   cocci
hexagon              randconfig-r2202-20260929    clang-17   smatch
hexagon              randconfig-r2302-20260929    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260929    clang-22
i386        buildonly-randconfig-1001-20260929    clang-22
i386        buildonly-randconfig-1002-20260929    clang-22
i386        buildonly-randconfig-1003-20260929    clang-22
i386        buildonly-randconfig-1004-20260929    clang-22
i386        buildonly-randconfig-1005-20260929    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260929    gcc-13
i386                  randconfig-1001-20260929    gcc-13
i386                  randconfig-1002-20260929    gcc-13
i386                  randconfig-1003-20260929    gcc-13
i386                  randconfig-1004-20260929    gcc-13
i386                  randconfig-1005-20260929    gcc-13
i386                  randconfig-1006-20260929    gcc-13
i386                  randconfig-1007-20260929    gcc-14
i386                  randconfig-1008-20260929    gcc-14
i386                  randconfig-1009-20260929    gcc-14
i386                  randconfig-1010-20260929    gcc-14
i386                  randconfig-1011-20260929    gcc-14
i386                  randconfig-1012-20260929    gcc-14
i386                  randconfig-1013-20260929    gcc-14
i386                  randconfig-2100-20260929    clang-22   cocci
i386                  randconfig-2101-20260929    clang-22   cocci
i386                  randconfig-2102-20260929    clang-22   cocci
i386                  randconfig-2103-20260929    clang-22   cocci
i386                  randconfig-2200-20260929    gcc-14     smatch
i386                  randconfig-2300-20260929    gcc-14     sparse
i386                  randconfig-2301-20260929    gcc-14     sparse
i386                  randconfig-2302-20260929    gcc-14     sparse
i386                 randconfig-r2106-20260929    gcc-16.1.0 cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260929    gcc-8.5.0
loongarch             randconfig-1001-20260929    gcc-8.5.0
loongarch            randconfig-r2102-20260929    clang-24   cocci
loongarch            randconfig-r2107-20260929    clang-22   cocci
loongarch            randconfig-r2201-20260929    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                        bvme6000_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                 randconfig-r2101-20260929    clang-24   cocci
m68k                 randconfig-r2104-20260929    clang-22   cocci
m68k                 randconfig-r2105-20260929    clang-22   cocci
m68k                 randconfig-r2200-20260929    gcc-11.5.0 smatch
m68k                 randconfig-r2303-20260929    clang-24   sparse
m68k                 randconfig-r2304-20260929    gcc-13.4.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2201-20260929    gcc-13.4.0 smatch
microblaze           randconfig-r2301-20260929    clang-24   sparse
microblaze           randconfig-r2306-20260929    clang-24   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                             gpr_defconfig    gcc-16.1.0
mips                            ip30_defconfig    gcc-16.1.0
mips                       loongson3_defconfig    gcc-16.1.0
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                 randconfig-r2100-20260929    clang-22   cocci
mips                 randconfig-r2103-20260929    clang-24   cocci
mips                 randconfig-r2200-20260929    gcc-12.5.0 smatch
mips                 randconfig-r2202-20260929    gcc-12.5.0 smatch
mips                 randconfig-r2300-20260929    clang-24   sparse
mips                 randconfig-r2300-20260929    gcc-13.4.0 sparse
mips                 randconfig-r2302-20260929    gcc-13.4.0 sparse
mips                 randconfig-r2303-20260929    clang-24   sparse
mips                 randconfig-r2306-20260929    gcc-13.4.0 sparse
mips                 randconfig-r2308-20260929    gcc-16.1.0 sparse
nios2                          10m50_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260929    gcc-8.5.0
nios2                 randconfig-1001-20260929    gcc-8.5.0
nios2                randconfig-r2106-20260929    gcc-11.5.0 cocci
nios2                randconfig-r2200-20260929    gcc-11.5.0 smatch
nios2                randconfig-r2303-20260929    gcc-13.4.0 sparse
nios2                randconfig-r2305-20260929    clang-24   sparse
nios2                randconfig-r2306-20260929    gcc-11.5.0 sparse
nios2                randconfig-r2307-20260929    gcc-11.5.0 sparse
openrisc                          alldefconfig    gcc-16.1.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2304-20260929    gcc-12.5.0 sparse
openrisc             randconfig-r2305-20260929    clang-24   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260929    gcc-8.5.0
parisc                randconfig-1001-20260929    gcc-8.5.0
parisc               randconfig-r2105-20260929    gcc-11.5.0 cocci
parisc64                             defconfig    clang-24
powerpc                      akebono_defconfig    gcc-16.1.0
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    gcc-16.1.0
powerpc                     gamecube_defconfig    gcc-16.1.0
powerpc                         icon_defconfig    gcc-16.1.0
powerpc                      ksi8560_defconfig    gcc-16.1.0
powerpc                    motionpro_defconfig    gcc-16.1.0
powerpc                  mpc837x_rdb_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260929    gcc-8.5.0
powerpc               randconfig-1001-20260929    gcc-8.5.0
powerpc              randconfig-r2102-20260929    gcc-16.1.0 cocci
powerpc              randconfig-r2104-20260929    gcc-16.1.0 cocci
powerpc              randconfig-r2201-20260929    gcc-10.5.0 smatch
powerpc              randconfig-r2202-20260929    clang-24   smatch
powerpc                     socrates_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260929    gcc-8.5.0
powerpc64             randconfig-1001-20260929    gcc-8.5.0
powerpc64            randconfig-r2104-20260929    gcc-15.2.0 cocci
powerpc64            randconfig-r2106-20260929    gcc-15.2.0 cocci
powerpc64            randconfig-r2304-20260929    clang-24   sparse
powerpc64            randconfig-r2307-20260929    clang-24   sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260929    clang-24
riscv                 randconfig-1001-20260929    clang-24
riscv                 randconfig-2000-20260929    gcc-11.5.0
riscv                 randconfig-2001-20260929    gcc-11.5.0
riscv                randconfig-r2100-20260929    clang-24   cocci
riscv                randconfig-r2100-20260929    gcc-16.1.0 cocci
riscv                randconfig-r2202-20260929    clang-24   smatch
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260929    clang-24
s390                  randconfig-1001-20260929    clang-24
s390                  randconfig-2000-20260929    gcc-11.5.0
s390                  randconfig-2001-20260929    gcc-11.5.0
s390                 randconfig-r2307-20260929    clang-19   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                              espt_defconfig    gcc-16.1.0
sh                           kfr2r09_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260929    clang-24
sh                    randconfig-1001-20260929    clang-24
sh                    randconfig-2000-20260929    gcc-11.5.0
sh                    randconfig-2001-20260929    gcc-11.5.0
sh                   randconfig-r2104-20260929    clang-22   cocci
sh                   randconfig-r2106-20260929    clang-22   cocci
sh                            se7343_defconfig    gcc-16.1.0
sh                            se7705_defconfig    gcc-16.1.0
sh                            se7721_defconfig    gcc-16.1.0
sh                            se7722_defconfig    gcc-16.1.0
sh                    secureedge5410_defconfig    gcc-16.1.0
sh                            sh2007_defconfig    gcc-16.1.0
sh                         sh7757lcr_defconfig    gcc-16.1.0
sh                         sh7785lcr_defconfig    gcc-16.1.0
sh                              shx3_defconfig    gcc-16.1.0
sh                             titan_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260929    gcc-14
sparc                 randconfig-1001-20260929    gcc-14
sparc                 randconfig-2000-20260929    gcc-12.5.0
sparc                 randconfig-2001-20260929    gcc-12.5.0
sparc                randconfig-r2101-20260929    gcc-16.1.0 cocci
sparc                randconfig-r2102-20260929    clang-24   cocci
sparc                randconfig-r2307-20260929    gcc-16.1.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260929    gcc-14
sparc64               randconfig-1001-20260929    gcc-14
sparc64               randconfig-2000-20260929    gcc-12.5.0
sparc64               randconfig-2001-20260929    gcc-12.5.0
sparc64              randconfig-r2100-20260929    clang-24   cocci
sparc64              randconfig-r2304-20260929    clang-24   sparse
sparc64              randconfig-r2308-20260929    clang-19   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260929    gcc-14
um                    randconfig-1001-20260929    gcc-14
um                    randconfig-2000-20260929    gcc-12.5.0
um                    randconfig-2001-20260929    gcc-12.5.0
um                   randconfig-r2201-20260929    gcc-14     smatch
um                   randconfig-r2202-20260929    clang-24   smatch
um                   randconfig-r2301-20260929    clang-24   sparse
um                   randconfig-r2308-20260929    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260929    clang-22
x86_64      buildonly-randconfig-1001-20260929    clang-22
x86_64      buildonly-randconfig-1002-20260929    clang-22
x86_64      buildonly-randconfig-1003-20260929    clang-22
x86_64      buildonly-randconfig-1004-20260929    clang-22
x86_64      buildonly-randconfig-1005-20260929    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260929    clang-22
x86_64                randconfig-1001-20260929    clang-22
x86_64                randconfig-1002-20260929    clang-22
x86_64                randconfig-1003-20260929    clang-22
x86_64                randconfig-1004-20260929    clang-22
x86_64                randconfig-1005-20260929    clang-22
x86_64                randconfig-1006-20260929    gcc-13
x86_64                randconfig-1007-20260929    gcc-13
x86_64                randconfig-1008-20260929    gcc-13
x86_64                randconfig-1009-20260929    gcc-13
x86_64                randconfig-1010-20260929    gcc-13
x86_64                randconfig-1011-20260929    gcc-13
x86_64                randconfig-1012-20260929    clang-22
x86_64                randconfig-1013-20260929    clang-22
x86_64                randconfig-1014-20260929    clang-22
x86_64                randconfig-1015-20260929    clang-22
x86_64                randconfig-1016-20260929    clang-22
x86_64                randconfig-1017-20260929    clang-22
x86_64                randconfig-2100-20260929    clang-22   cocci
x86_64                randconfig-2101-20260929    clang-22   cocci
x86_64                randconfig-2102-20260929    clang-22   cocci
x86_64                randconfig-2103-20260929    clang-22   cocci
x86_64                randconfig-2200-20260929    clang-22   smatch
x86_64                randconfig-2300-20260929    gcc-14     sparse
x86_64                randconfig-2301-20260929    gcc-14     sparse
x86_64                randconfig-2302-20260929    gcc-14     sparse
x86_64               randconfig-r2101-20260929    clang-24   cocci
x86_64               randconfig-r2102-20260929    clang-22   cocci
x86_64               randconfig-r2105-20260929    clang-22   cocci
x86_64               randconfig-r2106-20260929    clang-22   cocci
x86_64               randconfig-r2107-20260929    clang-22   cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20260929    gcc-14
xtensa                randconfig-1001-20260929    gcc-14
xtensa                randconfig-2000-20260929    gcc-12.5.0
xtensa                randconfig-2001-20260929    gcc-12.5.0
xtensa               randconfig-r2101-20260929    clang-22   cocci
xtensa               randconfig-r2105-20260929    gcc-15.2.0 cocci
xtensa               randconfig-r2306-20260929    gcc-16.1.0 sparse
xtensa               randconfig-r2308-20260929    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
