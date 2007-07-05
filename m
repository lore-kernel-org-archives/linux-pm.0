From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 22:40:05 +0200
Message-ID: <200707052240.05950.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0707051546010.4198-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707051546010.4198-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> On Thu, 5 Jul 2007, Oliver Neukum wrote:
>=20
> > Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> > > Allow me to rephrase. =A0You seem to be saying that /sys/.../power/=
wakeup=20
> > > should be able to hold four different values:
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A01. always disabled
> > > =A0=A0=A0=A0=A0=A0=A0=A02. always enabled
> > > =A0=A0=A0=A0=A0=A0=A0=A03. enabled at runtime but not during system=
 sleep
> > > =A0=A0=A0=A0=A0=A0=A0=A04. enabled during system sleep but not at r=
untime
> > >=20
> > > Right? =A0With the default being 3 (except for a few things like th=
e=20
> > > power button).
> > >=20
> > > Or maybe there should be two attribute files: wakeup (used during
> > > system sleep) and wakeup_runtime (used for runtime suspend).
> > >=20
> > > Comments from anybody else?
> >=20
> > I am not sure we ever want to do runtime suspend without remote wakeu=
p.
>=20
> You mean the user shouldn't be able to disable remote wakeup during a
> runtime suspend?  But what if the user wants to put the device to sleep
> with no possibility of wakeup?

Then the user will have to force suspend anyway and we can use the existi=
ng
attribute. Two points:

1. For hubs I don't think we should allow it
2. The important distinction is not between system wide vs. device,
but between forced sleep and the "best effort" runtime suspension
in style of autosuspend. The latter needs remote wakeup under control
of the driver.

	Regards
		Oliver
