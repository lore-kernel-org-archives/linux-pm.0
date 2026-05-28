Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA23A6B9A
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967515; cv=none; b=mfmJsKArxuhzLXNHl+FyJJtitTmnIExtBy9ircOpiPzwEc2IkuU8jGpvLrox9rtvjTdtP94C+3F/UlinykmZeeTIocsnqhZfgreEf8s4Q3+dZzZj2SsDCm2VJItcWtz05Ii+Qo+N6vbjNtrGZwyEkRchBOQffUw62eGhBxMd0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967515; c=relaxed/simple;
	bh=IrpciD1D4mV8t56Rf6hUyqgbSzTj0OOvoOP/ugPTdrQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lkuDakySlqkEa8v4vk1eOgN20wXIQZJbNDLexjtXgfGmAktvsP+3PyT6Rpk78z8fvrI0d/gDYePDiKXlp/r00gmK79ydcR3ORGNUa9Yvtvp+oO7HD4M2QfgjyZYnQVbZ/y3LM4KqZsUzHyvSnGmu6fFA4uLv4iCW6nnFtw5bEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYYQgjXI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYYQgjXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779967512; x=1811503512;
  h=date:from:to:cc:subject:message-id;
  bh=IrpciD1D4mV8t56Rf6hUyqgbSzTj0OOvoOP/ugPTdrQ=;
  b=RYYQgjXIosfPQacbk0LqHtuo1q5Yy4GvBni8clHvwwTqNBv7o4T3tO6P
   QjXBVS4lHcOk8PYZIl3Rfqi4r3/agIIo+Mp/LpChZaNGLXQNVB9yEbYYU
   mFycidbQfzRaeDrjRLeNGayHcKYbZDZsRpHnh0rt6/XbO8ilZ0jrHg1/2
   dd6g+UhTnz5nM08VXiPeAAwZ+2QlgEF7tu+97G6qKinuFGFEtue0VEyjJ
   gYGXdDHmnEbvnMLYYJlU8oMEAzUXIiDoD+94ssJE+C2xA5zUGBIdqz6AN
   BRD5KuUWROA14ozUuz6KGWrOd/YcNgESBGSTEnWbHqmT8yZ3yWxix7pFN
   g==;
X-CSE-ConnectionGUID: 4Jes5lieS2W7/M1Vb5QKCg==
X-CSE-MsgGUID: JzcWwijXQSuNRZ+lO19JPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="83384500"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="83384500"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 04:25:12 -0700
X-CSE-ConnectionGUID: H15aFt1dS7anWJEf1ard7A==
X-CSE-MsgGUID: HKcIbs8sRqawQJWNaEPJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="266131618"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 28 May 2026 04:25:10 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSYrL-000000000KL-3dzz;
	Thu, 28 May 2026 11:25:07 +0000
Date: Thu, 28 May 2026 13:24:44 +0200
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/backlight-property-v4 3/9]
 drivers/gpu/drm/drm_backlight.c:101:76: error: passing argument 3 of
 'kobject_uevent_env' from incompatible pointer type
Message-ID: <202605281301.8RWsqel0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/backlight-property-v4
head:   d6dda4e35a589d00e7be9db8c45aef13547401f2
commit: 838d0906592749f46424cbf58eb20a85a95efd27 [3/9] drm: link connectors to backlight devices
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260528/202605281301.8RWsqel0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281301.8RWsqel0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605281301.8RWsqel0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_backlight.c: In function '__drm_backlight_worker':
>> drivers/gpu/drm/drm_backlight.c:101:76: error: passing argument 3 of 'kobject_uevent_env' from incompatible pointer type [-Wincompatible-pointer-types]
     101 |                 kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE, ep);
         |                                                                            ^~
         |                                                                            |
         |                                                                            const char * const*
   In file included from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from include/linux/backlight.h:12,
                    from drivers/gpu/drm/drm_backlight.c:8:
   include/linux/kobject.h:216:31: note: expected 'char **' but argument is of type 'const char * const*'
     216 |                         char *envp[]);
         |                         ~~~~~~^~~~~~
   drivers/gpu/drm/drm_backlight.c: At top level:
   drivers/gpu/drm/drm_backlight.c:315:6: warning: no previous prototype for 'drm_backlight_inhibit_legacy' [-Wmissing-prototypes]
     315 | void drm_backlight_inhibit_legacy(struct drm_backlight *b)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_backlight.c: In function 'drm_backlight_inhibit_legacy':
   drivers/gpu/drm/drm_backlight.c:321:10: error: 'struct drm_backlight' has no member named 'luminance_clients'
     321 |         b->luminance_clients++;
         |          ^~
   drivers/gpu/drm/drm_backlight.c:323:36: error: 'struct backlight_device' has no member named 'drm_takeover'
     323 |                 atomic_inc(&b->link->drm_takeover);
         |                                    ^~
   drivers/gpu/drm/drm_backlight.c: At top level:
   drivers/gpu/drm/drm_backlight.c:334:6: warning: no previous prototype for 'drm_backlight_uninhibit_legacy' [-Wmissing-prototypes]
     334 | void drm_backlight_uninhibit_legacy(struct drm_backlight *b)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/bug.h:193,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/segment.h:6,
                    from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15:
   drivers/gpu/drm/drm_backlight.c: In function 'drm_backlight_uninhibit_legacy':
   drivers/gpu/drm/drm_backlight.c:340:22: error: 'struct drm_backlight' has no member named 'luminance_clients'
     340 |         if (WARN_ON(b->luminance_clients == 0))
         |                      ^~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON'
     110 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   drivers/gpu/drm/drm_backlight.c:342:10: error: 'struct drm_backlight' has no member named 'luminance_clients'
     342 |         b->luminance_clients--;
         |          ^~
   drivers/gpu/drm/drm_backlight.c:344:36: error: 'struct backlight_device' has no member named 'drm_takeover'
     344 |                 atomic_dec(&b->link->drm_takeover);
         |                                    ^~
   drivers/gpu/drm/drm_backlight.c: At top level:
   drivers/gpu/drm/drm_backlight.c:356:6: warning: no previous prototype for 'drm_backlight_inhibit_legacy_all' [-Wmissing-prototypes]
     356 | void drm_backlight_inhibit_legacy_all(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_backlight.c:372:6: warning: no previous prototype for 'drm_backlight_uninhibit_legacy_all' [-Wmissing-prototypes]
     372 | void drm_backlight_uninhibit_legacy_all(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/kobject_uevent_env +101 drivers/gpu/drm/drm_backlight.c

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
