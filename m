Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C943A0B1E;
	Mon,  9 Feb 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666959; cv=none; b=qYOlVnHC0XRazUtz9Zeq4Bs9e8eU85aJeKqd//Kq3q0Z5jVBZMmMECVvVXhE7GW99Uq+zGdPikxtV3FYsLeFjK+keN0to3J4yEe8vtbmwzGXoax5+S8K+k85OeL4ceIixjwiqw0gLm9hGC0kwezQKFGw/2jKyGoanJZ5KS2DuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666959; c=relaxed/simple;
	bh=Kri/6798PkMwyZy4c1p5aMyRdc5CV8j/kQSXj8xR28Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j3XRaCchWa2CVUyzcJIc05fd+YgBYVrrLKAIpO2zbzgsRBEYBsYUchPPLlKjI4WHThzvgWf6zhLIIwnZNWICshmtnPgv/zaZ3nH/4cj7dTNpgURTOW3Q4Ig74w79OKycekrFVgx3S9RCi459VZBLfYeB61BI3v0FS8VYsUss1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiJuw3Wn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiJuw3Wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770666959; x=1802202959;
  h=date:from:to:cc:subject:message-id;
  bh=Kri/6798PkMwyZy4c1p5aMyRdc5CV8j/kQSXj8xR28Y=;
  b=hiJuw3WnoSmchjRUWGSOyhrw+Sm0OLiRWGvaQsnNTnpc3h8sgs9Vpuc8
   fGQ6sxuqlmYFHOd6eReQD7KriJLlFvlkrm7ia53D8SXLYbtQZNJhbmP/C
   n5jgtYhtH1eR5fIfqegGpakC7Aiw7jQT9qHyS2unqYHuwdvf6FSsZXhWN
   jKxcuBamxoOqV0pp9LXcSB3L1AhewCMCIB0XnB5jnQV2joR7jWqStFX6u
   TdqJnZDZWuTHfbRv7TOxf2EW+v88RxIw/DLh0GanS9OtN+iNzDsAiyyjR
   +pLDiuWagctK3yRghVjV0EgB5CSUu0ydpUclDkls63CcBzuUkbw8E2d/e
   A==;
X-CSE-ConnectionGUID: mq0uxTBfTZObu1Y9O06dYw==
X-CSE-MsgGUID: 6ynGoWAnTGmsFgE9iyKwfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83228728"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="83228728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:55:58 -0800
X-CSE-ConnectionGUID: baGu/zitQvCCIM6eLQnM+Q==
X-CSE-MsgGUID: V4GNt2mdRIefFW1tSvCj1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="211694789"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Feb 2026 11:55:56 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpXMP-00000000oI0-3b6j;
	Mon, 09 Feb 2026 19:55:53 +0000
Date: Tue, 10 Feb 2026 03:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 313/334]
 drivers/platform/chrome/chromeos_privacy_screen.c:113:46: error: 'adev'
 undeclared; did you mean 'pdev'?
Message-ID: <202602100346.fLNnmZhR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   e54545ecac98b5c4581cce71acdbb1a3728157da
commit: 0e7efd17fb4c556eadb575bc7b30b359604e3ac1 [313/334] platform/chrome: Convert ChromeOS privacy-screen driver to platform
config: loongarch-randconfig-002-20260210 (https://download.01.org/0day-ci/archive/20260210/202602100346.fLNnmZhR-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602100346.fLNnmZhR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602100346.fLNnmZhR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/chrome/chromeos_privacy_screen.c: In function 'chromeos_privacy_screen_probe':
>> drivers/platform/chrome/chromeos_privacy_screen.c:113:46: error: 'adev' undeclared (first use in this function); did you mean 'pdev'?
     113 |                                             &adev->dev);
         |                                              ^~~~
         |                                              pdev
   drivers/platform/chrome/chromeos_privacy_screen.c:113:46: note: each undeclared identifier is reported only once for each function it appears in


vim +113 drivers/platform/chrome/chromeos_privacy_screen.c

3fb57847f6ec30 Rajat Jain        2022-01-07  107  
0e7efd17fb4c55 Rafael J. Wysocki 2026-02-09  108  static int chromeos_privacy_screen_probe(struct platform_device *pdev)
3fb57847f6ec30 Rajat Jain        2022-01-07  109  {
3fb57847f6ec30 Rajat Jain        2022-01-07  110  	struct drm_privacy_screen *drm_privacy_screen =
0e7efd17fb4c55 Rafael J. Wysocki 2026-02-09  111  		drm_privacy_screen_register(&pdev->dev,
3fb57847f6ec30 Rajat Jain        2022-01-07  112  					    &chromeos_privacy_screen_ops,
3fb57847f6ec30 Rajat Jain        2022-01-07 @113  					    &adev->dev);
3fb57847f6ec30 Rajat Jain        2022-01-07  114  
3fb57847f6ec30 Rajat Jain        2022-01-07  115  	if (IS_ERR(drm_privacy_screen)) {
0e7efd17fb4c55 Rafael J. Wysocki 2026-02-09  116  		dev_err(&pdev->dev, "Error registering privacy-screen\n");
3fb57847f6ec30 Rajat Jain        2022-01-07  117  		return PTR_ERR(drm_privacy_screen);
3fb57847f6ec30 Rajat Jain        2022-01-07  118  	}
3fb57847f6ec30 Rajat Jain        2022-01-07  119  
0e7efd17fb4c55 Rafael J. Wysocki 2026-02-09  120  	platform_set_drvdata(pdev, drm_privacy_screen);
0e7efd17fb4c55 Rafael J. Wysocki 2026-02-09  121  	dev_info(&pdev->dev, "registered privacy-screen '%s'\n",
3fb57847f6ec30 Rajat Jain        2022-01-07  122  		 dev_name(&drm_privacy_screen->dev));
3fb57847f6ec30 Rajat Jain        2022-01-07  123  
3fb57847f6ec30 Rajat Jain        2022-01-07  124  	return 0;
3fb57847f6ec30 Rajat Jain        2022-01-07  125  }
3fb57847f6ec30 Rajat Jain        2022-01-07  126  

:::::: The code at line 113 was first introduced by commit
:::::: 3fb57847f6ec30e9aa27af7b37aed7a7419d50aa platform/chrome: Add driver for ChromeOS privacy-screen

:::::: TO: Rajat Jain <rajatja@google.com>
:::::: CC: Hans de Goede <hdegoede@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
