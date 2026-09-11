Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8546DFE7;
	Fri, 11 Sep 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116306; cv=none; b=lnfgziJ9nLKCDfC2DYWivnu/7iQftVXmxVdDE1THadByW3dvmcVbWjffLIFbByxM6TR7/VFAwGPPh9Tnd+bl1cAcW42tAmXGusx5QSFNBB1TuiWZVxiGi+251T+Xrr88eh/6h4+ea+WSf9RUTbO7lva+rO79IM9gZrG2JtfOG9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116306; c=relaxed/simple;
	bh=JteMke0Sr8hgyKy/a2txaR62oAa054IlDk0jPobWpo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4I4HXUBTAyQXXi3J0KWUThG6BD8Fh4mANoa5692Ce9rEMAL5BRm40YuJ9WgHgWIM4SDuAa2GUeQYUVU6NRsLJnggQV4O1BvLr+m94BrYIa9GYAh0hW+yybaztVwBT9k0FwU+u0IjWMvHXU4yAskWze7eS3WLJAm9rIA54nI1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6rvZRwt; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6rvZRwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789116301; x=1820652301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JteMke0Sr8hgyKy/a2txaR62oAa054IlDk0jPobWpo0=;
  b=N6rvZRwtH426TvUBm6fCzevZaGmjdXW33zDRV6SqHYEmh/vx3A8nMWfa
   ZjOOGmk9t1WxJkLFe3n99hwsKHKsoL4BV3TqyMbjqYK+Jd2RpQteR0SHe
   Qf6PmOaafjXmRE/61NoY+i6W3Dq1c/JGQ3AQm9TI5HC5BSW2U1zj1fRkp
   6LvTpYNg2qe63lq9wMqRQ5s59eQhWCE2L4mr3r44SGUKDrGWYdHhsMrQa
   18uq8uyTq0LL8xFlgZTUZwjlyA/zkLHxnjS3gTJS/6h0cYEig/XajuAdT
   y4O7h9r72pL4EA7CQ+oE+Xmv9dWqfcnUTVLRc8/cvFISI3G8/kb7WFZOf
   w==;
X-CSE-ConnectionGUID: eDDwpcYdQ8qRBbys661thA==
X-CSE-MsgGUID: tMRU9TKbSk2LH7n1uscmHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="87800"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="87800"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:44:58 -0700
X-CSE-ConnectionGUID: k9MFxhyNQLy3i2GG1UOXkQ==
X-CSE-MsgGUID: E4PKgMprRjCjxs8dCAcSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="272369570"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2026 01:44:56 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4wsC-000000001JG-3XP5;
	Fri, 11 Sep 2026 08:44:44 +0000
Date: Fri, 11 Sep 2026 16:44:06 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Braha <julianbraha@gmail.com>, rafael@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lenb@kernel.org, pavel@kernel.org,
	akpm@linux-foundation.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH] PM: sleep: only allow relevant powerpc platforms to
 enable PM_SLEEP_SMP
Message-ID: <202609111618.fkJkvb2m-lkp@intel.com>
References: <20260909170520.553867-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909170520.553867-1-julianbraha@gmail.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v7.3-rc2 next-20260909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Braha/PM-sleep-only-allow-relevant-powerpc-platforms-to-enable-PM_SLEEP_SMP/20260909-180520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260909170520.553867-1-julianbraha%40gmail.com
patch subject: [PATCH] PM: sleep: only allow relevant powerpc platforms to enable PM_SLEEP_SMP
config: i386-randconfig-062-20260910 (https://download.01.org/0day-ci/archive/20260911/202609111618.fkJkvb2m-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260911/202609111618.fkJkvb2m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609111618.fkJkvb2m-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/power/cpu.c: In function 'hibernate_resume_nonboot_cpu_disable':
>> arch/x86/power/cpu.c:338:15: error: implicit declaration of function 'freeze_secondary_cpus'; did you mean 'thaw_secondary_cpus'? [-Wimplicit-function-declaration]
     338 |         ret = freeze_secondary_cpus(0);
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               thaw_secondary_cpus


vim +338 arch/x86/power/cpu.c

406f992e4a372da Rafael J. Wysocki 2016-07-14  312  
406f992e4a372da Rafael J. Wysocki 2016-07-14  313  int hibernate_resume_nonboot_cpu_disable(void)
406f992e4a372da Rafael J. Wysocki 2016-07-14  314  {
406f992e4a372da Rafael J. Wysocki 2016-07-14  315  	void (*play_dead)(void) = smp_ops.play_dead;
406f992e4a372da Rafael J. Wysocki 2016-07-14  316  	int ret;
406f992e4a372da Rafael J. Wysocki 2016-07-14  317  
406f992e4a372da Rafael J. Wysocki 2016-07-14  318  	/*
406f992e4a372da Rafael J. Wysocki 2016-07-14  319  	 * Ensure that MONITOR/MWAIT will not be used in the "play dead" loop
406f992e4a372da Rafael J. Wysocki 2016-07-14  320  	 * during hibernate image restoration, because it is likely that the
406f992e4a372da Rafael J. Wysocki 2016-07-14  321  	 * monitored address will be actually written to at that time and then
406f992e4a372da Rafael J. Wysocki 2016-07-14  322  	 * the "dead" CPU will attempt to execute instructions again, but the
406f992e4a372da Rafael J. Wysocki 2016-07-14  323  	 * address in its instruction pointer may not be possible to resolve
406f992e4a372da Rafael J. Wysocki 2016-07-14  324  	 * any more at that point (the page tables used by it previously may
406f992e4a372da Rafael J. Wysocki 2016-07-14  325  	 * have been overwritten by hibernate image data).
ec527c318036a65 Jiri Kosina       2019-05-30  326  	 *
ec527c318036a65 Jiri Kosina       2019-05-30  327  	 * First, make sure that we wake up all the potentially disabled SMT
ec527c318036a65 Jiri Kosina       2019-05-30  328  	 * threads which have been initially brought up and then put into
ec527c318036a65 Jiri Kosina       2019-05-30  329  	 * mwait/cpuidle sleep.
ec527c318036a65 Jiri Kosina       2019-05-30  330  	 * Those will be put to proper (not interfering with hibernation
ec527c318036a65 Jiri Kosina       2019-05-30  331  	 * resume) sleep afterwards, and the resumed kernel will decide itself
ec527c318036a65 Jiri Kosina       2019-05-30  332  	 * what to do with them.
406f992e4a372da Rafael J. Wysocki 2016-07-14  333  	 */
ec527c318036a65 Jiri Kosina       2019-05-30  334  	ret = cpuhp_smt_enable();
ec527c318036a65 Jiri Kosina       2019-05-30  335  	if (ret)
ec527c318036a65 Jiri Kosina       2019-05-30  336  		return ret;
406f992e4a372da Rafael J. Wysocki 2016-07-14  337  	smp_ops.play_dead = resume_play_dead;
565558558985b1d Qais Yousef       2020-04-30 @338  	ret = freeze_secondary_cpus(0);
406f992e4a372da Rafael J. Wysocki 2016-07-14  339  	smp_ops.play_dead = play_dead;
406f992e4a372da Rafael J. Wysocki 2016-07-14  340  	return ret;
406f992e4a372da Rafael J. Wysocki 2016-07-14  341  }
406f992e4a372da Rafael J. Wysocki 2016-07-14  342  #endif
406f992e4a372da Rafael J. Wysocki 2016-07-14  343  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
