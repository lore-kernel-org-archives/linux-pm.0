From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: reset: Add generic SYSCON register mapped
 poweroff.
Date: Wed, 11 Mar 2015 02:39:31 +0100
Message-ID: <20150311013931.GA1017@earth>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
 <1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41452 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbbCKBju (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Mar 2015 21:39:50 -0400
Content-Disposition: inline
In-Reply-To: <1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 10, 2015 at 04:21:09PM -0700, Moritz Fischer wrote:
> Add a generic SYSCON register mapped poweroff mechanism.

Driver looks mostly fine.

> [...]
> +#ifdef CONFIG_OF
> +static const struct of_device_id syscon_poweroff_of_match[] =3D {
> +	{ .compatible =3D "syscon-poweroff" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, syscon_poweroff_of_match);
> +#endif

You can remove the #ifdef, since the driver depends on OF.

> +static struct platform_driver syscon_poweroff_driver =3D {
> +	.probe =3D syscon_poweroff_probe,

You should set pm_power_off =3D NULL in .remove

> +	.driver =3D {
> +		.name =3D "syscon-poweroff",
> +		.of_match_table =3D syscon_poweroff_of_match,

This would fail for !CONFIG_OF. If the driver has optional OF
support you should use of_match_ptr(syscon_poweroff_of_match),
which is a preprocessor macro returning NULL for !CONFIG_OF.

> +	},
> +};
> +module_platform_driver(syscon_poweroff_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
> +MODULE_DESCRIPTION("Generic SYSCON poweroff driver");
> +MODULE_ALIAS("platform:syscon-poweroff");
> --=20
> 1.9.3
>=20

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/5zQAAoJENju1/PIO/qan2kQAJnfjLcABB3rIf6fxjescZpL
9ZnLPyNDZZjwpcvFhG1r18SZ5ypU0ZJcsLBuvwAGiu0lpuBPCMpcXzHsoF69cMtL
L/UJI2mRS7jGo042XpvRYB375Rble+VCx/DkfBrJB595t14Sx4+OwU1JfXYhFNaC
bPU7T2OLarlqMEDlP4KZlb3JPncu4/Lejp9pRMWW52XL6p2x9yr7uJtxQbh8Xruj
1cCo/0v7Dr+Wc6K/a6kqyrnt7IipAWM2NoeSTP4WU7m8tvsOJPokcqr3248HMs/h
8TzNszYck4K7/UxoxNbc0GuIJ3AV7LH1m/2iSWadRysn00d13VuFjiW9qnAIW08M
8QDNMj5gc1eX/WxM4bhWk961ZWoSN4ZlhloNV4q89bOL13jTfzvli4HufSkB4UJl
LBgbXJtRjTnuJDfcqqa4mIert+DxNHSjxsXccRZC9IK0zqo7nbZHxKYbfBUGqFxY
WI7IJ6oWwaBcX9epfNyM6n2K5cuQP62zM/6DpiTb0+cvCT9wQbcmZRNHgGtVezh7
9KBg05KaWdXoMNKVdBnP/GfZyilIfLD9qYWvumPBdAcKpsceBaqFzcFNsjUF2HMh
Psse+3j0zihv+sosrNR8e0mURt7YdTeb9nDea+dDYKLFyrsp4vM37jMz4IRyRgBZ
TNX3AwLpj4YqE/H+dGCx
=8eMn
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
