Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB251E450;
	Mon,  7 Sep 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807643; cv=none; b=XerstbX/ZF8cWlJCPi8XnqSmgVLPK4Kwrvy82DGpqL44fOKkvLuaB7CKQhR4G4FM37yIMeCXAiPP0E/pd2Mc4a+82P4lu+PfGpBz7V6PaaSdxLKA4Chyn5N1UXAC8izNYPyfU3TWpLPR3Gh2FCjW0PNS29K4u4JOhPnqM6cqdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807643; c=relaxed/simple;
	bh=Q0WbFUvcYNqMyiLR/YrlQb4tSgmvMOnWLHBuOFEd/4o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fZyOY2wovoACr/nvSJFzDl2pC9LXFMYQSktQBJmdv5g8jVpTIWbgM5q69vit/YZS1V5NLWF8WRoGfPEHJogdaprjYUUHLIfbmzQq3A5b/CotgBhshrfXrpg486V9ugaSQ6VMhuN/KZHF2swCexcZ8YhNYIj1we31zuIZJxv2GmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJLIWS/q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJLIWS/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788807641; x=1820343641;
  h=date:from:to:cc:subject:message-id;
  bh=Q0WbFUvcYNqMyiLR/YrlQb4tSgmvMOnWLHBuOFEd/4o=;
  b=iJLIWS/qqMD+Y/Y4L+N6ojw6A9+OnDgaNQWRHWobO/aJgiM0br0zLoqD
   Vd1ocSfCrwnO4vP4R652CaoCyft0Poj/vfR2CtR+WZpphjyqDJbCv6xIs
   nxbwdL/F+4IyUgBhv+EteDDepWeTGq1mQ0edYHY9ckozWconHCnPzBAqV
   twzZmIpQrlr5Kp8sL8ACNgatJKGI5GtzdROuv9P6fzZrRR3jOQwlS506p
   mCd1jStuyP+UTY4RQxoe9BenuS79ekHMLNWNur+DVub/tcA0emTXwFcZm
   GbEXvRhJ6LrC3v+oxJ6hT3UGrwsDjjXqdterlGT7yZ3GnXsrHbf2K1qfO
   Q==;
X-CSE-ConnectionGUID: nu0P8nxgSyCmdT/jcwmneA==
X-CSE-MsgGUID: SCuErXngSoyNlI3zsBSa0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99805006"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="99805006"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 12:00:21 -0700
X-CSE-ConnectionGUID: B0jGQLK0RPepGAhtd5mIjA==
X-CSE-MsgGUID: MO8VA/52T8i0YWwPgYcdvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="270263844"
Received: from lkp-server01.sh.intel.com (HELO dff15f1b2031) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Sep 2026 12:00:20 -0700
Received: from kbuild by dff15f1b2031 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x3eZl-000000001G9-41Wm;
	Mon, 07 Sep 2026 19:00:17 +0000
Date: Tue, 08 Sep 2026 02:59:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 2ee5b4937c4dac356997169f3b49566fad45491e
Message-ID: <202609080220.FQ9eY0y9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 2ee5b4937c4dac356997169f3b49566fad45491e  Merge branch 'pm-cpufreq' into fixes

elapsed time: 4477m

configs tested: 65
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
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv        allmodconfig    clang-24
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
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
