Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596334CFD1
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983547; cv=none; b=lk/sPpvdHHJuMjM+MX/dGrN3KjJRDjFoKKS106lErKAYi6Q6wP0YFnntPOnxB2phve7SdAwbbawlJBZKBeatwC9Ihh/732XXxKSp9cSUN5FA95aAST5CvEzxibaT3CYe/TpV4IM01fbhwN6swAq/gUT+zwrtzvftGl/8nNtuuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983547; c=relaxed/simple;
	bh=7O2igdmsSSzrhB2hpxK4FYqwE3h3JPdCYQWZp1FWUmw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HjXRRQjhT35jYj2HyTnCbUMvZtrLD/upjbOkvvJamAm3K9mlVK4/8k2Tdrct0aLIq+22fzoRBGzmZXlUNg7C3ib71++KfoeZc8kbIYvWfjLomg7FUTwB+ecZGLV7iXQn34wE5J0yDVLcc1ExBWKtkz65WBOmtdovOwzT5x/qpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ca2SPpaj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ca2SPpaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780983545; x=1812519545;
  h=date:from:to:cc:subject:message-id;
  bh=7O2igdmsSSzrhB2hpxK4FYqwE3h3JPdCYQWZp1FWUmw=;
  b=Ca2SPpajbMtav9I6Lqlgqp7ZgjRQFW3mcFjbxqzC5g0L8cV59My3OSIh
   M9Ows7pXvpWoztsBqssfLtfRoPHabb9Qs2siOtf6HdnTL8yWj6BXl9VX5
   hIYpo25NdA1pIX/GpbDs1nmTZZZq1MBh4uSeofMaVdQD5XtW2xJKhNNLH
   4dunPlSw8L5sVxJrFDa1go1YJJ9KfHL5BBpZ7z9OdXEtJgiqhuanjpjnl
   LIstijqdTZM3GTqD5fYMIOkhbaPvAOZAFeXAqS2LAPrANQeEHuEa2WxJ3
   TPBFTKXSDFjnbi/2OISMAii+1Jpc9AfQDOJi+6Ey+Hzqm5nGOn1EcAKr2
   A==;
X-CSE-ConnectionGUID: F7oxECTzTzKomhSG3XVW0A==
X-CSE-MsgGUID: jUwbkxHtRR2mWqYBzJi2hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93120095"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93120095"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:39:04 -0700
X-CSE-ConnectionGUID: c289YDagTJa5JwecH6zcEw==
X-CSE-MsgGUID: 51HbjpiYScmsJB5SX9eWOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245798220"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Jun 2026 22:39:03 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wWpAy-00000000Jfq-1lIg;
	Tue, 09 Jun 2026 05:39:00 +0000
Date: Tue, 09 Jun 2026 13:38:11 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 5629eec1a2829871d496f3042884cdc267612f6a
Message-ID: <202606091303.BbW09ZYr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 5629eec1a2829871d496f3042884cdc267612f6a  cpufreq/amd-pstate: Fix setting EPP in performance mode

elapsed time: 9124m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-16.1.0
arm64        allmodconfig    clang-23
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-23
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-20
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-23
s390         allmodconfig    clang-23
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-23
um            allnoconfig    clang-16
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
