Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210736828D;
	Thu, 30 Apr 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531236; cv=none; b=BHziiWGNdORvWay908Y11zSb5YerOCUvmjA7+7D9DNarMkZCt4bb3320gucu7FuFckDeYl1P1vuy15wnZUs4uWdzNV2tfVsHNJFSb8d5f/4IOhizVSKNsf3b3T3/eaKrgD8rM4acmYYUIBppPXjwse+7QxNoL7eGLw68B0mwDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531236; c=relaxed/simple;
	bh=jq68uOfCLs7ckLRy7sytlzyCQJwRudpkMsuWOiXICiE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hKBGRX/zAxpPulEy+1fdVp5rqAEEKByZ31swMtKuJmhaTUkHxiVTRTyPJIx1DZ/Ffqcygk+hjIFm5GeAq3u0J8UMowEXmsgGJKzRu0hEr4a7x8eVIETnE68wbhGvZcKlBThjc+9AkJsNdaLIqGz5w0AzqTo56JQI6xd6nD5Hi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E14tA/Dh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E14tA/Dh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777531235; x=1809067235;
  h=date:from:to:cc:subject:message-id;
  bh=jq68uOfCLs7ckLRy7sytlzyCQJwRudpkMsuWOiXICiE=;
  b=E14tA/DhndlapU1ZTKcgtN3MOoPnYbwQtm2LX8EPjTVtJ7LGfwNwOize
   wMmKyW6AOix4VbYp+mMnn4w7Pb6f8QGWb7MzzdpcthGRSsQ9nyC6wF6LV
   yVhDnr0VWXyIkBpfbyZtuSq8LSJVlt4/VRsc2vBTrA3aY6WKi23fhGyKB
   McDFcp31t/rpcvlHnRmGhsQ+YKkitEsoF+p8FWGE9ns6NvGWQMD1qVsX1
   rj8y6rrT/YlVMjux6YkcryApmcwH+cssCIE1igXEwtdVYrQswxJibaFOD
   RIOLr86n1wB4EPXNqbGCcUBIFTltsAcalQiFTfxUgmD/O9PEIs/bKIEpZ
   Q==;
X-CSE-ConnectionGUID: +EpNYQnaTWO7fADd7Rew2Q==
X-CSE-MsgGUID: Y6MPVB+/Ss2TDHZJNMgoxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78394356"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78394356"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:40:35 -0700
X-CSE-ConnectionGUID: Bl2i/imCTWiBmkZ2o+vqJw==
X-CSE-MsgGUID: ZDZZwQHeRrCa1lkCFxDVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="258075604"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 29 Apr 2026 23:40:32 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIL4Y-000000004lH-3WK9;
	Thu, 30 Apr 2026 06:40:30 +0000
Date: Thu, 30 Apr 2026 08:40:04 +0200
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 14/30] htmldocs:
 Documentation/driver-api/acpi/index.rst:5: WARNING: toctree contains
 reference to nonexisting document 'driver-api/acpi/acpi-drivers'
 [toc.not_readable]
Message-ID: <202604300815.6rqygFFB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c776b06fa37fc4193b29821f1ac2871c02ae97b4
commit: 54ce12887d4a1d605f6a9b4736d07564ed07b529 [14/30] ACPI: Documentation: Remove driver-api/acpi/acpi-drivers.rst
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260430/202604300815.6rqygFFB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300815.6rqygFFB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
   ------------------------------------------------------------------------------------------------^
   Documentation/core-api/kref:328: ./include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
   int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)
   --------------------------------------------------------------------------------------------^
>> Documentation/driver-api/acpi/index.rst:5: WARNING: toctree contains reference to nonexisting document 'driver-api/acpi/acpi-drivers' [toc.not_readable]
   Documentation/driver-api/basics:42: ./kernel/time/time.c:370: WARNING: Duplicate C declaration, also defined at driver-api/basics:436.
   Declaration is '.. c:function:: unsigned int jiffies_to_msecs (const unsigned long j)'. [duplicate_declaration.c]
   Documentation/driver-api/basics:42: ./kernel/time/time.c:393: WARNING: Duplicate C declaration, also defined at driver-api/basics:453.
   Declaration is '.. c:function:: unsigned int jiffies_to_usecs (const unsigned long j)'. [duplicate_declaration.c]
   Documentation/driver-api/target:25: ./drivers/target/target_core_user.c:35: ERROR: Unexpected section title.


vim +5 Documentation/driver-api/acpi/index.rst

680e6ffa15103a Changbin Du 2019-04-25  4  
680e6ffa15103a Changbin Du 2019-04-25 @5  .. toctree::

:::::: The code at line 5 was first introduced by commit
:::::: 680e6ffa15103ab610c0fc1241d2f98c801b13e2 Documentation: add Linux ACPI to Sphinx TOC tree

:::::: TO: Changbin Du <changbin.du@gmail.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
