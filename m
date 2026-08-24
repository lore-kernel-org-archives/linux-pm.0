Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787F2EA75E;
	Mon, 24 Aug 2026 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787614475; cv=none; b=ohqgPsh+hdF/Kyz6eICz0hH9XAWSUaLTaBwetNBLidzmsx1wXc7hoAkMIy1hluQ5scpzg8GH3fplevBDZEQSbPWGWeQMafg/I2xTsy6LM8gxcz9xRakpRB+FdhuOJANlaGsGwrXMH1ehfTjFOEKByL+nIvTF8lZrMBdskZ52Q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787614475; c=relaxed/simple;
	bh=I8hw8QcYhrVE0Xtu/s4HveX5wFVFRiZ/9FuQd30RZQw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=by2sfSw2gcTb7sDvrK135V34P2KP7vr/LMVGQZOeKMnhS8xhKu5PwrtwMp+CDpL/pT5IxRvfmX7lpKMB9dsc5oMG41RwwPJDWcsNreV3UlwApHwdGPlbKLuKGqJQXvSjV8UY6qXg7WgBaAsI16Ff2aydp/4Sxlx4y6gGbOogb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUVtNNWV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUVtNNWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787614472; x=1819150472;
  h=date:from:to:cc:subject:message-id;
  bh=I8hw8QcYhrVE0Xtu/s4HveX5wFVFRiZ/9FuQd30RZQw=;
  b=PUVtNNWVYDegcuS0V0bLqtEWpLYzIfVWQ7cGqsH4fCEBeekEGegj1XG1
   KxByOCN6sOJDURdh4of65jWCoIcEsWgZ9YRX4Q/6S2VwNw88H/+k7ucGD
   S7MeYp7RM2R0QQV/fuU6n2Qa/SEI45KR1CWqRGhQ44IyDiu8l0o4v7pjf
   s8A/4DEZx9uQIgOTLOtL/F25kCcFSRu3CgbUMioDCvhZUllIRBKvGFG1i
   L+SdWCPKQt6yj03mcCjH96yb89kEhYUDYlWmR+Sr04gOBA0bpyAcI2S0D
   xGMv/Ltvc8Cz+bxUNvv3bdwgAbFsx2bXe175HDhn+8C/cCUw/U65JpLru
   g==;
X-CSE-ConnectionGUID: oHk1bNY6SfeCHLNJr/F3jQ==
X-CSE-MsgGUID: TdFhCoUjR8GB9M2tAB4Kxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87841415"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87841415"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 16:34:31 -0700
X-CSE-ConnectionGUID: vAmsXkNvQMi2gzv0eMocnw==
X-CSE-MsgGUID: k2SvPbSXTsCD9fzwmjL7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="271336694"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Aug 2026 16:34:30 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyeBK-000000004Yn-1ZiC;
	Mon, 24 Aug 2026 23:34:24 +0000
Date: Tue, 25 Aug 2026 07:33:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9906109d1e9a0544cf0816740ba5a130400c6256
Message-ID: <202608250720.hjGwJBus-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9906109d1e9a0544cf0816740ba5a130400c6256  Merge branch 'pm-powercap-next' into bleeding-edge

elapsed time: 760m

configs tested: 14
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha       allnoconfig    gcc-16.1.0
alpha      allyesconfig    gcc-16.1.0
alpha         defconfig    gcc-16.1.0
arc        allmodconfig    gcc-16.1.0
arc        allyesconfig    gcc-16.1.0
csky       allmodconfig    gcc-16.1.0
i386       allmodconfig    gcc-14
loongarch     defconfig    clang-24
nios2       allnoconfig    gcc-11.5.0
parisc     allmodconfig    gcc-16.1.0
parisc     allyesconfig    gcc-16.1.0
parisc        defconfig    gcc-16.1.0
sh            defconfig    gcc-16.1.0
sparc      alldefconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
