Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A724B28;
	Mon, 24 Aug 2026 05:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548294; cv=none; b=fp9rHBIO2jRVIKoyGESi7zhuz7QMlM7RwMV3gIAFQXS/QIyKyV+BpCtuwBLJSjhZI+zvVsYjP27wtItxUF50uBEGw0t2dgABoIb4oKa+JpUTy1txRQ2bqupnSvLujzQCDCgG/ifc5Jpmnhx9MWKMIn+1wHmEtFbktAL4cPNfDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548294; c=relaxed/simple;
	bh=D1QJ7C7gJsZ5zCDUiZyvJvMTUPzU7QGuyoPVz2wr2N4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RhLuSrVDJaprYexJ2GnKux6ncDvOJxXyHPuB5m0uVWwIQ0bWxH7lbUVU8uo2bPacmK1zqNRCPhg1+l1Mh2IKUSzIG+G1AYNfU1ievgRmDqkpTH7HKNkLa1gEvbxeqRGQ0/HCudCOseyE5hUHGtfbQM9qKOsTQjJmr/BjXNqsIgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaVga5Qe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaVga5Qe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787548292; x=1819084292;
  h=date:from:to:cc:subject:message-id;
  bh=D1QJ7C7gJsZ5zCDUiZyvJvMTUPzU7QGuyoPVz2wr2N4=;
  b=SaVga5QembsRWpH2yykWmFhM0sehj6LX3d65MKUgr33SMxXXRHBphJi3
   rfTLeyhgWf2nZOPcK9Ym0G+X/ZGOkyfIoj36I7H9y4enSPoaim/9/3NuS
   sUrxMkYIm5Gv3y1uw+5TMuXFOPImpTjYH9CdBHCcTdD24cCSPTh78ivtX
   iKH1XXfGVXnqH3zyX+ISByY+kLlOgO8bhPDpkmCLjbNeYFIvZL7sRt2j9
   WkVogZ9XCkDjzmecxacJOiHSb4ZU7IW/7iVwl3+wrzkbP6ZQFLF1NXVW9
   OGBDnNk88mX4j4SskdvzhGZkLQGzfeNiTxty0thz/NN37TeWdheGLbnXn
   Q==;
X-CSE-ConnectionGUID: CRwwXU7SQnqR8sajLIDluw==
X-CSE-MsgGUID: 5VDMd22IRXiOZCr3FlhwrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91665431"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91665431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:11:32 -0700
X-CSE-ConnectionGUID: FO7t9gxrQVa1rY3LEs9lYw==
X-CSE-MsgGUID: bfjgpWfoTvq+VI2t/pExtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265115883"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Aug 2026 22:11:30 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyMxv-000000002C5-07GA;
	Mon, 24 Aug 2026 05:11:24 +0000
Date: Mon, 24 Aug 2026 13:09:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 361498477a97b6060e2441f64fc29da7b1e07eac
Message-ID: <202608241339.0y44z2vK-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 361498477a97b6060e2441f64fc29da7b1e07eac  Merge branch 'acpi-button' into bleeding-edge

elapsed time: 2941m

configs tested: 101
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                           randconfig-001    gcc-8.5.0
arc                  randconfig-001-20260822    gcc-14.3.0
arc                  randconfig-002-20260822    gcc-16.1.0
arm                  randconfig-001-20260822    gcc-16.1.0
arm                  randconfig-002-20260822    gcc-10.5.0
arm                  randconfig-003-20260822    gcc-12.5.0
arm                  randconfig-004-20260822    clang-24
arm                       spear6xx_defconfig    clang-24
arm64                randconfig-001-20260822    gcc-10.5.0
arm64                randconfig-002-20260822    gcc-12.5.0
arm64                randconfig-003-20260822    clang-24
arm64                randconfig-004-20260822    gcc-12.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260822    gcc-12.5.0
csky                 randconfig-002-20260822    gcc-14.3.0
hexagon              randconfig-001-20260823    clang-24
hexagon              randconfig-002-20260823    clang-17
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260823    gcc-12
i386       buildonly-randconfig-002-20260823    clang-22
i386       buildonly-randconfig-003-20260823    gcc-14
i386       buildonly-randconfig-004-20260823    gcc-14
i386       buildonly-randconfig-005-20260823    clang-22
i386       buildonly-randconfig-006-20260823    gcc-12
i386                 randconfig-001-20260822    gcc-14
i386                 randconfig-002-20260822    clang-22
i386                 randconfig-003-20260822    clang-22
i386                 randconfig-004-20260822    gcc-14
i386                 randconfig-005-20260822    clang-22
i386                 randconfig-006-20260822    clang-22
i386                 randconfig-007-20260822    clang-22
i386                 randconfig-011-20260822    gcc-14
i386                 randconfig-012-20260822    clang-22
i386                 randconfig-013-20260822    gcc-14
i386                 randconfig-014-20260822    gcc-14
i386                 randconfig-015-20260822    clang-22
i386                 randconfig-016-20260822    gcc-14
i386                 randconfig-017-20260822    gcc-12
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260823    clang-24
loongarch            randconfig-002-20260823    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260823    gcc-11.5.0
nios2                randconfig-002-20260823    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260822    gcc-15.2.0
parisc               randconfig-002-20260822    gcc-9.5.0
powerpc              randconfig-001-20260822    gcc-8.5.0
powerpc              randconfig-002-20260822    clang-24
powerpc64            randconfig-001-20260822    clang-24
powerpc64            randconfig-002-20260822    gcc-12.5.0
riscv                randconfig-001-20260823    gcc-8.5.0
riscv                randconfig-002-20260823    gcc-13.4.0
s390                 randconfig-001-20260823    gcc-10.5.0
s390                 randconfig-002-20260823    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260823    gcc-16.1.0
sh                   randconfig-002-20260823    gcc-11.5.0
sparc                         randconfig-001    gcc-16.1.0
sparc                randconfig-001-20260822    gcc-13.4.0
sparc                randconfig-002-20260822    gcc-15.2.0
sparc64              randconfig-001-20260822    gcc-8.5.0
sparc64              randconfig-002-20260822    clang-24
um                   randconfig-001-20260822    gcc-13
um                   randconfig-002-20260822    clang-24
x86_64     buildonly-randconfig-001-20260822    clang-22
x86_64     buildonly-randconfig-002-20260822    clang-22
x86_64     buildonly-randconfig-003-20260822    gcc-14
x86_64     buildonly-randconfig-004-20260822    gcc-14
x86_64     buildonly-randconfig-005-20260822    gcc-14
x86_64     buildonly-randconfig-006-20260822    clang-22
x86_64               randconfig-001-20260822    clang-22
x86_64               randconfig-002-20260822    clang-22
x86_64               randconfig-003-20260822    clang-22
x86_64               randconfig-004-20260822    clang-22
x86_64               randconfig-005-20260822    gcc-14
x86_64               randconfig-006-20260822    gcc-12
x86_64                        randconfig-011    gcc-14
x86_64               randconfig-011-20260822    gcc-14
x86_64               randconfig-012-20260822    clang-22
x86_64               randconfig-013-20260822    gcc-14
x86_64               randconfig-014-20260822    clang-22
x86_64               randconfig-015-20260822    clang-22
x86_64               randconfig-016-20260822    gcc-14
x86_64               randconfig-071-20260822    gcc-14
x86_64               randconfig-072-20260822    clang-22
x86_64               randconfig-073-20260822    gcc-13
x86_64               randconfig-074-20260822    clang-22
x86_64               randconfig-075-20260822    gcc-14
x86_64               randconfig-076-20260822    clang-22
xtensa               randconfig-001-20260822    gcc-9.5.0
xtensa               randconfig-002-20260822    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
