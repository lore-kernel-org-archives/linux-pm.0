From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] power: supply: axp288_fuel_gauge: Read 12 bit values
 2 registers at a time
Date: Sat, 17 Dec 2016 15:58:29 +0100
Message-ID: <20161217145829.3hlys43tnqzjuxuo@earth>
References: <20161214163853.454-1-hdegoede@redhat.com>
 <20161214163853.454-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ernmdlox2qqwtrz2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756275AbcLQO6f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Dec 2016 09:58:35 -0500
Content-Disposition: inline
In-Reply-To: <20161214163853.454-3-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org


--ernmdlox2qqwtrz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 05:38:52PM +0100, Hans de Goede wrote:
> In order for the MSB -> LSB latching to work correctly we must read the
> 2 8 bit registers of a 12 bit value in one consecutive read.
>=20
> This fixes voltage_ocv reporting inconsistent values on my tablet.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--ernmdlox2qqwtrz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVUpUACgkQ2O7X88g7
+pqdnA//bKriiZtdVYh9w3wOgUHH07a+otUjokgCyeZY5yRms+UElIe9nunMn9bb
CU3ISQ+9ZWGEig/8hjlZvQRZ1VW6rJTUDmSHiMv5gpbmwjg2brwZl2ba/7K/InBx
3ko/1e+fQq96rUL9RT4aBUpHDScGmauEzNuq5KUFzl6gK9/LttVSSHtohLS4tqOA
sBQBjyiKi4Imj0GALxWGiAwHapcVckSy7lIpn2A7Q7ZtwaUvQqK1kE4j1+wqMEb4
lCxjm54kH/sQw5Oi+FVu8rT7U5OwYY8KP7kzjgAnvTfKZn3jbrD/1asRqrWXqEJL
799mpeUWX3sba3nRNimscoTtekrk4q2IjkAT/p34y2/CzG29p9DWRPffF39EijQh
cyV0DNWX49I4fRCpVggoZRPbyHQcaHDZmy+l4TtAqGhJllMm9L04c4zOxSHQotno
S+72g8btQdxXD0Pw5+3LqLXlfjShw9Nw/bdGWaEyIOIK5wW+dogbAr7u5qqt3D0Q
iDYq7ijtD8iJ+dlG1E8XxW4TrQfsdPfWC38qR1zw0UxfHT0D/4H84U5YbFvmS80W
zunPYp/amP6hmc9cCvL4UatTvZfG+fVcTqasfyxNI6KmD9g5aJ6xWS/sK9ZeROpc
dSb4FioE/TnOrszPmMC4/Y/JvdY1d9RDMJRnvsS/bTDNPuJc3C4=
=Lc6+
-----END PGP SIGNATURE-----

--ernmdlox2qqwtrz2--
