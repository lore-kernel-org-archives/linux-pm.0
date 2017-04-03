From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with compilation units
Date: Mon, 3 Apr 2017 12:26:54 +0300
Message-ID: <CAHp75VcGgSF-spv6OZWuAE9ardAW=Q6GjC7T8Eto=7subAuW2g@mail.gmail.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
 <201704030357.HdHD43mM%fengguang.wu@intel.com> <CAHp75Vdt3ys=tFax5iK5tnANNCLj-b4-VxO78b4ZT0jqdAnsdg@mail.gmail.com>
 <20170403092028.z4xtrwz5wj3go3jd@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170403092028.z4xtrwz5wj3go3jd@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kbuild-all@01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 3, 2017 at 12:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Sun, 02 Apr 2017, Andy Shevchenko wrote:
>
>> On Sun, Apr 2, 2017 at 11:03 PM, kbuild test robot <lkp@intel.com> wrote:
>> > Hi Andy,
>> >
>> > [auto build test ERROR on ljones-mfd/for-mfd-next]
>> > [also build test ERROR on v4.11-rc4 next-20170331]
>> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> Thank you for report, though...
>>
>> >
>> > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/mfd-intel_soc_pmic-Fix-a-mess-with-compilation-units/20170320-153539
>> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>> > config: tile-allyesconfig (attached as .config)
>> > compiler: tilegx-linux-gcc (GCC) 4.6.2
>> > reproduce:
>> >         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         # save the attached .config to linux build tree
>>
>> >         make.cross ARCH=tile
>>
>> ...I doubt how below is related to my patch. This is obvious x86 code
>> which was initially submitted without
>> depend on X86
>> line in corresponding Kconfig.
>
> I think you should probably specify the architecture in the Kconfig
> entry, or else some `randconfig`s will fail.

Yes, I understand how to fix this, though it's not a problem of this
patch per se.

Fengguang, is there any possible way to determine the relation between
an error and a root cause change?

-- 
With Best Regards,
Andy Shevchenko
