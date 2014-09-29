From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] PM / Domains: Move dev_pm_domain_attach|detach() to
 pm_domain.h
Date: Mon, 29 Sep 2014 14:54:34 +0200
Message-ID: <20140929125434.GB1327@katana>
References: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58396 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbaI2MyJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Sep 2014 08:54:09 -0400
Content-Disposition: inline
In-Reply-To: <1411991927-19654-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 01:58:47PM +0200, Ulf Hansson wrote:
> The commit below, started using errno values in pm.h header file. It
> also failed to include the header for these, thus it caused compiler
> errors.
>=20
> 46420dd73b800f87a19af13af5883855cf38cb08
> (PM / Domains: Add APIs to attach/detach a PM domain for a device)
>=20
> Instead of including the errno header to pm.h, let's move the functions
> to pm_domain.h, since it's a better match.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

For the I2C part:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKVaKAAoJEBQN5MwUoCm2SsUQAIqH5prUFvW/dJeB4cr5RNYH
cKNlwyJw8kOJT0ZaxgfcTIBRxgvAZIFPuHskmangOY2ZOzotuEvz55jW4eYWVVrf
+I5QMzFLHUjpMxwnwcrRGf9oS2oAfd41xwnq+/rkPYPzFv9/zekEhgTGhOYOhBnw
wpImzzuouhGKDiaER/wl334cGLFLX8wZKo4DkCqstwKxg2ykqsB8CP3Z+BNNM0X/
ke/+glW5HXqZI6WKxKmauJ6pSyB9L388Q1AL+eNvtGnk61OzD6/wP5Lk2cBDqPbA
X1rqxKhhozQQv4nYfmgrqiVpXwB9bc7yKAFEietxMQOBvA28StF+m10/07rI5XWn
Tyb9McECqqVd5Z8kL9WwZgKomlq9p7EHbGDXqUhTQS0xkbiNLN0vf7J2r4DIS+f7
CIF2Pt7ALpUgGOLFG9CGlb87Y/xiFfsauFbz0dnNvIYfxo6Nm6kECK3+wGScJKUg
NAQBY9Yo9wPnmLEZ8OWt+mzly5pDLfhL/gGEu7PcUw8aQ93qAxlI0so7ftlIbXDX
Xj7xMS8S7yc+Dt5FlXXgZqvD2uJA4JtlSBwujnwA4BY3rrsh8yotB0DC/R1Vy2Ft
7wkXYlQkZ977CHvCzwPx9dcVgOQhrj0M6wQkmFk9ZgPbwPE33BgN7FPedlZMGP40
FrQVy3HV2BRf6uQQ5D4r
=RJC8
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
