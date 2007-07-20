From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 23:35:04 +0200
Message-ID: <200707202335.05519.oliver__33415.9738071778$1184967329$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707201608120.2546-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707201608120.2546-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Am Freitag 20 Juli 2007 schrieb Alan Stern:
> On Fri, 20 Jul 2007, Oliver Neukum wrote:
>=20
> > Am Freitag 20 Juli 2007 schrieb Alan Stern:
> > > Some drivers need the ability to schedule. =A0Some will need the ab=
ility=20
> > > to allocate memory (although GFP_ATOMIC is probably sufficient). =A0=
Some=20
> > > will need timers to run.
> >=20
> > Some will have to request firmware. It can add up to some megabytes.
> > In addition, if we don't freeze, some drivers, eg. video drivers, can
> > do allocations in the megabyte range.
> >=20
> > It seems to me that without the freezer we will end up with many driv=
ers
> > needing a two step notification process. Furthermore there are requir=
ements
> > on the order of shutting down system facilities, eg. device addition =
must
> > be stopped before drivers allocate firmware.
>=20
> These are really separate issues, since they refer to things that have=20
> to happen well before the memory snapshot is captured.
>=20
> We already have a pre-suspend notification available for drivers that=20
> need to allocate large amounts of memory.

Is that facility fine grained enough?

> You are correct about the need to delay/stop device addition.  I don't
> know how this can be done in general; each code path calling
> device_add() may have to be treated individually.

What about the old API? Do we have to block module loading?
What happens if a scsi error handler is woken? If it cannot be woken,
how are errors handled?

	Regards
		Oliver
