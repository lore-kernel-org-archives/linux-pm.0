From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: BQ27xxx registers
Date: Tue, 20 Dec 2016 12:34:19 +0100
Message-ID: <201612201234.19759@pali>
References: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1760215.LsmGnWy8E9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35648 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbcLTLeW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2016 06:34:22 -0500
In-Reply-To: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chris@lapa.com.au
Cc: afd@ti.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart1760215.LsmGnWy8E9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 20 December 2016 07:00:41 Chris Lapa wrote:
> I can generate a patch to fix this issue, however the bigger problem
> exists as to which revision fuel gauge the bq27xxx_battery.c driver
> is intended to support for each family.

Hi! I think driver should support all revisions. There can be (and=20
probably really is) hardware which uses old revision and such hardware=20
should be still supported...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1760215.LsmGnWy8E9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhZFzsACgkQi/DJPQPkQ1JATQCgybNCdgbOSTkVBvVoOosZrPC1
C4UAmwSNuv0mjIVAODr3qky7QDxq7VpZ
=ug8i
-----END PGP SIGNATURE-----

--nextPart1760215.LsmGnWy8E9--
