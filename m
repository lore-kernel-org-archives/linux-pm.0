Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425510;
	b=f5Uwy2vZaZUr1Dgh1H1zZCDuhyQ01zIw0ibfUWrv4vI+mJh9IHbt8EP1DXz+9IKAK0bb
	 jW5zxbZG+1LKo1rt/56A79yODa3yagAq6EGmGaPeHqBtVqXAgQ7KRQgF0D44Y7wCsgXKS
	 VSnMvu15pGpZPB+00/8rLuTSKb12d2ChsrksB+aVGie/FxvkixiZ6FokZZ3tQH2juyUSn
	 ZO65xuC6WbTxaa9AImomVlsr/n3/UB0xvjXgpc3mp6DTzLAImv2dW/8q+lmzOmkCBqWVa
	 aJ3GQlICnR+u4oS1MheltELvLidV6NH0paGc91TQtLkvSjw9uSimVw1JH1+wrnsY65g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ihmjpaq362zzdxmp/sT8AuTP1S4oabw2RE04rYS9y5E=;
	b=mux3ma5/URXJN4K16+BwfnQiuc6dNahgx++4vOeAnLvftnlW1gAcVmkm6QP8MNOYIwIA
	 oVQ8HK64RzrwGE98UkDLLQz0JaQOhMzpu4+o2nszS2vY3ME2DlwMMpPa4F65e1bs33Hm6
	 olTA8x2x626weLig76QC2/Sne+ad5L5kM+3CqjvtSbKMh0s9xVdoB8CVbwj2aOTJlqYxC
	 g7bavhNVOtvLzVwmQuTpC44paWk9AoVRtR1oe/0VZWPvSegmSo3IyryE54HqRyI5T/lvP
	 GyBUc/NuBgcad/6dF7LR2vDz+yy1rqA4IsXcx8LbmpnGV0z2caBQyN5jY3Vle4v9liw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0dFk7c9;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1141606A332;
	Wed, 11 Nov 2026 19:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1141606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0dFk7c9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794425510; x=1825961510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DcTofesJFT1jeKz+4gvXAC2F9ujJKAM96Sgs1nkt01o=;
  b=T0dFk7c9m3m7kFV4rOmhFdAQVhA4EAKbMnU6tKzTmHNAY9tSf3moFCM2
   KkW5lZZ0vJm/Sdy3Mpyq97CUwZeVBDRGwU55IDYyn3+QWvUnibJ475new
   XNKJRvOONmrAXiN9Ya6Kas+JuQQcSNLY0T5XGbySWLtI0ZbEr4mYBKIlO
   xRn9rPoLbS+RM9SnsWUCkSSxCbP0QcvT5mmziO/mvcQGZRzzoeKxSAeBF
   rAdgh2ioWxHtf0/etD4GifkhI9WuSA6XFkBsr2UIznCeuNn1y3TkuGOpJ
   pLTwhmpP6xYYJU8SN6iEfRpQMa2nax60vhzL2L2FswsxD8TRKsUpHjr0q
   Q==;
X-CSE-ConnectionGUID: hurCFDhZRuudM/5K7dOxYg==
X-CSE-MsgGUID: 5w4zhrEGQ5uLcFlZ9HJsQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099038"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099038"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 11:31:49 -0800
X-CSE-ConnectionGUID: 7Qov/K15S6C/fBiJhfO24g==
X-CSE-MsgGUID: l+vjy1i3SXmfMFLMolRq8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8820410"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Nov 2026 11:31:44 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRE2n-00000000zZl-2KpJ;
	Wed, 11 Nov 2026 19:31:41 +0000
Date: Thu, 12 Nov 2026 03:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
	viresh.kumar@linaro.org, sudeep.holla@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	zhanjie9@hisilicon.com, christian.loehle@arm.com,
	zhenglifeng1@huawei.com, sumitg@nvidia.com, lenb@kernel.org,
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
	gregkh@linuxfoundation.org, dakr@kernel.org, johan@kernel.org,
	ionela.voinescu@arm.com, pierre.gondois@arm.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	driver-core@lists.linux.dev, Xueqin Luo <luoxueqin@kylinos.cn>
Subject: Re: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity()
 for runtime updates
Message-ID: <202611120358.5eM3xOiA-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261112/202611120358.5eM3xOiA-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project e73e336290028f26553b46c9fba844c13da38c9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120358.5eM3xOiA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611120358.5eM3xOiA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/arch_topology.c:232:21: warning: unused variable 'raw_capacity_lock' [-Wunused-variable]
     232 | static DEFINE_MUTEX(raw_capacity_lock);
         |                     ^~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/raw_capacity_lock +232 drivers/base/arch_topology.c

   230	
   231	static u32 *raw_capacity;
 > 232	static DEFINE_MUTEX(raw_capacity_lock);
   233	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
