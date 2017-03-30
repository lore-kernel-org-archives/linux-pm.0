From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: Preventing PM from suspending device
Date: Thu, 30 Mar 2017 22:35:41 +0200
Message-ID: <20170330203541.GR24709@bigcity.dyn.berto.se>
References: <20170109172247.GI29854@bigcity.dyn.berto.se>
 <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
 <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com>
 <CAPDyKFqWEzMSTkz+pzXckXebzr8WH4dDHOE38OFX+w771J5ZEA@mail.gmail.com>
 <20170329192827.GI24709@bigcity.dyn.berto.se>
 <CAPDyKFqP2YO-f-L3+hCp8H32c5L5MBHcXuisA9iy8HwtgeAU+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35811 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbdC3Ufp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 16:35:45 -0400
Received: by mail-lf0-f47.google.com with SMTP id j90so34286207lfk.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 13:35:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFqP2YO-f-L3+hCp8H32c5L5MBHcXuisA9iy8HwtgeAU+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Ulf,

On 2017-03-30 18:44:20 +0200, Ulf Hansson wrote:
> On 29 March 2017 at 21:28, Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> > Hi Ulf,
> >
> > On 2017-01-12 18:02:40 +0100, Ulf Hansson wrote:
> >> On 12 January 2017 at 08:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> > Hi Ulf,
> >> >
> >> > On Thu, Jan 12, 2017 at 12:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> >> On 9 January 2017 at 18:22, Niklas Söderlund
> >> >> <niklas.soderlund@ragnatech.se> wrote:
> >> >>> Hi Ulf and Linux PM,
> >> >>>
> >> >>> I have a question regarding if a driver can signal to the PM core that
> >> >>> it should not be suspended from its struct dev_pm_ops suspend callback.
> >> >>
> >> >> No. The driver/subsystem needs to deal this.
> >> >>
> >> >>> My use-case is the sh_eth driver which I have added Wake-on-Lan support
> >> >>> to, see [1]. In this driver I need to prevent the PM core to disable the
> >> >>> module clock to the device if WoL is enabled. Currently I call
> >> >>> clk_enable()/clk_disable() from the suspend/resume callbacks to modify
> >> >>> the usage count of the clock to prevent the clock from being switched
> >> >>> off by PM. This do not feel like the best solution to my problem.
> >> >>
> >> >> I am not sure I get this. Is someone else than the driver performing
> >> >> clk gateing/un-gating of the same clock?
> >> >>>
> >> >>> Is there a more generic way to let PM know that I'm fine with the system
> >> >>> being suspended and I have suspended as much as I can but I'm a wake up source
> >> >>> so could please not switch of my clock and power domain?
> >> >>
> >> >> Seems like a quite common issue, but before we go into more details,
> >> >> are you using genpd as the power domain? If not, what?
> >> >
> >> > The Ethernet device is part of a PM Domain, hence it's power-managed by
> >> > genpd.
> >> > On most SoCs, that PM Domain is a clock domain, so Runtime PM and system
> >> > suspend disable the device's module clock, the latter breaking WoL.
> >> > Calling clk_enable() from the suspend callback works around that.
> >> > On some SoCs, that PM Domain is both a clock domain and a power domain.
> >> > Calling clk_enable() from the suspend callback is not sufficient here, but
> >> > fortunately the power domain stays powered for another reason (it contains
> >> > the memory controller).
> >>
> >> Thanks for the additional information, very useful.
> >>
> >> Allow me to think of this a little bit, before I give any further
> >> suggestions. Indeed a very interesting use-case, well worth to think
> >> more about! :-)
> >
> > I'm curious if you have had the opportunity to think about this. If not
> > no rush, I'm just checking in :-)
> 
> Yes I have! :-) It's soon reaching my top of my TODO list.
> 
> I realized that thinking isn't sufficient, I need to do some
> prototyping to convince myself about the best approach.

That's great news :-)

> 
> Sorry for the delay!

No worries, I'm not suffering from this since I can manage the clock 
directly from the driver. And as Geert explained the device is in an 
always on power domain. I just wanted to check in so that if a different 
solution is found I can remove the explicit clock handling.

Thanks again for thinking about this.

> 
> Br
> Uffe

-- 
Regards,
Niklas Söderlund
