Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04895331EB0;
	Sat, 15 Aug 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838355; cv=none; b=MCcG94hoLlyST31inq+oSkRv8f6CSlO0TXUJ6IH/y1np3z+bCc44UTsIcR2iSf6rn2T5NEBwsk3RXUTS5IvCCFsgu5tkjPTqx0wxbHOJuwQfANkI9ws6auR9CSkAJn7/hn32GixhuVeaWkmnroi+D7YKERqPvjxWCpjlfyJkNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838355; c=relaxed/simple;
	bh=vQIy8Lzzf7v2RWIWimMjFYNxRWwl3Vhpoo9uAAAkoCo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GFJb6Z9mBUipRxIAK8WXBVAZdVv6S5wxASTvAsmFYn/DvuvnBqEvLwt97OEX0z2Kjy6VTwXDxCUt4paXLGYmKEVqQsPA+sGWY0EvxXSWk/PUMDRH5peepLfN6dWrH8u+ni1IxvL5KEIwZ0D8Bqj/2boGJx/b/SCuLkObtexZFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Opn47OdJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Opn47OdJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786838354; x=1818374354;
  h=date:from:to:cc:subject:message-id;
  bh=vQIy8Lzzf7v2RWIWimMjFYNxRWwl3Vhpoo9uAAAkoCo=;
  b=Opn47OdJfUwqudc0afd+92hTiTUF4lC7qLQ3RGAVKS0/Gh5WCDhKxnd1
   PtkdPS9hVs0rTO6X5Ul4wQyiB6qQ3nI7ValpNglGuEkwD396kw2XkWwN2
   w/H1XdoJDLax0d7iij6nlXe3AgYzrDnEJSrZpCSOwpd47wetPMgr18bQi
   cZuPWoO9lDx4/SZviI9o2reAekYCorvPbKNUv2yNgf0AwDfFfxERFiYbs
   FsKTFc4UE1l6f+nc6soBUKDQ4O9h+rvuDtQpQPC1oejrZMXyztEpYE9hq
   uRgwObX7IGn9Ol53/DmVupYNaANCuzsehyvhNH6aUcuAxQBzwxlHFOxl1
   Q==;
X-CSE-ConnectionGUID: J8aLLxp6Q5K6B/Seej2lBw==
X-CSE-MsgGUID: naebMU/mQYKPJcmp1pbADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="91040093"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="91040093"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 16:59:14 -0700
X-CSE-ConnectionGUID: I3WyOQdSSwWn1/lZhLZH8A==
X-CSE-MsgGUID: eqDNzFi6Te2+T3Cf+VgvHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="268815524"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Aug 2026 16:59:13 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvOHO-00000000cXE-1Mcj;
	Sat, 15 Aug 2026 23:59:10 +0000
Date: Sun, 16 Aug 2026 07:58:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 db408378f6e367f0065d9617f16850179fed82bb
Message-ID: <202608160722.s59iBg8Q-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: db408378f6e367f0065d9617f16850179fed82bb  Merge branch 'acpi-soc' into bleeding-edge

elapsed time: 770m

configs tested: 15
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-16.1.0
alpha           allyesconfig    gcc-16.1.0
alpha              defconfig    gcc-16.1.0
arc             allmodconfig    gcc-16.1.0
arc             allyesconfig    gcc-16.1.0
csky            allmodconfig    gcc-16.1.0
i386            allmodconfig    gcc-14
loongarch          defconfig    clang-24
nios2           allmodconfig    gcc-11.5.0
nios2            allnoconfig    gcc-11.5.0
parisc          allmodconfig    gcc-16.1.0
parisc          allyesconfig    gcc-16.1.0
parisc             defconfig    gcc-16.1.0
sh                 defconfig    gcc-16.1.0
sh         rsk7264_defconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
