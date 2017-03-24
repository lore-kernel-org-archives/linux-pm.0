From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 1/7] devicetree: power: battery: Add properties for
 pre-charge and end-charge current
Date: Fri, 24 Mar 2017 10:01:58 +0100
Message-ID: <20170324090158.tl55neisjws66naf@earth>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apesiipwl2ie4wgu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753963AbdCXJCE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Mar 2017 05:02:04 -0400
Content-Disposition: inline
In-Reply-To: <20170321220921.5834-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>


--apesiipwl2ie4wgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 21, 2017 at 03:09:15PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> precharge-current-microamp and endcharge-current-microamp are used
> by battery chargers at the beginning and end of a charging cycle.
>=20
> Depends-on: https://patchwork.kernel.org/patch/9633605/
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Acked-by: Sebastian Reichel <sre@kernel.org>

I think it makes sense to merge this into the patch adding
simple-battery.

>  Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> index 53a68c0..494374a 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -12,6 +12,8 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - precharge-current-microamp: current for pre-charge phase
> + - endcharge-current-microamp: current for charge termination phase
> =20
>  Battery properties are named, where possible, for the corresponding=20
>  elements in enum power_supply_property, defined in
> @@ -28,6 +30,8 @@ Example:
>  		voltage-min-design-microvolt =3D <3200000>;
>  		energy-full-design-microwatt-hours =3D <5290000>;
>  		charge-full-design-microamp-hours =3D <1430000>;
> +		precharge-current-microamp =3D <256000>;
> +		endcharge-current-microamp =3D <128000>;
>  	};
> =20
>  	charger: charger@11 {
> --=20
> 2.9.3
>=20

--apesiipwl2ie4wgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU4IYACgkQ2O7X88g7
+ppkKw//egZ52BHeixWjHkjw1EtV3depVzzo/cW8BZF65s6iU0ko6XdTF/oEKzs/
o5fPQLVvxfNiasiLcQ1+sUAQP9Tkzd3XJNiXucS1xBshyq0VLST0d+cZAf0igrQu
y0OARC5NQd8uNjcCFLRh0aqb9Q9yIZzOdWaw7gzVk6muLPREQegq3N5XEAr+4IJE
+7BCbyE4/p3W8oYLvbslZj+7M/qQ2rwfLQRRd1WFulKkPscNko6O4ALN4WJtp6cG
/ZZ4EGGB29xGBgZ/cREA34c7BmkPaH3dqH0s084CxNuLWuuOr5VfihoWpBKBqmJ4
/yGLD2hG+h+vXh7/liD+v6aq62dIUp+N29Qr2iiccxvFJ5G+QJbSKtgxwuBMEZos
VJqeRqAL/hn/A/oaLDGfjHeFixksv8ahusRt6llrg0QGntWnu+vGc8w0cYLcFMa5
r+fWhMLYinslHLXvQFSJ8O4w917BOsyUuqS/tIQf2GCcVo5yD1aSsXqJ3ot/bVMM
H/txJOYeys5X212lkQysTXlyACqsiMZdZ9zcRxWknwyFBatol+Vz0dEb5ZRXgYEW
V4bHYAFlF7MgU+WwzEFAu9Y+ntc2zPfqE72Zcn2vFr5UioLaVvJX3I0/Ao5ZAa6K
f6a2V/vi6EeMm5itzhvI2u0BSTsUkY4FxkYmM4mB0syYDYMkR2U=
=BflX
-----END PGP SIGNATURE-----

--apesiipwl2ie4wgu--
