Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13574451068;
	Tue, 18 Aug 2026 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049061; cv=none; b=EmIXwOuf4/4TP4bwCz0kJe3zDN8bi3t9Z+WmMOLtoVH+FmczWoSik8dTcUPRIBYIs31jKFK0P6BDM803asTQsXSoW813wrsgwMwzqJmhaH0XRrjCArjnfa/rIFeDGCtEwFugd0Y7dSE3KjBW7Wcx3yYyVuIGSCsKYZe/LUkI+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049061; c=relaxed/simple;
	bh=LNSrUV/ITwJlRr8hSUge2UJlDMFjjd53gg5supooGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHI49e3bddGRSfkLWNF5My6u0E1zB0sL5Oqig+vedohHZeEepD0E7O0wcr1ESfXIvBPWi4Q4Quau2wNV3WP7fK0heBzzJQx7QDCpxshKJqQxB6udv7RTNR0/Z6demu302w7nxycCzHz52lywiZzjVvWTdj30BVhhlG3GW5juK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ai3GoKWa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ai3GoKWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787049059; x=1818585059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LNSrUV/ITwJlRr8hSUge2UJlDMFjjd53gg5supooGNg=;
  b=ai3GoKWaKn2NXRSepJ5JGDzZZmTVJ5m+ExFlBf2zXqYUhNLBagXKGP1/
   rw/E1Mqjegd2wjfkz9qihaqsICBZtJAbXi0ktZCXd36S1NfPLlqRkcdmP
   fUtsheF1nf5t2GBSXyOkiwAImaOrn9F/Mfoz5xmx3TWsYQ9NB8ygQ/kyM
   sSd3Pmecg8XOXCqttxJNCpaI0372Bh4h7pxa2ID7VVgGHcwUXlUq82fPO
   OPeQEwF5b9bSP+M6x87+NcKhGk10yyF6H7IE0/WkUUF8BhmeGrci1eUtQ
   qhpYMdj/gd9KFdDZtusN/S3kH6CwIcipUHxNQYQX8t2IApna5GPv7iZJy
   w==;
X-CSE-ConnectionGUID: /CFkzPA3T/mwNqC/0QwRyg==
X-CSE-MsgGUID: a/qMajtfSz6PVUo3PUimDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="99057347"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="99057347"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 03:30:59 -0700
X-CSE-ConnectionGUID: Du1PYORZSUewt5wAsp2TqQ==
X-CSE-MsgGUID: tDtDPAFbTnaTbYSVZx2sPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="289995416"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Aug 2026 03:30:56 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwH5p-00000000eGY-2uow;
	Tue, 18 Aug 2026 10:30:53 +0000
Date: Tue, 18 Aug 2026 18:30:09 +0800
From: kernel test robot <lkp@intel.com>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
Message-ID: <202608181850.9yczbIEQ-lkp@intel.com>
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>

Hi Maulik,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b84a0ebe421ca56995ff78b66307667b62b3a900]

url:    https://github.com/intel-lab-lkp/linux/commits/Maulik-Shah/cpuidle-Deny-idle-entry-when-CPU-already-have-IPI-interrupt-pending/20260815-180554
base:   b84a0ebe421ca56995ff78b66307667b62b3a900
patch link:    https://lore.kernel.org/r/20260403-cpuidle_ipi-v2-1-b3e44b032e2c%40oss.qualcomm.com
patch subject: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI interrupt pending
config: x86_64-randconfig-001-20260818 (https://download.01.org/0day-ci/archive/20260818/202608181850.9yczbIEQ-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260818/202608181850.9yczbIEQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608181850.9yczbIEQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: cpuidle_enter_state+0x56: call to cpus_peek_for_pending_ipi() leaves .noinstr.text section

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
