Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547919;
	b=cPcnZMHciJ5Av5OvHBptFNkVX0RylREnX2sllqPG7hLec5bnqNHe0enAsFZnOZRteC6f
	 rk/Q7SicyZyvXAoiTD3+oGqwCxnxXUDuugVHz2wteWxXrgyQAqag160e7bw2KpMbDPR16
	 mlRv/GBHx9TbN10aNlZ7XsRefVylZ3OWmKHkPj9A3RUHBX1jO7oIosZcofmSa+VTjPA32
	 l77mT5GgmQE4xfZVBkjEAIZ0umq4f/UWd+xWQDt9BNRoTtgIR2iHL2ghXkCrHY4NfxsS2
	 0coqh4bbGblGxDIvqVCN3yQvYDJf1Y3ZpPz9Cfc7UQxhprNGpvjEiJ1x5fd71fQrY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547919;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ba6WMI+eH0A0XYWzYjkOrHuY+1qhzJ7ZLbDOBJrgo58=;
	b=I6XZgAnEbnu2qikvqtXRWgeiad2EA9nZlBPuYEsmI91ivaKNB6elSvhphPA5eTotjV70
	 ztAru67CofZXLgKKM9mIP1J1n/Ykp6Su5x9LSpEkjKivgDVyyZYK3xVKJ77Hulyggh5Gh
	 0Bl363GWxP80FxV843Sl4RHKs5eBrazZ+yV+Mli62/a7tvBvq7Fvyfmsvjx8uEb9OmriR
	 ZRGQvg5z0YIzEb6ND4VpmMk5SJzxpOL12rP9/NFX6vazdeQMx5DGMt5x9iEmSnizdvG8e
	 +5wuXqyvE3wnNoRRB1+phprlj3QsNZ9B05J0CNl/UjBkJuJVKM39oNuc6cjH/qmygxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="FE6P8j/0";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F7606A323;
	Fri, 13 Nov 2026 05:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105F7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FE6P8j/0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794547917; x=1826083917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wU1MQ3okr3j4hH5DB7t1ThuMNxBMz1z5jxvll2cwO8E=;
  b=FE6P8j/0c+Np920CAIEf+t4AB5Mv/fr/koSl6q2XDdU6SA8gVXOHrskK
   7SPKP2fiADk5QNqqeidk9cKY/pr35Zls3Fx/rVYIYMLXbsr8V4YpyI6JX
   H38IVJ/pcbRI17ucjZfRP3/kXq2VqTQqanR98fEPkn5bSNNVfmDSZkd/e
   M3zzNf7ddGhwgdRCiVw9VJSQiNz4w1ydoAiJXy6/8ycUxFKTUw3OlzhkV
   jlcF3aNZF3oMUDRxTIcJ8uYgV/HegQPPrk3Gmpn2K1/jSP1OCMJb/N3fo
   4nxGZa02HMoapubK3Fh+k765UnGRQ6eSqWNflC42+ZyxtTtG9DNiWF+QA
   g==;
X-CSE-ConnectionGUID: LKgUUIUeRLmWMmCDzDmy3A==
X-CSE-MsgGUID: LSuaFt6eRemPYkRdV/39+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3333629"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3333629"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 21:31:56 -0800
X-CSE-ConnectionGUID: PJtJPZlQTpK0EHcF36dOgQ==
X-CSE-MsgGUID: 6NTBylRbQt+nZaN19ITuWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9179999"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2026 21:31:52 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRjt6-000000012QV-1CP8;
	Fri, 13 Nov 2026 05:31:48 +0000
Date: Fri, 13 Nov 2026 13:31:22 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 12/20 v3] sched/fair: Support not wakeup case in
 select_idle_sibling
Message-ID: <202611131321.iXTrhEmV-lkp@intel.com>
References: <20261106151947.3991524-13-vincent.guittot@linaro.org>
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
In-Reply-To: <20261106151947.3991524-13-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[cannot apply to peterz-queue/sched/core amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.4-rc2 next-20261111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-eevdf-Reset-lag-at-wakeup-when-prev-CPU-has-been-idle/20261106-161929
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20261106151947.3991524-13-vincent.guittot%40linaro.org
patch subject: [PATCH 12/20 v3] sched/fair: Support not wakeup case in select_idle_sibling
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20261113/202611131321.iXTrhEmV-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261113/202611131321.iXTrhEmV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611131321.iXTrhEmV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/sched/fair.c:12994 function parameter 'rq' not described in 'idle_rq_without'
>> Warning: kernel/sched/fair.c:12994 Excess function parameter 'cpu' description in 'idle_rq_without'
>> Warning: kernel/sched/fair.c:12994 function parameter 'rq' not described in 'idle_rq_without'
>> Warning: kernel/sched/fair.c:12994 Excess function parameter 'cpu' description in 'idle_rq_without'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
