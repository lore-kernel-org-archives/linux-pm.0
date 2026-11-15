Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706086;
	b=jXK74dX65jziJ12zvlTaA1O/Ep/UqFW2Enz24FULTI/zLDdQH79ZpN/9kG1Xx+WFz/to
	 y7WLXBbGissyrrDOV3qnWv1R13XHtBf1jA8bDe1RsXhPeUM/3qFy883i69KYWdbfv3th0
	 AwnP3o8qg7NX2lnRVm++Do45yHgIJCpuLe0bvVNYFYWT2akNAD/psmf5J4M3H7yPM2TuO
	 xwkTWS8Oc+NrP5YuYR8pBvEkJwZzbkiOEK4AOTVgc7eGMwj/sECy4JdHZWZGvNJbHzeHx
	 jpmGDgS61co2o/LDyhP1Bb/5ReV8ZKMPtTv+IN83AG8IiqNtaJ8+U+HVkUlBNcj6JkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706086;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=cKZugUUXq7tkHGFMcg/VpXFhTOTki3WAmPBZYdcic94=;
	b=1RGD+ikCDg6PRKBO11yjc6Lj0FNsD1EvWPE9aqtdjfCaThxnAgG2U15O9Uktq73IkW/+
	 kEtqYyIyUbLmPDNZYVHkK9g2qQC9lcuPrFnRXRaBz8e+xTTS7Yr8mPWrJIbAILz3AJlPs
	 /BKiXvNvQ2FqF5S8Hb7TcHcZZig0YdXBuaG8tWbHoUU1f1FrmTujlKWVx+CIbIW7yLRCm
	 ouGIlDXpTbcm1Yf27BD/HuQq03+y73/dbN/F8RiXpwlysjpvuJejK96ni1ai2/Y9435nB
	 sMPR5ykOQFDk1SelARbgsYqRC61Lyhvarn5iPIy6Tcqc+y4g47kcaaP1lxtSA67UqpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=juySwPeW;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5778606A32D;
	Sun, 15 Nov 2026 01:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5778606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=juySwPeW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794706084; x=1826242084;
  h=date:from:to:cc:subject:message-id;
  bh=qLuktHp07kHCA30YpViWf8SFWV/4Leu5iT2Jk9F0ahs=;
  b=juySwPeWQQwEd3YyJ/6ZiRV/RT2HUPD8NXr0MolW3MKgukgYiyGBZMPD
   S7qmVYbL9E+SrvNBcbV2MnA7qQF8l8PZT4QZIBBUbPgYe5pUe7g37JOb7
   bEZl9H0/t0g/x2pIOFqKuezWf+5hiKHuLHoVh0espDpvF6ijrspEyt5u8
   CsOjpUKqi5q89c4jw4J/dJex29pGHjD/VxLaRORQVHkh+GuKngAO9X5IS
   aHo7SsXteygSKVQi0Fdkfqq6S6UvY4uaLX5tvtLXN9EvmZde0mlksy/jL
   UPmIOlghknK4afof0CZhIJEyL2KQRexkufQzJvs+b3xFtJtvbY2+tkQ+g
   A==;
X-CSE-ConnectionGUID: c0csCnvdRjKTGQwl3S2VWw==
X-CSE-MsgGUID: 485vWhE7RKKXQHG1kmGGIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3486917"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3486917"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 17:28:03 -0800
X-CSE-ConnectionGUID: Y+nqgIqvTFuhy6JqLBA6ew==
X-CSE-MsgGUID: v6nhrnrkQ42qPvvR5evDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9073822"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Nov 2026 17:28:03 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSP2G-000000016GK-01oB;
	Sun, 15 Nov 2026 01:28:00 +0000
Date: Sun, 15 Nov 2026 09:27:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 03176329b3f11ca2298f310a47486a5bd2f13d1d
Message-ID: <20261115092704.lnjCugTW-lkp@intel.com>
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
branch HEAD: 03176329b3f11ca2298f310a47486a5bd2f13d1d  Merge branches 'acpi-property', 'acpi-pfrut', 'acpi-sysfs' and 'acpi-battery' into bleeding-edge

elapsed time: 1045m

configs tested: 577
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                                defconfig    gcc-16.2.0
alpha                 randconfig-2000-20261114    gcc-12.5.0
alpha                 randconfig-2001-20261114    gcc-12.5.0
alpha                 randconfig-2200-20261114    gcc-9.5.0  smatch
alpha                randconfig-r2100-20261114    gcc-15.3.0 cocci
alpha                randconfig-r2101-20261114    clang-17   cocci
alpha                randconfig-r2104-20261114    gcc-12.5.0 cocci
alpha                randconfig-r2302-20261114    gcc-16.2.0 sparse
alpha                randconfig-r2303-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2305-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2306-20261114    gcc-13.5.0 sparse
alpha                randconfig-r2308-20261114    gcc-8.5.0  sparse
alpha                randconfig-r2309-20261114    clang-19   sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.2.0
arc                   randconfig-1000-20261115    gcc-11.5.0
arc                   randconfig-1001-20261115    gcc-11.5.0
arc                   randconfig-2000-20261114    gcc-11.5.0
arc                   randconfig-2001-20261114    gcc-11.5.0
arc                   randconfig-2002-20261114    gcc-11.5.0
arc                   randconfig-2003-20261114    gcc-11.5.0
arc                   randconfig-2004-20261114    gcc-11.5.0
arc                   randconfig-2005-20261114    gcc-11.5.0
arc                   randconfig-2200-20261114    gcc-8.5.0  smatch
arc                  randconfig-r2100-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2101-20261114    gcc-10.5.0 cocci
arc                  randconfig-r2101-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2102-20261114    gcc-12.5.0 cocci
arc                  randconfig-r2103-20261114    gcc-15.3.0 cocci
arc                  randconfig-r2108-20261114    clang-24   cocci
arc                  randconfig-r2301-20261114    gcc-16.2.0 sparse
arc                  randconfig-r2305-20261114    gcc-12.5.0 sparse
arc                  randconfig-r2306-20261114    gcc-8.5.0  sparse
arc                  randconfig-r2307-20261114    gcc-12.5.0 sparse
arc                  randconfig-r2311-20261114    gcc-15.3.0 sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                                  defconfig    gcc-16.2.0
arm                             dove_defconfig    clang-24
arm                           exynos_defconfig    clang-19
arm                         keystone_defconfig    clang-24
arm                             mps2_defconfig    clang-24
arm                         multi_v5_defconfig    clang-24
arm                   randconfig-1000-20261115    gcc-11.5.0
arm                   randconfig-1001-20261115    gcc-11.5.0
arm                   randconfig-1002-20261115    gcc-11.5.0
arm                   randconfig-1003-20261115    gcc-11.5.0
arm                   randconfig-2000-20261114    gcc-10.5.0
arm                   randconfig-2001-20261114    gcc-10.5.0
arm                   randconfig-2002-20261114    gcc-10.5.0
arm                   randconfig-2200-20261114    clang-17   smatch
arm                  randconfig-r2101-20261114    gcc-15.3.0 cocci
arm                  randconfig-r2102-20261114    gcc-14     cocci
arm                  randconfig-r2105-20261114    gcc-8.5.0  cocci
arm                  randconfig-r2106-20261114    clang-24   cocci
arm                  randconfig-r2110-20261114    gcc-10.5.0 cocci
arm                  randconfig-r2111-20261114    clang-24   cocci
arm                  randconfig-r2302-20261114    gcc-14.4.0 sparse
arm                  randconfig-r2303-20261114    clang-22   sparse
arm                  randconfig-r2305-20261114    clang-24   sparse
arm                  randconfig-r2309-20261114    clang-24   sparse
arm                  randconfig-r2310-20261114    clang-24   sparse
arm                  randconfig-r2311-20261114    gcc-8.5.0  sparse
arm                          s3c6400_defconfig    clang-19
arm                          socfpga_defconfig    clang-24
arm                         spear3xx_defconfig    clang-24
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                                defconfig    gcc-16.2.0
arm64                 randconfig-1000-20261115    gcc-16.2.0
arm64                 randconfig-1001-20261115    gcc-16.2.0
arm64                 randconfig-1002-20261115    gcc-16.2.0
arm64                 randconfig-1003-20261115    gcc-16.2.0
arm64                 randconfig-2000-20261114    gcc-10.5.0
arm64                 randconfig-2001-20261114    gcc-10.5.0
arm64                 randconfig-2002-20261114    gcc-10.5.0
arm64                 randconfig-2200-20261114    clang-17   smatch
arm64                randconfig-r2100-20261114    gcc-12.5.0 cocci
arm64                randconfig-r2101-20261114    gcc-14     cocci
arm64                randconfig-r2102-20261114    clang-17   cocci
arm64                randconfig-r2102-20261114    gcc-15.3.0 cocci
arm64                randconfig-r2103-20261114    clang-17   cocci
arm64                randconfig-r2103-20261114    clang-24   cocci
arm64                randconfig-r2104-20261114    clang-17   cocci
arm64                randconfig-r2107-20261114    gcc-14.4.0 cocci
arm64                randconfig-r2308-20261114    gcc-15.3.0 sparse
arm64                randconfig-r2310-20261114    clang-19   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                                 defconfig    clang-24
csky                                 defconfig    gcc-16.2.0
csky                  randconfig-1000-20261115    gcc-16.2.0
csky                  randconfig-1001-20261115    gcc-16.2.0
csky                  randconfig-2000-20261114    gcc-16.2.0
csky                  randconfig-2001-20261114    gcc-16.2.0
csky                  randconfig-2200-20261113    gcc-10.5.0 smatch
csky                  randconfig-2200-20261114    gcc-16.2.0 smatch
csky                 randconfig-r2103-20261114    gcc-12.5.0 cocci
csky                 randconfig-r2106-20261114    gcc-10.5.0 cocci
csky                 randconfig-r2107-20261114    clang-24   cocci
csky                 randconfig-r2108-20261114    clang-21   cocci
csky                 randconfig-r2109-20261114    clang-21   cocci
csky                 randconfig-r2302-20261114    gcc-16.2.0 sparse
csky                 randconfig-r2302-20261114    gcc-8.5.0  sparse
csky                 randconfig-r2306-20261114    clang-22   sparse
csky                 randconfig-r2307-20261114    clang-24   sparse
csky                 randconfig-r2307-20261114    gcc-13.5.0 sparse
csky                 randconfig-r2310-20261114    clang-22   sparse
csky                 randconfig-r2310-20261114    gcc-13.5.0 sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon                              defconfig    gcc-16.2.0
hexagon               randconfig-1000-20261114    clang-24
hexagon               randconfig-1000-20261115    clang-24
hexagon               randconfig-1001-20261114    clang-24
hexagon               randconfig-1001-20261115    clang-24
hexagon               randconfig-2000-20261114    gcc-16.2.0
hexagon               randconfig-2001-20261114    gcc-16.2.0
hexagon               randconfig-2200-20261114    clang-24   smatch
hexagon              randconfig-r2102-20261114    gcc-8.5.0  cocci
hexagon              randconfig-r2103-20261114    gcc-11.5.0 cocci
hexagon              randconfig-r2104-20261114    gcc-12.5.0 cocci
hexagon              randconfig-r2104-20261114    gcc-15.3.0 cocci
hexagon              randconfig-r2106-20261114    clang-24   cocci
hexagon              randconfig-r2108-20261114    clang-22   cocci
hexagon              randconfig-r2108-20261114    clang-24   cocci
hexagon              randconfig-r2109-20261114    clang-22   cocci
hexagon              randconfig-r2111-20261114    clang-17   cocci
hexagon              randconfig-r2111-20261114    gcc-10.5.0 cocci
hexagon              randconfig-r2301-20261114    gcc-12.5.0 sparse
hexagon              randconfig-r2306-20261114    gcc-11.5.0 sparse
hexagon              randconfig-r2311-20261114    clang-19   sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261115    clang-22
i386        buildonly-randconfig-1001-20261115    clang-22
i386        buildonly-randconfig-1002-20261115    clang-22
i386        buildonly-randconfig-1003-20261115    clang-22
i386        buildonly-randconfig-1004-20261115    clang-22
i386        buildonly-randconfig-1005-20261115    clang-22
i386                                 defconfig    gcc-16.2.0
i386                  randconfig-1000-20261115    clang-22
i386                  randconfig-1001-20261115    clang-22
i386                  randconfig-1002-20261115    clang-22
i386                  randconfig-1003-20261115    clang-22
i386                  randconfig-1004-20261115    clang-22
i386                  randconfig-1005-20261115    clang-22
i386                  randconfig-1006-20261115    clang-22
i386                  randconfig-1007-20261115    gcc-14
i386                  randconfig-1008-20261115    gcc-14
i386                  randconfig-1009-20261115    gcc-14
i386                  randconfig-1010-20261115    gcc-14
i386                  randconfig-1011-20261115    gcc-14
i386                  randconfig-1012-20261115    gcc-14
i386                  randconfig-1013-20261115    gcc-14
i386                  randconfig-2000-20261114    clang-22
i386                  randconfig-2001-20261114    clang-22
i386                  randconfig-2002-20261114    clang-22
i386                  randconfig-2003-20261114    clang-22
i386                  randconfig-2004-20261114    clang-22
i386                  randconfig-2005-20261114    clang-22
i386                  randconfig-2100-20261114    gcc-14     cocci
i386                  randconfig-2101-20261114    gcc-14     cocci
i386                  randconfig-2102-20261114    gcc-14     cocci
i386                  randconfig-2103-20261114    gcc-14     cocci
i386                  randconfig-2104-20261114    gcc-14     cocci
i386                  randconfig-2105-20261114    gcc-14     cocci
i386                  randconfig-2200-20261114    gcc-14     smatch
i386                  randconfig-2300-20261114    clang-22   sparse
i386                  randconfig-2301-20261114    clang-22   sparse
i386                  randconfig-2302-20261114    clang-22   sparse
i386                 randconfig-r2100-20261114    gcc-14     cocci
i386                 randconfig-r2101-20261114    gcc-12.5.0 cocci
i386                 randconfig-r2102-20261114    clang-22   cocci
i386                 randconfig-r2106-20261114    clang-22   cocci
i386                 randconfig-r2108-20261114    gcc-8.5.0  cocci
i386                 randconfig-r2109-20261114    gcc-10.5.0 cocci
i386                 randconfig-r2110-20261114    clang-21   cocci
i386                 randconfig-r2300-20261114    gcc-8.5.0  sparse
i386                 randconfig-r2302-20261114    clang-22   sparse
i386                 randconfig-r2306-20261114    clang-22   sparse
i386                 randconfig-r2309-20261114    clang-22   sparse
i386                 randconfig-r2310-20261114    clang-22   sparse
i386                 randconfig-r2311-20261114    clang-22   sparse
i386                 randconfig-r2311-20261114    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261114    clang-24
loongarch             randconfig-1000-20261115    clang-24
loongarch             randconfig-1001-20261114    clang-24
loongarch             randconfig-1001-20261115    clang-24
loongarch             randconfig-2000-20261114    gcc-11.5.0
loongarch             randconfig-2001-20261114    gcc-11.5.0
loongarch             randconfig-2200-20261114    clang-18   smatch
loongarch            randconfig-r2100-20261114    clang-17   cocci
loongarch            randconfig-r2105-20261114    gcc-11.5.0 cocci
loongarch            randconfig-r2105-20261114    gcc-12.5.0 cocci
loongarch            randconfig-r2105-20261114    gcc-14     cocci
loongarch            randconfig-r2109-20261114    clang-17   cocci
loongarch            randconfig-r2300-20261114    gcc-16.2.0 sparse
loongarch            randconfig-r2303-20261114    gcc-12.5.0 sparse
loongarch            randconfig-r2303-20261114    gcc-8.5.0  sparse
loongarch            randconfig-r2304-20261114    gcc-12.5.0 sparse
loongarch            randconfig-r2305-20261114    gcc-14.4.0 sparse
loongarch            randconfig-r2308-20261114    clang-24   sparse
loongarch            randconfig-r2309-20261114    clang-22   sparse
loongarch            randconfig-r2309-20261114    gcc-8.5.0  sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5249evb_defconfig    clang-24
m68k                         m5272c3_defconfig    clang-24
m68k                       m54418evb_defconfig    clang-24
m68k                           multi_defconfig    clang-19
m68k                  randconfig-2000-20261114    gcc-12.5.0
m68k                  randconfig-2001-20261114    gcc-12.5.0
m68k                  randconfig-2200-20261114    gcc-16.2.0 smatch
m68k                 randconfig-r2103-20261114    clang-22   cocci
m68k                 randconfig-r2104-20261114    gcc-11.5.0 cocci
m68k                 randconfig-r2107-20261114    clang-17   cocci
m68k                 randconfig-r2107-20261114    clang-24   cocci
m68k                 randconfig-r2110-20261114    clang-17   cocci
m68k                 randconfig-r2111-20261114    gcc-14.4.0 cocci
m68k                 randconfig-r2301-20261114    gcc-8.5.0  sparse
m68k                 randconfig-r2303-20261114    gcc-14.4.0 sparse
m68k                 randconfig-r2310-20261114    gcc-8.5.0  sparse
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261114    gcc-12.5.0
microblaze            randconfig-2001-20261114    gcc-12.5.0
microblaze            randconfig-2200-20261114    gcc-9.5.0  smatch
microblaze           randconfig-r2101-20261114    clang-22   cocci
microblaze           randconfig-r2102-20261114    gcc-11.5.0 cocci
microblaze           randconfig-r2109-20261114    gcc-8.5.0  cocci
microblaze           randconfig-r2111-20261114    clang-22   cocci
microblaze           randconfig-r2302-20261114    gcc-8.5.0  sparse
microblaze           randconfig-r2304-20261114    gcc-8.5.0  sparse
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                         bcm63xx_defconfig    clang-19
mips                            jazz_defconfig    clang-19
mips                  randconfig-2000-20261114    gcc-16.2.0
mips                  randconfig-2001-20261114    gcc-16.2.0
mips                  randconfig-2002-20261114    gcc-16.2.0
mips                  randconfig-2200-20261114    gcc-15.3.0 smatch
mips                 randconfig-r2100-20261114    clang-24   cocci
mips                 randconfig-r2105-20261114    gcc-11.5.0 cocci
mips                 randconfig-r2106-20261114    clang-17   cocci
mips                 randconfig-r2107-20261114    clang-24   cocci
mips                 randconfig-r2108-20261114    clang-17   cocci
mips                 randconfig-r2301-20261114    gcc-16.2.0 sparse
mips                 randconfig-r2303-20261114    gcc-12.5.0 sparse
mips                 randconfig-r2308-20261114    clang-19   sparse
mips                 randconfig-r2308-20261114    gcc-13.5.0 sparse
mips                 randconfig-r2309-20261114    gcc-12.5.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261114    clang-24
nios2                 randconfig-1000-20261115    clang-24
nios2                 randconfig-1001-20261114    clang-24
nios2                 randconfig-1001-20261115    clang-24
nios2                 randconfig-2000-20261114    gcc-11.5.0
nios2                 randconfig-2001-20261114    gcc-11.5.0
nios2                 randconfig-2200-20261114    gcc-11.5.0 smatch
nios2                randconfig-r2103-20261114    gcc-12.5.0 cocci
nios2                randconfig-r2105-20261114    clang-24   cocci
nios2                randconfig-r2105-20261114    gcc-12.5.0 cocci
nios2                randconfig-r2106-20261114    gcc-14.4.0 cocci
nios2                randconfig-r2109-20261114    gcc-8.5.0  cocci
nios2                randconfig-r2300-20261114    gcc-16.2.0 sparse
nios2                randconfig-r2301-20261114    clang-24   sparse
nios2                randconfig-r2304-20261114    gcc-12.5.0 sparse
nios2                randconfig-r2306-20261114    clang-24   sparse
nios2                randconfig-r2307-20261114    clang-22   sparse
nios2                randconfig-r2310-20261114    gcc-11.5.0 sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc              randconfig-2000-20261114    gcc-16.2.0
openrisc              randconfig-2001-20261114    gcc-16.2.0
openrisc              randconfig-2002-20261114    gcc-16.2.0
openrisc              randconfig-2200-20261113    gcc-14.4.0 smatch
openrisc              randconfig-2200-20261114    gcc-16.2.0 smatch
openrisc             randconfig-r2100-20261114    clang-22   cocci
openrisc             randconfig-r2101-20261114    gcc-15.3.0 cocci
openrisc             randconfig-r2102-20261114    gcc-12.5.0 cocci
openrisc             randconfig-r2104-20261114    gcc-10.5.0 cocci
openrisc             randconfig-r2106-20261114    clang-21   cocci
openrisc             randconfig-r2108-20261114    gcc-10.5.0 cocci
openrisc             randconfig-r2108-20261114    gcc-14.4.0 cocci
openrisc             randconfig-r2109-20261114    clang-24   cocci
openrisc             randconfig-r2110-20261114    clang-24   cocci
openrisc             randconfig-r2307-20261114    clang-19   sparse
openrisc             randconfig-r2307-20261114    gcc-11.5.0 sparse
openrisc             randconfig-r2307-20261114    gcc-15.3.0 sparse
openrisc             randconfig-r2309-20261114    gcc-13.5.0 sparse
openrisc             randconfig-r2311-20261114    gcc-12.5.0 sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                randconfig-1000-20261115    gcc-11.5.0
parisc                randconfig-1001-20261115    gcc-11.5.0
parisc                randconfig-2000-20261114    gcc-11.5.0
parisc                randconfig-2001-20261114    gcc-11.5.0
parisc                randconfig-2200-20261114    gcc-8.5.0  smatch
parisc               randconfig-r2100-20261114    gcc-10.5.0 cocci
parisc               randconfig-r2101-20261114    gcc-11.5.0 cocci
parisc               randconfig-r2103-20261114    gcc-15.3.0 cocci
parisc               randconfig-r2103-20261114    gcc-8.5.0  cocci
parisc               randconfig-r2110-20261114    gcc-8.5.0  cocci
parisc               randconfig-r2304-20261114    gcc-16.2.0 sparse
parisc               randconfig-r2305-20261114    gcc-8.5.0  sparse
parisc               randconfig-r2310-20261114    clang-24   sparse
parisc64                             defconfig    clang-24
powerpc                     adder875_defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc                     gamecube_defconfig    clang-19
powerpc                     ge_imp3a_defconfig    clang-24
powerpc                      mpc512x_defconfig    clang-24
powerpc                  mpc832x_rdb_defconfig    clang-24
powerpc                       pasemi_defconfig    clang-24
powerpc               randconfig-1000-20261115    gcc-11.5.0
powerpc               randconfig-1001-20261115    gcc-11.5.0
powerpc               randconfig-2000-20261114    gcc-8.5.0
powerpc               randconfig-2001-20261114    gcc-8.5.0
powerpc               randconfig-2002-20261114    gcc-8.5.0
powerpc               randconfig-2200-20261114    clang-24   smatch
powerpc              randconfig-r2100-20261114    gcc-15.3.0 cocci
powerpc              randconfig-r2100-20261114    gcc-8.5.0  cocci
powerpc              randconfig-r2101-20261114    clang-24   cocci
powerpc              randconfig-r2101-20261114    gcc-11.5.0 cocci
powerpc              randconfig-r2104-20261114    clang-24   cocci
powerpc              randconfig-r2105-20261114    gcc-10.5.0 cocci
powerpc              randconfig-r2107-20261114    clang-22   cocci
powerpc              randconfig-r2109-20261114    gcc-14.4.0 cocci
powerpc              randconfig-r2111-20261114    clang-24   cocci
powerpc              randconfig-r2301-20261114    gcc-8.5.0  sparse
powerpc              randconfig-r2306-20261114    gcc-12.5.0 sparse
powerpc              randconfig-r2306-20261114    gcc-15.3.0 sparse
powerpc              randconfig-r2308-20261114    clang-22   sparse
powerpc              randconfig-r2308-20261114    gcc-11.5.0 sparse
powerpc                      tqm8548_defconfig    clang-24
powerpc64             randconfig-1000-20261115    gcc-11.5.0
powerpc64             randconfig-1001-20261115    gcc-11.5.0
powerpc64             randconfig-2000-20261114    gcc-8.5.0
powerpc64             randconfig-2001-20261114    gcc-8.5.0
powerpc64             randconfig-2002-20261114    gcc-8.5.0
powerpc64             randconfig-2200-20261114    clang-17   smatch
powerpc64            randconfig-r2102-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-10.5.0 cocci
powerpc64            randconfig-r2103-20261114    gcc-11.5.0 cocci
powerpc64            randconfig-r2104-20261114    gcc-12.5.0 cocci
powerpc64            randconfig-r2105-20261114    clang-22   cocci
powerpc64            randconfig-r2106-20261114    clang-24   cocci
powerpc64            randconfig-r2109-20261114    clang-24   cocci
powerpc64            randconfig-r2110-20261114    clang-24   cocci
powerpc64            randconfig-r2300-20261114    gcc-12.5.0 sparse
powerpc64            randconfig-r2300-20261114    gcc-14.4.0 sparse
powerpc64            randconfig-r2305-20261114    gcc-16.2.0 sparse
powerpc64            randconfig-r2307-20261114    clang-24   sparse
powerpc64            randconfig-r2310-20261114    gcc-12.5.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                 randconfig-1000-20261114    gcc-15.3.0
riscv                 randconfig-1000-20261115    clang-24
riscv                 randconfig-1001-20261114    gcc-15.3.0
riscv                 randconfig-1001-20261115    clang-24
riscv                 randconfig-2000-20261114    gcc-12.5.0
riscv                 randconfig-2001-20261114    gcc-12.5.0
riscv                 randconfig-2002-20261114    gcc-12.5.0
riscv                 randconfig-2003-20261114    gcc-12.5.0
riscv                 randconfig-2004-20261114    gcc-12.5.0
riscv                 randconfig-2005-20261114    gcc-12.5.0
riscv                 randconfig-2200-20261114    clang-24   smatch
riscv                randconfig-r2101-20261114    gcc-12.5.0 cocci
riscv                randconfig-r2104-20261114    clang-22   cocci
riscv                randconfig-r2111-20261114    gcc-8.5.0  cocci
riscv                randconfig-r2300-20261114    clang-24   sparse
riscv                randconfig-r2309-20261114    gcc-11.5.0 sparse
riscv                randconfig-r2311-20261114    clang-22   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                  randconfig-1000-20261114    gcc-15.3.0
s390                  randconfig-1000-20261115    clang-24
s390                  randconfig-1001-20261114    gcc-15.3.0
s390                  randconfig-1001-20261115    clang-24
s390                  randconfig-2000-20261114    clang-24
s390                  randconfig-2001-20261114    clang-24
s390                  randconfig-2002-20261114    clang-24
s390                  randconfig-2003-20261114    clang-24
s390                  randconfig-2004-20261114    clang-24
s390                  randconfig-2005-20261114    clang-24
s390                  randconfig-2200-20261114    clang-24   smatch
s390                 randconfig-r2102-20261114    clang-24   cocci
s390                 randconfig-r2103-20261114    gcc-12.5.0 cocci
s390                 randconfig-r2107-20261114    gcc-8.5.0  cocci
s390                 randconfig-r2108-20261114    clang-24   cocci
s390                 randconfig-r2111-20261114    clang-21   cocci
s390                 randconfig-r2302-20261114    clang-24   sparse
s390                 randconfig-r2304-20261114    clang-22   sparse
s390                 randconfig-r2306-20261114    clang-19   sparse
s390                 randconfig-r2311-20261114    gcc-11.5.0 sparse
s390                 randconfig-r2311-20261114    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    clang-24
sh                                   defconfig    gcc-14
sh                              espt_defconfig    clang-24
sh                             hp6xx_defconfig    clang-19
sh                           r7785rp_defconfig    clang-24
sh                    randconfig-1000-20261114    gcc-15.3.0
sh                    randconfig-1000-20261115    clang-24
sh                    randconfig-1001-20261114    gcc-15.3.0
sh                    randconfig-1001-20261115    clang-24
sh                    randconfig-2000-20261114    gcc-13.5.0
sh                    randconfig-2001-20261114    gcc-13.5.0
sh                    randconfig-2002-20261114    gcc-13.5.0
sh                    randconfig-2003-20261114    gcc-13.5.0
sh                    randconfig-2004-20261114    gcc-13.5.0
sh                    randconfig-2005-20261114    gcc-13.5.0
sh                    randconfig-2200-20261114    gcc-9.5.0  smatch
sh                   randconfig-r2102-20261114    gcc-11.5.0 cocci
sh                   randconfig-r2102-20261114    gcc-15.3.0 cocci
sh                   randconfig-r2104-20261114    gcc-15.3.0 cocci
sh                   randconfig-r2105-20261114    gcc-12.5.0 cocci
sh                   randconfig-r2110-20261114    clang-22   cocci
sh                   randconfig-r2110-20261114    clang-24   cocci
sh                   randconfig-r2110-20261114    gcc-14.4.0 cocci
sh                   randconfig-r2302-20261114    gcc-12.5.0 sparse
sh                   randconfig-r2303-20261114    gcc-16.2.0 sparse
sh                   randconfig-r2304-20261114    clang-24   sparse
sh                   randconfig-r2304-20261114    gcc-14.4.0 sparse
sh                   randconfig-r2305-20261114    gcc-12.5.0 sparse
sh                   randconfig-r2307-20261114    gcc-8.5.0  sparse
sh                           sdk7786_defconfig    clang-19
sh                            se7206_defconfig    clang-24
sh                            se7343_defconfig    clang-24
sh                            se7750_defconfig    clang-24
sh                    sh7770_generic_defconfig    clang-24
sparc                              allnoconfig    clang-24
sparc                 randconfig-2000-20261113    clang-24
sparc                 randconfig-2000-20261114    clang-21
sparc                 randconfig-2001-20261113    clang-24
sparc                 randconfig-2001-20261114    clang-21
sparc                 randconfig-2200-20261114    gcc-8.5.0  smatch
sparc                randconfig-r2100-20261114    gcc-11.5.0 cocci
sparc                randconfig-r2105-20261114    gcc-15.3.0 cocci
sparc                randconfig-r2106-20261114    clang-24   cocci
sparc                randconfig-r2106-20261114    gcc-8.5.0  cocci
sparc                randconfig-r2107-20261114    gcc-8.5.0  cocci
sparc                randconfig-r2108-20261114    clang-24   cocci
sparc                randconfig-r2303-20261114    gcc-16.2.0 sparse
sparc                randconfig-r2304-20261114    gcc-16.2.0 sparse
sparc                randconfig-r2304-20261114    gcc-8.5.0  sparse
sparc                randconfig-r2305-20261114    clang-22   sparse
sparc                randconfig-r2307-20261114    gcc-8.5.0  sparse
sparc                randconfig-r2309-20261114    gcc-8.5.0  sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-2000-20261113    clang-24
sparc64               randconfig-2000-20261114    clang-21
sparc64               randconfig-2001-20261113    clang-24
sparc64               randconfig-2001-20261114    clang-21
sparc64               randconfig-2200-20261114    gcc-16.2.0 smatch
sparc64              randconfig-r2102-20261114    gcc-10.5.0 cocci
sparc64              randconfig-r2104-20261114    gcc-14     cocci
sparc64              randconfig-r2108-20261114    gcc-8.5.0  cocci
sparc64              randconfig-r2111-20261114    clang-24   cocci
sparc64              randconfig-r2301-20261114    clang-22   sparse
sparc64              randconfig-r2303-20261114    clang-24   sparse
sparc64              randconfig-r2308-20261114    clang-22   sparse
sparc64              randconfig-r2308-20261114    gcc-12.5.0 sparse
sparc64              randconfig-r2309-20261114    clang-24   sparse
sparc64              randconfig-r2311-20261114    gcc-13.5.0 sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-2000-20261113    clang-24
um                    randconfig-2000-20261114    clang-21
um                    randconfig-2001-20261113    clang-24
um                    randconfig-2001-20261114    clang-21
um                    randconfig-2200-20261114    gcc-14     smatch
um                   randconfig-r2104-20261114    gcc-8.5.0  cocci
um                   randconfig-r2107-20261114    clang-21   cocci
um                   randconfig-r2110-20261114    gcc-8.5.0  cocci
um                   randconfig-r2111-20261114    clang-24   cocci
um                   randconfig-r2111-20261114    gcc-8.5.0  cocci
um                   randconfig-r2301-20261114    gcc-14.4.0 sparse
um                   randconfig-r2308-20261114    clang-24   sparse
um                   randconfig-r2309-20261114    gcc-15.3.0 sparse
um                   randconfig-r2311-20261114    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261115    gcc-14
x86_64                randconfig-1001-20261115    gcc-14
x86_64                randconfig-1002-20261115    gcc-14
x86_64                randconfig-1003-20261115    gcc-14
x86_64                randconfig-1004-20261115    gcc-14
x86_64                randconfig-1005-20261115    gcc-14
x86_64                randconfig-1012-20261115    gcc-14
x86_64                randconfig-1013-20261115    gcc-14
x86_64                randconfig-1014-20261115    gcc-14
x86_64                randconfig-1015-20261115    gcc-14
x86_64                randconfig-1016-20261115    gcc-14
x86_64                randconfig-1017-20261115    gcc-14
x86_64                randconfig-2000-20261114    gcc-14
x86_64                randconfig-2001-20261114    gcc-14
x86_64                randconfig-2002-20261114    gcc-14
x86_64                randconfig-2003-20261114    gcc-14
x86_64                randconfig-2004-20261114    gcc-14
x86_64                randconfig-2005-20261114    gcc-14
x86_64                randconfig-2100-20261114    gcc-14     cocci
x86_64                randconfig-2101-20261114    gcc-14     cocci
x86_64                randconfig-2102-20261114    gcc-14     cocci
x86_64                randconfig-2103-20261114    gcc-14     cocci
x86_64                randconfig-2104-20261114    gcc-14     cocci
x86_64                randconfig-2105-20261114    gcc-14     cocci
x86_64                randconfig-2200-20261114    gcc-14     smatch
x86_64                randconfig-2300-20261114    clang-22   sparse
x86_64                randconfig-2301-20261114    clang-22   sparse
x86_64                randconfig-2302-20261114    clang-22   sparse
x86_64               randconfig-r2101-20261114    gcc-8.5.0  cocci
x86_64               randconfig-r2103-20261114    gcc-14     cocci
x86_64               randconfig-r2104-20261114    gcc-11.5.0 cocci
x86_64               randconfig-r2105-20261114    clang-17   cocci
x86_64               randconfig-r2105-20261114    gcc-15.3.0 cocci
x86_64               randconfig-r2109-20261114    clang-24   cocci
x86_64               randconfig-r2110-20261114    clang-24   cocci
x86_64               randconfig-r2300-20261114    gcc-12.5.0 sparse
x86_64               randconfig-r2300-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2306-20261114    gcc-8.5.0  sparse
x86_64               randconfig-r2307-20261114    clang-22   sparse
x86_64               randconfig-r2310-20261114    gcc-15.3.0 sparse
x86_64               randconfig-r2310-20261114    gcc-8.5.0  sparse
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
xtensa                randconfig-2000-20261114    gcc-16.2.0
xtensa                randconfig-2001-20261114    gcc-16.2.0
xtensa               randconfig-r2100-20261114    gcc-11.5.0 cocci
xtensa               randconfig-r2106-20261114    gcc-8.5.0  cocci
xtensa               randconfig-r2107-20261114    clang-24   cocci
xtensa               randconfig-r2107-20261114    gcc-10.5.0 cocci
xtensa               randconfig-r2109-20261114    clang-24   cocci
xtensa               randconfig-r2300-20261114    clang-22   sparse
xtensa               randconfig-r2301-20261114    gcc-12.5.0 sparse
xtensa               randconfig-r2305-20261114    gcc-16.2.0 sparse
xtensa               randconfig-r2306-20261114    clang-24   sparse

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
