Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBF32FA2B
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209404; cv=none; b=dRgPhyK4tmOwonYEki1dgnZ6BPUJ7AFjT6G2yrQNeNwcIcCuXgXi2VQGurGD1+XcfLq+08X50QtPFw5+Ux9YUtCDsUTpbxGtLDSkGahZyYpJpDPnkfuTMUjYLc70uC6DuqT2WCDhaNaFo2qDdlB7Dlga4AFJS1YKATv7IgKbd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209404; c=relaxed/simple;
	bh=6VH2C6ot/ZxF6JvZBTESvSCDO9FA2rIEgqNKOURAVV4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iVy8+VLzluMHOgPkWx+ufqMZ+CprVViuB/u3KicabfeHInEiVxCFgSs5zd6wBdHvOaXo2vRkKGoS883EtM9DkirOCT+RUsOmepO2IEQZeRKSjAYFrx8UMH2DkQrGgiMEY+GyANR+RHF34ze9T1FuXXSBTPJR/nT2s01gb81FylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZEFA0B4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZEFA0B4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785209402; x=1816745402;
  h=date:from:to:cc:subject:message-id;
  bh=6VH2C6ot/ZxF6JvZBTESvSCDO9FA2rIEgqNKOURAVV4=;
  b=lZEFA0B4/rB9HxKadA5i2/seMFPFRHqCBmLQBMjxxdfT1qJQi7WVR3dx
   MDIviKfryk76FEVDZSaJja0cD02b+YV3m+EkKaOLFx5q3tU6HeubkQHHs
   PxV6al9SmPmjvuNGXKs1N2On082WfiQ7QJ2MD3yiov23InCIoiDIGc+eG
   NpaWP7cifxF1UKUfbZE9xEzSR78G9eBgA+50f6PwmdTYrLlnCZHVkQVMb
   GGeO8JaDUaRKEEVyWpE4QOIwm9aoQrChPPv3kLNw072H1B/qcXoQ1dCRn
   THl2qUss8/gAh58/KWyXlgvfHDHb5b0/m9FsVu/mcD4XjdAsW3DUgXhvY
   g==;
X-CSE-ConnectionGUID: GSY+sXyZSFSvoMN4O3gl8g==
X-CSE-MsgGUID: nVTxEEL2R9OsWUndmrhCdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96141733"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="96141733"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 20:30:01 -0700
X-CSE-ConnectionGUID: vouet11xR/mBo7i6IidPoA==
X-CSE-MsgGUID: 3v7f/kzlQIOam7ceJXGOjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="253257110"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Jul 2026 20:30:00 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woYVx-00000000dt9-3LEF;
	Tue, 28 Jul 2026 03:29:57 +0000
Date: Tue, 28 Jul 2026 11:29:11 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pm@vger.kernel.org
Subject: [amd-pstate:amd-pstate-fixes] BUILD SUCCESS
 08fc1e7b31f8832e356ede8afae1ad1ff0d5a1fc
Message-ID: <202607281100.jG5up33t-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git amd-pstate-fixes
branch HEAD: 08fc1e7b31f8832e356ede8afae1ad1ff0d5a1fc  cpufreq/amd-pstate: Prevent the driver from loading on unsupported hardware

elapsed time: 7015m

configs tested: 12
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha    allnoconfig    gcc-16.1.0
alpha   allyesconfig    gcc-16.1.0
arc     allmodconfig    gcc-16.1.0
arc     allyesconfig    gcc-16.1.0
csky    allmodconfig    gcc-16.1.0
i386    allmodconfig    gcc-14
nios2   allmodconfig    gcc-11.5.0
nios2    allnoconfig    gcc-11.5.0
parisc  allmodconfig    gcc-16.1.0
parisc  allyesconfig    gcc-16.1.0
x86_64         kexec    clang-22
x86_64  rhel-9.4-bpf    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
