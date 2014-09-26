From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Thu, 25 Sep 2014 22:08:03 -0700
Message-ID: <7hvbob6kb0.fsf@deeprootsystems.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<20140925112122.GA22753@ulmo>
	<CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
	<20140925165625.GC30382@ulmo> <20140926002757.GJ10233@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140926002757.GJ10233@codeaurora.org> (Stephen Boyd's message
	of "Thu, 25 Sep 2014 17:27:57 -0700")
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>Ma
List-Id: linux-pm@vger.kernel.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 09/25, Thierry Reding wrote:

[...]

>> The critical part is that we need to enable the clock after the
>> partition has been powered, but before the clamps are removed.
>> Implementing this with runtime PM support in drivers won't work
>> because the power domain driver has to do both the powering up
>> and removing the clamps, so there's no place to inject the call
>> to enable the clock.
>
> FWIW, Qualcomm platforms have pretty much the same design. Our
> power domain controls live in the same register space as the
> clocks and resets. Is Tegra the same way? To power on/off a
> domain we need to go and forcefully turn a clock on and assert a
> reset or perhaps we need the clock to be off and assert a reset.
> It depends on the domain.
>

> Historically we've supported this by requiring all drivers to
> disable their clocks and deassert any resets before calling into
> this code (we put this behind the regulator API). Then we're free
> to do whatever is necessary to power on/off, eventally leaving
> the clocks off if they were forced on and finally giving control
> to the drivers so they can manage their own clocks and resets. It
> would be better for us to take ownership of the clocks and resets
> in the domain so we don't have this prerequisite of clocks being
> off before calling into the domain code. I plan to do pretty much
> Kevin outlined and use runtime PM, power domains, and per-device
> pm QoS to figure out if we should gate clocks (clk_disable), or
> if we go to a lower power mode where we unprepare clocks
> (clk_unprepare), or if we go to the lowest power mode where we
> apply clamps, etc. (called power collapse for us). Then the
> drivers just interact with runtime PM and QoS and they aren't
> aware of all this SoC glue.

Excellent!  I'm glad you're heading in that direction.  One other
important point here is that keeping drivers "simple" like this makes it
much easier for them to stay portable across SoCs.

Also, neither tegra or qcom are unique here.

FWIW, OMAP has similar ordering requirements, and quite a bit of "stuff"
to properly get a device and powerdomain to actually power down (and
power up) properly.  The OMAP implementation pre-dates runtime PM, power
domains etc. so we hid all of this behind the omap_hwmod abstraction and
the omap_device API where all clocks, resets, and various other magic is
handled, and so that device drivers didn't have to care about the details.

These days, those APIs are now used by the OMAP pm_domain implementation
(which pre-dates genpd), so drivers (still) don't have to care about the
details only have to care about runtime PM and QoS.  After genpd came
along, the goal was to convert OMAP to it, but well, other circumstances
have changed things such that those working in that area are, um...,
somewhat less focused on OMAP. ;)

Kevin


