Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152E4279E9
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248270; cv=none; b=Z7BNAI89dcr/26Lw0YwwaTlFvfEsP8hLOHrpf/BvwOwvum7zU6v4fUDydZb5NI5BoToyYbgz3sW7YmTFddXJ9PqDDCVp1wEiRyVYpM+2qq1ZtKu4C93OKj3rAhRVvPWF94jYnWUyO0eTsRKYnj8HeLaatKeb4Zz6wwhRszbgThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248270; c=relaxed/simple;
	bh=FBSS75W60V68MY01JfGP4CDHdWV+dWdHrwljJqGVDKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DUOJEe9BL3Fp9YdST51HR5bGXsxDVKKLnGW/Rgqfzj6E5gKTAMhJXWFeNiE2NADrI6zAn8EZsQehiMi334ikmHX8HVyMAy0qjYnRbYtIY3VPdCqPk4bcvP1ypNYjI5iBzsaHun603uBpEwIT9vPXYZpMxSX8blow8hVnhBfWp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlqcmdS8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlqcmdS8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785248269; x=1816784269;
  h=date:from:to:cc:subject:message-id;
  bh=FBSS75W60V68MY01JfGP4CDHdWV+dWdHrwljJqGVDKc=;
  b=FlqcmdS8rP+HgvxPrisMSGT3ljAPKa/1YTn+Hr3naH1ImpxwhLPMlK6q
   cxgv76+OSDkqZ+Algui13DmAbxqLrG5u9iy9xM8FNUEqzTz2c/L/Q9JsH
   b2jRu1G+j1n9e42YvqDAfPjDmJHwN/rCTbv9Yc6DjtUyKuK5xSLIVEScd
   Q1ATeFOtAS8tT1m45xlgJe/EMLbO+FFbS9aZU0NcGdaOgsuKlLljzuWnU
   C9DXsB3FAqd23vptMEQ2GS5wxAq5WAKk6+JAr+ROWVc/CEK/G4D93WcDn
   ry6Gk3V9iq1MMJTJxe1cgAemPIx1HrpRsj88fwrZuJHdA1btAp+e3jnnu
   w==;
X-CSE-ConnectionGUID: XyJdyQ7VTRmGZGfQwiQPZQ==
X-CSE-MsgGUID: EwYI4qZoRKy6CxD5BSgT6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103374136"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="103374136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 07:17:48 -0700
X-CSE-ConnectionGUID: MKd/Npp0RN6SwHc5191Ydg==
X-CSE-MsgGUID: 8DQ7rYNnR1qFFNVeIbqNLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="297946538"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 28 Jul 2026 07:17:48 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woicr-00000000eQp-2iBG;
	Tue, 28 Jul 2026 14:17:45 +0000
Date: Tue, 28 Jul 2026 22:16:50 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:bleeding-edge] BUILD SUCCESS
 d9a3b95f3713c88672b44ee579b6435d6ce10857
Message-ID: <202607282236.kR21MsP6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
branch HEAD: d9a3b95f3713c88672b44ee579b6435d6ce10857  cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority

elapsed time: 788m

configs tested: 14
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
alpha           defconfig    gcc-16.1.0
arc          allmodconfig    gcc-16.1.0
arc          allyesconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
i386         allmodconfig    gcc-14
m68k    mvme147_defconfig    gcc-16.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
parisc       allmodconfig    gcc-16.1.0
parisc       allyesconfig    gcc-16.1.0
parisc          defconfig    gcc-16.1.0
sh              defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
