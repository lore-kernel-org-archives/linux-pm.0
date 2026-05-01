Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DE324B1F;
	Fri,  1 May 2026 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660853; cv=none; b=gACu4ME/H6kxmm+Fc8Q7HAk+IZBBCKwnvNlbDdbMdHoopkbicHmMQnhEoQWY4OFaPGTIC9arfz4LGAyYgPL7hwQXrsKjm1C0eN8BB4ZAObaEGUA0j/DCvekhwW0rEZbCuLniOw9DWSRq6eqk/0eNErtNj3ayeSsSO9LKUP9iJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660853; c=relaxed/simple;
	bh=zvGrBicncWSbwbO4FH/3RpNAwA+5nTSTGhioNyJOWco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSizSU6SV730ZEsgDe9jGaVEcLaosqnHW/2/R2vSPamAidyLwSmkJMPqnJH5CLSzEa/f9m78ncoUjgTyzTNf1qteb++pQwO58bMVMyNrP+SDAqLLDHUid4IuLzq+uB/jBZa/dr1+Z3mFWkQh/q5qNd9MhKU8A+Oc20FoNJiZQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBsH6vPW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBsH6vPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777660852; x=1809196852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zvGrBicncWSbwbO4FH/3RpNAwA+5nTSTGhioNyJOWco=;
  b=RBsH6vPW3PDrgVSBYOUcvPKFsDc0claVqdl0A8SF1e3aynf8Eyr1wUrr
   Y/zIugojZHyUkVI3KE385pnpbustcVM4wkfx/yum6nUq9q6hFQhcFI0b7
   Ci5M2z1TghcQnyUbPyXlUZTw9OD00/YEyGhen+rWf3FXFke/VTLRUfSYq
   acN/zG+11O/Csc5I93oXMX3lj+/yB4vqVMVZhCBiIICqWgXPeP1xeh3lo
   zmhWeSw3nlAUTMTl/qcg1ZWkGKAcZi99mw5eBPh62WSyoLb6rt6Zblrbk
   Aoqo8sjGrJImIprVibXN1w99TPY7FLl+JZJWoasP1gk3Lqj8PwwfomtDN
   Q==;
X-CSE-ConnectionGUID: q1R4MdLVQAOcbsus7kWOBQ==
X-CSE-MsgGUID: XgWDFHZoTweibub6/PwDCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78523600"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="78523600"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 11:40:52 -0700
X-CSE-ConnectionGUID: W+agS+EWSo+XBBU+/6a85A==
X-CSE-MsgGUID: gSZdrQHASuKwMGTZUHsE4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="265297256"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 01 May 2026 11:40:48 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIsn8-000000000mT-15f3;
	Fri, 01 May 2026 18:40:46 +0000
Date: Sat, 2 May 2026 02:40:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yuho Choi <dbgh9129@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH v1] cpufreq: pcc: fix use-after-free and double free in
 _OSC evaluation
Message-ID: <202605020207.kSlb7cj7-lkp@intel.com>
References: <20260415165139.14113-1-dbgh9129@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415165139.14113-1-dbgh9129@gmail.com>

Hi Yuho,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuho-Choi/cpufreq-pcc-fix-use-after-free-and-double-free-in-_OSC-evaluation/20260418-135954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260415165139.14113-1-dbgh9129%40gmail.com
patch subject: [PATCH v1] cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260502/202605020207.kSlb7cj7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260502/202605020207.kSlb7cj7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605020207.kSlb7cj7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cpufreq/pcc-cpufreq.c:26:
>> include/acpi/actypes.h:21:2: error: ACPI_MACHINE_WIDTH not defined
      21 | #error ACPI_MACHINE_WIDTH not defined
         |  ^
   include/acpi/actypes.h:95:9: error: unknown type name 'COMPILER_DEPENDENT_UINT64'
      95 | typedef COMPILER_DEPENDENT_UINT64 u64;
         |         ^
   include/acpi/actypes.h:96:9: error: unknown type name 'COMPILER_DEPENDENT_INT64'
      96 | typedef COMPILER_DEPENDENT_INT64 s64;
         |         ^
   include/acpi/actypes.h:116:5: warning: 'ACPI_MACHINE_WIDTH' is not defined, evaluates to 0 [-Wundef]
     116 | #if ACPI_MACHINE_WIDTH == 64
         |     ^
   include/acpi/actypes.h:157:7: warning: 'ACPI_MACHINE_WIDTH' is not defined, evaluates to 0 [-Wundef]
     157 | #elif ACPI_MACHINE_WIDTH == 32
         |       ^
>> include/acpi/actypes.h:199:2: error: unknown ACPI_MACHINE_WIDTH
     199 | #error unknown ACPI_MACHINE_WIDTH
         |  ^
   include/acpi/actypes.h:230:6: warning: 'ACPI_MUTEX_TYPE' is not defined, evaluates to 0 [-Wundef]
     230 | #if (ACPI_MUTEX_TYPE == ACPI_BINARY_SEMAPHORE)
         |      ^
   include/acpi/actypes.h:230:25: warning: 'ACPI_BINARY_SEMAPHORE' is not defined, evaluates to 0 [-Wundef]
     230 | #if (ACPI_MUTEX_TYPE == ACPI_BINARY_SEMAPHORE)
         |                         ^
   include/acpi/actypes.h:421:9: error: unknown type name 'u32'
     421 | typedef u32 acpi_status;        /* All ACPI Exceptions */
         |         ^
   include/acpi/actypes.h:422:9: error: unknown type name 'u32'
     422 | typedef u32 acpi_name;          /* 4-byte ACPI name */
         |         ^
   include/acpi/actypes.h:644:9: error: unknown type name 'u32'
     644 | typedef u32 acpi_object_type;
         |         ^
   include/acpi/actypes.h:716:9: error: unknown type name 'u32'
     716 | typedef u32 acpi_event_type;
         |         ^
   include/acpi/actypes.h:747:9: error: unknown type name 'u32'
     747 | typedef u32 acpi_event_status;
         |         ^
   include/acpi/actypes.h:917:3: error: unknown type name 'u32'
     917 |                 u32 length;     /* # of bytes in string, excluding trailing null */
         |                 ^
   include/acpi/actypes.h:923:3: error: unknown type name 'u32'
     923 |                 u32 length;     /* # of bytes in buffer */
         |                 ^
   include/acpi/actypes.h:929:3: error: unknown type name 'u32'
     929 |                 u32 count;      /* # of elements in package */
         |                 ^
   include/acpi/actypes.h:941:3: error: unknown type name 'u32'
     941 |                 u32 proc_id;
         |                 ^
   include/acpi/actypes.h:942:3: error: unknown type name 'acpi_io_address'
     942 |                 acpi_io_address pblk_address;
         |                 ^
   include/acpi/actypes.h:943:3: error: unknown type name 'u32'
     943 |                 u32 pblk_length;
         |                 ^
   include/acpi/actypes.h:948:3: error: unknown type name 'u32'
     948 |                 u32 system_level;
         |                 ^
   include/acpi/actypes.h:949:3: error: unknown type name 'u32'
     949 |                 u32 resource_order;
         |                 ^
   include/acpi/actypes.h:957:2: error: unknown type name 'u32'
     957 |         u32 count;
         |         ^
   include/acpi/actypes.h:979:2: error: unknown type name 'acpi_size'
     979 |         acpi_size length;       /* Length in bytes of the buffer */
         |         ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   4 warnings and 20 errors generated.


vim +21 include/acpi/actypes.h

61686124f47d7c Bob Moore      2006-03-17   14  
defba1d8f233c0 Bob Moore      2005-12-16   15  /*
c6915b3f29eb09 Bob Moore      2017-06-05   16   * ACPI_MACHINE_WIDTH must be specified in an OS- or compiler-dependent
c6915b3f29eb09 Bob Moore      2017-06-05   17   * header and must be either 32 or 64. 16-bit ACPICA is no longer
c6915b3f29eb09 Bob Moore      2017-06-05   18   * supported, as of 12/2006.
defba1d8f233c0 Bob Moore      2005-12-16   19   */
defba1d8f233c0 Bob Moore      2005-12-16   20  #ifndef ACPI_MACHINE_WIDTH
defba1d8f233c0 Bob Moore      2005-12-16  @21  #error ACPI_MACHINE_WIDTH not defined
defba1d8f233c0 Bob Moore      2005-12-16   22  #endif
defba1d8f233c0 Bob Moore      2005-12-16   23  
^1da177e4c3f41 Linus Torvalds 2005-04-16   24  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16   25   * Data type ranges
^1da177e4c3f41 Linus Torvalds 2005-04-16   26   * Note: These macros are designed to be compiler independent as well as
^1da177e4c3f41 Linus Torvalds 2005-04-16   27   * working around problems that some 32-bit compilers have with 64-bit
^1da177e4c3f41 Linus Torvalds 2005-04-16   28   * constants.
^1da177e4c3f41 Linus Torvalds 2005-04-16   29   */
e252652fb2664d Lv Zheng       2014-02-11   30  #define ACPI_UINT8_MAX                  (u8) (~((u8)  0))	/* 0xFF               */
e252652fb2664d Lv Zheng       2014-02-11   31  #define ACPI_UINT16_MAX                 (u16)(~((u16) 0))	/* 0xFFFF             */
e252652fb2664d Lv Zheng       2014-02-11   32  #define ACPI_UINT32_MAX                 (u32)(~((u32) 0))	/* 0xFFFFFFFF         */
e252652fb2664d Lv Zheng       2014-02-11   33  #define ACPI_UINT64_MAX                 (u64)(~((u64) 0))	/* 0xFFFFFFFFFFFFFFFF */
^1da177e4c3f41 Linus Torvalds 2005-04-16   34  #define ACPI_ASCII_MAX                  0x7F
^1da177e4c3f41 Linus Torvalds 2005-04-16   35  
^1da177e4c3f41 Linus Torvalds 2005-04-16   36  /*
defba1d8f233c0 Bob Moore      2005-12-16   37   * Architecture-specific ACPICA Subsystem Data Types
defba1d8f233c0 Bob Moore      2005-12-16   38   *
defba1d8f233c0 Bob Moore      2005-12-16   39   * The goal of these types is to provide source code portability across
defba1d8f233c0 Bob Moore      2005-12-16   40   * 16-bit, 32-bit, and 64-bit targets.
defba1d8f233c0 Bob Moore      2005-12-16   41   *
defba1d8f233c0 Bob Moore      2005-12-16   42   * 1) The following types are of fixed size for all targets (16/32/64):
defba1d8f233c0 Bob Moore      2005-12-16   43   *
e252652fb2664d Lv Zheng       2014-02-11   44   * u8           Logical boolean
^1da177e4c3f41 Linus Torvalds 2005-04-16   45   *
e252652fb2664d Lv Zheng       2014-02-11   46   * u8           8-bit  (1 byte) unsigned value
e252652fb2664d Lv Zheng       2014-02-11   47   * u16          16-bit (2 byte) unsigned value
e252652fb2664d Lv Zheng       2014-02-11   48   * u32          32-bit (4 byte) unsigned value
e252652fb2664d Lv Zheng       2014-02-11   49   * u64          64-bit (8 byte) unsigned value
defba1d8f233c0 Bob Moore      2005-12-16   50   *
e252652fb2664d Lv Zheng       2014-02-11   51   * s16          16-bit (2 byte) signed value
e252652fb2664d Lv Zheng       2014-02-11   52   * s32          32-bit (4 byte) signed value
e252652fb2664d Lv Zheng       2014-02-11   53   * s64          64-bit (8 byte) signed value
defba1d8f233c0 Bob Moore      2005-12-16   54   *
e252652fb2664d Lv Zheng       2014-02-11   55   * COMPILER_DEPENDENT_UINT64/s64 - These types are defined in the
c6915b3f29eb09 Bob Moore      2017-06-05   56   * compiler-dependent header(s) and were introduced because there is no
c6915b3f29eb09 Bob Moore      2017-06-05   57   * common 64-bit integer type across the various compilation models, as
c6915b3f29eb09 Bob Moore      2017-06-05   58   * shown in the table below.
defba1d8f233c0 Bob Moore      2005-12-16   59   *
defba1d8f233c0 Bob Moore      2005-12-16   60   * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
defba1d8f233c0 Bob Moore      2005-12-16   61   * char      8    8     8     8     8    8
defba1d8f233c0 Bob Moore      2005-12-16   62   * short     16   16    16    16    16   16
defba1d8f233c0 Bob Moore      2005-12-16   63   * _int32         32
defba1d8f233c0 Bob Moore      2005-12-16   64   * int       32   64    32    32    16   16
defba1d8f233c0 Bob Moore      2005-12-16   65   * long      64   64    32    32    32   32
defba1d8f233c0 Bob Moore      2005-12-16   66   * long long            64    64
defba1d8f233c0 Bob Moore      2005-12-16   67   * pointer   64   64    64    32    32   32
defba1d8f233c0 Bob Moore      2005-12-16   68   *
defba1d8f233c0 Bob Moore      2005-12-16   69   * Note: ILP64 and LP32 are currently not supported.
defba1d8f233c0 Bob Moore      2005-12-16   70   *
defba1d8f233c0 Bob Moore      2005-12-16   71   *
defba1d8f233c0 Bob Moore      2005-12-16   72   * 2) These types represent the native word size of the target mode of the
defba1d8f233c0 Bob Moore      2005-12-16   73   * processor, and may be 16-bit, 32-bit, or 64-bit as required. They are
defba1d8f233c0 Bob Moore      2005-12-16   74   * usually used for memory allocation, efficient loop counters, and array
c6915b3f29eb09 Bob Moore      2017-06-05   75   * indexes. The types are similar to the size_t type in the C library and
c6915b3f29eb09 Bob Moore      2017-06-05   76   * are required because there is no C type that consistently represents the
c6915b3f29eb09 Bob Moore      2017-06-05   77   * native data width. acpi_size is needed because there is no guarantee
c6915b3f29eb09 Bob Moore      2017-06-05   78   * that a kernel-level C library is present.
defba1d8f233c0 Bob Moore      2005-12-16   79   *
e252652fb2664d Lv Zheng       2014-02-11   80   * acpi_size        16/32/64-bit unsigned value
e252652fb2664d Lv Zheng       2014-02-11   81   * acpi_native_int  16/32/64-bit signed value
^1da177e4c3f41 Linus Torvalds 2005-04-16   82   */
^1da177e4c3f41 Linus Torvalds 2005-04-16   83  
defba1d8f233c0 Bob Moore      2005-12-16   84  /*******************************************************************************
defba1d8f233c0 Bob Moore      2005-12-16   85   *
defba1d8f233c0 Bob Moore      2005-12-16   86   * Common types for all compilers, all targets
defba1d8f233c0 Bob Moore      2005-12-16   87   *
defba1d8f233c0 Bob Moore      2005-12-16   88   ******************************************************************************/
0897831bb54eb3 Bob Moore      2005-10-21   89  
e252652fb2664d Lv Zheng       2014-02-11   90  #ifndef ACPI_USE_SYSTEM_INTTYPES
e252652fb2664d Lv Zheng       2014-02-11   91  
e252652fb2664d Lv Zheng       2014-02-11   92  typedef unsigned char u8;
e252652fb2664d Lv Zheng       2014-02-11   93  typedef unsigned short u16;
80a648c12e4bda Lv Zheng       2014-07-08   94  typedef short s16;
e252652fb2664d Lv Zheng       2014-02-11   95  typedef COMPILER_DEPENDENT_UINT64 u64;
e252652fb2664d Lv Zheng       2014-02-11   96  typedef COMPILER_DEPENDENT_INT64 s64;
defba1d8f233c0 Bob Moore      2005-12-16   97  
e252652fb2664d Lv Zheng       2014-02-11   98  #endif				/* ACPI_USE_SYSTEM_INTTYPES */
defba1d8f233c0 Bob Moore      2005-12-16   99  
28eb3fcf8762a3 Lin Ming       2010-09-15  100  /*
28eb3fcf8762a3 Lin Ming       2010-09-15  101   * Value returned by acpi_os_get_thread_id. There is no standard "thread_id"
28eb3fcf8762a3 Lin Ming       2010-09-15  102   * across operating systems or even the various UNIX systems. Since ACPICA
28eb3fcf8762a3 Lin Ming       2010-09-15  103   * only needs the thread ID as a unique thread identifier, we use a u64
28eb3fcf8762a3 Lin Ming       2010-09-15  104   * as the only common data type - it will accommodate any type of pointer or
28eb3fcf8762a3 Lin Ming       2010-09-15  105   * any type of integer. It is up to the host-dependent OSL to cast the
28eb3fcf8762a3 Lin Ming       2010-09-15  106   * native thread ID type to a u64 (in acpi_os_get_thread_id).
28eb3fcf8762a3 Lin Ming       2010-09-15  107   */
28eb3fcf8762a3 Lin Ming       2010-09-15  108  #define acpi_thread_id                  u64
28eb3fcf8762a3 Lin Ming       2010-09-15  109  
defba1d8f233c0 Bob Moore      2005-12-16  110  /*******************************************************************************
defba1d8f233c0 Bob Moore      2005-12-16  111   *
defba1d8f233c0 Bob Moore      2005-12-16  112   * Types specific to 64-bit targets
defba1d8f233c0 Bob Moore      2005-12-16  113   *
defba1d8f233c0 Bob Moore      2005-12-16  114   ******************************************************************************/
^1da177e4c3f41 Linus Torvalds 2005-04-16  115  
^1da177e4c3f41 Linus Torvalds 2005-04-16  116  #if ACPI_MACHINE_WIDTH == 64
^1da177e4c3f41 Linus Torvalds 2005-04-16  117  
e252652fb2664d Lv Zheng       2014-02-11  118  #ifndef ACPI_USE_SYSTEM_INTTYPES
^1da177e4c3f41 Linus Torvalds 2005-04-16  119  
e252652fb2664d Lv Zheng       2014-02-11  120  typedef unsigned int u32;
e252652fb2664d Lv Zheng       2014-02-11  121  typedef int s32;
^1da177e4c3f41 Linus Torvalds 2005-04-16  122  
e252652fb2664d Lv Zheng       2014-02-11  123  #endif				/* ACPI_USE_SYSTEM_INTTYPES */
^1da177e4c3f41 Linus Torvalds 2005-04-16  124  
defba1d8f233c0 Bob Moore      2005-12-16  125  typedef s64 acpi_native_int;
defba1d8f233c0 Bob Moore      2005-12-16  126  
67a119f990063f Bob Moore      2008-06-10  127  typedef u64 acpi_size;
^1da177e4c3f41 Linus Torvalds 2005-04-16  128  typedef u64 acpi_io_address;
^1da177e4c3f41 Linus Torvalds 2005-04-16  129  typedef u64 acpi_physical_address;
^1da177e4c3f41 Linus Torvalds 2005-04-16  130  
^1da177e4c3f41 Linus Torvalds 2005-04-16  131  #define ACPI_MAX_PTR                    ACPI_UINT64_MAX
^1da177e4c3f41 Linus Torvalds 2005-04-16  132  #define ACPI_SIZE_MAX                   ACPI_UINT64_MAX
^1da177e4c3f41 Linus Torvalds 2005-04-16  133  
defba1d8f233c0 Bob Moore      2005-12-16  134  #define ACPI_USE_NATIVE_DIVIDE	/* Has native 64-bit integer support */
65082bfcb486ef Lv Zheng       2017-08-03  135  #define ACPI_USE_NATIVE_MATH64	/* Has native 64-bit integer support */
defba1d8f233c0 Bob Moore      2005-12-16  136  
0897831bb54eb3 Bob Moore      2005-10-21  137  /*
0897831bb54eb3 Bob Moore      2005-10-21  138   * In the case of the Itanium Processor Family (IPF), the hardware does not
c6915b3f29eb09 Bob Moore      2017-06-05  139   * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORTED
c6915b3f29eb09 Bob Moore      2017-06-05  140   * flag to indicate that special precautions must be taken to avoid alignment
c6915b3f29eb09 Bob Moore      2017-06-05  141   * faults. (IA64 or ia64 is currently used by existing compilers to indicate
c6915b3f29eb09 Bob Moore      2017-06-05  142   * IPF.)
0897831bb54eb3 Bob Moore      2005-10-21  143   *
ba494beeaa69bc Bob Moore      2012-07-12  144   * Note: EM64T and other X86-64 processors support misaligned transfers,
0897831bb54eb3 Bob Moore      2005-10-21  145   * so there is no need to define this flag.
0897831bb54eb3 Bob Moore      2005-10-21  146   */
0897831bb54eb3 Bob Moore      2005-10-21  147  #if defined (__IA64__) || defined (__ia64__)
0897831bb54eb3 Bob Moore      2005-10-21  148  #define ACPI_MISALIGNMENT_NOT_SUPPORTED
0897831bb54eb3 Bob Moore      2005-10-21  149  #endif
0897831bb54eb3 Bob Moore      2005-10-21  150  
defba1d8f233c0 Bob Moore      2005-12-16  151  /*******************************************************************************
defba1d8f233c0 Bob Moore      2005-12-16  152   *
defba1d8f233c0 Bob Moore      2005-12-16  153   * Types specific to 32-bit targets
defba1d8f233c0 Bob Moore      2005-12-16  154   *
defba1d8f233c0 Bob Moore      2005-12-16  155   ******************************************************************************/
defba1d8f233c0 Bob Moore      2005-12-16  156  
defba1d8f233c0 Bob Moore      2005-12-16  157  #elif ACPI_MACHINE_WIDTH == 32
defba1d8f233c0 Bob Moore      2005-12-16  158  
e252652fb2664d Lv Zheng       2014-02-11  159  #ifndef ACPI_USE_SYSTEM_INTTYPES
defba1d8f233c0 Bob Moore      2005-12-16  160  
e252652fb2664d Lv Zheng       2014-02-11  161  typedef unsigned int u32;
e252652fb2664d Lv Zheng       2014-02-11  162  typedef int s32;
defba1d8f233c0 Bob Moore      2005-12-16  163  
e252652fb2664d Lv Zheng       2014-02-11  164  #endif				/* ACPI_USE_SYSTEM_INTTYPES */
defba1d8f233c0 Bob Moore      2005-12-16  165  
defba1d8f233c0 Bob Moore      2005-12-16  166  typedef s32 acpi_native_int;
defba1d8f233c0 Bob Moore      2005-12-16  167  
67a119f990063f Bob Moore      2008-06-10  168  typedef u32 acpi_size;
2b8760100e1de6 Lv Zheng       2015-04-13  169  
2b8760100e1de6 Lv Zheng       2015-04-13  170  #ifdef ACPI_32BIT_PHYSICAL_ADDRESS
2b8760100e1de6 Lv Zheng       2015-04-13  171  
2b8760100e1de6 Lv Zheng       2015-04-13  172  /*
2b8760100e1de6 Lv Zheng       2015-04-13  173   * OSPMs can define this to shrink the size of the structures for 32-bit
2b8760100e1de6 Lv Zheng       2015-04-13  174   * none PAE environment. ASL compiler may always define this to generate
2b8760100e1de6 Lv Zheng       2015-04-13  175   * 32-bit OSPM compliant tables.
2b8760100e1de6 Lv Zheng       2015-04-13  176   */
defba1d8f233c0 Bob Moore      2005-12-16  177  typedef u32 acpi_io_address;
f3d2e7865c8162 Bob Moore      2007-02-02  178  typedef u32 acpi_physical_address;
defba1d8f233c0 Bob Moore      2005-12-16  179  
2b8760100e1de6 Lv Zheng       2015-04-13  180  #else				/* ACPI_32BIT_PHYSICAL_ADDRESS */
2b8760100e1de6 Lv Zheng       2015-04-13  181  
2b8760100e1de6 Lv Zheng       2015-04-13  182  /*
2b8760100e1de6 Lv Zheng       2015-04-13  183   * It is reported that, after some calculations, the physical addresses can
2b8760100e1de6 Lv Zheng       2015-04-13  184   * wrap over the 32-bit boundary on 32-bit PAE environment.
2b8760100e1de6 Lv Zheng       2015-04-13  185   * https://bugzilla.kernel.org/show_bug.cgi?id=87971
2b8760100e1de6 Lv Zheng       2015-04-13  186   */
2b8760100e1de6 Lv Zheng       2015-04-13  187  typedef u64 acpi_io_address;
2b8760100e1de6 Lv Zheng       2015-04-13  188  typedef u64 acpi_physical_address;
2b8760100e1de6 Lv Zheng       2015-04-13  189  
2b8760100e1de6 Lv Zheng       2015-04-13  190  #endif				/* ACPI_32BIT_PHYSICAL_ADDRESS */
2b8760100e1de6 Lv Zheng       2015-04-13  191  
defba1d8f233c0 Bob Moore      2005-12-16  192  #define ACPI_MAX_PTR                    ACPI_UINT32_MAX
defba1d8f233c0 Bob Moore      2005-12-16  193  #define ACPI_SIZE_MAX                   ACPI_UINT32_MAX
defba1d8f233c0 Bob Moore      2005-12-16  194  
defba1d8f233c0 Bob Moore      2005-12-16  195  #else
^1da177e4c3f41 Linus Torvalds 2005-04-16  196  
59fa85057e12ff Bob Moore      2007-02-02  197  /* ACPI_MACHINE_WIDTH must be either 64 or 32 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  198  
defba1d8f233c0 Bob Moore      2005-12-16 @199  #error unknown ACPI_MACHINE_WIDTH
defba1d8f233c0 Bob Moore      2005-12-16  200  #endif
^1da177e4c3f41 Linus Torvalds 2005-04-16  201  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
