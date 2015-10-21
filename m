From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Alternative approach to solve the deferred probe
Date: Wed, 21 Oct 2015 19:28:17 +0100
Message-ID: <20151021182817.GM32532@n2100.arm.linux.org.uk>
References: <CAAObsKDWM6A98tdKHqi4fe5DBf0BmB0JeghcZDWan_PYbyshag@mail.gmail.com>
 <20151019153548.GM32532@n2100.arm.linux.org.uk>
 <CAMuHMdVv=ieYM-Nehp0qV8CEggHEeJ22j-6i_N09rRA_U=2ePw@mail.gmail.com>
 <20151020154656.GY32532@n2100.arm.linux.org.uk>
 <56270D5B.5010902@gmail.com>
 <20151021081847.GB32532@n2100.arm.linux.org.uk>
 <5627B0F7.7010600@gmail.com>
 <5627C381.60602@ti.com>
 <20151021172042.GJ32532@n2100.arm.linux.org.uk>
 <5627D5DC.1040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5627D5DC.1040708@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: frowand.list@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 21, 2015 at 09:13:48PM +0300, Grygorii Strashko wrote:
> But I worry a bit (and that my main point) about these few additional
> rounds of deferred device probing which I have right now and which allows
> some of drivers to finish, finally, their probes successfully.
> With proposed change I'll get more messages in boot log, but some of
> them will belong to drivers which have been probed successfully and so,
> they will be not really useful.

Then you haven't properly understood my proposal.

I want to get rid of all the "X deferred its probing" messages up until
the point that we set the "please report deferred probes" flag.

That _should_ mean that all the deferred probing that goes on becomes
_totally_ silent and becomes hidden (unless you really want to see it,
in which case we can make a debug option which turns it on) up until
we're at the point where we want to enter userspace.

At that point, we then report into the kernel log which devices are
still deferring and, via appropriately placed dev_warn_deferred(),
the reasons why the devices are being deferred.

So, gone will be all the messages earlier in the log about device X
not having a GPIO/clock/whatever because the device providing the
GPIO/clock/whatever hasn't been probed.

If everything is satisfied by the time we run this last round (again,
I'm not using a three line sentence to describe exactly what I mean,
I'm sure you know by now... oops, I just did) then the kernel will
report nothing about any deferrals.  That's _got_ to be an improvement.

> 
> As result, I think, the most important thing is to identify (or create)
> some point during kernel boot when it will be possible to say that all
> built-in drivers (at least) finish their probes 100% (done or defer).
> 
> Might be do_initcalls() can be updated (smth like this):
> static void __init do_initcalls(void)
> {
> 	int level;
> 
> 	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++)
> 		do_initcall_level(level);
> 
> +	wait_for_device_probe();
> +	/* Now one final round, reporting any devices that remain deferred */
> +	driver_deferred_probe_report = true;
> +	driver_deferred_probe_trigger();
> +	wait_for_device_probe();
> }
> 
> Also, in my opinion, it will be useful if this debugging feature will be
> optional.

I wonder why you want it optional... so I'm going to guess and cover
both cases I can think of below to head off another round of reply on
this point (sorry if this sucks eggs.)

I don't see it as being optional, because it's going to be cheap to run
in the case of a system which has very few or no errors - which is what
you should have for production systems, right?

Remember, only devices and drivers that are present and have been
probed once get added to the deferred probe list, not devices for
which their drivers are modules.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
