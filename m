From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regmap: Add 1-Wire bus support
Date: Wed, 31 May 2017 19:28:34 +0100
Message-ID: <20170531182834.ne3rghcnm4pcdcsv@sirena.org.uk>
References: <20170530175735.3481-1-minimumlaw@rambler.ru>
 <20170530175735.3481-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihzb45gcqu23x6og"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47146 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdEaS2t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 14:28:49 -0400
Content-Disposition: inline
In-Reply-To: <20170530175735.3481-2-minimumlaw@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--ihzb45gcqu23x6og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2017 at 08:57:33PM +0300, Alex A. Mihaylov wrote:

> +	if (!w1_reset_select_slave(sl)) {
> +		w1_write_8(sl->master, W1_CMD_READ_DATA);
> +		w1_write_8(sl->master, reg);
> +		*val = w1_read_8(sl->master);
> +	} else
> +		ret = -ENODEV;

CodingStyle says { } on both sides of an if statement if they're on one.
Otherwise this looks good.

--ihzb45gcqu23x6og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkvC1EACgkQJNaLcl1U
h9DOCgf/RUw7xi5b/xQ112ExQWa333F50SsY4IyD3tc1G+CFr9YT94OZnRylokqH
OaH0Wv7PX6RzavNx8L9GZFbelXc4PBMaCHZGEq6pQwgQGAko4gxnGGaPj0UuRGXL
Rve7GQu/snRA2p4PUmWWb6UBb7765dQ+aj5GWVcuy6Yxmf9PVKCdDDq0fvLB0ymH
dZKNUMx2Yz9Q8CmKJakBY4LVybf7DgqlhZHtTqKz1inMDoHn/TMwb12w8r4R9dg7
qH4rEqnv5J0wGjTyep8ZLQYcFZax69HcCQAYKPhNjA1iGGUD4w6jwCiu0oycza9F
D6qvqaco5NzB8zkYavJBLx8UsP6cRA==
=QXv1
-----END PGP SIGNATURE-----

--ihzb45gcqu23x6og--
