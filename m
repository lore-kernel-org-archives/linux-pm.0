Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FCE346769;
	Tue,  8 Sep 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896550; cv=none; b=exOnQANLcfCc14u3+7zhD9ZhmpOSK/+0IJiHo2dAFKkyggV9yRh1iZzTNQazkJYDuGVlpR/jPMgb06EI+8nXUEry0hZ97qQdqo2ju03Rl5AQHBlIlS3JvE4fu/xboWl6Ka/jkE6CMctPKF1SbRWXSvXQQoR6505w4aB8oWT9iCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896550; c=relaxed/simple;
	bh=Suh8lsb5p4CCHH8X7qEY3ul4i+oN69EyqTzHAbKtRBE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UC8XOSUtQRwYt9Io/TO+YEjNrfx5oRP3MiZTzLe3mIbtpBJIs308s9mM5wlghhPVUxZIbJJ+wTXOVWCFNEalFkKLz27Ql6rXB66ckmYUVULlb3wTvgnKGhffbrOGe+guNXVcOmOfkZQRuGPsgDHqfT6eek/b/jFgEHFJjcGXAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMB8W3U+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMB8W3U+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788896549; x=1820432549;
  h=date:from:to:cc:subject:message-id;
  bh=Suh8lsb5p4CCHH8X7qEY3ul4i+oN69EyqTzHAbKtRBE=;
  b=IMB8W3U+8D+YiU+666qaz6gvWOLBagTwG2iqCv2lUkDa8wduNyADwy4n
   Z4d7F8dBQNaEEeKPfAsa9LIctWzdqLFHuEVF7mQZVacvb88D1dZdcl3/M
   cnEwbYcKymTBH063y9bRXULurP0lmQFTUb1T+OiG860Gt3UdVN0zCbxdE
   uKvDEhIigPic5KMmfnZ3SJ/X6I+1ezcOXXswjXIgUu3i0r9J3aS1EURpm
   OWldkrLAbJbUXiuvZfH1Hd47wPd106JuKpqbm5yllOVmmTxrSSedH7sdU
   5bylpvCADvCpi3FTpKVcKT7zEYmaxQWHfUci0HNB6rw9bvIvPM18w9a0Y
   g==;
X-CSE-ConnectionGUID: yc3eF24iQaCKNompoFLm5w==
X-CSE-MsgGUID: uqL/h1sHTtSLuzOytDgryQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89183842"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89183842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 12:42:28 -0700
X-CSE-ConnectionGUID: w/PfxS+dTYaOJvRcZWMT9A==
X-CSE-MsgGUID: CYhoqffBR8GOQpMlhjiXnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="294606661"
Received: from lkp-server01.sh.intel.com (HELO dc5b8f51e05b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Sep 2026 12:42:27 -0700
Received: from kbuild by dc5b8f51e05b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x41i4-000000000m3-1nbm;
	Tue, 08 Sep 2026 19:42:24 +0000
Date: Wed, 09 Sep 2026 03:41:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3083a286e913923a341abaddb80a9c9284ef4f24
Message-ID: <202609090342.FpTORqaX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3083a286e913923a341abaddb80a9c9284ef4f24  Merge branch 'acpi-apei' into linux-next

elapsed time: 1491m

configs tested: 78
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-16.1.0
alpha        allyesconfig    gcc-16.1.0
arc          allmodconfig    clang-24
arc          allmodconfig    gcc-16.1.0
arc           allnoconfig    gcc-16.1.0
arm           allnoconfig    clang-17
arm           allnoconfig    gcc-16.1.0
arm          allyesconfig    clang-24
arm          allyesconfig    gcc-16.1.0
arm64         allnoconfig    gcc-16.1.0
csky         allmodconfig    gcc-16.1.0
csky          allnoconfig    gcc-16.1.0
hexagon      allmodconfig    clang-24
hexagon      allmodconfig    gcc-16.1.0
hexagon       allnoconfig    clang-24
hexagon       allnoconfig    gcc-16.1.0
i386         allmodconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386          allnoconfig    gcc-16.1.0
i386         allyesconfig    clang-22
i386         allyesconfig    gcc-14
loongarch     allnoconfig    clang-20
loongarch     allnoconfig    gcc-16.1.0
m68k         allmodconfig    gcc-16.1.0
m68k          allnoconfig    gcc-16.1.0
m68k         allyesconfig    clang-24
m68k         allyesconfig    gcc-16.1.0
microblaze    allnoconfig    gcc-16.1.0
microblaze   allyesconfig    gcc-16.1.0
mips         allmodconfig    gcc-16.1.0
mips          allnoconfig    gcc-16.1.0
mips         allyesconfig    gcc-16.1.0
nios2        allmodconfig    clang-20
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    clang-24
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    clang-20
openrisc     allmodconfig    gcc-16.1.0
openrisc      allnoconfig    clang-24
openrisc      allnoconfig    gcc-16.1.0
parisc       allmodconfig    gcc-16.1.0
parisc        allnoconfig    clang-24
parisc        allnoconfig    gcc-16.1.0
parisc       allyesconfig    clang-17
parisc       allyesconfig    gcc-16.1.0
powerpc      allmodconfig    gcc-16.1.0
powerpc       allnoconfig    clang-24
powerpc       allnoconfig    gcc-16.1.0
riscv         allnoconfig    clang-24
riscv         allnoconfig    gcc-16.1.0
riscv        allyesconfig    clang-24
s390         allmodconfig    clang-17
s390         allmodconfig    clang-24
s390          allnoconfig    clang-24
s390         allyesconfig    gcc-16.1.0
sh           allmodconfig    gcc-16.1.0
sh            allnoconfig    clang-24
sh            allnoconfig    gcc-16.1.0
sh           allyesconfig    clang-17
sh           allyesconfig    gcc-16.1.0
sparc         allnoconfig    clang-24
sparc         allnoconfig    gcc-16.1.0
sparc64      allmodconfig    clang-20
um           allmodconfig    clang-17
um            allnoconfig    clang-17
um            allnoconfig    clang-24
um           allyesconfig    gcc-14
um           allyesconfig    gcc-16.1.0
x86_64       allmodconfig    clang-22
x86_64        allnoconfig    clang-22
x86_64        allnoconfig    clang-24
x86_64       allyesconfig    clang-22
x86_64      rhel-9.4-rust    clang-22
xtensa        allnoconfig    clang-24
xtensa        allnoconfig    gcc-16.1.0
xtensa       allyesconfig    clang-20
xtensa       allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
