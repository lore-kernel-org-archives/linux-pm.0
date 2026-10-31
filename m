Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415682;
	b=xf7co+8OjTRMvTwRblYUJGjf+tDhsyH1qICp28A1KS+tXOOzidKMsW+pmwMUlBBKfJGY
	 l5sIBd4qR836htkOHEWUYvObXpmUONteWlb46B9MVH6G386/3I5z2qE9wESpEPAdUuQP0
	 3Z+9cx/8CS4ANw/O00egl1X7079jZIwzH13njsxY92IoW9N5hTgqdPQaaz7u9BsLTkkRP
	 TmlsArsLwfxa++0VarQrADsgQCwSRKmsy1yH4ntSizZ2uj0ALt3sb2coFHHQcLXktGScS
	 f6j2n/BKLOgPLq5b5O9+732uYbab6Usyos4ztz9njGUjRzBLdJCduroJUDvxB9rGUKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415682;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ScO8O/upqFlWc9ms/cDV7A+06pHYa0mgXEy5Xe3VLRM=;
	b=l1gi5vb1JSZa03esa5n5b8IW///yzmOqpoFFyMpGDX8mxa6jZhL9I2rL3Sbo4RFqubi3
	 S5PMkiHNZksOG77UNMIwgkx5eevmb6UyoEyiUCk1gZi+Tntm3NNn3ad0UKGbec/JDoqll
	 V6YorAu839iLF6ZdLaTaVDB/BPNddopemSIosexwbfb8T+1LI3w8M45CkGymTERLPwYdt
	 Gimdmv+JtLGFprDxaZKLZylOEK/9ibAzDxXeJsEoVX2WcsgldVZDdhmQm6rt89M3IlsZ3
	 6feN9Q1iCHfMJsfBWSHgnZd9nAYcdOOVfnDYz55ygHfhF04lDipOURXleUzcJDLPZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b1kRt6px;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A76606A320;
	Sat, 31 Oct 2026 03:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A76606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b1kRt6px
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793415680; x=1824951680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=414eLYxu+WXKrALlVPM8NuQyq6xSQJkQYhiLsXdq/iw=;
  b=b1kRt6pxMzmHsqbcKpPc3+IQAdonYiTflXT/uEfUfAIIAvcUq/cs/MD9
   4TA158QlHotP1s/3zRqc7NiebQBORZ175HZaT1NWSnMT+OY7q2kgwNDSE
   GB2uTOKugDbNPxNIdx0J/53HTLtcyOTaSRQiUygm4+Z9ELmIdnBbESwxB
   eFW/X1N8SbXer+jZg12ZxkVEq+JwYMX9x5qUrUKS4nPn525K3u4BAT0IW
   Yr2/w4bdJm07jfxB6y6dvwGnXlJnzIk1hku1z7vHiUMpE/GkSDl3KEDyp
   BPBGtRUY1RNNpSpAYf7S3/4/3SMyXL0TIimBwrDvrE4qq4nJf20dacftP
   Q==;
X-CSE-ConnectionGUID: 3sOrMF0oQ+q/BXBZ/i9zaw==
X-CSE-MsgGUID: T6QJ0VkTS7+Jxu1LV6uM4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2195886"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2195886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 20:01:19 -0700
X-CSE-ConnectionGUID: +7yY5swGQQ2kKbO+RDjs8g==
X-CSE-MsgGUID: 2kuP9pWuTUmhbE14Qkfh/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5738979"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2026 20:01:17 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMzLG-00000000cUC-3q17;
	Sat, 31 Oct 2026 03:01:14 +0000
Date: Sat, 31 Oct 2026 11:01:03 +0800
From: kernel test robot <lkp@intel.com>
To: Saranya Gopal <saranya.gopal@intel.com>, linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
Message-ID: <202610311004.dFYbEqgo-lkp@intel.com>
References: <20261030030515.3127310-1-saranya.gopal@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030030515.3127310-1-saranya.gopal@intel.com>

Hi Saranya,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master next-20261030]
[cannot apply to v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saranya-Gopal/ACPI-s2idle-Handle-shared-_Ixx-GPEs-without-an-EC/20261030-083515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20261030030515.3127310-1-saranya.gopal%40intel.com
patch subject: [PATCH] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
config: i386-randconfig-1000-20261031 (https://download.01.org/0day-ci/archive/20261031/202610311004.dFYbEqgo-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610311004.dFYbEqgo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610311004.dFYbEqgo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/acpi/processor_driver.c:25:
   drivers/acpi/internal.h: In function 'acpi_ec_dispatch_gpe':
>> drivers/acpi/internal.h:262:17: error: 'ENOTSUP' undeclared (first use in this function); did you mean 'ENOTSUPP'?
     262 |         return -ENOTSUP;
         |                 ^~~~~~~
         |                 ENOTSUPP
   drivers/acpi/internal.h:262:17: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from drivers/acpi/x86/utils.c:19:
   drivers/acpi/x86/../internal.h: In function 'acpi_ec_dispatch_gpe':
>> drivers/acpi/x86/../internal.h:262:17: error: 'ENOTSUP' undeclared (first use in this function); did you mean 'ENOTSUPP'?
     262 |         return -ENOTSUP;
         |                 ^~~~~~~
         |                 ENOTSUPP
   drivers/acpi/x86/../internal.h:262:17: note: each undeclared identifier is reported only once for each function it appears in


vim +262 drivers/acpi/internal.h

   258	
   259	static inline void acpi_ec_flush_work(void) {}
   260	static inline int acpi_ec_dispatch_gpe(void)
   261	{
 > 262		return -ENOTSUP;
   263	}
   264	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
