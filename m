Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C692EAC7;
	Wed, 25 Feb 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003977; cv=none; b=Pc6pronKWqOfFBJov+He7IRr+68n8pZraUf6MK/oH5/OGUuY8QYdNL6IyYxQkASXlflal9sLEC6/Gv0RHmvotBd+VjorausYPljQpntLhSgvChIqFPr8lsCnbjlu3+HZX/cq7rbAQ1nev2TbfLYkP3MU9wECa3RIkQT/LpSNz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003977; c=relaxed/simple;
	bh=CbiotcYeTC/xNX/WWvgx2AOcqH/NVwgPal1VsDbilCU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K9YY+Easj1aK+rbzSthjQSgxR6z7Pv3x8l8gQsQhRAltNkZhk/+BRvI7Wulo7BCY1v6EzrhGvUGVW52ZZMHA6wtEgCKuvpl0kSd9Bb2fGBUtdhdJotlAB86e5BYIzQQp1qui9nQ7JLYEm3F+W8oXHtWIk6W5qXnE86V1Ik/V4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLZHT7g0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLZHT7g0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772003975; x=1803539975;
  h=date:from:to:cc:subject:message-id;
  bh=CbiotcYeTC/xNX/WWvgx2AOcqH/NVwgPal1VsDbilCU=;
  b=XLZHT7g0nAU6PUO7jWLpyl2AWKcTIXvYDKW+V2yJdOxvZ8BYv5b2YUUa
   ir1Nbsz0RRMMbhs/ctjBrM6MiTSjCX8BwmJd1gfmd7TxXIAHPPAFMCOvB
   rUCCmGFR390mQVSoou/tCjyNTzEl1w2xf1W/5t1/C3/80qWzFh4av+qz/
   KASF5TUC8/Z0o13TcSeysAKtIOV5YNYsgsE+n5uLIe9dZkvkgEPilnJKw
   6u8nZGoCwbPjN7Of7oBSxz6v1NAivCaL89Xxs+MOsFzXMmeXEY7AioueH
   e4iSbtTadhTH8JCYEUR3IXf1OonlUfihsFAOAolqJ3yEIQ9UHbI9H6jKp
   g==;
X-CSE-ConnectionGUID: CkQQVMR4T0e5gd5yp4fdNg==
X-CSE-MsgGUID: yUcc2tkqQUGRzUJA9GNvFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90452075"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="90452075"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 23:19:34 -0800
X-CSE-ConnectionGUID: KhdnH8UoTBKb+MCigyfQHQ==
X-CSE-MsgGUID: F7ILzBGSTxKstO8NaCxZAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220268724"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 24 Feb 2026 23:19:33 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vv9B9-000000004Rr-1pvn;
	Wed, 25 Feb 2026 07:19:28 +0000
Date: Wed, 25 Feb 2026 15:18:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:acpi-rtc 13/14] ERROR: modpost:
 "devm_rtc_device_register" [drivers/acpi/acpi_tad.ko] undefined!
Message-ID: <202602251547.aJzUhpzh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-rtc
head:   52b552ea2b0e12800942e22f4ed3dbc7f394dec9
commit: ad9f759418050a355eb90ac010b8db05d4d6f23c [13/14] ACPI: TAD: Add RTC class device interface
config: x86_64-randconfig-002-20260225 (https://download.01.org/0day-ci/archive/20260225/202602251547.aJzUhpzh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260225/202602251547.aJzUhpzh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602251547.aJzUhpzh-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_rtc_device_register" [drivers/acpi/acpi_tad.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
