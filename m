From: Johannes Berg <johannes@sipsolutions.net>
Subject: hibernate fails to freeze tasks
Date: Mon, 22 Oct 2007 16:22:25 +0200
Message-ID: <1193062945.9793.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8052052768359228404=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============8052052768359228404==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-O+lwDowPGYCisR2OOvo8"


--=-O+lwDowPGYCisR2OOvo8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On my quad powermac, with a current git snapshot, hibernating fails to
freeze tasks and then dumps me a snapshot of the tasks. I've uploaded it
here because it's so long:
http://johannes.sipsolutions.net/files/quad-syslog-hibernate-fails

Haven't found time to look into it yet, any ideas are appreciated.

johannes

--=-O+lwDowPGYCisR2OOvo8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARxyyIKVg1VMiehFYAQL1rg/+NdYnMukB0OTHzVl3Q2zbDIBFC6iBvOL8
8fIxu3j5y4NDSYrZdDdyvansxS+3Aruzjtdy1x/UVDhM1VVA89CoKf7/k9SzUmdD
l7tzeVhmS00M3Y//VvZ/UsrXldEHxP7sd+T/lRys7oi+oqNgOxeRi1jUgMCaX3Cs
FMqY4cWeSQRqQLTwFaSng0twlQ8cJTqag0ejCBkC6NY5cmM5xWKz6bvxD/QcGOPe
BBYm9ZqsFKo//apuZsNOBiWgsP3VzMFBwAAToLA6ZWEEc09OdpUfSY4FR9fUAgdm
YtOJC4nCDJq1fYHAYlWtUTQPTx6YGJjdJpVh7oYR8y3k0ai4rNM2YCpVHEVk2Juz
SxS6e8uyMo/c0zBtwZ/ljAQkt4L8OoVnj77cAspMSQS7ooV0sYCehKsprfircOGB
EJjGzcIdtddPeMhm3XK+zNFlP3xf84efNDpC/hl5JkjnfjdHwUzf4PmR4fG1aJh9
DpCJDA6PV8E8qq5K4GCTpFwgMN8ALqALmjTSGeEmKVLcigA+725CuiZI4kgPwyWQ
iWubhxB5xpI43zvCQWIx+alu087GlfDJ1p5E6Q3n55ZYpLnaR1PZ49BEiZuJzYoj
mPBF/axnYHS7UxgdaweWpYWyHVx7QLm+XPjR2QViOmcP5Q9QOmbWFChEB5R9BkPv
fRiASJwUxX8=
=9b3S
-----END PGP SIGNATURE-----

--=-O+lwDowPGYCisR2OOvo8--


--===============8052052768359228404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8052052768359228404==--
