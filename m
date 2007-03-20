From: Johannes Berg <johannes@sipsolutions.net>
Subject: suspend to disk modes, default mode
Date: Tue, 20 Mar 2007 01:47:51 +0100
Message-ID: <1174351671.3645.8.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337254566=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0337254566==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FwhnzPlzxbtzoPwhTP2j"


--=-FwhnzPlzxbtzoPwhTP2j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This suspend to disk modes stuff really sucks. The last time I looked
must have been a long time ago because then shutdown was default. Now I
find that in November 06 you changed it to be platform by default.

The problem with this is that not all platforms support the "platform"
mode.

I have a pm_ops struct for PMU-based Apple powerpc machines that doesn't
set pm_disk_mode in order not to allow the platform mode because that
currently fails.

I also used to think this was for implementing suspend-to-both, is that
wrong? In any case, I can't live with it being platform by default
because that goes into really weird behaviour, or I need to special-case
the ->enter callback for suspend to disk to just shut down again.

Could you please post a patch to change the documentation in pm.h to
indicate what the pm_disk_mode is intended for? It also doesn't help my
willingness to work on and with the generic suspend to disk stuff that
the patch I'm referring to was posted as if it was ACPI specific...

Maybe we just need a pm_disk_modes bitmap and a default_pm_disk_mode
member in struct pm_ops instead? What's firmware vs. platform anyway?

Thanks,
johannes

--=-FwhnzPlzxbtzoPwhTP2j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/y83/ETPhpq3jKURAnTVAKCdhmB62z9Ty3KI2Ah7+nIrIeb7pwCgqAVP
rpYEcLcfgSGEHMqAM6JY0Z4=
=SLb9
-----END PGP SIGNATURE-----

--=-FwhnzPlzxbtzoPwhTP2j--


--===============0337254566==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0337254566==--
