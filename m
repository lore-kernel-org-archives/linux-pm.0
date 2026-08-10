Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150935C695
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356579; cv=none; b=Vtz52Ur6w49cTiHdcBfRiQ1MSz1F9uH3qvE+hPgH9MrJORV0+s2DpxOeFfLHygn8hCWrq1x5JnH1YjNVCcdwGDZFONGCNV35MVvDK1xD9uFs16J4gmG4+LQMiVMYESRB1jF7zAAVJdjC/eeyyIBSwcgECSF5CbOshrXm7BrltSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356579; c=relaxed/simple;
	bh=bdJ/iNaaamNGNmZ2H9h9dvPY80VOXODcOnZlru2LcxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6Ity5mgNL7EynwPgpOztwBVRgEuqrVO7pHukWE5kT22/kofH0xFkkehuhe2zPRqc6AZfh6hPjCcyb5FGDmEN9/WkOJe5Y49hCroE+HUEzNgb6SsfqCMBu6l4RXuR4CEpgccEFwcChgxl+BtuwNSFsBUmR45NPdyEgP6uvXw0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YUN/ocF+; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YUN/ocF+"
Date: Mon, 10 Aug 2026 13:09:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786356574; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=JhIBN1tfwNjQw86bei0syRvcG5esJBYJHLXucToUKvw=;
	b=YUN/ocF+0UX5yKSb8etgJ5OCNL4oBx2pOTg3Hw05ETBIQxTxhb/OJh/Iv8Tay/nvJh3FuP
	iXe28rYbEcEYq/oC7BYMdQ53sbLJ5TTk940SSOhJjmdYBdeCgxhpzuGTzaGmiMOEj4Jwrz
	M/Ug0EVnZtc1jTd0OXKJZuotjzSCjds=
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
Subject: [PATCH 3/5] power: supply: bd71828: Drop duplicate power-supply
 property
Message-ID: <518283ec9163943fcd1b53ad61fc3025fd346d83.1786356145.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J+1SLjX5CXTuD2Ot"
Content-Disposition: inline
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--J+1SLjX5CXTuD2Ot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The POWER_SUPPLY_PROP_HEALTH is added into property-array twice.

Drop the duplicate property.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
---
 drivers/power/supply/bd71828-power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index 9927a7e8934a..a564ad7210be 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -640,7 +640,6 @@ static const enum power_supply_property bd71828_charger=
_props[] =3D {
=20
 static const enum power_supply_property bd71828_battery_props[] =3D {
 	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
--=20
2.55.0


--J+1SLjX5CXTuD2Ot
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5o1UACgkQeFA3/03a
ocWt4ggAnVpObjKYN4msQv53bhqAvL2VPnVv/a3nPPEhhsPo30EbrjkDi1BRdLWD
Ku4JQvUbHQNMcOe5UQwiLgEsF0HbY2QQcJ72lo69mmdMTGnlT7es04IIzMIRjf/v
Moema50xinlgYgN0qEhqUG0/k/5aR9QZH462R/RV1YxrDSe5WAvVMkAWYC51VKap
cLcrRs15lzqZRcBYVSRRcPJMVHLz/j+UExCIMKN2Nwl+p5pKxWRWGNeSmwMQteQO
NkteYeoLsCSZzZBVVtgi/VVvriGwB9aINuM1i/KYwao8OJGA5fJWiZUnFsUBqaY7
Eev4KyWp0mwkH074GQCGBZCudd3BRg==
=Es2w
-----END PGP SIGNATURE-----

--J+1SLjX5CXTuD2Ot--
