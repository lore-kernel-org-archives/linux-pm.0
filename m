Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406508;
	b=pSGYrDUuXKmMEfEDkvvD7YiXI66VZDlFPmADegQHr9UpDNFRZ5uS+f6s6cKoLpHrHmPP
	 nh+TTZbT20H2SjttTXJhI8k8fJ2/6yAqiNjdR7auaS4UN59XUDhSgNtcRo9EjxMJsQNu5
	 bYeOzLgiz6SaeXugZbEKZjCF4kq1pO983KCmdwD7/TuSevbByHG33mheNyVTriVhv7ugS
	 H063HIlPQXgFRG/+35pbsTObsjFT2IP9RV3ZPdFAt4kpDE/68+SksCGRcIbftZbG4inV7
	 +1lgtu6vVOYMSqawD2jpQQko9CsN4n4M/CyujwDNucrE/RH4xnvj3T5jLG6jrmemh3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406508;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RRKrPiiXLxIqqSj5iQKbou4siQUwjTukbqJQ8BaYzM0=;
	b=oB8KrxGhBmzd/H/Gk6rwir4XYVpwXpdWOaggjjQYTX9xsZOZE3MOZDKuQ2+CVMobpOtg
	 1YohUKFy42RVvWt6tsOxFffwyDhwyVRMAxaH8LTljzGBVu6r9TMEH7x6Ty43yOpOnEI7w
	 Iopvyawvv9qju1bKk/plQEvVIiRzLXjTjIkYr6KD3yXzW7OP09TfDPh0tlIH/bc/g1yIV
	 lER4UKjx18VPmy2tFC4wmZ9/MW3By/bLHDIoHE+N0hNyI0qLGtrJqzJZRrfFf8R+C5rqG
	 Q/AanUUV1ySQwFYqFCBCnZLZ3+fT/U6ccHoDbLwA1voh1CGA3UIj4ND9wkT0Wa8xBNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmcpmJrs;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB70606A334;
	Wed, 11 Nov 2026 14:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB70606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmcpmJrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794406507; x=1825942507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FYWLjmEyrSr5TGZ1v1f2UI6FyVNvdj9IceZa13vfjIY=;
  b=lmcpmJrsuMgWKU2qIpXa1N71U/OSi1JA8slN454odjMspoWwDG0IvGGf
   XmSKpR1B59rtFrrDy2r4MzyPQEfkixKPX6P+3CoAz6o3xROXUko1ZdXiw
   2ZPN8UM4f7GjT0QoCinYAf66lrtHHQGl1QswHjmh/vE5FqJ3F454eM0/j
   6hTdnk6sHGilnVOVWjuWmr8p25JUoVHP5LXDO0vJfKj9NedjfU2yGjVK+
   OWGWeaFtU6lUQ49M4IiozkEx0GGYek9a2lBNxujki0qa9URSel4x5FYNF
   Buphf8fnWgAYR+ud/LFTdR9cOb95UWZMa/W1F2jRzAOg2EXgFKogxN12Z
   Q==;
X-CSE-ConnectionGUID: Me4vqCoMQ0ugg9cQlzpPaw==
X-CSE-MsgGUID: gLyZldH0RUOcH3ZJo553CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3175625"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3175625"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:15:01 -0800
X-CSE-ConnectionGUID: fJ2hYlQmRhGtC2EHUopSdg==
X-CSE-MsgGUID: 641PaO2GQqyGf0BX8BN1Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8424156"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Nov 2026 06:14:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xR96E-00000000yzd-0mnJ;
	Wed, 11 Nov 2026 14:14:54 +0000
Date: Wed, 11 Nov 2026 22:14:12 +0800
From: kernel test robot <lkp@intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, zhanjie9@hisilicon.com,
	christian.loehle@arm.com, zhenglifeng1@huawei.com,
	sumitg@nvidia.com, lenb@kernel.org, maciej.wieczor-retman@intel.com,
	pawel.chmielewski@intel.com, gregkh@linuxfoundation.org,
	dakr@kernel.org, johan@kernel.org, ionela.voinescu@arm.com,
	pierre.gondois@arm.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, driver-core@lists.linux.dev,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: Re: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity()
 for runtime updates
Message-ID: <202611112222.Q0bXZAjq-lkp@intel.com>
References: <20261111085022.1229866-4-luoxueqin@kylinos.cn>
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
In-Reply-To: <20261111085022.1229866-4-luoxueqin@kylinos.cn>

Hi Xueqin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.4-rc2]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge next-20261110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xueqin-Luo/cpufreq-cppc-Add-update_limits-support-for-Highest-Performance-changes/20261111-165020
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20261111085022.1229866-4-luoxueqin%40kylinos.cn
patch subject: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20261111/202611112222.Q0bXZAjq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611112222.Q0bXZAjq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611112222.Q0bXZAjq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/seqlock.h:20,
                    from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:17,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:14,
                    from drivers/base/arch_topology.c:9:
>> drivers/base/arch_topology.c:232:21: warning: 'raw_capacity_lock' defined but not used [-Wunused-variable]
     232 | static DEFINE_MUTEX(raw_capacity_lock);
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/mutex.h:87:22: note: in definition of macro 'DEFINE_MUTEX'
      87 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~


vim +/raw_capacity_lock +232 drivers/base/arch_topology.c

   230	
   231	static u32 *raw_capacity;
 > 232	static DEFINE_MUTEX(raw_capacity_lock);
   233	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
