Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF0284B2F;
	Sun,  2 Aug 2026 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704183; cv=none; b=TBQrVFMQQbCEp/lC64a5FTmMi0ZFMJhHMesTt6kDOT7n+S7CYDjqiNqdzUQkEI+ZmA4eC0ttBkSQB1iqrqZBvnr0ZMyG4EsuD2/yybfftDZYHZ9nu0EXLrKBAn8XljLXDbfptnOObNynx1img/qODlLCKwCeXu49VkFFjuq+nS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704183; c=relaxed/simple;
	bh=KV/jXwvpNTbbniz7PyWwfckoyDbQ7xhwtiWUxuOwzkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVyBRpOtZ6eEYA8NRIxd4YErBpvnYZIlR1cDx7cLgy05aCH9H/7DCUAul/FovsXIiNLd/ADBq12ARf1F/ai4hQmIqdrFq6s4G5Ot/+xgxd1iwUM45MfKrvhWPNWUZK5tDOThqPym2nrlvZHetKZ1pnVuEzRYYB6abOKaLmpD/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5ekza/j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5ekza/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785704181; x=1817240181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KV/jXwvpNTbbniz7PyWwfckoyDbQ7xhwtiWUxuOwzkI=;
  b=Q5ekza/j5VannrQA0lieEAw/1HoOhisnPnhiG0gNEFSOIBK7gJ6oS++C
   0Ke0F2zxM5Kc7Ce+vJ6Q2fy/dsEDlBWMCGGoPnUKQJBCvxsxuRrjPxAyj
   CcKlvbjz/ya5fGFhQEFAYWN0Fzs4+6XBs4XsiebLMaocGBLB3/Kl7AZty
   iL1RLUKmp4WHnxtheka1n1WlCZfOV3arusex5lGJ1BFUBqIgblzKcddp0
   1lxJB5SPD7YbONIa9EcWFr3Ei4tO1sJCoA9PRkAmEqR0zY9UYAG+Zei84
   eQvW1G1yjFgaO+fH+HJrlBCXBcl4GTGDJMZCiJgGJnGUN7cJFFTPAFZKr
   A==;
X-CSE-ConnectionGUID: buPXJtnaQAG2WkvCzQRyFw==
X-CSE-MsgGUID: gfBk/kdfTMGu+ODpIrVKnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="96606350"
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="96606350"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2026 13:56:20 -0700
X-CSE-ConnectionGUID: fh7N4PkDQte8Bth89CxopA==
X-CSE-MsgGUID: OiQkEuoeRXy/a9IxvFMMcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,201,1779174000"; 
   d="scan'208";a="258379363"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Aug 2026 13:56:17 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqdEE-000000005XF-3ot7;
	Sun, 02 Aug 2026 20:56:14 +0000
Date: Mon, 3 Aug 2026 04:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: jipinghuang <jipihuan@qti.qualcomm.com>, rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	jipinghuang <jipihuan@qti.qualcomm.com>
Subject: Re: [PATCH] Fixed a bug related to thermal framework boundary
 conditions: trip points do not need to be updated when polling is active,
 whereas they must be update to re-enable the irq when polling is inactive
Message-ID: <202608030411.IDGREI1x-lkp@intel.com>
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
[also build test ERROR on linus/master v7.2-rc5 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jipinghuang/Fixed-a-bug-related-to-thermal-framework-boundary-conditions-trip-points-do-not-need-to-be-updated-when-polling-is-activ/20260727-115235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20260727035037.554303-1-jipihuan%40qti.qualcomm.com
patch subject: [PATCH] Fixed a bug related to thermal framework boundary conditions: trip points do not need to be updated when polling is active, whereas they must be update to re-enable the irq when polling is inactive
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260803/202608030411.IDGREI1x-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260803/202608030411.IDGREI1x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608030411.IDGREI1x-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/thermal_trip.c: In function 'thermal_zone_set_trips':
>> drivers/thermal/thermal_trip.c:64:90: error: 'trip_temp' undeclared (first use in this function)
      64 |         if (tz->prev_low_trip == low && tz->prev_high_trip == high && tz->temperature >= trip_temp)
         |                                                                                          ^~~~~~~~~
   drivers/thermal/thermal_trip.c:64:90: note: each undeclared identifier is reported only once for each function it appears in


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
