Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8E231829;
	Tue, 26 May 2026 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785054; cv=none; b=EpFFYGvyhsp+sPXatVyGtB/kqRvZlhF5CbjYGVQqypW8CPIj0OWMJm20ZXiTDbto1pQH3hdEoi8vaJNkHZUu2vcu3USGZr6Cz8YgwY7yGzzHvynNL/oQ2QQ/u6yZINhUwY5E1G8neYYMAb7JJ4/VmR8LQkRSrQc0D7VHDw2+W4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785054; c=relaxed/simple;
	bh=P1TTSb+W9oa+KvOKtQtNe5QY+x6v34i6rntYIM4q0Fg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IKCVl5Y76BG+W5hAjhCFUarw6+s5G/jIzdPxYHLELdNedL94Q/enI1KqaSHndJJUGBjf6CVayjNZXxtGwt9nS5DCRpA1d4bw63DrV836BpqvyrXRBjzPpZI/LVqavOMUtfVGP4p3q2mtL3VGbUbRvHqtxGCTJK7u8FJAzoy4TnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bew/DJkk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bew/DJkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779785052; x=1811321052;
  h=date:from:to:cc:subject:message-id;
  bh=P1TTSb+W9oa+KvOKtQtNe5QY+x6v34i6rntYIM4q0Fg=;
  b=bew/DJkkJQFNPUaAKKAIWGXH3gpWl+EYw19y9K/pcUpasP1NjSnf+iS/
   Bjz/a1aj+nN4Rk21l/fepgSOVZsk4VzKpCHN1jkKLPtjJRZJfuCbGPEpz
   a6gTkY6rIKc87+D+uezJxjqE61LNJ8/wGSnS7HKfKnJzuGEaSaJGV95Z1
   HldXBPyrmp1+TYIT+zYLBWllNQtLH6sdEJwPPRhgZZrj1ZYoPId93POlP
   XN5l3nzBBxRgXxCHvp2wmSZyQ91NfmId54VEqX+gxkJBYGffL1ATgNPiW
   +4Sz24XP+qJZXyGM2gWlIL05RE2QWtCkLPfCGg5rgfmpLQi36Rv1qK84A
   A==;
X-CSE-ConnectionGUID: UP7ZG1gATkmUtR3oNB6KKA==
X-CSE-MsgGUID: vfVwpx4UTK2U0VvGCzHQ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80563688"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80563688"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 01:44:12 -0700
X-CSE-ConnectionGUID: e8YYxvEZS/S6DsBHNBe9tg==
X-CSE-MsgGUID: UptraIbqQRGI7dYmcH9fdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="237670475"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 May 2026 01:44:10 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wRnOS-000000002Gk-0Sxy;
	Tue, 26 May 2026 08:44:08 +0000
Date: Tue, 26 May 2026 16:43:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 44d6101d610303d64d51b8366de0de0034cac61f
Message-ID: <202605261614.gH5niLEx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 44d6101d610303d64d51b8366de0de0034cac61f  Merge branch 'experimental/acpi-driver-work' into bleeding-edge

elapsed time: 998m

configs tested: 59
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
arm64       randconfig-002-20260526    gcc-8.5.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
csky        randconfig-001-20260526    gcc-15.2.0
csky        randconfig-002-20260526    gcc-13.4.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
loongarch   randconfig-001-20260526    gcc-15.2.0
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sh          randconfig-001-20260526    gcc-10.5.0
sparc                   allnoconfig    gcc-15.2.0
sparc64                allmodconfig    clang-23
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
