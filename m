From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/3] PM: i2c-designware-platdrv: Clean up PM handling in probe
Date: Mon, 25 Sep 2017 22:45:31 +0200
Message-ID: <3491198.ZaBooUSjR1@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <2813826.3DA0fVXnVa@aspire.rjw.lan> <CAPDyKFo_E79POLCuV_0Dd3tDL_Ko-WY_oZ4zLyf=y3GLf52ajg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54000 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934254AbdIYUyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2017 16:54:43 -0400
In-Reply-To: <CAPDyKFo_E79POLCuV_0Dd3tDL_Ko-WY_oZ4zLyf=y3GLf52ajg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Lee Jones <lee.jones@linaro.org>, Rajat Jain <rajatja@google.com>

On Monday, September 25, 2017 9:12:28 PM CEST Ulf Hansson wrote:
> On 25 September 2017 at 01:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The power management handling in dw_i2c_plat_probe() is somewhat
> > messy and it is rather hard to figure out the code intention for
> > the case when pm_disabled is set.  In that case, the driver doesn't
> > enable runtime PM at all, but in addition to that it calls
> > pm_runtime_forbid() as though it wasn't sure if runtime PM might
> > be enabled for the device later by someone else.
> >
> > Although that concern doesn't seem to be actually valid, the
> > device is clearly still expected to be PM-capable even in the
> > pm_disabled set case, so a better approach would be to enable
> > runtime PM for it unconditionally and then prevent it from
> > being runtime-suspended by using pm_runtime_forbid().
> 
> This is nice cleanup! However I have one suggestion/comment.
> 
> Using pm_runtime_forbid() to prevent the device from being runtime
> suspended may be a bit fragile, as userspace can then still change to
> "allow" it. Wouldn't it be better to bump the runtime PM usage count
> (pm_runtime_get_noresume()) instead?

Right, this is not a PCI driver. :-)

I'll send an update of this patch shortly.

Thanks,
Rafael
