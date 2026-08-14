Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57A3E2AC8;
	Fri, 14 Aug 2026 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743915; cv=none; b=e+jgpBAhIPI8+YAx1vqMjuQHtlnUDpwUekmAf7F8IMYqGrOqNZKijpQNiR+6Uby8yaB5YYRAzPEcWQ+urA6Wc+KHczSOv7cxwIxasKjcpbP7HS0Bz0j9/gTLcJQavPTehteei+Cgirod7W1OMkBmcp7DK8Y+WcFjmPbh5x2MTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743915; c=relaxed/simple;
	bh=YUix+X7HQEuVx90naR8Mkyb9fD3a0rcCi68P0ctqLG8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n1/d1uVAinRbo4n8ouypo+e54/plM56fminnvqXTn/zBCTNqahnAFCQR9/1Rrvp2xpx90VqW+6J7xyXK4V0hPQtIdJOad6XwVKPOLkYhwTPc4DeB6NvlIOcmX7sN1SMZakrXbqN7cFLS81+/FlwchcfQBVq0BmtOvur1fcXNPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8P4boft; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8P4boft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786743914; x=1818279914;
  h=date:from:to:cc:subject:message-id;
  bh=YUix+X7HQEuVx90naR8Mkyb9fD3a0rcCi68P0ctqLG8=;
  b=a8P4boftsbxnl+L5OgtX26zg4sJ/B96AbUtm7umkk7W5HQWpccsEJKN3
   IBPs3ttTQM30rNKSHAhVC9fDDlVQvIYMFVYE7/fettM2+8vUFJdJ2vX3n
   XxN4gefIowxyB764QX6Sb0Lf60v8FYXn6ZaCjrbT9a5IkJ+DRhIx8FBuZ
   67NaF6Vsc1FRyZ/SgC7V2TKRUYtuDIoEMMe0WobdUBrt5Ze+NSrEvKYc1
   KTH3PIgviA94kwYru3nuR+Gv5Oj/Kon45qU46ATOC99w3j9CEDwZ/hwUB
   9fMxDyUJyjzHuNl9MnGyuv+owZ0YnTCF0IyRGqWjYdju1JSnuvEqCAbUZ
   g==;
X-CSE-ConnectionGUID: fWwyoRwDRuG5jWfEuoNctg==
X-CSE-MsgGUID: i5h4iSHfROGV8QMmEYeG0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="91138434"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="91138434"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 14:45:11 -0700
X-CSE-ConnectionGUID: YmzC+uN2Q+KmWdE5WYjj6g==
X-CSE-MsgGUID: rHDpHf79SvWSli2Cc11T6w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Aug 2026 14:45:10 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuzi7-00000000aI6-2cHP;
	Fri, 14 Aug 2026 21:45:07 +0000
Date: Sat, 15 Aug 2026 05:44:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 625ebfae138fc0ff127c03188d613655a6c7444a
Message-ID: <202608150539.vrc46RLO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 625ebfae138fc0ff127c03188d613655a6c7444a  Merge branch 'thermal' into bleeding-edge

elapsed time: 794m

configs tested: 23
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                  allnoconfig    gcc-16.1.0
alpha                 allyesconfig    gcc-16.1.0
alpha                    defconfig    gcc-16.1.0
arc                   allmodconfig    gcc-16.1.0
arc                   allyesconfig    gcc-16.1.0
csky                  allmodconfig    gcc-16.1.0
csky       randconfig-001-20260815    gcc-13.4.0
csky       randconfig-002-20260815    gcc-15.2.0
i386                  allmodconfig    gcc-14
loongarch                defconfig    clang-24
nios2                 allmodconfig    gcc-11.5.0
nios2                  allnoconfig    gcc-11.5.0
parisc                allmodconfig    gcc-16.1.0
parisc                allyesconfig    gcc-16.1.0
parisc                   defconfig    gcc-16.1.0
sh                       defconfig    gcc-16.1.0
um                x86_64_defconfig    clang-24
x86_64     randconfig-011-20260815    clang-22
x86_64     randconfig-012-20260815    gcc-14
x86_64     randconfig-013-20260815    clang-22
x86_64     randconfig-014-20260815    clang-22
x86_64     randconfig-015-20260815    gcc-14
x86_64     randconfig-016-20260815    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
