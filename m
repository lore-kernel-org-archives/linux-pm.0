From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 14:18:21 +0100
Message-ID: <20151019131821.GA32532@n2100.arm.linux.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jin
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 02:34:22PM +0200, Tomeu Vizoso wrote:
> ... If a device is available and has
> a compatible driver, but it cannot be probed because a dependency
> isn't going to be available, that's an error and is going to cause
> real-world problems unless the device is redundant. Currently we say
> nothing because with deferred probe the probe callbacks are also part
> of the mechanism that determines the dependency order.

So what if device X depends on device Y, and we have a driver for
device Y built-in to the kernel, but the driver for device X is a
module?

I don't see this being solvable in the way you describe above - it's
going to identify X as being unable to be satisfied, and report it as
an error - but it's not an error at all.

> Having a specific switch for enabling deferred probe logging sounds
> good, but there's going to be hundreds of spurious messages about
> deferred probes that were just deferrals and only one of them is going
> to be the actual error in which a device failed to find a dependency.

Why would there be?  Sounds like something's very wrong there.

You should only get deferred probes for devices which are declared to
be present, but their resources have not yet been satisfied.  It
doesn't change anything if you have a kernel with lots of device drivers
or just the device drivers you need - the device drivers you don't need
do not contribute to the deferred probing in any way.

So, really, after boot and all appropriate modules have been loaded,
you should end up with no deferred probes.  Are you saying that you
still have "hundreds" at that point?  If you do, that sounds like
there's something very wrong.

> 3) Regarding total boot time, I don't expect this series to make much
> of a difference because though we would save a lot of matching and
> querying for resources, that's little time compared with how long we
> wait for hardware to react during probing. Async probing is more
> likely to help with drivers that take a long time to probe.

For me, on my fastest ARM board, though running serial console:

[    2.293468] VFS: Mounted root (ext4 filesystem) on device 179:1.

There's a couple of delays in there, but they're not down to deferred
probing.  The biggest one is serial console startup (due to the time
it takes to write out the initial kernel messages):

[    0.289962] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 23, base_baud = 15625000) is a 16550A
[    0.944124] console [ttyS0] enabled

and DSA switch initialisation:

[    1.530655] libphy: dsa slave smi: probed
[    2.034426] dsa dsa@0 lan6 (uninitialized): attached PHY at address 0 [Generic PHY]

I'm not sure what causes that, but at a guess it's having to talk to the
DSA switch over the MDIO bus via several layers of indirect accesses.
Of course, serial console adds to the boot time significantly anyway,
especially at the "standard" kernel logging level.

> One more thing about the breakage we have seen so far is that it's
> generally caused by implicit dependencies and hunting those is
> probably the second biggest timesink of the linux embedded developer
> after failed probes.

... which is generally caused by the crappy code which the average
embedded Linux developer creates, particularly with the crappy error
messages they like creating.  For the most part, they _might_ as well
just print "Error!\n" and be done with it, for all the use they are.
When creating an error print, your average embedded Linux developer
fails to print the _reason_ why something failed, which makes debugging
it much harder.

The first thing I do when I touch code that needs this kind of debugging
is to go through and add printing of the error code.  That normally lets
me quickly narrow down what's failed.

If embedded Linux developers are struggling with this, they only have
themselves to blame.

In the case of deferred probing, what _may_ help is if we got rid of the
core code printing that driver X requested deferred probing, instead
moving the responsibility to report this onto the driver or subsystem.
Resource claiming generally has the struct device, and can use dev_warn()
to report which device is being probed, along with which resource is
not yet available.

This debug problem is solvable without needing to resort to complex
probing solutions.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
