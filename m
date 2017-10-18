From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Preventing PM from suspending device
Date: Wed, 18 Oct 2017 14:06:08 +0200
Message-ID: <CAPDyKFqnaw-Hdj4b=LNTry7z5Gfb9fmy5iHX67EJJQqTxRV_-g@mail.gmail.com>
References: <20170109172247.GI29854@bigcity.dyn.berto.se> <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
 <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com>
 <CAPDyKFqWEzMSTkz+pzXckXebzr8WH4dDHOE38OFX+w771J5ZEA@mail.gmail.com>
 <20170329192827.GI24709@bigcity.dyn.berto.se> <CAPDyKFqP2YO-f-L3+hCp8H32c5L5MBHcXuisA9iy8HwtgeAU+g@mail.gmail.com>
 <20170330203541.GR24709@bigcity.dyn.berto.se> <CAMuHMdVcW6eNpyexRCkNA8gg0Z1gVcs_hMHWoag+jUku_MHGyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:48988 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbdJRMGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 08:06:10 -0400
Received: by mail-io0-f169.google.com with SMTP id j17so5927135iod.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2017 05:06:09 -0700 (PDT)
In-Reply-To: <CAMuHMdVcW6eNpyexRCkNA8gg0Z1gVcs_hMHWoag+jUku_MHGyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 October 2017 at 13:35, Geert Uytterhoeven <geert@linux-m68k.org> wrot=
e:
> )Hi Niklas, Ulf,
>
> On Thu, Mar 30, 2017 at 10:35 PM, Niklas S=C3=B6derlund
> <niklas.soderlund@ragnatech.se> wrote:
>> On 2017-03-30 18:44:20 +0200, Ulf Hansson wrote:
>>> On 29 March 2017 at 21:28, Niklas S=C3=B6derlund
>>> <niklas.soderlund@ragnatech.se> wrote:
>>> > On 2017-01-12 18:02:40 +0100, Ulf Hansson wrote:
>>> >> On 12 January 2017 at 08:10, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
>>> >> > On Thu, Jan 12, 2017 at 12:19 AM, Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
>>> >> >> On 9 January 2017 at 18:22, Niklas S=C3=B6derlund
>>> >> >> <niklas.soderlund@ragnatech.se> wrote:
>>> >> >>> I have a question regarding if a driver can signal to the PM cor=
e that
>>> >> >>> it should not be suspended from its struct dev_pm_ops suspend ca=
llback.
>>> >> >>
>>> >> >> No. The driver/subsystem needs to deal this.
>>> >> >>
>>> >> >>> My use-case is the sh_eth driver which I have added Wake-on-Lan =
support
>>> >> >>> to, see [1]. In this driver I need to prevent the PM core to dis=
able the
>>> >> >>> module clock to the device if WoL is enabled. Currently I call
>>> >> >>> clk_enable()/clk_disable() from the suspend/resume callbacks to =
modify
>>> >> >>> the usage count of the clock to prevent the clock from being swi=
tched
>>> >> >>> off by PM. This do not feel like the best solution to my problem=
.
>>> >> >>
>>> >> >> I am not sure I get this. Is someone else than the driver perform=
ing
>>> >> >> clk gateing/un-gating of the same clock?
>>> >> >>>
>>> >> >>> Is there a more generic way to let PM know that I'm fine with th=
e system
>>> >> >>> being suspended and I have suspended as much as I can but I'm a =
wake up source
>>> >> >>> so could please not switch of my clock and power domain?
>>> >> >>
>>> >> >> Seems like a quite common issue, but before we go into more detai=
ls,
>>> >> >> are you using genpd as the power domain? If not, what?
>>> >> >
>>> >> > The Ethernet device is part of a PM Domain, hence it's power-manag=
ed by
>>> >> > genpd.
>>> >> > On most SoCs, that PM Domain is a clock domain, so Runtime PM and =
system
>>> >> > suspend disable the device's module clock, the latter breaking WoL=
.
>>> >> > Calling clk_enable() from the suspend callback works around that.
>>> >> > On some SoCs, that PM Domain is both a clock domain and a power do=
main.
>>> >> > Calling clk_enable() from the suspend callback is not sufficient h=
ere, but
>>> >> > fortunately the power domain stays powered for another reason (it =
contains
>>> >> > the memory controller).
>>> >>
>>> >> Thanks for the additional information, very useful.
>>> >>
>>> >> Allow me to think of this a little bit, before I give any further
>>> >> suggestions. Indeed a very interesting use-case, well worth to think
>>> >> more about! :-)
>>> >
>>> > I'm curious if you have had the opportunity to think about this. If n=
ot
>>> > no rush, I'm just checking in :-)
>>>
>>> Yes I have! :-) It's soon reaching my top of my TODO list.
>>>
>>> I realized that thinking isn't sufficient, I need to do some
>>> prototyping to convince myself about the best approach.
>>
>> That's great news :-)
>>
>>>
>>> Sorry for the delay!
>>
>> No worries, I'm not suffering from this since I can manage the clock
>> directly from the driver. And as Geert explained the device is in an
>> always on power domain. I just wanted to check in so that if a different
>> solution is found I can remove the explicit clock handling.
>
> In case you missed it: the issue turned out to be the R-Car PM Domain
> driver(s) not proving gpd_dev_ops.active_wakeup() callbacks, cfr.
> "[PATCH 00/10] PM / Domain: renesas: Fix active wakeup behavior"
> (https://www.spinics.net/lists/linux-renesas-soc/msg19319.html).

That works, but as a matter of fact a have a slightly different idea
on how to perhaps better solve this. Allow me a couple of days, then I
respond to you.

Kind regards
Uffe
