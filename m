Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97C23392C;
	Sat,  1 Aug 2026 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785556272; cv=none; b=MvxeFig4xstuJgmyq27YxtJmdYdsj113HwAroWmNp/69klOBWaktKLQa5eQBKMkFc8gT6XVxxSe5F99BL9MJ+ICX851JMHTD+T4fLKBE/8KJF8ljPckA7eyJc4EofhfGW9INW1ufr0h+ZHGaNbfeB9s0kvtUs9iRHXUHXoYNsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785556272; c=relaxed/simple;
	bh=2W5ZN/G1PXsiAF9NJApqvpB1OlCDJiebRTjiHSOrwA4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mE7juswk5BCY7QeaXicntyWmxlVnzO94twleJuPTDKA8r4L3k+JC4pQOY8YUA3BzONt7JVaMV0a3M7Bk5YX8ZVopuPWjBlIAH+2KASArggu9ISuWLycf09AnNfJl2qttHMg3u69DqNVZ/ew8xaXfoSXK+ZqMworeC+N33Gf+w7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUw8DyfF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUw8DyfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785556270; x=1817092270;
  h=date:from:to:cc:subject:message-id;
  bh=2W5ZN/G1PXsiAF9NJApqvpB1OlCDJiebRTjiHSOrwA4=;
  b=mUw8DyfFOCqLnGGMMp+J8OZErt56m9+CL6HkHB+oUyPe+TWgMQxWijg/
   E6Mq/Nn4+Anyn2caajcmB5V0mv91Zm4QpSrpuBZrIq2JbJV3bJDEjLqZl
   J7c7j9BI9Y5CMncOWPsR+Fkl+jLappOpR99g7OsvdidlfyL85mIIk12qJ
   n2onkGnkLVKbx+FqoomaaeiGE7qeYCN2fzWdB1TPxVjov6srfqdpZ2tnq
   c3vxAHvltM8BjR6MTtrvgHkqroI5lxWPNR41iXAmKllZmwmpGp/IK8DMS
   o39J3gY1QB3D24IqFVA5LIfLSA9Ahsmf9Tr0XY7F5K/9LJCHPlPPDEdRQ
   g==;
X-CSE-ConnectionGUID: M3PA110eSpCWh6KLrHszlA==
X-CSE-MsgGUID: w2fIw0zYSN+T8PtIg25xSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="111731102"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="111731102"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 20:51:07 -0700
X-CSE-ConnectionGUID: 7HBSRMxgSCu4UWTeYB7pYw==
X-CSE-MsgGUID: yRI2Z/UOTPuf9pZBNgtYSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="254448018"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Jul 2026 20:51:05 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wq0kZ-000000002fr-2Lko;
	Sat, 01 Aug 2026 03:51:03 +0000
Date: Sat, 01 Aug 2026 11:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b2cc8158c9887f33de9cea29cfb400ebc35aacf2
Message-ID: <202608011104.Glmw06k3-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: b2cc8158c9887f33de9cea29cfb400ebc35aacf2  Merge branch 'acpi-processor' into bleeding-edge

elapsed time: 787m

configs tested: 86
configs skipped: 0

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
