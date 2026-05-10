Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455B24E4AF;
	Sun, 10 May 2026 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778393738; cv=none; b=hwtJ0ystp6dRO7w2pEONVlYxBeU0yJNtK1AAWxfIJr4EY9/f04w6svlYPMoNnpUqNykxut/pz34bYL3WEsQ0nGssV1M/FaDXEoayVOWBivgLde7TDel3zVI6Qye53LKXg4+gPmOaxpgad+8FQaedpg9qHdIs8b3S8th6tMooL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778393738; c=relaxed/simple;
	bh=zD3zC9CrfQa8lHkjHcUf9WWv3IQD31uQekPTskL+QiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUfbQK1esH13ITcdCjKDS6D/HOa/A+PNsQ2w+6WkVjNpnCZq5TMsnOpeGPmTf9jWQ8sScBANXSXIxj7VzpLKlfq5QmbfXssksz33SPKkX32WNt8heeV1uae1tsC0RlBbdwh+jrZVG0D8VggK3SNhqX+w8xb5QUfwLTlMylxXyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRgqwMdK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRgqwMdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778393737; x=1809929737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zD3zC9CrfQa8lHkjHcUf9WWv3IQD31uQekPTskL+QiM=;
  b=PRgqwMdKB9n07b0OfT+k3JYIFCyBN9cD08tn+KKukpXMYkCJaYFDfIZQ
   VK9bOrw/YVdOqKrsHpsHOnryLKJJSBtBrEx47wrxbFoVm3LowRdFZrnUz
   J5rMi72oXNcfOIs1uZtgI6+0PQvs+kmu2++4n+e7/YaFF2EXxlSbkFhDj
   CQTyYQ92blAXgwkWhs1UBfmIe1RVp0Ok8W81qynE5H/y2Cc4w+q32vtMT
   s8NrMPAxiMxQ9NFtrI9zEK+1GIYBLIJpY5qGcodi7TeqFEaKfDWEFRaXu
   9M4cqBMhD1Cjfu/LXJATvxJqAHTo6BtmlDU/cvze9O8On4rHptrzNkiOZ
   A==;
X-CSE-ConnectionGUID: +UNRnbzyRLKBx5daX84uvg==
X-CSE-MsgGUID: UqoVI7+xS9uN9hNeaJKi7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="66848183"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="66848183"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:15:37 -0700
X-CSE-ConnectionGUID: LSAFUuayS3C7QuBifNq+Pg==
X-CSE-MsgGUID: hWBHzN70R0G4r5SUNBlmkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="241505966"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2026 23:15:34 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLxRr-000000001pR-1KDr;
	Sun, 10 May 2026 06:15:31 +0000
Date: Sun, 10 May 2026 14:14:56 +0800
From: kernel test robot <lkp@intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
	viresh.kumar@linaro.org, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, pierre.gondois@arm.com, sumitg@nvidia.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: Re: [PATCH] cpufreq: cppc: Add update_limits support for Highest
 Performance changes
Message-ID: <202605101404.fqz0MXIe-lkp@intel.com>
References: <20260508111932.185886-3-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508111932.185886-3-luoxueqin@kylinos.cn>

Hi Xueqin,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.1-rc2 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xueqin-Luo/cpufreq-cppc-Add-update_limits-support-for-Highest-Performance-changes/20260510-093030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260508111932.185886-3-luoxueqin%40kylinos.cn
patch subject: [PATCH] cpufreq: cppc: Add update_limits support for Highest Performance changes
config: riscv-randconfig-002-20260510 (https://download.01.org/0day-ci/archive/20260510/202605101404.fqz0MXIe-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101404.fqz0MXIe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101404.fqz0MXIe-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/cpufreq/cppc_cpufreq.c:857:43: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'u64 *' (aka 'unsigned long long *') [-Wincompatible-pointer-types]
     857 |         ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
         |                                                  ^~~~~~~~~~~~~
   include/acpi/cppc_acpi.h:157:51: note: passing argument to parameter 'highest_perf' here
     157 | extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
         |                                                   ^
>> drivers/cpufreq/cppc_cpufreq.c:882:3: error: call to undeclared function 'cppc_cpufreq_set_autonomous_perf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     882 |                 cppc_cpufreq_set_autonomous_perf(policy);
         |                 ^
>> drivers/cpufreq/cppc_cpufreq.c:886:4: warning: format specifies type 'unsigned long long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
     884 |         pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
         |                                               ~~~~
         |                                               %u
     885 |                  policy->cpu,
     886 |                  prev_highest_perf,
         |                  ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:641:38: note: expanded from macro 'pr_debug'
     641 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:134:18: note: expanded from macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ~~~    ^~~~~~~~~~~
   drivers/cpufreq/cppc_cpufreq.c:887:4: warning: format specifies type 'unsigned long long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
     884 |         pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
         |                                                       ~~~~
         |                                                       %u
     885 |                  policy->cpu,
     886 |                  prev_highest_perf,
     887 |                  highest_perf);
         |                  ^~~~~~~~~~~~
   include/linux/printk.h:641:38: note: expanded from macro 'pr_debug'
     641 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                     ~~~     ^~~~~~~~~~~
   include/linux/printk.h:134:18: note: expanded from macro 'no_printk'
     134 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                         ~~~    ^~~~~~~~~~~
   2 warnings and 2 errors generated.


vim +857 drivers/cpufreq/cppc_cpufreq.c

   845	
   846	static void cppc_cpufreq_update_limits(struct cpufreq_policy *policy)
   847	{
   848		struct cppc_cpudata *cpu_data = policy->driver_data;
   849		u32 prev_highest_perf;
   850		u32 highest_perf;
   851		int ret;
   852	
   853		guard(cpufreq_policy_write)(policy);
   854	
   855		prev_highest_perf = cpu_data->perf_caps.highest_perf;
   856	
 > 857		ret = cppc_get_highest_perf(policy->cpu, &highest_perf);
   858		if (ret)
   859			return;
   860	
   861		if (highest_perf == prev_highest_perf)
   862			return;
   863	
   864		cpu_data->perf_caps.highest_perf = highest_perf;
   865		if (cpu_data->perf_caps.nominal_perf > highest_perf)
   866			cpu_data->perf_caps.nominal_perf = highest_perf;
   867	
   868		policy->max = cppc_perf_to_khz(&cpu_data->perf_caps,
   869				policy->boost_enabled ?
   870				highest_perf :
   871				cpu_data->perf_caps.nominal_perf);
   872	
   873		policy->cpuinfo.max_freq = policy->max;
   874	
   875		/*
   876		 * Autonomous selection mode uses MIN/MAX performance as runtime
   877		 * hardware control bounds.
   878		 *
   879		 * Re-program them when highest_perf changes.
   880		 */
   881		if (cpu_data->perf_ctrls.auto_sel)
 > 882			cppc_cpufreq_set_autonomous_perf(policy);
   883	
   884		pr_debug("CPU%d: highest_perf updated %llu -> %llu\n",
   885			 policy->cpu,
 > 886			 prev_highest_perf,
   887			 highest_perf);
   888	}
   889	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
