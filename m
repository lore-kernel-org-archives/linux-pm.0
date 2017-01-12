From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Preventing PM from suspending device
Date: Thu, 12 Jan 2017 08:10:53 +0100
Message-ID: <CAMuHMdXhtJQ-1nt3gTvkAJZpZ1o=A4iz_67VKZox5jSBOxN3oQ@mail.gmail.com>
References: <20170109172247.GI29854@bigcity.dyn.berto.se> <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33275 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750719AbdALHKz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 02:10:55 -0500
Received: by mail-io0-f194.google.com with SMTP id 101so1559819iom.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2017 23:10:54 -0800 (PST)
In-Reply-To: <CAPDyKFq0pbk3=Ne2wE9b62g+tCzNrT6Mm-5H1C+0obgJmTQSzw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Ulf,

On Thu, Jan 12, 2017 at 12:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> On 9 January 2017 at 18:22, Niklas S=C3=B6derlund
> <niklas.soderlund@ragnatech.se> wrote:
>> Hi Ulf and Linux PM,
>>
>> I have a question regarding if a driver can signal to the PM core that
>> it should not be suspended from its struct dev_pm_ops suspend callback.
>
> No. The driver/subsystem needs to deal this.
>
>> My use-case is the sh_eth driver which I have added Wake-on-Lan support
>> to, see [1]. In this driver I need to prevent the PM core to disable the
>> module clock to the device if WoL is enabled. Currently I call
>> clk_enable()/clk_disable() from the suspend/resume callbacks to modify
>> the usage count of the clock to prevent the clock from being switched
>> off by PM. This do not feel like the best solution to my problem.
>
> I am not sure I get this. Is someone else than the driver performing
> clk gateing/un-gating of the same clock?
>>
>> Is there a more generic way to let PM know that I'm fine with the system
>> being suspended and I have suspended as much as I can but I'm a wake up =
source
>> so could please not switch of my clock and power domain?
>
> Seems like a quite common issue, but before we go into more details,
> are you using genpd as the power domain? If not, what?

The Ethernet device is part of a PM Domain, hence it's power-managed by
genpd.
On most SoCs, that PM Domain is a clock domain, so Runtime PM and system
suspend disable the device's module clock, the latter breaking WoL.
Calling clk_enable() from the suspend callback works around that.
On some SoCs, that PM Domain is both a clock domain and a power domain.
Calling clk_enable() from the suspend callback is not sufficient here, but
fortunately the power domain stays powered for another reason (it contains
the memory controller).

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
