Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A553A5E90
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356598; cv=none; b=VwQfWlsgURKzjSHtCgpvkX+gDKSvG77Ii/mgQjNrD6bXA4yEvRIgvyPF9jCx9qpuYlhPLS/Fi7YRKELKFs2MGmVbiWw3q3z6EVt3ue4QfBGGXKR9dNeUCiTebpqN7vmKeeSUryLs92QOON6Tp5FFQMSSm2xXP8/ggVjLYQGJFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356598; c=relaxed/simple;
	bh=BfIxQcsUpQR7yGmqTVW2AbmmE/cqjCymxlvX++/gW7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt5XBEe1EqrTwgOV8UnOvdGpWo0SWEg3Foha6abadGnmWV/M5/YVYUWySxb7ILV+R1WKCuB0s5OWCc7D1X5zB1JASEJHau9vTsbjJIOO1Q3/ao3HsT5V2ZJhMqkH48xKa9mCMdjCCipZcxtX6a4JftfAXa5M8K//1svMhGOEvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zt7kOVOc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zt7kOVOc"
Date: Mon, 10 Aug 2026 13:09:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786356593; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=NFRBGj6xZQjiu4PpczKHqS5R8RXoFOjImZ2eD8ddS6s=;
	b=Zt7kOVOceAfMchEAt9/V9kfb+Q59rCrZW/+dgnhc3KKK5doeAgTgpM/sT0Ht1uuZxPtA3b
	GgSrYZyYlZyYvc5/Vzjo7p8UFLvwiCW4Vu5wv1h1dcEewffnidImNuOWum2e7yZGl2Nx0T
	5bJnwirIIDUnSUYCGfmYfL96T86gEhA=
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
Subject: [PATCH 4/5] power: supply: bd71828: Do not hide errors
Message-ID: <22db56cf35252d2d8f67828a0554e8daac7ae251.1786356145.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CaP5KfQN4JEx3u+C"
Content-Disposition: inline
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--CaP5KfQN4JEx3u+C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The bd71828 reports success / continues operation even when some regmap
operations fail. This can lead incorrect data to be reported.

Return appropriate errors when operations fail.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
---
 drivers/power/supply/bd71828-power.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index a564ad7210be..589e12225cb2 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -456,8 +456,10 @@ static int bd71828_charger_get_property(struct power_s=
upply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret =3D get_chg_online(pwr, &online);
-		if (!ret)
-			val->intval =3D online;
+		if (ret)
+			return ret;
+
+		val->intval =3D online;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret =3D bd7182x_read16_himask(pwr, pwr->regs->vdcin,
@@ -1218,7 +1220,9 @@ static int bd71828_power_probe(struct platform_device=
 *pdev)
 		return dev_err_probe(&pdev->dev, ret, "sense resistor missing\n");
=20
 	dev_set_drvdata(&pdev->dev, pwr);
-	bd71828_init_hardware(pwr);
+	ret =3D bd71828_init_hardware(pwr);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "hardware init failed\n");
=20
 	bat_cfg.drv_data	=3D pwr;
 	bat_cfg.fwnode		=3D dev_fwnode(&pdev->dev);
--=20
2.55.0


--CaP5KfQN4JEx3u+C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5o2kACgkQeFA3/03a
ocWkegf/YusS2b56gPOHzH39KEPYRN7NDbriYotkZPFsK7i0B2/rnIjRVuCk+vbN
MinJaMD103QjsKeqf8K4U77m/cD1L58DBRLc/12A0Qi29/zEUe6OSuSIdlADRi+g
jFvzMhoSGn8kNKcszF43iPO56N7/9VBq8pNyMyxSehSRK0x0ID0JmO3KCEnnqiBE
zOfDJCWq6Abh8LFFg9hKCUHSvrqyY3HHY9L7qHkHwks8BRqT1n5rGU/hr82MeYEG
Wd/3taohyZHT/s+Z8Ew7jjDkJOgFq0Xv05RHZgdrXjZHKj7ep9Ndso8tHxuGsaPK
q7PYyEmqsiiIYCbg2fqwDVe99yx+ag==
=a2Co
-----END PGP SIGNATURE-----

--CaP5KfQN4JEx3u+C--
