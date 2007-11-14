From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Wed, 14 Nov 2007 13:52:01 +0100
Message-ID: <1195044721.6924.16.camel@twins>
References: <200711041459.23082.rjw@sisk.pl>
	<1194979533.4299.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1776177450119685901=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194979533.4299.5.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============1776177450119685901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7sBixq1sxsYzffLP/GfN"


--=-7sBixq1sxsYzffLP/GfN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2007-11-13 at 19:45 +0100, Johannes Berg wrote:
> On Sun, 2007-11-04 at 14:59 +0100, Rafael J. Wysocki wrote:
> > [Len, please add this patch to the suspend branch, thanks.]
> > ---
> > From: Johannes Berg <johannes@sipsolutions.net>
> >=20
> > Lockdep reports a circular locking dependency in the hibernate code
> > because
> >  - during system boot hibernate code (from an initcall) locks pm_mutex
> >    and then a sysfs buffer mutex via name_to_dev_t
> >  - during regular operation hibernate code locks pm_mutex under a
> >    sysfs buffer mutex because it's called from sysfs methods.
>=20
> Ping? Do I need to follow this or will somebody take care to merge it
> before .24 closes?

I can feed it to Linus through the lockdep tree if Len hasn't picked it
up yet, Len?

--=-7sBixq1sxsYzffLP/GfN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOu9xXA2jU0ANEf4RAnD5AJ9CwrwAHr5QRkxte5eLrHI6Nay4kgCfZMfV
9uEl3SCsP4TmWWG13HHx7KY=
=ICb3
-----END PGP SIGNATURE-----

--=-7sBixq1sxsYzffLP/GfN--


--===============1776177450119685901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1776177450119685901==--
