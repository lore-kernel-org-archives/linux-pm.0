From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Thu, 25 Sep 2014 17:27:57 -0700
Message-ID: <20140926002757.GJ10233@codeaurora.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <CAPDyKFp8oK6KAujU44NEwT2vL2_BBPSMuGPkyppHdonPfOmUrQ@mail.gmail.com>
 <20140925165625.GC30382@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140925165625.GC30382@ulmo>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>Mark Brown <b>
List-Id: linux-pm@vger.kernel.org

On 09/25, Thierry Reding wrote:
> On Thu, Sep 25, 2014 at 05:29:10PM +0200, Ulf Hansson wrote:
> > On 25 September 2014 13:21, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > I just noticed these patches because they conflicted with some of the
> > > local patches I had to add a very similar framework. One of the reasons
> > > why I hadn't posted these publicly yet is because the platform where I
> > > want to use this (Tegra) is somewhat quirky when it comes to power
> > > domains.
> > 
> > It's great that more things goes on in this area. :-)
> > 
> > >
> > > On Tegra these domains are called power gates and they currently have
> > > their own API. We've been looking at migrating things over to some
> > > generic framework for some time and PM domains do seem like a good fit.
> > > However one of the quirks regarding these domains on Tegra is that a
> > > fixed sequence exists that needs to be respected when enabling or
> > > disabling a power partition. The exact sequence can be found in the
> > > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> > > function. Essentially we need to call into the clock and reset drivers
> > > at very specific moments during the operations that the PMC does.
> > 
> > I am not sure I fully understand how the power gating actually
> > happens. How is it triggered?
> 
> Drivers explicitly call the custom API. So all drivers that need to turn
> on power partitions have a call to tegra_powergate_sequence_power_up()
> in .probe() and tegra_powergate_power_off() in .remove().
> 
> > > One solution to this would be to make the needed clocks and resets
> > > available to the power domain driver via DT, but then we have the
> > > problem that two drivers would be controlling the same resources. For
> > > example drivers could still want to disable the clock for more fine-
> > > grained power management.
> > 
> > Sorry, but I think I need a better understanding to be able to comment.
> > 
> > But maybe, drivers could implement runtime PM support and define
> > runtime PM callbacks. From the callbacks those will handle clocks and
> > resets, is not that enough? What more is needed from a PM domain point
> > of view?
> 
> Let me quote the actual power up sequence code:
> 
> 	int tegra_powergate_sequence_power_up(int id, struct clk *clk,
> 					      struct reset_control *rst)
> 	{
> 		int ret;
> 
> 		reset_control_assert(rst);
> 
> 		ret = tegra_powergate_power_on(id);
> 		if (ret)
> 			goto err_power;
> 
> 		ret = clk_prepare_enable(clk);
> 		if (ret)
> 			goto err_clk;
> 
> 		usleep_range(10, 20);
> 
> 		ret = tegra_powergate_remove_clamping(id);
> 		if (ret)
> 			goto err_clamp;
> 
> 		usleep_range(10, 20);
> 		reset_control_deassert(rst);
> 
> 		return 0;
> 
> 	err_clamp:
> 		clk_disable_unprepare(clk);
> 	err_clk:
> 		tegra_powergate_power_off(id);
> 	err_power:
> 		return ret;
> 	}
> 	EXPORT_SYMBOL(tegra_powergate_sequence_power_up);
> 
> The critical part is that we need to enable the clock after the
> partition has been powered, but before the clamps are removed.
> Implementing this with runtime PM support in drivers won't work
> because the power domain driver has to do both the powering up
> and removing the clamps, so there's no place to inject the call
> to enable the clock.

FWIW, Qualcomm platforms have pretty much the same design. Our
power domain controls live in the same register space as the
clocks and resets. Is Tegra the same way? To power on/off a
domain we need to go and forcefully turn a clock on and assert a
reset or perhaps we need the clock to be off and assert a reset.
It depends on the domain.

Historically we've supported this by requiring all drivers to
disable their clocks and deassert any resets before calling into
this code (we put this behind the regulator API). Then we're free
to do whatever is necessary to power on/off, eventally leaving
the clocks off if they were forced on and finally giving control
to the drivers so they can manage their own clocks and resets. It
would be better for us to take ownership of the clocks and resets
in the domain so we don't have this prerequisite of clocks being
off before calling into the domain code. I plan to do pretty much
Kevin outlined and use runtime PM, power domains, and per-device
pm QoS to figure out if we should gate clocks (clk_disable), or
if we go to a lower power mode where we unprepare clocks
(clk_unprepare), or if we go to the lowest power mode where we
apply clamps, etc. (called power collapse for us). Then the
drivers just interact with runtime PM and QoS and they aren't
aware of all this SoC glue.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
