From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Preventing PM from suspending device
Date: Wed, 18 Oct 2017 13:35:26 +0200
Message-ID: <CAMuHMdVcW6eNpyexRCkNA8gg0Z1gVcs_hMHWoag+jUku_MHGyw@mail.gmail.com>
References: <20170109172247.GI29854@bigcity.dyn.berto.se> <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
 <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com>
 <CAPDyKFqWEzMSTkz+pzXckXebzr8WH4dDHOE38OFX+w771J5ZEA@mail.gmail.com>
 <20170329192827.GI24709@bigcity.dyn.berto.se> <CAPDyKFqP2YO-f-L3+hCp8H32c5L5MBHcXuisA9iy8HwtgeAU+g@mail.gmail.com>
 <20170330203541.GR24709@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45118 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754228AbdJRLf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 07:35:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id k7so4672441wre.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2017 04:35:27 -0700 (PDT)
In-Reply-To: <20170330203541.GR24709@bigcity.dyn.berto.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

)Hi Niklas, Ulf,

On Thu, Mar 30, 2017 at 10:35 PM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> On 2017-03-30 18:44:20 +0200, Ulf Hansson wrote:
>> On 29 March 2017 at 21:28, Niklas S=C3=B6derlund
>> <niklas.soderlund@ragnatech.se> wrote:
>> > On 2017-01-12 18:02:40 +0100, Ulf Hansson wrote:
>> >> On 12 January 2017 at 08:10, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>> >> > On Thu, Jan 12, 2017 at 12:19 AM, Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
>> >> >> On 9 January 2017 at 18:22, Niklas S=C3=B6derlund
>> >> >> <niklas.soderlund@ragnatech.se> wrote:
>> >> >>> I have a question regarding if a driver can signal to the PM core=
 that
>> >> >>> it should not be suspended from its struct dev_pm_ops suspend cal=
lback.
>> >> >>
>> >> >> No. The driver/subsystem needs to deal this.
>> >> >>
>> >> >>> My use-case is the sh_eth driver which I have added Wake-on-Lan s=
upport
>> >> >>> to, see [1]. In this driver I need to prevent the PM core to disa=
ble the
>> >> >>> module clock to the device if WoL is enabled. Currently I call
>> >> >>> clk_enable()/clk_disable() from the suspend/resume callbacks to m=
odify
>> >> >>> the usage count of the clock to prevent the clock from being swit=
ched
>> >> >>> off by PM. This do not feel like the best solution to my problem.
>> >> >>
>> >> >> I am not sure I get this. Is someone else than the driver performi=
ng
>> >> >> clk gateing/un-gating of the same clock?
>> >> >>>
>> >> >>> Is there a more generic way to let PM know that I'm fine with the=
 system
>> >> >>> being suspended and I have suspended as much as I can but I'm a w=
ake up source
>> >> >>> so could please not switch of my clock and power domain?
>> >> >>
>> >> >> Seems like a quite common issue, but before we go into more detail=
s,
>> >> >> are you using genpd as the power domain? If not, what?
>> >> >
>> >> > The Ethernet device is part of a PM Domain, hence it's power-manage=
d by
>> >> > genpd.
>> >> > On most SoCs, that PM Domain is a clock domain, so Runtime PM and s=
ystem
>> >> > suspend disable the device's module clock, the latter breaking WoL.
>> >> > Calling clk_enable() from the suspend callback works around that.
>> >> > On some SoCs, that PM Domain is both a clock domain and a power dom=
ain.
>> >> > Calling clk_enable() from the suspend callback is not sufficient he=
re, but
>> >> > fortunately the power domain stays powered for another reason (it c=
ontains
>> >> > the memory controller).
>> >>
>> >> Thanks for the additional information, very useful.
>> >>
>> >> Allow me to think of this a little bit, before I give any further
>> >> suggestions. Indeed a very interesting use-case, well worth to think
>> >> more about! :-)
>> >
>> > I'm curious if you have had the opportunity to think about this. If no=
t
>> > no rush, I'm just checking in :-)
>>
>> Yes I have! :-) It's soon reaching my top of my TODO list.
>>
>> I realized that thinking isn't sufficient, I need to do some
>> prototyping to convince myself about the best approach.
>
> That's great news :-)
>
>>
>> Sorry for the delay!
>
> No worries, I'm not suffering from this since I can manage the clock
> directly from the driver. And as Geert explained the device is in an
> always on power domain. I just wanted to check in so that if a different
> solution is found I can remove the explicit clock handling.

In case you missed it: the issue turned out to be the R-Car PM Domain
driver(s) not proving gpd_dev_ops.active_wakeup() callbacks, cfr.
"[PATCH 00/10] PM / Domain: renesas: Fix active wakeup behavior"
(https://www.spinics.net/lists/linux-renesas-soc/msg19319.html).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
