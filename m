From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 15:30:45 +0100
Message-ID: <20151019143045.GE32532@n2100.arm.linux.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
 <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jin
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 19, 2015 at 04:10:56PM +0200, Tomeu Vizoso wrote:
> On 19 October 2015 at 15:18, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Oct 19, 2015 at 02:34:22PM +0200, Tomeu Vizoso wrote:
> >> ... If a device is available and has
> >> a compatible driver, but it cannot be probed because a dependency
> >> isn't going to be available, that's an error and is going to cause
> >> real-world problems unless the device is redundant. Currently we say
> >> nothing because with deferred probe the probe callbacks are also part
> >> of the mechanism that determines the dependency order.
> >
> > So what if device X depends on device Y, and we have a driver for
> > device Y built-in to the kernel, but the driver for device X is a
> > module?
> >
> > I don't see this being solvable in the way you describe above - it's
> > going to identify X as being unable to be satisfied, and report it as
> > an error - but it's not an error at all.
> 
> It's going to probe Y at late_initcall, then probe X when its driver
> is registered. No deferred probes nor messages about it.
> 
> But if you meant to write the opposite case (X built-in and Y in a
> module), then I have to ask you in what situation that would make
> sense.

I did mean the opposite way around.  It may not make sense if you're
targetting a single platform, but it may make sense in a single zImage
kernel.

Consider something like a single zImage kernel that is built with
everything built-in to be able to boot and mount rootfs without
initramfs support on both platform A and platform B.  Both platforms
share some hardware (eg, an I2C GPIO expander) which is built as a
module.  It is a resource provider.  Platform B contains a driver
which is required to boot on platform A, but not platform B (so the
kernel has to have that driver built-in.)  On platform B, there is
a dependency to the I2C GPIO expander device.

> >> Having a specific switch for enabling deferred probe logging sounds
> >> good, but there's going to be hundreds of spurious messages about
> >> deferred probes that were just deferrals and only one of them is going
> >> to be the actual error in which a device failed to find a dependency.
> >
> > Why would there be?  Sounds like something's very wrong there.
> 
> Sorry about that, I have checked that only now and I "only" get 39
> deferred probe messages on exynos5250-snow.

I typically see one or two, maybe five maximum on the platforms I have
here, but normally zero.

> > So, really, after boot and all appropriate modules have been loaded,
> > you should end up with no deferred probes.  Are you saying that you
> > still have "hundreds" at that point?  If you do, that sounds like
> > there's something very wrong.
> 
> I was talking about messages if we log each -EPROBE_DEFER, not devices
> that remain to be probed. The point being that right now we don't have
> a way to know if we are deferring because the dependency will be
> around later, or if we have a problem and the dependency isn't going
> to be there at all.

What's the difference between a dependency which isn't around because
the driver is not built into the kernel but is available as a module,
and a dependency that isn't around because the module hasn't been
loaded yet?

How do you distinguish between those two scenarios?  In the former
scenario, the device will eventually come up when udev loads the
module.  In the latter case, it's a persistent failing case.

> Agreed, with the note from above on why it would be better to only
> print such a message only when the -EPROBE_DEFER is likely to be a
> problem.

... and my argument is that there's _no way_ to know for certain which
deferred probes will be a problem, and which won't.  The only way to
definitely know that is if you disable kernel modules, and require
all drivers to be built into the kernel.

What you can do is print those devices which have failed to probe at
late_initcall() time - possibly augmenting that with reports from
subsystems showing what resources are not available, but that's only
a guide, because of the "it might or might not be in a kernel module"
problem.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
