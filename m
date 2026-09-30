Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA874E06D1;
	Wed, 30 Sep 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781071; cv=none; b=gL8yodaUXwmpLGcr7hc/3xQujcE7yB94LWR0CDgj6/sOnC5GXVipebwNLeZ2GyuVqiAnByVLmcD+RzDoS1q+JiYyZQmzTeQZK85t+FflmdqUk8/K3G3UjKljc/NHgthFTF2OyN2DR593ItrRpWW65DWkebi5fp417mar1+FDRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781071; c=relaxed/simple;
	bh=BofmzIBPZtBCn/zUznRVBG6cbo7eAsPuT/1S3Eju0/s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ln2g1TlcIgzDoQOiglgwe+10ZYxcpcuAuE3/Xbf261uFpt8Quhv+fa+BVkhR5pJKNcLn+nfJWEH72zsv1IkA53kVol919k6ijcV8J/nDKjuQHF7D8Ycp5EVLVOUXn3n7DTxTAI3agAzw/7zU7GBT/mKJG9RJmrar2jshwQRvOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRu3n88Y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRu3n88Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790781056; x=1822317056;
  h=date:from:to:cc:subject:message-id;
  bh=BofmzIBPZtBCn/zUznRVBG6cbo7eAsPuT/1S3Eju0/s=;
  b=NRu3n88YPC3cbiBvA5wSfKf51PF54kQu4ttkWVa8KLCwTy8cOJ+fWrkC
   RHmNbZA93PiRj22c4sOztzb/1QFlfJwjTmNYqea13C82SeH+2J9GkWqPX
   fIvon7TynX20GEVHh7PgaNlEdM6vK3ignM19es6iPz+hQ9zB17ysaoF4K
   a3Ev1SJaSskBNY5UQCYfT2x66Br0Vwm6lcSZHZbjG88+5ewP9Y3BztCwR
   4OOu5mgHNMSaL2jkODcG23+QHnTtYr7dFu0KCiW5f7CM3hLEcWYMGwCMS
   yVAI3C5AR0I+pnx5HUqUEc5QbXaI3IKDnCa4mtenSZ+cMx/OTXe9dyprt
   g==;
X-CSE-ConnectionGUID: RAV6gPNNQNGwLd1XFkD8zQ==
X-CSE-MsgGUID: 70pS0GpqSAq/AFMrHT/3BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94232771"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="94232771"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 08:10:51 -0700
X-CSE-ConnectionGUID: aP6b6fYMQxO9SOq50vuWYg==
X-CSE-MsgGUID: d8lLSqXwQg26csekfPiE5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="279507742"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2026 08:10:50 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xBvxH-00000000Qmu-2Cb1;
	Wed, 30 Sep 2026 15:10:47 +0000
Date: Wed, 30 Sep 2026 23:09:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 0cbea88e01c30240f9323c71fced059301f398db
Message-ID: <202609302349.tqBn3yFU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 0cbea88e01c30240f9323c71fced059301f398db  Merge branch 'pm-cpufreq-fixes' into fixes

elapsed time: 1051m

configs tested: 325
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2103-20260930    clang-21   cocci
alpha                randconfig-r2106-20260930    gcc-9.5.0  cocci
alpha                randconfig-r2107-20260930    gcc-8.5.0  cocci
alpha                randconfig-r2200-20260930    gcc-11.5.0 smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arc                         nsim_700_defconfig    gcc-16.1.0
arc                   randconfig-1000-20260930    gcc-11.5.0
arc                   randconfig-1001-20260930    gcc-11.5.0
arc                  randconfig-r2101-20260930    gcc-16.1.0 cocci
arc                  randconfig-r2301-20260930    clang-24   sparse
arc                  randconfig-r2302-20260929    gcc-8.5.0  sparse
arc                  randconfig-r2309-20260930    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             dove_defconfig    gcc-16.1.0
arm                       integrator_defconfig    clang-24
arm                             mmp2_defconfig    gcc-16.1.0
arm                         mvebu_v5_defconfig    gcc-16.1.0
arm                             qcom_defconfig    clang-24
arm                   randconfig-1000-20260930    gcc-11.5.0
arm                   randconfig-1001-20260930    gcc-11.5.0
arm                   randconfig-1002-20260930    gcc-11.5.0
arm                   randconfig-1003-20260930    gcc-11.5.0
arm                  randconfig-r2100-20260930    clang-21   cocci
arm                  randconfig-r2103-20260929    gcc-15.2.0 cocci
arm                  randconfig-r2106-20260929    gcc-10.5.0 cocci
arm                  randconfig-r2106-20260930    clang-21   cocci
arm                  randconfig-r2202-20260930    clang-17   smatch
arm                  randconfig-r2305-20260929    gcc-8.5.0  sparse
arm                            sama5_defconfig    gcc-16.1.0
arm                         spear6xx_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260930    gcc-16.1.0
arm64                 randconfig-1001-20260930    gcc-16.1.0
arm64                 randconfig-1002-20260930    gcc-16.1.0
arm64                 randconfig-1003-20260930    gcc-16.1.0
arm64                randconfig-r2104-20260930    gcc-9.5.0  cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260930    gcc-16.1.0
csky                  randconfig-1001-20260930    gcc-16.1.0
csky                 randconfig-r2307-20260929    clang-22   sparse
csky                 randconfig-r2309-20260929    clang-22   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260930    clang-24
hexagon               randconfig-1001-20260930    clang-24
hexagon              randconfig-r2103-20260930    gcc-16.1.0 cocci
hexagon              randconfig-r2308-20260930    clang-24   sparse
i386                              alldefconfig    gcc-16.1.0
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260930    gcc-14
i386        buildonly-randconfig-1001-20260930    gcc-14
i386        buildonly-randconfig-1002-20260930    gcc-14
i386        buildonly-randconfig-1003-20260930    gcc-14
i386        buildonly-randconfig-1004-20260930    gcc-14
i386        buildonly-randconfig-1005-20260930    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260930    gcc-14
i386                  randconfig-1001-20260930    gcc-14
i386                  randconfig-1002-20260930    gcc-14
i386                  randconfig-1003-20260930    gcc-14
i386                  randconfig-1004-20260930    gcc-14
i386                  randconfig-1005-20260930    gcc-14
i386                  randconfig-1006-20260930    gcc-14
i386                  randconfig-1007-20260930    clang-22
i386                  randconfig-1008-20260930    clang-22
i386                  randconfig-1009-20260930    clang-22
i386                  randconfig-1010-20260930    clang-22
i386                  randconfig-1011-20260930    clang-22
i386                  randconfig-1012-20260930    clang-22
i386                  randconfig-1013-20260930    clang-22
i386                  randconfig-2100-20260929    clang-22   cocci
i386                  randconfig-2100-20260930    clang-22   cocci
i386                  randconfig-2101-20260929    clang-22   cocci
i386                  randconfig-2101-20260930    clang-22   cocci
i386                  randconfig-2102-20260929    clang-22   cocci
i386                  randconfig-2102-20260930    clang-22   cocci
i386                  randconfig-2103-20260929    clang-22   cocci
i386                  randconfig-2103-20260930    clang-22   cocci
i386                  randconfig-2200-20260929    gcc-14     smatch
i386                  randconfig-2200-20260930    gcc-14     smatch
i386                  randconfig-2300-20260929    gcc-14     sparse
i386                  randconfig-2300-20260930    gcc-13     sparse
i386                  randconfig-2301-20260929    gcc-14     sparse
i386                  randconfig-2301-20260930    gcc-13     sparse
i386                  randconfig-2302-20260929    gcc-14     sparse
i386                  randconfig-2302-20260930    gcc-13     sparse
i386                 randconfig-r2102-20260930    gcc-16.1.0 cocci
i386                 randconfig-r2104-20260929    gcc-10.5.0 cocci
i386                 randconfig-r2202-20260930    gcc-13     smatch
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260930    clang-24
loongarch             randconfig-1001-20260930    clang-24
loongarch            randconfig-r2200-20260929    clang-24   smatch
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    clang-24
m68k                           atari_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                        m5475evb_defconfig    gcc-16.1.0
m68k                 randconfig-r2105-20260930    gcc-9.5.0  cocci
m68k                 randconfig-r2106-20260930    gcc-8.5.0  cocci
m68k                 randconfig-r2300-20260930    clang-24   sparse
m68k                 randconfig-r2304-20260929    gcc-8.5.0  sparse
m68k                 randconfig-r2306-20260929    clang-22   sparse
m68k                 randconfig-r2307-20260930    clang-24   sparse
m68k                 randconfig-r2307-20260930    gcc-12.5.0 sparse
m68k                            virt_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2200-20260930    gcc-11.5.0 smatch
microblaze           randconfig-r2300-20260929    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                          bigsur_defconfig    gcc-16.1.0
mips                      loongson2k_defconfig    gcc-16.1.0
mips                           malta_defconfig    clang-24
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                         qi_lb60_defconfig    clang-24
mips                         qi_lb60_defconfig    gcc-16.1.0
mips                 randconfig-r2101-20260930    clang-21   cocci
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260930    clang-24
nios2                 randconfig-1001-20260930    clang-24
nios2                randconfig-r2200-20260930    gcc-10.5.0 smatch
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2100-20260930    gcc-16.1.0 cocci
openrisc             randconfig-r2102-20260930    clang-21   cocci
openrisc             randconfig-r2107-20260929    gcc-10.5.0 cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260930    gcc-8.5.0
parisc                randconfig-1001-20260930    gcc-8.5.0
parisc               randconfig-r2100-20260929    gcc-15.2.0 cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    gcc-16.1.0
powerpc                         fsp2_defconfig    gcc-16.1.0
powerpc                       ppc64e_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260930    gcc-8.5.0
powerpc               randconfig-1001-20260930    gcc-8.5.0
powerpc              randconfig-r2102-20260929    gcc-15.2.0 cocci
powerpc              randconfig-r2105-20260930    clang-21   cocci
powerpc              randconfig-r2201-20260929    gcc-10.5.0 smatch
powerpc              randconfig-r2201-20260930    gcc-14.3.0 smatch
powerpc              randconfig-r2302-20260930    clang-24   sparse
powerpc              randconfig-r2306-20260930    gcc-12.5.0 sparse
powerpc                      sequoia_defconfig    gcc-16.1.0
powerpc                      tqm8548_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260930    gcc-8.5.0
powerpc64             randconfig-1001-20260930    gcc-8.5.0
powerpc64            randconfig-r2107-20260930    clang-21   cocci
powerpc64            randconfig-r2201-20260930    clang-24   smatch
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                     nommu_k210_defconfig    clang-24
riscv                     nommu_k210_defconfig    gcc-16.1.0
riscv                 randconfig-1000-20260930    gcc-16.1.0
riscv                 randconfig-1001-20260930    gcc-16.1.0
riscv                 randconfig-2000-20260929    gcc-11.5.0
riscv                 randconfig-2000-20260930    gcc-14.3.0
riscv                 randconfig-2001-20260929    gcc-11.5.0
riscv                 randconfig-2001-20260930    gcc-14.3.0
riscv                randconfig-r2101-20260929    gcc-15.2.0 cocci
riscv                randconfig-r2202-20260929    clang-24   smatch
riscv                randconfig-r2306-20260930    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260930    gcc-16.1.0
s390                  randconfig-1001-20260930    gcc-16.1.0
s390                  randconfig-2000-20260929    gcc-11.5.0
s390                  randconfig-2000-20260930    gcc-14.3.0
s390                  randconfig-2001-20260929    gcc-11.5.0
s390                  randconfig-2001-20260930    gcc-14.3.0
s390                 randconfig-r2104-20260930    gcc-8.5.0  cocci
s390                 randconfig-r2105-20260929    gcc-10.5.0 cocci
s390                 randconfig-r2304-20260930    clang-24   sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         edosk7760_defconfig    clang-24
sh                              espt_defconfig    gcc-16.1.0
sh                             hp6xx_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260930    gcc-16.1.0
sh                    randconfig-1001-20260930    gcc-16.1.0
sh                    randconfig-2000-20260929    gcc-11.5.0
sh                    randconfig-2000-20260930    gcc-14.3.0
sh                    randconfig-2001-20260929    gcc-11.5.0
sh                    randconfig-2001-20260930    gcc-14.3.0
sh                           urquell_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260930    clang-22
sparc                 randconfig-1001-20260930    clang-22
sparc                 randconfig-2000-20260929    gcc-12.5.0
sparc                 randconfig-2000-20260930    gcc-10.5.0
sparc                 randconfig-2001-20260929    gcc-12.5.0
sparc                 randconfig-2001-20260930    gcc-10.5.0
sparc                randconfig-r2301-20260929    gcc-8.5.0  sparse
sparc                randconfig-r2308-20260930    gcc-12.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260930    clang-22
sparc64               randconfig-1001-20260930    clang-22
sparc64               randconfig-2000-20260929    gcc-12.5.0
sparc64               randconfig-2000-20260930    gcc-10.5.0
sparc64               randconfig-2001-20260929    gcc-12.5.0
sparc64               randconfig-2001-20260930    gcc-10.5.0
sparc64              randconfig-r2104-20260930    clang-21   cocci
sparc64              randconfig-r2303-20260929    gcc-8.5.0  sparse
sparc64              randconfig-r2303-20260930    clang-24   sparse
sparc64              randconfig-r2305-20260930    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260930    clang-22
um                    randconfig-1001-20260930    clang-22
um                    randconfig-2000-20260929    gcc-12.5.0
um                    randconfig-2000-20260930    gcc-10.5.0
um                    randconfig-2001-20260929    gcc-12.5.0
um                    randconfig-2001-20260930    gcc-10.5.0
um                   randconfig-r2105-20260930    gcc-8.5.0  cocci
um                   randconfig-r2201-20260930    clang-17   smatch
um                   randconfig-r2309-20260930    gcc-12.5.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260930    clang-22
x86_64      buildonly-randconfig-1001-20260930    clang-22
x86_64      buildonly-randconfig-1002-20260930    clang-22
x86_64      buildonly-randconfig-1003-20260930    clang-22
x86_64      buildonly-randconfig-1004-20260930    clang-22
x86_64      buildonly-randconfig-1005-20260930    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260930    gcc-14
x86_64                randconfig-1001-20260930    gcc-14
x86_64                randconfig-1002-20260930    gcc-14
x86_64                randconfig-1003-20260930    gcc-14
x86_64                randconfig-1004-20260930    gcc-14
x86_64                randconfig-1005-20260930    gcc-14
x86_64                randconfig-1006-20260930    gcc-14
x86_64                randconfig-1007-20260930    gcc-14
x86_64                randconfig-1008-20260930    gcc-14
x86_64                randconfig-1009-20260930    gcc-14
x86_64                randconfig-1010-20260930    gcc-14
x86_64                randconfig-1011-20260930    gcc-14
x86_64                randconfig-1012-20260930    clang-22
x86_64                randconfig-1013-20260930    clang-22
x86_64                randconfig-1014-20260930    clang-22
x86_64                randconfig-1015-20260930    clang-22
x86_64                randconfig-1016-20260930    clang-22
x86_64                randconfig-1017-20260930    clang-22
x86_64                randconfig-2100-20260929    clang-22   cocci
x86_64                randconfig-2100-20260930    clang-22   cocci
x86_64                randconfig-2101-20260929    clang-22   cocci
x86_64                randconfig-2101-20260930    clang-22   cocci
x86_64                randconfig-2102-20260929    clang-22   cocci
x86_64                randconfig-2102-20260930    clang-22   cocci
x86_64                randconfig-2103-20260929    clang-22   cocci
x86_64                randconfig-2103-20260930    clang-22   cocci
x86_64                randconfig-2200-20260929    clang-22   smatch
x86_64                randconfig-2200-20260930    gcc-14     smatch
x86_64                randconfig-2300-20260929    gcc-14     sparse
x86_64                randconfig-2300-20260930    gcc-13     sparse
x86_64                randconfig-2301-20260929    gcc-14     sparse
x86_64                randconfig-2301-20260930    gcc-13     sparse
x86_64                randconfig-2302-20260929    gcc-14     sparse
x86_64                randconfig-2302-20260930    gcc-13     sparse
x86_64               randconfig-r2107-20260930    gcc-9.5.0  cocci
x86_64               randconfig-r2308-20260929    clang-22   sparse
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
xtensa                randconfig-1000-20260930    clang-22
xtensa                randconfig-1001-20260930    clang-22
xtensa                randconfig-2000-20260929    gcc-12.5.0
xtensa                randconfig-2000-20260930    gcc-10.5.0
xtensa                randconfig-2001-20260929    gcc-12.5.0
xtensa                randconfig-2001-20260930    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
