Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF3335064;
	Tue, 18 Aug 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043093; cv=none; b=rT8sfTJn6nZFHVcLokfwcxpQutfvCXx771PbQPEj3wF1Z2SHznpipbi4RLjYSmhD+d6LUg9nVGkGORRADjBmWlr05FGU+lJDpai0VS39U/HOyGZUoAlhVnY/8GGqdxRcCH//eeGKYfDnEGRQOaKEUUSR7VCL0n607mY/MzVlSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043093; c=relaxed/simple;
	bh=4CnP61+049zgvAdEjGQXHJyNjC6r3RyBTFm8BmjfYyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUX3Of/+b56C1jcEJ+lF6npf/YfqLsc8nBXpiO++YyR7oyt7htrD7NRV+FKvmdTdHb7Icf5FaIBVxnQj4RSOMX5gSgq0IVSuvu26xzl9HN1KgUUcECbgrMoLm8qkuKtEHoChE0nIpo+Phv80FMaVJlZARljwaP8OI+DBmTQr8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9v6LZ7o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9v6LZ7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787043092; x=1818579092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CnP61+049zgvAdEjGQXHJyNjC6r3RyBTFm8BmjfYyw=;
  b=T9v6LZ7o1Ljn8cH7ag1aszATDqUif9YojGIxnowWv7L4eX59IzKvbIXm
   PkX3Tj8V1wk+GY+Fd8E2SAdwNzsqexvAP3XQElsbTkxQzprzHG5Fis0SR
   QY5QE2K3bJjn7MS+eB0A3n99nuA5p8w8oWdjjr6GohiKFfpj4a7U0dBie
   Y6NfUCM99l4pDg1V4R2uYZiAcY17V/p1Ixhe6w9sgnE2Y+KuxGnslMVTY
   a32zvPwcrDyffLx8HKUyvcoCcWtsTiowexi6Dcy/UA0jP9LW0NY0ETJPH
   oq3O6mEAzzKdkKvXjVXRUPOSCQGVuEJJiHG7mMv1ikfKj6ec0aqlsvgwy
   A==;
X-CSE-ConnectionGUID: OvYkIlTEQtqymZ4YH6Weaw==
X-CSE-MsgGUID: 5GDtRC+ETFCeHqTWgslp+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87650662"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87650662"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:51:31 -0700
X-CSE-ConnectionGUID: v9ETOGviR7+8lKZk4N5vsA==
X-CSE-MsgGUID: SUdeV4EDTzezHj4ymAX03Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="270384987"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2026 01:51:28 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwFXa-00000000eD8-1IjG;
	Tue, 18 Aug 2026 08:51:26 +0000
Date: Tue, 18 Aug 2026 16:51:14 +0800
From: kernel test robot <lkp@intel.com>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
Message-ID: <202608181649.yR8lLTtW-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on b84a0ebe421ca56995ff78b66307667b62b3a900]

url:    https://github.com/intel-lab-lkp/linux/commits/Maulik-Shah/cpuidle-Deny-idle-entry-when-CPU-already-have-IPI-interrupt-pending/20260815-180554
base:   b84a0ebe421ca56995ff78b66307667b62b3a900
patch link:    https://lore.kernel.org/r/20260403-cpuidle_ipi-v2-1-b3e44b032e2c%40oss.qualcomm.com
patch subject: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI interrupt pending
config: x86_64-randconfig-002-20260818 (https://download.01.org/0day-ci/archive/20260818/202608181649.yR8lLTtW-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260818/202608181649.yR8lLTtW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608181649.yR8lLTtW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> vmlinux.o: error: objtool: cpuidle_enter_state+0x81: call to cpus_peek_for_pending_ipi() leaves .noinstr.text section

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
