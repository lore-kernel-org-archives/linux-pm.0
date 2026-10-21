Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545141;
	b=RqYWhTewdmd0qCTNCNJ44TMLYEELWgyLLkdwMmmHPskrR5liCalVU4+GV+S/obwtJ5yM
	 vFW0uT8Ny9Un3RaFhnZvZkH4TJhfouZd6zatLM2alrhY5mQZLsaeRr0NuyASryXgegmK5
	 BxyPmEs6tglCxRAOj22zvTtOpR1TswGAJMLcldLpL3TvrJ6hDiY6io1UPzT9yVaWeoXgL
	 tuhT0BXHUYzUACL1pgkemNigRr7uVANDhwOMWFNaR//SBPKl1xBXE46zmfr9KVYeSKSpF
	 pye2iMsb2a3hRLXquQkGiHraoQRF+3074dsq5Ljg3gbzzBFGBkbMQd+5/aBKIJpR+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545141;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=WEGNaxJcoitnt3C6W0gIalaRt1sxv5/ptmrm7PtgSW8=;
	b=q1XBT866xp4t7viqtYBn5yZelGSssSy8yCHq6l9A98O7XLjV8In8CqxEpIOHHmQfgQXJ
	 4wdiya/q2mZXt18/YsVPhIsH0Ffl6RWUYqr98MuNjHTsjn+RVy4oIv6mQN+b628VfL44F
	 /zaKD9uOK17WNSP+piq5bxmRcJ73ZrFVzCNaJtCo9odgucNLXj9Ro8RuVgcm0Q8G02LBb
	 dSq3IWCvSo9r9GE3qFyjVbXOPkz8HRqUrwZmvzcrQjqDTLlfZkGu6JbDEeR30MXWmNoZT
	 MYS8NiKcXRYWB38eZxdHGcV8PD4G39m4NHq7SE3oQ+vCkCSuExiZ411QkZ1Hh9oB54w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DStf41WP;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC7606A319;
	Wed, 21 Oct 2026 01:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CEC7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DStf41WP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792545139; x=1824081139;
  h=date:from:to:cc:subject:message-id;
  bh=KBkX6ZXbiqc28IqHQRknF9oyGe+bjVwUANOYsEYpgIE=;
  b=DStf41WP0/HhgXvFunWY/Z8RnakplahZk4kQ1e6UeYFBJ8S+hYm/XIWy
   0odmT4ZOGzc/0plyt0gou4Dg4nIA0Z5wcJygj5+4n3V9jABE7EvgG6P4m
   6Ydhew/YaIF3UjCGqOApEfEOOFK4kT+F2mXVX6fvqbKvqVmsFh5Mae2id
   DzrLqCNdLsOIx1lDN+ridN2bJQIY2UYYheEZEaJ4S3DduG0JE8lYmks5X
   4Ww1vy2S5TYQkQUbg12fgRw8Hyo93Xma0Hz26Sk//R56vgm3tkX/SwGPW
   NFGpfTrmaHhRadQUyHpaq2j2n/CNSwtm+TEFw9izP0eVli32QrEJl5YNs
   A==;
X-CSE-ConnectionGUID: +4JHPfKVTY6u5qtYUvG4fg==
X-CSE-MsgGUID: NnD7nV+BRaWoRezH2POb7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1262641"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1262641"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 18:12:19 -0700
X-CSE-ConnectionGUID: /6k4Wr7tS6WkzTTJLVvdZg==
X-CSE-MsgGUID: 1H4NaqUHScSTof20rh6mng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2903596"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Oct 2026 18:12:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xJKsI-00000000Olo-1d8D;
	Wed, 21 Oct 2026 01:12:14 +0000
Date: Wed, 21 Oct 2026 09:11:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a7b81d2593fc90a93e108441a04e3b258d19f074
Message-ID: <202610210917.ChrHHfpc-lkp@intel.com>
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
branch HEAD: a7b81d2593fc90a93e108441a04e3b258d19f074  Merge tag 'thermal-7.4-rc1' into bleeding-edge

elapsed time: 1327m

configs tested: 172
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261020    gcc-10.5.0
arc                   randconfig-1001-20261020    gcc-10.5.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                   randconfig-1000-20261020    gcc-10.5.0
arm                   randconfig-1001-20261020    gcc-10.5.0
arm                   randconfig-1002-20261020    gcc-10.5.0
arm                   randconfig-1003-20261020    gcc-10.5.0
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261020    gcc-8.5.0
arm64                 randconfig-1001-20261020    gcc-8.5.0
arm64                 randconfig-1002-20261020    gcc-8.5.0
arm64                 randconfig-1003-20261020    gcc-8.5.0
csky                              alldefconfig    gcc-16.2.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261020    gcc-8.5.0
csky                  randconfig-1001-20261020    gcc-8.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261020    clang-17
hexagon               randconfig-1001-20261020    clang-17
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261020    clang-22
i386        buildonly-randconfig-1001-20261020    clang-22
i386        buildonly-randconfig-1002-20261020    clang-22
i386        buildonly-randconfig-1003-20261020    clang-22
i386        buildonly-randconfig-1004-20261020    clang-22
i386        buildonly-randconfig-1005-20261020    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261020    gcc-14
i386                  randconfig-1001-20261020    gcc-14
i386                  randconfig-1002-20261020    gcc-14
i386                  randconfig-1003-20261020    gcc-14
i386                  randconfig-1004-20261020    gcc-14
i386                  randconfig-1005-20261020    gcc-14
i386                  randconfig-1006-20261020    gcc-14
i386                  randconfig-1007-20261020    gcc-14
i386                  randconfig-1008-20261020    gcc-14
i386                  randconfig-1009-20261020    gcc-14
i386                  randconfig-1010-20261020    gcc-14
i386                  randconfig-1011-20261020    gcc-14
i386                  randconfig-1012-20261020    gcc-14
i386                  randconfig-1013-20261020    gcc-14
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261020    clang-17
loongarch             randconfig-1001-20261020    clang-17
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                 malta_qemu_32r6_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261020    clang-17
nios2                 randconfig-1001-20261020    clang-17
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261020    clang-17
parisc                randconfig-1001-20261020    clang-17
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       arches_defconfig    gcc-16.2.0
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261020    clang-17
powerpc               randconfig-1001-20261020    clang-17
powerpc64             randconfig-1000-20261020    clang-17
powerpc64             randconfig-1001-20261020    clang-17
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261020    gcc-11.5.0
riscv                 randconfig-1001-20261020    gcc-11.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261020    gcc-11.5.0
s390                  randconfig-1001-20261020    gcc-11.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    gcc-16.2.0
sh                                   defconfig    gcc-14
sh                          ecovec24_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261020    gcc-11.5.0
sh                    randconfig-1001-20261020    gcc-11.5.0
sh                           sdk7780_defconfig    gcc-16.2.0
sh                    secureedge5410_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261020    clang-20
sparc                 randconfig-1001-20261020    clang-20
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261020    clang-20
sparc64               randconfig-1001-20261020    clang-20
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261020    clang-20
um                    randconfig-1001-20261020    clang-20
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261020    gcc-14
x86_64      buildonly-randconfig-1001-20261020    gcc-14
x86_64      buildonly-randconfig-1002-20261020    gcc-14
x86_64      buildonly-randconfig-1003-20261020    gcc-14
x86_64      buildonly-randconfig-1004-20261020    gcc-14
x86_64      buildonly-randconfig-1005-20261020    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261020    clang-22
x86_64                randconfig-1001-20261020    clang-22
x86_64                randconfig-1002-20261020    clang-22
x86_64                randconfig-1003-20261020    clang-22
x86_64                randconfig-1004-20261020    clang-22
x86_64                randconfig-1005-20261020    clang-22
x86_64                randconfig-1006-20261020    gcc-14
x86_64                randconfig-1007-20261020    gcc-14
x86_64                randconfig-1008-20261020    gcc-14
x86_64                randconfig-1009-20261020    gcc-14
x86_64                randconfig-1010-20261020    gcc-14
x86_64                randconfig-1011-20261020    gcc-14
x86_64                randconfig-1012-20261020    clang-22
x86_64                randconfig-1013-20261020    clang-22
x86_64                randconfig-1014-20261020    clang-22
x86_64                randconfig-1015-20261020    clang-22
x86_64                randconfig-1016-20261020    clang-22
x86_64                randconfig-1017-20261020    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261020    clang-20
xtensa                randconfig-1001-20261020    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
