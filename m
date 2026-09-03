Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD305693
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408955; cv=none; b=kmdGTFLmRLaHHh2TQ7QsWi4upfNAUr72o7Awqau2bGdEWVEn8AtNHJh6OCvmfqN3rXxyMZ4qgIRbexj+x5mpCIRBDnO46ms2lf7jQos3FX8oUO2DSlI+PGe97eRYKynrq8sRJt2Bi4UBkTwYS1EiMZ6/owCXXxk3g/27bnEudAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408955; c=relaxed/simple;
	bh=hYG6l8n+3ICOSgbIdRk6Rbfrs8W/nP66wV62G7SWYEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hemAb/ZFht/65p2moa50CiP7LesElWYN0Nm2qX9ZCIG3A97Sz+ZoOyLxIf83FSW/OfOjTdbQ1Tv5ym8rPeyBJEHaEB+WH5B7UF8ZSZBiFrO1xiBhsFW3vgwMN0KLNvx4ze2xdVQ2VysDqXDOWSWuqHPfaLl8UMNgdtDzDDVfMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCNrtTYi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCNrtTYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788408952; x=1819944952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hYG6l8n+3ICOSgbIdRk6Rbfrs8W/nP66wV62G7SWYEI=;
  b=QCNrtTYiI1aCaGWBIrIzq91FVgxOGJXrr1BbMRX87SI1w+L8MtpZrI+M
   AnYnPodQ2tUEf8BsglsDXO/idkqcB2uOOm3RoyjMzPsY9lpZZ5QlTA6/7
   Y74u1fKEmQN4JKMM7SxdqX18Fr2YjMdwOsqFpVc0+yjtoe0S1zEOZki5n
   BzIzy6qPt/xMUzCFZuZGjTvM7xffCaCTtqSYXqZxFocvQbuKtOnpHGOYH
   DsD+45Xw+dY9V9N7nGqO/duFnYxxeoO0Bkd0RFWIykMbUUjdnyyadg92j
   XPknq7hXufGNDgc/YznALcJ0S9+oD3xP9LcfdLQM+Zp9A5+U42RT78c6b
   g==;
X-CSE-ConnectionGUID: zKXjGvBIQPeq84LcYIlQhg==
X-CSE-MsgGUID: eeYSLeXpQ+C3KI8OJeyJRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100234920"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100234920"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 21:15:52 -0700
X-CSE-ConnectionGUID: OmOcC7utT6Sc/7qqkyCUug==
X-CSE-MsgGUID: Os6zgQG3TlGsk1QvC0ANNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273101325"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Sep 2026 21:15:50 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1yrb-0000000042k-2qNf;
	Thu, 03 Sep 2026 04:15:47 +0000
Date: Thu, 3 Sep 2026 12:15:45 +0800
From: kernel test robot <lkp@intel.com>
To: Todd Brandt <todd.e.brandt@linux.intel.com>, linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: oe-kbuild-all@lists.linux.dev, todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: Re: [PATCH v2] PM: dpm_show_time changes to suspend/resume dmesg
 prints
Message-ID: <202609031247.SRpWbgoA-lkp@intel.com>
References: <20260831222926.34698-1-todd.e.brandt@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831222926.34698-1-todd.e.brandt@linux.intel.com>

Hi Todd,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.3-rc1 next-20260902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Todd-Brandt/PM-dpm_show_time-changes-to-suspend-resume-dmesg-prints/20260831-152926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260831222926.34698-1-todd.e.brandt%40linux.intel.com
patch subject: [PATCH v2] PM: dpm_show_time changes to suspend/resume dmesg prints
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260903/202609031247.SRpWbgoA-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260903/202609031247.SRpWbgoA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609031247.SRpWbgoA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:5,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/mips/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:369,
                    from include/linux/dev_printk.h:14,
                    from include/linux/device.h:15,
                    from drivers/base/power/main.c:21:
   drivers/base/power/main.c: In function 'dpm_complete':
>> include/linux/stddef.h:8:14: error: passing argument 3 of 'dpm_show_time' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/base/power/main.c:1362:41: note: in expansion of macro 'NULL'
    1362 |         dpm_show_time(starttime, state, NULL, "complete");
         |                                         ^~~~
   drivers/base/power/main.c:480:70: note: expected 'int' but argument is of type 'void *'
     480 | static void dpm_show_time(ktime_t starttime, pm_message_t state, int error,
         |                                                                  ~~~~^~~~~


vim +/dpm_show_time +8 include/linux/stddef.h

^1da177e4c3f415 Linus Torvalds   2005-04-16  6  
^1da177e4c3f415 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f415 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e2182874324727 Richard Knutsson 2006-09-30  9  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
