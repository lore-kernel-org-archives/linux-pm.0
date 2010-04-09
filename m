From: Tony Vroon <tony@linx.net>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Fri, 09 Apr 2010 22:20:27 +0100
Message-ID: <1270848027.3071.0.camel__3037.81365878439$1270848255$gmane$org@localhost>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<20100408094905.GA3948@tiehlicka.suse.cz>
	<201004082243.18393.rjw@sisk.pl> <201004092242.17341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362036479056875258=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004092242.17341.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Michal Hocko <mhocko@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============0362036479056875258==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-LhGhoRgUsXJhAY6xP2i5"


--=-LhGhoRgUsXJhAY6xP2i5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> Please check if the patch below changes anything.
>  drivers/acpi/wakeup.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

That didn't change the behaviour for me, sorry.
(I made sure to go through a full power down session before trying the
patched kernel)

Regards,
--=20
Tony Vroon
UNIX systems administrator
London Internet Exchange Ltd, Trinity Court, Trinity Street,
Peterborough, PE1 1DA
Registered in England number 3137929
E-Mail: tony@linx.net

--=-LhGhoRgUsXJhAY6xP2i5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAku/mhsACgkQp5vW4rUFj5oFtwCdEJewDO5KuuQ4Tbd09adP//xf
gcEAn0e2wNiShRNPAFRBR4YRgvLUF78q
=nmBI
-----END PGP SIGNATURE-----

--=-LhGhoRgUsXJhAY6xP2i5--


--===============0362036479056875258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0362036479056875258==--
