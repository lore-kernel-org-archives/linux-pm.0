From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v11 02/10] devicetree: property-units: Add uWh and uAh
 units
Date: Mon, 1 May 2017 17:06:50 +0200
Message-ID: <20170501150650.c4jtwqjza5em2e6c@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-3-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lk7clqpaeww6pd5j"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58176 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbdEAPu3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 11:50:29 -0400
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-3-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--lk7clqpaeww6pd5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:43:27AM -0700, Liam Breck wrote:
> From: Matt Ranostay <matt@ranostay.consulting>
>=20
> Add entries for microwatt-hours and microamp-hours.
>=20
> Cc: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/property-units.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Docum=
entation/devicetree/bindings/property-units.txt
> index 12278d7..0849618 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -25,8 +25,10 @@ Distance
>  Electricity
>  ----------------------------------------
>  -microamp	: micro amps
> +-microamp-hours : micro amp-hours
>  -ohms		: Ohms
>  -micro-ohms	: micro Ohms
> +-microwatt-hours: micro Watt-hours
>  -microvolt	: micro volts
> =20
>  Temperature

Thanks, queued.

-- Sebastian

--lk7clqpaeww6pd5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHTwcACgkQ2O7X88g7
+pqzFw//alIBuKhwQoYdbVxVEghAl3uk5deNcQG7l54eGfK8iXHjZqehj8Rz4s/N
/map1zSzSKO47E8zy9HK68nI3etTRJoswlSa7c0/OpprNVJ0L15+g9kGDHyi7zQv
SjuuEE75uyrQDvD97Whr2z54miFwOa1PVuAc3XWVxo7Q7piGsSDqSJIpswJqxP0y
uTvuAmRXM4LjFFu6MABTKNCaqjCLCgD9P3/cWdkWRP2k7BQcKx97/IYyERhd5iCV
iuwqCKT28aeo/2b5oAzEf7CBpjRiWTJuGLryWrePu3Vph8CEHZKCa7ADeSqaZWea
zugZNTZRglXn3rLWESQWb72VvnXWjAqrk8P8PhxNgFUTh6KuOxDT6jSbIZ6qv7ms
pT+13mfwmPHzXsb5ftXzHuQPkQ0Z8Fiq8vr3ld6t0jRHLyIcIDHGNxo8OE3VMzcQ
N65hWM+Nj62Fv9jmXPO5Y/IQBqwQss4eaRx5D9hjbTJA0L15+GPDYYyOY1+EoZTX
8pxU3TZMWGYDDyQ8+0jKxK5np0y6k7KdWrfXTyoA42RRa/rDQeA8oIegJel7FEdD
MEfhjuU21lQedJi/NrgcXE6k6L+03aeDqf/a+IkaPDUnCUmdsUzddT0IJj/OeT7W
3iDPQLP0bJs4QIn401qHPhH65zqNXDxbFZEc5ZV92AlVnpF6J6c=
=Op2c
-----END PGP SIGNATURE-----

--lk7clqpaeww6pd5j--
