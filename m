From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 26 Sep 2014 10:06:24 +0200
Message-ID: <CAMuHMdWq9ZySdt8sQpBFq=X7LR5a=vZkowNZoB8NHztTisG+NQ@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<20140925112122.GA22753@ulmo>
	<7hppej8glk.fsf@deeprootsystems.com>
	<20140926073125.GB31106@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140926073125.GB31106@ulmo>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@g>
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

On Fri, Sep 26, 2014 at 9:31 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Thu, Sep 25, 2014 at 03:45:11PM -0700, Kevin Hilman wrote:
>> Thierry Reding <thierry.reding@gmail.com> writes:
>> > I just noticed these patches because they conflicted with some of the
>> > local patches I had to add a very similar framework. One of the reasons
>> > why I hadn't posted these publicly yet is because the platform where I
>> > want to use this (Tegra) is somewhat quirky when it comes to power
>> > domains.
>> >
>> > On Tegra these domains are called power gates and they currently have
>> > their own API. We've been looking at migrating things over to some
>> > generic framework for some time and PM domains do seem like a good fit.
>> > However one of the quirks regarding these domains on Tegra is that a
>> > fixed sequence exists that needs to be respected when enabling or
>> > disabling a power partition. The exact sequence can be found in the
>> > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
>> > function. Essentially we need to call into the clock and reset drivers
>> > at very specific moments during the operations that the PMC does.
>> >
>> > One solution to this would be to make the needed clocks and resets
>> > available to the power domain driver via DT, but then we have the
>> > problem that two drivers would be controlling the same resources. For
>> > example drivers could still want to disable the clock for more fine-
>> > grained power management.
>>
>> I think you're on the right path here.  You can get rid of this conflict
>> by removing the direct/manual clock management from the drivers, and
>> using runtime PM instead: s/clk_enable/pm_runtime_get_sync/,
>> s/clk_disable/pm_runtime_put_sync/.  When using runtime PM, those calls
>> trickle down through the power domain driver, which can manage the
>> device clocks, as well as any additional clocks and resets needed for
>> power gating.
>
> Okay. The DT part of it is going to be pretty nasty (as usual) because
> we currently have the clocks and resets within the device's device tree
> node (which I think is where they really belong).
>
> So one possibility would be to move the clocks and resets to the power
> domain controller's node, like so:
>
>         pmc@... {
>                 power-domains {
>                         ...
>
>                         sata@... {
>                                 clocks = <&tegra_car 124>;
>                                 resets = <&tegra_car 124>;
>                         };
>                 };
>         };
>
> An alternative would be to make the power-domain controller look up the
> clock within the user's device tree node. That could be problematic,
> because while the module clock is always the first clock in current
> device trees, there aren't ordering guarantees, so we'd have to rely on
> the clock name.

Or on some other way.
Do you have a separate hardware block that controls all (and only) the
module clocks?

On shmobile SoCs, all module clocks are controlled using the MSTP
(Module SToP) clocks.

In my old RFC series "[PATCH/RFC 0/4] of: Register clocks for Runtime PM
with PM core" (https://lkml.org/lkml/2014/4/24/1118) the MSTP clock driver
advertised using a new CLK_RUNTIME_PM flag that its clocks are module
clocks and thus suitable for runtime PM.

There were some issues with that series, but the general idea of letting a
clock driver advertise that all its clocks are module clocks could still be
useful. Then the power domain driver knows which clocks to manage.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
