From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: Resume hanging on MSI motherboard
Date: Fri, 23 Jul 2010 13:58:05 +0200
Message-ID: <20100723135805.57358845@mjolnir.ossman.eu>
References: <20091204081739.575b29d5@mjolnir.ossman.eu>
	<200912081338.56941.rjw@sisk.pl>
	<20091208233553.498e1442@mjolnir.ossman.eu>
	<200912082343.30195.rjw@sisk.pl>
	<20100723124023.75e53814@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0150121061233135745=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100723124023.75e53814@mjolnir.ossman.eu>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0150121061233135745==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-6972-1279886290-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-6972-1279886290-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Jul 2010 12:40:23 +0200
Pierre Ossman <pierre-list@ossman.eu> wrote:

>=20
> 2. Machine fails to wake properly using the IR remote. This works fine
> in Windows, but not in Linux. As this is a HTPC, this is pretty crucial
> for everything to come together. :/
>=20

Solved.

Apparently I should have paid attention to those messages
about /proc/acpi/wakeup being deprecated. Using power/wakeup on the
relevant device worked so much better. ;)

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-6972-1279886290-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iF4EAREIAAYFAkxJg9AACgkQopDLsoqlmELuRwEAvJ7hjQ/cgps5FwL/4v6GOXMZ
YEsCSvpJeSBc17mza+IBAJqa8S09kXycIEY/o+8q9RFMt3r2t5Pv0Eqdf9oLgQHw
=t7et
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-6972-1279886290-0001-2--

--===============0150121061233135745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0150121061233135745==--
