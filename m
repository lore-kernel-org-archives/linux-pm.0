Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB223385D6A;
	Thu, 10 Sep 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053664; cv=none; b=JSZBXQKM/47AP6CA9DZoO8piK7YxIhTu3XuZHYHjcEP6gAmYjKeP7SDnSGiuzkSJdLNrN9oatnlFdIdeR0zkWjdHjH5Md7XmQU4PpRW1r5gj/wetom4I0zH1X2sTNiJyqYbjjThNMumlgJohSXqGQSXzBPVC6O3sb2QgmBOw274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053664; c=relaxed/simple;
	bh=rxLjR7TqBBK7IbwLSXQhqpihy8bN+l65yZrGiqQRGQI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WdG0lrvpayMlOybsA1Xd0MX4QNlSrjoeShBwoiVtkzH7nXIA15HzK4UbbBfLb4MiFCxb7b8SU42WkSQ9zVvrG7akXO5zWowvsLK/hygTqhWDJALVYt04UzvUS/mCNLmDYs/eGUvN2kk0CQws6zDVrip8vPcq76E3LO8XEAwUOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkSayVsn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkSayVsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789053659; x=1820589659;
  h=date:from:to:cc:subject:message-id;
  bh=rxLjR7TqBBK7IbwLSXQhqpihy8bN+l65yZrGiqQRGQI=;
  b=BkSayVsnf0Ruupy/hVzT4zCJ/U7AlW0rZUQbK+Z7l6f41TUKZ/VaPTDD
   gNulb7p0hoBS8I9GGNNZyy+bVFqrCx5942aKDCH3B1A6HuXxpS4bBImsc
   n2btYWQh70zBmIvI5uDRguoHU4gru4ZS4jRoBrLXm5oocv29GfZtcw2h+
   nsQil/qaWuakVDVLy/Cg5Et6f4A2qKG6K7hT5uHSyijfORReKf2pzHtd4
   DblzGyHUZNudsIaM7zFefD6MMK6w9l10D594jEZf4FNAo66Zp7JAyQVP8
   8lV+DaCO/+TTwfHnIwQ4gTL2ZwKccE7SOBAHqs60/GmA3spGIApP0oZy2
   Q==;
X-CSE-ConnectionGUID: Fam8KVXKQGCvMHPxIW4O+w==
X-CSE-MsgGUID: kKMJ4KNbTYSM7V0b2F2neQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89350000"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89350000"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:20:54 -0700
X-CSE-ConnectionGUID: oxpjUNTXQs+WpxcZ5mYb3A==
X-CSE-MsgGUID: 1Uky8/i7RQe3n6VeZm+r/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="296650522"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 10 Sep 2026 08:20:53 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4ga2-000000000Cw-26m4;
	Thu, 10 Sep 2026 15:20:50 +0000
Date: Thu, 10 Sep 2026 23:05:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 52f7a75969b0f4c42746d9a563f4f83429738d42
Message-ID: <202609102358.EZiDL9yv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 52f7a75969b0f4c42746d9a563f4f83429738d42  Merge branches 'pm-cpufreq' and 'pm-opp' into fixes

elapsed time: 1312m

configs tested: 63
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
hexagon       allmodconfig    clang-24
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
parisc        allyesconfig    gcc-16.1.0
powerpc       allmodconfig    gcc-16.1.0
powerpc        allnoconfig    clang-24
riscv         allmodconfig    clang-24
riscv          allnoconfig    clang-24
riscv         allyesconfig    clang-24
s390          allmodconfig    clang-17
s390          allmodconfig    clang-24
s390           allnoconfig    clang-24
s390          allyesconfig    gcc-16.1.0
sh            allmodconfig    gcc-16.1.0
sh             allnoconfig    clang-24
sh            allyesconfig    clang-17
sh            allyesconfig    gcc-16.1.0
sparc          allnoconfig    clang-24
sparc64       allmodconfig    clang-20
um            allmodconfig    clang-17
um             allnoconfig    clang-24
um            allyesconfig    gcc-14
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
