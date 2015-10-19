From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 16:10:56 +0200
Message-ID: <CAAObsKDS_+AZ26P_fHc6pvAYrQotsuoO0DEGQUWC514t3DD_jQ@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk> <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <20151019131821.GA32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151019131821.GA32532-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jingo
List-Id: linux-pm@vger.kernel.org

On 19 October 2015 at 15:18, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Mon, Oct 19, 2015 at 02:34:22PM +0200, Tomeu Vizoso wrote:
>> ... If a device is available and has
>> a compatible driver, but it cannot be probed because a dependency
>> isn't going to be available, that's an error and is going to cause
>> real-world problems unless the device is redundant. Currently we say
>> nothing because with deferred probe the probe callbacks are also part
>> of the mechanism that determines the dependency order.
>
> So what if device X depends on device Y, and we have a driver for
> device Y built-in to the kernel, but the driver for device X is a
> module?
>
> I don't see this being solvable in the way you describe above - it's
> going to identify X as being unable to be satisfied, and report it as
> an error - but it's not an error at all.

It's going to probe Y at late_initcall, then probe X when its driver
is registered. No deferred probes nor messages about it.

But if you meant to write the opposite case (X built-in and Y in a
module), then I have to ask you in what situation that would make
sense.

>> Having a specific switch for enabling deferred probe logging sounds
>> good, but there's going to be hundreds of spurious messages about
>> deferred probes that were just deferrals and only one of them is going
>> to be the actual error in which a device failed to find a dependency.
>
> Why would there be?  Sounds like something's very wrong there.

Sorry about that, I have checked that only now and I "only" get 39
deferred probe messages on exynos5250-snow.

> You should only get deferred probes for devices which are declared to
> be present, but their resources have not yet been satisfied.  It
> doesn't change anything if you have a kernel with lots of device drivers
> or just the device drivers you need - the device drivers you don't need
> do not contribute to the deferred probing in any way.

I don't think that the number of registered drivers affects the number
of probes that get deferred (but I'm not sure why you mention that).

> So, really, after boot and all appropriate modules have been loaded,
> you should end up with no deferred probes.  Are you saying that you
> still have "hundreds" at that point?  If you do, that sounds like
> there's something very wrong.

I was talking about messages if we log each -EPROBE_DEFER, not devices
that remain to be probed. The point being that right now we don't have
a way to know if we are deferring because the dependency will be
around later, or if we have a problem and the dependency isn't going
to be there at all.

If we had a way to enable printing the cause of each -EPROBE_DEFER,
right now that would print 39 messages of this board that are only due
to ordering. The actual issue would be printed in exactly the same way
somewhere in the middle.

>> 3) Regarding total boot time, I don't expect this series to make much
>> of a difference because though we would save a lot of matching and
>> querying for resources, that's little time compared with how long we
>> wait for hardware to react during probing. Async probing is more
>> likely to help with drivers that take a long time to probe.
>
> For me, on my fastest ARM board, though running serial console:
>
> [    2.293468] VFS: Mounted root (ext4 filesystem) on device 179:1.
>
> There's a couple of delays in there, but they're not down to deferred
> probing.  The biggest one is serial console startup (due to the time
> it takes to write out the initial kernel messages):
>
> [    0.289962] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 23, base_baud = 15625000) is a 16550A
> [    0.944124] console [ttyS0] enabled
>
> and DSA switch initialisation:
>
> [    1.530655] libphy: dsa slave smi: probed
> [    2.034426] dsa dsa@0 lan6 (uninitialized): attached PHY at address 0 [Generic PHY]
>
> I'm not sure what causes that, but at a guess it's having to talk to the
> DSA switch over the MDIO bus via several layers of indirect accesses.
> Of course, serial console adds to the boot time significantly anyway,
> especially at the "standard" kernel logging level.

Yes, I don't think it makes any sense to measure boot times with the
serial console on, because it's not comparable to production and
because printing an additional line during boot affects significantly
the times.

To be clear, I was saying that this series should NOT affect total
boot times much.

>> One more thing about the breakage we have seen so far is that it's
>> generally caused by implicit dependencies and hunting those is
>> probably the second biggest timesink of the linux embedded developer
>> after failed probes.
>
> ... which is generally caused by the crappy code which the average
> embedded Linux developer creates, particularly with the crappy error
> messages they like creating.  For the most part, they _might_ as well
> just print "Error!\n" and be done with it, for all the use they are.
> When creating an error print, your average embedded Linux developer
> fails to print the _reason_ why something failed, which makes debugging
> it much harder.
>
> The first thing I do when I touch code that needs this kind of debugging
> is to go through and add printing of the error code.  That normally lets
> me quickly narrow down what's failed.
>
> If embedded Linux developers are struggling with this, they only have
> themselves to blame.
>
> In the case of deferred probing, what _may_ help is if we got rid of the
> core code printing that driver X requested deferred probing, instead
> moving the responsibility to report this onto the driver or subsystem.
> Resource claiming generally has the struct device, and can use dev_warn()
> to report which device is being probed, along with which resource is
> not yet available.

Agreed, with the note from above on why it would be better to only
print such a message only when the -EPROBE_DEFER is likely to be a
problem.

> This debug problem is solvable without needing to resort to complex
> probing solutions.

If you really think anything in this series is complex, you should
look at the other ones that tried to accomplish the same!

Thanks,

Tomeu

> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
