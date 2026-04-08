Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112092BE04C;
	Wed,  8 Apr 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645935; cv=none; b=DHs/k6FabhQKfSE5rxQXB7BD/ce24eHhN3DqtLKvvWXUIjDI9eLagW+N8lToS2U9Q7LnqSEbVlPZAOMSKhHpIhh7hUBgzsf6uukXk8dSKGbwcPH2wFxTCt3GpLGxm4JyWv7n2e97YTJXoGfUnrPDv/olm2QU/w4AOaPF6ttJ8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645935; c=relaxed/simple;
	bh=yhGUaeJuXPEXey6cTCrR/VOqeDvC3awUjWTPNd0YTAg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=myu7CEbifSaP7Ri0gBm1n68K3Brc5HUycKK2MTlgwVRNPgSkyYO6D2z13ihDKJ/6yskpcPGH0DOAZBPrCjAoa1rhO1tPB0fN+fjYAZPz2X2aN2E2Pu9sgHYVhz8MtLs5CM/gxLO0oL28RIAN9eni/BbkG2C3hBc0ew7seSNCAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuV0doOp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuV0doOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775645934; x=1807181934;
  h=date:from:to:cc:subject:message-id;
  bh=yhGUaeJuXPEXey6cTCrR/VOqeDvC3awUjWTPNd0YTAg=;
  b=QuV0doOpjXAKjtnyGamppjep+muizYsEpxi2HjqZPnd6IyWQBNrDzAAI
   6Bhb+QqxiLdi1gQnTdxIAXiWul8pK3S9Pckl/TdkFcwNMMTFvcrUGoWSI
   hUf7XW8MrgqYNZP6q5Gt6bnRVvlzUgi3RsKi/CR9cknhWstbIRNZpsMPu
   JqqERw8ykWqgRLniBUeHIcB7/J1Wb1CCoHCFFNwMKuqW7Ha05oeGutn+7
   injDQmm9rHp/1FOs44EvHdxL5iTQ9/DxUsbqQ4sb2DBx2WO+EZGhUAslZ
   byzm5MrFWDgCfPH4LwTFToHj7RU7g5JreN4JRiZwtFejY1ayCwag2AUYF
   w==;
X-CSE-ConnectionGUID: guYa9wUkSxW6EjX+J6w0zg==
X-CSE-MsgGUID: NxmxNmx8RqCo1RL9ebrMUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102078398"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102078398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:58:53 -0700
X-CSE-ConnectionGUID: 8WWFW87eQlW8fo2XZ4qPzA==
X-CSE-MsgGUID: XuvOI0X8RPuj7g9aSpqsSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228691427"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 03:58:52 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wAQcS-000000001lN-41IL;
	Wed, 08 Apr 2026 10:58:48 +0000
Date: Wed, 08 Apr 2026 18:58:11 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 170/268] ERROR: modpost:
 "thermal_of_cooling_device_register" [drivers/gpu/drm/etnaviv/etnaviv.ko]
 undefined!
Message-ID: <202604081848.Yh1jEbFo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi Daniel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   d18364264af84e2a89da14c6b5f0eae2ba7f98de
commit: e1b96fba58c6fe18a31a06f752ebc8ad6921b1cb [170/268] thermal/of: Move OF code where it belongs to
config: x86_64-randconfig-005-20260408 (https://download.01.org/0day-ci/archive/20260408/202604081848.Yh1jEbFo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081848.Yh1jEbFo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081848.Yh1jEbFo-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "thermal_of_cooling_device_register" [drivers/gpu/drm/etnaviv/etnaviv.ko] undefined!
ERROR: modpost: "devm_thermal_of_cooling_device_register" [drivers/hwmon/dell-smm-hwmon.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
