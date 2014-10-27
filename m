From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 02/10] dt-bindings: Document the standard property
 "system-power-controller"
Date: Mon, 27 Oct 2014 11:39:18 -0500
Message-ID: <20141027163918.GB14253@saruman>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
 <1414427215-14380-2-git-send-email-romain.perier@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414427215-14380-2-git-send-email-romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 04:26:47PM +0000, Romain Perier wrote:
> This simply renames the previous documentation to something more generic =
and adds
> updates according to last changes.
>=20
> Signed-off-by: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/power/power-controller.txt     | 18 ++++++++++++=
++++++
>  Documentation/devicetree/bindings/power/poweroff.txt   | 18 ------------=
------
>  2 files changed, 18 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/power-control=
ler.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/poweroff.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/power-controller.txt=
 b/Documentation/devicetree/bindings/power/power-controller.txt
> new file mode 100644
> index 0000000..e0a1abe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-controller.txt
> @@ -0,0 +1,18 @@
> +* Generic system power control capability
> +
> +Power-management integrated circuits or miscellaneous harware components=
 are
> +sometimes able to control the system power. The device driver associated=
 to these
> +components might needs to define this capability, which tells to the ker=
nel
> +how to switch off the system. The corresponding driver must have the sta=
ndard
> +property "system-power-controller" in its device node. This property mar=
ks the device as
> +able to controller the system-power. In order to test if this property i=
s found
> +programmatically, use the helper function "of_is_system_power_controller=
" from
> +of.h .
> +
> +Example:
> +
> +act8846: act8846@5 {
> +	 compatible =3D "active-semi,act8846";
> +	 status =3D "okay";
> +	 system-power-controller;
> +}

there is no mention here that system-power-controller superseeds
poweroff-source and deprecates that.

--=20
balbi

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTnU2AAoJEIaOsuA1yqRE1bEP/3w1qaKnt/soJsWLxUog+aCM
uMgzJRmOz2ZIAD+6B2chsi6JbdovBszPaErdf2leX5+0VpX+XjnTntcgjN6Rufyj
WGvhHrzvSGFL3xQn+cyxMgngO+jFuq5j8pS868tymYeyj/2MGOWe6qhK/+hyX/kc
tKEazbyPyw4QGauQ1LK+709OXWG7507QGpqgUIkHQ1u9A1ELMwHm+k1EoNiLem7O
RXkb0N7I9XoEUibnMhqOnSrcp0+3qV25LitW8kGTanb67EtHH8W9ja0O36pa+cP4
tmrj8/U0qAIrdFKSKHyB1uCwbi0RQ9EBfbHX6KBSxgIcq79jgcGS7n1ZD02qoDP8
HdB/mtDJIbOf8UxJL5FUP9izcEY5+DHc+1mj1eC7S8o/t4Fr/DRTmAlERDZKKQeJ
+yVEk8bXtl3snkfjKXR67RUZyZiJm3N1O+IcFNyS+HircXoT8eB9erjUtfiDcPcj
OuK0VIDvrDoMcYJtqokTKnrkHNO9Kaqkb1RhqSi2zZXijzmbEwt9I3g57+Ac5ugj
HgqpZiFEtR0HZJmWgZEg2E551sXPt3rGn1dDdTGoIBJJQbkChvCDb6lFOLrXrclQ
FkKD3YySoyUG8Tx1CaklsV/+K5IzDJSW71l/QNMCOLW3nun3QuGIE5/MGIqbfQ8+
/B4T5X+D0spTMHoBCZXf
=K/db
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
