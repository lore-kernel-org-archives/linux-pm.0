Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453635AC05;
	Wed, 16 Sep 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561234; cv=none; b=aNgC+AExmSAosuaz/boRDbQ/UxMznrUBxqCspRX2EiCey9EfLR89D6S9ygX3YRZX5ivtbKGI5ZrJowNCuHTTWbYFpZ/l6XAqgGRVSZr0ZeDh623AMESAVmYCgy+PLBfa6yyZGOCLMc9SQexxHWXgYisF4LENGvFgkjk/Gy3uMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561234; c=relaxed/simple;
	bh=0OgQU2jHRRT1xL5IV57LG2VHT69lgAMQSJtJadVUyKY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ueVugugD4wqJ94WPW/iQqIJwC+JVLq657N1tuQepDmOtbCq5UKr59pDRyfcXOQvvyRFklUya9p5v6EoSDc8Yo4GNvRkqIRozhH1sWF49n/h6m9Zl9uw5H5Lx9kTGoe8a+kx7UqvOknozj4AlmRgzpcvgk9MIVxZwTiE/Y8apiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=du7UTTsj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="du7UTTsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789561232; x=1821097232;
  h=date:from:to:cc:subject:message-id;
  bh=0OgQU2jHRRT1xL5IV57LG2VHT69lgAMQSJtJadVUyKY=;
  b=du7UTTsj/vJ5IQv+OMz/hURyj7Pj6oyXlipqAr9Vw0Dx7949CBkNTJnw
   L5e4jivy99OEH7/VYGUASpbqrm8pScOMzkic3Jg/uDbUKDrT7dq1EzArf
   06bc2vigPg0eBUzO8sEN6sm0F6EtBWImxipvns0+7xzqMO0QGIVfQ+VCO
   AW4THS3IjfL9Wfq1cgBkkoz5to/1DcNTNUtFOtbgxB6Gq7lRthLIN81l8
   YaYeq/13UAGVlCsDmV4en32W0gSbCpcXHqEjq1/VyQcZIz/jReZZYawLT
   LerRAVG9jMzcOUySav1cj2KSprxHgD6jXya3Op+R0XGrSJUAutTe00dJj
   A==;
X-CSE-ConnectionGUID: 1o9bSnP0SLOKJWusFr+JcA==
X-CSE-MsgGUID: Pvcs1x6IRRmCaP+BlzNUwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93761822"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93761822"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 05:20:31 -0700
X-CSE-ConnectionGUID: PwfSNSeASGW9bwrvB9xYJw==
X-CSE-MsgGUID: IhNZVQczQhicLYGDrzmhWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277451403"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Sep 2026 05:20:29 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6ocl-0000000063l-2oYP;
	Wed, 16 Sep 2026 12:20:27 +0000
Date: Wed, 16 Sep 2026 20:20:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 c4effca721d9748be701b3c3b8a666b380b2a4e5
Message-ID: <202609162001.DINb6CUz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c4effca721d9748be701b3c3b8a666b380b2a4e5  Merge branch 'acpi-pri-dev' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202609150550.ZyqBeGWm-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202609160705.vk4ADT7O-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202609160802.42lSCDhD-lkp@intel.com

    drivers/thunderbolt/acpi.c:31:6: warning: variable 'dev' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    sound/soc/loongson/loongson_card.c:206:17: error: incompatible integer to pointer conversion initializing 'struct device *' with an expression of type 'int' [-Wint-conversion]
    sound/soc/loongson/loongson_card.c:206:46: error: call to undeclared function 'acpi_bus_get_primary_device'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    sound/soc/loongson/loongson_card.c:206:46: error: implicit declaration of function 'acpi_bus_get_primary_device'; did you mean 'acpi_get_gpe_device'? [-Werror=implicit-function-declaration]
    sound/soc/loongson/loongson_card.c:206:46: warning: initialization of 'struct device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    sound/soc/loongson/loongson_card.c:206:53: error: implicit declaration of function 'acpi_bus_get_primary_device' [-Werror=implicit-function-declaration]
    sound/soc/loongson/loongson_card.c:206:53: error: implicit declaration of function 'acpi_bus_get_primary_device' [-Wimplicit-function-declaration]
    sound/soc/loongson/loongson_card.c:206:53: error: initialization of 'struct device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    sound/soc/loongson/loongson_card.c:206:53: warning: initialization of 'struct device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- arc-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- arc-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- arc-randconfig-001-20260916
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:warning:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- arm-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- csky-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- i386-randconfig-051-20260915
|   `-- drivers-thunderbolt-acpi.c:warning:variable-dev-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-053-20260915
|   `-- drivers-thunderbolt-acpi.c:warning:variable-dev-is-used-uninitialized-whenever-if-condition-is-true
|-- i386-randconfig-r051-20260915
|   `-- drivers-thunderbolt-acpi.c:warning:variable-dev-is-used-uninitialized-whenever-if-condition-is-true
|-- m68k-allmodconfig
|   `-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|-- m68k-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- microblaze-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- nios2-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:warning:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- openrisc-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- parisc-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- parisc-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- parisc-randconfig-r122-20260916
|   `-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|-- powerpc-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- powerpc64-randconfig-002-20260916
|   |-- sound-soc-loongson-loongson_card.c:error:call-to-undeclared-function-acpi_bus_get_primary_device-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- sound-soc-loongson-loongson_card.c:error:incompatible-integer-to-pointer-conversion-initializing-struct-device-with-an-expression-of-type-int
|-- powerpc64-randconfig-r112-20260916
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:warning:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- s390-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:call-to-undeclared-function-acpi_bus_get_primary_device-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- sound-soc-loongson-loongson_card.c:error:incompatible-integer-to-pointer-conversion-initializing-struct-device-with-an-expression-of-type-int
|-- s390-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- sh-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- sh-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- sparc64-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:call-to-undeclared-function-acpi_bus_get_primary_device-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- sound-soc-loongson-loongson_card.c:error:incompatible-integer-to-pointer-conversion-initializing-struct-device-with-an-expression-of-type-int
|-- um-allmodconfig
|   |-- sound-soc-loongson-loongson_card.c:error:call-to-undeclared-function-acpi_bus_get_primary_device-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- sound-soc-loongson-loongson_card.c:error:incompatible-integer-to-pointer-conversion-initializing-struct-device-with-an-expression-of-type-int
|-- um-allyesconfig
|   |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
|   `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast
|-- x86_64-rhel-9.4-rust
|   `-- drivers-thunderbolt-acpi.c:warning:variable-dev-is-used-uninitialized-whenever-if-condition-is-true
`-- xtensa-allyesconfig
    |-- sound-soc-loongson-loongson_card.c:error:implicit-declaration-of-function-acpi_bus_get_primary_device
    `-- sound-soc-loongson-loongson_card.c:error:initialization-of-struct-device-from-int-makes-pointer-from-integer-without-a-cast

elapsed time: 2485m

configs tested: 252
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
alpha                randconfig-r073-20260915    gcc-14.3.0
arc                              allmodconfig    clang-24
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-24
arc                                 defconfig    gcc-16.1.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20260916    clang-24
arc                   randconfig-002-20260916    clang-24
arc                  randconfig-r071-20260915    gcc-14.3.0
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-24
arm                                 defconfig    gcc-16.1.0
arm                           h3600_defconfig    gcc-16.1.0
arm                   randconfig-001-20260916    clang-24
arm                   randconfig-002-20260916    clang-24
arm                   randconfig-003-20260916    clang-24
arm                   randconfig-004-20260916    clang-24
arm                  randconfig-r051-20260915    clang-19
arm                  randconfig-r052-20260915    gcc-9.5.0
arm                  randconfig-r062-20260915    clang-24
arm                  randconfig-r133-20260916    gcc-16.1.0 sparse
arm                           tegra_defconfig    clang-20
arm64                            allmodconfig    clang-24
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260916    gcc-16.1.0
arm64                 randconfig-002-20260916    gcc-16.1.0
arm64                 randconfig-003-20260916    gcc-16.1.0
arm64                 randconfig-004-20260916    gcc-16.1.0
arm64                randconfig-r062-20260915    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260916    gcc-16.1.0
csky                  randconfig-002-20260916    gcc-16.1.0
csky                 randconfig-r054-20260915    gcc-15.2.0
csky                 randconfig-r111-20260916    clang-24 sparse
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260916    gcc-16.1.0
hexagon               randconfig-002-20260916    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260916    clang-22
i386        buildonly-randconfig-002-20260916    clang-22
i386        buildonly-randconfig-003-20260916    clang-22
i386        buildonly-randconfig-004-20260916    clang-22
i386        buildonly-randconfig-005-20260916    clang-22
i386        buildonly-randconfig-006-20260916    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260916    gcc-14
i386                  randconfig-002-20260916    gcc-14
i386                  randconfig-003-20260916    gcc-14
i386                  randconfig-004-20260916    gcc-14
i386                  randconfig-005-20260916    gcc-14
i386                  randconfig-006-20260916    gcc-14
i386                  randconfig-007-20260916    gcc-14
i386                  randconfig-011-20260916    clang-22
i386                  randconfig-012-20260916    clang-22
i386                  randconfig-013-20260916    clang-22
i386                  randconfig-014-20260916    clang-22
i386                  randconfig-015-20260916    clang-22
i386                  randconfig-016-20260916    clang-22
i386                  randconfig-017-20260916    clang-22
i386                  randconfig-051-20260915    clang-22
i386                  randconfig-052-20260915    clang-22
i386                  randconfig-053-20260915    clang-22
i386                  randconfig-054-20260915    clang-22
i386                  randconfig-141-20260915    clang-22
i386                 randconfig-r051-20260915    gcc-9.5.0
i386                 randconfig-r131-20260916    gcc-16.1.0 sparse
loongarch                        allmodconfig    clang-24
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260916    gcc-16.1.0
loongarch             randconfig-002-20260916    gcc-16.1.0
loongarch            randconfig-r052-20260915    gcc-15.2.0
loongarch            randconfig-r053-20260915    clang-19
loongarch            randconfig-r062-20260915    gcc-13
loongarch            randconfig-r111-20260916    gcc-12.5.0 sparse
loongarch            randconfig-r121-20260916    gcc-12.5.0 sparse
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-24
m68k                                defconfig    clang-24
m68k                       m5329evb_defconfig    clang-20
m68k                 randconfig-r061-20260915    clang-24
m68k                 randconfig-r064-20260915    gcc-13
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-24
microblaze           randconfig-r053-20260915    gcc-9.5.0
microblaze           randconfig-r073-20260915    gcc-8.5.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                           ip22_defconfig    gcc-16.1.0
mips                 randconfig-r054-20260915    gcc-9.5.0
mips                 randconfig-r064-20260915    gcc-8.5.0
mips                 randconfig-r113-20260916    clang-24 sparse
mips                 randconfig-r123-20260916    gcc-12.5.0 sparse
mips                           rs90_defconfig    gcc-16.1.0
mips                        vocore2_defconfig    clang-20
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-24
nios2                               defconfig    clang-24
nios2                 randconfig-001-20260916    gcc-16.1.0
nios2                 randconfig-002-20260916    gcc-16.1.0
nios2                randconfig-r063-20260915    gcc-13
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-24
openrisc                            defconfig    gcc-16.1.0
openrisc             randconfig-r071-20260915    gcc-14.3.0
openrisc             randconfig-r134-20260916    gcc-16.1.0 sparse
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-24
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260916    clang-24
parisc                randconfig-002-20260916    clang-24
parisc               randconfig-r052-20260915    clang-19
parisc               randconfig-r122-20260916    gcc-12.5.0 sparse
parisc               randconfig-r132-20260916    gcc-11.5.0 sparse
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    clang-24
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-24
powerpc                        cell_defconfig    gcc-16.1.0
powerpc                   currituck_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-16.1.0
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20260916    clang-24
powerpc               randconfig-002-20260916    clang-24
powerpc              randconfig-r053-20260915    gcc-15.2.0
powerpc              randconfig-r063-20260915    clang-24
powerpc              randconfig-r064-20260915    clang-24
powerpc              randconfig-r071-20260915    clang-24
powerpc              randconfig-r072-20260915    gcc-9.5.0
powerpc              randconfig-r113-20260916    gcc-12.5.0 sparse
powerpc              randconfig-r122-20260916    clang-24 sparse
powerpc                         wii_defconfig    gcc-16.1.0
powerpc64             randconfig-001-20260916    clang-24
powerpc64             randconfig-002-20260916    clang-24
powerpc64            randconfig-r054-20260915    clang-19
powerpc64            randconfig-r071-20260915    gcc-10.5.0
powerpc64            randconfig-r112-20260916    gcc-12.5.0 sparse
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    clang-24
riscv                            allyesconfig    clang-24
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260916    gcc-16.1.0
riscv                 randconfig-002-20260916    gcc-16.1.0
riscv                randconfig-r053-20260915    clang-24
riscv                randconfig-r072-20260915    clang-19
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-24
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260916    gcc-16.1.0
s390                  randconfig-002-20260916    gcc-16.1.0
s390                 randconfig-r051-20260915    gcc-15.2.0
s390                 randconfig-r064-20260915    gcc-13
s390                 randconfig-r072-20260915    gcc-9.5.0
s390                 randconfig-r073-20260915    clang-19
s390                 randconfig-r133-20260916    gcc-11.5.0 sparse
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-24
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-16.1.0
sh                    randconfig-001-20260916    gcc-16.1.0
sh                    randconfig-002-20260916    gcc-16.1.0
sh                   randconfig-r054-20260915    clang-24
sh                   randconfig-r123-20260916    clang-24 sparse
sh                          sdk7786_defconfig    clang-20
sh                           se7751_defconfig    gcc-16.1.0
sparc                             allnoconfig    clang-24
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260916    gcc-14.3.0
sparc                 randconfig-002-20260916    gcc-14.3.0
sparc                randconfig-r063-20260915    gcc-13
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260916    gcc-14.3.0
sparc64               randconfig-002-20260916    gcc-14.3.0
sparc64              randconfig-r112-20260916    clang-24 sparse
sparc64              randconfig-r134-20260916    gcc-11.5.0 sparse
um                               allmodconfig    clang-17
um                                allnoconfig    clang-24
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260916    gcc-14.3.0
um                    randconfig-002-20260916    gcc-14.3.0
um                   randconfig-r052-20260915    clang-24
um                   randconfig-r072-20260915    clang-17
um                   randconfig-r121-20260916    clang-24 sparse
um                   randconfig-r132-20260916    gcc-16.1.0 sparse
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-24
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260916    clang-22
x86_64                randconfig-002-20260916    clang-22
x86_64                randconfig-003-20260916    clang-22
x86_64                randconfig-004-20260916    clang-22
x86_64                randconfig-005-20260916    clang-22
x86_64                randconfig-006-20260916    clang-22
x86_64                randconfig-011-20260916    gcc-14
x86_64                randconfig-012-20260916    gcc-14
x86_64                randconfig-013-20260916    gcc-14
x86_64                randconfig-014-20260916    gcc-14
x86_64                randconfig-015-20260916    gcc-14
x86_64                randconfig-016-20260916    gcc-14
x86_64                randconfig-071-20260916    gcc-14
x86_64                randconfig-072-20260916    gcc-14
x86_64                randconfig-073-20260916    gcc-14
x86_64                randconfig-074-20260916    gcc-14
x86_64                randconfig-075-20260916    gcc-14
x86_64                randconfig-076-20260916    gcc-14
x86_64                randconfig-101-20260915    clang-22
x86_64                randconfig-102-20260915    clang-22
x86_64                randconfig-103-20260915    clang-22
x86_64                randconfig-104-20260915    clang-22
x86_64                randconfig-161-20260915    clang-22
x86_64               randconfig-r061-20260915    gcc-13
x86_64               randconfig-r063-20260915    gcc-8.5.0
x86_64               randconfig-r073-20260915    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    clang-22
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-24
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260916    gcc-14.3.0
xtensa                randconfig-002-20260916    gcc-14.3.0
xtensa               randconfig-r051-20260915    clang-24
xtensa               randconfig-r061-20260915    gcc-8.5.0
xtensa               randconfig-r062-20260915    gcc-13
xtensa               randconfig-r131-20260916    gcc-11.5.0 sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
