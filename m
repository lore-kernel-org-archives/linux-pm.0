From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 14:37:16 +0100
Message-ID: <200803251437.17268.oliver__14699.2165515714$1206452422$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0803241519090.24400-100000@iolanthe.rowland.org>
	<200803251255.31482.oliver@neukum.org>
	<200803251340.55210.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803251340.55210.rjw@sisk.pl>
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

Am Dienstag, 25. M=E4rz 2008 13:40:53 schrieb Rafael J. Wysocki:
> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Montag 24 M=E4rz 2008 schrieb Rafael J. Wysocki:

> > > + *=A0=A0=A0=A0=A0after @prepare() returns. =A0If @prepare() detects =
a situation it cannot
> > > + *=A0=A0=A0=A0=A0handle (e.g. registration of a child already in pro=
gress), it may return
> > > + *=A0=A0=A0=A0=A0-EAGAIN, so that the PM core can execute it once ag=
ain (e.g. after the
> > > + *=A0=A0=A0=A0=A0new child has been registered) to recover from the =
race condition. This
> > > + *=A0=A0=A0=A0=A0method is executed for all kinds of suspend transit=
ions and is followed
> > > + *=A0=A0=A0=A0=A0by one of the suspend callbacks: @suspend(), @freez=
e(), or @poweroff().
> > =

> > This could be understood so that disconnect() cannot be called.
> =

> At what time exactly?

I see no locking that would would prevent disconnect() in the window between
prepare() and suspend()/...
  =

> > > + *=A0=A0=A0=A0=A0The PM core executes @prepare() for all devices bef=
ore starting to
> > > + *=A0=A0=A0=A0=A0execute suspend callbacks for any of them, so drive=
rs may assume all of
> > > + *=A0=A0=A0=A0=A0the other devices to be present and functional whil=
e @prepare() is being
> > > + *=A0=A0=A0=A0=A0executed. =A0However, they may NOT assume anything =
about the availability
> > > + *=A0=A0=A0=A0=A0of the user space at that time.
> > =

> > Probably it should be mentioned that this is the time to allocate memory
> > if you have to.
> =

> Well, not exactly.  Afterwards you cannot use GFP_KERNEL allocations, but
> GFP_NOIO should still work, although for hibernation it's quite possible =
that
> they'll fail if substantial amounts of memory are requested.
> =

> > And it is too late to request firmware. =

> =

> Yes.

This is better documented explicitly.

	Regards
		Oliver
