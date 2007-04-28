From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Sat, 28 Apr 2007 08:40:44 +0200
Message-ID: <1177742445.3448.3.camel@johannes.berg>
References: <200703221800.l2MI0tBW026306@shell0.pdx.osdl.net>
	<1177711880.3565.79.camel@johannes.berg>
	<20070427155530.9d589078.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7175107517701572034=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427155530.9d589078.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pavel@ucw.cz, linux-pm@lists.linux-foundation.org, rmk@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org


--===============7175107517701572034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VhOfa3P5m01Mbx1AO5N2"


--=-VhOfa3P5m01Mbx1AO5N2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 15:55 -0700, Andrew Morton wrote:

> In which case I'll move
>=20
> rework-pm_ops-pm_disk_mode-kill-misuse.patch
> power-management-remove-firmware-disk-mode.patch
> power-management-implement-pm_opsvalid-for-everybody.patch
> power-management-force-pm_opsvalid-callback-to-be.patch
>=20
> to head-of-queue.

Thanks, much appreciated. If there are any problems the first one is the
only patch my other patches really depend on, the others are just
cleanups I made while in that area to ensure the mess doesn't
proliferate again.

johannes

--=-VhOfa3P5m01Mbx1AO5N2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD4DBQBGMuxs/ETPhpq3jKURAhbXAJd6S55RizdDGuQiWMnGLlqvTq3IAJ0bmZNa
Y0mE0TTqnpb+GjwjEvAxOw==
=yXuy
-----END PGP SIGNATURE-----

--=-VhOfa3P5m01Mbx1AO5N2--


--===============7175107517701572034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7175107517701572034==--
