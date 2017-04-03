From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [kbuild-all] [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess with
 compilation units
Date: Mon, 3 Apr 2017 15:33:17 +0100
Message-ID: <20170403143317.3wfqx2nek2p4dyt3@dell>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
 <201704030357.HdHD43mM%fengguang.wu@intel.com>
 <CAHp75Vdt3ys=tFax5iK5tnANNCLj-b4-VxO78b4ZT0jqdAnsdg@mail.gmail.com>
 <20170403092028.z4xtrwz5wj3go3jd@dell>
 <CAHp75VcGgSF-spv6OZWuAE9ardAW=Q6GjC7T8Eto=7subAuW2g@mail.gmail.com>
 <20170403110631.2fksvvnj22plih7o@wfg-t540p.sh.intel.com>
 <CAHp75VeWmR0W1=V29OFYrAfodKam=M5bdU8bTQUj_NHVTY2gjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeWmR0W1=V29OFYrAfodKam=M5bdU8bTQUj_NHVTY2gjg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Fengguang Wu <lkp@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, kbuild-all@01.org, Zhang Rui <rui.zhang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 03 Apr 2017, Andy Shevchenko wrote:

> On Mon, Apr 3, 2017 at 2:06 PM, Fengguang Wu <lkp@intel.com> wrote:
> > On Mon, Apr 03, 2017 at 12:26:54PM +0300, Andy Shevchenko wrote:
> >> On Mon, Apr 3, 2017 at 12:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >>> On Sun, 02 Apr 2017, Andy Shevchenko wrote:
> >>>> On Sun, Apr 2, 2017 at 11:03 PM, kbuild test robot <lkp@intel.com>
> >>>> wrote:
> >>>> > Hi Andy,
> >>>> >
> >>>> > [auto build test ERROR on ljones-mfd/for-mfd-next]
> >>>> > [also build test ERROR on v4.11-rc4 next-20170331]
> >>>> > [if your patch is applied to the wrong git tree, please drop us a note
> >>>> > to help improve the system]
> >>>>
> >>>> Thank you for report, though...
> 
> >>>> ...I doubt how below is related to my patch. This is obvious x86 code
> >>>> which was initially submitted without
> >>>> depend on X86
> >>>> line in corresponding Kconfig.
> >>>
> >>>
> >>> I think you should probably specify the architecture in the Kconfig
> >>> entry, or else some `randconfig`s will fail.
> >>
> >>
> >> Yes, I understand how to fix this, though it's not a problem of this
> >> patch per se.
> >>
> >> Fengguang, is there any possible way to determine the relation between
> >> an error and a root cause change?
> >
> >
> > Andy, our 0day build error reports are all bisected ones. It means the
> > error happens since the reported patch/commit, which is either
> > responsible for the root cause, or somehow triggers (or changes the
> > exact form of) an old bug.
> 
> Thanks, like you said in this case it looks pretty much for triggering
> an old bug.

Quite.  But as a good open source citizen, you'll follow up with
patches too, right? :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
