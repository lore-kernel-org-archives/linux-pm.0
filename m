Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7333F8A2
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164317; cv=none; b=Lx560VY2Wd7Iyyst0HME5fxaarazmbNwTCILlTBylBe/RTubu147JQrdZ125oEzH0npggFW/isfH82pOeesrrMvX7YildX1ljDnXM8wRGocQQZDcU2n9lrC4Dl34vm213FnXZyJUjg0Aq8xORcwbCdI7A6ivXlH1tdM1CO/7aKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164317; c=relaxed/simple;
	bh=mGQW32snOu4TyIRU0WPTaIkp4qt1qj4vr8DRIxnVgZA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hXhOBmqUUS+BZhZDuZahB9a90mu8i+KC5xd0MSqUSiHa3STNIp+pVUyzPNeOUP/wbhao4nIfdyXF4ZF+khXpNNeZ6vWTyGaqS0FF8L/uJrZBfeURBXHYcrHRg2VWrCy5lwpNt4UcEtqY8STD3+fYEufVNYzs+d0Om5RKI5yXfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ky7zN8ZG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ky7zN8ZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780164316; x=1811700316;
  h=date:from:to:cc:subject:message-id;
  bh=mGQW32snOu4TyIRU0WPTaIkp4qt1qj4vr8DRIxnVgZA=;
  b=Ky7zN8ZGALncRB6jsBeeALMcWa1jkgTpiJCvjpPf/Ev83IV9NMC4it62
   eTZ7Vigs7U2PPurvFe+AuziK12uhmUJ+u0JlsKoovPwtwT3ajQRfi+i6n
   kcD/kAWJvDl4AFJgNOP6TAJAjhoG1RkwCwqX9xBUDD2iKwI0DxpMbZKmP
   fliZEJ4A+ubGI9eC9JeoP49HbAiGxpnUTMDmDrRbqXgCkD+xCBXqfRp8/
   VaA7fmw/QCcaMHtEk6WDQevQqLXtvztWMltNLaWeQyRLCkt8N3dOSovHT
   Eo4ivzaBSM2ME+Zo/n5/UXbyckmtfuyDE6a5uXKUEnKy63JeJd4z1zSWM
   A==;
X-CSE-ConnectionGUID: MQqgUaHYRUqGPp3G/spgbw==
X-CSE-MsgGUID: p6bDgYOWSGmSlSAEF7kGGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="81095342"
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="81095342"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 11:05:15 -0700
X-CSE-ConnectionGUID: epAjtd+aQtGegY4mlz8tfQ==
X-CSE-MsgGUID: CbvFPeXdRamyG8yxizq/Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="266779662"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 May 2026 11:05:13 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTO3b-000000008m4-1YBl;
	Sat, 30 May 2026 18:05:11 +0000
Date: Sun, 31 May 2026 02:04:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/backlight-property-v4 3/9]
 drivers/gpu/drm/drm_backlight.c:101:76: error: passing argument 3 of
 'kobject_uevent_env' from incompatible pointer type
Message-ID: <202605310146.7FTDGWKQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/backlight-property-v4
head:   d6dda4e35a589d00e7be9db8c45aef13547401f2
commit: 838d0906592749f46424cbf58eb20a85a95efd27 [3/9] drm: link connectors to backlight devices
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260531/202605310146.7FTDGWKQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260531/202605310146.7FTDGWKQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605310146.7FTDGWKQ-lkp@intel.com/

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
   In file included from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/processor.h:11,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15:
   drivers/gpu/drm/drm_backlight.c: In function 'drm_backlight_uninhibit_legacy':
   drivers/gpu/drm/drm_backlight.c:340:22: error: 'struct drm_backlight' has no member named 'luminance_clients'
     340 |         if (WARN_ON(b->luminance_clients == 0))
         |                      ^~
   include/asm-generic/bug.h:155:32: note: in definition of macro 'WARN_ON'
     155 |         int __ret_warn_on = !!(condition);                              \
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
