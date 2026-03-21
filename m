Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEF3976AF;
	Sat, 21 Mar 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774108476; cv=none; b=YiUkqFiSF6uqxI79jCf8IQ1wkcAji5sCd6857VAxdO2c3ZhWRT1gOiUriG9byo1KPZGhRtIPkD3ZbssZjzqhpnaBxaz5FoXc1x3Dt1kAbinXKTlvvh3+/VMTljYhfB7otGcs8/hjptz7aZkhfFMM6bG3hDGl/XE0VelbJirhTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774108476; c=relaxed/simple;
	bh=p5Xq37Tq4otuskmHrwReMpu/9fT/YtSTV/k7jPPA3Yo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fgsgxk1ZQsjhNWnb3mKIkXbLRt8DoC5ux+DNGY77F69Fw0ooVUYCgg+F9D5N+fzBZruYKCfWtuF9kMqKWsAdwUYamK1fOimXV4/islIZ0A/4hRS5aKBLNofPlh/0FdvRtV+CFEtm3y23+RRgCbbbJGvk0+oki0nHRlKGtejY+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RK7DrGWX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RK7DrGWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774108473; x=1805644473;
  h=date:from:to:cc:subject:message-id;
  bh=p5Xq37Tq4otuskmHrwReMpu/9fT/YtSTV/k7jPPA3Yo=;
  b=RK7DrGWX6ULFqvqtEVuGnDLokVW0eE8a1/+7vU5T0TS0dGkrh1NywYP7
   iP3vxxEQyF6+wZWS87yroBicx0xHXB925oEgj7CUfNHv7Pb2SA8dxNTLg
   FlYMWJx3/0N73do6t1e58AehPmw02PglQLEEkLNCUh3QuynZH5EIAZ+NG
   yhLxRyesPZ2UEy+xM/YSWTmXSVqROqbHCM8yWBJdHFld8FlBEKKjneD4x
   TKf5WvLaKJEkTRxJDxybu7hbaMYrJ2NTx0nzomwvcKyp0cJe8d0yI4l0j
   iQRSl16g16Vbl+SNxJY8xxp9B7RohCM6JlrqxH18XGX7TJmpiTeR/Adcp
   A==;
X-CSE-ConnectionGUID: pW1Q2P71QbKkOVw9WRmgsQ==
X-CSE-MsgGUID: OX+iLnV7R42dBezGwi4C6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="85800538"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="85800538"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 08:54:32 -0700
X-CSE-ConnectionGUID: 4BSC3cWNQo+jvFlPZRs/Vg==
X-CSE-MsgGUID: 8KcWXWc6TXK1v24UBmgGqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="220859480"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Mar 2026 08:54:29 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3yeh-000000000xp-1K9W;
	Sat, 21 Mar 2026 15:54:27 +0000
Date: Sat, 21 Mar 2026 23:53:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 156256523dae66754586951efb08784d52c33968
Message-ID: <202603212335.k3hczyo0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 156256523dae66754586951efb08784d52c33968  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 1232m

configs tested: 120
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
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260321    clang-23
arm64                 randconfig-002-20260321    clang-23
arm64                 randconfig-003-20260321    gcc-9.5.0
arm64                 randconfig-004-20260321    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260321    gcc-15.2.0
csky                  randconfig-002-20260321    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260321    clang-23
hexagon               randconfig-002-20260321    clang-23
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260321    clang-20
i386        buildonly-randconfig-002-20260321    gcc-14
i386        buildonly-randconfig-003-20260321    gcc-14
i386        buildonly-randconfig-004-20260321    clang-20
i386        buildonly-randconfig-005-20260321    clang-20
i386        buildonly-randconfig-006-20260321    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260321    gcc-14
i386                  randconfig-002-20260321    gcc-14
i386                  randconfig-003-20260321    clang-20
i386                  randconfig-004-20260321    gcc-13
i386                  randconfig-006-20260321    gcc-14
loongarch                         allnoconfig    clang-23
loongarch             randconfig-001-20260321    gcc-15.2.0
loongarch             randconfig-002-20260321    clang-20
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260321    gcc-8.5.0
nios2                 randconfig-002-20260321    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260321    gcc-8.5.0
parisc                randconfig-002-20260321    gcc-9.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-002-20260321    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260321    gcc-15.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260321    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260321    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260321    gcc-15.2.0
sparc                 randconfig-002-20260321    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260321    clang-23
sparc64               randconfig-002-20260321    gcc-15.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260321    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260321    clang-20
x86_64                randconfig-002-20260321    gcc-14
x86_64                randconfig-003-20260321    clang-20
x86_64                randconfig-004-20260321    gcc-14
x86_64                randconfig-005-20260321    gcc-14
x86_64                randconfig-006-20260321    clang-20
x86_64                randconfig-011-20260321    gcc-13
x86_64                randconfig-012-20260321    gcc-14
x86_64                randconfig-013-20260321    clang-20
x86_64                randconfig-014-20260321    gcc-14
x86_64                randconfig-015-20260321    clang-20
x86_64                randconfig-016-20260321    clang-20
x86_64                randconfig-071-20260321    gcc-14
x86_64                randconfig-072-20260321    clang-20
x86_64                randconfig-073-20260321    gcc-13
x86_64                randconfig-074-20260321    gcc-14
x86_64                randconfig-075-20260321    clang-20
x86_64                randconfig-076-20260321    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
