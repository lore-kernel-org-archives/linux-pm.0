Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E17309EFF;
	Sat, 14 Mar 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507328; cv=none; b=gT26MOejNiITjHXbJzP81TKvFsmr8E4Rt0Nnf+wgujEj//UWTbk1ZZ9WW+DDgxlLUp20vT9lXGLfMbyiAa5mToZVR6fjCW4YnVoTi8st0DJusf5ECAgfx02sWPoBNVJcYAyLizCPGOOlVeF2CLr2MwmuWF+gpEGSgjn6IAKyNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507328; c=relaxed/simple;
	bh=gRNQlNfa9x/mXv62dDGe+xjnZhT7DR+AGXLx19taNMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhJjFKEX5N5pEA4cxaabcGhkRIaIsmGbC/zK4dSCeEtywdWpoE7EKGzQr8zEfAVSl4peHYLSq+3re8qabh+YlGf5AACP74PbEh6uXKaAFYYVFhLyo9Jj8hvB53iftNWZbU57Pbcy2uJEfCV0CKCMBiIb2lZy/Dag1Q3lLvby9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2pWBk7b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2pWBk7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773507325; x=1805043325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gRNQlNfa9x/mXv62dDGe+xjnZhT7DR+AGXLx19taNMs=;
  b=k2pWBk7bVDvyYsbhhWHbfeWhF/GgQwDwqDX0MVzPT1Jzi9Zs6KCZii1H
   MsZZkfsbsxkQQFsFmyC0CHO8PfsifE1tJxicz/0so3/cN6MO5OvXhad7r
   oLAQJ7fa7WdBSP/ouoXdttFk3Kl5l4k92cj8im2Tz2aNig8j9WTROQzNf
   RRpEv4RNrl3SWRClX5p/wO/XsGzunQ9UucbwN9hRDX4PK+O74E3ygrXyU
   q3SSvOQlIMfMvMPTUI1OMywYpOUgYcZ9yvoOyp/s7+1UA/zJOo1mwC+NW
   XlQr5Y5ot6hoS+k5tUk8mMRSgfib/QfK57a1+h8FN2cMqi59iFkvm0OHW
   g==;
X-CSE-ConnectionGUID: mby3joHDS5CMyAloEU6Z0w==
X-CSE-MsgGUID: xIwEbJ2LTDC5OeXpJ8sYiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="74469959"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="74469959"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 09:55:25 -0700
X-CSE-ConnectionGUID: 51tZTZaVSByHeqH/cOwAiA==
X-CSE-MsgGUID: BT4K8FXLQuSCDfsh89B5Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="226137458"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 14 Mar 2026 09:55:22 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1SGm-000000003pB-3dVy;
	Sat, 14 Mar 2026 16:55:20 +0000
Date: Sat, 14 Mar 2026 17:55:02 +0100
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Cache the max frequency in cpudata
Message-ID: <202603141750.mDER1GM9-lkp@intel.com>
References: <20260312182442.3236386-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312182442.3236386-1-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.16-rc1 next-20260313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/cpufreq-amd-pstate-Cache-the-max-frequency-in-cpudata/20260314-194005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260312182442.3236386-1-mario.limonciello%40amd.com
patch subject: [PATCH] cpufreq/amd-pstate: Cache the max frequency in cpudata
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260314/202603141750.mDER1GM9-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260314/202603141750.mDER1GM9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603141750.mDER1GM9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:1092:20: warning: variable 'perf' set but not used [-Wunused-but-set-variable]
    1092 |         union perf_cached perf;
         |                           ^
   1 warning generated.


vim +/perf +1092 drivers/cpufreq/amd-pstate.c

ec4e3326a95507 Huang Rui         2021-12-24  1082  
ec4e3326a95507 Huang Rui         2021-12-24  1083  /*
ec4e3326a95507 Huang Rui         2021-12-24  1084   * This frequency is to indicate the maximum hardware frequency.
ec4e3326a95507 Huang Rui         2021-12-24  1085   * If boost is not active but supported, the frequency will be larger than the
ec4e3326a95507 Huang Rui         2021-12-24  1086   * one in cpuinfo.
ec4e3326a95507 Huang Rui         2021-12-24  1087   */
ec4e3326a95507 Huang Rui         2021-12-24  1088  static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
ec4e3326a95507 Huang Rui         2021-12-24  1089  					char *buf)
ec4e3326a95507 Huang Rui         2021-12-24  1090  {
009d1c29a45194 Mario Limonciello 2025-01-17  1091  	struct amd_cpudata *cpudata;
009d1c29a45194 Mario Limonciello 2025-01-17 @1092  	union perf_cached perf;
ec4e3326a95507 Huang Rui         2021-12-24  1093  
009d1c29a45194 Mario Limonciello 2025-01-17  1094  	cpudata = policy->driver_data;
009d1c29a45194 Mario Limonciello 2025-01-17  1095  	perf = READ_ONCE(cpudata->perf);
ec4e3326a95507 Huang Rui         2021-12-24  1096  
a6b5fc5470a623 Mario Limonciello 2026-03-12  1097  	return sysfs_emit(buf, "%u\n", cpudata->max_freq);
ec4e3326a95507 Huang Rui         2021-12-24  1098  }
ec4e3326a95507 Huang Rui         2021-12-24  1099  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
