Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5C381EB5;
	Wed,  2 Sep 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371265; cv=none; b=ddwYzpIdd0tPXXiRzHiqzWUE9zNMulUFJOqT+kaACahEGVMeyGFb2l6nlZkmp4FXEGYjww3vIZ/oXK9/37DGrtSaV4X53UfkC+nM63h4C0h/CTI/qrfu8mHm7A7eN6EDpUJeBn1TiXKZRUZJ54622rZT+h9IMN3hxENy4fK1sIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371265; c=relaxed/simple;
	bh=IWgk0hsVjRXhlLhEWIxVCWRMRpovGs474qgm8wj4So0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hd4xZPLAFUCNyL0D8+f8HY4n+ww1s1hqpfQGrHewD+q+8j70lGKiDAzyVyUxuLsqdLs3Gxm2FwqZc9uTyo18JJ4PG/V6Qd1jj6GTIDcEUAkoEGHKh8TRSFF/+NPesmcqFEU00uc+aAiAhoLMNRpYeVEjF6Qd8Z/xz4tuoKRIiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmlInIoA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmlInIoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788371264; x=1819907264;
  h=date:from:to:cc:subject:message-id;
  bh=IWgk0hsVjRXhlLhEWIxVCWRMRpovGs474qgm8wj4So0=;
  b=jmlInIoAz2V9N8XGReCW4XJcyM+F68tH+jF4kS6R/X7AmuOjflzPy5ew
   HsBlIpLjBw19rcR1wc4FK5TUVaiXI4tDKGVYEjMMXsXD4PUXlKFBjFdaB
   PXN5+vRr4mDJ3Ml4p/56eWC6NpGZOoQMnAhoHNlTSrqGdJMcuVPf39ATG
   B+xB2VNgT+D73ljSeNeXMi6CrUQb0C0EeNCbl5XNIamjgsv9ZIgco1vzZ
   8BOYZWrmVVXruG/8Gj+cMFH+giU8d+mhY4NMwzX0Ki/gXzIPXfBQovyBx
   iyhQ38mIZK4ldj3YeRMqMbUV8tSQlZ1nNLFr7JGjMtFbYEcT+CvQ+idTr
   g==;
X-CSE-ConnectionGUID: wlSQ/e0lTaSthPyas0iNdg==
X-CSE-MsgGUID: cOW1XRjnTOeGhGkJUlkIuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88873776"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88873776"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 10:47:44 -0700
X-CSE-ConnectionGUID: yYmKtuXwRa+gLyXzasgYOA==
X-CSE-MsgGUID: a1WJh2JdRPCdEkr8txAU6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273237769"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Sep 2026 10:47:43 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1p3j-0000000035W-43xd;
	Wed, 02 Sep 2026 17:47:39 +0000
Date: Thu, 03 Sep 2026 01:46:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 208027d2c8957800e199a9e0f55da5fdb9550207
Message-ID: <202609030125.KSjl1YRt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 208027d2c8957800e199a9e0f55da5fdb9550207  Merge branch 'acpi-bus' into linux-next

elapsed time: 1317m

configs tested: 68
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    clang-24
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm64        allmodconfig    clang-24
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
loongarch    allmodconfig    clang-24
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
