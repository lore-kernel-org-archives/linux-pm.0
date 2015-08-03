From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/6] power: Add support for DA9150 Fuel-Gauge
Date: Mon, 3 Aug 2015 19:25:42 +0200
Message-ID: <20150803172542.GD4856@earth>
References: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
 <d122a6ffc20fca836847016895e5181f5d2248e7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
 <20150725172715.GA1697@earth>
 <2E89032DDAA8B9408CB92943514A0337AB5690C3@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB5690C3-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 03, 2015 at 03:23:11PM +0000, Opensource [Adam Thomson] wrote:
> > > +MODULE_LICENSE("GPL");
> >=20
> > MODULE_LICENSE("GPL v2");
>=20
> If I do this then I need to update the file license disclaimer at the top=
, as
> right now they match and are correct as far as I can tell. Is this change=
 needed
> and if so is this the intention for other drivers as well, just so I'm cl=
ear?

The header states GPL v2+.

-- Sebastian

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVv6QSAAoJENju1/PIO/qaGqoP/jHLHPJPLJPpmAUzrlQ4zTQs
aMG9McADJ1lSJhmQz1LEuNUVBvLWFdhvI8y9LegzBESGfaozcssTD08y10o8uD8t
3NDTC9oaVmr0oWp47lMXd3+1u5q0/BTUSeY1AAcBcAtHO8zDQN1dMDgJtF+kEr5x
8G96cj174lqIeYAjJpp5AesZs6kmG3l0pgy0983f5y5Bf4zfJgawaf9dHKXZqxPq
u31sggkuIoY76zNe00XCh0x/bHzBfgmGQSYUY225D87jKPxgSu60VLvdGHNcaxVr
7HAdqBl2atHMH4PgYvaJudLcpaOgANctAu5MCB9is/Eh5KTPiNXQTfJ5eFQ1yrmp
+iSDktGZcJD0CU19gbDuFkXqpC0shn1BAFsTBEFrJ+wQA+KfxhFOpp65mhlh7xDj
Zl2cjVnslKTzfzsBbDCz/r3C5MAZjVm85d5Rh2EdihHoKjii4dqJFvoBjKfU08Y2
jmdLIxF3rpZXRs4StFV9SwoTgSusNiG3QMMOmDLqI0j/NXIxlX9QHVpcDtojwwXp
qYRSlWNEQ9gYLyybAXEaNE8UuNquE88o+S6y16NQ0LJnXzMim3S3+1iUd6Pjy8lr
ZIMqQSSSGBtCdYbhjREb08d50YiCwlDFTNBT774EuewCebLxCacvWQVld77Ho7Oi
vgieflGH2Z/Md79JrOYg
=SGaf
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
