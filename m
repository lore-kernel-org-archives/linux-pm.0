Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793422233;
	b=cPCecnxkTHChYNtBckycF9jJQ9sYxclCQDI/GM4QGWfAkJHTfpJT95BEDIRhGWBhX3L+
	 uunwZ2kWG25zUzj90q3Q2OrTL/9bYV3f3tP0UfhwdcOWy4c7eU8pTB+KwWNQNLvJ2owSn
	 MnAMwqiI8sBvioo/uj6QZ5dcIUOkvcVNRONB0Aex+1KZXdz8ip79xJP042EwhmWgJnFL9
	 tjlDm1QO/qXUuERE8OWQ/bCYkV5ppbpkhYXghtNgM5rgo8EbhRzJq4gVpLN6C06yU+RIz
	 t5h0SLOKWXt+1FfEmBR6AmpkXFtBAyeuIPon2jc2kaRicGuw/aXzxd6AA0uYXS3omeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793422233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=U0ah+/mdXfppCcH+FdTlHAr5Y6FK4dmXjWDNtY24zT8=;
	b=LSQqm+uN11LcbgO7uOCMBE4IL/l58/MVoO6ZUHeEkeR0vfq4LujkSu3lmrgS+5XKaXLV
	 6EwD4xn+ABWShsgDd1fnCF+D66mUm9C7UE/iXjuOpjN3zY1hQGR/rwxSC/zSrO0NTzB/+
	 rkdaXwsRuIo+sqnUQxqocDcq6cNn4/m85dDI7BQ9CKbMsjsdlPAHUUBYnSFNApl0Zp1z1
	 pdaVUFihDGylHxkMJXiOaeqhKGpoK5jLGyRAx+3BKBVRCIGvyVmlemllvZgYr+b7uXmUb
	 XXhsz4VPrvzwveEtnqD4C08OFke28GhujHZX/TUkeZ+3wNPodEDcsTubAd2KXPWGwUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVVpX0zH;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC73606A31A;
	Sat, 31 Oct 2026 04:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBC73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVVpX0zH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793422232; x=1824958232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VQIxThp1B2mpWnsX0MaSqLPhRU+ui0ShDgvVHR25dYQ=;
  b=RVVpX0zHVF2NYfL9h4VgwAQN0n0qBEKkVQgcKRBSKd0N/QoOKfDW9XaB
   oHXNmo0uMBpqgYJxY1CfhaMFDwFT0nihK5cP5YsCOeANuygFs47TMS2Yu
   B6CKGpAd+2FMi+6pa0xrNfLhy5Kg3rxkxujV/wn0SZ4aYbLb5jnsu0lm+
   boZDMBZAkqADlKqbTt1tSMWul0b/f9D0uvGbqK8WIEz0KK208FeBti/Qv
   V6nCDm4g0HFpczY0tjEJYdQ8UuTW6MHdLpuoyS7JBOzKI70dWIlrNM6j4
   SZMdrZTj2zT0+omgZQxXVVaY2HttGBFP0SlIf6/837tTrYOgmoltgYwWj
   g==;
X-CSE-ConnectionGUID: Gd7xGkt8SniTi2EMU8bJGQ==
X-CSE-MsgGUID: kHmBInVYQSWX4uw6IRDe3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2199117"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2199117"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 21:50:31 -0700
X-CSE-ConnectionGUID: jh76AprFT1i2+5WyacK76w==
X-CSE-MsgGUID: aWxndDEHTM6RBXMZz9Yrew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5481267"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Oct 2026 21:50:30 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xN12x-00000000cXk-2XEz;
	Sat, 31 Oct 2026 04:50:27 +0000
Date: Sat, 31 Oct 2026 12:49:32 +0800
From: kernel test robot <lkp@intel.com>
To: Saranya Gopal <saranya.gopal@intel.com>, linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
Message-ID: <202610311242.kB7pRXhy-lkp@intel.com>
References: <20261030030515.3127310-1-saranya.gopal@intel.com>
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
In-Reply-To: <20261030030515.3127310-1-saranya.gopal@intel.com>

Hi Saranya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master next-20261030]
[cannot apply to v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saranya-Gopal/ACPI-s2idle-Handle-shared-_Ixx-GPEs-without-an-EC/20261030-083515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20261030030515.3127310-1-saranya.gopal%40intel.com
patch subject: [PATCH] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
config: x86_64-buildonly-randconfig-1000-20261031 (https://download.01.org/0day-ci/archive/20261031/202610311242.kB7pRXhy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261031/202610311242.kB7pRXhy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610311242.kB7pRXhy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/sleep.c:26:
   drivers/acpi/internal.h: In function 'acpi_ec_dispatch_gpe':
   drivers/acpi/internal.h:262:17: error: 'ENOTSUP' undeclared (first use in this function); did you mean 'ENOTSUPP'?
     262 |         return -ENOTSUP;
         |                 ^~~~~~~
         |                 ENOTSUPP
   drivers/acpi/internal.h:262:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/acpi/internal.h:263:1: warning: control reaches end of non-void function [-Wreturn-type]
     263 | }
         | ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [y]:
   - COMMON_CLK_MT8173_MFGTOP [=y] && COMMON_CLK [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && COMMON_CLK_MT8173 [=y] && PM [=y]


vim +263 drivers/acpi/internal.h

a6021aa24f64174 Arnd Bergmann 2024-10-11  258  
a6021aa24f64174 Arnd Bergmann 2024-10-11  259  static inline void acpi_ec_flush_work(void) {}
c644e4b14c9cb08 Saranya Gopal 2026-10-30  260  static inline int acpi_ec_dispatch_gpe(void)
a6021aa24f64174 Arnd Bergmann 2024-10-11  261  {
c644e4b14c9cb08 Saranya Gopal 2026-10-30  262  	return -ENOTSUP;
a6021aa24f64174 Arnd Bergmann 2024-10-11 @263  }
a6021aa24f64174 Arnd Bergmann 2024-10-11  264  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
