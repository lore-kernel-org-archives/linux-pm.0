From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 26 Sep 2014 12:01:13 +0200
Message-ID: <CAMuHMdUqHZWrQGx=y8_yEJ7G9H5C=Y14-qPCMVJC6mxS5Sdb6A@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<20140925112122.GA22753@ulmo>
	<7hppej8glk.fsf@deeprootsystems.com>
	<20140926073125.GB31106@ulmo>
	<CAMuHMdWq9ZySdt8sQpBFq=X7LR5a=vZkowNZoB8NHztTisG+NQ@mail.gmail.com>
	<20140926095647.GI31106@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140926095647.GI31106@ulmo>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@g>
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

On Fri, Sep 26, 2014 at 11:56 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
>> > An alternative would be to make the power-domain controller look up the
>> > clock within the user's device tree node. That could be problematic,
>> > because while the module clock is always the first clock in current
>> > device trees, there aren't ordering guarantees, so we'd have to rely on
>> > the clock name.
>>
>> Or on some other way.
>> Do you have a separate hardware block that controls all (and only) the
>> module clocks?
>
> No, the "clock and reset controller" controls all clocks (and resets) on
> the SoC.

Sorry, with "only the module clocks" I meant "not clocks that are not module
clocks". Having a reset controller function in there is fine.

So it seems you do have a clock provider that provides module clocks,
and can mark them CLK_RUNTIME_PM.

>> On shmobile SoCs, all module clocks are controlled using the MSTP
>> (Module SToP) clocks.
>>
>> In my old RFC series "[PATCH/RFC 0/4] of: Register clocks for Runtime PM
>> with PM core" (https://lkml.org/lkml/2014/4/24/1118) the MSTP clock driver
>> advertised using a new CLK_RUNTIME_PM flag that its clocks are module
>> clocks and thus suitable for runtime PM.
>>
>> There were some issues with that series, but the general idea of letting a
>> clock driver advertise that all its clocks are module clocks could still be
>> useful. Then the power domain driver knows which clocks to manage.
>
> That sounds interesting. Although it would still mean that we need a way
> to associate a clock with the correct power domain. I guess the driver
> could do that by iterating over all available clocks in the device's
> clocks property and grab only those that are marked CLK_RUNTIME_PM.

Yes, that's the idea.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
