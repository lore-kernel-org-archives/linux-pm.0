From: Fengguang Wu <lkp@intel.com>
Subject: Re: [kbuild-all] [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with
 compilation units
Date: Mon, 3 Apr 2017 19:06:31 +0800
Message-ID: <20170403110631.2fksvvnj22plih7o@wfg-t540p.sh.intel.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
 <201704030357.HdHD43mM%fengguang.wu@intel.com>
 <CAHp75Vdt3ys=tFax5iK5tnANNCLj-b4-VxO78b4ZT0jqdAnsdg@mail.gmail.com>
 <20170403092028.z4xtrwz5wj3go3jd@dell>
 <CAHp75VcGgSF-spv6OZWuAE9ardAW=Q6GjC7T8Eto=7subAuW2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcGgSF-spv6OZWuAE9ardAW=Q6GjC7T8Eto=7subAuW2g@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, kbuild-all@01.org, Zhang Rui <rui.zhang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 03, 2017 at 12:26:54PM +0300, Andy Shevchenko wrote:
>On Mon, Apr 3, 2017 at 12:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Sun, 02 Apr 2017, Andy Shevchenko wrote:
>>
>>> On Sun, Apr 2, 2017 at 11:03 PM, kbuild test robot <lkp@intel.com> wrote:
>>> > Hi Andy,
>>> >
>>> > [auto build test ERROR on ljones-mfd/for-mfd-next]
>>> > [also build test ERROR on v4.11-rc4 next-20170331]
>>> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> Thank you for report, though...
>>>
>>> >
>>> > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/mfd-intel_soc_pmic-Fix-a-mess-with-compilation-units/20170320-153539
>>> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>>> > config: tile-allyesconfig (attached as .config)
>>> > compiler: tilegx-linux-gcc (GCC) 4.6.2
>>> > reproduce:
>>> >         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>> >         chmod +x ~/bin/make.cross
>>> >         # save the attached .config to linux build tree
>>>
>>> >         make.cross ARCH=tile
>>>
>>> ...I doubt how below is related to my patch. This is obvious x86 code
>>> which was initially submitted without
>>> depend on X86
>>> line in corresponding Kconfig.
>>
>> I think you should probably specify the architecture in the Kconfig
>> entry, or else some `randconfig`s will fail.
>
>Yes, I understand how to fix this, though it's not a problem of this
>patch per se.
>
>Fengguang, is there any possible way to determine the relation between
>an error and a root cause change?

Andy, our 0day build error reports are all bisected ones. It means the
error happens since the reported patch/commit, which is either
responsible for the root cause, or somehow triggers (or changes the
exact form of) an old bug.

I just manual confirmed the bisect is correct:

=============== commit 162c61d1a ===============
/home/wfg/linux
HEAD is now at 162c61d... mfd: intel_soc_pmic: Fix a mess with compilation units
/home/wfg/linux/obj-compiletest

make ARCH=tile allyesconfig
make ARCH=tile drivers/mfd/

!!! BUILD ERROR !!!
make ARCH=tile M=drivers/mfd/

!!! BUILD ERROR !!!
grep -a -F drivers/mfd/ /tmp/build-err-162c61d1a76aa5ccfb398225b3f6f2e896fb58b0-wfg --color
../drivers/mfd/intel_soc_pmic_bxtwc.c:24:31: fatal error: asm/intel_pmc_ipc.h: No such file or directory
compilation terminated.
make[2]: *** [drivers/mfd/intel_soc_pmic_bxtwc.o] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [drivers/mfd/] Error 2
make: *** [sub-make] Error 2
make[2]: *** No rule to make target 'drivers/mfd//intel_soc_pmic_bxtwc.o', needed by 'drivers/mfd//built-in.o'.
make[2]: Target '__build' not remade because of errors.
make[1]: *** [_module_drivers/mfd/] Error 2
make[1]: Target '_all' not remade because of errors.
make: *** [sub-make] Error 2

=============== PREV commit e93c10211d03c35271896b03a40d3eca4a674770 ===============
/home/wfg/linux
Previous HEAD position was 162c61d... mfd: intel_soc_pmic: Fix a mess with compilation units
HEAD is now at e93c102... mfd: lpc_ich: Enable watchdog on Intel Apollo Lake PCH
/home/wfg/linux/obj-compiletest

make ARCH=tile allyesconfig
make ARCH=tile drivers/mfd/

make ARCH=tile M=drivers/mfd/

grep -a -F drivers/mfd/ /tmp/build-err-e93c10211d03c35271896b03a40d3eca4a674770-wfg --color

Thanks,
Fengguang
