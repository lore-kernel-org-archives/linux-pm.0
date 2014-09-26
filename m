From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 26 Sep 2014 07:50:08 -0700
Message-ID: <7hoau25tcv.fsf@deeprootsystems.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<20140925112122.GA22753@ulmo> <7hppej8glk.fsf@deeprootsystems.com>
	<20140926073125.GB31106@ulmo>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140926073125.GB31106@ulmo> (Thierry Reding's message of "Fri,
	26 Sep 2014 09:31:27 +0200")
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> On Thu, Sep 25, 2014 at 03:45:11PM -0700, Kevin Hilman wrote:
>> Thierry Reding <thierry.reding@gmail.com> writes:
>> 
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
> 	pmc@... {
> 		power-domains {
> 			...
>
> 			sata@... {
> 				clocks = <&tegra_car 124>;
> 				resets = <&tegra_car 124>;
> 			};
> 		};
> 	};
>
> An alternative would be to make the power-domain controller look up the
> clock within the user's device tree node. That could be problematic,
> because while the module clock is always the first clock in current
> device trees, there aren't ordering guarantees, so we'd have to rely on
> the clock name.
>
>> > Furthermore for some devices it may turn out that turning the domain
>> > off and on introduces too much latency to be useful.
>> 
>> In these cases, you should use the per-device PM QoS framework to set
>> per-device latencies.  Then your power-domain can look up these
>> latencies and decide whether or not to actually power gate or not.
>
> Does this allow fine-grained control over what parts of the "power
> domain" get disabled? 

Sure.  Your power-domain can have control over this, and can make
decisions based on QoS constraints or other considerations.

> For example some drivers may want to only turn off
> the clock under some circumstances, which would keep the hardware state,
> whereas in other situations or drivers it might be fine to completely
> turn off the power partition and reset the hardware block (loosing all
> hardware state).

Well, IMO, it shouldn't be the drivers making these decisions, because
the "circumstances" around these decisions typically are related to QoS
constraints that affect the whole power domain, not just that device.

Part of the benefit of moving direct clock management out of the
drivers, and into some pm_domain/genpd logic is that you put them in the
place that is has enough information to make decision based on the whole
power domain.  e.g. a specific device driver doesn't know (and shouldn't
know, IMO) about the what other devices might be in the same power
domain.  Only the power-domain logic has enough of a "big picture" to
make the right decisions.  The wakeup latency and the save/restore
context needs of a device depend on other factors in the power domain,
like whether that device is the last one to be idle, or whether the
power domain is going to be power gated due to constraints set by some
other device. 

> Keeping a reference to the clock in the power domain will prevent that
> from working since the driver itself won't be able to disable the
> hardware clock.

IMO, the driver itself shouldn't be disabling the hardware clock in the
first place.  That should be left up to the domain logic.

Kevin

