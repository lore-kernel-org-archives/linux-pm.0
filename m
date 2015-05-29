From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] power_supply: 88pm860x_charger: Do not call
 free_irq() twice
Date: Fri, 29 May 2015 16:34:38 +0200
Message-ID: <20150529143438.GA9783@earth>
References: <1432905403-27416-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52076 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387AbbE2OfD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 May 2015 10:35:03 -0400
Content-Disposition: inline
In-Reply-To: <1432905403-27416-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 29, 2015 at 01:16:43PM +0000, Takeshi Yoshimura wrote:
> My static checker detected double free_irq() in pm860x_charger_remove().
> Unloading this module always causes a warning. This patch removes the
> first redundant free_irq() call.

Thanks, queued for 4.2.

-- Sebastian

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVaHj6AAoJENju1/PIO/qazzcP/1eax17LnXHh0kqGamF4geAl
8QMDMoVeg8HgHX6/4MlhnaxVAuUvjEy90bsyJc/VrQ7RVx3M0M94YETgcwEUyvMf
4RKt043mZA643CjvIjUykyyZuu8Ue74MywEgsNf8fZMXbv1TfRLs4MmaIx/RSl5B
ZeisAy/Wq5okgAbY5ZTwqwDUQi/OJsVX4DeV/KZl4BkT4DuR99ensPpXu3GpP6OY
W89mO50gK2Vh3pvck5nwE8/XgLsrZwsNjkpJn4v/sjvCPgxXyhEBCDpltyz0Ujox
ZuAiBbSgW7cHuoxXdtTa79tBXUdb8a/RDZg+JdTIQm/2C9o3CWA7CtlBuejNfGcn
lsA9h9Ql4AbJNbKYp+GvZG3ynsFg9GXyAlEbN8w/GlLF7GCfo98ufsdleIuJ8tAU
bYVyEteEA54qvtMtE7Q2BDBvzLAoCLfi+lb7DfX7b4EIMCzWbNrmcnODZ4sxF4KH
laqlWKv8771OkmkJnidDrlUJz8HNjw7pnHilLTvpH8WHo6wRzOnQCIEfaCA/hN6S
9Oknxwg1cmae2XhHs8BFDI9Ss3/j+EkMFZ49x9Mk0AFbl30E9qi+eHvH8MXL46nc
xYmuQd8DK7qONTuUsL63EE93kgZVrVQRwP1e0797FlvEoedh+1ZS0Qm+yxygJ3NY
0gqYujWIBU/odUgEeVWB
=EvFj
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
