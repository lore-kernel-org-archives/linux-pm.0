Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA325B0B5
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171166; cv=none; b=VJnevEdvYHYP11PAoW/6BrebqlXHpGJXpMIKr3kvD6eHlRVMYQdA/EkdcPPN0+al+ry8Iobos466uhFHN8Se9YCtuyilhAeic8EvyMxkgZQEnL1US6DphSHAnS+v6Yh+Yd/L+GpCugsABzHQfQBWgi2TwM4CON+hBE5jziquyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171166; c=relaxed/simple;
	bh=V3gXuKL3ohKlaGUo6W9V9HMZNrmRcdDJ5vz2T55yHpk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dIxsW6AdG/bycTUzKD3w7wjG3yuYWzbG5FesJZ9OMBPWbfTGSPDcbZgmt6I7NWmF+/XgEFDFakYU3ifN7Hp3B17tJgjAHvdEF+gPzbICeau9TfZFcONdxe1Ryrw6ZByvv4ID4ZVwMUnkM89+LYmQ3QfvVg6qhetQnmUu3DY1Foo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZJxEpvj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZJxEpvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780171165; x=1811707165;
  h=date:from:to:cc:subject:message-id;
  bh=V3gXuKL3ohKlaGUo6W9V9HMZNrmRcdDJ5vz2T55yHpk=;
  b=HZJxEpvjteo67tMbMj+4nDBicHYoAcWLpXF/YPAhpd1sfMmQhBKoJbRx
   X7A7fb35D3PPhwU5M6FObjQ0qJhslxzPtNCi/PtOLc2duYfKUalQOLlFt
   /EkJQFd/VQXWzkxyu8rgSqlQuq6yp8jkzbuhnLIPMPVDJ8/Gmd2vNfCZ3
   JxLhPCm/+tlstYp+HjlxXnQBNU65ej56rRq836Jai/uBellcTHV4SQbzh
   MTLIYCsI61M11YVAgwIEBiJJJYKmnM93f+AFVgGCBkAr5Mkjri58AO0HB
   5gJUx7HThR2jedhu8Wy3U3B7rARLmDzXctxrD92owR58nFZdhvxNdxNEu
   Q==;
X-CSE-ConnectionGUID: GORlXDjGQwir8Uzs/gKF6g==
X-CSE-MsgGUID: YcFA96VXQ6aKlpg4FtPIAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="81172122"
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="81172122"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 12:59:25 -0700
X-CSE-ConnectionGUID: 6idJrEaxRuG/+eG2rVKgiA==
X-CSE-MsgGUID: aXtt8mwWRVi9D42qdYfQyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,178,1774335600"; 
   d="scan'208";a="238977790"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 May 2026 12:59:22 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTPq4-000000008pa-0gx5;
	Sat, 30 May 2026 19:59:20 +0000
Date: Sun, 31 May 2026 03:59:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/backlight-property-v4 3/9]
 drivers/gpu/drm/drm_backlight.c:101:62: error: passing 'const char *const[2]'
 to parameter of type 'char **' discards qualifiers in nested pointer types
Message-ID: <202605310304.chQ0W1xz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/backlight-property-v4
head:   d6dda4e35a589d00e7be9db8c45aef13547401f2
commit: 838d0906592749f46424cbf58eb20a85a95efd27 [3/9] drm: link connectors to backlight devices
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260531/202605310304.chQ0W1xz-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310304.chQ0W1xz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310304.chQ0W1xz-lkp@intel.com/

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
   include/asm-generic/bug.h:155:25: note: expanded from macro 'WARN_ON'
     155 |         int __ret_warn_on = !!(condition);                              \
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
