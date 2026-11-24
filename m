Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506781;
	b=5P8ZbIVDIvccgb8bCp6RWMFC+zu60/76dMEWKrA+K/HxeMmZOyqSiXoEMTV9rRRKzTNw
	 dE4xk4abn3ap2P6J6f7wWkKxhL5yj3e/Nu5GFUAgDLP8ZWsHpATW2Vsk6kO4WiIavDQjV
	 vA5uhJzhZW293a9VrimUKZVBrUWiGCnPWS9jFRJ+1rJBD6RIrnyFnK/c76gQ6ZnIzt5Zn
	 xwoR3sAwQ9H7xYGA+3d9WHoBe9qp3VFFLfM4p7OvVKlK6RqklE2y6uuhu85e1e3D4sOTN
	 OJ7II9aXZF6w4x+4LuIdSqszaGqwHDNLnlyZLMQcjfTz90rn+uUlTbVd7kjW0b3J0Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506781;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=0Y4Cw3ef4+JPCHj6OUFJ7aGVgiX/QqX+FtR+u3Nw1xE=;
	b=okEMOkAKET63tsT/jYYotb8gLwpvS6Pt4vfS8TvahNLcv/ZcdBR/YcE88TRDHveRPwwX
	 Qhncur/7ARY7sLVIci/Ak9/I4teW4hzcddrxUFOzPhcYZor8YxL9hPFY1t3aI8hsS9Dz5
	 4zkXACO2s5imThznAzGjhcKqu218DYf0SnElyXAqbuxWn23uurx7QWvWfwfMYxOeVTAhm
	 yraFPOcmwieoQHLKm5YW+j7Hn04EBPdfFmQ7e7apyiL3Ge9W8GPnnU4xij/eZN5/kTkwD
	 csqKomVnJrPXCTaRWk7fEzWXV82QDmo4O9L7o8rJxXlIDvRV1ebLvs7twcvNTTENUDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VLEj0VSV;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E34606A321;
	Tue, 24 Nov 2026 07:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E34606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VLEj0VSV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795506781; x=1827042781;
  h=date:from:to:cc:subject:message-id;
  bh=a0lNWswTv5FfhK67xwNIuHVRv30chbu6SFozjmDNczw=;
  b=VLEj0VSVQu6wvilG1zsezVlOKbGrQRKNulsguT2IGiWHdqKaAKMWa4D7
   10S4XZr2VBRd8JDop9AOPLUOQzGKdfZgG+xZ1qSSCT+mmMuMVS1T5Z1Qc
   qI/VgqyfIJOCFlR2IOIz2cd6JpwVT80tFF6G+d9lx/YY6TeDj5IcniVsa
   aF4p2vqcLLXgEcWM5EJKCbGz3WQ/8ym8fDHouFCpz54MJLjBsvXpaArqR
   4It8nBaR8vmuwOwHjumjBzCwNeV79u+YKMZJoLEF+eue0yz7F/aRFumyG
   57ikZQi9oYlOCZL8GrkeVTCk5WHImXOeqsQvcToLKLU9Hm2LbwvcOd7sx
   Q==;
X-CSE-ConnectionGUID: gSf7UBlUSaSsUFcudFX/0w==
X-CSE-MsgGUID: dR+dus7oR+KsZfBoginX0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4320984"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4320984"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 23:53:00 -0800
X-CSE-ConnectionGUID: ibbHb+PfQ0mc0HP56JE4Uw==
X-CSE-MsgGUID: +IJMo5bRSGSqJpv6iEUrrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11373144"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 23:52:58 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVlKi-00000001OoQ-1VfF;
	Tue, 24 Nov 2026 07:52:56 +0000
Date: Tue, 24 Nov 2026 15:51:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 564e0f0c59d4113ee95aa348ed07b970f849bdf8
Message-ID: <20261124155156.ejZ7k3dp-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 564e0f0c59d4113ee95aa348ed07b970f849bdf8  Merge branches 'thermal-core-fixes' and 'pm-cpufreq-fixes' into fixes

elapsed time: 762m

configs tested: 571
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261124    gcc-11.5.0
alpha                 randconfig-2001-20261124    gcc-11.5.0
alpha                 randconfig-2200-20261123    gcc-12.5.0 smatch
alpha                 randconfig-2200-20261124    gcc-8.5.0  smatch
alpha                randconfig-r2103-20261124    gcc-16.2.0 cocci
alpha                randconfig-r2300-20261124    clang-24   sparse
alpha                randconfig-r2305-20261123    gcc-14.4.0 sparse
alpha                randconfig-r2307-20261124    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                       axs103_smp_defconfig    gcc-16.2.0
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261124    clang-24
arc                   randconfig-1001-20261124    clang-24
arc                   randconfig-2000-20261123    gcc-12.5.0
arc                   randconfig-2000-20261124    gcc-11.5.0
arc                   randconfig-2001-20261123    gcc-12.5.0
arc                   randconfig-2001-20261124    gcc-11.5.0
arc                   randconfig-2002-20261123    gcc-12.5.0
arc                   randconfig-2002-20261124    gcc-11.5.0
arc                   randconfig-2003-20261123    gcc-12.5.0
arc                   randconfig-2003-20261124    gcc-11.5.0
arc                   randconfig-2004-20261123    gcc-12.5.0
arc                   randconfig-2004-20261124    gcc-11.5.0
arc                   randconfig-2005-20261123    gcc-12.5.0
arc                   randconfig-2005-20261124    gcc-11.5.0
arc                   randconfig-2200-20261123    gcc-12.5.0 smatch
arc                   randconfig-2200-20261124    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261124    gcc-12.5.0 cocci
arc                  randconfig-r2102-20261123    gcc-8.5.0  cocci
arc                  randconfig-r2104-20261124    gcc-16.2.0 cocci
arc                  randconfig-r2106-20261124    gcc-10.5.0 cocci
arc                  randconfig-r2108-20261123    gcc-14     cocci
arc                  randconfig-r2108-20261124    clang-24   cocci
arc                  randconfig-r2309-20261124    gcc-8.5.0  sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                          at91_dt_defconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                           ep93xx_defconfig    clang-24
arm                       footbridge_defconfig    clang-24
arm                         mvebu_v5_defconfig    clang-24
arm                   randconfig-1000-20261124    clang-24
arm                   randconfig-1001-20261124    clang-24
arm                   randconfig-1002-20261124    clang-24
arm                   randconfig-1003-20261124    clang-24
arm                   randconfig-2000-20261123    gcc-8.5.0
arm                   randconfig-2000-20261124    clang-17
arm                   randconfig-2001-20261123    gcc-8.5.0
arm                   randconfig-2001-20261124    clang-17
arm                   randconfig-2002-20261123    gcc-8.5.0
arm                   randconfig-2002-20261124    clang-17
arm                   randconfig-2200-20261123    gcc-8.5.0  smatch
arm                   randconfig-2200-20261124    clang-17   smatch
arm                  randconfig-r2101-20261123    gcc-8.5.0  cocci
arm                  randconfig-r2104-20261124    clang-24   cocci
arm                  randconfig-r2107-20261123    gcc-14     cocci
arm                  randconfig-r2307-20261123    gcc-8.5.0  sparse
arm                          s5pv210_defconfig    clang-24
arm                         spear3xx_defconfig    gcc-16.2.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261124    gcc-8.5.0
arm64                 randconfig-1001-20261124    gcc-8.5.0
arm64                 randconfig-1002-20261124    gcc-8.5.0
arm64                 randconfig-1003-20261124    gcc-8.5.0
arm64                 randconfig-2000-20261123    gcc-8.5.0
arm64                 randconfig-2000-20261124    clang-17
arm64                 randconfig-2001-20261123    gcc-8.5.0
arm64                 randconfig-2001-20261124    clang-17
arm64                 randconfig-2002-20261123    gcc-8.5.0
arm64                 randconfig-2002-20261124    clang-17
arm64                 randconfig-2200-20261123    clang-17   smatch
arm64                 randconfig-2200-20261124    gcc-16.2.0 smatch
arm64                randconfig-r2101-20261123    gcc-8.5.0  cocci
arm64                randconfig-r2101-20261124    gcc-16.2.0 cocci
arm64                randconfig-r2107-20261124    gcc-12.5.0 cocci
arm64                randconfig-r2109-20261123    clang-17   cocci
arm64                randconfig-r2304-20261124    gcc-16.2.0 sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261124    gcc-8.5.0
csky                  randconfig-1001-20261124    gcc-8.5.0
csky                  randconfig-2000-20261123    gcc-12.5.0
csky                  randconfig-2000-20261124    gcc-16.2.0
csky                  randconfig-2001-20261123    gcc-12.5.0
csky                  randconfig-2001-20261124    gcc-16.2.0
csky                  randconfig-2200-20261123    gcc-16.2.0 smatch
csky                  randconfig-2200-20261124    gcc-15.3.0 smatch
csky                 randconfig-r2102-20261124    clang-24   cocci
csky                 randconfig-r2103-20261124    clang-24   cocci
csky                 randconfig-r2104-20261123    gcc-8.5.0  cocci
csky                 randconfig-r2111-20261123    clang-17   cocci
csky                 randconfig-r2111-20261124    gcc-16.2.0 cocci
csky                 randconfig-r2311-20261123    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261124    gcc-10.5.0
hexagon               randconfig-1001-20261124    gcc-10.5.0
hexagon               randconfig-2000-20261123    gcc-12.5.0
hexagon               randconfig-2000-20261124    gcc-16.2.0
hexagon               randconfig-2001-20261123    gcc-12.5.0
hexagon               randconfig-2001-20261124    gcc-16.2.0
hexagon               randconfig-2200-20261123    clang-24   smatch
hexagon               randconfig-2200-20261124    clang-24   smatch
hexagon              randconfig-r2101-20261124    clang-24   cocci
hexagon              randconfig-r2103-20261124    clang-24   cocci
hexagon              randconfig-r2105-20261124    clang-24   cocci
hexagon              randconfig-r2108-20261124    gcc-16.2.0 cocci
hexagon              randconfig-r2302-20261124    clang-24   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261124    gcc-12
i386        buildonly-randconfig-1001-20261124    gcc-12
i386        buildonly-randconfig-1002-20261124    gcc-12
i386        buildonly-randconfig-1003-20261124    gcc-12
i386        buildonly-randconfig-1004-20261124    gcc-12
i386        buildonly-randconfig-1005-20261124    gcc-12
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261124    gcc-14
i386                  randconfig-1001-20261124    gcc-14
i386                  randconfig-1002-20261124    gcc-14
i386                  randconfig-1003-20261124    gcc-14
i386                  randconfig-1004-20261124    gcc-14
i386                  randconfig-1005-20261124    gcc-14
i386                  randconfig-1006-20261124    gcc-14
i386                  randconfig-2000-20261123    gcc-14
i386                  randconfig-2000-20261124    gcc-14
i386                  randconfig-2001-20261123    gcc-14
i386                  randconfig-2001-20261124    gcc-14
i386                  randconfig-2002-20261123    gcc-14
i386                  randconfig-2002-20261124    gcc-14
i386                  randconfig-2003-20261123    gcc-14
i386                  randconfig-2003-20261124    gcc-14
i386                  randconfig-2004-20261123    gcc-14
i386                  randconfig-2004-20261124    gcc-14
i386                  randconfig-2005-20261123    gcc-14
i386                  randconfig-2005-20261124    gcc-14
i386                  randconfig-2100-20261123    clang-22   cocci
i386                  randconfig-2100-20261124    gcc-14     cocci
i386                  randconfig-2101-20261123    clang-22   cocci
i386                  randconfig-2101-20261124    gcc-14     cocci
i386                  randconfig-2102-20261123    clang-22   cocci
i386                  randconfig-2102-20261124    gcc-14     cocci
i386                  randconfig-2103-20261123    clang-22   cocci
i386                  randconfig-2103-20261124    gcc-14     cocci
i386                  randconfig-2104-20261123    clang-22   cocci
i386                  randconfig-2104-20261124    gcc-14     cocci
i386                  randconfig-2105-20261123    clang-22   cocci
i386                  randconfig-2105-20261124    gcc-14     cocci
i386                  randconfig-2200-20261123    gcc-14     smatch
i386                  randconfig-2200-20261124    clang-22   smatch
i386                  randconfig-2300-20261123    gcc-14     sparse
i386                  randconfig-2300-20261124    gcc-14     sparse
i386                  randconfig-2301-20261123    gcc-14     sparse
i386                  randconfig-2301-20261124    gcc-14     sparse
i386                  randconfig-2302-20261123    gcc-14     sparse
i386                  randconfig-2302-20261124    gcc-14     sparse
i386                 randconfig-r2104-20261123    gcc-8.5.0  cocci
i386                 randconfig-r2108-20261124    gcc-12.5.0 cocci
i386                 randconfig-r2311-20261124    gcc-8.5.0  sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261124    gcc-10.5.0
loongarch             randconfig-1001-20261124    gcc-10.5.0
loongarch             randconfig-2000-20261123    gcc-16.2.0
loongarch             randconfig-2000-20261124    clang-18
loongarch             randconfig-2001-20261123    gcc-16.2.0
loongarch             randconfig-2001-20261124    clang-18
loongarch             randconfig-2200-20261123    clang-24   smatch
loongarch             randconfig-2200-20261124    gcc-16.2.0 smatch
loongarch            randconfig-r2100-20261123    gcc-8.5.0  cocci
loongarch            randconfig-r2101-20261124    clang-24   cocci
loongarch            randconfig-r2102-20261124    clang-24   cocci
loongarch            randconfig-r2106-20261123    clang-17   cocci
loongarch            randconfig-r2108-20261123    clang-17   cocci
loongarch            randconfig-r2110-20261124    gcc-10.5.0 cocci
loongarch            randconfig-r2300-20261123    gcc-14.4.0 sparse
loongarch            randconfig-r2306-20261124    gcc-8.5.0  sparse
loongarch            randconfig-r2309-20261124    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                           atari_defconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    clang-24
m68k                        m5235evb_defconfig    clang-24
m68k                       m54418evb_defconfig    gcc-16.2.0
m68k                  randconfig-2000-20261124    gcc-11.5.0
m68k                  randconfig-2001-20261124    gcc-11.5.0
m68k                  randconfig-2200-20261123    gcc-8.5.0  smatch
m68k                  randconfig-2200-20261124    gcc-10.5.0 smatch
m68k                 randconfig-r2105-20261124    gcc-16.2.0 cocci
m68k                 randconfig-r2108-20261124    gcc-10.5.0 cocci
m68k                 randconfig-r2300-20261124    clang-18   sparse
m68k                 randconfig-r2301-20261123    gcc-14.4.0 sparse
m68k                 randconfig-r2306-20261124    gcc-14     sparse
m68k                 randconfig-r2310-20261124    gcc-14     sparse
m68k                            sun3_defconfig    gcc-16.2.0
microblaze                        alldefconfig    gcc-16.2.0
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261124    gcc-11.5.0
microblaze            randconfig-2001-20261124    gcc-11.5.0
microblaze            randconfig-2200-20261123    gcc-16.2.0 smatch
microblaze            randconfig-2200-20261124    gcc-8.5.0  smatch
microblaze           randconfig-r2100-20261124    clang-24   cocci
microblaze           randconfig-r2100-20261124    gcc-16.2.0 cocci
microblaze           randconfig-r2103-20261123    gcc-8.5.0  cocci
microblaze           randconfig-r2104-20261124    clang-24   cocci
microblaze           randconfig-r2110-20261123    clang-17   cocci
microblaze           randconfig-r2303-20261124    clang-18   sparse
microblaze           randconfig-r2303-20261124    gcc-16.2.0 sparse
microblaze           randconfig-r2308-20261124    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                          cobalt_defconfig    clang-24
mips                          db1xxx_defconfig    gcc-16.2.0
mips                     maltaup_xpa_defconfig    gcc-16.2.0
mips                  randconfig-2000-20261123    gcc-10.5.0
mips                  randconfig-2000-20261124    gcc-16.2.0
mips                  randconfig-2001-20261123    gcc-10.5.0
mips                  randconfig-2001-20261124    gcc-16.2.0
mips                  randconfig-2002-20261123    gcc-10.5.0
mips                  randconfig-2002-20261124    gcc-16.2.0
mips                  randconfig-2200-20261123    gcc-14.4.0 smatch
mips                  randconfig-2200-20261124    clang-20   smatch
mips                 randconfig-r2101-20261124    gcc-12.5.0 cocci
mips                 randconfig-r2104-20261124    gcc-16.2.0 cocci
mips                 randconfig-r2107-20261124    clang-24   cocci
mips                 randconfig-r2110-20261124    gcc-16.2.0 cocci
mips                 randconfig-r2304-20261124    clang-18   sparse
mips                            rs90_defconfig    gcc-16.2.0
mips                            xway_defconfig    gcc-16.2.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261124    gcc-10.5.0
nios2                 randconfig-1001-20261124    gcc-10.5.0
nios2                 randconfig-2000-20261123    gcc-16.2.0
nios2                 randconfig-2000-20261124    clang-18
nios2                 randconfig-2001-20261123    gcc-16.2.0
nios2                 randconfig-2001-20261124    clang-18
nios2                 randconfig-2200-20261123    gcc-8.5.0  smatch
nios2                 randconfig-2200-20261124    gcc-11.5.0 smatch
nios2                randconfig-r2100-20261124    gcc-16.2.0 cocci
nios2                randconfig-r2103-20261124    clang-24   cocci
nios2                randconfig-r2104-20261124    gcc-12.5.0 cocci
nios2                randconfig-r2105-20261123    gcc-8.5.0  cocci
nios2                randconfig-r2107-20261124    gcc-8.5.0  cocci
nios2                randconfig-r2111-20261124    gcc-12.5.0 cocci
nios2                randconfig-r2308-20261123    gcc-8.5.0  sparse
nios2                randconfig-r2308-20261124    gcc-8.5.0  sparse
nios2                randconfig-r2311-20261124    gcc-14     sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261123    gcc-10.5.0
openrisc              randconfig-2000-20261124    gcc-16.2.0
openrisc              randconfig-2001-20261123    gcc-10.5.0
openrisc              randconfig-2001-20261124    gcc-16.2.0
openrisc              randconfig-2002-20261123    gcc-10.5.0
openrisc              randconfig-2002-20261124    gcc-16.2.0
openrisc              randconfig-2200-20261123    gcc-12.5.0 smatch
openrisc              randconfig-2200-20261124    gcc-11.5.0 smatch
openrisc             randconfig-r2101-20261124    clang-24   cocci
openrisc             randconfig-r2101-20261124    gcc-16.2.0 cocci
openrisc             randconfig-r2103-20261124    gcc-12.5.0 cocci
openrisc             randconfig-r2109-20261124    gcc-12.5.0 cocci
openrisc             randconfig-r2110-20261123    gcc-14     cocci
openrisc             randconfig-r2300-20261124    gcc-16.2.0 sparse
openrisc             randconfig-r2306-20261123    gcc-8.5.0  sparse
openrisc             randconfig-r2310-20261124    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261124    clang-24
parisc                randconfig-1001-20261124    clang-24
parisc                randconfig-2000-20261123    gcc-16.2.0
parisc                randconfig-2000-20261124    clang-18
parisc                randconfig-2001-20261123    gcc-16.2.0
parisc                randconfig-2001-20261124    clang-18
parisc                randconfig-2200-20261123    gcc-14.4.0 smatch
parisc                randconfig-2200-20261124    gcc-9.5.0  smatch
parisc               randconfig-r2100-20261123    gcc-8.5.0  cocci
parisc               randconfig-r2106-20261123    gcc-14     cocci
parisc               randconfig-r2106-20261124    gcc-10.5.0 cocci
parisc               randconfig-r2109-20261124    gcc-8.5.0  cocci
parisc               randconfig-r2303-20261123    gcc-14.4.0 sparse
parisc               randconfig-r2304-20261124    clang-24   sparse
parisc               randconfig-r2307-20261124    gcc-8.5.0  sparse
parisc               randconfig-r2310-20261123    gcc-8.5.0  sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    gcc-16.2.0
powerpc                       cm5200_defconfig    clang-24
powerpc                        ebony_defconfig    clang-24
powerpc                     mvme5100_defconfig    gcc-16.2.0
powerpc                        ppc64_defconfig    gcc-16.2.0
powerpc               randconfig-1000-20261124    clang-24
powerpc               randconfig-1001-20261124    clang-24
powerpc               randconfig-2000-20261123    clang-21
powerpc               randconfig-2000-20261124    clang-24
powerpc               randconfig-2001-20261123    clang-21
powerpc               randconfig-2001-20261124    clang-24
powerpc               randconfig-2002-20261123    clang-21
powerpc               randconfig-2002-20261124    clang-24
powerpc               randconfig-2200-20261123    gcc-9.5.0  smatch
powerpc               randconfig-2200-20261124    clang-21   smatch
powerpc              randconfig-r2106-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2110-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2111-20261123    gcc-14     cocci
powerpc              randconfig-r2111-20261124    gcc-8.5.0  cocci
powerpc              randconfig-r2301-20261124    clang-18   sparse
powerpc                      skiroot_defconfig    clang-24
powerpc                     socrates_defconfig    gcc-16.2.0
powerpc                      stx_gp3_defconfig    gcc-16.2.0
powerpc                      tqm8541_defconfig    gcc-16.2.0
powerpc                      tqm8560_defconfig    gcc-16.2.0
powerpc                       tqm8xx_defconfig    clang-24
powerpc64                         alldefconfig    gcc-16.2.0
powerpc64             randconfig-1000-20261124    clang-24
powerpc64             randconfig-1001-20261124    clang-24
powerpc64             randconfig-2000-20261123    clang-21
powerpc64             randconfig-2000-20261124    clang-24
powerpc64             randconfig-2001-20261123    clang-21
powerpc64             randconfig-2001-20261124    clang-24
powerpc64             randconfig-2002-20261123    clang-21
powerpc64             randconfig-2002-20261124    clang-24
powerpc64             randconfig-2200-20261123    gcc-15.3.0 smatch
powerpc64             randconfig-2200-20261124    gcc-12.5.0 smatch
powerpc64            randconfig-r2106-20261124    gcc-16.2.0 cocci
powerpc64            randconfig-r2109-20261124    gcc-10.5.0 cocci
powerpc64            randconfig-r2111-20261124    gcc-10.5.0 cocci
powerpc64            randconfig-r2303-20261124    clang-24   sparse
powerpc64            randconfig-r2305-20261124    gcc-16.2.0 sparse
powerpc64            randconfig-r2310-20261124    gcc-8.5.0  sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261124    gcc-11.5.0
riscv                 randconfig-1001-20261124    gcc-11.5.0
riscv                 randconfig-2000-20261123    gcc-11.5.0
riscv                 randconfig-2000-20261124    gcc-16.2.0
riscv                 randconfig-2001-20261123    gcc-11.5.0
riscv                 randconfig-2001-20261123    gcc-13.5.0
riscv                 randconfig-2001-20261124    gcc-16.2.0
riscv                 randconfig-2002-20261123    gcc-11.5.0
riscv                 randconfig-2002-20261123    gcc-8.5.0
riscv                 randconfig-2002-20261124    gcc-16.2.0
riscv                 randconfig-2003-20261123    gcc-11.5.0
riscv                 randconfig-2003-20261123    gcc-8.5.0
riscv                 randconfig-2003-20261124    gcc-16.2.0
riscv                 randconfig-2004-20261123    clang-24
riscv                 randconfig-2004-20261123    gcc-11.5.0
riscv                 randconfig-2004-20261124    gcc-16.2.0
riscv                 randconfig-2005-20261123    gcc-11.5.0
riscv                 randconfig-2005-20261123    gcc-13.5.0
riscv                 randconfig-2005-20261124    gcc-16.2.0
riscv                 randconfig-2200-20261123    clang-17   smatch
riscv                 randconfig-2200-20261124    gcc-14.4.0 smatch
riscv                randconfig-r2105-20261124    gcc-12.5.0 cocci
riscv                randconfig-r2106-20261124    clang-24   cocci
riscv                randconfig-r2111-20261124    gcc-10.5.0 cocci
riscv                randconfig-r2308-20261124    gcc-14     sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261124    gcc-11.5.0
s390                  randconfig-1001-20261124    gcc-11.5.0
s390                  randconfig-2000-20261123    clang-20
s390                  randconfig-2000-20261124    clang-24
s390                  randconfig-2001-20261123    clang-20
s390                  randconfig-2001-20261124    clang-24
s390                  randconfig-2002-20261123    clang-20
s390                  randconfig-2002-20261124    clang-24
s390                  randconfig-2003-20261123    clang-20
s390                  randconfig-2003-20261124    clang-24
s390                  randconfig-2004-20261123    clang-20
s390                  randconfig-2004-20261124    clang-24
s390                  randconfig-2005-20261123    clang-20
s390                  randconfig-2005-20261124    clang-24
s390                  randconfig-2200-20261123    clang-24   smatch
s390                  randconfig-2200-20261124    clang-24   smatch
s390                 randconfig-r2103-20261123    gcc-8.5.0  cocci
s390                 randconfig-r2106-20261124    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261124    gcc-10.5.0 cocci
s390                 randconfig-r2109-20261124    gcc-16.2.0 cocci
s390                 randconfig-r2307-20261124    gcc-14     sparse
s390                 randconfig-r2311-20261124    gcc-8.5.0  sparse
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
sh                    randconfig-2002-20261123    gcc-16.2.0
sh                    randconfig-2002-20261124    gcc-11.5.0
sh                    randconfig-2003-20261123    gcc-16.2.0
sh                    randconfig-2003-20261124    gcc-11.5.0
sh                    randconfig-2004-20261123    gcc-16.2.0
sh                    randconfig-2004-20261124    gcc-11.5.0
sh                    randconfig-2005-20261123    gcc-16.2.0
sh                    randconfig-2005-20261124    gcc-11.5.0
sh                    randconfig-2200-20261123    gcc-16.2.0 smatch
sh                    randconfig-2200-20261124    gcc-16.2.0 smatch
sh                   randconfig-r2102-20261124    gcc-16.2.0 cocci
sh                   randconfig-r2105-20261124    clang-24   cocci
sh                   randconfig-r2110-20261124    clang-24   cocci
sh                   randconfig-r2110-20261124    gcc-12.5.0 cocci
sh                   randconfig-r2302-20261124    gcc-16.2.0 sparse
sh                           sdk7780_defconfig    gcc-16.2.0
sh                           sdk7786_defconfig    clang-24
sh                            se7619_defconfig    gcc-16.2.0
sh                            se7721_defconfig    gcc-16.2.0
sh                            se7780_defconfig    clang-24
sh                         sh7757lcr_defconfig    gcc-16.2.0
sh                    sh7770_generic_defconfig    clang-24
sh                           urquell_defconfig    gcc-16.2.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261124    clang-24
sparc                 randconfig-1001-20261124    clang-24
sparc                 randconfig-2000-20261123    gcc-9.5.0
sparc                 randconfig-2000-20261124    gcc-8.5.0
sparc                 randconfig-2001-20261123    gcc-9.5.0
sparc                 randconfig-2001-20261124    gcc-8.5.0
sparc                 randconfig-2200-20261123    gcc-12.5.0 smatch
sparc                 randconfig-2200-20261124    gcc-11.5.0 smatch
sparc                randconfig-r2100-20261124    clang-24   cocci
sparc                randconfig-r2103-20261124    gcc-16.2.0 cocci
sparc                randconfig-r2108-20261124    gcc-8.5.0  cocci
sparc                randconfig-r2109-20261124    gcc-10.5.0 cocci
sparc                randconfig-r2110-20261124    gcc-10.5.0 cocci
sparc                randconfig-r2301-20261124    gcc-16.2.0 sparse
sparc                randconfig-r2309-20261123    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261124    clang-24
sparc64               randconfig-1001-20261124    clang-24
sparc64               randconfig-2000-20261123    gcc-9.5.0
sparc64               randconfig-2000-20261124    gcc-8.5.0
sparc64               randconfig-2001-20261123    gcc-9.5.0
sparc64               randconfig-2001-20261124    gcc-8.5.0
sparc64               randconfig-2200-20261123    clang-22   smatch
sparc64               randconfig-2200-20261124    clang-24   smatch
sparc64              randconfig-r2104-20261124    clang-24   cocci
sparc64              randconfig-r2105-20261124    clang-24   cocci
sparc64              randconfig-r2105-20261124    gcc-16.2.0 cocci
sparc64              randconfig-r2107-20261123    clang-17   cocci
sparc64              randconfig-r2302-20261123    gcc-14.4.0 sparse
sparc64              randconfig-r2304-20261123    gcc-14.4.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261124    clang-24
um                    randconfig-1001-20261124    clang-24
um                    randconfig-2000-20261123    gcc-9.5.0
um                    randconfig-2000-20261124    gcc-8.5.0
um                    randconfig-2001-20261123    gcc-9.5.0
um                    randconfig-2001-20261124    gcc-8.5.0
um                    randconfig-2200-20261123    clang-21   smatch
um                    randconfig-2200-20261124    gcc-14     smatch
um                   randconfig-r2100-20261124    clang-24   cocci
um                   randconfig-r2108-20261124    gcc-10.5.0 cocci
um                   randconfig-r2109-20261123    gcc-14     cocci
um                   randconfig-r2109-20261124    clang-24   cocci
um                   randconfig-r2301-20261124    clang-24   sparse
um                   randconfig-r2305-20261124    clang-24   sparse
um                   randconfig-r2306-20261124    gcc-8.5.0  sparse
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
x86_64                randconfig-2100-20261123    clang-22   cocci
x86_64                randconfig-2100-20261124    gcc-14     cocci
x86_64                randconfig-2101-20261123    clang-22   cocci
x86_64                randconfig-2101-20261124    gcc-14     cocci
x86_64                randconfig-2102-20261123    clang-22   cocci
x86_64                randconfig-2102-20261124    gcc-14     cocci
x86_64                randconfig-2103-20261123    clang-22   cocci
x86_64                randconfig-2103-20261124    gcc-14     cocci
x86_64                randconfig-2104-20261123    clang-22   cocci
x86_64                randconfig-2104-20261124    gcc-14     cocci
x86_64                randconfig-2105-20261123    clang-22   cocci
x86_64                randconfig-2105-20261124    gcc-14     cocci
x86_64                randconfig-2200-20261123    gcc-14     smatch
x86_64                randconfig-2200-20261124    gcc-14     smatch
x86_64                randconfig-2300-20261123    gcc-14     sparse
x86_64                randconfig-2300-20261124    gcc-14     sparse
x86_64                randconfig-2301-20261123    gcc-14     sparse
x86_64                randconfig-2301-20261124    gcc-14     sparse
x86_64                randconfig-2302-20261123    gcc-14     sparse
x86_64                randconfig-2302-20261124    gcc-14     sparse
x86_64               randconfig-r2102-20261124    clang-24   cocci
x86_64               randconfig-r2102-20261124    gcc-12.5.0 cocci
x86_64               randconfig-r2105-20261123    gcc-8.5.0  cocci
x86_64               randconfig-r2302-20261124    clang-18   sparse
x86_64               randconfig-r2305-20261124    clang-18   sparse
x86_64               randconfig-r2309-20261124    gcc-14     sparse
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
xtensa                randconfig-1000-20261124    clang-24
xtensa                randconfig-1001-20261124    clang-24
xtensa                randconfig-2000-20261123    gcc-12.5.0
xtensa                randconfig-2000-20261124    gcc-16.2.0
xtensa                randconfig-2001-20261123    gcc-12.5.0
xtensa                randconfig-2001-20261124    gcc-16.2.0
xtensa                randconfig-2200-20261123    gcc-8.5.0  smatch
xtensa                randconfig-2200-20261124    gcc-9.5.0  smatch
xtensa               randconfig-r2107-20261124    gcc-16.2.0 cocci
xtensa               randconfig-r2111-20261124    clang-24   cocci

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
