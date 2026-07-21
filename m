Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039D221FC6
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637182; cv=none; b=Vnd9p23pKMbROlr5dhqOmF4yG3m4X/OTLgx2skVlVBKFQ5CMKa2gPuKpFra6NR9DBO+gzr6YX07kCSKRZ+7cB314pcZMFuw55wwXY75ilSyDr/XRUQpML2jtP31UzQD9dXk2ekG6onnBMjm4Ks3o/Hy7DXBWaQQc/M6jOl7VAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637182; c=relaxed/simple;
	bh=Zifw3WYIrbU8l8r+PP39sHeSxxlE58PEqtFFaF5Csb8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RD+oaw21ubkKDARZKU2c3D8oJgBIIDTMtlQI1fLq7kIrfW1kYvvRMWOHlsWB3CJ3MXqcVnTi62gCxAEKs1xVdWnSkAlfNPKLIHCp4+HDDhkMv5FVlXxmEtr0xaVw8SsDBChJiF9c3R/id8xE84lmdEdDGQM5DhH+qL0teKar0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG/Q4CMk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG/Q4CMk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784637181; x=1816173181;
  h=date:from:to:cc:subject:message-id;
  bh=Zifw3WYIrbU8l8r+PP39sHeSxxlE58PEqtFFaF5Csb8=;
  b=HG/Q4CMkoB4XAVlyYAjSLntO5Kw5jXZMHNl9QuDWRQsLoBDqXGv1gIvt
   XU5yXoJDP6yzXxdVUQQA5JQ+RBYIwPcShIK8vIoqvwoSHeaVC84vCUmqu
   tYpXO1C1hoGq1VKj16KGU/K4Oqh9mPKFXm5+SVoZupIwOKr33Vi+EbnRu
   MCPhUBca+57VmfLZCzdIM2nx+5+vQsnHV0KtCrDCU/NthY0kWQOIq8dAu
   V3nt05lLHFXs8Ag/qlwMp5KI3jnxfaiCqKZNwzNwlGuLsyvdsEG/8cA6p
   34bCX4t54Y/b53zRj/lJZhgJYt0uNHArSmvJEzwtrurFx1VCBg0DH3Rs8
   A==;
X-CSE-ConnectionGUID: O5J/dGI0TvSgs+QqV46Chw==
X-CSE-MsgGUID: DyNCfnVxTT+f2XLTlbeogA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110786316"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="110786316"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 05:33:00 -0700
X-CSE-ConnectionGUID: Tw9RhKBST8uWlcnEQtRCzQ==
X-CSE-MsgGUID: 7OSpl0+pR86Y3/0Wzu+zvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="282258136"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Jul 2026 05:32:58 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wm9ea-00000000XaB-2pcL;
	Tue, 21 Jul 2026 12:32:56 +0000
Date: Tue, 21 Jul 2026 20:32:30 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 eb21749db7127a4e8a9eca8a9ac14c8cb0b90af8
Message-ID: <202607212017.y2plBCKg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: eb21749db7127a4e8a9eca8a9ac14c8cb0b90af8  cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks

elapsed time: 761m

configs tested: 26
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-16.1.0
alpha                  allyesconfig    gcc-16.1.0
alpha                     defconfig    gcc-16.1.0
arc                    allmodconfig    gcc-16.1.0
arc                    allyesconfig    gcc-16.1.0
arc         randconfig-002-20260721    gcc-13.4.0
arm         randconfig-002-20260721    gcc-8.5.0
csky                   allmodconfig    gcc-16.1.0
i386                   allmodconfig    gcc-14
i386        randconfig-016-20260721    gcc-14
loongarch                 defconfig    clang-24
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
parisc                 allmodconfig    gcc-16.1.0
parisc                 allyesconfig    gcc-16.1.0
parisc                    defconfig    gcc-16.1.0
parisc      randconfig-001-20260721    gcc-8.5.0
parisc      randconfig-002-20260721    gcc-12.5.0
powerpc       mpc836x_rdk_defconfig    clang-24
powerpc     randconfig-001-20260721    clang-24
powerpc     randconfig-002-20260721    clang-18
powerpc64   randconfig-001-20260721    gcc-11.5.0
powerpc64   randconfig-002-20260721    clang-24
sh                        defconfig    gcc-16.1.0
sh         sh7724_generic_defconfig    gcc-16.1.0
sparc       randconfig-001-20260721    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
