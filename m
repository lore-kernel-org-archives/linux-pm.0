From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 14:20:52 +0100
Message-ID: <20070322132052.GA7221@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703220042.20471.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703220042.20471.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Runtime device power management or dynamic device power management
> > > (dpm).
> > > =

> > > Why dpm: =

> > >      1. put an idle device into low power state to save power =

> > >      2. speed up S3/S4. In resume time, we could resume devices only =
as
> > >         the devices are used. In suspend time, we could skip suspended
> > >         devices. (suspend/resume a device equals to change device sta=
te)
> =

> Today on system suspend we suspend all devices.
> Today on system resume, we resume all devices.

That's not how it works.

On system suspend, we _tell_ all devices to suspend

If device driver auto-suspended, it will of course not do anything. I
believe we want to keep it designed like that.

> Instead I think we should focus on exporting the appropriate APIs
> so that a management application with platform specific knowledge can
> efficiently get the kernel/drivers to implement its policies.

Please... pick one driver for whatever hardware you like... MMC card
reader in x60? And add runtime suspend/resume to that.

You'll probably find out that no new APIs are needed.

> > > My proposal: =

> > >      1. device=E2=80=99s power parameters. If a device=E2=80=99s powe=
r state depends on
> > >         several parameters, we can map different parameters combining
> > >          to a single index, which looks like ACPI Dx state. In this w=
ay,
> > >         dpm framework and policy have a generic interface to get/set
> > >         device=E2=80=99s state. Each state exports some info, includi=
ng this
> > >         state=E2=80=99s power consumption/latency. Device driver can =
export
> > >         extra info to policy, dpm framework doesn=E2=80=99t handle th=
e extra
> > >         info, but policy can. =

> =

> I don't think it is realistic for devices to export power numbers to user=
-space.
> Sure, it would be great, I just don't think it is realistic.
> =

> Latencies?  maybe.

Not sure about latencies. So open() on soundcard takes few miliseconds
more... userspace will not even notice.

> In general, no API has a chance until somebody actually tries it out
> and programs to it.

Yes... please.

> > >      3. detect if a device is idle. The idea is each device has a busy
> > >         timestamp. Every time the driver wants to handle the device,
> > >         driver will update the timestamp. Policy can poll the timesta=
mp
> > >         to determine if the device is idle. =

> > =

> > That's not how the USB implementation works.  Although a timestamp like =

> > the one you describe is going to be added.
> =

> I sort of like this idea -- it seems that it is low overhead.
> Of course it requires every device driver to be changed.
> Instead we could maybe hook the generic driver entry points
> and do this in the framework -- dunno if that is viable.

No, you can't get around changing all the drivers.

Generic entry points are for _system_ suspend, and if you try to abuse
them for runtime PM, you'll have to audit/change all the drivers.

> > (This is cutting-edge stuff, not all present even in the development
> > trees.  But we're getting there.)
> > =

> > The API design is documented, so far as it exists, by the kerneldoc in =

> > drivers/usb/core/driver.c.
> =

> This is the "intelligent device driver" model -- the driver actually has =
a clue
> and can do the work internally.  Probably we need some combination of this
> plus the simple timeout/user-policy-manager for dumber drivers if we are =
to
> cover the whole system.

You simply turn dumber drivers to more inteligent ones for devices you
care about. As I explained above, you have to touch the drivers
anyway.

Maybe some helpers to make that job easier are possible...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
