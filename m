From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] rework pm_ops pm_disk_modes foo
Date: Tue, 20 Mar 2007 10:36:47 +0100
Message-ID: <1174383407.3770.3.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1719046847=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320093105.GD3922@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Cliff Brake <cbrake@accelent.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>, Ben Dooks <ben@simtec.co.uk>, Patrick Mochel <mochelp@infinity.powertie.org>
List-Id: linux-pm@vger.kernel.org


--===============1719046847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TqFDx3D+8iAEJPk4WX3h"


--=-TqFDx3D+8iAEJPk4WX3h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-20 at 10:31 +0100, Pavel Machek wrote:

> Is the pm_disk_mode still bitmask? If yes, say so.
>=20
> ...no, it does not appear so.

No, I should have explained. Since the prepare/enter/finish callbacks
aren't told what the chosen pm_disk_mode is, there is no point in
allowing multiple since they can't differentiate. Changing that is
something that could be done, but doesn't seem necessary since ACPI is
the only user.

> Please don't do this. We want to keep the "use platform if available"
> behaviour. [Changing platform->shutdown is really _big_ change,
> independend from any cleanups, and it needs to go separate at the very
> least. It will break some machines.]

As far as I can tell "use platform if available" means "use platform
when ACPI pm_ops are present" since that's the only pm_ops that has
platform. And notice that I change the default when pm_ops are
registered.

If, of course, my assumption about ACPI here is wrong, then some other
pm_ops implementations will need to be changed to have .pm_disk_mode =3D
PM_DISK_PLATFORM.

However, using PM_DISK_PLATFORM by default w/o pm_ops support is *wrong*
as I explained previously since it leads to user-interface
inconsistencies, the user can switch *away* from platform but *not back*
to platform.

johannes

--=-TqFDx3D+8iAEJPk4WX3h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/6sv/ETPhpq3jKURAmtUAJsHYJNgoDCE2jgmrpCaxpCzf8pTSQCfZu6R
JT0ZryeDlhkie9rBr0ghpGU=
=o6Q0
-----END PGP SIGNATURE-----

--=-TqFDx3D+8iAEJPk4WX3h--


--===============1719046847==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1719046847==--
