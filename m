Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436F47CC73;
	Thu, 17 Sep 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686358; cv=none; b=rourqucWWzFPvAvL6BiBrQd0pbDggy3vO3P4Xe4Ya2mKuXDPrdJJDZMThSIjlSaGJ2NiOiZ6D8icB9KMHZpx61dC4gYeqdBNDTn93j3heBEbR/PIwpA85hiHCypLJpyLmJA/Idgr6nqC4AtqgLOj7qEj+zUtB+MsxB60HYWBzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686358; c=relaxed/simple;
	bh=5VIKYhYjDgWjRc1wSCgLrMa7vsIPJl7iFXaZONPXlKw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zwz+UIlt9GjJprqCAT2fJuVMdTLvvb197A+/mFltyzQ55CLjzi0O30REnixQADF4MDtomiXdDwor2Q5ipNpmA1sd3rE5aPXsa+lTLm/VDW/+msH4k593tf16DycWMyC4R/wQZJOiDkXJszpVt0RbdKoDLxvliv8siK6XUkRPnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hqdn6ugO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hqdn6ugO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789686352; x=1821222352;
  h=date:from:to:cc:subject:message-id;
  bh=5VIKYhYjDgWjRc1wSCgLrMa7vsIPJl7iFXaZONPXlKw=;
  b=Hqdn6ugOokdwrYpDJ/Gv4rTw4nnXpdyOhKEU8OExAtf/J16ShPVGMBle
   zb/2H6fOuS4QOEUZZEzt4UV4Sft3JFBVDuSCosawNQm3az+9IvyVgi6qA
   x7lseRPmktbrUxQW2nhAbXRPSEpvH9yIrrW4iy90DSPWoo677b+r0XErk
   i76jXQl6ZfsEHpVwsvzOMfvnzXexbUO/JXo0sxY/gbFHxKr9A1hfTIFTD
   xESUDZX0+HNuv+j3f0q/swB6H7V9bVAT2gVwG4Vg8HasQXSYgs2geJ2+F
   ScNNOYXuON7lV9XCAvzlX9qGYViL5MSwOJeanMC3fAj1wJtHVDWWRiIRJ
   w==;
X-CSE-ConnectionGUID: 8mVJNMWFRh6E/GNrnFZOVg==
X-CSE-MsgGUID: uTCEHVsRSbq4Mb8iV9wRxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89295172"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89295172"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 16:05:48 -0700
X-CSE-ConnectionGUID: aOTxkUL4RAOjU3Dnls/4ng==
X-CSE-MsgGUID: Tdbp8LQJSGy8IUmIjgfVyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2293631"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 17 Sep 2026 16:05:47 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7LAm-000000008f7-2YPo;
	Thu, 17 Sep 2026 23:05:44 +0000
Date: Fri, 18 Sep 2026 07:05:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 7d81fd7f1644e8172350caa5b32aa00e57050ec0
Message-ID: <202609180725.EUIk48d3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7d81fd7f1644e8172350caa5b32aa00e57050ec0  Merge branch 'pm-tools' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202609171147.kpmULcuM-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202609172243.uPgiesDR-lkp@intel.com

    drivers/bluetooth/btintel.c:2725:14: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Wimplicit-function-declaration]
    drivers/bluetooth/btintel.c:2725:7: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/bluetooth/btintel.c:2725:7: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Werror=implicit-function-declaration]
    drivers/bluetooth/btintel.c:2729:14: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Wimplicit-function-declaration]
    drivers/bluetooth/btintel.c:2729:7: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/bluetooth/btintel.c:2769:7: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    drivers/bluetooth/btintel.c:2769:7: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- arc-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- arc-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- arc-randconfig-1000-20260917
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- arc-randconfig-r1307-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- arm-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- arm64-randconfig-1002-20260917
|   `-- drivers-bluetooth-btintel.c:error:call-to-undeclared-function-acpi_has_method-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- csky-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- hexagon-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:call-to-undeclared-function-acpi_has_method-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-1000-20260918
|   `-- drivers-bluetooth-btintel.c:error:call-to-undeclared-function-acpi_has_method-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- hexagon-randconfig-1001-20260917
|   `-- drivers-bluetooth-btintel.c:error:call-to-undeclared-function-acpi_has_method-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- m68k-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- m68k-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- microblaze-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- mips-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- mips-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- nios2-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- nios2-randconfig-1000-20260917
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- openrisc-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- parisc-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- parisc-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- parisc-randconfig-1001-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- powerpc-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- powerpc64-randconfig-1000-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- riscv-randconfig-1000-20260917
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sh-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sh-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sh-randconfig-1001-20260917
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sh-randconfig-1001-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sparc-randconfig-1000-20260917
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sparc-randconfig-1000-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sparc-randconfig-1001-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- sparc64-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:call-to-undeclared-function-acpi_has_method-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- sparc64-randconfig-1000-20260918
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- um-allmodconfig
|   `-- drivers-bluetooth-btintel.c:error:call-to-undeclared-function-acpi_has_method-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- um-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
|-- xtensa-allyesconfig
|   `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method
`-- xtensa-randconfig-1001-20260918
    `-- drivers-bluetooth-btintel.c:error:implicit-declaration-of-function-acpi_has_method

elapsed time: m

configs tested: 234
configs skipped: 9

tested configs:
alpha                             alldefconfig    gcc-16.1.0
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r1304-20260917    clang-21   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20260917    gcc-15.2.0
arc                   randconfig-1000-20260918    gcc-16.1.0
arc                   randconfig-1001-20260917    gcc-15.2.0
arc                   randconfig-1001-20260918    gcc-16.1.0
arc                         vdk_hs38_defconfig    clang-24
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                   randconfig-1000-20260917    gcc-15.2.0
arm                   randconfig-1000-20260918    gcc-16.1.0
arm                   randconfig-1001-20260917    gcc-15.2.0
arm                   randconfig-1001-20260918    gcc-16.1.0
arm                   randconfig-1002-20260917    gcc-15.2.0
arm                   randconfig-1002-20260918    gcc-16.1.0
arm                   randconfig-1003-20260917    gcc-15.2.0
arm                   randconfig-1003-20260918    gcc-16.1.0
arm                  randconfig-r1308-20260917    gcc-13.4.0 sparse
arm                          s5pv210_defconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20260917    gcc-11.5.0
arm64                 randconfig-1001-20260917    gcc-11.5.0
arm64                 randconfig-1002-20260917    gcc-11.5.0
arm64                 randconfig-1003-20260917    gcc-11.5.0
arm64                randconfig-r1306-20260917    clang-18   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20260917    gcc-11.5.0
csky                  randconfig-1001-20260917    gcc-11.5.0
csky                 randconfig-r1309-20260917    clang-18   sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20260917    clang-24
hexagon               randconfig-1001-20260917    clang-24
hexagon              randconfig-r1300-20260917    clang-21   sparse
hexagon              randconfig-r1307-20260917    clang-18   sparse
hexagon              randconfig-r2100-20260917    clang-24
hexagon              randconfig-r2102-20260917    clang-24
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20260917    gcc-13
i386        buildonly-randconfig-1001-20260917    gcc-13
i386        buildonly-randconfig-1002-20260917    gcc-13
i386        buildonly-randconfig-1003-20260917    gcc-13
i386        buildonly-randconfig-1004-20260917    gcc-13
i386        buildonly-randconfig-1005-20260917    gcc-13
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20260917    clang-22
i386                  randconfig-1001-20260917    clang-22
i386                  randconfig-1002-20260917    clang-22
i386                  randconfig-1003-20260917    clang-22
i386                  randconfig-1004-20260917    clang-22
i386                  randconfig-1005-20260917    clang-22
i386                  randconfig-1006-20260917    clang-22
i386                  randconfig-1007-20260917    clang-22
i386                  randconfig-1008-20260917    clang-22
i386                  randconfig-1009-20260917    clang-22
i386                  randconfig-1010-20260917    clang-22
i386                  randconfig-1011-20260917    clang-22
i386                  randconfig-1012-20260917    clang-22
i386                  randconfig-1013-20260917    clang-22
i386                  randconfig-1300-20260917    gcc-14     sparse
i386                  randconfig-1301-20260917    gcc-14     sparse
i386                  randconfig-1302-20260917    gcc-14     sparse
i386                  randconfig-2100-20260917    gcc-14
i386                  randconfig-2101-20260917    gcc-14
i386                  randconfig-2102-20260917    gcc-14
i386                  randconfig-2103-20260917    clang-22
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20260917    clang-24
loongarch             randconfig-1001-20260917    clang-24
loongarch            randconfig-r1309-20260917    gcc-13.4.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                          amcore_defconfig    gcc-16.1.0
m68k                          apollo_defconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                         m5272c3_defconfig    gcc-16.1.0
m68k                         mvme147_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                   cavium_octeon_defconfig    gcc-16.1.0
mips                            gcw0_defconfig    clang-24
mips                       malta_kvm_defconfig    gcc-16.1.0
mips                         omega2p_defconfig    clang-24
mips                 randconfig-r2201-20260917    gcc-14.3.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20260917    clang-24
nios2                 randconfig-1001-20260917    clang-24
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r1308-20260917    clang-18   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20260917    gcc-11.5.0
parisc                randconfig-1000-20260918    gcc-8.5.0
parisc                randconfig-1001-20260917    gcc-11.5.0
parisc                randconfig-1001-20260918    gcc-8.5.0
parisc               randconfig-r1302-20260917    clang-21   sparse
parisc               randconfig-r2202-20260917    gcc-10.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    clang-24
powerpc                       ep88xc_defconfig    gcc-16.1.0
powerpc                           g5_defconfig    clang-24
powerpc                      kmeter1_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20260917    gcc-11.5.0
powerpc               randconfig-1000-20260918    gcc-8.5.0
powerpc               randconfig-1001-20260917    gcc-11.5.0
powerpc               randconfig-1001-20260918    gcc-8.5.0
powerpc                   storcenter_defconfig    gcc-16.1.0
powerpc                         warp_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20260917    gcc-11.5.0
powerpc64             randconfig-1000-20260918    gcc-8.5.0
powerpc64             randconfig-1001-20260917    gcc-11.5.0
powerpc64             randconfig-1001-20260918    gcc-8.5.0
powerpc64            randconfig-r1305-20260917    clang-21   sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv              nommu_k210_sdcard_defconfig    clang-24
riscv                 randconfig-1000-20260917    clang-17
riscv                 randconfig-1001-20260917    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20260917    clang-17
s390                  randconfig-1001-20260917    clang-17
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    gcc-16.1.0
sh                    randconfig-1000-20260917    clang-17
sh                    randconfig-1001-20260917    clang-17
sh                            se7750_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20260917    clang-17
sparc                 randconfig-1001-20260917    clang-17
sparc                randconfig-r1306-20260917    gcc-13.4.0 sparse
sparc                randconfig-r1307-20260917    gcc-13.4.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20260917    clang-17
sparc64               randconfig-1001-20260917    clang-17
sparc64              randconfig-r1301-20260917    clang-21   sparse
sparc64              randconfig-r1303-20260917    clang-21   sparse
sparc64              randconfig-r2101-20260917    clang-24
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20260917    clang-17
um                    randconfig-1001-20260917    clang-17
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20260917    gcc-14
x86_64      buildonly-randconfig-1001-20260917    gcc-14
x86_64      buildonly-randconfig-1002-20260917    gcc-14
x86_64      buildonly-randconfig-1003-20260917    gcc-14
x86_64      buildonly-randconfig-1004-20260917    gcc-14
x86_64      buildonly-randconfig-1005-20260917    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20260917    clang-22
x86_64                randconfig-1001-20260917    clang-22
x86_64                randconfig-1002-20260917    clang-22
x86_64                randconfig-1003-20260917    clang-22
x86_64                randconfig-1004-20260917    clang-22
x86_64                randconfig-1005-20260917    clang-22
x86_64                randconfig-1006-20260917    clang-22
x86_64                randconfig-1007-20260917    clang-22
x86_64                randconfig-1008-20260917    clang-22
x86_64                randconfig-1009-20260917    clang-22
x86_64                randconfig-1010-20260917    clang-22
x86_64                randconfig-1011-20260917    clang-22
x86_64                randconfig-1012-20260917    clang-22
x86_64                randconfig-1013-20260917    clang-22
x86_64                randconfig-1014-20260917    clang-22
x86_64                randconfig-1015-20260917    clang-22
x86_64                randconfig-1016-20260917    clang-22
x86_64                randconfig-1017-20260917    clang-22
x86_64                randconfig-1300-20260917    gcc-14     sparse
x86_64                randconfig-1301-20260917    gcc-14     sparse
x86_64                randconfig-1302-20260917    gcc-14     sparse
x86_64                randconfig-2100-20260917    clang-22
x86_64                randconfig-2101-20260917    gcc-14
x86_64                randconfig-2102-20260917    gcc-14
x86_64                randconfig-2103-20260917    gcc-13
x86_64                randconfig-2200-20260917    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                            alldefconfig    gcc-16.1.0
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   cadence_csp_defconfig    gcc-16.1.0
xtensa                           iss_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20260917    clang-17
xtensa                randconfig-1001-20260917    clang-17
xtensa               randconfig-r2103-20260917    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
