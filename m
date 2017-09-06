From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
Date: Wed, 6 Sep 2017 15:59:16 +0200
Message-ID: <CAPDyKFr0hV=m=TumYKLoYC57mTht9_185vR5ynP_3oi7rauRbg@mail.gmail.com>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFpX3Owk4H=0SqgfspXZd9TmdL_ANOZftXRq6HPjrT2ctQ@mail.gmail.com>
 <1883292.VFru06qUYG@aspire.rjw.lan> <8456507.jc97SKmauk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:37767 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932399AbdIFN7S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Sep 2017 09:59:18 -0400
Received: by mail-io0-f182.google.com with SMTP id j141so19899818ioj.4
        for <linux-pm@vger.kernel.org>; Wed, 06 Sep 2017 06:59:17 -0700 (PDT)
In-Reply-To: <8456507.jc97SKmauk@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 6 September 2017 at 12:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 6, 2017 2:52:59 AM CEST Rafael J. Wysocki wrote:
>> On Monday, September 4, 2017 2:55:37 PM CEST Ulf Hansson wrote:
>> > [...]
>
> I guess I can wrap it up, because all of the points seem to have been stated
> and repeating them would not be useful.
>
> My summary of the discussion is as follows.
>
> It only is valid to use pm_runtime_force_suspend/resume() as *driver*
> callbacks for system suspend/resume if both the driver itself and all of
> the middle layers it has to work with carry out the same sequence of
> operations in order to suspend the device both in runtime PM and for
> system sleep (and analogously for resuming).  [The middle layers need
> to meet additional conditions, but that's less relevant.]
>
> Unfortunately, for the ACPI PM domain and the PCI bus type the situation is
> different, because they generally need to do different things to suspend
> devices for system sleep than they do for runtime PM (which mostly is
> related to the handling of ACPI-defined sleep states and device/system
> wakeup, but not limited to that).  This clearly means that drivers needing
> to work with the ACPI PM domain and PCI drivers cannot use
> pm_runtime_force_suspend/resume() as their PM callbacks for system
> suspend/resume (quite fundamentally).
>
> [Note that for i2c-designware-platdrv the situation is even more complicated,
> because on some platforms it has to work with the ACPI PM domain (or the
> ACPI LPSS driver), on some platforms its parent is a PCI device and on
> some other platforms there's none of them.]

That is also why it makes it really interesting. I am guessing we will
be seeing more of these cases sooner or later.

To make it even more complex, I can guess we can expect cases when
genpd is mixed with the ACPI PM domain.

>
> However, for drivers that need to work with the ACPI PM domain and
> PCI drivers the differences in the device handling between runtime PM and
> system suspend/resume are *very* often (even though not always) covered
> entirely by the middle layer code.  Then, the driver itself actually
> always carries out the same sequence of operations in order to suspend
> the device (or to resume it, analogously).  The driver then can re-use
> its runtime PM callbacks for system suspend/resume (but at the driver
> level only) and it would be good to make that easy (or easier) for these
> drivers somehow.

This is a very nice summary so far, thanks for putting it together.

Kind regards
Uffe
