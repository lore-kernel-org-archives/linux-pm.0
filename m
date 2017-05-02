From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v5 7/9] power: Adds support for Smart Battery System
 Manager
Date: Tue, 2 May 2017 09:12:39 +0200
Message-ID: <20170502071239.jsiorsvyzw65f3p7@earth>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
 <1493628599-30552-8-git-send-email-preid@electromag.com.au>
 <20170501134136.u2tebw77xcirvaqx@earth>
 <bf4cf813-609c-1d92-2329-35e9176d0d28@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7dblfcvgetpmf3fc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bf4cf813-609c-1d92-2329-35e9176d0d28-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--7dblfcvgetpmf3fc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Tue, May 02, 2017 at 10:20:22AM +0800, Phil Reid wrote:
> In regards the le to cpu conversion. grepping the supply folder
> finds a couple of other suspicious cases.
>=20
> sbs-battery & the bq24735-cahrger do similar things.
>=20
> thoughts on if they need to be corrected?

Yes, those drivers look incorrect. I guess nobody noticed, since
most people use little endian machines nowadays (so le16_to_cpu and
cpu_to_le16 do nothing).

-- Sebastian

--7dblfcvgetpmf3fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkIMWUACgkQ2O7X88g7
+prlXw//TyRPzCOkwzk9i2R/xX9FNJRTiNuqZSjb/nOy3r/zS0ZCJUxTE364Z4Zt
s+6516y0wtas4PT6AWaBDU6k0AuUeQMZtJwZ+ze/MCgm5CIm4bDvcFVTkJxRmBQB
zbySnVGoHdTeMBeWbh5P7GDyz0V8h2xYLzfE+tLy+Q5lkZV/w8DPVoURpZXC+J4c
1PG3/M/Y35rWDT597P0HKtHOedBs9W0mikF2VUV5Z8SBhrMqdoHLew2v3IZu0XUe
6wDAko/AhUZ7YF+HjX3QPgYLnwfj32ihvaZ3MieHbCwTkjdW1129mg9dRuyLuk9q
v55wLqpeOEj4ngrpbI4c1VZXeGCQiAF3yACYmdbCl2EZNQZU+ld4kuyE7EbvaxmV
9bS/GYPsbaQmzIqBK8MJPY0GCzXCSBloQ3yqKTwUpDDWKXCfJwuMjUGsR3BnVU5e
xSh6bOLU6niWuPqtPeEA79vbosB3fDRKQzwlo5+c+vLrJDNwxZ/7w0l/gr9Ajhzp
pFBbXTIKKJV3IunhV2Ew7Gea4vxlJ1pZhVELW/4HDtT8n01LzS7h9+SFNJjlGqIT
K2Hf7NWhAlUUeZQkRXixP9bq0kx7bzJenmofJsmGS60ZL5yoFff35HpuUCMX/zK6
XvGiVN3mpZOaUM82IWItVVIv4T7NSQCJi68pfyFkW6i6Jl3as9I=
=gT7i
-----END PGP SIGNATURE-----

--7dblfcvgetpmf3fc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
