Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934175;
	b=zVWvOYSUSoi++CwVbxlXe/pXL9Sr59BmuaIJJaGPdo0hczYsfJqHK8XZpvRakBzi4r+w
	 CQ5Ip+FNJzrYnM60NWszSNRC0kU74/Ok+HYg8CisftJBcLh2NybbMkOXWR/UtkFLZAvmh
	 V9BqWsGgs5JHWLnz5QjDNLstMTLkIWETQiWIOwjINVu8J2boNY3io02m4tPndRS6CYMxe
	 zMJ/jAdLMtsNXshWRJtRm1ZU9GukHdQkja5EOT+6hdcroYSNRRiNx0Q4h5e242k5NfSjR
	 o2R8frBbSSml2PVz62F5XqIadCkjtKNVB9wIWIn+flHhs6klmFF9gnY2w8z/ckdyyxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934175;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2YR8rl+GGFbncmUMrSW0eijCZeC2vAMN26k0XEift+0=;
	b=FnlUc41OciVWAHOFcNtu8IjBkp+Vm9BPHQrJ0dSA+KPKOw3Ho5B1vQJJ1fvF4aqyOtC0
	 xw9++0ASXLSi2awjNdchiNoMbi9wN7qSd+DKbWwNpmAXdZEMTG3IdCkonOVMamQOnPwh1
	 jlEeqBEstq41+P/WrauvgXHPll7cruFrLoHT/4IPao0Xcq/hc1S2OqLmG2TkeMP8EOO0F
	 rVcNGouzO8QijlVEd44DH0KVlaaeVru1QUxTj7/5Es02FXHK8EJWpBKGDbvBtCv2crJ3L
	 Pe/7Tx4VmVYbTBL0m8uJl3Rg4JtF2WMB6MNHrhHOB71nspOlo7ohizK7wWqmx/+efCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYBDRHMQ;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C6606A330;
	Fri,  6 Nov 2026 03:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD9C6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYBDRHMQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793934175; x=1825470175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oaSNQDemGHlJSYKH1ldJU5q8jgU2oc+ggmGZkRCO0vY=;
  b=mYBDRHMQrDmFPK/wgsrAmBkHLUgyMOZhqhrJlSBNJ6EeE/kT/Wb5Ri7T
   Q/6Cij2VVF5mdRRcpG/bqtTzBa3/lK4OnatnWgWAdVtzzXFEnSSEqubkP
   t9EUHOOS2ZjNsrYK36g954J9eQSjJrEp7gqCegQmREBz/jNI13eDqqC7r
   K6QYMZtiWqWgSjBuCB6sIoDihc5xogwAFxhdJqYpFpLxSrzBBcBpuYzhv
   bUpp0ztdRnijOnP7snHaUNtdxZlKMw/DAT7aU9mZet2vFbgX8hMZGxLUW
   TBm4I+cSeOFygcymAxuEMP5wOQswOq6UE/HH5ZdJUu0q+8YC6NHPhPRaC
   w==;
X-CSE-ConnectionGUID: LlUeD8pRRDinZxgM9ing8Q==
X-CSE-MsgGUID: CrjQuDuyTWKlMNZ+2BfrBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2759320"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2759320"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:02:54 -0800
X-CSE-ConnectionGUID: 0SsrEfIQTAyQZZu4/aazfg==
X-CSE-MsgGUID: 7VdkqNl1SV6pApz3bPbGaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7206432"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 19:02:54 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPAE6-00000000nDn-3z65;
	Fri, 06 Nov 2026 03:02:50 +0000
Date: Fri, 6 Nov 2026 11:02:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: core: add a note on descriptor
 serialization
Message-ID: <202611061108.IT0tUaIe-lkp@intel.com>
References: <20261105-pwrseq-core-desc-kerneldoc-v1-1-e10a2b03ce1f@oss.qualcomm.com>
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
In-Reply-To: <20261105-pwrseq-core-desc-kerneldoc-v1-1-e10a2b03ce1f@oss.qualcomm.com>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/power-sequencing-core-add-a-note-on-descriptor-serialization/20261105-165511
base:   ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
patch link:    https://lore.kernel.org/r/20261105-pwrseq-core-desc-kerneldoc-v1-1-e10a2b03ce1f%40oss.qualcomm.com
patch subject: [PATCH] power: sequencing: core: add a note on descriptor serialization
config: arc-randconfig-1000-20261106 (https://download.01.org/0day-ci/archive/20261106/202611061108.IT0tUaIe-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611061108.IT0tUaIe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611061108.IT0tUaIe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/power/sequencing/core.c:282 Excess struct member 'note' description in 'pwrseq_desc'
>> Warning: drivers/power/sequencing/core.c:282 Excess struct member 'note' description in 'pwrseq_desc'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
