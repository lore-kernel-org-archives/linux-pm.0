From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4] power_supply: power_supply_read_temp only if use_cnt
 > 0
Date: Wed, 22 Jun 2016 16:23:54 +0200
Message-ID: <20160622142353.GA16084@earth>
References: <1465507719-819-1-git-send-email-rklein@nvidia.com>
 <8b081e45-94c8-bb53-69ca-0a617c668de5@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39256 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbcFVOYd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jun 2016 10:24:33 -0400
Content-Disposition: inline
In-Reply-To: <8b081e45-94c8-bb53-69ca-0a617c668de5@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, stable@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rhyland,

On Tue, Jun 21, 2016 at 02:06:55PM -0400, Rhyland Klein wrote:
> Sebastian, might this be accepted soon? We can't enable the bq27xxx
> driver for Tegra210 Smaug without running into the crash this prevents.

Yes, I have already queued this in my fixes branch some days ago,
but did not yet pushed it. It's pushed out now:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=5bc28b93a36e3cb3acc2870fb75cb6ffb182fece

-- Sebastian

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXap92AAoJENju1/PIO/qaALoQAJr2coGVaJwo/z06c1d1bELe
71wvGrD3dj7j8fy/V4144FOJivFY+6QgOXq9h3jRw+hXim/xUeJWbHY3vltQX6OB
RpwTLOTwQXxaU8DX8n+rtIuyxhwYhKeFgGeSk2Vpx5QDQvRdQA76cSmtdJ28ZNPJ
xhS+8T0FXpNYmiHgUsApAi8Z8njCTGqZPAPmEqomSURtmAcAMzKwFWk0z8oqZNMs
mLgEQO83Bp1i8/dI/0SYMxQP/sZyHmfkSlSjOF2o2X+mJtseqHT67srV4d2NkDHV
oZ8YRW0THzcDiPWI/uKS1Eix0PR6oldnwpAF4ayfAnbnwrkUGnxWeWltpqNiW2o+
9LMy3M2kJSr/5LeGOaNqeOzD5JmL6ulbPQFTCPrAc4hBhLfnJj1+9pUWM2eCbDfB
voepjwMBam1TjBAVTMSS9uIEwZPzIdRFcSIKd4FciXpCHSnqcCxDSrE/3jT/URxG
hveS0KfsC+n6AH7QGKeoFx7dw0xOjsEmAw+Yfmp46eQub9yEDfsZkt1Z9q92BhJt
9gCpvslJCyxWy7/QUqjWcAg+ZvUTFzMoG90Xt6zjl2E14mK2FiGI1dYUH9RBeWAZ
/EkVpjLJFPpsRwpzYz5aSZkPBbynMoijIQk+lrbsHLy959I4wqI5fTshJHgx4Xix
cyJNxXV7ReKfi75OQk0h
=mtpL
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
