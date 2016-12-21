From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: BQ27xxx registers
Date: Wed, 21 Dec 2016 13:46:17 +0100
Message-ID: <201612211346.17265@pali>
References: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au> <201612201234.19759@pali> <a354018a-a2e5-f70e-85b1-477a8d349a04@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3749847.QbpnXtOEk8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35733 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbcLUMqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 07:46:21 -0500
In-Reply-To: <a354018a-a2e5-f70e-85b1-477a8d349a04@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chris@lapa.com.au
Cc: afd@ti.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart3749847.QbpnXtOEk8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 21 December 2016 03:49:10 Chris Lapa wrote:
> On 20/12/16 10:34 pm, Pali Roh=C3=A1r wrote:
> > On Tuesday 20 December 2016 07:00:41 Chris Lapa wrote:
> >> I can generate a patch to fix this issue, however the bigger
> >> problem exists as to which revision fuel gauge the
> >> bq27xxx_battery.c driver is intended to support for each family.
> >=20
> > Hi! I think driver should support all revisions. There can be (and
> > probably really is) hardware which uses old revision and such
> > hardware should be still supported...
>=20
> I agree. However due to the register address changes across the
> spectrum of revisions, each revision will have to be specified
> individually. For example, we will need to implement a BQ27510G1,
> BQ27510G2, BQ27510G3, BQ27520G1, BQ27520G2, BQ27520G3, BQ27520G4
> definitions and prospective device tree additions ti,bq27510g1,
> ti,bq27510g2 etc.
>=20
> The other option is to aim for bottom of the barrel support for all
> the devices under the BQ27500 definition but my feeling is it would
> get messier fast and be less maintainable.
>=20
> My preference is to go with the first option if you agree?

Yes. If those chips have different register addresses, then those chips=20
are different. Name, generation or suffix does not matter here.

Similarly there could be chips with different name, but same addresses,=20
so can use one driver/configuration without any change.

So I'm for different name in device tree (or platform data or what is=20
being used) to distinguish between different revisions.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3749847.QbpnXtOEk8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhaeZkACgkQi/DJPQPkQ1LBUACgjW8PfHp4M/jiokHTQM24Zlg9
oJAAn2FwaNnNW/AmMEe2YLc3eCMEpOui
=PKHR
-----END PGP SIGNATURE-----

--nextPart3749847.QbpnXtOEk8--
