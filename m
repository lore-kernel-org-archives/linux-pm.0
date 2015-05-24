From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: axp288_fuel_gauge: Constify platform_device_id
Date: Sun, 24 May 2015 21:40:51 +0200
Message-ID: <20150524194050.GC11066@earth>
References: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54207 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbbEXTlN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:41:13 -0400
Content-Disposition: inline
In-Reply-To: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, May 02, 2015 at 12:46:43AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Thanks, queued.

-- Sebastian

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYilCAAoJENju1/PIO/qaHtYP/R9uot7qpxxSqzBIoXmBCq9D
rmy+63Jz5ScZ4NEfIIHc5HDq68NM/SIf7cCCE/YSrkedBZMv2HRknjwzCOIxRgV0
wgK0JiEZe/Bkru3Eq8xVECv60Akng5yVZl3tRHV3tg3x2fNArT1PxaxH8I3KXXL6
2RjkC8LZcfe6DQn7u9GmpalFH9aW3pwCVOKr0wLPbA76Y+Y3ugFAYisM6gw20Uz2
fJETc1xr+LDjJ1HW6psBLOh4oZkplr4xIukSU1aJEFg4cdqSRPxa13+RX5fqv8/B
48km9uAKgLN/M6VNGt3dEipKAghOSbfda0T16fkmuU49iBpmN2mRBbSIYF86cU9U
wJffOzSQD884pJNR2b30BVywfu+IlJSp4IPECgggfk8/CXKgdYARB3/Vu9zGg8rc
xrf+aq34SKySph2LptPOsJR5zakTESEcgleBabKKYEjmQmqGsZVFF27ShwUSvdGj
0r8Fxqtbc1CfgjMkv7hU5cf/leQlPDYg7ZaMm9VsVb0idBnPbgQ35XPcJ3zAF+YC
1ky6hA0pgHQuvHNOMr92Qdj2f448Xpu68CaKxNmweIPaxKkn7aqULAk6MKm/wft3
3Xit6CmSupPl0vX+YVn4xggUKYoCi6B+NOIQ1gCGQvpYL1Ud6iJNkUefwPNQhRhC
L4DRJgcqjEpyHtaz4reW
=EQvB
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
