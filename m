From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert
 from i2c-smbus to i2c-core-smbus
Date: Sun, 29 Oct 2017 16:44:08 +0100
Message-ID: <20171029154408.vmjkpj7ybqyrj3ke@ninjato>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
 <1503567070-115646-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ttwrb3btjf6zwrj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1503567070-115646-3-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--3ttwrb3btjf6zwrj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 05:31:02PM +0800, Phil Reid wrote:
> In preparation to adding of_i2c_setup_smbus_alert() move
> i2c_setup_smbus_alert() to core module. of_i2c_setup_smbus_alert()
> will call i2c_setup_smbus_alert() and this avoid module dependecy issues.

I am not very happy with this but don't want to cause another delay. So,
I hope we can discuss and fix it incrementally.

=46rom what it does, I really think both setup_alert functions belong to
i2c-smbus.c. Three possibilities come to my mind (untested, though):

a) use try_then_request_module somehow

b) add to CONFIG_I2C something like:
	select I2C_SMBUS if OF

c) get rid of i2c-smbus.c entirely and move it all into the core

Dunno if a) or b) have been tried in the course of this series already?

Kind regards,

   Wolfram


--3ttwrb3btjf6zwrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln190QACgkQFA3kzBSg
KbahfhAAj0Pjm3wgot/4JAZqwufaZfuMfPpIMEDl2xdcdkPrvgfxPZwdM+JknJQK
c5tHOoijY1XlSAOwv+E8agjUE2YZpBcPIfSeItV6wHFkhYvzawXG6MpV0irUfrC6
gwv3OaiWTPmSvCrIvDg/ghirvE7lY4uVJlr/mE2GKzVSsGdjSI+TJmnym6HMx4N6
XYySJlyQh5aBxddt0XTjNMLprIHhgh9rb88MljL4wdYf7dyhwPwjklTlrwy0WjUY
A8nG+SoQAl1NnYbGizXZFF4z1NOIsxbUrtU759fovNOgPY5juldvTsUZbpDSKrSB
T2GzXyAAFUi5o2ImCbdYbu7kr/wgfSmMDQtHhBtTnYBc9/5fCCgRMlQKjhVAkIRi
n+VAS7On3yyJKGpJTi3g2d5riIkBbD7bEL+RRxWOb+xGdEHqA2udW49HA0INqz1C
Kpon/MIJeR9mB0kERG/TCFuaqPda5BKZZsxFrOVpFdJl7BOqKhBMuo54Q36cYsMP
/zns0TjqduNXdf8/9VSIzipWYqAO6NLwYHyv17yjubWTX0Hd/WPirfFr+gNaOxOi
LYc2+4iQc12G77yHUlOox5cCPLKIN2ZzFd+l51rXsJuxdGobtVFm4+7/4Mkig9fx
pGRod31OiV838WmSbHADesbdHZiVndsusfMs75ZsLlU91vX/WzE=
=tsb9
-----END PGP SIGNATURE-----

--3ttwrb3btjf6zwrj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
