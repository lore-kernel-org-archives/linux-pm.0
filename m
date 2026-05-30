Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E83AFD11;
	Sat, 30 May 2026 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164320; cv=none; b=cOxth6gL5Ked+afPVB14oeAJ22/yrioa0u0oaVaIc2HJiSxt58jNL8Nufh1KWnt2Z0hkUSap0Cfrtz0f9jVDlu6DezYOPndvIgFSp3/gWAcxU6prkHzksafwokL/RqgXSVnujfCNnVBldbLkUP+VhXV5bTtJzhyJY8B8Y6TA8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164320; c=relaxed/simple;
	bh=CmIOsDhzmaoHfGl24Cswm9/46h1EqKgKFEAM5HlR5l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYxvprVh2VLk9gAxoR9G9NKAGchSsiFwCNFK1X8waFE6jxTtKFd76Bf/eEVA2ScpSYCPExASOm/3PsUdR6gWZfHxehDvQVI5uleU/m1Q3xVVG78kJ4C6LINV/PAs5I0tzJ6S1fCZmnQC8pr1FukteCGU7j/CpKtV95NXzhWAwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ET/MXsJl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ET/MXsJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780164319; x=1811700319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmIOsDhzmaoHfGl24Cswm9/46h1EqKgKFEAM5HlR5l8=;
  b=ET/MXsJlRMnRwt4OGGww3YQ/REgWg5XSZ3y4bntO+z5erZnlgYgN1LpQ
   ZXAI6M+JTbMPEgUf0b/3PUo61VtJ4LDFg3ZXKxV2EujVaDsb9DG8OTY4A
   c1MOodLzpHd0pUMW1o97VSsMBqdHbvrJey/FYezUSot+iZ3jOzKFfYlgO
   B/vk2k1/4EEn4tcdosluP6tRZWM8svdxe4SdX2QgTUUjP7eWQZ/gjjZ+d
   z2SvFUaqDIHpzCMWN736u5i7mAleS2B5ESZEqDf9naH54H48TqByKtK8b
   pnwiuagpyQE1O9a5+8YWDEUMbHwbyAxmiI/W8z35i4wQ8c/dwd097dHOM
   g==;
X-CSE-ConnectionGUID: lExS36arQ7qCT4cXz6hbfw==
X-CSE-MsgGUID: W4a6Kyc8Rzmj+5usb6JSPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="103655848"
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="103655848"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 11:05:19 -0700
X-CSE-ConnectionGUID: VCmEDFrQTAinCjDCAOl9rw==
X-CSE-MsgGUID: 1EOOZkKNQ1u+i7ncO+8olQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="281261019"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 May 2026 11:05:14 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTO3b-000000008m2-1KnD;
	Sat, 30 May 2026 18:05:11 +0000
Date: Sun, 31 May 2026 02:04:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Guillaume La Roque <glaroque@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
Message-ID: <202605310154.bmdMBZHJ-lkp@intel.com>
References: <20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr>

Hi Ronald,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3929405c64376a8a54c794e8a4485023b108a97e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ronald-Claveau-via-B4-Relay/firmware-meson-sm-add-stub-functions-when-CONFIG_MESON_SM-is-disabled/20260530-150837
base:   3929405c64376a8a54c794e8a4485023b108a97e
patch link:    https://lore.kernel.org/r/20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4%40aliel.fr
patch subject: [PATCH] firmware: meson: sm: add stub functions when CONFIG_MESON_SM is disabled
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260531/202605310154.bmdMBZHJ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310154.bmdMBZHJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310154.bmdMBZHJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/meson/meson_sm.c:233:27: error: redefinition of 'meson_sm_get'
     233 | struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
         |                           ^
   include/linux/firmware/meson/meson_sm.h:39:41: note: previous definition is here
      39 | static inline struct meson_sm_firmware *meson_sm_get(struct device_node *firmware_node)
         |                                         ^
>> drivers/firmware/meson/meson_sm.c:258:5: error: redefinition of 'meson_sm_get_thermal_calib'
     258 | int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
         |     ^
   include/linux/firmware/meson/meson_sm.h:43:19: note: previous definition is here
      43 | static inline int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw,
         |                   ^
   2 errors generated.


vim +/meson_sm_get +233 drivers/firmware/meson/meson_sm.c

2c4ddb215521d5 Carlo Caione   2016-08-27  225  
8cde3c2153e8f5 Carlo Caione   2019-07-31  226  /**
8cde3c2153e8f5 Carlo Caione   2019-07-31  227   * meson_sm_get - get pointer to meson_sm_firmware structure.
8cde3c2153e8f5 Carlo Caione   2019-07-31  228   *
8cde3c2153e8f5 Carlo Caione   2019-07-31  229   * @sm_node:		Pointer to the secure-monitor Device Tree node.
8cde3c2153e8f5 Carlo Caione   2019-07-31  230   *
8cde3c2153e8f5 Carlo Caione   2019-07-31  231   * Return:		NULL is the secure-monitor device is not ready.
8cde3c2153e8f5 Carlo Caione   2019-07-31  232   */
8cde3c2153e8f5 Carlo Caione   2019-07-31 @233  struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
8cde3c2153e8f5 Carlo Caione   2019-07-31  234  {
8cde3c2153e8f5 Carlo Caione   2019-07-31  235  	struct platform_device *pdev = of_find_device_by_node(sm_node);
8ece3173f87df0 Johan Hovold   2025-07-25  236  	struct meson_sm_firmware *fw;
8cde3c2153e8f5 Carlo Caione   2019-07-31  237  
8cde3c2153e8f5 Carlo Caione   2019-07-31  238  	if (!pdev)
8cde3c2153e8f5 Carlo Caione   2019-07-31  239  		return NULL;
8cde3c2153e8f5 Carlo Caione   2019-07-31  240  
8ece3173f87df0 Johan Hovold   2025-07-25  241  	fw = platform_get_drvdata(pdev);
8ece3173f87df0 Johan Hovold   2025-07-25  242  
8ece3173f87df0 Johan Hovold   2025-07-25  243  	put_device(&pdev->dev);
8ece3173f87df0 Johan Hovold   2025-07-25  244  
8ece3173f87df0 Johan Hovold   2025-07-25  245  	return fw;
8cde3c2153e8f5 Carlo Caione   2019-07-31  246  }
8cde3c2153e8f5 Carlo Caione   2019-07-31  247  EXPORT_SYMBOL_GPL(meson_sm_get);
8cde3c2153e8f5 Carlo Caione   2019-07-31  248  
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  249  /**
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  250   * meson_sm_get_thermal_calib - Read thermal sensor calibration data.
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  251   * @fw:		Pointer to secure-monitor firmware.
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  252   * @trim_info:	Pointer to store the returned calibration data.
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  253   * @tsensor_id:	Sensor index to identify which sensor's calibration data
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  254   *		to retrieve
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  255   *
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  256   * Return: 0 on success, negative error code on failure.
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  257   */
1c5cb7391ef5f8 Ronald Claveau 2026-04-24 @258  int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  259  			       u32 tsensor_id)
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  260  {
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  261  	return meson_sm_call(fw, SM_THERMAL_CALIB_READ, trim_info, tsensor_id,
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  262  			     0, 0, 0, 0);
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  263  }
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  264  EXPORT_SYMBOL_GPL(meson_sm_get_thermal_calib);
1c5cb7391ef5f8 Ronald Claveau 2026-04-24  265  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
