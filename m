Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222419;
	b=mYz7f9svikwJynVDTKNF334Q9v2ZPD7nacz2k1rwU4fY2FOwXLW2uumPlweCwyHx8oLP
	 nMMSkLWcXi0GnOSXpZqkNViMuWZD8WlJ0/xEuHDAuYqH2vdtidibYLfZnmw4mCZoh0ZeF
	 tWEuCaidfoDskkAOpRm31Ilcm0wSQB3Yx1aVkimaPNHhOHlSB/61yYtzVDcbgqtzcTt6j
	 FNkSPCYYOTG7gTX5WDcHzOHV7ouPfwrdGJLr1/igOqXcy81U31K8mxFvW7xuy7zPYeNKV
	 iCDBH4OXODjywGOzK9ues+G7rgIqU0O9EFmhW5vQRCuN5jQNRdPCFNrZI4Yo1JuQKmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=xMJTo5sUCM0JMEO5B+e0CA2UyU8L9Y80UMligeaaVdc=;
	b=Tk2klj7NOCepggNu2MOcbnZdHp1gZCS2Yy41PF1CeH9YoPizsy33TnxRvNrPRu0EbMyP
	 tH2rgIJ3Y7IUqD0a+zWIKPiAQdoon5+dKfAyMxkmlD6fKXskLZb4BEN33bywgJIvviufS
	 BLyhniCO7hfzBOYrDoe7/qyhV0ZH/Kim739emniiCQ9XJIfHxS6uGzZnAhDCmEd6t3mln
	 DI6I81kZ4ANa5xL5x/v1+F7V7w5vSuDOIZ1EhoEdcVDdeFx33JXOf+cgUariP2T8CrV9w
	 YHdz+KLn3UzO1Myi9BH14Anjy+9y8vpKn0YOMg+C1R7iNjhpx0tZklFK4/Bh4G8fWzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h0esq2F8;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24B606A321;
	Mon,  9 Nov 2026 11:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B24B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h0esq2F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794222419; x=1825758419;
  h=date:from:to:cc:subject:message-id;
  bh=jiApkSJWHOlfX9SjJgAK1ahPw3mTTkG4KQptHR2i2Ak=;
  b=h0esq2F8MX/mzf+dexzo6N+WvuIo49EE8IYlcru/HN+S3J26FX2/fqFR
   FmoGhAeKnERDe3241vgxYQVMY+MEEIA+kLsS0yvIuijqwo0mwvJDvENE5
   XxXk1MPQxc4Se1Z+u5XAE503dMibmOdvq/GlrSqyFc4KFoVvWZ2K073lw
   UOutzNKN1SlY4xncGBNVpi/N48pD/YcXMtZTnfe7OqKH84B98m47fFhyW
   YpppMstNF70/XcVFqYb9WgcX8gSdI2lYayA+IzlxNkLGymdGnyTEkvm0a
   yKxmxxnaNOGy2M2g5gJDZlq0z235PWU1LY9QovpJ95p66UYfRWLtbDeLb
   Q==;
X-CSE-ConnectionGUID: Ya50JTgLQ9q2s7NYK1pP9g==
X-CSE-MsgGUID: eic3M44NS4qx/Ww81+ZDGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2936562"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2936562"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 03:06:58 -0800
X-CSE-ConnectionGUID: wloE75v3R6WMDrnP2z1ERw==
X-CSE-MsgGUID: zqIQDS8nRqG0vdWJtheLCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8169325"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Nov 2026 03:06:56 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQNDB-00000000uNp-48cS;
	Mon, 09 Nov 2026 11:06:53 +0000
Date: Mon, 09 Nov 2026 19:06:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ee3b82351a306b559fd132b9b168185fee641a18
Message-ID: <20261109190604.ycJFph9U-lkp@intel.com>
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
branch HEAD: ee3b82351a306b559fd132b9b168185fee641a18  Merge branches 'pm-cpufreq', 'pm-runtime' and 'pm-powercap' into linux-next

elapsed time: 891m

configs tested: 222
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                      haps_hs_smp_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261109    clang-24
arc                   randconfig-1001-20261109    clang-24
arm                               alldefconfig    gcc-16.2.0
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                        aspeed_g5_defconfig    clang-24
arm                          bcm2835_defconfig    clang-17
arm                          bcm2835_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                        imx_v4_v5_defconfig    gcc-16.2.0
arm                             mps2_defconfig    clang-24
arm                         multi_v7_defconfig    gcc-16.2.0
arm                          orion5x_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261109    clang-24
arm                   randconfig-1001-20261109    clang-24
arm                   randconfig-1002-20261109    clang-24
arm                   randconfig-1003-20261109    clang-24
arm                         shmobile_defconfig    clang-17
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261109    gcc-13.5.0
arm64                 randconfig-1001-20261109    gcc-13.5.0
arm64                 randconfig-1002-20261109    gcc-13.5.0
arm64                 randconfig-1003-20261109    gcc-13.5.0
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261109    gcc-13.5.0
csky                  randconfig-1001-20261109    gcc-13.5.0
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261109    clang-19
hexagon               randconfig-1001-20261109    clang-19
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261109    clang-22
i386        buildonly-randconfig-1001-20261109    clang-22
i386        buildonly-randconfig-1002-20261109    clang-22
i386        buildonly-randconfig-1003-20261109    clang-22
i386        buildonly-randconfig-1004-20261109    clang-22
i386        buildonly-randconfig-1005-20261109    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261109    gcc-14
i386                  randconfig-1001-20261109    gcc-14
i386                  randconfig-1002-20261109    gcc-14
i386                  randconfig-1003-20261109    gcc-14
i386                  randconfig-1004-20261109    gcc-14
i386                  randconfig-1005-20261109    gcc-14
i386                  randconfig-1006-20261109    gcc-14
i386                  randconfig-1007-20261109    gcc-12
i386                  randconfig-1008-20261109    gcc-12
i386                  randconfig-1009-20261109    gcc-12
i386                  randconfig-1010-20261109    gcc-12
i386                  randconfig-1011-20261109    gcc-12
i386                  randconfig-1012-20261109    gcc-12
i386                  randconfig-1013-20261109    gcc-12
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261109    clang-19
loongarch             randconfig-1001-20261109    clang-19
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5329evb_defconfig    gcc-16.2.0
m68k                        m5475evb_defconfig    gcc-16.2.0
m68k                         mvme16x_defconfig    clang-17
m68k                          nettel_defconfig    clang-24
m68k                          nettel_defconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                           ath79_defconfig    clang-24
mips                       bmips_stb_defconfig    gcc-16.2.0
mips                      cu1000-neo_defconfig    gcc-16.2.0
mips                          db1xxx_defconfig    gcc-16.2.0
mips                           eyeq5_defconfig    clang-17
mips                       fuloong2e_defconfig    gcc-16.2.0
mips                            gcw0_defconfig    gcc-16.2.0
mips                             gpr_defconfig    gcc-16.2.0
mips                            ip27_defconfig    gcc-16.2.0
mips                       loongson3_defconfig    gcc-16.2.0
mips                           rb532_defconfig    clang-17
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261109    clang-19
nios2                 randconfig-1001-20261109    clang-19
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc                   or1klitex_defconfig    gcc-16.2.0
openrisc                        virt_defconfig    gcc-16.2.0
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261109    gcc-8.5.0
parisc                randconfig-1001-20261109    gcc-8.5.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                        ebony_defconfig    clang-24
powerpc                           g5_defconfig    gcc-16.2.0
powerpc                  mpc837x_rdb_defconfig    clang-24
powerpc                   mpc866_ads_defconfig    clang-17
powerpc                       pmac32_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261109    gcc-8.5.0
powerpc               randconfig-1001-20261109    gcc-8.5.0
powerpc                      redwood_defconfig    gcc-16.2.0
powerpc                      taishan_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261109    gcc-8.5.0
powerpc64             randconfig-1001-20261109    gcc-8.5.0
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261109    gcc-8.5.0
riscv                 randconfig-1001-20261109    gcc-8.5.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261109    gcc-8.5.0
s390                  randconfig-1001-20261109    gcc-8.5.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                         dreamcast_defconfig    gcc-16.2.0
sh                 ecovec24-romimage_defconfig    gcc-16.2.0
sh                           lboxre2_defconfig    gcc-16.2.0
sh                             migor_defconfig    gcc-16.2.0
sh                    randconfig-1000-20261109    gcc-8.5.0
sh                    randconfig-1001-20261109    gcc-8.5.0
sh                       rts7751r2d1_defconfig    gcc-16.2.0
sh                           sdk7780_defconfig    clang-24
sh                           sdk7786_defconfig    gcc-16.2.0
sh                            se7751_defconfig    gcc-16.2.0
sh                              sh03_defconfig    gcc-16.2.0
sh                    sh7770_generic_defconfig    gcc-16.2.0
sh                              shx3_defconfig    clang-17
sh                               ul2_defconfig    clang-17
sparc                             alldefconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261109    gcc-8.5.0
sparc                 randconfig-1001-20261109    gcc-8.5.0
sparc                        sparc32_defconfig    gcc-16.2.0
sparc                        sparc64_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261109    gcc-8.5.0
sparc64               randconfig-1001-20261109    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261109    gcc-8.5.0
um                    randconfig-1001-20261109    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261109    clang-22
x86_64      buildonly-randconfig-1001-20261109    clang-22
x86_64      buildonly-randconfig-1002-20261109    clang-22
x86_64      buildonly-randconfig-1003-20261109    clang-22
x86_64      buildonly-randconfig-1004-20261109    clang-22
x86_64      buildonly-randconfig-1005-20261109    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261109    clang-22
x86_64                randconfig-1001-20261109    clang-22
x86_64                randconfig-1002-20261109    clang-22
x86_64                randconfig-1003-20261109    clang-22
x86_64                randconfig-1004-20261109    clang-22
x86_64                randconfig-1005-20261109    clang-22
x86_64                randconfig-1006-20261109    gcc-14
x86_64                randconfig-1007-20261109    gcc-14
x86_64                randconfig-1008-20261109    gcc-14
x86_64                randconfig-1009-20261109    gcc-14
x86_64                randconfig-1010-20261109    gcc-14
x86_64                randconfig-1011-20261109    gcc-14
x86_64                randconfig-1012-20261109    clang-22
x86_64                randconfig-1013-20261109    clang-22
x86_64                randconfig-1014-20261109    clang-22
x86_64                randconfig-1015-20261109    clang-22
x86_64                randconfig-1016-20261109    clang-22
x86_64                randconfig-1017-20261109    clang-22
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.2.0
xtensa                 generic_kc705_defconfig    gcc-16.2.0
xtensa                randconfig-1000-20261109    gcc-8.5.0
xtensa                randconfig-1001-20261109    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
