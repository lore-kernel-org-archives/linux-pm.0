Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915617;
	b=3I83gMMGULh8axu3tBWdY6A6B06aq+mRNzsLE3CKI5+Le+6QxvpZUrrA54DS/vm30P2M
	 wBrrP9BeY9pRrEJ1othASgRi8pEO0pJhWVGiLJ6i+JEcJsEIIhfJnrSKyKRTAqhIGrCaJ
	 VJmAda38OxT430XypB3M92pAYZL7HPTvDBuQJmF6+w8YnOmUxx0lNTUkeRP2jD42yguUh
	 so9PPHhnvSa3n+SOOV3k/Ma4lcCXQBJBAAhFsr3DXPQdSWCxCCCGOMophK8Cut1o0bop/
	 Qoj4hcv30Da5TY/gt5DYV2L28/RCBXkZLjKYEVsN5yllBJgU7E6gh9nQa8kAfJSmRtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915617;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=U0jyWfBZwAC9o7h7FuzbBtbUE+nvAM3v35KauM8ue94=;
	b=IbYUQfH86R2DC4E5zwlongY9PNk2Kbkaa8qmim36rOsxvPhKEerZn0JqPhCd22XNBRbp
	 AncQVKhiBmBtTal4CidfX+uCvzAprm9xy71ZAxfxZ1GJYsONeXLqBNDgiNnIL3G1YVXIc
	 sIh0ePZDZZ1Krl0GBhpe/73FJZH1mxiR0YyWQRf63EMMBVeI5WfhIiq723pi4jRhHeLer
	 m+px33ASUmne6fYCXdWEIIzdElU/gooDK+2W8CzHsMPopESRL8WwUSMKSAB3Dap/aGDCk
	 argJb9gfaMSP4Qq7FnmytUmfDO5hFA+3PEq0uP3xhjxM6jG1mgFOAFfP2u2ENDdTnzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FtGUqyzU;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4C606A31C;
	Tue, 17 Nov 2026 11:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FtGUqyzU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794915617; x=1826451617;
  h=date:from:to:cc:subject:message-id;
  bh=O5zQUVu1FEFFWtG96NWJ0mBQIHLBDcTx7keFs3EFkGA=;
  b=FtGUqyzU1EpQRXqqoBkM4nAm7ok6GYbmP1GEn6Woee6DTpxwApqOtaQH
   ts5r9wf4Xsv3mj+LbcxAtvEFVksOm+b9Bjet7VEQUSHr424J8iRy5oq2U
   pmKcO37KWlX4x05ejMAnrszG2+aNwLjsk6DkHNNWKjXCkab0fyZ3zvPgS
   zDgO+MxL4Bpk7mBWwdN7p3THHARQHFlh09hDFyDCrM83OP9HfbU/i2cNA
   krUBkKmR3/QYxmlodhGfNnPcF7pqs7QSVq3bIyvAW5Y3DyZ3x3ZRl584l
   UVwRsT9iIP38cdAhakKqmoxzhC0r3ScXiDpcYDl4jV5dS+QLei0nwBlpl
   Q==;
X-CSE-ConnectionGUID: qAnVsjBKSkimgByNC/VNMg==
X-CSE-MsgGUID: iwIRL1iGSy6ctUY3JqfAHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3764857"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3764857"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 03:40:17 -0800
X-CSE-ConnectionGUID: STkvhN7lRzGTwh2ns9S68A==
X-CSE-MsgGUID: sQPy8H+HT0yZBjhdBSD4JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9778012"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 17 Nov 2026 03:40:15 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTHXo-00000001BLE-1gLQ;
	Tue, 17 Nov 2026 11:40:12 +0000
Date: Tue, 17 Nov 2026 19:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0069320cef67ba6ca745a05868c40e4c46b61284
Message-ID: <20261117194004.QBYhyzCy-lkp@intel.com>
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
branch HEAD: 0069320cef67ba6ca745a05868c40e4c46b61284  Merge branch 'pm-runtime' into linux-next

elapsed time: 1248m

configs tested: 469
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261116    gcc-10.5.0
alpha                 randconfig-2000-20261116    gcc-8.5.0
alpha                 randconfig-2000-20261117    gcc-15.3.0
alpha                 randconfig-2001-20261116    gcc-10.5.0
alpha                 randconfig-2001-20261116    gcc-15.3.0
alpha                 randconfig-2001-20261117    gcc-15.3.0
alpha                 randconfig-2200-20261116    gcc-15.3.0 smatch
alpha                 randconfig-2200-20261117    gcc-8.5.0  smatch
alpha                randconfig-r2100-20261116    gcc-13.5.0 cocci
alpha                randconfig-r2103-20261116    gcc-15.3.0 cocci
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                          haps_hs_defconfig    gcc-16.2.0
arc                   randconfig-1000-20261117    gcc-13.5.0
arc                   randconfig-1001-20261117    gcc-13.5.0
arc                   randconfig-2000-20261116    gcc-13.5.0
arc                   randconfig-2001-20261116    gcc-11.5.0
arc                   randconfig-2001-20261116    gcc-13.5.0
arc                   randconfig-2002-20261116    gcc-13.5.0
arc                   randconfig-2003-20261116    gcc-11.5.0
arc                   randconfig-2003-20261116    gcc-13.5.0
arc                   randconfig-2004-20261116    gcc-13.5.0
arc                   randconfig-2004-20261116    gcc-9.5.0
arc                   randconfig-2005-20261116    gcc-11.5.0
arc                   randconfig-2005-20261116    gcc-13.5.0
arc                   randconfig-2200-20261116    gcc-15.3.0 smatch
arc                   randconfig-2200-20261117    gcc-8.5.0  smatch
arc                  randconfig-r2310-20261116    clang-20   sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          axm55xx_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                       footbridge_defconfig    gcc-16.2.0
arm                         neponset_defconfig    gcc-16.2.0
arm                          orion5x_defconfig    gcc-16.2.0
arm                   randconfig-1000-20261117    gcc-13.5.0
arm                   randconfig-1001-20261117    gcc-13.5.0
arm                   randconfig-1002-20261117    gcc-13.5.0
arm                   randconfig-1003-20261117    gcc-13.5.0
arm                   randconfig-2000-20261116    gcc-15.3.0
arm                   randconfig-2000-20261117    gcc-10.5.0
arm                   randconfig-2001-20261116    clang-24
arm                   randconfig-2001-20261116    gcc-15.3.0
arm                   randconfig-2001-20261117    gcc-10.5.0
arm                   randconfig-2002-20261116    gcc-15.3.0
arm                   randconfig-2002-20261116    gcc-8.5.0
arm                   randconfig-2002-20261117    gcc-10.5.0
arm                   randconfig-2200-20261116    gcc-13.5.0 smatch
arm                  randconfig-r2105-20261117    gcc-16.2.0 cocci
arm                  randconfig-r2110-20261116    clang-24   cocci
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261117    gcc-16.2.0
arm64                 randconfig-1001-20261117    gcc-16.2.0
arm64                 randconfig-1002-20261117    gcc-16.2.0
arm64                 randconfig-1003-20261117    gcc-16.2.0
arm64                 randconfig-2000-20261116    gcc-15.3.0
arm64                 randconfig-2000-20261116    gcc-8.5.0
arm64                 randconfig-2000-20261117    gcc-10.5.0
arm64                 randconfig-2001-20261116    clang-18
arm64                 randconfig-2001-20261116    gcc-15.3.0
arm64                 randconfig-2001-20261117    gcc-10.5.0
arm64                 randconfig-2002-20261116    gcc-14.4.0
arm64                 randconfig-2002-20261116    gcc-15.3.0
arm64                 randconfig-2002-20261117    gcc-10.5.0
arm64                 randconfig-2200-20261116    gcc-8.5.0  smatch
arm64                 randconfig-2200-20261117    clang-17   smatch
arm64                randconfig-r2301-20261116    clang-24   sparse
csky                              alldefconfig    clang-24
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261117    gcc-16.2.0
csky                  randconfig-1001-20261117    gcc-16.2.0
csky                  randconfig-2000-20261116    gcc-16.2.0
csky                  randconfig-2001-20261116    gcc-16.2.0
csky                  randconfig-2200-20261116    gcc-16.2.0 smatch
csky                  randconfig-2200-20261117    gcc-14.4.0 smatch
csky                 randconfig-r2303-20261116    clang-24   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261117    clang-17
hexagon               randconfig-1001-20261117    clang-17
hexagon               randconfig-2000-20261116    gcc-16.2.0
hexagon               randconfig-2001-20261116    gcc-16.2.0
hexagon               randconfig-2200-20261116    clang-17   smatch
hexagon               randconfig-2200-20261117    clang-17   smatch
hexagon              randconfig-r2111-20261116    clang-24   cocci
hexagon              randconfig-r2303-20261116    gcc-11.5.0 sparse
hexagon              randconfig-r2304-20261116    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261117    clang-22
i386        buildonly-randconfig-1001-20261117    clang-22
i386        buildonly-randconfig-1002-20261117    clang-22
i386        buildonly-randconfig-1003-20261117    clang-22
i386        buildonly-randconfig-1004-20261117    clang-22
i386        buildonly-randconfig-1005-20261117    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261117    gcc-14
i386                  randconfig-1001-20261117    gcc-14
i386                  randconfig-1002-20261117    gcc-14
i386                  randconfig-1003-20261117    gcc-14
i386                  randconfig-1004-20261117    gcc-14
i386                  randconfig-1005-20261117    gcc-14
i386                  randconfig-1006-20261117    gcc-14
i386                  randconfig-1007-20261117    clang-22
i386                  randconfig-1008-20261117    clang-22
i386                  randconfig-1009-20261117    clang-22
i386                  randconfig-1010-20261117    clang-22
i386                  randconfig-1011-20261117    clang-22
i386                  randconfig-1012-20261117    clang-22
i386                  randconfig-1013-20261117    clang-22
i386                  randconfig-2000-20261116    gcc-14
i386                  randconfig-2000-20261117    clang-22
i386                  randconfig-2001-20261116    gcc-14
i386                  randconfig-2001-20261117    clang-22
i386                  randconfig-2002-20261116    gcc-14
i386                  randconfig-2002-20261117    clang-22
i386                  randconfig-2003-20261116    gcc-14
i386                  randconfig-2003-20261117    clang-22
i386                  randconfig-2004-20261116    gcc-14
i386                  randconfig-2004-20261117    clang-22
i386                  randconfig-2005-20261116    gcc-14
i386                  randconfig-2005-20261117    clang-22
i386                  randconfig-2100-20261116    gcc-14     cocci
i386                  randconfig-2100-20261117    clang-22   cocci
i386                  randconfig-2101-20261116    gcc-14     cocci
i386                  randconfig-2101-20261117    clang-22   cocci
i386                  randconfig-2102-20261116    gcc-14     cocci
i386                  randconfig-2102-20261117    clang-22   cocci
i386                  randconfig-2103-20261116    gcc-14     cocci
i386                  randconfig-2103-20261117    clang-22   cocci
i386                  randconfig-2104-20261116    gcc-14     cocci
i386                  randconfig-2104-20261117    clang-22   cocci
i386                  randconfig-2105-20261116    gcc-14     cocci
i386                  randconfig-2105-20261117    clang-22   cocci
i386                  randconfig-2200-20261116    gcc-14     smatch
i386                  randconfig-2300-20261116    gcc-14     sparse
i386                  randconfig-2301-20261116    gcc-14     sparse
i386                  randconfig-2302-20261116    gcc-14     sparse
i386                 randconfig-r2101-20261116    gcc-13.5.0 cocci
i386                 randconfig-r2102-20261117    gcc-16.2.0 cocci
i386                 randconfig-r2302-20261116    clang-24   sparse
i386                 randconfig-r2311-20261116    clang-20   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261117    clang-17
loongarch             randconfig-1001-20261117    clang-17
loongarch             randconfig-2000-20261116    clang-24
loongarch             randconfig-2000-20261116    gcc-11.5.0
loongarch             randconfig-2000-20261117    gcc-8.5.0
loongarch             randconfig-2001-20261116    clang-24
loongarch             randconfig-2001-20261116    gcc-11.5.0
loongarch             randconfig-2001-20261117    gcc-8.5.0
loongarch             randconfig-2200-20261116    clang-19   smatch
loongarch             randconfig-2200-20261117    gcc-13.5.0 smatch
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           amiga_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261116    gcc-10.5.0
m68k                  randconfig-2000-20261116    gcc-12.5.0
m68k                  randconfig-2000-20261117    gcc-15.3.0
m68k                  randconfig-2001-20261116    gcc-10.5.0
m68k                  randconfig-2001-20261117    gcc-15.3.0
m68k                  randconfig-2200-20261116    gcc-14.4.0 smatch
m68k                  randconfig-2200-20261117    gcc-11.5.0 smatch
m68k                 randconfig-r2107-20261116    clang-24   cocci
m68k                 randconfig-r2300-20261116    gcc-11.5.0 sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261116    gcc-10.5.0
microblaze            randconfig-2000-20261116    gcc-8.5.0
microblaze            randconfig-2000-20261117    gcc-15.3.0
microblaze            randconfig-2001-20261116    gcc-10.5.0
microblaze            randconfig-2001-20261116    gcc-15.3.0
microblaze            randconfig-2001-20261117    gcc-15.3.0
microblaze            randconfig-2200-20261116    gcc-11.5.0 smatch
microblaze            randconfig-2200-20261117    gcc-14.4.0 smatch
microblaze           randconfig-r2100-20261117    gcc-16.2.0 cocci
microblaze           randconfig-r2302-20261116    gcc-11.5.0 sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                      loongson2k_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261116    gcc-13.5.0
mips                  randconfig-2001-20261116    gcc-13.5.0
mips                  randconfig-2002-20261116    gcc-13.5.0
mips                  randconfig-2200-20261116    gcc-8.5.0  smatch
mips                 randconfig-r2301-20261116    gcc-11.5.0 sparse
mips                            xway_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261117    clang-17
nios2                 randconfig-1001-20261117    clang-17
nios2                 randconfig-2000-20261116    gcc-11.5.0
nios2                 randconfig-2000-20261117    gcc-8.5.0
nios2                 randconfig-2001-20261116    gcc-11.5.0
nios2                 randconfig-2001-20261117    gcc-8.5.0
nios2                 randconfig-2200-20261116    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261117    gcc-11.5.0 smatch
nios2                randconfig-r2105-20261116    gcc-13.5.0 cocci
nios2                randconfig-r2305-20261116    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261116    gcc-13.5.0
openrisc              randconfig-2001-20261116    gcc-13.5.0
openrisc              randconfig-2002-20261116    gcc-13.5.0
openrisc              randconfig-2200-20261116    gcc-15.3.0 smatch
openrisc              randconfig-2200-20261117    gcc-16.2.0 smatch
openrisc             randconfig-r2108-20261116    clang-24   cocci
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                 generic-64bit_defconfig    clang-24
parisc                randconfig-1000-20261117    gcc-9.5.0
parisc                randconfig-1001-20261117    gcc-9.5.0
parisc                randconfig-2000-20261116    gcc-11.5.0
parisc                randconfig-2000-20261116    gcc-15.3.0
parisc                randconfig-2000-20261117    gcc-8.5.0
parisc                randconfig-2001-20261116    gcc-11.5.0
parisc                randconfig-2001-20261116    gcc-9.5.0
parisc                randconfig-2001-20261117    gcc-8.5.0
parisc                randconfig-2200-20261116    gcc-8.5.0  smatch
parisc                randconfig-2200-20261117    gcc-8.5.0  smatch
parisc               randconfig-r2103-20261116    gcc-13.5.0 cocci
parisc               randconfig-r2109-20261116    clang-24   cocci
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                  canyonlands_defconfig    clang-24
powerpc                  mpc8313_rdb_defconfig    gcc-16.2.0
powerpc                mpc834x_itxgp_defconfig    clang-24
powerpc                  mpc836x_rdk_defconfig    clang-24
powerpc                      mpc83xx_defconfig    gcc-16.2.0
powerpc                       pcm030_defconfig    clang-24
powerpc                       pmac32_defconfig    clang-24
powerpc                        ppc64_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261117    gcc-9.5.0
powerpc               randconfig-1001-20261117    gcc-9.5.0
powerpc               randconfig-2000-20261116    clang-17
powerpc               randconfig-2000-20261117    gcc-8.5.0
powerpc               randconfig-2001-20261116    clang-17
powerpc               randconfig-2001-20261117    gcc-8.5.0
powerpc               randconfig-2002-20261116    clang-17
powerpc               randconfig-2002-20261117    gcc-8.5.0
powerpc               randconfig-2200-20261116    clang-22   smatch
powerpc               randconfig-2200-20261117    gcc-8.5.0  smatch
powerpc64             randconfig-1000-20261117    gcc-9.5.0
powerpc64             randconfig-1001-20261117    gcc-9.5.0
powerpc64             randconfig-2000-20261116    clang-17
powerpc64             randconfig-2000-20261117    gcc-8.5.0
powerpc64             randconfig-2001-20261116    clang-17
powerpc64             randconfig-2001-20261117    gcc-8.5.0
powerpc64             randconfig-2002-20261116    clang-17
powerpc64             randconfig-2002-20261117    gcc-8.5.0
powerpc64             randconfig-2200-20261116    clang-19   smatch
powerpc64            randconfig-r2104-20261116    gcc-15.3.0 cocci
powerpc64            randconfig-r2305-20261116    gcc-11.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261117    clang-24
riscv                 randconfig-1001-20261117    clang-24
riscv                 randconfig-2000-20261116    clang-20
riscv                 randconfig-2000-20261116    gcc-8.5.0
riscv                 randconfig-2001-20261116    clang-20
riscv                 randconfig-2001-20261116    clang-24
riscv                 randconfig-2002-20261116    clang-20
riscv                 randconfig-2002-20261116    gcc-16.2.0
riscv                 randconfig-2003-20261116    clang-20
riscv                 randconfig-2004-20261116    clang-20
riscv                 randconfig-2004-20261116    clang-24
riscv                 randconfig-2005-20261116    clang-18
riscv                 randconfig-2005-20261116    clang-20
riscv                 randconfig-2200-20261116    clang-24   smatch
riscv                randconfig-r2101-20261117    gcc-16.2.0 cocci
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261117    clang-24
s390                  randconfig-1001-20261117    clang-24
s390                  randconfig-2000-20261116    clang-17
s390                  randconfig-2000-20261117    gcc-15.3.0
s390                  randconfig-2001-20261116    clang-17
s390                  randconfig-2001-20261116    clang-24
s390                  randconfig-2001-20261117    gcc-15.3.0
s390                  randconfig-2002-20261116    clang-17
s390                  randconfig-2002-20261116    gcc-12.5.0
s390                  randconfig-2002-20261117    gcc-15.3.0
s390                  randconfig-2003-20261116    clang-17
s390                  randconfig-2003-20261116    gcc-8.5.0
s390                  randconfig-2003-20261117    gcc-15.3.0
s390                  randconfig-2004-20261116    clang-17
s390                  randconfig-2004-20261116    gcc-12.5.0
s390                  randconfig-2004-20261117    gcc-15.3.0
s390                  randconfig-2005-20261116    clang-17
s390                  randconfig-2005-20261117    gcc-15.3.0
s390                  randconfig-2200-20261116    gcc-10.5.0 smatch
s390                  randconfig-2200-20261117    gcc-11.5.0 smatch
s390                 randconfig-r2300-20261116    clang-24   sparse
s390                 randconfig-r2304-20261116    gcc-11.5.0 sparse
s390                        zfcpdump_defconfig    gcc-16.2.0
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261117    clang-24
sh                    randconfig-1001-20261117    clang-24
sh                    randconfig-2000-20261116    gcc-15.3.0
sh                    randconfig-2000-20261116    gcc-9.5.0
sh                    randconfig-2000-20261117    gcc-14.4.0
sh                    randconfig-2001-20261116    gcc-11.5.0
sh                    randconfig-2001-20261116    gcc-15.3.0
sh                    randconfig-2001-20261117    gcc-14.4.0
sh                    randconfig-2002-20261116    gcc-13.5.0
sh                    randconfig-2002-20261116    gcc-15.3.0
sh                    randconfig-2002-20261117    gcc-14.4.0
sh                    randconfig-2003-20261116    gcc-15.3.0
sh                    randconfig-2003-20261117    gcc-14.4.0
sh                    randconfig-2004-20261116    gcc-15.3.0
sh                    randconfig-2004-20261116    gcc-16.2.0
sh                    randconfig-2004-20261117    gcc-14.4.0
sh                    randconfig-2005-20261116    gcc-15.3.0
sh                    randconfig-2005-20261117    gcc-14.4.0
sh                    randconfig-2200-20261116    gcc-15.3.0 smatch
sh                    randconfig-2200-20261117    gcc-16.2.0 smatch
sh                   randconfig-r2101-20261116    gcc-15.3.0 cocci
sh                   randconfig-r2103-20261117    gcc-16.2.0 cocci
sh                   randconfig-r2104-20261117    gcc-16.2.0 cocci
sh                   randconfig-r2309-20261116    clang-20   sparse
sh                           sdk7780_defconfig    gcc-16.2.0
sh                      sh7710voipgw_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261117    gcc-15.3.0
sparc                 randconfig-1001-20261117    gcc-15.3.0
sparc                 randconfig-2000-20261116    gcc-14
sparc                 randconfig-2000-20261117    gcc-14
sparc                 randconfig-2001-20261116    gcc-14
sparc                 randconfig-2001-20261117    gcc-14
sparc                 randconfig-2200-20261116    gcc-15.3.0 smatch
sparc                randconfig-r2100-20261116    gcc-15.3.0 cocci
sparc                        sparc32_defconfig    gcc-16.2.0
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261117    gcc-15.3.0
sparc64               randconfig-1001-20261117    gcc-15.3.0
sparc64               randconfig-2000-20261116    gcc-14
sparc64               randconfig-2000-20261117    gcc-14
sparc64               randconfig-2001-20261116    gcc-14
sparc64               randconfig-2001-20261117    gcc-14
sparc64               randconfig-2200-20261116    gcc-8.5.0  smatch
sparc64               randconfig-2200-20261117    gcc-8.5.0  smatch
sparc64              randconfig-r2102-20261116    gcc-15.3.0 cocci
sparc64              randconfig-r2104-20261116    gcc-13.5.0 cocci
sparc64              randconfig-r2106-20261116    clang-24   cocci
sparc64              randconfig-r2306-20261116    clang-20   sparse
sparc64              randconfig-r2307-20261116    clang-20   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261117    gcc-15.3.0
um                    randconfig-1001-20261117    gcc-15.3.0
um                    randconfig-2000-20261116    gcc-14
um                    randconfig-2000-20261117    gcc-14
um                    randconfig-2001-20261116    gcc-14
um                    randconfig-2001-20261117    gcc-14
um                    randconfig-2200-20261116    gcc-14     smatch
um                    randconfig-2200-20261117    clang-21   smatch
um                   randconfig-r2102-20261116    gcc-13.5.0 cocci
um                   randconfig-r2105-20261116    gcc-15.3.0 cocci
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261117    gcc-13
x86_64      buildonly-randconfig-1001-20261117    gcc-13
x86_64      buildonly-randconfig-1002-20261117    gcc-13
x86_64      buildonly-randconfig-1003-20261117    gcc-13
x86_64      buildonly-randconfig-1004-20261117    gcc-13
x86_64      buildonly-randconfig-1005-20261117    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261117    clang-22
x86_64                randconfig-1001-20261117    clang-22
x86_64                randconfig-1002-20261117    clang-22
x86_64                randconfig-1003-20261117    clang-22
x86_64                randconfig-1004-20261117    clang-22
x86_64                randconfig-1005-20261117    clang-22
x86_64                randconfig-1006-20261117    gcc-14
x86_64                randconfig-1007-20261117    gcc-14
x86_64                randconfig-1008-20261117    gcc-14
x86_64                randconfig-1009-20261117    gcc-14
x86_64                randconfig-1010-20261117    gcc-14
x86_64                randconfig-1011-20261117    gcc-14
x86_64                randconfig-1012-20261117    gcc-14
x86_64                randconfig-1013-20261117    gcc-14
x86_64                randconfig-1014-20261117    gcc-14
x86_64                randconfig-1015-20261117    gcc-14
x86_64                randconfig-1016-20261117    gcc-14
x86_64                randconfig-1017-20261117    gcc-14
x86_64                randconfig-2000-20261116    gcc-13
x86_64                randconfig-2000-20261116    gcc-14
x86_64                randconfig-2000-20261117    gcc-14
x86_64                randconfig-2001-20261116    gcc-14
x86_64                randconfig-2001-20261117    gcc-14
x86_64                randconfig-2002-20261116    clang-22
x86_64                randconfig-2002-20261116    gcc-14
x86_64                randconfig-2002-20261117    gcc-14
x86_64                randconfig-2003-20261116    clang-22
x86_64                randconfig-2003-20261116    gcc-14
x86_64                randconfig-2003-20261117    gcc-14
x86_64                randconfig-2004-20261116    gcc-14
x86_64                randconfig-2004-20261117    gcc-14
x86_64                randconfig-2005-20261116    clang-22
x86_64                randconfig-2005-20261116    gcc-14
x86_64                randconfig-2005-20261117    gcc-14
x86_64                randconfig-2100-20261116    gcc-14     cocci
x86_64                randconfig-2101-20261116    gcc-14     cocci
x86_64                randconfig-2102-20261116    gcc-14     cocci
x86_64                randconfig-2103-20261116    gcc-14     cocci
x86_64                randconfig-2104-20261116    gcc-14     cocci
x86_64                randconfig-2105-20261116    gcc-14     cocci
x86_64                randconfig-2200-20261116    clang-22   smatch
x86_64                randconfig-2200-20261117    gcc-14     smatch
x86_64                randconfig-2300-20261116    gcc-14     sparse
x86_64                randconfig-2301-20261116    gcc-14     sparse
x86_64                randconfig-2302-20261116    gcc-14     sparse
x86_64               randconfig-r2308-20261116    clang-20   sparse
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
xtensa                randconfig-1000-20261117    gcc-15.3.0
xtensa                randconfig-1001-20261117    gcc-15.3.0
xtensa                randconfig-2000-20261116    gcc-16.2.0
xtensa                randconfig-2001-20261116    gcc-16.2.0
xtensa                randconfig-2200-20261117    gcc-8.5.0  smatch
xtensa                          virt_defconfig    gcc-16.2.0
xtensa                     xip_kc705_defconfig    gcc-16.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
