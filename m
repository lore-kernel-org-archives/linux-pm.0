From: kbuild test robot <fengguang.wu@intel.com>
Subject: [acpi:release 27/30] arch/x86/include/asm/disabled-features.h:38:25:
 warning: left shift count >= width of type
Date: Fri, 1 Apr 2016 13:04:36 +0800
Message-ID: <201604011334.GJbV1100%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release
head:   1346f469e231ea4eb4ddc130f3e34a5a127a445e
commit: 9c30af26b775133f5795280ab23eefdca0663f8f [27/30] x86: Add core HWP feature enabling support
config: x86_64-randconfig-i0-201613 (attached as .config)
reproduce:
        git checkout 9c30af26b775133f5795280ab23eefdca0663f8f
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/linkage.h:4:0,
                    from include/linux/kernel.h:6,
                    from arch/x86/kernel/cpu/intel.c:1:
   arch/x86/kernel/cpu/intel.c: In function 'intel_hwp_disable':
>> arch/x86/include/asm/disabled-features.h:38:25: warning: left shift count >= width of type [-Wshift-count-overflow]
    # define DISABLE_PKU  (1<<(X86_FEATURE_PKU))
                            ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> arch/x86/kernel/cpu/intel.c:421:2: note: in expansion of macro 'if'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
     ^
>> arch/x86/include/asm/disabled-features.h:64:26: note: in expansion of macro 'DISABLE_PKU'
    #define DISABLED_MASK16 (DISABLE_PKU|DISABLE_OSPKE)
                             ^
>> arch/x86/include/asm/cpufeature.h:87:43: note: in expansion of macro 'DISABLED_MASK16'
        (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
                                              ^
>> arch/x86/include/asm/cpufeature.h:106:32: note: in expansion of macro 'DISABLED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                   ^
>> arch/x86/kernel/cpu/intel.c:421:7: note: in expansion of macro 'cpu_feature_enabled'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
          ^
   arch/x86/include/asm/disabled-features.h:39:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    # define DISABLE_OSPKE  (1<<(X86_FEATURE_OSPKE))
                              ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> arch/x86/kernel/cpu/intel.c:421:2: note: in expansion of macro 'if'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
     ^
>> arch/x86/include/asm/disabled-features.h:64:38: note: in expansion of macro 'DISABLE_OSPKE'
    #define DISABLED_MASK16 (DISABLE_PKU|DISABLE_OSPKE)
                                         ^
>> arch/x86/include/asm/cpufeature.h:87:43: note: in expansion of macro 'DISABLED_MASK16'
        (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
                                              ^
>> arch/x86/include/asm/cpufeature.h:106:32: note: in expansion of macro 'DISABLED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                   ^
>> arch/x86/kernel/cpu/intel.c:421:7: note: in expansion of macro 'cpu_feature_enabled'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
          ^
>> arch/x86/include/asm/disabled-features.h:38:25: warning: left shift count >= width of type [-Wshift-count-overflow]
    # define DISABLE_PKU  (1<<(X86_FEATURE_PKU))
                            ^
   include/linux/compiler.h:151:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^
>> arch/x86/kernel/cpu/intel.c:421:2: note: in expansion of macro 'if'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
     ^
>> arch/x86/include/asm/disabled-features.h:64:26: note: in expansion of macro 'DISABLE_PKU'
    #define DISABLED_MASK16 (DISABLE_PKU|DISABLE_OSPKE)
                             ^
>> arch/x86/include/asm/cpufeature.h:87:43: note: in expansion of macro 'DISABLED_MASK16'
        (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
                                              ^
>> arch/x86/include/asm/cpufeature.h:106:32: note: in expansion of macro 'DISABLED_MASK_BIT_SET'
     (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
                                   ^
>> arch/x86/kernel/cpu/intel.c:421:7: note: in expansion of macro 'cpu_feature_enabled'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
          ^
   arch/x86/include/asm/disabled-features.h:39:27: warning: left shift count >= width of type [-Wshift-count-overflow]
    # define DISABLE_OSPKE  (1<<(X86_FEATURE_OSPKE))
                              ^
   include/linux/compiler.h:151:42: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                             ^
>> arch/x86/kernel/cpu/intel.c:421:2: note: in expansion of macro 'if'
     if (!cpu_feature_enabled(X86_FEATURE_HWP))
     ^
>> arch/x86/include/asm/disabled-features.h:64:38: note: in expansion of macro 'DISABLE_OSPKE'
    #define DISABLED_MASK16 (DISABLE_PKU|DISABLE_OSPKE)
                                         ^
>> arch/x86/include/asm/cpufeature.h:87:43: note: in expansion of macro 'DISABLED_MASK16'
        (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
                                              ^

vim +38 arch/x86/include/asm/disabled-features.h

9298b815 Dave Hansen 2014-09-11  32  # define DISABLE_K6_MTRR	0
9298b815 Dave Hansen 2014-09-11  33  # define DISABLE_CYRIX_ARR	0
9298b815 Dave Hansen 2014-09-11  34  # define DISABLE_CENTAUR_MCR	0
9298b815 Dave Hansen 2014-09-11  35  #endif /* CONFIG_X86_64 */
9298b815 Dave Hansen 2014-09-11  36  
dfb4a70f Dave Hansen 2016-02-12  37  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
dfb4a70f Dave Hansen 2016-02-12 @38  # define DISABLE_PKU		(1<<(X86_FEATURE_PKU))
dfb4a70f Dave Hansen 2016-02-12 @39  # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE))
dfb4a70f Dave Hansen 2016-02-12  40  #else
dfb4a70f Dave Hansen 2016-02-12  41  # define DISABLE_PKU		0
dfb4a70f Dave Hansen 2016-02-12  42  # define DISABLE_OSPKE		0
dfb4a70f Dave Hansen 2016-02-12  43  #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
dfb4a70f Dave Hansen 2016-02-12  44  
381aa07a Dave Hansen 2014-09-11  45  /*
381aa07a Dave Hansen 2014-09-11  46   * Make sure to add features to the correct mask
381aa07a Dave Hansen 2014-09-11  47   */
9298b815 Dave Hansen 2014-09-11  48  #define DISABLED_MASK0	(DISABLE_VME)
381aa07a Dave Hansen 2014-09-11  49  #define DISABLED_MASK1	0
381aa07a Dave Hansen 2014-09-11  50  #define DISABLED_MASK2	0
9298b815 Dave Hansen 2014-09-11  51  #define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
381aa07a Dave Hansen 2014-09-11  52  #define DISABLED_MASK4	0
381aa07a Dave Hansen 2014-09-11  53  #define DISABLED_MASK5	0
381aa07a Dave Hansen 2014-09-11  54  #define DISABLED_MASK6	0
9c30af26 Len Brown   2015-11-05  55  #define DISABLED_MASK7	(DISABLE_HWP)
381aa07a Dave Hansen 2014-09-11  56  #define DISABLED_MASK8	0
95290cf1 Dave Hansen 2014-11-14  57  #define DISABLED_MASK9	(DISABLE_MPX)
dfb4a70f Dave Hansen 2016-02-12  58  #define DISABLED_MASK10	0
dfb4a70f Dave Hansen 2016-02-12  59  #define DISABLED_MASK11	0
dfb4a70f Dave Hansen 2016-02-12  60  #define DISABLED_MASK12	0
dfb4a70f Dave Hansen 2016-02-12  61  #define DISABLED_MASK13	0
dfb4a70f Dave Hansen 2016-02-12  62  #define DISABLED_MASK14	0
dfb4a70f Dave Hansen 2016-02-12  63  #define DISABLED_MASK15	0
dfb4a70f Dave Hansen 2016-02-12 @64  #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE)
381aa07a Dave Hansen 2014-09-11  65  
381aa07a Dave Hansen 2014-09-11  66  #endif /* _ASM_X86_DISABLED_FEATURES_H */

:::::: The code at line 38 was first introduced by commit
:::::: dfb4a70f20c5b3880da56ee4c9484bdb4e8f1e65 x86/cpufeature, x86/mm/pkeys: Add protection keys related CPUID definitions

:::::: TO: Dave Hansen <dave.hansen@linux.intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BOKacYhQ+x31HxR3
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6K4OkP8A/SEoJQNDAQA=

--BOKacYhQ+x31HxR3--
