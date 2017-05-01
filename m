From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 04/14] power: max17042_battery: Add default
 platform_data fallback data
Date: Mon, 1 May 2017 13:37:39 +0200
Message-ID: <20170501113739.36xmeuqu5ecls7xx@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncymr725rl3kz6de"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756695AbdEALhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:37:43 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-4-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--ncymr725rl3kz6de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:49PM +0200, Hans de Goede wrote:
> Some x86 machines use a max17047 fuel-gauge and x86 might be missing
> platform_data if not provided by SFI.
>=20
> This commit adds default platform_data as fallback option so that the
> driver can work on boards where no platform_data is provided.
>=20
> Since not all boards have a thermistor hooked up, set temp_min to 0 and
> change the health checks from temp <=3D temp_min to temp < temp_min to
> not trigger on such boards (where temp reads 0).
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--ncymr725rl3kz6de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHgMACgkQ2O7X88g7
+prXmQ/7BB27X2gEgI9CHzQZbolAGgDS138ZvVxkM4M4mezjTeIEN/A2gRVT2hOP
4a+/B3beZHvcFhDEq02tFPD2F6hbsL6brEy+6LXGhtHAu2w6Uhvrju+e//5hZfh1
yE8wrVYi7makz+hHnBZ1M8zKK0dLIFHq5arNPPzqHf0iXRHFGRgKw+lDuAcHJiHz
OVrI+1oJ2xv3BHKzMS5Tibf8QRwcFbiMza9hCMgnhm0g17+aYYaxUbjcgLvUsykm
v7/8D7DZEmTWicXdwHjWnUxSh6TIhCckGvksoWOihkV1M4Zuy31341Fz/9cwQ671
ORJsHQkJLDbS4wrUWGYPYyNtElQKci9E/J4C5S5Bf/H/QZpZT+3gv9wxFqJm3KC4
xzUsTtaDLjHK4L1NCykCjqljAoTWEQaQ0l9DGYilyD9c1qAaI8UgsMiSKLn0ahOT
xq0FwoBvFDo72i4M1shRh4jyNj/30bHdYjEc/5iTO7BaUw9FM9oEPdMHDid9L6wM
7Gs+sw/QFY6motrD37H7KSkKTTp3oRHlnPnA5nR0qz6M2KCiayPTYU3oS6Dn2ez3
+rDkk5THIkR9+Fyhtw1TSCYIyNmU1/BOorGdszgpur3ogZukQKmVuYSiOnQXuPOs
5wLd81QWrXXv/sb8FfPTf7jxpGM0b3rrUfKxfSA7egF9aCK/CiI=
=TyD+
-----END PGP SIGNATURE-----

--ncymr725rl3kz6de--
