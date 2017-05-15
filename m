From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v2] dt-bindings: power: New bindings for ltc3651-charger
Date: Mon, 15 May 2017 15:17:54 +0200
Message-ID: <20170515131754.pbnvgiqa2awkgnyp@earth>
References: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl>
 <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
 <1494308190-3687-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wkw6rg6lchpkkhri"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1494308190-3687-1-git-send-email-mike.looijmans-Oq418RWZeHk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--wkw6rg6lchpkkhri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, May 09, 2017 at 07:36:30AM +0200, Mike Looijmans wrote:
> This adds the devicetree bindings documentation for the LTC3651 battery c=
harger.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>

Thanks, queued.

-- Sebastian

> ---
> v2: Add "lltc," vendor prefix to gpios
>     Expand irq paragraph
>=20
>  .../bindings/power/supply/ltc3651-charger.txt      | 27 ++++++++++++++++=
++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc365=
1-charger.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charg=
er.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> new file mode 100644
> index 0000000..71f2840
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
> @@ -0,0 +1,27 @@
> +ltc3651-charger
> +
> +Required properties:
> + - compatible: "lltc,ltc3651-charger"
> + - lltc,acpr-gpios: Connect to ACPR output. See remark below.
> +
> +Optional properties:
> + - lltc,fault-gpios: Connect to FAULT output. See remark below.
> + - lltc,chrg-gpios: Connect to CHRG output. See remark below.
> +
> +The ltc3651 outputs are open-drain type and active low. The driver assum=
es the
> +GPIO reports "active" when the output is asserted, so if the pins have b=
een
> +connected directly, the GPIO flags should be set to active low also.
> +
> +The driver will attempt to aquire interrupts for all GPIOs to detect cha=
nges in
> +line state. If the system is not capabale of providing interrupts, the d=
river
> +cannot report changes and userspace will need to periodically read the s=
ysfs
> +attributes to detect changes.
> +
> +Example:
> +
> +	charger: battery-charger {
> +		compatible =3D "lltc,ltc3651-charger";
> +		lltc,acpr-gpios =3D <&gpio0 68 GPIO_ACTIVE_LOW>;
> +		lltc,fault-gpios =3D <&gpio0 64 GPIO_ACTIVE_LOW>;
> +		lltc,chrg-gpios =3D <&gpio0 63 GPIO_ACTIVE_LOW>;
> +	};
> --=20
> 1.9.1
>=20

--wkw6rg6lchpkkhri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkZqoIACgkQ2O7X88g7
+pqmWg//Y8KxuLpvEcE3J6kfC2+fSD3Tkj1TUqjswdJK7LvDGpb5GqsyINkbrXZC
LOMExw6zedf2ZBIhjXdBG4jVrRcv3TB9Aqgy2wVgPKytu6I3v6lCk21cyefIb8Go
NYolimYLdtX1AyDy2KRllSBs0J4nzhYA9qx9383f0B/ikzVp2iWSysEkz+JZACK4
Cgkk6bVViWLxQGRNcewBd+GgwP39yelrkTzBD9TNdXVvtDxVkJ5AugubAajzvBhI
0MRD6umakLCusSLyWZQ8y42DEs3Ld46eunlU8rpQ4B8Iyr5O7gBJgg1qqH8wVENu
Kq7mORzqNlTti/KvTZgYLzjlwMjJhEd/yMPZOa5W5D/8JT8zZsBAr50ajIjFI1ZP
dCbxtTtUHIpYjmzHo+gxAeieuEAWWO2b0hgOCzz+rCujVhMCjB+G+8HyKKht2jbQ
SsOu5MejK3JaRkLQkguiVcU7Y8Q6r6Fg+HmmJ9n1wZMuNVWk3MwCqGJD87l1p8pu
IKYF5lb/midd6RumWICPwpJzH5C6/1VkC4GJRQZOe2MtElFInjNxfzQ7lASLioMO
OdU71wg8Rq+6R0gOMvLUQJ0vFj2J3bYoX9allsBHF3ltwSQ3byPT9omG8SOJYicJ
MNn+qnshL3xd1B/6Zhshn1vlUi+sGUoxoG3QMTwN1mJ0guhVxYE=
=zhQ7
-----END PGP SIGNATURE-----

--wkw6rg6lchpkkhri--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
