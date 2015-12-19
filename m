From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: s3c2410: remove superfluous runtime PM calls
Date: Sat, 19 Dec 2015 11:52:13 +0100
Message-ID: <20151219105213.GB2571@katana>
References: <1450203249-4873-1-git-send-email-wsa@the-dreams.de>
 <56716CC3.50309@samsung.com>
 <20151217094655.GV6058@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49338 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbbLSKwT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 19 Dec 2015 05:52:19 -0500
Content-Disposition: inline
In-Reply-To: <20151217094655.GV6058@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2015 at 09:46:55AM +0000, Charles Keepax wrote:
> On Wed, Dec 16, 2015 at 02:53:07PM +0100, Sylwester Nawrocki wrote:
> > On 15/12/15 19:14, Wolfram Sang wrote:
> > > Since commit 6ada5c1e1b077a ("i2c: Mark adapter devices with
> > > pm_runtime_no_callbacks"), runtime PM on adapters turned into a no-op.
> > > So, we can remove these calls.
> >=20
> > Won't this break i2c client devices that use runtime PM? Not sure
> > if any cases of such client exist now, I'll try to find some time
> > to test this change.
> >=20
>=20
> Our CODECs can be controlled over I2C and use runtime PM.
> However, this change doesn't seem to have any adverse effect on
> them that I can find.
>=20
> Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks for testing!


--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWdTbdAAoJEBQN5MwUoCm219IP/AwBCgzzMaywq48ncGXxCOcL
drG3N1nnooASYOe5+7xycgecMFMucraceXyKrpjQUMhI2zd2tX4TdCBKkKcwB06x
rPzamaXbe035eagxzlE/ku7JDzezLcTnURjMs5aWG1AWc66lTHY82nVENM6Dg0vt
m5cBn36r+n6jf18BseBBW0pGzjsjJNvDxTORXzPKDeNQ70bxHY3ksL9sdzRhvYr9
orH5Vy4075EkcfyK0S+4lglU546mYpSB7Yd3m9PJ0tsmokJMP8BprKFLj+3pxcOC
2kht/qcbJFPT8alI7b60f2S9H/bTa+fa7GPrfFlvDW/NWDHMf1dVWg7s2NyVYGe/
sAWzzHN9X0VyCFhoTiOXMpiVpB1zAduSWlcbBZqp2nfDWAEJl7cxY1gKtJQ2N0dn
jF5MdtSJ4dSnimSCMOfINaSBdzSEcFf+Cmk8QVb1fM2lat+b0+dQwWNNQPRtkHfY
DVpJc8H27l6/Ely/RPxugInUjj0i++KuUkwovZz73u9Gl5N0wO70zVER/T1yKWM8
QUjB3UCpGh+4BqTT8iTlwkEFcdB9RGIH+7cbzSMG7dA6Oyp5hOvUXYEY7BE1qMy0
83GbogvU7GOU/cnhKhKIpMT4rcULVrZe2OfNlwXhcpvcLMdtpMrlcCazG8G3O0ij
zdxn5fRQorSZFJFbkyES
=buqW
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
