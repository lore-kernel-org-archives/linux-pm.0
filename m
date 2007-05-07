From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC][PATCH] swsusp: Reduce code duplication between
	user.c and disk.c
Date: Mon, 07 May 2007 13:43:11 +0200
Message-ID: <1178538191.7261.13.camel__12366.6676613086$1178538252$gmane$org@johannes.berg>
References: <200705052227.14265.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2005819484529829348=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705052227.14265.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>
List-Id: linux-pm@vger.kernel.org


--===============2005819484529829348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8QMwLgBnJW5JXpT5Ygzl"


--=-8QMwLgBnJW5JXpT5Ygzl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> However, this modifies the user-observable behavior in such a way that
> if the user sets 'shutdown mode =3D platform' in the s2disk's configurati=
on file,
> the kernel will use the hibernation mode resulting from the sysfs interfa=
ce
> settings.  That is, if there is 'shutdown mode =3D platform' in the s2dis=
k's
> configuration file, but the hibernation mode is set to 'reboot' in the sy=
sfs
> interface, the system will be rebooted instead of going for the 'ACPI S0-=
>S4
> transition'.

This I don't understand. Without looking at the code, it seems that
you're invoking some common code that checks the sysfs file. Couldn't
those functions take an argument instead? Or even kill off the ioctl
interface completely and just use whatever was in the sysfs file (and
change userland to change the sysfs file). There isn't much point in
having two separate configuration entries for one thing, imho.

johannes

--=-8QMwLgBnJW5JXpT5Ygzl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGPxDO/ETPhpq3jKURAjcWAKCva4qWX/Z7C8pVy/cELhZ2aJ66GACdHdLX
HSqck6MUF0XgTvpBx/RTXC0=
=+3SI
-----END PGP SIGNATURE-----

--=-8QMwLgBnJW5JXpT5Ygzl--


--===============2005819484529829348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2005819484529829348==--
