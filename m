Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7035C695;
	Mon, 10 Aug 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356542; cv=none; b=uwaG6FJqjhavFkK65afL0ghwyPUUk9RjRQG4okZEjKmfYHwP8eQBw/qT3/QwQRX9GwZAzDOjEuh7MSyS9KLHnH1+SDy2RLJAKk3bOWHdDo9VaInV1fVR4X+VXfvB4SJk/DWghsWSASY6rrVQ9B9hBGzOZmy+NuB3iKQRpgt9sVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356542; c=relaxed/simple;
	bh=NPTw5Qkru5xKUyLBUaN5xRLF7avhUkcIM9QkhHIE8u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH4F591Zps8ma5wZlKJZyA4lFz6P/J/JjMS9iA/sKesDIvbqEyUMaJJL+Z1Bfx4oiRvEj3FG4pESJ4kK0ZZNNzG8zWbXqmpzO2UYZUgaem2Dc9zG7SDzRYc+/HHVY79HQnN6Icy5j43H0bshFmUKQUfuFFYZXk6P8y91bnavGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tsz+PLM+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tsz+PLM+"
Date: Mon, 10 Aug 2026 13:08:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786356538; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=WUFkLgZPFib4GyFOfx2B4fKRRRwlTZ/sdM/18oq88ac=;
	b=tsz+PLM+md34pqEVYpQuWInMECD3M/mHxaOobcIFT6kk/33bq/vWhCO73Lajyp3t30XLtQ
	+dEsvm45j+8Q31TpRkhwjz3lCFyvm5nlnnsW1Y7+Yd4kqWaVB4GI7zRrhNc9WVi0qzDEdU
	U/CUWDZN65A1a7y3nc5rCzNLX5f0/5k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>,
	Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
	Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: [PATCH 1/5] power: supply: bd71815: Fix temperature reading
Message-ID: <4ae3dfa7fc80372977fd29c837321f96d551bf6f.1786356145.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aKLRCn6ZdE2XSj5b"
Content-Disposition: inline
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--aKLRCn6ZdE2XSj5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The temperature read from the hardware is never returned to caller.
Furthermore, the check for temperature validity is wrong. This yields
garbage value to be returned to caller, and also detection of
bad values read from hardware to fail.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
---
 drivers/power/supply/bd71828-power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index b671563ead79..e1ae5fe52e1d 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -225,13 +225,13 @@ static int bd71815_get_temp(struct bd71828_power *pwr=
, int *temp)
 	if (ret)
 		return ret;
=20
-	t =3D 200 - t;
-
 	if (t > 200) {
 		dev_err(pwr->dev, "Failed to read battery temperature\n");
 		return -ENODATA;
 	}
=20
+	*temp =3D 200 - t;
+
 	return 0;
 }
=20
--=20
2.55.0


--aKLRCn6ZdE2XSj5b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5ozIACgkQeFA3/03a
ocV9YQf8CLDbHJPBz8vpbr529zmDRfanqifT+ZAwCSeDcpcTh2zFiuzNOZJjkjN+
0F6RO6RMiQar2DepGjbtgzg9Xd9cUT31CLZxVJgwKj2yR3BzDCnYX5N/FwaFkWu3
OiLdBD2PYzrfJfG+zH/rhOT6+bag0FE/Jxs5feqnmFkov+nIZhCjKSCWD530JmnF
DCE+/Gpaq2XbKrmWK+ZV9HcMGJ6swJkudjHudtAnSxm1pjqY/QRoHqYUbLZjm1ru
I2F/0AeAp6IOHwoyHuYYf6l+kBJx5afo/o2BCMKC0C8BNbJlWM1uB/3vMY/y1pJ1
onjVwD5krcCXc1t7AhTwCxY8gLwLLw==
=XESO
-----END PGP SIGNATURE-----

--aKLRCn6ZdE2XSj5b--
