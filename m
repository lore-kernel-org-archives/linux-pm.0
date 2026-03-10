Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEF43E48A;
	Tue, 10 Mar 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137585; cv=none; b=QCZ/pdWwRXFBuZXgpmzTnVXQukwGXrfnw6VZcHhCGh5piNqn88QbqpCFeiQVgGllPhadwQ87ERfiOqX7ItA1NfRn+xmfERQq5a3RpNiLKLBgar1cArlp0gV7ldkCVI4/h5giAkJT3755+AnJ5/VlywIYtnRyTvXgITF72Jdsjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137585; c=relaxed/simple;
	bh=kGl1AiP2y4nJT1Ekz+dqxJlitvGyd3vY/7cfmzQLFs4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pPd7Ah/5PaUr7Js2BOd+FGIqY6grF6Qp7HCWdxi63kbbDC46P7EqRMOlr8ihxkUX95O1TVzcEut7oUsxN2H28bqcq/mfEnk6g+slfLzPDHL7fKAqKY2bMaFDegKlBODRs57BNDo81kDlahCF+ch8ppjolbcNnr+PxvPbuikUIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHvDJ3mE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHvDJ3mE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773137583; x=1804673583;
  h=date:from:to:cc:subject:message-id;
  bh=kGl1AiP2y4nJT1Ekz+dqxJlitvGyd3vY/7cfmzQLFs4=;
  b=AHvDJ3mE2h6nArPqjxEZGKlnrJklPJ9f5kTYPJJG5EW9rWpDolQ60Asr
   XxupEx178UgFcmu+07KNw/trPb1/tZEleZX7LfSitvGtVC6GeKRPgcHqk
   w2/EUuZFP/pihNzpy4X9MX6+Kk6FnXR4LRSy+WWZMtTjWDgRUxAb5e9BP
   FI2EmAKMVcE9vUhmzJM6lSk2jzzRlKNA6AUXv3zSzDn9DYYimikYLbRt1
   fHFuNJYPdAyMWKgeP59z6jUveOZ60FCKTG5bKnud5EEfpaATdX7q62Qhq
   a9VC6dbm3xnIvIZQ6ulUqeti6pKAPE25R9BVNHsmsaJ3NdyvPf5VqmICJ
   g==;
X-CSE-ConnectionGUID: D6R75ibUSQmgVXtyqd1y5A==
X-CSE-MsgGUID: JbFmJesRQL66fluNpvUD+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="76787711"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="76787711"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 03:13:02 -0700
X-CSE-ConnectionGUID: TXWG15DFRJ6D30KbDn3Urg==
X-CSE-MsgGUID: ic6QgQWuQSGPXvuipuo+Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216864156"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Mar 2026 03:13:01 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzu5C-000000001i2-2T0O;
	Tue, 10 Mar 2026 10:12:58 +0000
Date: Tue, 10 Mar 2026 18:12:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 140/141] ld.lld: error: undefined
 symbol: auxiliary_device_init
Message-ID: <202603101801.WkDiQ5K0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   4ebf43399f2d20075ab4ab03c0270169af62ba36
commit: cc2b80418f5a9958cc550deeea9a65d598afe514 [140/141] ACPI: video: Switch over to auxiliary bus type
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260310/202603101801.WkDiQ5K0-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c32caeec8158d634bb71ab8911a6031248b9fc47)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260310/202603101801.WkDiQ5K0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603101801.WkDiQ5K0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: auxiliary_device_init
   >>> referenced by scan.c
   >>>               drivers/acpi/scan.o:(acpi_default_enumeration) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __auxiliary_device_add
   >>> referenced by scan.c
   >>>               drivers/acpi/scan.o:(acpi_default_enumeration) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
