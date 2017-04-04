From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [kbuild-all] [PATCH v3 1/3] mfd: intel_soc_pmic: Fix a mess
 with compilation units
Date: Tue, 04 Apr 2017 15:13:52 +0300
Message-ID: <1491308032.708.123.camel@linux.intel.com>
References: <20170317153715.48555-1-andriy.shevchenko@linux.intel.com>
         <201704030357.HdHD43mM%fengguang.wu@intel.com>
         <CAHp75Vdt3ys=tFax5iK5tnANNCLj-b4-VxO78b4ZT0jqdAnsdg@mail.gmail.com>
         <20170403092028.z4xtrwz5wj3go3jd@dell>
         <CAHp75VcGgSF-spv6OZWuAE9ardAW=Q6GjC7T8Eto=7subAuW2g@mail.gmail.com>
         <20170403110631.2fksvvnj22plih7o@wfg-t540p.sh.intel.com>
         <CAHp75VeWmR0W1=V29OFYrAfodKam=M5bdU8bTQUj_NHVTY2gjg@mail.gmail.com>
         <20170403143317.3wfqx2nek2p4dyt3@dell>
         <1491230615.708.110.camel@linux.intel.com>
         <20170404084129.ccvpn7tnzwpgocu6@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20050 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdDDMN6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Apr 2017 08:13:58 -0400
In-Reply-To: <20170404084129.ccvpn7tnzwpgocu6@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Fengguang Wu <lkp@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, kbuild-all@01.org, Zhang Rui <rui.zhang@intel.com>

On Tue, 2017-04-04 at 09:41 +0100, Lee Jones wrote:
> On Mon, 03 Apr 2017, Andy Shevchenko wrote:
> 
> > On Mon, 2017-04-03 at 15:33 +0100, Lee Jones wrote:
> > > On Mon, 03 Apr 2017, Andy Shevchenko wrote:
> > > 
> > > > On Mon, Apr 3, 2017 at 2:06 PM, Fengguang Wu <lkp@intel.com>
> > > > wrote:
> > > > > On Mon, Apr 03, 2017 at 12:26:54PM +0300, Andy Shevchenko
> > > > > wrote:
> > > > > > On Mon, Apr 3, 2017 at 12:20 PM, Lee Jones <lee.jones@linaro
> > > > > > .org
> > > > > > > wrote:
> > > > > > > On Sun, 02 Apr 2017, Andy Shevchenko wrote:
> > > > > > > > On Sun, Apr 2, 2017 at 11:03 PM, kbuild test robot <lkp@
> > > > > > > > inte
> > > > > > > > l.com>
> > > > > > > > wrote:

> > > > > > It looks like I have to submit fix for older bug first.
> > > > > > Likely I can do
> > this without delays and give you a green light to apply via your
> > tree.
> > Unfortunately I will continue on this tomorrow.
> 
> Turns out that this is not an older bug.
> 
> You need to fix your patch.  I believe you lose the depend on
> INTEL_PMC_IPC, which ensures it's only built on x86 systems.
> 
> NB: I discovered this after a 20 second scan, so it might not be the
> correct fix.  Please investigate.

Oh my gosh, I was looking to older version of the patch which does a
select and thus I was quite sure that that triggers an old bug.

Thank you everyone who raised concern.

P.S. Certainly need a vacation...

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
