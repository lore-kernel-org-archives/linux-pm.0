Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA29283FE5
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976646; cv=none; b=ZpTcewTQPQ301OQsV1UeRcvcXSQ8GxrjmZ5tI/izkmPwp3kosO86XIlqF2qSOADHYmOR2fm1lsUCwhABIQK0ECGocH6q6IHdJxt6toJTi3IReSvDuKYne5uDsREBLI2puC/IsI9Ux0iU+pU9O7YO0ORqNWo+3dJRC4+19HIidg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976646; c=relaxed/simple;
	bh=R4wixPQ5VzxTmo/HsU4ylHaObjt3mfis+odIpgxlx6s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BKU2/QI5Kj0Arko+5s3tPPcW7wM3zmDRdmTuohV2/D2ryLSHxy7ULyW8HN8xK9Sj0EEmK5i5xovdPBywmjfkE8dI9v5utnyJUTsYzR4nf3E813Rod6SGlPDCHqYfc8Xcl2cKdbO+v+mlyOAn/q09y/GKHFM0tww+Xt9j1vgCNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrpUnnDL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrpUnnDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779976644; x=1811512644;
  h=date:from:to:cc:subject:message-id;
  bh=R4wixPQ5VzxTmo/HsU4ylHaObjt3mfis+odIpgxlx6s=;
  b=FrpUnnDLQ9Wf60SGNOXwm9JUAv5Fba4lx7q/Il66I4e9dAd921mgmPd7
   syZ75u8iRG1Q8pOTSiLwfxqHkwSNxY4GWTZAgMD0De70hTNZhf42bR9s4
   5Kr3Mys8IpLAD6F+SV8JxFRQOBorV67HkBElXxIpQARnukgDWKy711ow+
   XY0irVokw5ZcQY2gJ1P8pWnyVrc+vCoGtxF7bULDMFD+0XQpa57aRI/kD
   QEqjMp9xvNBYnX6/N0vat2pMV315XFtqlJRURB0A+pKxfB337VvL93Zax
   6r+pddOKMuIEv7vUvBbcJcyAi8euuM9rNYgxX30bZrPBKKXZlIVSDdjtx
   g==;
X-CSE-ConnectionGUID: 22VXHEv/QFu13q/UCHd/Mg==
X-CSE-MsgGUID: sxZzuZg8Q8Caefj7Y65Q+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92204149"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="92204149"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:57:19 -0700
X-CSE-ConnectionGUID: 2hE3PV36SHSO2XvnEXHW1g==
X-CSE-MsgGUID: EhIm+4YFTCiq+b6dpWnFVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="247642405"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2026 06:57:17 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSbEZ-000000000WL-43Rr;
	Thu, 28 May 2026 13:57:15 +0000
Date: Thu, 28 May 2026 15:56:51 +0200
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/backlight-property-v4 3/9]
 drivers/gpu/drm/drm_backlight.c:101:62: error: passing 'const char *const[2]'
 to parameter of type 'char **' discards qualifiers in nested pointer types
Message-ID: <202605281543.JSTIO0Te-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/backlight-property-v4
head:   d6dda4e35a589d00e7be9db8c45aef13547401f2
commit: 838d0906592749f46424cbf58eb20a85a95efd27 [3/9] drm: link connectors to backlight devices
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260528/202605281543.JSTIO0Te-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281543.JSTIO0Te-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605281543.JSTIO0Te-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_backlight.c:101:62: error: passing 'const char *const[2]' to parameter of type 'char **' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     101 |                 kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE, ep);
         |                                                                            ^~
   include/linux/kobject.h:216:10: note: passing argument to parameter 'envp' here
     216 |                         char *envp[]);
         |                               ^
   drivers/gpu/drm/drm_backlight.c:321:5: error: no member named 'luminance_clients' in 'struct drm_backlight'
     321 |         b->luminance_clients++;
         |         ~  ^
   drivers/gpu/drm/drm_backlight.c:323:24: error: no member named 'drm_takeover' in 'struct backlight_device'
     323 |                 atomic_inc(&b->link->drm_takeover);
         |                             ~~~~~~~  ^
   drivers/gpu/drm/drm_backlight.c:315:6: warning: no previous prototype for function 'drm_backlight_inhibit_legacy' [-Wmissing-prototypes]
     315 | void drm_backlight_inhibit_legacy(struct drm_backlight *b)
         |      ^
   drivers/gpu/drm/drm_backlight.c:315:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     315 | void drm_backlight_inhibit_legacy(struct drm_backlight *b)
         | ^
         | static 
   drivers/gpu/drm/drm_backlight.c:340:17: error: no member named 'luminance_clients' in 'struct drm_backlight'
     340 |         if (WARN_ON(b->luminance_clients == 0))
         |                     ~  ^
   include/asm-generic/bug.h:110:25: note: expanded from macro 'WARN_ON'
     110 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   drivers/gpu/drm/drm_backlight.c:342:5: error: no member named 'luminance_clients' in 'struct drm_backlight'
     342 |         b->luminance_clients--;
         |         ~  ^
   drivers/gpu/drm/drm_backlight.c:344:24: error: no member named 'drm_takeover' in 'struct backlight_device'
     344 |                 atomic_dec(&b->link->drm_takeover);
         |                             ~~~~~~~  ^
   drivers/gpu/drm/drm_backlight.c:334:6: warning: no previous prototype for function 'drm_backlight_uninhibit_legacy' [-Wmissing-prototypes]
     334 | void drm_backlight_uninhibit_legacy(struct drm_backlight *b)
         |      ^
   drivers/gpu/drm/drm_backlight.c:334:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     334 | void drm_backlight_uninhibit_legacy(struct drm_backlight *b)
         | ^
         | static 
   drivers/gpu/drm/drm_backlight.c:356:6: warning: no previous prototype for function 'drm_backlight_inhibit_legacy_all' [-Wmissing-prototypes]
     356 | void drm_backlight_inhibit_legacy_all(struct drm_device *dev)
         |      ^
   drivers/gpu/drm/drm_backlight.c:356:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     356 | void drm_backlight_inhibit_legacy_all(struct drm_device *dev)
         | ^
         | static 
   drivers/gpu/drm/drm_backlight.c:372:6: warning: no previous prototype for function 'drm_backlight_uninhibit_legacy_all' [-Wmissing-prototypes]
     372 | void drm_backlight_uninhibit_legacy_all(struct drm_device *dev)
         |      ^
   drivers/gpu/drm/drm_backlight.c:372:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     372 | void drm_backlight_uninhibit_legacy_all(struct drm_device *dev)
         | ^
         | static 
   4 warnings and 6 errors generated.


vim +101 drivers/gpu/drm/drm_backlight.c

    74	
    75	static void __drm_backlight_worker(struct work_struct *w)
    76	{
    77		struct drm_backlight *b = container_of(w, struct drm_backlight, work);
    78		static const char * const ep[] = { "BACKLIGHT=1", NULL };
    79		struct backlight_device *bd;
    80		bool send_uevent;
    81		unsigned int v;
    82	
    83		scoped_guard(spinlock, &drm_backlight_lock) {
    84			send_uevent = b->changed;
    85			b->changed = false;
    86			v = b->set_value;
    87			bd = b->link;
    88			backlight_device_ref(bd);
    89		}
    90	
    91		if (bd) {
    92			int rc = backlight_set_brightness(bd, v, BACKLIGHT_UPDATE_DRM);
    93	
    94			WARN_ON(rc);
    95			if (rc)
    96				backlight_set_brightness(bd, U16_MAX, BACKLIGHT_UPDATE_DRM);
    97			backlight_device_unref(bd);
    98		}
    99	
   100		if (send_uevent)
 > 101			kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE, ep);
   102	}
   103	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
