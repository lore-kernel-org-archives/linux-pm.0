From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Preventing PM from suspending device
Date: Thu, 12 Jan 2017 18:02:40 +0100
Message-ID: <CAPDyKFqWEzMSTkz+pzXckXebzr8WH4dDHOE38OFX+w771J5ZEA@mail.gmail.com>
References: <20170109172247.GI29854@bigcity.dyn.berto.se> <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
 <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37228 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdALRCn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 12:02:43 -0500
Received: by mail-wm0-f54.google.com with SMTP id c206so30009295wme.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2017 09:02:42 -0800 (PST)
In-Reply-To: <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 January 2017 at 08:10, Geert Uytterhoeven <geert@linux-m68k.org> wrot=
e:
> Hi Ulf,
>
> On Thu, Jan 12, 2017 at 12:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
>> On 9 January 2017 at 18:22, Niklas S=C3=B6derlund
>> <niklas.soderlund@ragnatech.se> wrote:
>>> Hi Ulf and Linux PM,
>>>
>>> I have a question regarding if a driver can signal to the PM core that
>>> it should not be suspended from its struct dev_pm_ops suspend callback.
>>
>> No. The driver/subsystem needs to deal this.
>>
>>> My use-case is the sh_eth driver which I have added Wake-on-Lan support
>>> to, see [1]. In this driver I need to prevent the PM core to disable th=
e
>>> module clock to the device if WoL is enabled. Currently I call
>>> clk_enable()/clk_disable() from the suspend/resume callbacks to modify
>>> the usage count of the clock to prevent the clock from being switched
>>> off by PM. This do not feel like the best solution to my problem.
>>
>> I am not sure I get this. Is someone else than the driver performing
>> clk gateing/un-gating of the same clock?
>>>
>>> Is there a more generic way to let PM know that I'm fine with the syste=
m
>>> being suspended and I have suspended as much as I can but I'm a wake up=
 source
>>> so could please not switch of my clock and power domain?
>>
>> Seems like a quite common issue, but before we go into more details,
>> are you using genpd as the power domain? If not, what?
>
> The Ethernet device is part of a PM Domain, hence it's power-managed by
> genpd.
> On most SoCs, that PM Domain is a clock domain, so Runtime PM and system
> suspend disable the device's module clock, the latter breaking WoL.
> Calling clk_enable() from the suspend callback works around that.
> On some SoCs, that PM Domain is both a clock domain and a power domain.
> Calling clk_enable() from the suspend callback is not sufficient here, bu=
t
> fortunately the power domain stays powered for another reason (it contain=
s
> the memory controller).

Thanks for the additional information, very useful.

Allow me to think of this a little bit, before I give any further
suggestions. Indeed a very interesting use-case, well worth to think
more about! :-)

Kind regards
Uffe
