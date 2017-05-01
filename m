From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v11 03/10] devicetree: power: bq27xxx: Add
 monitored-battery documentation
Date: Mon, 1 May 2017 17:10:05 +0200
Message-ID: <20170501151004.2yum3expxzi4nah5@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgzstdovchzpw5ew"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58159 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdEAPp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 11:45:29 -0400
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--xgzstdovchzpw5ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:43:28AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> Document monitored-battery =3D <&battery_node>
>=20
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 11 ++++++++=
++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b=
/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> index b0c95ef..cf83371 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> @@ -28,9 +28,18 @@ Required properties:
>   * "ti,bq27621" - BQ27621
>  - reg: integer, i2c address of the device.
> =20
> +Optional properties:
> +- monitored-battery: phandle of battery information devicetree node
> +
> +  See Documentation/devicetree/bindings/power/supply/battery.txt
> +  If either of the referenced battery's *-full-design-*-hours properties=
 are set,
> +  then both must be.
> +
>  Example:
> =20
> -bq27510g3 {
> +bq27510g3 : fuel-gauge@55 {
>      compatible =3D "ti,bq27510g3";
>      reg =3D <0x55>;
> +
> +    monitored-battery =3D <&bat>;
>  };

Thanks, queued.

-- Sebastian

--xgzstdovchzpw5ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHT8wACgkQ2O7X88g7
+poA7BAAqK/msYgB+HKdobtk9sK+KXNIHirPnAMuFMOE/a4E3sfvbmfbCxUHiPxm
yiZ5EG4pKCfUkB0YeAzs33AQM/JO4fNEG9uxM67AwJZFit58hwObvJJYnVkZR9rl
oMCJzLHnSat0/3HPA+S1CJ9p811ffUqDTXw1rbgUzD+H6DN4sgS9TD+AxSHHteJF
w/ykJodW8oAnFJnnnw3zw6CKeIh4MPfCwvKrS4og6739XDc+M7PzkTtroJrD9B1o
6YggW09+MUkaaI3jgT/fgBkbiCcsod+972lHFdaTEXoCjQgTGQtoHv9/n5uqOSxH
UavdZWVJXBNhSrcIU+kYIYnwaDEmn+yMw35acCQK24JPLc9k1S+lav9C5OqtXFD0
RfQ9KgRA7ZHoTuijEQ/nvoSsMqRBAzvU0wkelGUCQwFMN/PSrapAZVNLE5BFBtnO
GjQaGFVst5G4PL3h2b75DVzThMCTA81nuroi/qaxdi6ZLHheljoZmED+VYd/0hEv
XxIdIvloh5IzUPjx0fqt6xGNy5Q3ziWKPCk1qJes9+AFdJ1qvJ4apkyODtscmbrH
flkgNS/XeNIGcltYKy+6ns/wHKXjMQrv1vn/MNxkvdFgqIUXYl28kS8dtbJx2uND
qVOPMvZqYps3CvqNGJtrXmpGegowNrno+tKsDZLvZDZkLNozFW4=
=lP8Z
-----END PGP SIGNATURE-----

--xgzstdovchzpw5ew--
