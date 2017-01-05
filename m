From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 01/11] power: supplies: bq275xx: rename BQ27500 allow
 for deprecation in future.
Date: Fri, 6 Jan 2017 00:59:57 +0100
Message-ID: <20170105235957.jfoffcnlqqpw36vp@earth>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-2-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nc5vhpyztquyu4ii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968792AbdAFABo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Jan 2017 19:01:44 -0500
Content-Disposition: inline
In-Reply-To: <1482451507-37676-2-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--nc5vhpyztquyu4ii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Dec 23, 2016 at 11:04:57AM +1100, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
>=20
> The BQ275XX definition exists only to satisfy backwards compatibility.
>=20
> tested: yes
>=20
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
>
> [...]
>
>  static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16=
 flags)
>  {
> -	if (di->chip =3D=3D BQ27500 || di->chip =3D=3D BQ27541 || di->chip =3D=
=3D BQ27545)
> +	if (di->chip =3D=3D BQ275XX || di->chip =3D=3D BQ27541 || di->chip =3D=
=3D BQ27545)
>  		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
>  	if (di->chip =3D=3D BQ27530 || di->chip =3D=3D BQ27421)
>  		return flags & BQ27XXX_FLAG_OT;

This is really getting out of hands in this patchset. Please
add a patch at the beginning of the patchset, which converts
this construct into the following:

switch (di->chip) {
case A:
case B:
case C:
case D:
    return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
case E:
case F:
    return flags & BQ27XXX_FLAG_OT;
default:
    return false;
}

-- Sebastian

--nc5vhpyztquyu4ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhu3fcACgkQ2O7X88g7
+po2JQ//V1y12V0G0zy0T3H2seuiEMeZBYoiS50SMNpPXNYqLnV+hhEfGG+HmKvc
QcETa7Q1k0Hqhri7FrP/mJrQGEPFKI9tcWwpeLXdzrHzgseGOhrZ+3B/lWtemshe
XEuLQfxqeSGLnI76fMDu9kdnwU+xyc60QhoIFp34BsVTfAB10oy9wr7zmAWjo2PK
Wl9RnxEXA1UOKpfrd/6bGe6aIHLFP5vNzT9yXzSByeEyI3NYS/ASE5SRXB6/3hLL
+PxYDz+foer6qAkGC5HgLxVIhC09dzXW5ShwAwjagpo0yr29rbBkxwtNe6iHiAdB
QobjeXQ2zKZikNIqiXUfMmsiCDNY5bL3ryyE104z50dDJBVHUYi3REDiRqLY9L28
qNB/Bpuo2Cz9XkI97F6OFcMmAksdNtQe8T+nVHG1txlnSI84XUQyX0Gc3kjIywQ9
OM8eoXh112v5gN2F6IC2fqisuyaceIIplI8lySmfiQPX9KWG0WXJBNUu+bWqeB63
kq+Aaug92kTlnh5bj8+sb/DTM8yD6doTErHezxPfgBdXLGjU4DQqJzx+gI2qYsLo
vyQNcMAQ4kFwCrq/a7t8QcwGGS3I7X2agnv/WstITgyrLGaqjXW16iobRmv0g7GS
JGq+/iByrMKK7d4MhDOHPoxFRn2vFOBruYzDC3lcxaa5CGtznNw=
=gkpP
-----END PGP SIGNATURE-----

--nc5vhpyztquyu4ii--
