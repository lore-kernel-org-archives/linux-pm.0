From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] power: reset: at91: add sama5d3 reset function
Date: Mon, 20 Jul 2015 18:42:42 +0200
Message-ID: <20150720164241.GA5930@earth>
References: <1437384726-24927-1-git-send-email-josh.wu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437384726-24927-1-git-send-email-josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, Fabian Frederick <fabf-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 20, 2015 at 05:32:05PM +0800, Josh Wu wrote:
> This patch introduces a new compatible string: "atmel,sama5d3-rstc" and
> new reset function for sama5d3 and later chips.
>=20
> As in sama5d3 or later chips, we don't have to shutdown the DDR
> controller before reset. Shutdown the DDR controller before reset is a
> workaround to avoid DDR signal driving the bus, but since sama5d3 and
> later chips there is no such a conflict.
>=20
> So in this patch:
>    1. the sama5d3 reset function only need to write the rstc register
> and return.
>    2. we can remove the code related with sama5d3 DDR controller as
> we don't use it at all.
>=20
> Signed-off-by: Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

queued.

-- Sebastian

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVrST+AAoJENju1/PIO/qaDNIP/jmCqEJsY/NuiFaVK/nCyIyy
Wu+Dh5Ow9SnvGIyLlNMdmhdyqQYtgWuPeepTqjzbEFIFsun/yFmnBMrs8EAg9fm6
JjQy2DuzAJO0s0GmvtbrzZ4/EMcyh6DeH136EW4ZrJkBsnQRDqXS2wmbpRmJK34l
yck+CMZunNjKfT+Wxn/blV0ora+Avf7Sz+ZvqXX3XM1ki/tJACme5vuxkZBhImYH
mNkBRIe7QUI/+12HkwZukn0Ij38k6Vrjr5wCheaBajNxMUCu/CpfU4kwKjFUls4S
7WevKaNLzGA1taFzK8jz9Qrd02gPqMi3H9C0ELLTa9+soeQau2pvQcZAjNGEpvTG
NbnoIBPa9m4bgAkxLbS2BKbqugsJqL/sRdxdOhcyzlYPZn/EsCQJD3IXaFM3hiwX
Z4L9FwaCAUtMD3029BdFzk3Od9W+3BIfXrOExnw6hfddNIMW1i+kCoqpuS6XTVmb
+JFGN4ITCp5YZz6Arsq0KASPbD+C8TUY7S2IPY8cjxpEdhor4fiVAB+gB3gu2k7U
PRp7d1gzlDYFOMW/o56qDg0kUzf+ZHF8NrqXr+odI+JEVEHSPdNNY30HB4v7yevr
gwcLHIfA6dZjUIkM1TDAsW/Y2WGwXeBJXkhKkZHu19zy73E8s7YuSvIBA/v2e4n7
ruqhGIT0eClbrGVrF66v
=onF8
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
