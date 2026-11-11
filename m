Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426528;
	b=eFyX1D4B2h/v+uLvhfzA+w5Ps72LzSxgE4394g63uW1R7gvjogiBYZ0/4fLQ2qLf6CxI
	 E2vHVcaeCos5o5EgH7b5KiDNGwasplSitZhiUk5DUuG0lCXWjIQMOPssddFdDFLo9GtXs
	 P35xzsMoeunZuT9dmPSQAJldyG3xUBoewJBxImOk2ak6HAGXuMJUTUPT8mMaRGWafMM5M
	 kyoRP4X6cUQ8OjX11WO6U5XLzmKd58QctPrH04Pb3AvxsicXbIIBiA6a1Z5zV7ldC6CCo
	 xzvCQS8ENw0HDai3cquf+Li4DNd9CckD2ZO7oLD60vTxI9oEB/3i6vIeKeH++Zcp3Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426528;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=TkiAuk9hHTfz+zWp4F+H+755ZWtQZiAJhPwcUNQIxYY=;
	b=VO0mFLJcAJ3KHs5ivR4Ad4FepnJ08EoD8cPbceplPv6tXKnq815GqVIrFaJ5+Nc1h7U0
	 Dg4+LGbxEVZqqYSS52lnxj3BGHK9KkyG05Y99sXMfQmeH58znS/q7k7f4f111M5DakNxN
	 Q+TcrSuKQB5MKfmlaw7sDrK2XVC+i5SYDerFCx0sVhHWqmv7CnKX3adyq8xuf4o2F+63r
	 eBbrGETBxHtji7dlrimy2CzwBhPiPZ7+AreOe8ADIGul9YZDYLOW/u3yWnQ5bQrG8iIgi
	 V8KQQt4OJT4tdojZv3JaGSAFpgAr1CKIEx8AvOsqLGOE0lUJQQfznLJBB3g6WLdxNpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="N/oMvHG+";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE5606A31C;
	Wed, 11 Nov 2026 19:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22FE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N/oMvHG+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794426528; x=1825962528;
  h=date:from:to:cc:subject:message-id;
  bh=YRuN2ZlOJoRKcPyVMx4jwEwNOp5a4dOcOQYRB0INKNc=;
  b=N/oMvHG+xOuneV7dUrrtUzB4r9oWVujGKkgc52SN76WF/5cNd2SGx2Xa
   uMmHydWUkBRU3DivTDWL1eVkjHHJRsvrYyD7NQbgAmfKzi59t2AiDze+4
   2naJKObZhP+TyM2M/4J5+unp+YtwgYQqQRjEhQAhy6fpPoY35NPfEWjBn
   1yTyE84UhEkPD3n5D5nwCUu8Lk3vhUzQjf36EjLHKTGulM6zLYwLACoXG
   3V9mZi171dc2yafIlu5dI7VAHKZ7lOg87p6nUoNing/7X+54b4MdUAEHs
   IN3kmOXN+C1DTI1ID9QVN6zIjyNJYewaVW9zx9xYgvNs6e/vlpvJPP5i3
   w==;
X-CSE-ConnectionGUID: 7ofx3EPFSTq+zhk0bSkdHg==
X-CSE-MsgGUID: LHLqBJTsRJ++plw2udwJig==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3102487"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3102487"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 11:48:47 -0800
X-CSE-ConnectionGUID: ySvMwA34RxmBwDf3SkgqIw==
X-CSE-MsgGUID: O7pmt+bWQfK1hEoOHj13sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8343210"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Nov 2026 11:48:45 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xREJH-00000000zbf-0NPm;
	Wed, 11 Nov 2026 19:48:43 +0000
Date: Thu, 12 Nov 2026 03:47:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 51bafe2e7302403a43ba45415bf9a268a7fcaa05
Message-ID: <20261112034759.EYHAr7Un-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 51bafe2e7302403a43ba45415bf9a268a7fcaa05  Merge branch 'pm-cpufreq-tests' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202611111027.YYwIlIDB-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202611111639.D9pOcfbe-lkp@intel.com

    drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declaration of function 'devm_battery_hook_register'; did you mean 'acpi_battery_hook_register'? [-Wimplicit-function-declaration]
    drivers/platform/x86/acer-wmi-battery.c:292:9: error: call to undeclared function 'devm_battery_hook_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   `-- drivers-platform-x86-acer-wmi-battery.c:error:implicit-declaration-of-function-devm_battery_hook_register
|-- i386-allyesconfig
|   `-- drivers-platform-x86-acer-wmi-battery.c:error:implicit-declaration-of-function-devm_battery_hook_register
|-- x86_64-allmodconfig
|   `-- drivers-platform-x86-acer-wmi-battery.c:error:call-to-undeclared-function-devm_battery_hook_register-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-allyesconfig
|   `-- drivers-platform-x86-acer-wmi-battery.c:error:call-to-undeclared-function-devm_battery_hook_register-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- x86_64-randconfig-1000-20261111
|   `-- drivers-platform-x86-acer-wmi-battery.c:error:call-to-undeclared-function-devm_battery_hook_register-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- x86_64-randconfig-1011-20261111
    `-- drivers-platform-x86-acer-wmi-battery.c:error:implicit-declaration-of-function-devm_battery_hook_register

elapsed time: 1359m

configs tested: 193
configs skipped: 10

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                         nsimosci_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261111    gcc-15.3.0
arc                   randconfig-1001-20261111    gcc-15.3.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.2.0
arm                          bcm2835_defconfig    gcc-16.2.0
arm                      davinci_all_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             hisi_defconfig    gcc-16.2.0
arm                         mvebu_v7_defconfig    clang-24
arm                           pxa910_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261111    gcc-15.3.0
arm                   randconfig-1001-20261111    gcc-15.3.0
arm                   randconfig-1002-20261111    gcc-15.3.0
arm                   randconfig-1003-20261111    gcc-15.3.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261111    gcc-13.5.0
arm64                 randconfig-1001-20261111    gcc-13.5.0
arm64                 randconfig-1002-20261111    gcc-13.5.0
arm64                 randconfig-1003-20261111    gcc-13.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261111    gcc-13.5.0
csky                  randconfig-1001-20261111    gcc-13.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261111    clang-17
hexagon               randconfig-1001-20261111    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261111    clang-22
i386        buildonly-randconfig-1001-20261111    clang-22
i386        buildonly-randconfig-1002-20261111    clang-22
i386        buildonly-randconfig-1003-20261111    clang-22
i386        buildonly-randconfig-1004-20261111    clang-22
i386        buildonly-randconfig-1005-20261111    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261111    gcc-13
i386                  randconfig-1001-20261111    gcc-13
i386                  randconfig-1002-20261111    gcc-13
i386                  randconfig-1003-20261111    gcc-13
i386                  randconfig-1004-20261111    gcc-13
i386                  randconfig-1005-20261111    gcc-13
i386                  randconfig-1006-20261111    gcc-13
i386                  randconfig-1007-20261111    clang-22
i386                  randconfig-1008-20261111    clang-22
i386                  randconfig-1009-20261111    clang-22
i386                  randconfig-1010-20261111    clang-22
i386                  randconfig-1011-20261111    clang-22
i386                  randconfig-1012-20261111    clang-22
i386                  randconfig-1013-20261111    clang-22
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261111    clang-17
loongarch             randconfig-1001-20261111    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                          amcore_defconfig    gcc-16.2.0
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           eyeq6_defconfig    clang-24
mips                             gpr_defconfig    clang-24
mips                        lemote2f_defconfig    clang-24
mips                            mtx1_defconfig    clang-24
mips                         qi_lb60_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261111    clang-17
nios2                 randconfig-1001-20261111    clang-17
openrisc                          alldefconfig    gcc-16.2.0
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261111    gcc-15.3.0
parisc                randconfig-1001-20261111    gcc-15.3.0
parisc64                          alldefconfig    clang-24
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                        eiger_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261111    gcc-15.3.0
powerpc               randconfig-1001-20261111    gcc-15.3.0
powerpc                       tqm8xx_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261111    gcc-15.3.0
powerpc64             randconfig-1001-20261111    gcc-15.3.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261111    clang-17
riscv                 randconfig-1001-20261111    clang-17
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261111    clang-17
s390                  randconfig-1001-20261111    clang-17
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                  kfr2r09-romimage_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261111    clang-17
sh                    randconfig-1001-20261111    clang-17
sh                            se7780_defconfig    gcc-16.2.0
sh                         sh7763rdp_defconfig    gcc-16.2.0
sh                               ul2_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261111    gcc-16.2.0
sparc                 randconfig-1001-20261111    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261111    gcc-16.2.0
sparc64               randconfig-1001-20261111    gcc-16.2.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261111    gcc-16.2.0
um                    randconfig-1001-20261111    gcc-16.2.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261111    gcc-14
x86_64      buildonly-randconfig-1001-20261111    gcc-14
x86_64      buildonly-randconfig-1002-20261111    gcc-14
x86_64      buildonly-randconfig-1003-20261111    gcc-14
x86_64      buildonly-randconfig-1004-20261111    gcc-14
x86_64      buildonly-randconfig-1005-20261111    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261111    clang-22
x86_64                randconfig-1001-20261111    clang-22
x86_64                randconfig-1002-20261111    clang-22
x86_64                randconfig-1003-20261111    clang-22
x86_64                randconfig-1004-20261111    clang-22
x86_64                randconfig-1005-20261111    clang-22
x86_64                randconfig-1006-20261111    clang-22
x86_64                randconfig-1007-20261111    clang-22
x86_64                randconfig-1008-20261111    clang-22
x86_64                randconfig-1009-20261111    clang-22
x86_64                randconfig-1010-20261111    clang-22
x86_64                randconfig-1011-20261111    clang-22
x86_64                randconfig-1012-20261111    gcc-14
x86_64                randconfig-1013-20261111    gcc-14
x86_64                randconfig-1014-20261111    gcc-14
x86_64                randconfig-1015-20261111    gcc-14
x86_64                randconfig-1016-20261111    gcc-14
x86_64                randconfig-1017-20261111    gcc-14
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261111    gcc-16.2.0
xtensa                randconfig-1001-20261111    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
