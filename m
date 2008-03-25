From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 10:29:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251024120.4838-100000__6184.96726169742$1206455574$gmane$org@iolanthe.rowland.org>
References: <200803251340.55210.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251340.55210.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Mar 2008, Rafael J. Wysocki wrote:

> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> > > -/*
> > > +/**
> > > + * struct pm_ops - device PM callbacks
> > > + *
> > > =A0 * Several driver power state transitions are externally visible, =
affecting
> > > =A0 * the state of pending I/O queues and (for drivers that touch har=
dware)
> > > =A0 * interrupts, wakeups, DMA, and other hardware state. =A0There ma=
y also be
> > > @@ -122,6 +124,254 @@ typedef struct pm_message {
> > > =A0 * to the rest of the driver stack (such as a driver that's ON gat=
ing off
> > > =A0 * clocks which are not in active use).
> > > =A0 *
> > > + * The externally visible transitions are handled with the help of t=
he following
> > > + * callbacks included in this structure:
> > > + *
> > > + * @prepare: Prepare the device for the upcoming transition, but do =
NOT change
> > > + *=A0=A0=A0=A0=A0its hardware state. =A0Prevent new children of the =
device from being
> > > + *=A0=A0=A0=A0=A0registered and prevent new calls to the probe metho=
d from being made
> > =

> > How is a driver supposed to prevent calls to probe()? You can block in =
probe()
> > or you can fail it, but how do you prevent it from being called? User s=
pace
> > can trigger probe via sysfs.
> =

> I overlooked that.

The driver isn't supposed to prevent calls to its own probe().  The
comment means that the subsystem -- or the rest of the kernel generally
-- is supposed to avoid binding a driver to the device (thereby calling
the probe routine), assuming the device isn't already bound.

I don't expect this sort of thing to be very common.  Mostly it happens
when new kernel modules are loaded and new drivers are registered; we
will have to block module loading during a sleep transition.  It also
happens when the user writes to a driver's "bind" attribute in sysfs;  =

the code there will have to block during a sleep transition.

Alan Stern
