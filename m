Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194997;
	b=4KaM+mDXfk4P2diLD9G6VYy+bdDdyi0PN2GsYBgWhZAKLlYcTUqc0tfa8jT9tavoTTG7
	 J2IWX3MhwGJ6ggz5mWwDRcWwNMMhW3EGMuDjBR5hWCfsntemxe6wCxoySKklwd3TuOx9p
	 YU8aa829zSXe3OmpRj9I6jGNN6Qn3VUmFB0GpZpiV7WSO+8PWHigN4omv+vU9y9dgv2wh
	 M6k5Uj0KD44EZgWLZl8rWBtixJHKLIINQy0thueGA+aN+YFzfcI4oD/efWIFK9FhXkwgH
	 kE/5QHonJXkzVSE7XX7t09/Zxg5VkccWf5YU6Z0Btc+EbvCBUp7Ci0ECyiYHggCXoWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194997;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=We1wfdqHYfvXrZ/yfDXBoNvajozeA457GHn/Z+Vm02w=;
	b=yYlBymlQWiSTonbmiY8l7gWND/2cec80qbI7oA75Gd8sMQDzuwnN1kRoN3XHLq349V+E
	 UnrEv23YPILMXsvyucCRp7BLPcfTBwSasE/QdboCLUSA33Low/2PrqgBr4RNbMuwqgimB
	 qHRw6v9DIiA2tawUZ0jI3XzFuSQJAluRu+KsvUfNtmOvg7DMFY99IWS5V6S3fI+7oftux
	 cHH+LADy7Ef36I1nxv1PKWDKV1554N7Z8bE2sioyy6AiZeX38UP+/3ctUETVh+J/G27+o
	 HeQaPNZGhZmNpcxDqnylSErHtEqz9UCN/QCYQaZxnvoSeS0D06ldSJ0l9nuJTzoVzlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="FCEMuO/P";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A9606A320
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 13:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B1A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FCEMuO/P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793194996; x=1824730996;
  h=date:from:to:cc:subject:message-id;
  bh=Hmn6WZV9SSGj7gWdfnBVTa1IVtW6UbPPFlPZEF9LtI4=;
  b=FCEMuO/Pi3JYJ4oCSNlS8kpmK7jgjGaj5MyeNHJtsX6q+fzlqiMfwrDK
   jbM1Cd3c5mjGJYEQUaSe0l/JMJU4W7ltz+gLadOVtznA7+b5v51N7T5Tw
   ovDAR8ujx4kMbASAs7Szc3yKvcNSHSE0XSAAzEPyowZcBZLw9qBKSN6tC
   H0vPDAViDlmajvvZWiZPXzr/PT0HzhKFiYjfXK9n0z9tgL1WLdCGGKOWe
   4vDwXhlSoDmGg2Z904mj2iZ6Bmkeu5Q1nU4oHthmIFpK7t+hi/P96bEkw
   E7qzNoB4XvBcKaMRMk3PRx9PVHPSAPN2bBXHBVxMq4UwAquy+w1A8oZsV
   w==;
X-CSE-ConnectionGUID: MeN5u7CMRIe6c/e1yHVT+A==
X-CSE-MsgGUID: 00ThepENSPqSIh3m2oClKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1818582"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1818582"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 06:43:16 -0700
X-CSE-ConnectionGUID: 8HUkDoBwTVGsQ0j4Sa4P6g==
X-CSE-MsgGUID: KAMwPQ72Sryi+ck7biYqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4781274"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2026 06:43:14 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xM3vr-00000000Yls-3Txu;
	Wed, 28 Oct 2026 13:43:11 +0000
Date: Wed, 28 Oct 2026 21:43:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/lockdown-iommu 3/3]
 security/lockdown/lockdown.c:217:8: error: implicit declaration of function
 'iommu_is_available'; did you mean 'slab_is_available'?
Message-ID: <202610282123.Qci24dn3-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/lockdown-iommu
head:   74b0183524154e17897a7789da06a937eaf8b2b7
commit: 74b0183524154e17897a7789da06a937eaf8b2b7 [3/3] security: lockdown: Prevent boot with lockdown but no IOMMU
config: arm-randconfig-1003-20261028 (https://download.01.org/0day-ci/archive/20261028/202610282123.Qci24dn3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261028/202610282123.Qci24dn3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610282123.Qci24dn3-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/lockdown/lockdown.c: In function 'lockdown_check_iommu':
>> security/lockdown/lockdown.c:217:8: error: implicit declaration of function 'iommu_is_available'; did you mean 'slab_is_available'? [-Werror=implicit-function-declaration]
      if (!iommu_is_available()) {
           ^~~~~~~~~~~~~~~~~~
           slab_is_available
   cc1: some warnings being treated as errors


vim +217 security/lockdown/lockdown.c

   197	
   198	/*
   199	 * Late init call to verify IOMMU availability when lockdown is active.
   200	 * This catches cases where:
   201	 *  - IOMMU hardware is absent on the platform
   202	 *  - IOMMU was disabled by driver initialization failure
   203	 *  - IOMMU was not detected (e.g. broken firmware, missing ACPI tables)
   204	 *
   205	 * On x86, we also check no_iommu here as a double-check. The early check
   206	 * in lockdown_lsm_init() catches 'iommu=off' from the cmdline before
   207	 * lockdown_lsm_init() runs, but this late check covers any missed cases.
   208	 */
   209	static int __init lockdown_check_iommu(void)
   210	{
   211		if (kernel_locked_down > LOCKDOWN_NONE) {
   212			/*
   213			 * Check generic IOMMU availability (all architectures).
   214			 * iommu_is_available() returns true if any IOMMU driver
   215			 * registered successfully.
   216			 */
 > 217			if (!iommu_is_available()) {

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
