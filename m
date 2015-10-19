From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 14:34:22 +0200
Message-ID: <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com> <20151018195330.GB14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151018195330.GB14956@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-pm@vger.kernel.org

On 18 October 2015 at 21:53, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Oct 18, 2015 at 12:37:57PM -0700, Greg Kroah-Hartman wrote:
>> On Sun, Oct 18, 2015 at 08:29:31PM +0100, Mark Brown wrote:
>> > On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote:
>
>> > > I can't see adding calls like this all over the tree just to solve a
>> > > bus-specific problem, you are adding of_* calls where they aren't
>> > > needed, or wanted, at all.
>
>> > This isn't bus specific, I'm not sure what makes you say that?
>
>> You are making it bus-specific by putting these calls all over the tree
>> in different bus subsystems semi-randomly for all I can determine.
>
> Do you mean firmware rather than bus here?  I think that's the confusion
> I have...

Hi all,

hope you don't mind I summarize the points taken instead of replying
to the individual emails. I tried to address all the concerns that
have been raised again in the cover letter, but I guess I did a bad
job at explaining myself, so here's another (more in-depth) go at it.

1) About the sprinkling of calls, everybody agreed it's a bad smell
from the start, but the intention is to modify the behaviour of the
already-DT-specific part of each subsystem without duplicating code.

A way to avoid the sprinkling would be to move the storage and lookup
of resources to the core (using classes and their list of devices to
replace the likes of __of_usb_find_phy). I also like Mark's idea of
calling of_device_probe from of_parse_phandle, which would be much
less invasive but I'm not sure if it would be right to call that
function in all the current cases in which of_parse_phandle is called.

2) About the goal of the series, what matters to my employer is that
once a device defers its probe it's only going to be reprobed in
late_initcall, after all the devices have been tentatively probed
once. In the practice this means that devices get probed in a
dependency order in which first go devices without dependencies then
go up the tree until the leave devices (which tend to be the ones with
effects visible to the user).

This series changes to another dependency order in which when a leaf
node gets probed, it recursively "pulls" its dependencies. This way we
stop massively delaying the probing of the display devices and vendors
can stop carrying sizeable hacks in their trees which just further
reduce the incentive to upstream.

The above is what funds this work, but in my personal opinion the
biggest advantage of this work is that it makes development on
embedded platforms more efficient because right now we don't have a
way of telling if a device deferred its probe because of an ordering
issue, or because there's a problem. If a device is available and has
a compatible driver, but it cannot be probed because a dependency
isn't going to be available, that's an error and is going to cause
real-world problems unless the device is redundant. Currently we say
nothing because with deferred probe the probe callbacks are also part
of the mechanism that determines the dependency order. I have wasted
countless hours hunting for the reason why a device didn't probe and I
have heard the same several times from others.

Having a specific switch for enabling deferred probe logging sounds
good, but there's going to be hundreds of spurious messages about
deferred probes that were just deferrals and only one of them is going
to be the actual error in which a device failed to find a dependency.

3) Regarding total boot time, I don't expect this series to make much
of a difference because though we would save a lot of matching and
querying for resources, that's little time compared with how long we
wait for hardware to react during probing. Async probing is more
likely to help with drivers that take a long time to probe.

4) About the breakage we have seen, that's not caused so far by
probing devices on-demand but by delaying probes until all built-in
drivers have been registered. The latter isn't strictly needed for
on-demand probing but without it most of the benefits are lost because
probes of dependencies are going to be deferred because the drivers
aren't there yet. We could avoid that by registering drivers also
on-demand but we would need to make the matching information available
beforehand, which is a massive change in itself. This should speed up
boot some, and also cause leaf devices to be up earlier.

One more thing about the breakage we have seen so far is that it's
generally caused by implicit dependencies and hunting those is
probably the second biggest timesink of the linux embedded developer
after failed probes. We depend on hacks such as link order, node order
in the DT, initcall gerrymandering and a blind hope in things that
started some time ago to have finished by now. And those implicit
dependencies are often left completely undocumented. This is really
fragile and breaks often when changing something unrelated such as
when adding another revision of a board or soc and a dependency starts
deferring its probe or is delayed because of something else. Also
breaks with async probing.

Delayed probes can be reverted by disabling a Kconfig, so we can fix
those issues in an ordered manner as time allows (we could disable it
by default now and add CI jobs with that enabled during a transitory
period).

Back when I made the series FW-independent with fwnode additions I
felt in my interaction with the ACPI folks that there's a bit of a
chasm in this issue between embedded and non-embedded people. This
could be because with ACPI most of the low-level hw elements such as
clocks, regulators, gpios and pins are hidden from the kernel and are
already ready when we start probing devices. With DT, the kernel has
to initialize all those and only then it can initialize the higher
level devices that depend on them. This means lots more of devices and
dependencies and thus we feel more acutely the shortcomings of the
current device framework at the scale we are using it today.

I think that having all dependencies be explicit and represented in
the device-driver model, along with a more advanced method of ordering
probes is something that would be good to have at this moment, even if
it won't benefit all users of the kernel.

Thanks,

Tomeu
