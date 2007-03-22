From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 00:42:20 -0400
Message-ID: <200703220042.20471.lenb@kernel.org>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Monday 19 March 2007 11:44, Alan Stern wrote:
> On Mon, 19 Mar 2007, Shaohua Li wrote:
> =

> > Runtime device power management or dynamic device power management
> > (dpm).
> > =

> > Why dpm: =

> >      1. put an idle device into low power state to save power =

> >      2. speed up S3/S4. In resume time, we could resume devices only as
> >         the devices are used. In suspend time, we could skip suspended
> >         devices. (suspend/resume a device equals to change device state)

Today on system suspend we suspend all devices.
Today on system resume, we resume all devices.
In the future we need to recognize that upon system suspend,
some devices are already suspended.
We need to remember that, so upon resume we can restove
them to their suspended state, rather than blindly resuming everything.

> > Basically we need device driver support, a kernel framework and a policy
> > (determine when to change a device=E2=80=99s power state).
> =

> A lot of development along these lines has already been going on in the =

> USB subsystem.  It isn't complete yet, but a lot of the ideas you raise =

> have already been implemented.

Of course we should avoid the acronym "DPM",
as that already means something else:-)

> > I think we need answer below questions:
> > 1. How to present device=E2=80=99s power info/control interface to poli=
cy.
> > Unlike ACPI Dx state, a device=E2=80=99s power state might depend on se=
veral
> > parameters, like voltage/clock. We must change several parameters in the
> > meantime to switch device=E2=80=99s power state.

> > 2. How to handle devices dependences. For example, for a PCI endpoint
> > and a pci bridge above the pci endpoint, we should suspend pci endpoint
> > device first and then suspend pci bridge and vice versa in resume. On
> > the other hand, two devices might not have such relationship. Two
> > devices might haven=E2=80=99t any bus relationship. Eg, in embedded sys=
tem, a
> > clock might drive several devices under different buses.

The embedded devices which have a lot of complicated
platform specific dependencies.  These devices effectively get
a custom distribution -- custom kernel, and custom management application.

I think we'd create a big mess if we try to figure out these dependencies
at boot time with generic kernel code that runs on everything.

Instead I think we should focus on exporting the appropriate APIs
so that a management application with platform specific knowledge can
efficiently get the kernel/drivers to implement its policies.

I think that for laptops/desktops/servers with industry standard
components we _do_ need the generic kernel to figure out the dependencies
at boot time.

> > 3. How to detect if a device is idle.
> =

> These issues are where you are liable to run into trouble.  There are =

> extremely dependent on the type of platform, bus, and device.  USB is =

> particularly simple in this respect.
> =

> > 4. where should policy be, kernel/userspace. Userspace policy is
> > flexible, but userspace policy has some limitations like being swapped
> > out. The limitations don=E2=80=99t impact suspend device, but resume de=
vice
> > should be quick, eg suspended device should be resumed quickly soon
> > after new service request is coming.
> > =

> > My proposal: =

> >      1. device=E2=80=99s power parameters. If a device=E2=80=99s power =
state depends on
> >         several parameters, we can map different parameters combining
> >          to a single index, which looks like ACPI Dx state. In this way,
> >         dpm framework and policy have a generic interface to get/set
> >         device=E2=80=99s state. Each state exports some info, including=
 this
> >         state=E2=80=99s power consumption/latency. Device driver can ex=
port
> >         extra info to policy, dpm framework doesn=E2=80=99t handle the =
extra
> >         info, but policy can. =


I don't think it is realistic for devices to export power numbers to user-s=
pace.
Sure, it would be great, I just don't think it is realistic.

Latencies?  maybe.

In general, no API has a chance until somebody actually tries it out
and programs to it.

> >      2. The device dependence varies from different systems especially
> >         for embedded system. The idea is dpm framework handles device
> >         dependence (like, resume a device=E2=80=99s parent before resum=
e the
> >         device itself), and policy inputs the dependence data to dpm
> >         framework. As device dependence exists, device driver shouldn=
=E2=80=99t
> >         directly resume a device. Instead, let dpm framework resumes the
> >         device and handle dependence in the meantime. To input
> >         dependence data, policy should know device=E2=80=99s unique nam=
e and dpm
> >         framework can get corresponding dpm device from the name.
> >         Different buses have different device naming methods. To assign
> >         a unified name to each device, I just give each device an id
> >         regardless which bus the device is on. =


I'm skeptical about an additional framework in the kernel to track
dependencies, as I don't think we should even try to track embedded system
dependencies in the kernel.  For laptop/desktop/server, perhaps we can
focus on making the existing device tree be 90% of what we need and
augment it with the missing 10%, like the relationship between
PCI devices and the devices that control hotplug on the slots
that they're plugged into...

> >      3. detect if a device is idle. The idea is each device has a busy
> >         timestamp. Every time the driver wants to handle the device,
> >         driver will update the timestamp. Policy can poll the timestamp
> >         to determine if the device is idle. =

> =

> That's not how the USB implementation works.  Although a timestamp like =

> the one you describe is going to be added.

I sort of like this idea -- it seems that it is low overhead.
Of course it requires every device driver to be changed.
Instead we could maybe hook the generic driver entry points
and do this in the framework -- dunno if that is viable.

> >      4. policy position. The idea is policy resides on userspace. Dpm
> >         framework exports device=E2=80=99s busy timestamp, state info,
> >         dependence setting to userspace. According to the info, policy
> >         suspends a device in specific time. Resuming a device is
> >         directly done by dpm framework in kernel.
> =

> In USB, we export the idle-time delay value (device is autosuspended =

> when it has been idle longer than this) and an administrative power-level =

> atttribute: on, auto, or suspend.  When set to "on" the device will not =

> autosuspend; when set to "auto" the device will autosuspend and autoresum=
e =

> according to the delay setting; when set to "suspend" the device will be =

> suspended and will not autoresume.
> =

> (This is cutting-edge stuff, not all present even in the development
> trees.  But we're getting there.)
> =

> The API design is documented, so far as it exists, by the kerneldoc in =

> drivers/usb/core/driver.c.

This is the "intelligent device driver" model -- the driver actually has a =
clue
and can do the work internally.  Probably we need some combination of this
plus the simple timeout/user-policy-manager for dumber drivers if we are to
cover the whole system.

-Len
