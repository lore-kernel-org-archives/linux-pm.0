Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD12D2486
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172561; cv=none; b=uQPGAJFCnM/JAgIl1/ahqyic/hVIJSssHJH182rtvsdnte43AxyEHOF4bf2j9+KVAyQz671lVFcKcwLrBPdvBrs0vhBjEACQcFWRE0TahcqQuXXq+CiESoZC/KUvhQtg3EcJUSH7EB5mW5V1Xhub4+Ag88iamtlTQQGEEsEDRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172561; c=relaxed/simple;
	bh=lmDEBDjzWKYsp0GTgco2ipRw92G0z/BHSuc7fpZ8TJ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kfpVSv/E1qSqTbzKLOIkiXJO78JNFwB/DcKxnk+fyFVK1wG+QlXUgCfN9fb6SGIBXJRvh9BcMRQlB9Cy6c9oAV82DPID09cEurfRTq0IWDIYDLUcu8PDZYVktkqqDHOIKzb/KWF4S4WDQNMWoaFCuwTYrqNyXH4Z8+tLWe5Cg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hukZwVV9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hukZwVV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791172558; x=1822708558;
  h=date:from:to:cc:subject:message-id;
  bh=lmDEBDjzWKYsp0GTgco2ipRw92G0z/BHSuc7fpZ8TJ0=;
  b=hukZwVV9yQbcfq50gKHhfZNcpPhznsCYYa5+DRSrYmIaFT6B7SltQ4+U
   WbOXDKWxLjcJN1CJqzsXiIuCIC3IrMdLhiKgUweBPOJGreTKrxXtDRdxB
   Y5hXIGw2ZzWV1agOmtA9PKgqyfM55QPFntIwV7k70jZB61f5/YG92roZ9
   wuZQhHUXablZS5pQp8agfkRcU6zknIDfWwuA8ABX13RTsmbraAnndHyfj
   8/yiC2njPOiYv15GJ0YU24hLhs6kbJzSKJHIX0KB0u6rWweSs69fDRjck
   32DE2q1BY7xWCf4x4UdfySiGYDrn/EeEv+ldD9V47ItdqaQ5hWPpGRqx3
   g==;
X-CSE-ConnectionGUID: fi92s7sUQDOc5ciO3BhHkQ==
X-CSE-MsgGUID: Cxf8Qfb6SJii6c6ZM8CHJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="109324982"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="109324982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 20:55:57 -0700
X-CSE-ConnectionGUID: ZSRcgwEcRkas2rKRbuphDw==
X-CSE-MsgGUID: YYjYbgOnTJKlfJB/2rH3fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="275819812"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 04 Oct 2026 20:55:56 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDZnt-00000000VJp-46QF;
	Mon, 05 Oct 2026 03:55:53 +0000
Date: Mon, 05 Oct 2026 11:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 6b64d65c83688db2e58fbd9de7c74090f15271b7
Message-ID: <202610051144.AbIGeg71-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: 6b64d65c83688db2e58fbd9de7c74090f15271b7  cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6

elapsed time: 2781m

configs tested: 500
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2301-20261002    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261002    gcc-16.1.0 sparse
alpha                randconfig-r2307-20261002    gcc-13.4.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                         nsimosci_defconfig    gcc-16.1.0
arc                   randconfig-1000-20261004    clang-22
arc                   randconfig-1000-20261005    gcc-8.5.0
arc                   randconfig-1001-20261004    clang-22
arc                   randconfig-1001-20261005    gcc-8.5.0
arc                  randconfig-r2101-20261001    gcc-13.4.0 cocci
arc                  randconfig-r2102-20261001    gcc-13.4.0 cocci
arc                  randconfig-r2103-20261003    gcc-11.5.0 cocci
arc                  randconfig-r2301-20261003    gcc-14     sparse
arc                  randconfig-r2301-20261004    clang-24   sparse
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                        aspeed_g5_defconfig    gcc-16.1.0
arm                          bcm2835_defconfig    gcc-16.1.0
arm                                  defconfig    gcc-16.1.0
arm                            h3600_defconfig    gcc-16.1.0
arm                         keystone_defconfig    gcc-16.1.0
arm                   randconfig-1000-20261004    clang-22
arm                   randconfig-1000-20261005    gcc-8.5.0
arm                   randconfig-1001-20261004    clang-22
arm                   randconfig-1001-20261005    gcc-8.5.0
arm                   randconfig-1002-20261004    clang-22
arm                   randconfig-1002-20261005    gcc-8.5.0
arm                   randconfig-1003-20261004    clang-22
arm                   randconfig-1003-20261005    gcc-8.5.0
arm                  randconfig-r2102-20261005    gcc-13.4.0 cocci
arm                  randconfig-r2104-20261002    clang-21   cocci
arm                  randconfig-r2104-20261003    gcc-15.2.0 cocci
arm                  randconfig-r2106-20261002    clang-17   cocci
arm                  randconfig-r2200-20261002    gcc-8.5.0  smatch
arm                  randconfig-r2202-20261002    clang-24   smatch
arm                  randconfig-r2300-20261002    gcc-12.5.0 sparse
arm                  randconfig-r2303-20261005    gcc-11.5.0 sparse
arm                  randconfig-r2306-20261002    gcc-16.1.0 sparse
arm                            sama5_defconfig    gcc-16.1.0
arm                          wpcm450_defconfig    gcc-16.1.0
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261005    gcc-16.1.0
arm64                 randconfig-1001-20261005    gcc-16.1.0
arm64                 randconfig-1002-20261005    gcc-16.1.0
arm64                 randconfig-1003-20261005    gcc-16.1.0
arm64                randconfig-r2101-20261002    gcc-14     cocci
arm64                randconfig-r2101-20261002    gcc-8.5.0  cocci
arm64                randconfig-r2104-20261002    clang-17   cocci
arm64                randconfig-r2200-20261003    gcc-16.1.0 smatch
arm64                randconfig-r2300-20261001    gcc-9.5.0  sparse
arm64                randconfig-r2303-20261001    gcc-9.5.0  sparse
arm64                randconfig-r2309-20261002    gcc-16.1.0 sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261005    gcc-16.1.0
csky                  randconfig-1001-20261005    gcc-16.1.0
csky                 randconfig-r2106-20261003    gcc-15.2.0 cocci
csky                 randconfig-r2107-20261002    gcc-14     cocci
csky                 randconfig-r2201-20261002    gcc-9.5.0  smatch
csky                 randconfig-r2300-20261005    gcc-11.5.0 sparse
csky                 randconfig-r2305-20261001    gcc-9.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261004    gcc-16.1.0
hexagon               randconfig-1000-20261005    gcc-16.1.0
hexagon               randconfig-1001-20261004    gcc-16.1.0
hexagon               randconfig-1001-20261005    gcc-16.1.0
hexagon              randconfig-r2100-20261003    gcc-11.5.0 cocci
hexagon              randconfig-r2202-20261002    clang-18   smatch
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261004    clang-22
i386        buildonly-randconfig-1000-20261005    clang-22
i386        buildonly-randconfig-1001-20261004    clang-22
i386        buildonly-randconfig-1001-20261005    clang-22
i386        buildonly-randconfig-1002-20261004    clang-22
i386        buildonly-randconfig-1002-20261005    clang-22
i386        buildonly-randconfig-1003-20261004    clang-22
i386        buildonly-randconfig-1003-20261005    clang-22
i386        buildonly-randconfig-1004-20261004    clang-22
i386        buildonly-randconfig-1004-20261005    clang-22
i386        buildonly-randconfig-1005-20261004    clang-22
i386        buildonly-randconfig-1005-20261005    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261004    gcc-14
i386                  randconfig-1000-20261005    clang-22
i386                  randconfig-1001-20261004    gcc-14
i386                  randconfig-1001-20261005    clang-22
i386                  randconfig-1002-20261004    gcc-14
i386                  randconfig-1002-20261005    clang-22
i386                  randconfig-1003-20261004    gcc-14
i386                  randconfig-1003-20261005    clang-22
i386                  randconfig-1004-20261004    gcc-14
i386                  randconfig-1004-20261005    clang-22
i386                  randconfig-1005-20261004    gcc-14
i386                  randconfig-1005-20261005    clang-22
i386                  randconfig-1006-20261004    gcc-14
i386                  randconfig-1006-20261005    clang-22
i386                  randconfig-1007-20261005    clang-22
i386                  randconfig-1008-20261005    clang-22
i386                  randconfig-1009-20261005    clang-22
i386                  randconfig-1010-20261005    clang-22
i386                  randconfig-1011-20261005    clang-22
i386                  randconfig-1012-20261005    clang-22
i386                  randconfig-1013-20261005    clang-22
i386                  randconfig-2100-20261002    gcc-14     cocci
i386                  randconfig-2100-20261003    gcc-14     cocci
i386                  randconfig-2100-20261004    clang-22   cocci
i386                  randconfig-2101-20261002    gcc-14     cocci
i386                  randconfig-2101-20261003    gcc-14     cocci
i386                  randconfig-2101-20261004    clang-22   cocci
i386                  randconfig-2102-20261002    gcc-14     cocci
i386                  randconfig-2102-20261003    gcc-14     cocci
i386                  randconfig-2102-20261004    clang-22   cocci
i386                  randconfig-2103-20261002    gcc-14     cocci
i386                  randconfig-2103-20261003    gcc-14     cocci
i386                  randconfig-2103-20261004    clang-22   cocci
i386                  randconfig-2200-20261002    gcc-14     smatch
i386                  randconfig-2300-20261002    gcc-12     sparse
i386                  randconfig-2300-20261003    clang-22   sparse
i386                  randconfig-2301-20261002    gcc-12     sparse
i386                  randconfig-2301-20261003    clang-22   sparse
i386                  randconfig-2302-20261002    gcc-12     sparse
i386                  randconfig-2302-20261003    clang-22   sparse
i386                 randconfig-r2100-20261005    gcc-13.4.0 cocci
i386                 randconfig-r2202-20261005    clang-22   smatch
i386                 randconfig-r2304-20261002    clang-22   sparse
i386                 randconfig-r2304-20261005    gcc-11.5.0 sparse
i386                 randconfig-r2307-20261004    gcc-14.3.0 sparse
i386                 randconfig-r2308-20261002    gcc-12.5.0 sparse
i386                 randconfig-r2308-20261004    gcc-14.3.0 sparse
i386                 randconfig-r2309-20261002    gcc-13.4.0 sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261004    gcc-16.1.0
loongarch             randconfig-1000-20261005    gcc-16.1.0
loongarch             randconfig-1001-20261004    gcc-16.1.0
loongarch             randconfig-1001-20261005    gcc-16.1.0
loongarch            randconfig-r2105-20261004    gcc-16.1.0 cocci
loongarch            randconfig-r2303-20261002    gcc-12.5.0 sparse
loongarch            randconfig-r2305-20261004    clang-24   sparse
loongarch            randconfig-r2306-20261004    gcc-14.3.0 sparse
loongarch            randconfig-r2307-20261003    clang-24   sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                 randconfig-r2100-20261002    gcc-14     cocci
m68k                 randconfig-r2100-20261002    gcc-16.1.0 cocci
m68k                 randconfig-r2102-20261004    gcc-16.1.0 cocci
m68k                 randconfig-r2105-20261002    clang-17   cocci
m68k                 randconfig-r2106-20261002    gcc-12.5.0 cocci
m68k                 randconfig-r2300-20261004    clang-24   sparse
m68k                 randconfig-r2302-20261001    gcc-9.5.0  sparse
m68k                 randconfig-r2302-20261002    gcc-16.1.0 sparse
m68k                 randconfig-r2306-20261002    gcc-13.4.0 sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2102-20261002    clang-22   cocci
microblaze           randconfig-r2104-20261004    gcc-10.5.0 cocci
microblaze           randconfig-r2200-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2201-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2202-20261002    gcc-8.5.0  smatch
microblaze           randconfig-r2303-20261002    gcc-16.1.0 sparse
microblaze           randconfig-r2304-20261002    gcc-8.5.0  sparse
microblaze           randconfig-r2306-20261002    gcc-12.5.0 sparse
microblaze           randconfig-r2307-20261002    gcc-16.1.0 sparse
microblaze           randconfig-r2308-20261002    clang-22   sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                           ath79_defconfig    gcc-16.1.0
mips                         bcm47xx_defconfig    gcc-16.1.0
mips                      cu1000-neo_defconfig    gcc-16.1.0
mips                           malta_defconfig    gcc-16.1.0
mips                         maltaup_defconfig    gcc-16.1.0
mips                       pic32mzda_defconfig    gcc-16.1.0
mips                 randconfig-r2103-20261004    gcc-16.1.0 cocci
mips                 randconfig-r2105-20261002    clang-17   cocci
mips                 randconfig-r2200-20261004    gcc-15.2.0 smatch
mips                 randconfig-r2201-20261002    gcc-15.2.0 smatch
mips                 randconfig-r2300-20261003    gcc-14     sparse
mips                 randconfig-r2303-20261002    clang-22   sparse
mips                 randconfig-r2303-20261002    gcc-8.5.0  sparse
mips                            rs90_defconfig    gcc-16.1.0
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261004    gcc-16.1.0
nios2                 randconfig-1000-20261005    gcc-16.1.0
nios2                 randconfig-1001-20261004    gcc-16.1.0
nios2                 randconfig-1001-20261005    gcc-16.1.0
nios2                randconfig-r2100-20261002    gcc-8.5.0  cocci
nios2                randconfig-r2201-20261004    gcc-11.5.0 smatch
nios2                randconfig-r2300-20261002    gcc-8.5.0  sparse
nios2                randconfig-r2302-20261005    gcc-11.5.0 sparse
nios2                randconfig-r2309-20261004    gcc-14.3.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2104-20261002    gcc-14     cocci
openrisc             randconfig-r2104-20261004    gcc-16.1.0 cocci
openrisc             randconfig-r2105-20261002    clang-21   cocci
openrisc             randconfig-r2200-20261002    gcc-9.5.0  smatch
openrisc             randconfig-r2307-20261001    gcc-16.1.0 sparse
openrisc             randconfig-r2308-20261002    gcc-13.4.0 sparse
openrisc                  simple_smp_defconfig    gcc-16.1.0
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                 generic-64bit_defconfig    gcc-16.1.0
parisc                randconfig-1000-20261004    gcc-12.5.0
parisc                randconfig-1000-20261005    gcc-8.5.0
parisc                randconfig-1001-20261004    gcc-12.5.0
parisc                randconfig-1001-20261005    gcc-8.5.0
parisc               randconfig-r2100-20261004    gcc-16.1.0 cocci
parisc               randconfig-r2106-20261004    gcc-16.1.0 cocci
parisc               randconfig-r2107-20261002    gcc-12.5.0 cocci
parisc               randconfig-r2200-20261001    gcc-8.5.0  smatch
parisc               randconfig-r2303-20261004    clang-24   sparse
parisc               randconfig-r2304-20261002    gcc-16.1.0 sparse
parisc               randconfig-r2307-20261002    clang-22   sparse
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       katmai_defconfig    gcc-16.1.0
powerpc                    microwatt_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261004    gcc-12.5.0
powerpc               randconfig-1000-20261005    gcc-8.5.0
powerpc               randconfig-1001-20261004    gcc-12.5.0
powerpc               randconfig-1001-20261005    gcc-8.5.0
powerpc                      tqm8555_defconfig    gcc-16.1.0
powerpc64             randconfig-1000-20261004    gcc-12.5.0
powerpc64             randconfig-1000-20261005    gcc-8.5.0
powerpc64             randconfig-1001-20261004    gcc-12.5.0
powerpc64             randconfig-1001-20261005    gcc-8.5.0
powerpc64            randconfig-r2100-20261002    clang-22   cocci
powerpc64            randconfig-r2102-20261002    gcc-16.1.0 cocci
powerpc64            randconfig-r2302-20261002    gcc-8.5.0  sparse
powerpc64            randconfig-r2302-20261003    gcc-14     sparse
powerpc64            randconfig-r2309-20261002    clang-22   sparse
powerpc64            randconfig-r2309-20261003    clang-24   sparse
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261004    gcc-11.5.0
riscv                 randconfig-1000-20261005    clang-17
riscv                 randconfig-1001-20261004    gcc-11.5.0
riscv                 randconfig-1001-20261005    clang-17
riscv                 randconfig-2000-20261001    gcc-10.5.0
riscv                 randconfig-2000-20261002    gcc-9.5.0
riscv                 randconfig-2000-20261003    gcc-16.1.0
riscv                 randconfig-2000-20261004    gcc-11.5.0
riscv                 randconfig-2001-20261001    gcc-10.5.0
riscv                 randconfig-2001-20261002    gcc-9.5.0
riscv                 randconfig-2001-20261003    gcc-16.1.0
riscv                 randconfig-2001-20261004    gcc-11.5.0
riscv                randconfig-r2102-20261003    gcc-11.5.0 cocci
riscv                randconfig-r2103-20261002    clang-22   cocci
riscv                randconfig-r2103-20261002    gcc-14     cocci
riscv                randconfig-r2200-20261004    gcc-11.5.0 smatch
riscv                randconfig-r2202-20261004    clang-17   smatch
riscv                randconfig-r2300-20261002    clang-22   sparse
riscv                randconfig-r2300-20261002    gcc-16.1.0 sparse
riscv                randconfig-r2309-20261002    gcc-12.5.0 sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261004    gcc-11.5.0
s390                  randconfig-1000-20261005    clang-17
s390                  randconfig-1001-20261004    gcc-11.5.0
s390                  randconfig-1001-20261005    clang-17
s390                  randconfig-2000-20261001    gcc-10.5.0
s390                  randconfig-2000-20261002    gcc-9.5.0
s390                  randconfig-2000-20261003    gcc-16.1.0
s390                  randconfig-2000-20261004    gcc-11.5.0
s390                  randconfig-2001-20261001    gcc-10.5.0
s390                  randconfig-2001-20261002    gcc-9.5.0
s390                  randconfig-2001-20261003    gcc-16.1.0
s390                  randconfig-2001-20261004    gcc-11.5.0
s390                 randconfig-r2100-20261001    gcc-13.4.0 cocci
s390                 randconfig-r2101-20261002    clang-22   cocci
s390                 randconfig-r2101-20261002    gcc-16.1.0 cocci
s390                 randconfig-r2103-20261002    gcc-16.1.0 cocci
s390                 randconfig-r2106-20261002    clang-17   cocci
s390                 randconfig-r2302-20261002    gcc-12.5.0 sparse
s390                 randconfig-r2305-20261003    gcc-14     sparse
s390                 randconfig-r2308-20261001    gcc-16.1.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261004    gcc-11.5.0
sh                    randconfig-1000-20261005    clang-17
sh                    randconfig-1001-20261004    gcc-11.5.0
sh                    randconfig-1001-20261005    clang-17
sh                    randconfig-2000-20261001    gcc-10.5.0
sh                    randconfig-2000-20261002    gcc-9.5.0
sh                    randconfig-2000-20261003    gcc-16.1.0
sh                    randconfig-2000-20261004    gcc-11.5.0
sh                    randconfig-2001-20261001    gcc-10.5.0
sh                    randconfig-2001-20261002    gcc-9.5.0
sh                    randconfig-2001-20261003    gcc-16.1.0
sh                    randconfig-2001-20261004    gcc-11.5.0
sh                   randconfig-r2101-20261004    gcc-16.1.0 cocci
sh                   randconfig-r2107-20261002    clang-17   cocci
sh                   randconfig-r2201-20261002    gcc-12.5.0 smatch
sh                   randconfig-r2301-20261002    gcc-12.5.0 sparse
sh                   randconfig-r2305-20261005    gcc-11.5.0 sparse
sh                   randconfig-r2306-20261001    gcc-16.1.0 sparse
sh                   randconfig-r2306-20261003    clang-24   sparse
sh                   randconfig-r2307-20261002    gcc-12.5.0 sparse
sh                           rsk7201_defconfig    gcc-16.1.0
sh                   sh7785lcr_32bit_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261004    gcc-14
sparc                 randconfig-1000-20261005    clang-24
sparc                 randconfig-1001-20261004    gcc-14
sparc                 randconfig-1001-20261005    clang-24
sparc                 randconfig-2000-20261002    clang-24
sparc                 randconfig-2000-20261003    gcc-14
sparc                 randconfig-2000-20261004    clang-17
sparc                 randconfig-2001-20261002    clang-24
sparc                 randconfig-2001-20261003    gcc-14
sparc                 randconfig-2001-20261004    clang-17
sparc                randconfig-r2101-20261003    gcc-11.5.0 cocci
sparc                randconfig-r2102-20261002    gcc-8.5.0  cocci
sparc                randconfig-r2103-20261002    gcc-8.5.0  cocci
sparc                randconfig-r2201-20261002    gcc-8.5.0  smatch
sparc                randconfig-r2301-20261002    clang-22   sparse
sparc                randconfig-r2301-20261005    gcc-11.5.0 sparse
sparc                randconfig-r2305-20261002    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261004    gcc-14
sparc64               randconfig-1000-20261005    clang-24
sparc64               randconfig-1001-20261004    gcc-14
sparc64               randconfig-1001-20261005    clang-24
sparc64               randconfig-2000-20261002    clang-24
sparc64               randconfig-2000-20261003    gcc-14
sparc64               randconfig-2000-20261004    clang-17
sparc64               randconfig-2001-20261002    clang-24
sparc64               randconfig-2001-20261003    gcc-14
sparc64               randconfig-2001-20261004    clang-17
sparc64              randconfig-r2101-20261005    gcc-13.4.0 cocci
sparc64              randconfig-r2103-20261001    gcc-13.4.0 cocci
sparc64              randconfig-r2104-20261002    gcc-12.5.0 cocci
sparc64              randconfig-r2105-20261002    gcc-12.5.0 cocci
sparc64              randconfig-r2106-20261002    gcc-14     cocci
sparc64              randconfig-r2107-20261002    clang-17   cocci
sparc64              randconfig-r2107-20261004    gcc-10.5.0 cocci
sparc64              randconfig-r2200-20261002    gcc-15.2.0 smatch
sparc64              randconfig-r2301-20261001    gcc-9.5.0  sparse
sparc64              randconfig-r2305-20261002    clang-22   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261004    gcc-14
um                    randconfig-1000-20261005    clang-24
um                    randconfig-1001-20261004    gcc-14
um                    randconfig-1001-20261005    clang-24
um                    randconfig-2000-20261002    clang-24
um                    randconfig-2000-20261003    gcc-14
um                    randconfig-2000-20261004    clang-17
um                    randconfig-2001-20261002    clang-24
um                    randconfig-2001-20261003    gcc-14
um                    randconfig-2001-20261004    clang-17
um                   randconfig-r2105-20261004    gcc-10.5.0 cocci
um                   randconfig-r2107-20261002    clang-21   cocci
um                   randconfig-r2304-20261002    gcc-12.5.0 sparse
um                   randconfig-r2304-20261003    gcc-14     sparse
um                   randconfig-r2304-20261004    clang-24   sparse
um                   randconfig-r2305-20261002    gcc-12.5.0 sparse
um                   randconfig-r2308-20261002    gcc-16.1.0 sparse
um                   randconfig-r2308-20261003    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-22   checkkconfigsymbols
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64      buildonly-randconfig-1000-20261004    gcc-14
x86_64      buildonly-randconfig-1000-20261005    gcc-13
x86_64      buildonly-randconfig-1001-20261004    gcc-14
x86_64      buildonly-randconfig-1001-20261005    gcc-13
x86_64      buildonly-randconfig-1002-20261004    gcc-14
x86_64      buildonly-randconfig-1002-20261005    gcc-13
x86_64      buildonly-randconfig-1003-20261004    gcc-14
x86_64      buildonly-randconfig-1003-20261005    gcc-13
x86_64      buildonly-randconfig-1004-20261004    gcc-14
x86_64      buildonly-randconfig-1004-20261005    gcc-13
x86_64      buildonly-randconfig-1005-20261004    gcc-14
x86_64      buildonly-randconfig-1005-20261005    gcc-13
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261004    gcc-14
x86_64                randconfig-1000-20261005    gcc-14
x86_64                randconfig-1001-20261004    gcc-14
x86_64                randconfig-1001-20261005    gcc-14
x86_64                randconfig-1002-20261004    gcc-14
x86_64                randconfig-1002-20261005    gcc-14
x86_64                randconfig-1003-20261004    gcc-14
x86_64                randconfig-1003-20261005    gcc-14
x86_64                randconfig-1004-20261004    gcc-14
x86_64                randconfig-1004-20261005    gcc-14
x86_64                randconfig-1005-20261004    gcc-14
x86_64                randconfig-1005-20261005    gcc-14
x86_64                randconfig-1006-20261004    clang-22
x86_64                randconfig-1007-20261004    clang-22
x86_64                randconfig-1008-20261004    clang-22
x86_64                randconfig-1009-20261004    clang-22
x86_64                randconfig-1010-20261004    clang-22
x86_64                randconfig-1011-20261004    clang-22
x86_64                randconfig-1012-20261005    gcc-14
x86_64                randconfig-1013-20261005    gcc-14
x86_64                randconfig-1014-20261005    gcc-14
x86_64                randconfig-1015-20261005    gcc-14
x86_64                randconfig-1016-20261005    gcc-14
x86_64                randconfig-1017-20261005    gcc-14
x86_64                randconfig-2100-20261001    gcc-14     cocci
x86_64                randconfig-2100-20261002    gcc-14     cocci
x86_64                randconfig-2100-20261003    clang-22   cocci
x86_64                randconfig-2100-20261004    gcc-14     cocci
x86_64                randconfig-2101-20261001    gcc-14     cocci
x86_64                randconfig-2101-20261002    gcc-14     cocci
x86_64                randconfig-2101-20261003    clang-22   cocci
x86_64                randconfig-2101-20261004    gcc-14     cocci
x86_64                randconfig-2102-20261001    gcc-14     cocci
x86_64                randconfig-2102-20261002    gcc-14     cocci
x86_64                randconfig-2102-20261003    clang-22   cocci
x86_64                randconfig-2102-20261004    gcc-14     cocci
x86_64                randconfig-2103-20261001    gcc-14     cocci
x86_64                randconfig-2103-20261002    gcc-14     cocci
x86_64                randconfig-2103-20261003    clang-22   cocci
x86_64                randconfig-2103-20261004    gcc-14     cocci
x86_64                randconfig-2200-20261002    clang-22   smatch
x86_64                randconfig-2200-20261003    gcc-14     smatch
x86_64                randconfig-2200-20261004    gcc-14     smatch
x86_64                randconfig-2300-20261002    gcc-12     sparse
x86_64                randconfig-2300-20261003    clang-22   sparse
x86_64                randconfig-2301-20261002    gcc-12     sparse
x86_64                randconfig-2301-20261003    clang-22   sparse
x86_64                randconfig-2302-20261002    gcc-12     sparse
x86_64                randconfig-2302-20261003    clang-22   sparse
x86_64               randconfig-r2102-20261002    gcc-14     cocci
x86_64               randconfig-r2105-20261002    gcc-14     cocci
x86_64               randconfig-r2106-20261002    clang-21   cocci
x86_64               randconfig-r2201-20261003    clang-22   smatch
x86_64               randconfig-r2301-20261002    gcc-16.1.0 sparse
x86_64               randconfig-r2303-20261003    gcc-14     sparse
x86_64               randconfig-r2304-20261001    gcc-9.5.0  sparse
x86_64               randconfig-r2306-20261002    clang-22   sparse
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
xtensa                randconfig-1000-20261004    gcc-14
xtensa                randconfig-1000-20261005    clang-24
xtensa                randconfig-1001-20261004    gcc-14
xtensa                randconfig-1001-20261005    clang-24
xtensa                randconfig-2000-20261002    clang-24
xtensa                randconfig-2000-20261003    gcc-14
xtensa                randconfig-2000-20261004    clang-17
xtensa                randconfig-2001-20261002    clang-24
xtensa                randconfig-2001-20261003    gcc-14
xtensa                randconfig-2001-20261004    clang-17
xtensa               randconfig-r2103-20261005    gcc-13.4.0 cocci
xtensa               randconfig-r2105-20261003    gcc-15.2.0 cocci
xtensa               randconfig-r2106-20261004    gcc-10.5.0 cocci
xtensa               randconfig-r2107-20261003    gcc-15.2.0 cocci
xtensa               randconfig-r2107-20261004    gcc-16.1.0 cocci
xtensa               randconfig-r2201-20261004    gcc-13.4.0 smatch
xtensa               randconfig-r2202-20261002    gcc-9.5.0  smatch
xtensa               randconfig-r2302-20261002    clang-22   sparse
xtensa               randconfig-r2302-20261004    clang-24   sparse
xtensa               randconfig-r2309-20261001    gcc-16.1.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
