From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3 v7] battery: Add the battery hooking API
Date: Sat, 23 Dec 2017 15:36:47 +0800
Message-ID: <201712231549.Qs1NnfLn%fengguang.wu@intel.com>
References: <20171220151536.GA12278@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220151536.GA12278@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
Cc: kbuild-all@01.org, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ognjen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on platform-drivers-x86/for-next]
[also build test WARNING on v4.15-rc4 next-20171222]
[cannot apply to pm/linux-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ognjen-Galic/battery-Add-the-battery-hooking-API/20171223-144855
base:   git://git.infradead.org/users/dvhart/linux-platform-drivers-x86.git for-next
config: i386-randconfig-x007-201751 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:10:0,
                    from drivers//acpi/battery.c:24:
   drivers//acpi/battery.c: In function 'acpi_battery_exit':
   include/linux/compiler.h:58:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
     ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
>> drivers//acpi/battery.c:1532:2: note: in expansion of macro 'if'
     if (battery_driver_registered)
     ^~
   drivers//acpi/battery.c:1534:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      battery_hook_exit();
      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:10:0,
                    from drivers//acpi/battery.c:24:
   drivers//acpi/battery.c: At top level:
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:422:2: note: in expansion of macro 'if'
     if (p_size == (size_t)-1 && q_size == (size_t)-1)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:412:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:410:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:401:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:399:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:390:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:388:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:380:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:377:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:375:3: note: in expansion of macro 'if'
      if (p_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \

vim +/if +1532 drivers//acpi/battery.c

^1da177e Linus Torvalds 2005-04-16  1528  
4be44fcd Len Brown      2005-08-05  1529  static void __exit acpi_battery_exit(void)
^1da177e Linus Torvalds 2005-04-16  1530  {
5dfa0c73 Chris Wilson   2016-05-19  1531  	async_synchronize_cookie(async_cookie + 1);
bc39fbcf Hans de Goede  2017-04-19 @1532  	if (battery_driver_registered)
^1da177e Linus Torvalds 2005-04-16  1533  		acpi_bus_unregister_driver(&acpi_battery_driver);
19380b8e Ognjen Galic   2017-12-20  1534  		battery_hook_exit();
3a670cc7 Lan Tianyu     2014-05-04  1535  #ifdef CONFIG_ACPI_PROCFS_POWER
bc39fbcf Hans de Goede  2017-04-19  1536  	if (acpi_battery_dir)
3a670cc7 Lan Tianyu     2014-05-04  1537  		acpi_unlock_battery_dir(acpi_battery_dir);
3a670cc7 Lan Tianyu     2014-05-04  1538  #endif
^1da177e Linus Torvalds 2005-04-16  1539  }
^1da177e Linus Torvalds 2005-04-16  1540  

:::::: The code at line 1532 was first introduced by commit
:::::: bc39fbcf9c782970263bdc5b428e4a755db16efb ACPI / battery: Fix acpi_battery_exit on acpi_battery_init_async errors

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
xwENHbkBAA==

--fUYQa+Pmc3FrFX/N--
