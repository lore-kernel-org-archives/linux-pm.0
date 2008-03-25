From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 13:40:53 +0100
Message-ID: <200803251340.55210.rjw__44914.3918267966$1206449098$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803241519090.24400-100000@iolanthe.rowland.org>
	<200803242318.21052.rjw@sisk.pl>
	<200803251255.31482.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251255.31482.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> > -/*
> > +/**
> > + * struct pm_ops - device PM callbacks
> > + *
> > =A0 * Several driver power state transitions are externally visible, af=
fecting
> > =A0 * the state of pending I/O queues and (for drivers that touch hardw=
are)
> > =A0 * interrupts, wakeups, DMA, and other hardware state. =A0There may =
also be
> > @@ -122,6 +124,254 @@ typedef struct pm_message {
> > =A0 * to the rest of the driver stack (such as a driver that's ON gatin=
g off
> > =A0 * clocks which are not in active use).
> > =A0 *
> > + * The externally visible transitions are handled with the help of the=
 following
> > + * callbacks included in this structure:
> > + *
> > + * @prepare: Prepare the device for the upcoming transition, but do NO=
T change
> > + *=A0=A0=A0=A0=A0its hardware state. =A0Prevent new children of the de=
vice from being
> > + *=A0=A0=A0=A0=A0registered and prevent new calls to the probe method =
from being made
> =

> How is a driver supposed to prevent calls to probe()? You can block in pr=
obe()
> or you can fail it, but how do you prevent it from being called? User spa=
ce
> can trigger probe via sysfs.

I overlooked that.

> To be useful to driver writers, this has to be clarified.

The comment is supposed to mean that probe() should be prevented from runni=
ng
(i.e. even if it's executed, it should either fail or block).  I'll write i=
t this way.

> > + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() detects a =
situation it cannot
> > + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in progr=
ess), it may return
> > + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it once agai=
n (e.g. after the
> > + *=A0=A0=A0=A0=A0new child has been registered) to recover from the ra=
ce condition. This
> > + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend transitio=
ns and is followed
> > + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @freeze(=
), or @poweroff().
> =

> This could be understood so that disconnect() cannot be called.

At what time exactly?
 =

> > + *=A0=A0=A0=A0=A0The PM core executes @prepare() for all devices befor=
e starting to
> > + *=A0=A0=A0=A0=A0execute suspend callbacks for any of them, so drivers=
 may assume all of
> > + *=A0=A0=A0=A0=A0the other devices to be present and functional while =
@prepare() is being
> > + *=A0=A0=A0=A0=A0executed. =A0However, they may NOT assume anything ab=
out the availability
> > + *=A0=A0=A0=A0=A0of the user space at that time.
> =

> Probably it should be mentioned that this is the time to allocate memory
> if you have to.

Well, not exactly.  Afterwards you cannot use GFP_KERNEL allocations, but
GFP_NOIO should still work, although for hibernation it's quite possible th=
at
they'll fail if substantial amounts of memory are requested.

> And it is too late to request firmware. =


Yes.

Thanks,
Rafael
