Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3B407107;
	Wed, 25 Mar 2026 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460245; cv=none; b=V2yEQAg26pMEaweWeR29D7VLPoOOPIfm4k6smt/xwG8youV/TKlCnrXqIDzX9mLlyddL9QxdDIH2ESh0tzi+TC4dw0oGWWwrWDL0uu3EWIcWRDUhFRMzKAsrP1aFsIHra39B93IQPqbp1iB+e3Ff1XOgfhuQMSZK1nT+GgCIeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460245; c=relaxed/simple;
	bh=p/fgokrH2AN55tfNwoCxAMr+6XsIyIZTChoqOYjEmMY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e+DeEJW+zZjqWaTWMGsZOu+t93Yo4t0Lza2QVdFC1P0CzHL5FcVrogYgahpfdC3LB2Y8Bl6JmoykVe6MhMBvSZl1s+ht2GiW0GZZqd7MOudyDPKT8MSlnG6M0TzinePwVcS8hc8xGA5p2xC9RCNTEPWeoC2fSeTTDUaxXljN1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKljfBYO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKljfBYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774460240; x=1805996240;
  h=date:from:to:cc:subject:message-id;
  bh=p/fgokrH2AN55tfNwoCxAMr+6XsIyIZTChoqOYjEmMY=;
  b=CKljfBYOgLjvWa64SwGNXGua02QpaFQlxBGDgHOwk5d3WAW8usETOVcJ
   86ylMtpKjT4FnHKo/84sAbLnIiFNwbCCU7oeu2HaTjrWvXDT0r6tXqWNx
   UmzE7khe8qGTI+oWzPFGewJxL3hexul0I125BcOkR6Kmj30u99ajWdpVj
   35eCmR4u9FGanYijTYPVbqRQB+yvvepfwEI72K7WRK2mExOtTlVJgQjnX
   rWzRDlwAiPJODAM8+zBdablFZSRCAi6vj2DDQ3DJ2TwiWASCJkOLB0HIX
   jp4uZfvSpsGpIx31OBq+DIxo+DKubxzLtxIpYpe+XU8ZNZ/9ouTeEno5J
   g==;
X-CSE-ConnectionGUID: Bk18dZP/QMCJWADalyHqlg==
X-CSE-MsgGUID: eIexSTu/Sjav8qU5r5wjNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86985670"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86985670"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 10:37:19 -0700
X-CSE-ConnectionGUID: 2IMAijpXR6SI68b5bNP9qA==
X-CSE-MsgGUID: /XgqxJAuQm+umuAKjGrIIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="226389218"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Mar 2026 10:37:17 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5SAM-000000007QL-1cvI;
	Wed, 25 Mar 2026 17:37:14 +0000
Date: Thu, 26 Mar 2026 01:37:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 877556758cf5718848fe4ff01c93109f51ce715b
Message-ID: <202603260154.xenzGRA1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 877556758cf5718848fe4ff01c93109f51ce715b  Merge branch 'experimental/acpi-driver-conversion' into bleeding-edge

elapsed time: 1258m

configs tested: 153
configs skipped: 10

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
arc                   randconfig-001-20260325    gcc-15.2.0
arc                   randconfig-002-20260325    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            mmp2_defconfig    gcc-15.2.0
arm                   randconfig-001-20260325    gcc-8.5.0
arm                   randconfig-002-20260325    clang-23
arm                   randconfig-003-20260325    clang-23
arm                   randconfig-004-20260325    clang-17
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260325    clang-23
arm64                 randconfig-002-20260325    gcc-11.5.0
arm64                 randconfig-003-20260325    gcc-8.5.0
arm64                 randconfig-004-20260325    clang-23
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260325    gcc-10.5.0
csky                  randconfig-002-20260325    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260325    clang-19
hexagon               randconfig-002-20260325    clang-23
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260325    gcc-14
i386        buildonly-randconfig-002-20260325    gcc-14
i386        buildonly-randconfig-003-20260325    clang-20
i386        buildonly-randconfig-004-20260325    clang-20
i386        buildonly-randconfig-005-20260325    clang-20
i386        buildonly-randconfig-006-20260325    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260325    clang-20
i386                  randconfig-002-20260325    clang-20
i386                  randconfig-003-20260325    gcc-14
i386                  randconfig-004-20260325    clang-20
i386                  randconfig-005-20260325    gcc-14
i386                  randconfig-006-20260325    clang-20
i386                  randconfig-007-20260325    clang-20
i386                  randconfig-011-20260325    gcc-14
i386                  randconfig-012-20260325    gcc-14
i386                  randconfig-013-20260325    gcc-14
i386                  randconfig-014-20260325    gcc-14
i386                  randconfig-015-20260325    clang-20
i386                  randconfig-016-20260325    clang-20
i386                  randconfig-017-20260325    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260325    clang-23
loongarch             randconfig-002-20260325    clang-23
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
nios2                 randconfig-001-20260325    gcc-8.5.0
nios2                 randconfig-002-20260325    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260325    gcc-8.5.0
parisc                randconfig-002-20260325    gcc-14.3.0
parisc64                            defconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260325    clang-23
powerpc               randconfig-002-20260325    clang-23
powerpc64             randconfig-001-20260325    clang-23
powerpc64             randconfig-002-20260325    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260325    clang-20
riscv                 randconfig-002-20260325    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                                defconfig    clang-23
s390                  randconfig-001-20260325    clang-23
s390                  randconfig-002-20260325    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260325    gcc-15.2.0
sh                    randconfig-002-20260325    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260325    gcc-8.5.0
sparc                 randconfig-002-20260325    gcc-14.3.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260325    clang-23
sparc64               randconfig-002-20260325    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260325    gcc-13
um                    randconfig-002-20260325    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260325    gcc-14
x86_64      buildonly-randconfig-002-20260325    gcc-14
x86_64      buildonly-randconfig-003-20260325    gcc-14
x86_64      buildonly-randconfig-004-20260325    gcc-14
x86_64      buildonly-randconfig-005-20260325    gcc-14
x86_64      buildonly-randconfig-006-20260325    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260325    gcc-14
x86_64                randconfig-002-20260325    gcc-14
x86_64                randconfig-003-20260325    clang-20
x86_64                randconfig-004-20260325    clang-20
x86_64                randconfig-005-20260325    gcc-14
x86_64                randconfig-006-20260325    gcc-12
x86_64                randconfig-011-20260325    clang-20
x86_64                randconfig-012-20260325    gcc-13
x86_64                randconfig-013-20260325    gcc-14
x86_64                randconfig-014-20260325    gcc-14
x86_64                randconfig-015-20260325    clang-20
x86_64                randconfig-016-20260325    gcc-13
x86_64                randconfig-071-20260325    clang-20
x86_64                randconfig-072-20260325    gcc-14
x86_64                randconfig-073-20260325    clang-20
x86_64                randconfig-074-20260325    gcc-14
x86_64                randconfig-075-20260325    gcc-14
x86_64                randconfig-076-20260325    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260325    gcc-13.4.0
xtensa                randconfig-002-20260325    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
