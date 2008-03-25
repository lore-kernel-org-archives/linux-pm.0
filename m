From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 12:55:30 +0100
Message-ID: <200803251255.31482.oliver__29435.8345018283$1206446248$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0803241519090.24400-100000@iolanthe.rowland.org>
	<200803242318.21052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803242318.21052.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:
> -/*
> +/**
> + * struct pm_ops - device PM callbacks
> + *
> =A0 * Several driver power state transitions are externally visible, affe=
cting
> =A0 * the state of pending I/O queues and (for drivers that touch hardwar=
e)
> =A0 * interrupts, wakeups, DMA, and other hardware state. =A0There may al=
so be
> @@ -122,6 +124,254 @@ typedef struct pm_message {
> =A0 * to the rest of the driver stack (such as a driver that's ON gating =
off
> =A0 * clocks which are not in active use).
> =A0 *
> + * The externally visible transitions are handled with the help of the f=
ollowing
> + * callbacks included in this structure:
> + *
> + * @prepare: Prepare the device for the upcoming transition, but do NOT =
change
> + *=A0=A0=A0=A0=A0its hardware state. =A0Prevent new children of the devi=
ce from being
> + *=A0=A0=A0=A0=A0registered and prevent new calls to the probe method fr=
om being made

How is a driver supposed to prevent calls to probe()? You can block in prob=
e()
or you can fail it, but how do you prevent it from being called? User space
can trigger probe via sysfs. To be useful to driver writers, this has
to be clarified.

> + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() detects a si=
tuation it cannot
> + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in progres=
s), it may return
> + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it once again =
(e.g. after the
> + *=A0=A0=A0=A0=A0new child has been registered) to recover from the race=
 condition. This
> + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend transitions=
 and is followed
> + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @freeze(),=
 or @poweroff().

This could be understood so that disconnect() cannot be called.

> + *=A0=A0=A0=A0=A0The PM core executes @prepare() for all devices before =
starting to
> + *=A0=A0=A0=A0=A0execute suspend callbacks for any of them, so drivers m=
ay assume all of
> + *=A0=A0=A0=A0=A0the other devices to be present and functional while @p=
repare() is being
> + *=A0=A0=A0=A0=A0executed. =A0However, they may NOT assume anything abou=
t the availability
> + *=A0=A0=A0=A0=A0of the user space at that time.

Probably it should be mentioned that this is the time to allocate memory
if you have to. And it is too late to request firmware.

	Regards
		Oliver
