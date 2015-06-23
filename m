From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
Date: Tue, 23 Jun 2015 10:59:15 +0200
Message-ID: <CAMuHMdXsnKZjMe1FVr5etz6EakBxw9VONWa=UhC5uqa-TZWC_Q@mail.gmail.com>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdXntR6c4-uUNGVGx7D7941e8hvnmtVBvDu2+iUsNHQ=Qw@mail.gmail.com>
	<20150622204617.9112.71054@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150622204617.9112.71054@quantum>
Sender: linux-sh-owner@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mike,

On Mon, Jun 22, 2015 at 10:46 PM, Michael Turquette
<mturquette@linaro.org> wrote:
>> The MSTP block provides two functions:
>>   1. Module Standby: "Clock supply to specified modules is stopped by
>>      setting the module stop control register bits."
>>      However, the clock supply to a module is not stopped until all CPUs
>>      in the SoC agree.  Indeed, there are separate MSTP registers for
>>      application (Cortex-A) and real-time (SH and/or Cortex-R) cores.
>>   2. Reset control. to perform a software reset of a specific module.
>>
>> Given the second function, perhaps the MSTP bits shouldn't have been
>> moduled as clocks, but it made sense at the time of introduction, and
>> IMHO it still does.
>
> Does the clk.enable_count refcount for an MSTP "clock" mirror your
> statement, "the clock supply to a module is not stopped until all CPUs
> in the SoC agree"? Put another way, is it possble in a shmobile system
> for an MSTP "clock" to have an enable_count of zero, but still by
> physically enabled in hardware?

Yes. The enable_count only matches the bit in the application core MSTP
control register. The real-time core MSTP control register may still have the
same module clock enabled (i.e. module not put in standby).
On some SoCs (e.g. R-Mobile APE6) there can be 3 sets of control registers
(for application, real-time, and baseband core).

Most (not all) module clocks have a status register to check if the module
clock is actually enabled or not. This shows that the module clock is stopped
iff all cores agree to stop it.

However, I found a few module clocks that never can be stopped, according to
the status register. Perhaps there's another set of control registers for an
undocumented core...

In addition, there are many undocumented bits in the MSTP control registers,
which may represent existing but undocumented clocks. Disabling such bits
may lock up the system.

As Linux doesn't touch the control registers for other CPU cores (they're
not described in DT), a module clock may be enabled (read: not stopped) in
a control registers meant for another CPU core, depending on reset state or
on the boot loader. Or by another OS running on another CPU core.
I've been running for quite some time with extra code that disables all module
clocks (for all cores) at early boot time, which let me find lots of drivers
that relied on implicit module clocks. Most got fixed, the only major
offender left is the module clock for the GIC ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
