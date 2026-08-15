Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE454192F7;
	Sat, 15 Aug 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786798337; cv=none; b=iVs9X81QS5azsWaog+b8RD63f6l5qkqtFutrhXT/sf/njNSSM8WvV3nW9/FJ9mRtY/bq5HLzNS7/2KoWWi4n277IS2q4czAcoZHMMubJowjpxtb0oO9Ml6CLiR3+YL5slNugSUQvxcpA8j1MMKIFEgc0Bzq28urxILOt0y5SD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786798337; c=relaxed/simple;
	bh=Umy4SAEo6uAoGiafMqH/85OiBfhesCYOE6/0DYL77NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJSDVW+mNFOllhrilTwz5JQwnlfgn/HwlFO2rayV4zw8Fnm8z3ZCRWx+PkkI3SSmZDsoAjkBAa5vQInro/2R/fYa90vQNT9iG0i48EzIXrf7A180Ae+DaFdltcPjE/wbinGfyvHaTY/jbPVbTtvKzdO2xwOPuNWZGvguOq95T/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ex7HRrY0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ex7HRrY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786798336; x=1818334336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Umy4SAEo6uAoGiafMqH/85OiBfhesCYOE6/0DYL77NA=;
  b=Ex7HRrY0fl9nSE5da93WYZ1i0wqoZECYeDp0ietU41l8bkFKis0tkQH+
   kI9J4BAFT2jc+8B+n0HyxkF1f56tplpG4lU0ObJcWDOiLpyK8235jsaLh
   EKyNXqIt0rmJtn6tAwoUqMTQ7G5X5fjbftLZtXDWNQFPegOLg/PH/5Odb
   iZ7jfJ9dlerhrB5snruuUCKXrpPLw49JKR/cpfx2x3iVo4C9Y4vMxVVUU
   iXWU5NxTp14WByxpyXUifYbUYZjF/dU7UASeHupYfy9z6tmf860IYGJeQ
   4j3dm8bNHg545lZeu5ok8IxGF6EJf8xy9bxT2W6ZL68l9mD7pUvkAV9ur
   w==;
X-CSE-ConnectionGUID: d8Sd3b6jR56VU6JVfVhZfg==
X-CSE-MsgGUID: nG+N2dvoQTuqf4IX2nt6Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="91023688"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="91023688"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 05:52:15 -0700
X-CSE-ConnectionGUID: qgYPuavERiqmzOgHBS5DTA==
X-CSE-MsgGUID: 5SFEft+rQ2uPG02kkBDAnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="268323227"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Aug 2026 05:52:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvDru-00000000c1y-1d3n;
	Sat, 15 Aug 2026 12:52:10 +0000
Date: Sat, 15 Aug 2026 20:51:37 +0800
From: kernel test robot <lkp@intel.com>
To: jipinghuang <jipihuan@qti.qualcomm.com>, rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jipinghuang <jipihuan@qti.qualcomm.com>
Subject: Re: [PATCH] Fixed a bug related to thermal framework boundary
 conditions: trip points do not need to be updated when polling is active,
 whereas they must be update to re-enable the irq when polling is inactive
Message-ID: <202608152020.udg9HfCU-lkp@intel.com>
References: <20260728024856.1596951-1-jipihuan@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728024856.1596951-1-jipihuan@qti.qualcomm.com>

Hi jipinghuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v7.2-rc7 next-20260813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jipinghuang/Fixed-a-bug-related-to-thermal-framework-boundary-conditions-trip-points-do-not-need-to-be-updated-when-polling-is-activ/20260814-212058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20260728024856.1596951-1-jipihuan%40qti.qualcomm.com
patch subject: [PATCH] Fixed a bug related to thermal framework boundary conditions: trip points do not need to be updated when polling is active, whereas they must be update to re-enable the irq when polling is inactive
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260815/202608152020.udg9HfCU-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608152020.udg9HfCU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608152020.udg9HfCU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/thermal/thermal_trip.c:64:83: error: use of undeclared identifier 'trip_temp'
      64 |         if (tz->prev_low_trip == low && tz->prev_high_trip == high && tz->temperature >= trip_temp)
         |                                                                                          ^~~~~~~~~
   1 error generated.


vim +/trip_temp +64 drivers/thermal/thermal_trip.c

    53	
    54	void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
    55	{
    56		int ret;
    57	
    58		lockdep_assert_held(&tz->lock);
    59	
    60		if (!tz->ops.set_trips)
    61			return;
    62	
    63		/* No need to change trip points */
  > 64		if (tz->prev_low_trip == low && tz->prev_high_trip == high && tz->temperature >= trip_temp)
    65			return;
    66	
    67		tz->prev_low_trip = low;
    68		tz->prev_high_trip = high;
    69	
    70		dev_dbg(&tz->device,
    71			"new temperature boundaries: %d < x < %d\n", low, high);
    72	
    73		/*
    74		 * Set a temperature window. When this window is left the driver
    75		 * must inform the thermal core via thermal_zone_device_update.
    76		 */
    77		ret = tz->ops.set_trips(tz, low, high);
    78		if (ret)
    79			dev_err(&tz->device, "Failed to set trips: %d\n", ret);
    80	}
    81	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
