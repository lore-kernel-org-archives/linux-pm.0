Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309235;
	b=XZ70aeBJt9XGH2zrdX+4mST26mZjXN6teOSp6cDWyRyoq6/sMXj1OSbLUnCX0TEJdwVi
	 RfuSIuiEuoJ9huWuQp1C9W4sHO7z0olnSuIz+0lAONVFoSWZELJdADiVlc/I+ThZceH0M
	 c/F0jjfrFV/tjpgklxmD/1DPRWKdspp69YLxDJ1euzrRTU6WMpKAVlUpQYmJLHDwBkpXH
	 MQMslMIRTLYgE8Rh/f2NUFU3vaJK5kJ6hmaZcOnHgleR2Y34LS37dywFF5gJ4Ekcug06B
	 wwwLz/NW4/KcYSGDcUbj7z3v5UPL6niC0wAokBxfFOcux9wRCaI1iHeSWKUusVi9HKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309235;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1ddw33IRhP/2JwGXS8pr/OEmMOA3/AlgOlVfVT3jdAg=;
	b=p5WCev0yw2WOcpPFwy97+mJhsbUoEBoLSREvoEzy/V5pERNHCH6nSmrVKEqVQ/NOmtJz
	 v8D/gLJvDV5ocbBcY22bwZNENeaAjpDZCg/rl4MSotW7yHZlD2OQX1H+VHGrapQWW1Keg
	 i2jgSrv0mG2kJBSqtCPscxaTCFOKxbRrYSSUnJaeRWwsoc3Y7VNr80a5kIJVy79JiUHrz
	 ywQsim8/eUfYFVidjR8lUj5EMlYMqPgbM4zT6y2oD3GthvXjPjPO9fDB7F/b0CVqGZMdb
	 QMl0BHJw57AjHHbkqQafUJrNPNnSPpHkGD43Vn0sV/hIsi3S/oyOXlZobtuhzmsIc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ge8kgWs0;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DD606A325;
	Tue, 10 Nov 2026 11:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ge8kgWs0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794309233; x=1825845233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q151x58OOoxplNHV2tNqcg1F9gUopr/bQY46SxbANQE=;
  b=Ge8kgWs03JlnGdcfz/d9HojFTQdUrse3JcB2FxS9aNoEr9UHfLc4EXHR
   eV7YTz5TfKQNN5ldy2HdLXEqUyMfPiYUwk7nS607h4CUtPvaVz8PJDBcA
   tbMBnwvhupP3gvTuXRg0xF59yl0t1u7B833HxTlI7LXbSsdwHTnzdoJEA
   ZTex85wK8O9EA/alphufXQ8KVKJtpGpsH9H37kmgg9HscMdwHKWzRoilY
   pHWA2NV1sArQzTOu4Nx1xPNbYjlpZ8h23SLCL19qR4hn52t42PjPMJ3Sg
   OAiUqf4DRApmMIVJ2MPNgXRZA9Y19yDF50CvC67vWZL2CBVTC1jfqxWAQ
   Q==;
X-CSE-ConnectionGUID: A+8ay+ufTfmPEa9GTxJ1/A==
X-CSE-MsgGUID: PmKP8m5TS/WFWmhGh46UqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2929469"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2929469"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:13:52 -0800
X-CSE-ConnectionGUID: nQhW5sMRTXe0+WPQEFVfgw==
X-CSE-MsgGUID: Jr4gJxw2Sk+1AP3yIDtnrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9903373"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 10 Nov 2026 03:13:49 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQjnO-00000000wh1-3pUd;
	Tue, 10 Nov 2026 11:13:46 +0000
Date: Tue, 10 Nov 2026 19:13:33 +0800
From: kernel test robot <lkp@intel.com>
To: Armin Wolf <W_Armin@gmx.de>, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	bifangknt@qq.com, nicokessler@icloud.com, sre@kernel.org,
	linux-pm@vger.kernel.org, wse@tuxedocomputers.com
Subject: Re: [PATCH 5/9] platform/x86: uniwill-laptop: Expose raw battery
 capacity to userspace
Message-ID: <202611101928.MbCyLNXk-lkp@intel.com>
References: <20261110001725.851443-6-W_Armin@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110001725.851443-6-W_Armin@gmx.de>

Hi Armin,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on linus/master v7.4-rc2 next-20261109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Armin-Wolf/power-supply-core-Add-power_supply_has_property_direct/20261110-010643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20261110001725.851443-6-W_Armin%40gmx.de
patch subject: [PATCH 5/9] platform/x86: uniwill-laptop: Expose raw battery capacity to userspace
config: i386-randconfig-1009-20261110 (https://download.01.org/0day-ci/archive/20261110/202611101928.MbCyLNXk-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261110/202611101928.MbCyLNXk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611101928.MbCyLNXk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/uniwill/uniwill-acpi.c:2148:3: error: cannot jump from this goto statement to its label
    2148 |                 goto err_remove;
         |                 ^
   drivers/platform/x86/uniwill/uniwill-acpi.c:2150:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    2150 |         guard(mutex)(&data->battery_lock);
         |         ^
   include/linux/cleanup.h:416:2: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:299:3: note: expanded from macro 'CLASS'
     299 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:19:1: note: expanded from here
      19 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:25:1: note: expanded from here
      25 | __UNIQUE_ID_unlock_362
         | ^
   drivers/platform/x86/uniwill/uniwill-acpi.c:2150:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:416:15: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:13:1: note: expanded from here
      13 | __UNIQUE_ID_guard_361
         | ^
   drivers/platform/x86/uniwill/uniwill-acpi.c:2139:3: error: cannot jump from this goto statement to its label
    2139 |                 goto err_free;
         |                 ^
   drivers/platform/x86/uniwill/uniwill-acpi.c:2150:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
    2150 |         guard(mutex)(&data->battery_lock);
         |         ^
   include/linux/cleanup.h:416:2: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:299:3: note: expanded from macro 'CLASS'
     299 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:19:1: note: expanded from here
      19 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:25:1: note: expanded from here
      25 | __UNIQUE_ID_unlock_362
         | ^
   drivers/platform/x86/uniwill/uniwill-acpi.c:2150:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:416:15: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:13:1: note: expanded from here
      13 | __UNIQUE_ID_guard_361
         | ^
   2 errors generated.


vim +2148 drivers/platform/x86/uniwill/uniwill-acpi.c

  2125	
  2126	static int uniwill_add_battery(struct power_supply *battery, struct acpi_battery_hook *hook)
  2127	{
  2128		struct uniwill_data *data = container_of(hook, struct uniwill_data, hook);
  2129		struct uniwill_battery_entry *entry;
  2130		const struct power_supply_ext *ext;
  2131		int ret;
  2132	
  2133		entry = kzalloc_obj(*entry);
  2134		if (!entry)
  2135			return -ENOMEM;
  2136	
  2137		ret = device_create_file(&battery->dev, &data->charge_full_raw_attr);
  2138		if (ret < 0)
  2139			goto err_free;
  2140	
  2141		if (power_supply_has_property_direct(battery, POWER_SUPPLY_PROP_CYCLE_COUNT))
  2142			ext = &data->standard_extension;
  2143		else
  2144			ext = &data->cycle_count_extension;
  2145	
  2146		ret = power_supply_register_extension(battery, ext, data->dev, data);
  2147		if (ret < 0)
> 2148			goto err_remove;
  2149	
  2150		guard(mutex)(&data->battery_lock);
  2151	
  2152		entry->battery = battery;
  2153		list_add(&entry->head, &data->batteries);
  2154	
  2155		return 0;
  2156	
  2157	err_remove:
  2158		device_remove_file(&battery->dev, &data->charge_full_raw_attr);
  2159	
  2160	err_free:
  2161		kfree(entry);
  2162	
  2163		return ret;
  2164	}
  2165	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
