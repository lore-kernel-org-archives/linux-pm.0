Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22D30C16A;
	Mon, 12 Oct 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832989; cv=none; b=gh8uQb5ubSPOMvT6l4IqTtrZgSx8LvnNYOhN3cC05WAQhVZN/E6+HH5BOtCGOKXxBcRLke6PORt8U3vSUCHpgq/nRRPVukrgEmWnvud0pbz2NB89ZA0cs6oclJ5vzdR+M0qgkQqJnzU26LHdtvvfeX6bIKlN6e5uBNbJrd2hx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832989; c=relaxed/simple;
	bh=aEMXdSzUH/G6GQtYDJEHN5ukFFPX68D3gc2cPVAk+Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzuo7rPEVVlq5Hu4uEz9RA2nK31XS5sODmxpHDK/uj9/bRqymvWSH6l4iQ+bd8bYUPY5AlHb0BR805Ca4SD/eyXH2IwNsy8sV+Z5k2bYM5JEhmB9v6Ci0I5USo2vR+Iu8yA3+ZGI71rmC4NrF4IQtAJFGXP1l8peUBGPWaQPkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRTwwDsr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRTwwDsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791832987; x=1823368987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aEMXdSzUH/G6GQtYDJEHN5ukFFPX68D3gc2cPVAk+Rk=;
  b=YRTwwDsrpU80RCzI/y4lzUnk2EI5SJeC32W1zEraIgkHDi4HT6ZRui1z
   0qxN1jaaK9xnn/0cVqpqhUehcWWRn4E696gumbSwM/3a7dpSB1JBRhCqu
   XSPNSctC47uYH3h2ADBy3TTAEWMHuKWdG4DyiWl6XP89WK5SBvlVt8+ZQ
   yzR0tkAlXcCDleAe/ypK+fj8sK23UjJrIeYox4gBrX8iDrWXRrIFpVs2J
   MbnHwJa6ymtspp5Z3zVf174nF/sq94xR6kja7Gxw/93i1oUNvb+Uu4QlW
   0fGfgjEa9TYLe1jmaGwJsrJSElSVVXmIgIDpUK/a1Ofr2iVuGQ7Y6LG0B
   g==;
X-CSE-ConnectionGUID: D/tmCMPSRcGDwnJZwl5SzQ==
X-CSE-MsgGUID: vEpS2ZshSzq6Fbvn8B/Dxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="433637"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="433637"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 12:23:07 -0700
X-CSE-ConnectionGUID: Tn6CMk/RRluNiUTPzJO4sA==
X-CSE-MsgGUID: xjgxB+VSTQuve0XQbftHSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1302688"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Oct 2026 12:23:01 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGLbu-00000000C2C-12qa;
	Mon, 12 Oct 2026 19:22:58 +0000
Date: Tue, 13 Oct 2026 03:22:27 +0800
From: kernel test robot <lkp@intel.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	avaneesh.dwivedi@oss.qualcomm.com,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v16 2/6] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Message-ID: <202610130349.c7FTyYw4-lkp@intel.com>
References: <20261007-pscrr-framework-v16-2-3642c277bebb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-pscrr-framework-v16-2-3642c277bebb@oss.qualcomm.com>

Hi Faruque,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5c4d4169604b335c38bbc79bc1fc03042981fc6f]

url:    https://github.com/intel-lab-lkp/linux/commits/Faruque-Ansari/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20261007-123636
base:   5c4d4169604b335c38bbc79bc1fc03042981fc6f
patch link:    https://lore.kernel.org/r/20261007-pscrr-framework-v16-2-3642c277bebb%40oss.qualcomm.com
patch subject: [PATCH v16 2/6] reboot: hw_protection_trigger: use standardized numeric shutdown/reboot reasons instead of strings
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20261013/202610130349.c7FTyYw4-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261013/202610130349.c7FTyYw4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610130349.c7FTyYw4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/macsmc-power.c:587:25: error: incompatible pointer to integer conversion passing 'char[37]' to parameter of type 'enum psc_reason' [-Wint-conversion]
     587 |                 hw_protection_trigger("Battery voltage below design minimum", 1500);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/reboot.h:276:58: note: passing argument to parameter 'reason' here
     276 | static inline void hw_protection_trigger(enum psc_reason reason,
         |                                                          ^
   1 error generated.


vim +587 drivers/power/supply/macsmc-power.c

0ebf821cf6c75de Hector Martin     2026-02-17  554  
0ebf821cf6c75de Hector Martin     2026-02-17  555  static void macsmc_power_critical_work(struct work_struct *wrk)
0ebf821cf6c75de Hector Martin     2026-02-17  556  {
0ebf821cf6c75de Hector Martin     2026-02-17  557  	struct macsmc_power *power = container_of(wrk, struct macsmc_power, critical_work);
0ebf821cf6c75de Hector Martin     2026-02-17  558  	u16 bitv, b0av;
0ebf821cf6c75de Hector Martin     2026-02-17  559  	u32 bcf0;
0ebf821cf6c75de Hector Martin     2026-02-17  560  
0ebf821cf6c75de Hector Martin     2026-02-17  561  	if (!power->batt)
0ebf821cf6c75de Hector Martin     2026-02-17  562  		return;
0ebf821cf6c75de Hector Martin     2026-02-17  563  
0ebf821cf6c75de Hector Martin     2026-02-17  564  	/*
0ebf821cf6c75de Hector Martin     2026-02-17  565  	 * Avoid duplicate atempts at emergency shutdown
0ebf821cf6c75de Hector Martin     2026-02-17  566  	 */
0ebf821cf6c75de Hector Martin     2026-02-17  567  	if (power->emergency_shutdown_triggered || system_state > SYSTEM_RUNNING)
0ebf821cf6c75de Hector Martin     2026-02-17  568  		return;
0ebf821cf6c75de Hector Martin     2026-02-17  569  
0ebf821cf6c75de Hector Martin     2026-02-17  570  	/*
0ebf821cf6c75de Hector Martin     2026-02-17  571  	 * EMERGENCY: Check voltage vs design minimum.
0ebf821cf6c75de Hector Martin     2026-02-17  572  	 * If we are below BITV, the battery is physically exhausted.
0ebf821cf6c75de Hector Martin     2026-02-17  573  	 * We must shut down NOW to protect the filesystem.
0ebf821cf6c75de Hector Martin     2026-02-17  574  	 */
0ebf821cf6c75de Hector Martin     2026-02-17  575  	if (apple_smc_read_u16(power->smc, SMC_KEY(BITV), &bitv) >= 0 &&
0ebf821cf6c75de Hector Martin     2026-02-17  576  	    apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &b0av) >= 0 &&
0ebf821cf6c75de Hector Martin     2026-02-17  577  	    b0av < bitv) {
0ebf821cf6c75de Hector Martin     2026-02-17  578  		power->emergency_shutdown_triggered = true;
0ebf821cf6c75de Hector Martin     2026-02-17  579  		dev_emerg(power->dev,
0ebf821cf6c75de Hector Martin     2026-02-17  580  			  "Battery voltage (%d mV) below design minimum (%d mV)! Emergency shutdown.\n",
0ebf821cf6c75de Hector Martin     2026-02-17  581  			  b0av, bitv);
0ebf821cf6c75de Hector Martin     2026-02-17  582  
0ebf821cf6c75de Hector Martin     2026-02-17  583  		/*
0ebf821cf6c75de Hector Martin     2026-02-17  584  		 * Shutdown is now imminent. Kick userspace again and give it some
0ebf821cf6c75de Hector Martin     2026-02-17  585  		 * brief time to (hopefully) flush what's needed, before forcing.
0ebf821cf6c75de Hector Martin     2026-02-17  586  		 */
0ebf821cf6c75de Hector Martin     2026-02-17 @587  		hw_protection_trigger("Battery voltage below design minimum", 1500);
0ebf821cf6c75de Hector Martin     2026-02-17  588  	}
0ebf821cf6c75de Hector Martin     2026-02-17  589  
0ebf821cf6c75de Hector Martin     2026-02-17  590  	/*
0ebf821cf6c75de Hector Martin     2026-02-17  591  	 * Avoid duplicate attempts at orderly shutdown.
0ebf821cf6c75de Hector Martin     2026-02-17  592  	 * Voltage check is above this as we may want to
0ebf821cf6c75de Hector Martin     2026-02-17  593  	 * "upgrade" an orderly shutdown to a critical power
0ebf821cf6c75de Hector Martin     2026-02-17  594  	 * off if voltage drops.
0ebf821cf6c75de Hector Martin     2026-02-17  595  	 */
0ebf821cf6c75de Hector Martin     2026-02-17  596  	if (power->orderly_shutdown_triggered || system_state > SYSTEM_RUNNING)
0ebf821cf6c75de Hector Martin     2026-02-17  597  		return;
0ebf821cf6c75de Hector Martin     2026-02-17  598  
0ebf821cf6c75de Hector Martin     2026-02-17  599  	/*
0ebf821cf6c75de Hector Martin     2026-02-17  600  	 * Check if SMC flagged the battery as empty.
0ebf821cf6c75de Hector Martin     2026-02-17  601  	 * We trigger a graceful shutdown to let the OS save data.
0ebf821cf6c75de Hector Martin     2026-02-17  602  	 */
f7b253a6e217f71 Sasha Finkelstein 2026-07-12  603  	if (macsmc_battery_read_bcf0(power, &bcf0) == 0 && bcf0 != 0) {
0ebf821cf6c75de Hector Martin     2026-02-17  604  		power->orderly_shutdown_triggered = true;
0ebf821cf6c75de Hector Martin     2026-02-17  605  		dev_crit(power->dev, "Battery critical (empty flag set). Triggering orderly shutdown.\n");
0ebf821cf6c75de Hector Martin     2026-02-17  606  		orderly_poweroff(true);
0ebf821cf6c75de Hector Martin     2026-02-17  607  	}
0ebf821cf6c75de Hector Martin     2026-02-17  608  }
0ebf821cf6c75de Hector Martin     2026-02-17  609  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
