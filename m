From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Tue, 13 Nov 2007 19:45:33 +0100
Message-ID: <1194979533.4299.5.camel@johannes.berg>
References: <200711041459.23082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2353629889359461058=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711041459.23082.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-pm@vger.kernel.org


--===============2353629889359461058==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MzfBkxbIAWQ+DbO8Q1CP"


--=-MzfBkxbIAWQ+DbO8Q1CP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Sun, 2007-11-04 at 14:59 +0100, Rafael J. Wysocki wrote:
> [Len, please add this patch to the suspend branch, thanks.]
> ---
> From: Johannes Berg <johannes@sipsolutions.net>
>=20
> Lockdep reports a circular locking dependency in the hibernate code
> because
>  - during system boot hibernate code (from an initcall) locks pm_mutex
>    and then a sysfs buffer mutex via name_to_dev_t
>  - during regular operation hibernate code locks pm_mutex under a
>    sysfs buffer mutex because it's called from sysfs methods.

Ping? Do I need to follow this or will somebody take care to merge it
before .24 closes?

Thanks,
Johannes

--=-MzfBkxbIAWQ+DbO8Q1CP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARznwzKVg1VMiehFYAQKUVBAAmOZPHwkF8Xb35MH9rR/glCBAusojVj57
gxcNnTlN/YUm/pqfmx6vlqAjkIhwoHFNBajhROC6hRtxnrg3gnvl4AoIuJ+7bPdD
4QhS4TaEI1enB+jVfoubJ5JgdbFjOOHpZkM7A7a2xN3Yl9waa6gx46ErUeklHEWM
B69SzB/u5eiVJRgv/gHowu/tcUAmRBF4IZt43wgMIicXZcQC/MYwArQLbd4pfMXq
3958dn197sweVSHHYfkbUbDXC2lceA/ZaOawyVO0k4jZ8PDCkQCDjbTpGeitG0hA
O2QpSjB0QvB7dyPe+/OFN+WS5Kc9nPgLyT37Y3ss/JoZ+JLlgOTgpEeqFV5tTzHp
T9SnbpGkR9XnLG7mvA6yyNiZizJnR1jDuicDetAnn6mUL898hZPfL9bvKv7tc/3U
hSSvQnUmY5IMLzHcbyEsgePcR75yX7p+ddj2LZCnpbrwq1CrndWZUfoIdy/y5Fz4
XdptAgAvIkIZKBI0PSzOkmQN5b6ISzzDrc2yzse278O+MdrnhStkv9KbKMkMghRf
Mxo8uM6W0t1bJHCVRUMQ6Nscx+Fza5N2WgHE29dFZVlp5yULDiH9qYry4BgGff28
xU0Ku6Yoa/3h6zdL44Hl9oFz5+qenmlepEGgBMUOy9uKZjw3QXkDnOYG2ES81jgV
e/LskexrsaM=
=rMRn
-----END PGP SIGNATURE-----

--=-MzfBkxbIAWQ+DbO8Q1CP--


--===============2353629889359461058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2353629889359461058==--
