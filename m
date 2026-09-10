Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05425499F1D
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049262; cv=none; b=OtkSYBEuwPDZm2E9MChBbXoeCOQWfizPl8TWPxKodw9QLHPnUpaTKLdRTYg3Xy9jPbPVQvty+tfbYinnEKxS7WqRzAip55/eOG5LXgNeCdHgAupcfvobDljBMiqSvyQjAbq987DM2q7/AQyX2FYTtGtbIkyF768FDM8LGQQUE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049262; c=relaxed/simple;
	bh=oiUqkjRyqbRE1MSm/4v+vxuAVOWiZszSZlUCOY9PX5g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uikD9U+uI+39KPFmREFbx1YuGww5xwoIYtqmXMYH/nqJSl2o/i8ITgELelIYExZIlcqJHqBg66RbofgbzXrFgLeJvP3fXTr3GmKuwDXUVtt58WEypHSN+ZVyqUyLyuq5UZxkdq1wmHjDQLACVv7fXXp2M12lpHrGxxAKpiHMqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUS6gkwO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUS6gkwO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789049260; x=1820585260;
  h=date:from:to:cc:subject:message-id;
  bh=oiUqkjRyqbRE1MSm/4v+vxuAVOWiZszSZlUCOY9PX5g=;
  b=lUS6gkwO0gGmcHMLNgSe+IbHx6+KMnuZAPoQAuXESadAHzYksPv8bLwz
   YBD0uC6TNiH780qMgfMhy8h2lydwgkct9gfE/Y9RhJilYYHZvaG5nJ+6y
   8K8sqFR/QEwJAQXDqFQ4KfYpT2BbaR1+Gr5uud3VvWV5g/SMYNIyv7jcH
   /HGBjEKGlswNyax15f77vP4uE/UC0ooC93+ahNKWeE5OtPuzRZnEYuqTy
   SKZspNhAls54F5x9LBNzZqY5jK/qtqDkXGt4dZoKmmpkwYodIOqsNF2zN
   J0Q4+pvtmUVwDR4P2oH0Xp3XKe0oxpUZLIzIfdEUGhxHyXRk3a3fs7stN
   A==;
X-CSE-ConnectionGUID: FpziAIXfTUq7g+ZkRZcxlQ==
X-CSE-MsgGUID: w0gphhMAS++fGffPb5m54A==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="92014036"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="92014036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 07:06:37 -0700
X-CSE-ConnectionGUID: d6YnAavoTiKbLjjPyuJUiA==
X-CSE-MsgGUID: FoL9qM3nSiGmtOVOuwVOag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="269890121"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2026 07:06:36 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4fOs-0000000005j-48tz;
	Thu, 10 Sep 2026 14:05:48 +0000
Date: Thu, 10 Sep 2026 21:56:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 a23fca4ae137ec8e7620cc4f00b468b89cf5a7bd
Message-ID: <202609102103.b07zvNwB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: a23fca4ae137ec8e7620cc4f00b468b89cf5a7bd  cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq failure with 'Requested CPU Min frequency' BIOS option

elapsed time: 1032m

configs tested: 58
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-16.1.0
alpha         allyesconfig    gcc-16.1.0
arc           allmodconfig    clang-24
arc            allnoconfig    gcc-16.1.0
arc           allyesconfig    clang-24
arm            allnoconfig    gcc-16.1.0
arm           allyesconfig    clang-24
arm64         allmodconfig    clang-24
arm64          allnoconfig    gcc-16.1.0
csky          allmodconfig    gcc-16.1.0
csky           allnoconfig    gcc-16.1.0
hexagon       allmodconfig    gcc-16.1.0
hexagon        allnoconfig    gcc-16.1.0
i386          allmodconfig    clang-22
i386           allnoconfig    gcc-16.1.0
i386          allyesconfig    clang-22
loongarch     allmodconfig    clang-24
loongarch      allnoconfig    gcc-16.1.0
m68k          allmodconfig    gcc-16.1.0
m68k           allnoconfig    gcc-16.1.0
m68k          allyesconfig    clang-24
microblaze     allnoconfig    gcc-16.1.0
microblaze    allyesconfig    gcc-16.1.0
mips          allmodconfig    gcc-16.1.0
mips           allnoconfig    gcc-16.1.0
mips          allyesconfig    gcc-16.1.0
nios2         allmodconfig    clang-20
nios2          allnoconfig    clang-24
openrisc      allmodconfig    clang-20
openrisc       allnoconfig    clang-24
parisc        allmodconfig    gcc-16.1.0
parisc         allnoconfig    clang-24
parisc        allyesconfig    clang-17
powerpc       allmodconfig    gcc-16.1.0
powerpc        allnoconfig    clang-24
riscv         allmodconfig    clang-24
riscv          allnoconfig    clang-24
riscv         allyesconfig    clang-24
s390          allmodconfig    clang-17
s390           allnoconfig    clang-24
s390          allyesconfig    gcc-16.1.0
sh            allmodconfig    gcc-16.1.0
sh             allnoconfig    clang-24
sh            allyesconfig    clang-17
sparc          allnoconfig    clang-24
sparc64       allmodconfig    clang-20
um            allmodconfig    clang-17
um             allnoconfig    clang-24
um            allyesconfig    gcc-16.1.0
x86_64        allmodconfig    clang-22
x86_64         allnoconfig    clang-24
x86_64        allyesconfig    clang-22
x86_64        rhel-9.4-bpf    gcc-14
x86_64      rhel-9.4-kunit    gcc-14
x86_64        rhel-9.4-ltp    gcc-14
x86_64       rhel-9.4-rust    clang-22
xtensa         allnoconfig    clang-24
xtensa        allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
