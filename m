From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Preventing PM from suspending device
Date: Fri, 13 Jan 2017 10:38:31 +0100
Message-ID: <CAMuHMdVmbNddhF+7xxfm=Z4Zb7JnWNY2hSuuqtcrZirHtZaY7g@mail.gmail.com>
References: <20170109172247.GI29854@bigcity.dyn.berto.se> <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
 <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com> <CAPDyKFqWEzMSTkz+pzXckXebzr8WH4dDHOE38OFX+w771J5ZEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36798 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdAMJid (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 04:38:33 -0500
Received: by mail-it0-f68.google.com with SMTP id o138so4543285ito.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2017 01:38:32 -0800 (PST)
In-Reply-To: <CAPDyKFqWEzMSTkz+pzXckXebzr8WH4dDHOE38OFX+w771J5ZEA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Ulf,

On Thu, Jan 12, 2017 at 6:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> On 12 January 2017 at 08:10, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>> On Thu, Jan 12, 2017 at 12:19 AM, Ulf Hansson <ulf.hansson@linaro.org> w=
rote:
>>> On 9 January 2017 at 18:22, Niklas S=C3=B6derlund
>>> <niklas.soderlund@ragnatech.se> wrote:
>>>> Hi Ulf and Linux PM,
>>>>
>>>> I have a question regarding if a driver can signal to the PM core that
>>>> it should not be suspended from its struct dev_pm_ops suspend callback=
.
>>>
>>> No. The driver/subsystem needs to deal this.
>>>
>>>> My use-case is the sh_eth driver which I have added Wake-on-Lan suppor=
t
>>>> to, see [1]. In this driver I need to prevent the PM core to disable t=
he
>>>> module clock to the device if WoL is enabled. Currently I call
>>>> clk_enable()/clk_disable() from the suspend/resume callbacks to modify
>>>> the usage count of the clock to prevent the clock from being switched
>>>> off by PM. This do not feel like the best solution to my problem.
>>>
>>> I am not sure I get this. Is someone else than the driver performing
>>> clk gateing/un-gating of the same clock?
>>>>
>>>> Is there a more generic way to let PM know that I'm fine with the syst=
em
>>>> being suspended and I have suspended as much as I can but I'm a wake u=
p source
>>>> so could please not switch of my clock and power domain?
>>>
>>> Seems like a quite common issue, but before we go into more details,
>>> are you using genpd as the power domain? If not, what?
>>
>> The Ethernet device is part of a PM Domain, hence it's power-managed by
>> genpd.
>> On most SoCs, that PM Domain is a clock domain, so Runtime PM and system
>> suspend disable the device's module clock, the latter breaking WoL.
>> Calling clk_enable() from the suspend callback works around that.
>> On some SoCs, that PM Domain is both a clock domain and a power domain.
>> Calling clk_enable() from the suspend callback is not sufficient here, b=
ut
>> fortunately the power domain stays powered for another reason (it contai=
ns
>> the memory controller).
>
> Thanks for the additional information, very useful.

Related commits calling clk_enable() to keep modules awake:
  - 6f46aedb9c85873b ("irqchip: renesas-irqc: Add wake-up support")
  - ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable when
    wake-up is enabled")
  - 705bc96c2c15313c ("irqchip: renesas-intc-irqpin: Add minimal runtime
    PM support")

Basically anything needed for wake-up needs to stay active, but should
not prevent the system from entering system suspend (i.e. cannot return
-EBUSY from its suspend function).

> Allow me to think of this a little bit, before I give any further
> suggestions. Indeed a very interesting use-case, well worth to think
> more about! :-)

Thanks, and happy thinking!

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
