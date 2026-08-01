Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47F3346784;
	Sat,  1 Aug 2026 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785556329; cv=none; b=OKsSIHX5BULSxpL4IDUM4MtLUrROBHCnXInVlF83US6bs7LLoev4Lv8NfAfrZaRQJPYbuOxucaKR5Oxe/pKRDwhQWGkhnyaxQTshg4BKE6Uo3KFHE/XARCrJLEJl6I8BkIFLEo6i5tvqoite/g4rar/CVYHmaRvoY7Ol+JFzY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785556329; c=relaxed/simple;
	bh=pO/gzeSrMx3ODgvltjBuOnLkEkWhUHL0v5Yrmpjy1XU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=argwjnH7f/PJpSpAb4f6Vn0FCEsizCq14SplvTHaFn9H2dCvIdXuDkzAO6SNSCSc8g73ygnVRWOYkG4fUTUnICgcNL8+ZiacIDzn43+RYPULQoA8u7udv4qEIrWUuFET30V76Sy5b/IrBt3FT0PSB+kFYqjXWOoq1H4nq9ugXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8bK9Zh7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8bK9Zh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785556328; x=1817092328;
  h=date:from:to:cc:subject:message-id;
  bh=pO/gzeSrMx3ODgvltjBuOnLkEkWhUHL0v5Yrmpjy1XU=;
  b=c8bK9Zh72f8Q93UomPXLoTytDfDLiIDFJc3wgkXBWTuRMceMPKcgRDqT
   rpQQd3YrWCe/nq9ARs6JW/CDZASFffETbsBFppLnAR4+qDptG0urTQfzn
   26CwJRGt6LqYORm74DQclxEbG9LEH5DtLv5qsUjzFBIgWSPZMLjEDq+E4
   05z4OAN+J/cFqjiCuLByeuMZjfcpCHmH6ynulXvpM6IO5P4fsf+zuk2XZ
   bQp/EKxfGwFXWSejmLfjpnZE9mysvt3ap6rSnXaHFHM6tuvD8iQa6bZ8R
   LB1HZRNSLuPRExXdZY7JpcrdVgBwOhKlHr+xBioOOSS6dKkG+xcZTQU4L
   g==;
X-CSE-ConnectionGUID: 2r0tiikMRnGCZVQV2cPu5Q==
X-CSE-MsgGUID: B48l+c3JQhWR9X8vODVmMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="73715454"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="73715454"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 20:52:07 -0700
X-CSE-ConnectionGUID: TgGvahEFRtCzBGx/SklStw==
X-CSE-MsgGUID: 5AdY324jQHqb8DH7E1YsgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="265001034"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Jul 2026 20:52:06 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wq0lX-000000002g3-3Ouu;
	Sat, 01 Aug 2026 03:52:03 +0000
Date: Sat, 01 Aug 2026 11:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 cb62256854431c859778a70b6a1c2b2d45b0462e
Message-ID: <202608011136.C6LZpDFS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: cb62256854431c859778a70b6a1c2b2d45b0462e  Merge branch 'thermal-hwmon' into fixes

elapsed time: 788m

configs tested: 87
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260801    gcc-12.5.0
arc                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-001-20260801    gcc-12.5.0
arm                  randconfig-002-20260801    gcc-12.5.0
arm                  randconfig-003-20260801    gcc-12.5.0
arm                  randconfig-004-20260801    gcc-12.5.0
arm64                randconfig-001-20260801    gcc-10.5.0
arm64                randconfig-002-20260801    gcc-10.5.0
arm64                randconfig-003-20260801    gcc-10.5.0
arm64                randconfig-004-20260801    gcc-10.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260801    gcc-10.5.0
csky                 randconfig-002-20260801    gcc-10.5.0
hexagon              randconfig-001-20260801    gcc-16.1.0
hexagon              randconfig-002-20260801    gcc-16.1.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260801    gcc-14
i386       buildonly-randconfig-002-20260801    gcc-14
i386       buildonly-randconfig-003-20260801    gcc-14
i386       buildonly-randconfig-004-20260801    gcc-14
i386       buildonly-randconfig-005-20260801    gcc-14
i386       buildonly-randconfig-006-20260801    gcc-14
i386                 randconfig-011-20260801    gcc-14
i386                 randconfig-012-20260801    gcc-14
i386                 randconfig-013-20260801    gcc-14
i386                 randconfig-014-20260801    gcc-14
i386                 randconfig-015-20260801    gcc-14
i386                 randconfig-016-20260801    gcc-14
i386                 randconfig-017-20260801    gcc-14
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260801    gcc-16.1.0
loongarch            randconfig-002-20260801    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260801    gcc-16.1.0
nios2                randconfig-002-20260801    gcc-16.1.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260801    gcc-9.5.0
parisc               randconfig-002-20260801    gcc-9.5.0
powerpc                     bamboo_defconfig    clang-21
powerpc              randconfig-001-20260801    gcc-9.5.0
powerpc              randconfig-002-20260801    gcc-9.5.0
powerpc64            randconfig-001-20260801    gcc-9.5.0
powerpc64            randconfig-002-20260801    gcc-9.5.0
riscv                randconfig-001-20260801    gcc-14.3.0
riscv                randconfig-002-20260801    gcc-14.3.0
s390                 randconfig-001-20260801    gcc-14.3.0
s390                 randconfig-002-20260801    gcc-14.3.0
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260801    gcc-14.3.0
sh                   randconfig-002-20260801    gcc-14.3.0
sparc                randconfig-001-20260801    gcc-11.5.0
sparc                randconfig-002-20260801    gcc-11.5.0
sparc64                         alldefconfig    gcc-16.1.0
sparc64              randconfig-001-20260801    gcc-11.5.0
sparc64              randconfig-002-20260801    gcc-11.5.0
um                   randconfig-001-20260801    gcc-11.5.0
um                   randconfig-002-20260801    gcc-11.5.0
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260801    gcc-14
x86_64               randconfig-002-20260801    gcc-14
x86_64               randconfig-003-20260801    gcc-14
x86_64               randconfig-004-20260801    gcc-14
x86_64               randconfig-005-20260801    gcc-14
x86_64               randconfig-006-20260801    gcc-14
x86_64               randconfig-011-20260801    clang-22
x86_64               randconfig-012-20260801    clang-22
x86_64               randconfig-013-20260801    clang-22
x86_64               randconfig-014-20260801    clang-22
x86_64               randconfig-015-20260801    clang-22
x86_64               randconfig-016-20260801    clang-22
x86_64               randconfig-071-20260801    clang-22
x86_64               randconfig-072-20260801    clang-22
x86_64               randconfig-073-20260801    clang-22
x86_64               randconfig-074-20260801    clang-22
x86_64               randconfig-075-20260801    clang-22
x86_64               randconfig-076-20260801    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260801    gcc-11.5.0
xtensa               randconfig-002-20260801    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
