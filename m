From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v11 01/10] devicetree: power: Add battery.txt
Date: Mon, 1 May 2017 17:09:34 +0200
Message-ID: <20170501150934.qx2nrw3r4zjgjvb7@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rsqx7tuzf3lhgm2s"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170320094335.19224-2-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--rsqx7tuzf3lhgm2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 20, 2017 at 02:43:26AM -0700, Liam Breck wrote:
> From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
>=20
> Documentation of static battery characteristics that can be defined
> for batteries which cannot self-identify. This information is required
> by fuel-gauge and charger chips for proper handling of the battery.
>=20
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
> ---
>  .../devicetree/bindings/power/supply/battery.txt   | 43 ++++++++++++++++=
++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/batter=
y.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b=
/Documentation/devicetree/bindings/power/supply/battery.txt
> new file mode 100644
> index 0000000..53a68c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -0,0 +1,43 @@
> +Battery Characteristics
> +
> +The devicetree battery node provides static battery characteristics.=20
> +In smart batteries, these are typically stored in non-volatile memory=20
> +on a fuel gauge chip. The battery node should be used where there is=20
> +no appropriate non-volatile memory, or it is unprogrammed/incorrect.
> +
> +Required Properties:
> + - compatible: Must be "simple-battery"
> +
> +Optional Properties:
> + - voltage-min-design-microvolt: drained battery voltage
> + - energy-full-design-microwatt-hours: battery design energy
> + - charge-full-design-microamp-hours: battery design capacity
> +
> +Battery properties are named, where possible, for the corresponding=20
> +elements in enum power_supply_property, defined in
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
include/linux/power_supply.h#n86

Since Rob did not reply, I queued this with this paragraph removed
and whitespace errors fixed to speed up things. You can always try
persuading Rob in an incremental patch ;)

-- Sebastian

--rsqx7tuzf3lhgm2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHT64ACgkQ2O7X88g7
+prQqA//TLm0jamH7O6/T2Q6TJB9N+MsScmbLk/Txee+LqIi+zWH9YI/8DvqGKbi
t2ziY/RbueKDOtX7ZxLfY96zOxJ28dyBcNQ1nYLjVnIC0LvPRQrwRVi7PIQEe2Sk
FdiZ/FRoCStUwkLCfnh1KaeSePTKXVcBUXftbmPLZ1IQcY75jtZpHJplYITdAYrP
4EvNJ2qDg+LgOCwOjLwy+LAFt5FEpmXo85k7bS5Y9f80IrdoQ5BeyvhC0b1yVoed
JN2bYJpHCS/zZ72YvzEyvyWQ1MW5t6h/Djb0cswt2YZbjy6BI0vM8HI57GQpLFnj
OeGx37Pjmqw9Dab5YZ7v7oNysYyAYq6eb6I8z2mReprNa/SYBLYDps6Mqe93jj8A
qACemMd6HwVD7avYkbP7ZMWa/g9BDnQJl9t3T73okzwvjpy5w96krsCfRliiVAbj
ilKutKKCyaqQ9EfhK21LSu7yBTcLIG9YYMykjjb2D9QIz4xiUTXjGdZfkqF1mehM
njGNBPlsLLltKfF+DRO/ku2EgCMuXNlirGl99TOF/goDH8PBgpm0ORz0jNA9DhjZ
BTAxwxPDFtz+D8b8mnz6T8H72UD512cJ7YqkzBn+OQyGg9R4MMl5BLI5bf69wCr1
ItF5IRjjG3DaL1IfgG2BQHGTQ/hURPYCxir7sI2XJRyaYCtilfU=
=yGj+
-----END PGP SIGNATURE-----

--rsqx7tuzf3lhgm2s--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
