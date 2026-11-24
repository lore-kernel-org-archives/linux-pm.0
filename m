Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536363;
	b=BbCCODs5NXvGsAMXOgM/DG+k9jiQkkKt+3tBSW//Hn9OCBDtKgDMQv3VhzgCT3UNgGPg
	 aSjNN9yBSPZuuiZ073fbvscad2b3twguqMwGnwpJd/2LfTIkSeHWtxhPrnaFp7VPpW+pO
	 1bQe+0citXi5mGrs+oL70w1XiHTmD2SdPeyLZRypw8WpsuO0FYvREJuFJRbFRToQ+ORsI
	 k3OBmIjZxwsL1JEg4RCeDnGOL2VlvbtQtwK87PgEmKX/OYlNjx0AwCze24jpi51sTHdfz
	 rvqa85t2dITDth8PIEb1befcbSOXaYdbyrYAmhfX1b2Pgv4qEXR+y32+DqH3VttDW3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536363;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=7jiZc2LZpfTNEjr22BAq8V+pQXT0yLwBh3JNdEf3p8o=;
	b=gKIMykg3B/I8Gnz2FolFef4TCQ6sLQLzTIHX8cjvW5BZcv8T0RaTQSLGkeTZdnuYUpOj
	 GzgBkHM7NUu4eWLlSj2yv5V7EUBSogwQ50nik51q+JeJe1ojwFiJOm4cHxHZlmoKjXYHg
	 K62jcfwkLeI9TGdErPheNx5Vh/DPB+eBArTDAUSG01xdbCsQfhFNee5KoJMA87MYKMOAo
	 UmeodALJXVd2F60VQXoVDxBu8Ftaii4GAnQ5SG9ckZ80ZqBoAtVrf31DPbPNQ1ZReYor1
	 sMQGyE2hoqFCQ+t/J8np3LFUIYe0zGMbn7Phr8+bGgl2qSys35RtWePPhAt0CHwdzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ddZ5BCNi;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A8606A323;
	Tue, 24 Nov 2026 16:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ddZ5BCNi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795536363; x=1827072363;
  h=date:from:to:cc:subject:message-id;
  bh=Snmx0+5xqpFdFBFUV604lJOUrea+mLU6z8fBS+PGdJM=;
  b=ddZ5BCNiHdXMt7bu97r+MnRKO5GGYWt5RCtRW575OGeWYSDqdILlLhPk
   +gS32oOIWQc93BB2Cqs5x3faO8mkMFPOMuZR8S72nUz7B4FxE59M4QiJ6
   SgP8oiz2POP316VNXDQ1MJsX9hLjHo8mX3C9H7Ifkv2iMVLzZPcaEK70r
   6EwS1tdgkSbI++iwPRB6niucmmUWKv71oK4eBdrHy31u65vhUrGyXJ7up
   xOw102HgT0JfjWZhCgr1Ddp+9NRg1Os0cEFwBgI3JELUWQP+QripIIIzq
   +oAc+M7v2HLSqAGiGbf1u4908MP3hNGQRHiaFfxnPzRcGWMqPOhSK4CAL
   Q==;
X-CSE-ConnectionGUID: EEQxSLSASoi7I4rNLpIUjQ==
X-CSE-MsgGUID: uiO0+Iq2S2KYvTTNdLHs7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4276316"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4276316"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 08:05:58 -0800
X-CSE-ConnectionGUID: 3jFbo2sfTtCUSAAPVpqhWg==
X-CSE-MsgGUID: 2mb4r+JPRw+le+VEYrLpbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11897749"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Nov 2026 08:05:56 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVt1l-00000001Pg8-3KCx;
	Tue, 24 Nov 2026 16:05:53 +0000
Date: Wed, 25 Nov 2026 00:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a44a3cdb4d561c1a83529fc2e4c636def9c66fc6
Message-ID: <20261125000523.zWe64gaS-lkp@intel.com>
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
branch HEAD: a44a3cdb4d561c1a83529fc2e4c636def9c66fc6  Merge branch 'thermal-tools' into linux-next

elapsed time: 1256m

configs tested: 366
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                 randconfig-2000-20261123    gcc-14.4.0
alpha                 randconfig-2000-20261124    gcc-11.5.0
alpha                 randconfig-2001-20261123    gcc-8.5.0
alpha                 randconfig-2001-20261124    gcc-11.5.0
alpha                 randconfig-2200-20261123    gcc-12.5.0 smatch
alpha                 randconfig-2200-20261124    gcc-8.5.0  smatch
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                               allyesconfig    gcc-16.2.0
arc                       axs103_smp_defconfig    gcc-16.2.0
arc                   randconfig-2000-20261123    gcc-14.4.0
arc                   randconfig-2000-20261124    gcc-11.5.0
arc                   randconfig-2001-20261123    gcc-12.5.0
arc                   randconfig-2001-20261124    gcc-11.5.0
arc                   randconfig-2002-20261123    gcc-8.5.0
arc                   randconfig-2002-20261124    gcc-11.5.0
arc                   randconfig-2003-20261123    gcc-12.5.0
arc                   randconfig-2003-20261124    gcc-11.5.0
arc                   randconfig-2004-20261123    gcc-14.4.0
arc                   randconfig-2004-20261124    gcc-11.5.0
arc                   randconfig-2005-20261123    gcc-12.5.0
arc                   randconfig-2005-20261124    gcc-11.5.0
arc                   randconfig-2200-20261123    gcc-12.5.0 smatch
arc                   randconfig-2200-20261124    gcc-8.5.0  smatch
arc                  randconfig-r2106-20261124    gcc-10.5.0 cocci
arc                  randconfig-r2301-20261124    clang-24   sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          at91_dt_defconfig    clang-24
arm                         mvebu_v5_defconfig    clang-24
arm                   randconfig-2000-20261123    gcc-16.2.0
arm                   randconfig-2000-20261124    clang-17
arm                   randconfig-2001-20261123    gcc-8.5.0
arm                   randconfig-2001-20261124    clang-17
arm                   randconfig-2002-20261123    clang-20
arm                   randconfig-2002-20261124    clang-17
arm                   randconfig-2200-20261123    gcc-8.5.0  smatch
arm                   randconfig-2200-20261124    clang-17   smatch
arm                  randconfig-r2100-20261123    gcc-10.5.0 cocci
arm                  randconfig-r2104-20261124    clang-24   cocci
arm                  randconfig-r2302-20261124    clang-24   sparse
arm                         spear3xx_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                 randconfig-2000-20261123    clang-24
arm64                 randconfig-2000-20261124    clang-17
arm64                 randconfig-2001-20261123    gcc-8.5.0
arm64                 randconfig-2001-20261124    clang-17
arm64                 randconfig-2002-20261123    clang-24
arm64                 randconfig-2002-20261124    clang-17
arm64                 randconfig-2200-20261123    clang-17   smatch
arm64                 randconfig-2200-20261124    gcc-16.2.0 smatch
arm64                randconfig-r2107-20261124    gcc-12.5.0 cocci
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                  randconfig-2000-20261124    gcc-16.2.0
csky                  randconfig-2001-20261124    gcc-16.2.0
csky                  randconfig-2200-20261123    gcc-16.2.0 smatch
csky                  randconfig-2200-20261124    gcc-15.3.0 smatch
csky                 randconfig-r2103-20261124    clang-24   cocci
csky                 randconfig-r2301-20261124    gcc-14.4.0 sparse
csky                 randconfig-r2302-20261124    gcc-14.4.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon               randconfig-1000-20261124    gcc-10.5.0
hexagon               randconfig-1001-20261124    gcc-10.5.0
hexagon               randconfig-2000-20261124    gcc-16.2.0
hexagon               randconfig-2001-20261124    gcc-16.2.0
hexagon              randconfig-r2101-20261124    clang-24   cocci
hexagon              randconfig-r2103-20261124    clang-24   cocci
hexagon              randconfig-r2300-20261124    gcc-14.4.0 sparse
hexagon              randconfig-r2303-20261124    clang-24   sparse
hexagon              randconfig-r2310-20261124    gcc-14     sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261124    gcc-12
i386        buildonly-randconfig-1001-20261124    gcc-12
i386        buildonly-randconfig-1002-20261124    gcc-12
i386        buildonly-randconfig-1003-20261124    gcc-12
i386        buildonly-randconfig-1004-20261124    gcc-12
i386        buildonly-randconfig-1005-20261124    gcc-12
i386                  randconfig-2000-20261124    gcc-14
i386                  randconfig-2001-20261124    gcc-14
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2003-20261124    gcc-14
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2100-20261124    gcc-14     cocci
i386                  randconfig-2101-20261124    gcc-14     cocci
i386                  randconfig-2102-20261124    gcc-14     cocci
i386                  randconfig-2103-20261124    gcc-14     cocci
i386                  randconfig-2104-20261124    gcc-14     cocci
i386                  randconfig-2105-20261124    gcc-14     cocci
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2300-20261123    gcc-13     sparse
i386                  randconfig-2300-20261124    gcc-14     sparse
i386                  randconfig-2301-20261123    clang-22   sparse
i386                  randconfig-2301-20261124    gcc-14     sparse
i386                  randconfig-2302-20261123    clang-22   sparse
i386                  randconfig-2302-20261124    gcc-14     sparse
i386                 randconfig-r2107-20261123    clang-22   cocci
i386                 randconfig-r2108-20261124    gcc-12.5.0 cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261124    gcc-10.5.0
loongarch             randconfig-1001-20261124    gcc-10.5.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2001-20261124    clang-18
loongarch             randconfig-2200-20261124    gcc-16.2.0 smatch
loongarch            randconfig-r2102-20261124    clang-24   cocci
loongarch            randconfig-r2305-20261124    gcc-14.4.0 sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-24
m68k                        m5235evb_defconfig    clang-24
m68k                  randconfig-2000-20261123    gcc-15.3.0
m68k                  randconfig-2000-20261124    gcc-11.5.0
m68k                  randconfig-2001-20261123    gcc-9.5.0
m68k                  randconfig-2001-20261124    gcc-11.5.0
m68k                  randconfig-2200-20261124    gcc-10.5.0 smatch
m68k                 randconfig-r2105-20261124    gcc-16.2.0 cocci
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261123    gcc-8.5.0
microblaze            randconfig-2000-20261124    gcc-11.5.0
microblaze            randconfig-2001-20261124    gcc-11.5.0
microblaze            randconfig-2200-20261123    gcc-16.2.0 smatch
microblaze            randconfig-2200-20261124    gcc-8.5.0  smatch
microblaze           randconfig-r2100-20261124    clang-24   cocci
microblaze           randconfig-r2104-20261124    clang-24   cocci
microblaze           randconfig-r2300-20261124    clang-24   sparse
microblaze           randconfig-r2307-20261124    gcc-12.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          cobalt_defconfig    clang-24
mips                  randconfig-2000-20261124    gcc-16.2.0
mips                  randconfig-2001-20261124    gcc-16.2.0
mips                  randconfig-2002-20261124    gcc-16.2.0
mips                  randconfig-2200-20261124    clang-20   smatch
mips                            rs90_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261124    gcc-10.5.0
nios2                 randconfig-1001-20261124    gcc-10.5.0
nios2                 randconfig-2000-20261124    clang-18
nios2                 randconfig-2001-20261124    clang-18
nios2                 randconfig-2200-20261123    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261124    gcc-11.5.0 smatch
nios2                randconfig-r2111-20261124    gcc-12.5.0 cocci
nios2                randconfig-r2308-20261124    gcc-12.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2000-20261124    gcc-16.2.0
openrisc              randconfig-2001-20261124    gcc-16.2.0
openrisc              randconfig-2002-20261124    gcc-16.2.0
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc             randconfig-r2101-20261124    clang-24   cocci
openrisc             randconfig-r2103-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2104-20261123    gcc-9.5.0  cocci
openrisc             randconfig-r2109-20261124    gcc-12.5.0 cocci
openrisc             randconfig-r2110-20261123    gcc-10.5.0 cocci
openrisc             randconfig-r2304-20261124    gcc-14.4.0 sparse
openrisc             randconfig-r2311-20261124    gcc-14     sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-1000-20261124    clang-24
parisc                randconfig-1001-20261124    clang-24
parisc                randconfig-2000-20261124    clang-18
parisc                randconfig-2001-20261124    clang-18
parisc                randconfig-2200-20261123    gcc-14.4.0 smatch
parisc                randconfig-2200-20261124    gcc-9.5.0  smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       cm5200_defconfig    clang-24
powerpc                        ppc64_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261124    clang-24
powerpc               randconfig-1001-20261124    clang-24
powerpc               randconfig-2000-20261124    clang-24
powerpc               randconfig-2001-20261124    clang-24
powerpc               randconfig-2002-20261124    clang-24
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc              randconfig-r2103-20261123    gcc-8.5.0  cocci
powerpc              randconfig-r2109-20261123    gcc-11.5.0 cocci
powerpc              randconfig-r2306-20261124    gcc-12.5.0 sparse
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                      tqm8560_defconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261124    clang-24
powerpc64             randconfig-1001-20261124    clang-24
powerpc64             randconfig-2000-20261124    clang-24
powerpc64             randconfig-2001-20261124    clang-24
powerpc64             randconfig-2002-20261124    clang-24
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
powerpc64            randconfig-r2109-20261124    gcc-10.5.0 cocci
powerpc64            randconfig-r2111-20261124    gcc-10.5.0 cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261124    gcc-11.5.0
riscv                 randconfig-1001-20261124    gcc-11.5.0
riscv                 randconfig-2000-20261123    gcc-11.5.0
riscv                 randconfig-2000-20261124    gcc-16.2.0
riscv                 randconfig-2001-20261123    gcc-13.5.0
riscv                 randconfig-2001-20261124    gcc-16.2.0
riscv                 randconfig-2002-20261123    gcc-8.5.0
riscv                 randconfig-2002-20261124    gcc-16.2.0
riscv                 randconfig-2003-20261123    gcc-8.5.0
riscv                 randconfig-2003-20261124    gcc-16.2.0
riscv                 randconfig-2004-20261123    clang-24
riscv                 randconfig-2004-20261124    gcc-16.2.0
riscv                 randconfig-2005-20261123    gcc-13.5.0
riscv                 randconfig-2005-20261124    gcc-16.2.0
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
riscv                randconfig-r2101-20261123    gcc-15.3.0 cocci
riscv                randconfig-r2102-20261124    gcc-16.2.0 cocci
riscv                randconfig-r2105-20261123    clang-24   cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261124    gcc-11.5.0
s390                  randconfig-1001-20261124    gcc-11.5.0
s390                  randconfig-2000-20261124    clang-24
s390                  randconfig-2001-20261124    clang-24
s390                  randconfig-2002-20261124    clang-24
s390                  randconfig-2003-20261124    clang-24
s390                  randconfig-2004-20261124    clang-24
s390                  randconfig-2005-20261124    clang-24
s390                  randconfig-2200-20261123    clang-24   smatch
s390                  randconfig-2200-20261124    clang-24   smatch
s390                 randconfig-r2106-20261124    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261124    gcc-10.5.0 cocci
s390                 randconfig-r2304-20261124    clang-24   sparse
s390                 randconfig-r2307-20261124    gcc-14     sparse
s390                 randconfig-r2309-20261124    gcc-14     sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                             migor_defconfig    clang-24
sh                    randconfig-1000-20261124    gcc-11.5.0
sh                    randconfig-1001-20261124    gcc-11.5.0
sh                    randconfig-2000-20261123    gcc-16.2.0
sh                    randconfig-2000-20261124    gcc-11.5.0
sh                    randconfig-2001-20261123    gcc-16.2.0
sh                    randconfig-2001-20261124    gcc-11.5.0
sh                    randconfig-2002-20261123    gcc-10.5.0
sh                    randconfig-2002-20261124    gcc-11.5.0
sh                    randconfig-2003-20261123    gcc-16.2.0
sh                    randconfig-2003-20261124    gcc-11.5.0
sh                    randconfig-2004-20261123    gcc-14.4.0
sh                    randconfig-2004-20261124    gcc-11.5.0
sh                    randconfig-2005-20261123    gcc-16.2.0
sh                    randconfig-2005-20261124    gcc-11.5.0
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                   randconfig-r2105-20261124    clang-24   cocci
sh                   randconfig-r2110-20261124    gcc-12.5.0 cocci
sh                   randconfig-r2303-20261124    gcc-14.4.0 sparse
sh                   randconfig-r2309-20261124    gcc-12.5.0 sparse
sh                           sdk7786_defconfig    clang-24
sh                            se7619_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                 randconfig-2000-20261124    gcc-8.5.0
sparc                 randconfig-2001-20261124    gcc-8.5.0
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc                randconfig-r2100-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2110-20261124    gcc-10.5.0 cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-2000-20261124    gcc-8.5.0
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64              randconfig-r2102-20261123    clang-24   cocci
sparc64              randconfig-r2104-20261124    gcc-16.2.0 cocci
sparc64              randconfig-r2105-20261124    clang-24   cocci
sparc64              randconfig-r2108-20261123    clang-24   cocci
sparc64              randconfig-r2310-20261124    gcc-12.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-2000-20261124    gcc-8.5.0
um                    randconfig-2001-20261124    gcc-8.5.0
um                    randconfig-2200-20261124    gcc-14     smatch
um                   randconfig-r2100-20261124    clang-24   cocci
um                   randconfig-r2101-20261124    gcc-16.2.0 cocci
um                   randconfig-r2106-20261123    clang-17   cocci
um                   randconfig-r2108-20261124    gcc-10.5.0 cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261124    gcc-14
x86_64      buildonly-randconfig-1001-20261124    gcc-14
x86_64      buildonly-randconfig-1002-20261124    gcc-14
x86_64      buildonly-randconfig-1003-20261124    gcc-14
x86_64      buildonly-randconfig-1004-20261124    gcc-14
x86_64      buildonly-randconfig-1005-20261124    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261124    gcc-12
x86_64                randconfig-1001-20261124    gcc-12
x86_64                randconfig-1002-20261124    gcc-12
x86_64                randconfig-1003-20261124    gcc-12
x86_64                randconfig-1004-20261124    gcc-12
x86_64                randconfig-1005-20261124    gcc-12
x86_64                randconfig-2000-20261123    gcc-14
x86_64                randconfig-2000-20261124    gcc-14
x86_64                randconfig-2001-20261123    gcc-14
x86_64                randconfig-2001-20261124    gcc-14
x86_64                randconfig-2002-20261123    gcc-14
x86_64                randconfig-2002-20261124    gcc-14
x86_64                randconfig-2003-20261123    gcc-14
x86_64                randconfig-2003-20261124    gcc-14
x86_64                randconfig-2004-20261123    gcc-14
x86_64                randconfig-2004-20261124    gcc-14
x86_64                randconfig-2005-20261123    gcc-14
x86_64                randconfig-2005-20261124    gcc-14
x86_64                randconfig-2100-20261124    gcc-14     cocci
x86_64                randconfig-2101-20261124    gcc-14     cocci
x86_64                randconfig-2102-20261124    gcc-14     cocci
x86_64                randconfig-2103-20261124    gcc-14     cocci
x86_64                randconfig-2104-20261124    gcc-14     cocci
x86_64                randconfig-2105-20261124    gcc-14     cocci
x86_64                randconfig-2200-20261123    gcc-14     smatch
x86_64                randconfig-2200-20261124    gcc-14     smatch
x86_64                randconfig-2300-20261123    clang-22   sparse
x86_64                randconfig-2300-20261124    gcc-14     sparse
x86_64                randconfig-2301-20261123    gcc-14     sparse
x86_64                randconfig-2301-20261124    gcc-14     sparse
x86_64                randconfig-2302-20261123    gcc-14     sparse
x86_64                randconfig-2302-20261124    gcc-14     sparse
x86_64               randconfig-r2102-20261124    clang-24   cocci
x86_64               randconfig-r2111-20261123    clang-22   cocci
x86_64               randconfig-r2306-20261124    gcc-14     sparse
x86_64               randconfig-r2308-20261124    gcc-14     sparse
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
xtensa                randconfig-2000-20261124    gcc-16.2.0
xtensa                randconfig-2001-20261124    gcc-16.2.0
xtensa                randconfig-2200-20261124    gcc-9.5.0  smatch
xtensa               randconfig-r2305-20261124    clang-24   sparse
xtensa               randconfig-r2311-20261124    gcc-12.5.0 sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
