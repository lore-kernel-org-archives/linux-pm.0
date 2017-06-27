From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Tue, 27 Jun 2017 09:14:41 -0700
Message-ID: <1498580081.7952.91.camel@linux.intel.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
         <CA+55aFyBfHVyh=TMifF+0KGEVy6JEyDz=gbHdP7nM2roa++X4Q@mail.gmail.com>
         <CA+b4Kqd9qV0Pc7wJ2eHKcA-7+a23tY9gfe2Abm4=Bd08SKkh8w@mail.gmail.com>
         <1908911.91yT2N6t2f@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:55735 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbdF0QOn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Jun 2017 12:14:43 -0400
In-Reply-To: <1908911.91yT2N6t2f@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tom Lanyon <tom@oneshoeco.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 2017-06-27 at 17:03 +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 27, 2017 03:50:33 PM Tom Lanyon wrote:
> > 
> > On 23 June 2017 at 12:40, Linus Torvalds <torvalds@linux-foundation
> > .org> wrote:
> > > 
> > > On Thu, Jun 22, 2017 at 4:56 PM, Rafael J. Wysocki <rjw@rjwysocki
> > > .net> wrote:
> > > > 
> > > > 
> > > > Some recent Dell laptops, including the XPS13 model numbers
> > > > 9360 and
> > > > 9365, cannot be woken up from suspend-to-idle by pressing the
> > > > power
> > > > button which is unexpected and makes that feature less usable
> > > > on
> > > > those systems.  [ details removed ]
> > > 
> > > This looks much more reasonable and more likely to work on future
> > > machines too.
> > > 
> > > Of course, who knows what broken machines it will cause problems
> > > on,
> > > but it sounds like the code now does what it's supposed to and
> > > what
> > > Win10 does, so maybe it JustWorks(tm). Hah.
> > 
> > Rafael - thanks for your efforts on this.
> 
> You're welcome!
> 
> > 
> > I wanted to provide some feedback from some quick and naive tests
> > on
> > an XPS 13 9365 in case it was useful, as it seems like there's
> > still
> > some way to go before matching Win10's behaviour.
> > 
> >     Linux idling w/ screen ON => 17% battery drain per hour.
> >     Linux idling w/ screen OFF => 12% battery drain per hour.
> >     Linux during s2idle => 6% battery drain per hour.
> >     Win10 during sleep => 1% battery drain per hour.
> > 
> > where Linux = 4.12-rc6 + the latest patch from your acpi-pm-test
> > branch.
> > 
> > So whilst s2idle halves the battery drain compared to the machine
> > staying powered on, it's still significantly more draining than
> > Win10.
> 
> Thanks for the data.
> 
> > 
> > Let me know if there's any more useful analysis I can do.
> 
> I would carry out s2idle under turbostat to see how much PC10
> residency is
> there while suspended.  That may be a significant factor.
> 
> Most likely there is a device preventing the SoC from reaching its
> deepest
> low-power states under Linux on your system and it needs to be
> identified
> and dealt with.
Also make sure that you have no FW loading error for i915.
#dmesg | grep i915
It will display that Guc FW was loaded etc..
The latest FW can be downloaded from
https://01.org/linuxgraphics/downloads/firmware

If you don't see PC10 residency, we can try something more.

Thanks,
Srinivas


> 
> Thanks,
> Rafael
> 
