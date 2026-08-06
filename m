Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE41DC985;
	Thu,  6 Aug 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785985394; cv=none; b=qrFvxnLNlPUlz3sZxVNe7utps0F/Eu4ZCv2+p+lR+liImprhhr8qoYagDJclwxBcFmxR4usgtFhqScfBy+Jqgttd2NNffSJklTf1N7ZDXpYdkyu/eni38a6EX49jIYxXngO/95VbDHVKpIAq/3VghhKRBFjfk9ZFUPaLQDohozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785985394; c=relaxed/simple;
	bh=GkaTfaveSsD3z5A8YzPLkmNCrx+3A9h51z3TYCftdz4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aGy8f9hldVmGqVOwUxXlz8+5FwGVcHOu2RGMHmAgf7iEIFzA6cj/2M4bWAoTj8ZHCmsmQFqJgP4t0Gy3zwa0+JP7s0/BhgtnMQ7n2Dy/AHGyCNWi6KTcvcLE/WE35x0POkO7y3Om8WZX6i8WIQsBDrBpgeLr/0P0ZxQ0EWHKtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhXVnCgj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhXVnCgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785985391; x=1817521391;
  h=date:from:to:cc:subject:message-id;
  bh=GkaTfaveSsD3z5A8YzPLkmNCrx+3A9h51z3TYCftdz4=;
  b=ZhXVnCgjlYJXOMwsfHDp6yS/8lj/7T98eCuxz+Dg/V4wMZraZID76sEL
   kUFodr1Ac3CTq0W9mvd0Hf27f2GzuKuGk8Iju/Qs/c9/XWvx5Q5uptD7g
   QmI4u3dHM3uGeoa9Z+IxWi7UDvBCTvxrmBcigRJDZq0Ri68Uq5dpkT6SA
   /cTbbFO9ltjdyA/QuRVRh4q1yDecw3nTb/GCrTs8IZG8nNHxgiJinDuXN
   w2ogIaL18Z2KPZUXv/QqHvIw7iEi5w33EEljtqqh2m+IoeedKd7paa/0e
   n6G5OkCA4oYYSZE6fJHGTZe9Cxd+Qr7Eowc2UXZg3W5kLH27JfD0bXhIB
   Q==;
X-CSE-ConnectionGUID: gozZZ48pQoeCqt04n6g4Jw==
X-CSE-MsgGUID: ACbdTWNTQgOI1LHxdciXBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86647310"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86647310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 20:03:11 -0700
X-CSE-ConnectionGUID: 94USftiETRWAX5v/rOBp2g==
X-CSE-MsgGUID: Y2tBAQoFQwe9GGVpRmzdLw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Aug 2026 20:03:09 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wroNu-00000000E16-3f5s;
	Thu, 06 Aug 2026 03:03:06 +0000
Date: Thu, 06 Aug 2026 11:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 77acf59d7cf1d4e00e4f7689263f56bd8e1d3392
Message-ID: <202608061131.0H7fo8Ko-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 77acf59d7cf1d4e00e4f7689263f56bd8e1d3392  Merge branch 'acpi-cppc' into bleeding-edge

elapsed time: 784m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-16.1.0
alpha           allyesconfig    gcc-16.1.0
alpha              defconfig    gcc-16.1.0
arc             allmodconfig    gcc-16.1.0
arc             allyesconfig    gcc-16.1.0
csky            allmodconfig    gcc-16.1.0
i386            allmodconfig    gcc-14
loongarch          defconfig    clang-24
nios2           allmodconfig    gcc-11.5.0
nios2            allnoconfig    gcc-11.5.0
parisc          allmodconfig    gcc-16.1.0
parisc          allyesconfig    gcc-16.1.0
parisc             defconfig    gcc-16.1.0
powerpc    asp8347_defconfig    clang-24
sh                 defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
