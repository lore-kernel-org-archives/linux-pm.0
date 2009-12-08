From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: Resume hanging on MSI motherboard
Date: Tue, 8 Dec 2009 23:35:53 +0100
Message-ID: <20091208233553.498e1442@mjolnir.ossman.eu>
References: <20091204081739.575b29d5@mjolnir.ossman.eu>
	<20091208090327.3ac443e9@mjolnir.ossman.eu>
	<200912081338.56941.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9210575759348925145=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912081338.56941.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============9210575759348925145==
Content-Type: multipart/signed; micalg=PGP-SHA1; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-5656-1260311759-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-5656-1260311759-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Dec 2009 13:38:56 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday 08 December 2009, Pierre Ossman wrote:
> > Anyone?
>=20
> Sorry, it's just difficult to advise something in this case.
>=20
> You can try to use the /sys/power/pm_test tests to see if the problem is
> related to the drivers (it is described in
> Documentation/power/basic-pm-debugging.txt), but I bet it's not.
>=20

Yeah, that test went through just fine.

Any ideas as to why pm_trace isn't working though?

And any common incantations that appease buggy ACPI implementations?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-5656-1260311759-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkse1MsACgkQ7b8eESbyJLhcAwCfeI7qAdMCZ2gxJdkZbo7GNK5T
1YYAn3L00aTqZvPuBsJqLs4RukS4Raeu
=6frg
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-5656-1260311759-0001-2--

--===============9210575759348925145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9210575759348925145==--
