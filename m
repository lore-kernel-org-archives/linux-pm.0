Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B23BBFD8;
	Mon, 27 Jul 2026 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139614; cv=none; b=Y64Sb9T+GK0bzi+erHnVvWkX/LB+fzscJClfQ9hF3IOOnuHEO8RUq/pvodU8onudslZgX+TGbbSDJy8/+VrutzDDYy/a5leyHehNqvHHQiDSsqyr8+kYIDj7Lafwq+PgoGNnqkBlepm7E2jM6Lf2/beayWylXlnY6HU7q3sgZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139614; c=relaxed/simple;
	bh=KnU0D/LiroEaALd+3d0b3S9nheiF6IAaanFOXkI4ehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egxT5rv9awShCRuUCv85ji0BaV8mq8QSxagDQHoUeWsT4q3lz64fF0yHCBel/bqKA5Xi//H6ikcl0UavTujn/7VPbhJTW6V2m4Oe0roE9NMMPRzaP2kR7DNfpkLTV74DfryMCppJ6K6+Ujim0cz2q77ybMlMgQhkE9IVEb6vV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNR1IUIc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNR1IUIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785139611; x=1816675611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KnU0D/LiroEaALd+3d0b3S9nheiF6IAaanFOXkI4ehc=;
  b=dNR1IUIcGjqPluL6K7GT/lsgnn26R7KzMyJJrbqFJhtz8P9hUzAqLgv3
   xk4Jd59BhLiGimuyIBYK2w4+gG38VFLwYEWKJY60kA1oriGdYkOFLXz2Y
   pjmCtQf8Z0gIECOnnw0ewJZyN+KBUtOK+gvvDbwtj8YpVjItEer9dkS9J
   ht1IG4k/+9DTlEhZmvEMeRL6niZYjMiq+O7wHlV20qeHEskIpFoney3bF
   iXQXbL479dRU8nwcO8yYKEwBItJTORXTQWWAD8+r4Nu9WElsylxAyeWaN
   uooZyFtkL7kkSiKrMe+tpmCGeC5jA5pT+AOHXJM3A3ZRF7lx5VSwM87F9
   A==;
X-CSE-ConnectionGUID: /zfcCTbeQM2M48PVF/fNEg==
X-CSE-MsgGUID: M7gEbrYWQq6PhzX/mi5pYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="89526918"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="89526918"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:06:50 -0700
X-CSE-ConnectionGUID: AXbDLOhyQtmBf/KFE0UOwA==
X-CSE-MsgGUID: rxkjCoCgTg+tR2ivBWo7IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="259412904"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 27 Jul 2026 01:06:48 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woGMH-000000001Y2-3J6W;
	Mon, 27 Jul 2026 08:06:45 +0000
Date: Mon, 27 Jul 2026 10:06:13 +0200
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
Message-ID: <202607271050.J6ZhMOwT-lkp@intel.com>
References: <20260727035037.554303-1-jipihuan@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727035037.554303-1-jipihuan@qti.qualcomm.com>

Hi jipinghuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v7.2-rc5 next-20260726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jipinghuang/Fixed-a-bug-related-to-thermal-framework-boundary-conditions-trip-points-do-not-need-to-be-updated-when-polling-is-activ/20260727-115235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20260727035037.554303-1-jipihuan%40qti.qualcomm.com
patch subject: [PATCH] Fixed a bug related to thermal framework boundary conditions: trip points do not need to be updated when polling is active, whereas they must be update to re-enable the irq when polling is inactive
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260727/202607271050.J6ZhMOwT-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260727/202607271050.J6ZhMOwT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607271050.J6ZhMOwT-lkp@intel.com/

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
