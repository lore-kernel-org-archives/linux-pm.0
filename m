From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] PM / core: genpd fix and pm_runtime_force_suspend|resume()
 rework
Date: Mon, 15 Jan 2018 01:04:46 +0100
Message-ID: <CAJZ5v0i5FhKCtvcvS_PfpFQKo-zjExT4YypYaaTC7JD5kX-kew@mail.gmail.com>
References: <4928977.5hd79RbQlp@aspire.rjw.lan> <CAMuHMdX6dJzOcxkWyDR6anpcwZU5fy03sTeChEp35KY0d40iFg@mail.gmail.com>
 <12351114.Ym7QOfxZhK@aspire.rjw.lan> <CAMuHMdVaiuscrvat=BqtmXxQnA35=wocb85FHEFvQWjQaY615g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVaiuscrvat=BqtmXxQnA35=wocb85FHEFvQWjQaY615g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 14, 2018 at 10:48 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Sat, Jan 13, 2018 at 1:38 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Friday, January 12, 2018 3:31:09 PM CET Geert Uytterhoeven wrote:
>>> On Fri, Jan 12, 2018 at 2:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> > This comes from the recent discussion/testing effort that ensued after my
>>> > pm_runtime_force_suspend|resume() changes proposal:
>>> >
>>> > https://marc.info/?t=151497772000004&r=1&w=2
>>> >
>>> > Patch [1/2] basically is https://patchwork.kernel.org/patch/10152873/ rebased
>>> > on top of the current linux-next branch of the linux-pm.git tree (the relevant
>>> > part should be there in the linux-next tree proper ATM).  It applies on top
>>> > of https://patchwork.kernel.org/patch/10156077/ which should apply to the Linus'
>>> > tree cleanly.
>>> >
>>> > Patch [2/2] is a resend of https://patchwork.kernel.org/patch/10142047/ with
>>> > a very minor changelog modification and the R-b tag from Ulf.
>>> >
>>> > Geert, if possible, please test this on the Renesas systems that had the
>>> > problem with https://patchwork.kernel.org/patch/10142047/ previously and let
>>> > me know if you still see issues.
>>>
>>> I've tested this on two very similar systems: Salvator-XS with R-Car H3 ES2.0,
>>> and Salvator-X with R-Car M3-W ES1.0.
>>>
>>> On the M3-based system, everything seems to work fine.
>>
>> Good.
>>
>>> On the H3-based system, the serial console (the /dev/ttySC0 device, not kernel
>>> serial output) is dead after resume from s2ram, with and without
>>> no_console_suspend.
>>>
>>> With no_console_suspend, I see:
>>>
>>>     ttySC ttySC0: 1 input overrun(s)
>>>
>>> after typing on the serial console, so it looks like an interrupt problem.
>>>
>>> This issue seems to be caused by patch [1/2]. But I have no idea what's
>>> really happening, and why the two systems behave differently.
>
> Could be a firmware issue, too.
> While the kernel images are identical, the ARM trusted firmware configs aren't
> (same version, though).
>
> I'll do some more investigation...

OK, thanks!

It also would be good to know the topology of the device hierarchy and
how that maps to the domains on the failing system (and which UART
clocks are operated by genpd).

>> Well, that's not dramatic.
>>
>> Let's make a deal that we'll fix this on top of [1/2].
>
> ;-)
>
>> Which driver is this BTW?  sh-sci?  That one doesn't even support runtime
>> PM, confusingly enough.
>
> Yes, sh-sci. It does make pm_runtime_*() calls.

Hmm.  I overlooked that part.

This is sort of unusual, because the driver doesn't provide any
runtime PM callbacks, but still it does provided system suspend ones.
It looks like the idea is to never put it into runtime suspend if any
ports are enabled and always put it into runtime suspend otherwise.

Which one is the case in your testing?  Is the port disabled or
enabled during system-wide suspend?

> And of course there's uart_ops.pm, which is driven from serial_core...

What does this point to for that particular device?
