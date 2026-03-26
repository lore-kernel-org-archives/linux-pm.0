Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055A3FB7D4;
	Thu, 26 Mar 2026 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539335; cv=none; b=fEJcFrCdoGNNmRoY4Jr9ZuGDq3j0yN2QXOusGAFMU2ju7Ef5nwuYKYRpwn18nkwDtFP4kIesJwuQIgRkTrn0CnDnuEaWj4UHIH11QP+9pZq1tWNv3qx9BsVSQYmgUWYrCtBHtv3+1Xett+fCqn3PiO2BGiXjXnWLaIum56+gBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539335; c=relaxed/simple;
	bh=sCsT0KA8h5jHWbmOypFfmoAnuC3WdR7kTa1TZawRlCU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BCH1AMII0mEa/lypQgC8qG0qS7kIZ87uwDjYx8qWL91N8c345mGSEQEX6HobmY+AexEYOyJnFPNUfp9HcwJSo3958nrPYwFVlLgv+kFJjnERpRMqDNlriT9O61+TSPpC1hQd3DTVyT6Iyoea8exopGCUlhdPek3Y4Pkm7hqKJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9/cg8Mc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9/cg8Mc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774539334; x=1806075334;
  h=date:from:to:cc:subject:message-id;
  bh=sCsT0KA8h5jHWbmOypFfmoAnuC3WdR7kTa1TZawRlCU=;
  b=D9/cg8McBXX0Ul8z0kTMOL4hYprjisEnJyYgWuArKWfqBhl069pX0ekq
   UedFQG0jNwqXg1cfmmGWWdRNXEdAqYi42SwOVxaZ/lyf6Kso2d0co2z5n
   M9A22k2jvADt2t0y0W/LgUu7elj3JorH9FZem6bw9U5r+Juf3cSddijEQ
   BqOIzzqfvt4UlMZqYAgaPji0ofs6Wr3zCcsGrJ42qH1HmzAyK7rUbrAB8
   YDyBCQhyuO+isOIPgHFA7K4iu+0zdssbAw5bvQ0+Bjc16U8oDhz0Bw7au
   yRAg9WHrSvsLaJD+6XHvv4+NIJLLygILhd3vf/7upDOj/INd8fviqhjtm
   g==;
X-CSE-ConnectionGUID: h8EIM8VJQPmhqgaSx60JSw==
X-CSE-MsgGUID: jJxswHRXRpKAhSv9DHGiLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86291616"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="86291616"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 08:35:34 -0700
X-CSE-ConnectionGUID: gPGkoQ1cQaS1tdjwRNRYVg==
X-CSE-MsgGUID: tvxBTxSIScWWI+9txNCgSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248082322"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 08:35:32 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5mk6-000000008y5-0UUy;
	Thu, 26 Mar 2026 15:35:30 +0000
Date: Thu, 26 Mar 2026 23:35:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3d6125a4ea0e7ef1b11fa4dbf7e98831ef166613
Message-ID: <202603262356.RovzFjsW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3d6125a4ea0e7ef1b11fa4dbf7e98831ef166613  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 1233m

configs tested: 156
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260326    gcc-13.4.0
arc                   randconfig-002-20260326    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260326    clang-23
arm                   randconfig-002-20260326    gcc-11.5.0
arm                   randconfig-003-20260326    gcc-10.5.0
arm                   randconfig-004-20260326    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260326    clang-19
arm64                 randconfig-002-20260326    clang-23
arm64                 randconfig-003-20260326    gcc-13.4.0
arm64                 randconfig-004-20260326    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260326    gcc-13.4.0
csky                  randconfig-002-20260326    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260326    clang-23
hexagon               randconfig-002-20260326    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260326    gcc-14
i386        buildonly-randconfig-002-20260326    clang-20
i386        buildonly-randconfig-003-20260326    gcc-14
i386        buildonly-randconfig-004-20260326    clang-20
i386        buildonly-randconfig-005-20260326    gcc-14
i386        buildonly-randconfig-006-20260326    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260326    clang-20
i386                  randconfig-002-20260326    gcc-14
i386                  randconfig-003-20260326    clang-20
i386                  randconfig-004-20260326    gcc-14
i386                  randconfig-005-20260326    gcc-14
i386                  randconfig-006-20260326    clang-20
i386                  randconfig-007-20260326    clang-20
i386                  randconfig-011-20260326    gcc-14
i386                  randconfig-012-20260326    gcc-14
i386                  randconfig-013-20260326    gcc-14
i386                  randconfig-014-20260326    gcc-14
i386                  randconfig-015-20260326    clang-20
i386                  randconfig-016-20260326    clang-20
i386                  randconfig-017-20260326    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260326    clang-18
loongarch             randconfig-002-20260326    gcc-14.3.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260326    gcc-9.5.0
nios2                 randconfig-002-20260326    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260326    gcc-12.5.0
parisc                randconfig-002-20260326    gcc-11.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260326    gcc-10.5.0
powerpc               randconfig-002-20260326    clang-19
powerpc64             randconfig-001-20260326    gcc-8.5.0
powerpc64             randconfig-002-20260326    clang-19
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260326    gcc-10.5.0
riscv                 randconfig-002-20260326    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260326    gcc-13.4.0
s390                  randconfig-002-20260326    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260326    gcc-15.2.0
sh                    randconfig-002-20260326    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260326    gcc-8.5.0
sparc                 randconfig-002-20260326    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260326    clang-23
sparc64               randconfig-002-20260326    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260326    gcc-14
um                    randconfig-002-20260326    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260326    gcc-14
x86_64      buildonly-randconfig-002-20260326    gcc-14
x86_64      buildonly-randconfig-003-20260326    clang-20
x86_64      buildonly-randconfig-004-20260326    clang-20
x86_64      buildonly-randconfig-005-20260326    gcc-14
x86_64      buildonly-randconfig-006-20260326    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260326    gcc-14
x86_64                randconfig-002-20260326    gcc-14
x86_64                randconfig-004-20260326    gcc-14
x86_64                randconfig-005-20260326    clang-20
x86_64                randconfig-011-20260326    gcc-14
x86_64                randconfig-012-20260326    gcc-14
x86_64                randconfig-013-20260326    gcc-14
x86_64                randconfig-014-20260326    gcc-12
x86_64                randconfig-015-20260326    gcc-14
x86_64                randconfig-016-20260326    gcc-12
x86_64                randconfig-071-20260326    clang-20
x86_64                randconfig-072-20260326    gcc-14
x86_64                randconfig-073-20260326    gcc-14
x86_64                randconfig-074-20260326    gcc-14
x86_64                randconfig-075-20260326    clang-20
x86_64                randconfig-076-20260326    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260326    gcc-11.5.0
xtensa                randconfig-002-20260326    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
