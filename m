Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9E24E4B5;
	Mon, 27 Jul 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142674; cv=none; b=TUDduvhV75jRFOObi0unnCkqtyQ5sbgZWcWvELPVdd99swDyC3YqBdd1+TxdkJbZD0M8nRaRS45BfMV57LNtrvIMchkQiFApg6LhpghSTS7apWoqw1uO2jkhA2dxmIKxyrjliQ1HAkFnLGljgzRso9AC4IiOZhpFFmsGkg+OirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142674; c=relaxed/simple;
	bh=mxpP9sPzkaYZexQunonZZ90WRjtP2+ZYEK6ntiR06rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwg4gVPvJsZTpE2k1RdO7skaVrLC2XvWSu/+nR/OgLtW+3u2tXXi5ZNYMiLED4nwWLAg/mvAlALksr2EfTMdE9S5q7anijZM5cbbgarN+pTITVVPdpA1xX5vTY4o0C7qbdoh8mFRMIR6K8hnCMlv4InWIx/ZU05+53MiHkrf9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEhqtWA6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEhqtWA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142673; x=1816678673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mxpP9sPzkaYZexQunonZZ90WRjtP2+ZYEK6ntiR06rQ=;
  b=IEhqtWA6yj6YVUetwBlGt6VcAF/e/OdXoLAL6uIgyWSvHhMoKin7yUDt
   lYqLJ+nlGuDmXV2mOduk8h688i2sWtZLgEG4JC2FDCUCqpExYfLIJWodo
   cxEP1IY4KbeQ/6QEYzTQ6KSZoxRCYj+LPRHBiWXJx5Tbdyq/LT63o0oyS
   afuVufbflEBf9jbcm7FEvUEDf6YjKEhUwo9svNH/KGuiEjHby56851tBH
   4H/MXaknw9cLDy4sAVQmO4B0uVOKnZkN+bqsGqPzI1WtxWT7RHTEkflPL
   PGNrYNQpwD5LalVbO6kw2oqghQTXY2mdgFiHtLV1zi2aA4CFkP+cHriOh
   w==;
X-CSE-ConnectionGUID: EsA0zF4MRk+LCapFW1yUWg==
X-CSE-MsgGUID: v/5WWheKQaytwiH+n/NxYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="108501649"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="108501649"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:57:53 -0700
X-CSE-ConnectionGUID: zpKmsKZ+SX+xdZipXCDNXQ==
X-CSE-MsgGUID: 3azGLN+mQri82v+vZegZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="257568330"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 27 Jul 2026 01:57:51 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1woH9g-000000001YE-1ZVi;
	Mon, 27 Jul 2026 08:57:48 +0000
Date: Mon, 27 Jul 2026 10:57:25 +0200
From: kernel test robot <lkp@intel.com>
To: jipinghuang <jipihuan@qti.qualcomm.com>, rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	jipinghuang <jipihuan@qti.qualcomm.com>
Subject: Re: [PATCH] Fixed a bug related to thermal framework boundary
 conditions: trip points do not need to be updated when polling is active,
 whereas they must be update to re-enable the irq when polling is inactive
Message-ID: <202607271036.K1hH4r4a-lkp@intel.com>
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
config: x86_64-rhel-9.4-bpf (https://download.01.org/0day-ci/archive/20260727/202607271036.K1hH4r4a-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260727/202607271036.K1hH4r4a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607271036.K1hH4r4a-lkp@intel.com/

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
