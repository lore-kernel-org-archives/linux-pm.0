Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035276;
	b=XT7Ei6QxN5xx9tTeI2cGwvCwwFLUuLU9mYvN625zHR9zsYFe7VWoW1p82UqbDuiRAlqy
	 s3G8zAsg4NumBLivmcfVuqC78NlWpjy+SsmhS5vKdBymSvYISXW+ftrWKj5QE9Cptamds
	 qys7aRd9oQHvbMKHArElShMJaP01bKsyKJ+wqmwu1f1El2vhl3Js0EMaJVMsn+PIWm2B6
	 eaIFlKeZ+SqVUcpdshtarPr2ec0ZR3AwRgUCWb6NaoL4F/XDxPlY4yG3a0gB6tOFfRO5j
	 yR3wNq9xT2m6tt5aMK7ULj0vuWwJCoAUvQNYbWlaBiCMCAR5OxRWk9zXwpyihRIWqfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035276;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CgfZZyH7KabdKr1+wIIK9g0k0FRDxF2NmtOKcQevUd8=;
	b=dUgRA0dEXYIFY9NH5gmlaB6sUj7VP/9hKG/iFgi1cdrq1WuM8MGefdeGp5PntIyGhyiZ
	 RLuwEqWr9qU9Th+EwtvQNpdZapwbKBnJfG7G2NPGzvugtBpr+BteY7MY4cD2eK2jy7I/x
	 LpB/STZqnwnfW7mLa84GiLxiG77U8AHP62m+eLOsFuxjiIjlSikUNgPgC4GSw4k71qoB6
	 tCzh4QJUMi39s6qZ7OZjPHM4TafwICHix4X4yOMo611FDYthY7WK1n1ZvzNY6x4P45mQN
	 x+tz3CNlf7Jx0Jfrb8be2aDRuhw1Csj2nZa6j7yyFNlL+8mmutj9Zr01FYMm8mb780A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VXyk6zvn;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE09606A320;
	Wed, 18 Nov 2026 20:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE09606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VXyk6zvn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795035276; x=1826571276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Z8yZI/D4aXBD6yY6mwl1Kv3eFQ1J90JCFRfS4YRBT4=;
  b=VXyk6zvnWtJaxA4FbrzTwi9wPkJQPvHdYeckQwzRfK8ZyUCRq82ml91P
   hUiZQ0vsmdnge+IZoaLrgyKJunC7dfdRlYNseUyx5dzH3HvHhoOmOHNQr
   lm1KGLv6/aob9yf5NQeITlSf56KixOp9PrsGIManH9p7CjtvCk7Z2Ifob
   03mTp8RQkqtWXLfKij9chqSZw3ti+bxCIBFC0399H+CXdNTjsD+u1CBrY
   Af59IYk7eSWa9489J5A3qMtng+5np+ARDRl1ULJINrjrqPRcHTfdT/Vr2
   LLFO+AT3ctsXv0shoscUnYnsUjCJEYaLh1OjZ5bV8+8LeYfxILObQcQ6I
   w==;
X-CSE-ConnectionGUID: rxMzRrdLRJyR/p3gj9Ca3A==
X-CSE-MsgGUID: m0AOpelIRpS0+Pw9byMp/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3750866"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3750866"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 12:54:35 -0800
X-CSE-ConnectionGUID: zFQUWE4eQdiLMAAJFqq2rQ==
X-CSE-MsgGUID: za9zUMc1RhSZjEpYJWoLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10460438"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2026 12:54:32 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTmfl-00000001ELO-0Yml;
	Wed, 18 Nov 2026 20:54:29 +0000
Date: Thu, 19 Nov 2026 04:54:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3 6/9] PM / devfreq: rockchip-dfi: make RK3588 use its
 clocks
Message-ID: <202611190436.kIOKt8jJ-lkp@intel.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-6-32ff1546b0e4@collabora.com>
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
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-6-32ff1546b0e4@collabora.com>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chanwoo/devfreq-next]
[also build test WARNING on chanwoo/devfreq-testing next-20261116]
[cannot apply to rockchip/for-next robh/for-next linus/master v7.4-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/dt-bindings-devfreq-event-rockchip-dfi-add-clocks-to-rk3588/20261117-163537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-next
patch link:    https://lore.kernel.org/r/20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-6-32ff1546b0e4%40collabora.com
patch subject: [PATCH v3 6/9] PM / devfreq: rockchip-dfi: make RK3588 use its clocks
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20261119/202611190436.kIOKt8jJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261119/202611190436.kIOKt8jJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611190436.kIOKt8jJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/devfreq/event/rockchip-dfi.c:139 struct member 'num_clks' not described in 'rockchip_dfi_variant'
>> Warning: drivers/devfreq/event/rockchip-dfi.c:139 Excess struct member 'num_clk' description in 'rockchip_dfi_variant' (did you mean one of: 'num_clks')
>> Warning: drivers/devfreq/event/rockchip-dfi.c:139 struct member 'num_clks' not described in 'rockchip_dfi_variant'
>> Warning: drivers/devfreq/event/rockchip-dfi.c:139 Excess struct member 'num_clk' description in 'rockchip_dfi_variant' (did you mean one of: 'num_clks')

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
