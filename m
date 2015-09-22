From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] 88pm860x_battery: Convert to using managed resources
Date: Tue, 22 Sep 2015 15:17:46 +0200
Message-ID: <20150922131746.GE23334@earth>
References: <20150917123340.GA10489@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34187 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933388AbbIVNRz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 09:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20150917123340.GA10489@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2015 at 06:03:40PM +0530, Vaishali Thakkar wrote:
> Use managed resource functions devm_request_threaded_irq and
> devm_power_supply_register to simplify error handling.
>=20
> To be compatible with the change, various gotos are replaced
> with direct returns and unneeded labels are dropped. Also,
> remove pm860x_battery_remove as it is now redundant.
>=20
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Thanks, queued.

-- Sebastian

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAVT6AAoJENju1/PIO/qaRTQP+wYzC4HTiqnPueFXX4B5tKt2
pvExQRSiDvlbtS0BE/HBlCTyGKHzbpfNWEAsZ+QMOzDGe2M+lrABV59wuDo3zO83
daswQpzC9keRO1izJvh0hOPWo5C3gQAF5zpnM7EQB0d+yIPzl5J9cQaMkLrNuwTj
aWjw6Qbr7H+XkjaAXJ1cc1LNdspdHTzAl+VX1ZrhxWfgDWZlapEhHKjGioxqeqlg
m0rlnrYJ2QSIxRkLIYzaba8PX2Ye0WEd7By/N1n0lnw4xt8DPHf2ie5XQRv0hnVz
9mZ/5tFQD1gWBgD8jczsna6uoVt+53p25RJOus36BlnxRxUmDoL3/OADuUSgDiee
P4SKPCQFIy9ouMRjBoFUCT/B7EZUtOUGqNBPBGvCC9kay6+aUGusE3LOycZCpiBB
+SilclUoQkxpZfpk0k+ZZrG+VQ5jfMFdFLC5sS5GCxUYKYFJ5/s1GnGwH+rbtxTx
dqMjkDhQTSCYwbSnh95IDE9cCbtkFr3eFzRFpjLr+kkoQBjZjOgncW2o6wbZBkru
3y69z83rHTE39hceas8OFuRsSeDoxzvNhi0bxfabeJwpUck3srrFrWqHiA/62VKr
OAmGghNcVJPuJdZOIudWIWXHFYvMtGbZugZqsty/d6Opn3WKbT93FxTJ5IiVY2HF
0NICM4nZrSHXo7Ls0J+c
=LEFQ
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
