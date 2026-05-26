Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DF137418A;
	Tue, 26 May 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781931; cv=none; b=GDsvv5H/wGkUhgOdzEC0B6wcOSAHN+daqSR9n4Dg/utvXPKEoMRkzLcvDaAn4QcR28dULggrzMfiLgGv+nY2tErf50V817Yx0QRFFakvSZ3mHOuHRzPS/NHlJQobcSldnOA6cl7zLK7Xqruw8n4PIGr+YL8cx1PefK7XJajSuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781931; c=relaxed/simple;
	bh=tLQWlAxyvcYjblLPeqkMtnldMQIApj2Y0gv3/h5a13Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p0Uv9NpzJ9HoQ5rgBM91KVHG5P0fHXCnWCbjU/EIRVSHvl9h11GeVRWvJ4R6xuFa9hwIoupksOg6/5MFj5ukeNspVEbhbWDSEfP+S+n8d6NMNpYT8pPgLaT9XJ7gHQ1jZTKmaO3DtL1rQyJzINDVVriL5W20wah7f8CGefM+qLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4g0Lljy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4g0Lljy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779781931; x=1811317931;
  h=date:from:to:cc:subject:message-id;
  bh=tLQWlAxyvcYjblLPeqkMtnldMQIApj2Y0gv3/h5a13Y=;
  b=T4g0LljyNdE94voxCYKk3EarQ83YQvhaLnt/YrsR0Fx6Fct34yZu/Trl
   y6leeic/pxhPOs6jbnNqfJmS10R65pEskxVXXNMA61m7nQrABh6EZSd2F
   gnjibiDTh961ciq1xkWp9oMrnZ5GLbyuJWuovPLcYH8AVJXMFjUgXypon
   24j9CYUh5xzrIqhO+SaanXLi98lvX3xyJ2MqEPoiDSWqTpMWl+5LKIBu0
   CpJWn620nOPiCDOX4oHoWjRIcW3GI4UJNY3+cRZqFlantYAvBGrRoOOwH
   Bqc03NEOo6MRLSDlNsp7HvVZw6xR1q9057rq3iXBos0Webt24NDBOOE9/
   Q==;
X-CSE-ConnectionGUID: CU+q/GSARouCliBJ2qI0jA==
X-CSE-MsgGUID: 8gD62zXNRcu7XeoFfZvRVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84475361"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="84475361"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 00:52:10 -0700
X-CSE-ConnectionGUID: sfUoidulRky9Hi9fLhuCfA==
X-CSE-MsgGUID: wVPB7ynPRG6C9Pt+x3lvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246936508"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 May 2026 00:52:08 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wRma5-000000002EK-2qFc;
	Tue, 26 May 2026 07:52:05 +0000
Date: Tue, 26 May 2026 15:51:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 73c61caeee9538d702f458bbccc03849db673fab
Message-ID: <202605261514.4Js5tMpE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 73c61caeee9538d702f458bbccc03849db673fab  Merge branch 'acpi-button' into fixes

elapsed time: 946m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
