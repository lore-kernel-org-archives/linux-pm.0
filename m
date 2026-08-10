Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7243AEF56
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356558; cv=none; b=oVDfitBxYU07Ja1rXFKqHz2lw6GsHpffPaM4G1RNOtrb5b9v7H5hfCH5gp6RiUb6hL6KAEceO7MzQg/oQDzhd0bW+1h+I8d0P5HG/hkd+6ecOibyBHwTFdSpnKzZaWUZu9+5xy3QxzmUIl5WZ2PTFq0BD1O7TI0N52VDNIkdE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356558; c=relaxed/simple;
	bh=rJMKqi1RQ+r8HBj6LdDWxjQiZSQTvhLNXYkiKbR7cx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndVrbrgTXeuYw3KV6vwC4U7w6JojrVD7CSMcJ87Y9YS/Ojyu912ZutSjvRVb4qgmh6k7w8FO1xnRyLl77xe01ML31RDbDlnRLx/clTmeQZPZa3JXLXGgtOZh1M6/yl7dzbYWZz9AMLXkaD/QyMC0UWu64bCDR4+IL7e4FgyzjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wZlRmTrS; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wZlRmTrS"
Date: Mon, 10 Aug 2026 13:09:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786356554; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=Y1yGt+S9JJknR1LW14cAZVW+BNXaBFfxZpcwQyLkFks=;
	b=wZlRmTrSBens0IgXrRy57LiLLqA97D5GqQFTbjFVHKe3EkASTwcydyVupNxxYKylDhlE60
	KZwCw/ve4mP8alZMwd2cFgw5Zz69p4+jPf15vWb8/d4IkGC4BD57FyST/5MMYgZPYp2npa
	N6d8Z9gseD+rIaMiuZ6hQ6DMeKAp39A=
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
Subject: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQvgCqlg8fvQTwot"
Content-Disposition: inline
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--QQvgCqlg8fvQTwot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

Both the current and the average current registers contain same
'direction' -bit to denote the direction of the current. The code
reading these registers incorrectly caches the direction read from the
first register, and uses it also for the second.

Fix this by initializing the direction bit for both register reads.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
---
 drivers/power/supply/bd71828-power.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index e1ae5fe52e1d..9927a7e8934a 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -192,12 +192,13 @@ static int bd71828_get_current_ds_adc(struct bd71828_=
power *pwr, int *curr, int
 {
 	__be16 tmp_curr;
 	char *tmp =3D (char *)&tmp_curr;
-	int dir =3D 1;
 	int regs[] =3D { pwr->regs->ibat, pwr->regs->ibat_avg };
 	int *vals[] =3D { curr, curr_avg };
 	int ret, i;
=20
-	for (dir =3D 1, i =3D 0; i < ARRAY_SIZE(regs); i++) {
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {
+		int dir =3D 1;
+
 		ret =3D regmap_bulk_read(pwr->regmap, regs[i], &tmp_curr,
 				       sizeof(tmp_curr));
 		if (ret)
--=20
2.55.0


--QQvgCqlg8fvQTwot
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5o0MACgkQeFA3/03a
ocUZFgf/Zg6Rh9shYDmlINQupUAFf/r5pvtrAmiz8MuDkHk06olBAEcBtAlXxDSF
wp9aeNxH2IP2DN7Wd88y6zZX3RAR7opoy1cg8T5kG+c8nAFUGikFRIIITmcOiJU2
TkL8ClovN+cGXPTxB2IP9QaIfeaROlsgci8O1NoHy5ntQt9u8qi+u/DDmiLeZApx
GsebcxWxqMBWQ4XZK74ZBeoEOh5Q/hcYq+uNloHoRx26dcUxH1I08IL+jtYJIFRJ
cqQK9lsYnovYy3soSr9rNHd60tyNys8sLwVAToC7kfYq5yHP1N2vhqoxOJow0VHF
98tURUYxXlDozOi51BQMXZfasDd1+w==
=5BC8
-----END PGP SIGNATURE-----

--QQvgCqlg8fvQTwot--
