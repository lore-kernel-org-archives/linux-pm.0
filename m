From: Sebastian Reichel <sre@kernel.org>
Subject: power/reset: at91: big endian fixes for atsama5d3x
Date: Thu, 26 Mar 2015 15:59:26 +0100
Message-ID: <20150326145926.GB30183@earth>
Reply-To: 1427379382-25328-1-git-send-email-ben.dooks@codethink.co.uk
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56681 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbbCZO7y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Mar 2015 10:59:54 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-pm@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> power/reset: at91: big endian fixes for atsama5d3x
>
> Fix the passing of big endian data to routines that
> will be writing it to the bus in the wrong order.

Thanks, I applied your patch:

http://git.infradead.org/battery-2.6.git/commit/7be5ac2c32bd26c47a05367c0135cb6e67b3d452

-- Sebastian

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVFB7LAAoJENju1/PIO/qav4IQAKFHd/5tTJXS3Eha+NO/LLf/
KOn9SVz3MQTdXMXSuxnRk/mC0VnqNeCe/VbBX/1ycyNMFgWmM78gdDujfc6woCPz
3pyeKaWiD52nU83jOXli95zP3nQYZu5O3TXzat83BMoAB8quIJ46YOHzZetzcgtn
yS9xqAoKtF3+xiHD48mQVBrDW7p3dJAbcNWGX1PA5kb/e5Gkqg+I+oPhbNaRQIqi
7I42XnAgEw+GGvowRo9Juh20qqRGgLbNhGNMaawj7yHQmv4gTtDcDBDn++fD1Suu
D+loIsEzwouo1drV8g/8qhTc2+Km/EYVwyAkg40+amVlj8CEQ/EkHoNFYRPEAjCN
xyRVd5t5zcUhEWtOcxMmrmSh6jkrV6CXI9IXSY8ov4tJxUWKR93EJgJlrbTD2ekQ
1xYJa5qlRsnGr8xxGAwZ2+UNhMFMa3NGGTCeXawuiuA7iqcez9vk9DPHvfD6Q1jx
sfAUNUn6LK4z6vHYDyIZ7BRRadmMxuUGgmmSE3U0bSvF0N3Mi8L1VP3m/c6lUDpH
T/NQfM/YP5eDkBy+DR/p4P8wn0tGErllJ5uxX3iBk0yEcluY/sl999YFRhNE3gA4
9lI9kvrNA0qJNw2vXx0JolpzjdLc88xwvWnicXqHgtZ8OiRVZWxu0igXoI/pRzZj
0+b3fwoUIy+TYj3Nzpzw
=c1Kr
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
