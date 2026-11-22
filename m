Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362398;
	b=oBr20z54v7PxkvlqO0vGikfEDQDtWC7Bv764HDnNzPUAIELfuppS7pZ7ChD/ne0aKf7x
	 LHmdzuzgW+4hOQFLlSCZq+vxPZVF9nhuiY4G4y8Zc5MVi6KKXJHwJ2aWXRirIe3+cBwE+
	 3Ueu+aYhLiezVAP8OYt7c+FyhUOJy3HuQSYyCpHR0Ow46vHunUkZ4Ci3ODlyWrYffJpth
	 8vRK6ffSEhRF/qkieTL4oCMQ+s3o9mpqzstpi16c3KSYaG34yRpL5iHlSLiETyLd+AGgY
	 iLrKAMB3JxjAARXBAQK8Z+/MrFfwMPB10QzlSddqgNe907lmoNMq0hMUJE1GdPWnnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362398;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=5sbLdaThESFnxpqpOLZGNmhmaNAD3AjrnPk97HLbIxw=;
	b=Zmz6shnEzMFKoEu3HfXFFDZN3pSpLaopNWp9LrOOEjKfD3xykVtMQ3cad52HvMoxl30I
	 dWKh2rsVZWRZroTfFxruPQCFsDY97uegQkYxm1yq4+Ll09LeNPkjQzb3Kiy0mGvYmzKOk
	 yjKTxjYg4V2KDqFKmDNVIPwI6sVaMJoaGwnaDRzRKJFS8JYKHy/2vp1Sh5NSdt753muhy
	 TAxDLYHra7XRFHYLysmK4HCkDxFSouc7xS/oTkyz8JETgDHSyu6T9p/hM+hS85B/GuksV
	 RyUPIX/9f4wBRSuwq6DsLic2CEct7yZxiB1rVL6fWg88IlIZC8lTQ/VczAvbBjLmO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TSF97giT;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156C606A331;
	Sun, 22 Nov 2026 15:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C156C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TSF97giT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795362397; x=1826898397;
  h=date:from:to:cc:subject:message-id;
  bh=QmtKAMLPtEeq/t2hgpyKJuYSu1VzFF7xmNpUhYlc60M=;
  b=TSF97giT29SfCWXTJMXeFbbHkN8TN1nAxRR91Wh+9QYYTWEeszT8AzYA
   9hKg5iXH93VTi8D39V9NMsJdS0Xs1XFu7x73GOChd6ZipmIeOyhmk9EAi
   jPlAlNGXAI3wtVRWi3y/1WMif6MN//BPP2GMpAIVkzdwfXRyxPs9CDgdE
   hba5AJunMuldo9y30WvNpf9fYxFRSWDFfRQKSUL378cMQmIdHIOcOFebs
   QahWFJsF2uI2i06C8WuJyWWZ6Ixo17QYRql+9LYkd8dL/zXaY5fi0pXu3
   TJFkuojOgufvHtTSxniYCfU9lHE7L3zasgVNv8imuxXCvMmjDwQIwlqyP
   A==;
X-CSE-ConnectionGUID: QUZ2d3fMQnyGFnJTp4iV3A==
X-CSE-MsgGUID: FVuG5bNHQAic64q4X9y8rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4165138"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4165138"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 07:46:36 -0800
X-CSE-ConnectionGUID: t81pCAIITCuoeh+MhSYDBA==
X-CSE-MsgGUID: m/ZwNgrKSlWo34eHw/fqeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11434617"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Nov 2026 07:46:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xV9lw-00000001LgA-0I7A;
	Sun, 22 Nov 2026 15:46:32 +0000
Date: Sun, 22 Nov 2026 23:46:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3df0ac662b93d4a30f7db81a36105dc42f852973
Message-ID: <20261122234610.40fpRDhd-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3df0ac662b93d4a30f7db81a36105dc42f852973  Merge branch 'pm-powercap' into bleeding-edge

elapsed time: 1125m

configs tested: 415
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.2.0
alpha                             allyesconfig    gcc-16.2.0
alpha                 randconfig-2000-20261120    gcc-15.3.0
alpha                 randconfig-2000-20261121    gcc-14.4.0
alpha                 randconfig-2001-20261120    gcc-15.3.0
alpha                 randconfig-2001-20261121    gcc-14.4.0
alpha                 randconfig-2200-20261120    gcc-15.3.0 smatch
alpha                 randconfig-2200-20261121    gcc-10.5.0 smatch
alpha                randconfig-r2308-20261121    gcc-8.5.0  sparse
arc                               allmodconfig    clang-24
arc                               allmodconfig    gcc-16.2.0
arc                                allnoconfig    gcc-16.2.0
arc                               allyesconfig    clang-24
arc                   randconfig-1000-20261122    clang-17
arc                   randconfig-1001-20261122    clang-17
arc                   randconfig-2000-20261121    gcc-8.5.0
arc                   randconfig-2001-20261121    gcc-8.5.0
arc                   randconfig-2002-20261121    gcc-8.5.0
arc                   randconfig-2003-20261121    gcc-8.5.0
arc                   randconfig-2004-20261121    gcc-8.5.0
arc                   randconfig-2005-20261121    gcc-8.5.0
arc                   randconfig-2200-20261120    gcc-15.3.0 smatch
arc                   randconfig-2200-20261121    gcc-14.4.0 smatch
arc                  randconfig-r2101-20261121    gcc-9.5.0  cocci
arc                  randconfig-r2109-20261120    gcc-8.5.0  cocci
arc                  randconfig-r2304-20261120    clang-24   sparse
arc                  randconfig-r2309-20261120    clang-24   sparse
arm                                allnoconfig    gcc-16.2.0
arm                               allyesconfig    clang-24
arm                   randconfig-1000-20261122    clang-17
arm                   randconfig-1001-20261122    clang-17
arm                   randconfig-1002-20261122    clang-17
arm                   randconfig-1003-20261122    clang-17
arm                   randconfig-2000-20261120    gcc-8.5.0
arm                   randconfig-2000-20261121    clang-24
arm                   randconfig-2001-20261120    gcc-8.5.0
arm                   randconfig-2001-20261121    clang-24
arm                   randconfig-2002-20261120    gcc-8.5.0
arm                   randconfig-2002-20261121    clang-24
arm                   randconfig-2200-20261120    clang-17   smatch
arm                   randconfig-2200-20261121    clang-19   smatch
arm                  randconfig-r2106-20261120    gcc-8.5.0  cocci
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.2.0
arm64                 randconfig-1000-20261122    gcc-8.5.0
arm64                 randconfig-1001-20261122    gcc-8.5.0
arm64                 randconfig-1002-20261122    gcc-8.5.0
arm64                 randconfig-1003-20261122    gcc-8.5.0
arm64                 randconfig-2000-20261120    gcc-8.5.0
arm64                 randconfig-2000-20261121    clang-24
arm64                 randconfig-2001-20261120    gcc-8.5.0
arm64                 randconfig-2001-20261121    clang-24
arm64                 randconfig-2002-20261120    gcc-8.5.0
arm64                 randconfig-2002-20261121    clang-24
arm64                 randconfig-2200-20261121    clang-22   smatch
arm64                randconfig-r2102-20261120    clang-24   cocci
arm64                randconfig-r2104-20261121    gcc-9.5.0  cocci
arm64                randconfig-r2300-20261120    clang-24   sparse
csky                              allmodconfig    gcc-16.2.0
csky                               allnoconfig    gcc-16.2.0
csky                  randconfig-1000-20261122    gcc-8.5.0
csky                  randconfig-1001-20261122    gcc-8.5.0
csky                  randconfig-2000-20261120    gcc-16.2.0
csky                  randconfig-2000-20261121    gcc-16.2.0
csky                  randconfig-2001-20261120    gcc-16.2.0
csky                  randconfig-2001-20261121    gcc-16.2.0
csky                  randconfig-2200-20261120    gcc-15.3.0 smatch
csky                  randconfig-2200-20261121    gcc-16.2.0 smatch
csky                 randconfig-r2300-20261121    clang-24   sparse
hexagon                           allmodconfig    gcc-16.2.0
hexagon                            allnoconfig    gcc-16.2.0
hexagon               randconfig-2000-20261120    gcc-16.2.0
hexagon               randconfig-2000-20261121    gcc-16.2.0
hexagon               randconfig-2001-20261120    gcc-16.2.0
hexagon               randconfig-2001-20261121    gcc-16.2.0
hexagon               randconfig-2200-20261120    clang-17   smatch
hexagon               randconfig-2200-20261121    clang-24   smatch
hexagon              randconfig-r2107-20261121    gcc-16.2.0 cocci
hexagon              randconfig-r2108-20261120    gcc-8.5.0  cocci
hexagon              randconfig-r2303-20261121    clang-24   sparse
hexagon              randconfig-r2309-20261121    gcc-8.5.0  sparse
hexagon              randconfig-r2310-20261121    gcc-8.5.0  sparse
hexagon              randconfig-r2311-20261121    gcc-8.5.0  sparse
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.2.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261122    gcc-14
i386        buildonly-randconfig-1001-20261122    gcc-14
i386        buildonly-randconfig-1002-20261122    gcc-14
i386        buildonly-randconfig-1003-20261122    gcc-14
i386        buildonly-randconfig-1004-20261122    gcc-14
i386        buildonly-randconfig-1005-20261122    gcc-14
i386                  randconfig-2000-20261120    clang-22
i386                  randconfig-2000-20261121    gcc-14
i386                  randconfig-2001-20261120    clang-22
i386                  randconfig-2001-20261121    gcc-14
i386                  randconfig-2002-20261120    clang-22
i386                  randconfig-2002-20261121    gcc-14
i386                  randconfig-2003-20261120    clang-22
i386                  randconfig-2003-20261121    gcc-14
i386                  randconfig-2004-20261120    clang-22
i386                  randconfig-2004-20261121    gcc-14
i386                  randconfig-2005-20261120    clang-22
i386                  randconfig-2005-20261121    gcc-14
i386                  randconfig-2100-20261120    gcc-14     cocci
i386                  randconfig-2100-20261121    clang-22   cocci
i386                  randconfig-2101-20261120    gcc-14     cocci
i386                  randconfig-2101-20261121    clang-22   cocci
i386                  randconfig-2102-20261120    gcc-14     cocci
i386                  randconfig-2102-20261121    clang-22   cocci
i386                  randconfig-2103-20261120    gcc-14     cocci
i386                  randconfig-2103-20261121    clang-22   cocci
i386                  randconfig-2104-20261120    gcc-14     cocci
i386                  randconfig-2104-20261121    clang-22   cocci
i386                  randconfig-2105-20261120    gcc-14     cocci
i386                  randconfig-2105-20261121    clang-22   cocci
i386                  randconfig-2200-20261120    clang-22   smatch
i386                  randconfig-2200-20261121    clang-22   smatch
i386                  randconfig-2300-20261120    clang-22   sparse
i386                  randconfig-2300-20261121    gcc-14     sparse
i386                  randconfig-2301-20261120    clang-22   sparse
i386                  randconfig-2301-20261121    gcc-14     sparse
i386                  randconfig-2302-20261120    clang-22   sparse
i386                  randconfig-2302-20261121    gcc-14     sparse
i386                 randconfig-r2304-20261121    clang-24   sparse
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.2.0
loongarch                            defconfig    clang-24
loongarch             randconfig-2000-20261120    clang-24
loongarch             randconfig-2001-20261120    clang-24
loongarch             randconfig-2200-20261120    clang-18   smatch
loongarch             randconfig-2200-20261121    gcc-16.2.0 smatch
loongarch            randconfig-r2101-20261120    clang-24   cocci
loongarch            randconfig-r2103-20261120    clang-24   cocci
loongarch            randconfig-r2110-20261120    gcc-8.5.0  cocci
loongarch            randconfig-r2311-20261120    clang-24   sparse
m68k                              allmodconfig    gcc-16.2.0
m68k                               allnoconfig    gcc-16.2.0
m68k                              allyesconfig    clang-24
m68k                              allyesconfig    gcc-16.2.0
m68k                                 defconfig    clang-24
m68k                  randconfig-2000-20261120    gcc-15.3.0
m68k                  randconfig-2000-20261121    gcc-14.4.0
m68k                  randconfig-2001-20261120    gcc-15.3.0
m68k                  randconfig-2001-20261121    gcc-14.4.0
m68k                  randconfig-2200-20261120    gcc-14.4.0 smatch
m68k                  randconfig-2200-20261121    gcc-8.5.0  smatch
m68k                 randconfig-r2103-20261121    gcc-9.5.0  cocci
m68k                 randconfig-r2104-20261120    clang-24   cocci
m68k                 randconfig-r2105-20261120    clang-24   cocci
m68k                 randconfig-r2106-20261121    gcc-16.2.0 cocci
microblaze                         allnoconfig    gcc-16.2.0
microblaze                        allyesconfig    gcc-16.2.0
microblaze                           defconfig    clang-24
microblaze            randconfig-2000-20261120    gcc-15.3.0
microblaze            randconfig-2000-20261121    gcc-14.4.0
microblaze            randconfig-2001-20261120    gcc-15.3.0
microblaze            randconfig-2001-20261121    gcc-14.4.0
microblaze            randconfig-2200-20261120    gcc-11.5.0 smatch
microblaze            randconfig-2200-20261121    gcc-8.5.0  smatch
mips                              allmodconfig    gcc-16.2.0
mips                               allnoconfig    gcc-16.2.0
mips                              allyesconfig    gcc-16.2.0
mips                  randconfig-2000-20261120    gcc-9.5.0
mips                  randconfig-2000-20261121    gcc-16.2.0
mips                  randconfig-2001-20261120    gcc-9.5.0
mips                  randconfig-2001-20261121    gcc-16.2.0
mips                  randconfig-2002-20261120    gcc-9.5.0
mips                  randconfig-2002-20261121    gcc-16.2.0
mips                  randconfig-2200-20261120    clang-24   smatch
mips                  randconfig-2200-20261121    clang-21   smatch
mips                 randconfig-r2107-20261120    gcc-8.5.0  cocci
mips                 randconfig-r2301-20261121    clang-24   sparse
mips                 randconfig-r2302-20261120    clang-24   sparse
mips                 randconfig-r2305-20261121    clang-24   sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-2000-20261120    clang-24
nios2                 randconfig-2001-20261120    clang-24
nios2                 randconfig-2200-20261120    gcc-11.5.0 smatch
nios2                 randconfig-2200-20261121    gcc-10.5.0 smatch
nios2                randconfig-r2306-20261120    clang-24   sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.2.0
openrisc              randconfig-2000-20261120    gcc-9.5.0
openrisc              randconfig-2000-20261121    gcc-16.2.0
openrisc              randconfig-2001-20261120    gcc-9.5.0
openrisc              randconfig-2001-20261121    gcc-16.2.0
openrisc              randconfig-2002-20261120    gcc-9.5.0
openrisc              randconfig-2002-20261121    gcc-16.2.0
openrisc              randconfig-2200-20261120    gcc-11.5.0 smatch
openrisc              randconfig-2200-20261121    gcc-14.4.0 smatch
openrisc             randconfig-r2305-20261120    clang-24   sparse
openrisc             randconfig-r2306-20261121    gcc-8.5.0  sparse
parisc                            allmodconfig    gcc-16.2.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.2.0
parisc                randconfig-1000-20261122    clang-24
parisc                randconfig-1001-20261122    clang-24
parisc                randconfig-2000-20261120    clang-24
parisc                randconfig-2001-20261120    clang-24
parisc                randconfig-2200-20261120    gcc-8.5.0  smatch
parisc                randconfig-2200-20261121    gcc-16.2.0 smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.2.0
powerpc                            allnoconfig    clang-24
powerpc               randconfig-1000-20261122    clang-24
powerpc               randconfig-1001-20261122    clang-24
powerpc               randconfig-2000-20261120    clang-24
powerpc               randconfig-2000-20261121    clang-24
powerpc               randconfig-2001-20261120    clang-24
powerpc               randconfig-2001-20261121    clang-24
powerpc               randconfig-2002-20261120    clang-24
powerpc               randconfig-2002-20261121    clang-24
powerpc               randconfig-2200-20261120    clang-17   smatch
powerpc               randconfig-2200-20261121    gcc-11.5.0 smatch
powerpc              randconfig-r2102-20261121    gcc-9.5.0  cocci
powerpc              randconfig-r2308-20261120    clang-24   sparse
powerpc64             randconfig-1000-20261122    clang-24
powerpc64             randconfig-1001-20261122    clang-24
powerpc64             randconfig-2000-20261120    clang-24
powerpc64             randconfig-2000-20261121    clang-24
powerpc64             randconfig-2001-20261120    clang-24
powerpc64             randconfig-2001-20261121    clang-24
powerpc64             randconfig-2002-20261120    clang-24
powerpc64             randconfig-2002-20261121    clang-24
powerpc64             randconfig-2200-20261120    gcc-16.2.0 smatch
powerpc64             randconfig-2200-20261121    gcc-10.5.0 smatch
powerpc64            randconfig-r2100-20261120    clang-24   cocci
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.2.0
riscv                 randconfig-1000-20261122    gcc-9.5.0
riscv                 randconfig-1001-20261122    gcc-9.5.0
riscv                 randconfig-2000-20261120    clang-24
riscv                 randconfig-2000-20261121    gcc-9.5.0
riscv                 randconfig-2001-20261120    clang-24
riscv                 randconfig-2001-20261121    gcc-9.5.0
riscv                 randconfig-2002-20261120    clang-24
riscv                 randconfig-2002-20261121    gcc-9.5.0
riscv                 randconfig-2003-20261120    clang-24
riscv                 randconfig-2003-20261121    gcc-9.5.0
riscv                 randconfig-2004-20261120    clang-24
riscv                 randconfig-2004-20261121    gcc-9.5.0
riscv                 randconfig-2005-20261120    clang-24
riscv                 randconfig-2005-20261121    gcc-9.5.0
riscv                 randconfig-2200-20261120    gcc-8.5.0  smatch
riscv                 randconfig-2200-20261121    clang-24   smatch
riscv                randconfig-r2310-20261120    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.2.0
s390                                 defconfig    gcc-16.2.0
s390                  randconfig-1000-20261122    gcc-9.5.0
s390                  randconfig-1001-20261122    gcc-9.5.0
s390                  randconfig-2000-20261120    clang-24
s390                  randconfig-2000-20261121    clang-22
s390                  randconfig-2001-20261120    clang-24
s390                  randconfig-2001-20261121    clang-22
s390                  randconfig-2002-20261120    clang-24
s390                  randconfig-2002-20261121    clang-22
s390                  randconfig-2003-20261120    clang-24
s390                  randconfig-2003-20261121    clang-22
s390                  randconfig-2004-20261120    clang-24
s390                  randconfig-2004-20261121    clang-22
s390                  randconfig-2005-20261120    clang-24
s390                  randconfig-2005-20261121    clang-22
s390                  randconfig-2200-20261120    clang-17   smatch
s390                  randconfig-2200-20261121    gcc-8.5.0  smatch
s390                 randconfig-r2100-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2105-20261121    gcc-9.5.0  cocci
s390                 randconfig-r2111-20261121    gcc-16.2.0 cocci
s390                 randconfig-r2307-20261120    clang-24   sparse
s390                 randconfig-r2307-20261121    gcc-8.5.0  sparse
sh                                allmodconfig    gcc-16.2.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261122    gcc-9.5.0
sh                    randconfig-1001-20261122    gcc-9.5.0
sh                    randconfig-2000-20261120    gcc-11.5.0
sh                    randconfig-2000-20261121    gcc-16.2.0
sh                    randconfig-2001-20261120    gcc-11.5.0
sh                    randconfig-2001-20261121    gcc-16.2.0
sh                    randconfig-2002-20261120    gcc-11.5.0
sh                    randconfig-2002-20261121    gcc-16.2.0
sh                    randconfig-2003-20261120    gcc-11.5.0
sh                    randconfig-2003-20261121    gcc-16.2.0
sh                    randconfig-2004-20261120    gcc-11.5.0
sh                    randconfig-2004-20261121    gcc-16.2.0
sh                    randconfig-2005-20261120    gcc-11.5.0
sh                    randconfig-2005-20261121    gcc-16.2.0
sh                    randconfig-2200-20261120    gcc-11.5.0 smatch
sh                    randconfig-2200-20261121    gcc-10.5.0 smatch
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.2.0
sparc                 randconfig-1000-20261122    clang-24
sparc                 randconfig-1001-20261122    clang-24
sparc                 randconfig-2000-20261120    gcc-8.5.0
sparc                 randconfig-2000-20261121    gcc-8.5.0
sparc                 randconfig-2001-20261120    gcc-8.5.0
sparc                 randconfig-2001-20261121    gcc-8.5.0
sparc                 randconfig-2200-20261120    gcc-11.5.0 smatch
sparc                 randconfig-2200-20261121    gcc-8.5.0  smatch
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261122    clang-24
sparc64               randconfig-1001-20261122    clang-24
sparc64               randconfig-2000-20261120    gcc-8.5.0
sparc64               randconfig-2000-20261121    gcc-8.5.0
sparc64               randconfig-2001-20261120    gcc-8.5.0
sparc64               randconfig-2001-20261121    gcc-8.5.0
sparc64               randconfig-2200-20261120    gcc-14.4.0 smatch
sparc64               randconfig-2200-20261121    clang-20   smatch
sparc64              randconfig-r2108-20261121    gcc-16.2.0 cocci
sparc64              randconfig-r2110-20261121    gcc-16.2.0 cocci
sparc64              randconfig-r2111-20261120    gcc-8.5.0  cocci
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.2.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261122    clang-24
um                    randconfig-1001-20261122    clang-24
um                    randconfig-2000-20261120    gcc-8.5.0
um                    randconfig-2000-20261121    gcc-8.5.0
um                    randconfig-2001-20261120    gcc-8.5.0
um                    randconfig-2001-20261121    gcc-8.5.0
um                    randconfig-2200-20261120    clang-24   smatch
um                    randconfig-2200-20261121    gcc-14     smatch
um                   randconfig-r2301-20261120    clang-24   sparse
um                   randconfig-r2302-20261121    clang-24   sparse
um                   randconfig-r2303-20261120    clang-24   sparse
um                            x86_64_defconfig    gcc-14
x86_64                            allmodconfig    clang-22
x86_64                             allnoconfig    clang-24
x86_64                            allyesconfig    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261122    gcc-14
x86_64                randconfig-1001-20261122    gcc-14
x86_64                randconfig-1002-20261122    gcc-14
x86_64                randconfig-1003-20261122    gcc-14
x86_64                randconfig-1004-20261122    gcc-14
x86_64                randconfig-1005-20261122    gcc-14
x86_64                randconfig-1006-20261122    gcc-14
x86_64                randconfig-1007-20261122    gcc-14
x86_64                randconfig-1008-20261122    gcc-14
x86_64                randconfig-1009-20261122    gcc-14
x86_64                randconfig-1010-20261122    gcc-14
x86_64                randconfig-1011-20261122    gcc-14
x86_64                randconfig-1012-20261122    clang-22
x86_64                randconfig-1013-20261122    clang-22
x86_64                randconfig-1014-20261122    clang-22
x86_64                randconfig-1015-20261122    clang-22
x86_64                randconfig-1016-20261122    clang-22
x86_64                randconfig-1017-20261122    clang-22
x86_64                randconfig-2000-20261120    clang-22
x86_64                randconfig-2000-20261121    gcc-14
x86_64                randconfig-2001-20261120    clang-22
x86_64                randconfig-2001-20261121    gcc-14
x86_64                randconfig-2002-20261120    clang-22
x86_64                randconfig-2002-20261121    gcc-14
x86_64                randconfig-2003-20261120    clang-22
x86_64                randconfig-2003-20261121    gcc-14
x86_64                randconfig-2004-20261120    clang-22
x86_64                randconfig-2004-20261121    gcc-14
x86_64                randconfig-2005-20261120    clang-22
x86_64                randconfig-2005-20261121    gcc-14
x86_64                randconfig-2100-20261120    gcc-14     cocci
x86_64                randconfig-2100-20261121    gcc-14     cocci
x86_64                randconfig-2101-20261120    gcc-14     cocci
x86_64                randconfig-2101-20261121    gcc-14     cocci
x86_64                randconfig-2102-20261120    gcc-14     cocci
x86_64                randconfig-2102-20261121    gcc-14     cocci
x86_64                randconfig-2103-20261120    gcc-14     cocci
x86_64                randconfig-2103-20261121    gcc-14     cocci
x86_64                randconfig-2104-20261120    gcc-14     cocci
x86_64                randconfig-2104-20261121    gcc-14     cocci
x86_64                randconfig-2105-20261120    gcc-14     cocci
x86_64                randconfig-2105-20261121    gcc-14     cocci
x86_64                randconfig-2200-20261120    clang-22   smatch
x86_64                randconfig-2200-20261121    gcc-14     smatch
x86_64                randconfig-2300-20261120    clang-22   sparse
x86_64                randconfig-2300-20261121    gcc-14     sparse
x86_64                randconfig-2301-20261120    clang-22   sparse
x86_64                randconfig-2301-20261121    gcc-14     sparse
x86_64                randconfig-2302-20261120    clang-22   sparse
x86_64                randconfig-2302-20261121    gcc-14     sparse
x86_64               randconfig-r2109-20261121    gcc-16.2.0 cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261122    clang-24
xtensa                randconfig-1001-20261122    clang-24
xtensa                randconfig-2000-20261120    gcc-16.2.0
xtensa                randconfig-2000-20261121    gcc-16.2.0
xtensa                randconfig-2001-20261120    gcc-16.2.0
xtensa                randconfig-2001-20261121    gcc-16.2.0
xtensa                randconfig-2200-20261120    gcc-9.5.0  smatch
xtensa                randconfig-2200-20261121    gcc-12.5.0 smatch

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
