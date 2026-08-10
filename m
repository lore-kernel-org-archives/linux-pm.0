Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB843B19A0
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356525; cv=none; b=bCteYDNxAiEVSbWB3C4XlQqg5JhqtoPFahzM3sniaJA3UZnvNHtjWTa3x+8NrZ1/Db5y1brG3xbNAt2CdWmMWF4gLbyjbLhsVGaKFsfcUAs36D3HVDJt1XS+IVtvLZHmFdxVQsA89FSuso7GgJJqV52l/FcfjLmgJsxIEE2GEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356525; c=relaxed/simple;
	bh=DPiRDDtz5pA9WdL8rKoOq8faDEfgAo2PF9GXza2w7Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OxytHM5ccBBSeyoQa97Wut61eAuKzr31IqpAM+S2TV/GkEQhlqKAIsItjrwLe0JK5KKoGrAzg/WrgbMwx4JDwlJkEsINRmxFiZnRQh+Tae9mmIrUAe9seczSqmUVocMPeUTSUkvQkaxYTJ7xuqRPx3GWQ4JpxrFy4ILvCZus8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pD2r552S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pD2r552S"
Date: Mon, 10 Aug 2026 13:08:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786356511; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=sxWiyOTJ0ecANLwplvFgnQeN37E5tT7Yh+ddmGjtf1U=;
	b=pD2r552SXBvVIEmVz7vHMt8A92iLKJx+lEBSIeqTTBoXd5vomE7bUbRmltlskpV5L0/dsH
	cIbfGdqh+EIMzVTr7V/A5fLZiue30Mbw+Cwqbc+vrNMc6pcWNAeeFKu+KCiatF+zpVOadd
	2xQLgtfVU+iQ6idaGAX9rZMHhaYwzRo=
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
Subject: [PATCH 0/5] ROHM bd71828 power-supply fixes
Message-ID: <cover.1786356145.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ToawdUVrBOwgPv2"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

--1ToawdUVrBOwgPv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a few issues from PSU drivers for ROHM components.

I hired couple of gnomes to work for me. :) (Ran AI reviews).
Unsurprizingly some bugs were spotted. Time to try fix mess (mostly) I
have (originally) authored.

Bugs were found by AI review but fixes are made by hand. Hence no
AI-tooling tags are added. Please, let me know if one is needed.

---

NOTE: Only _very_ shallow testing is done. Some of the fixes are not
tested in the hardware at all. All reviewing and testing is appreciated
as usual.

Matti Vaittinen (5):
  power: supply: bd71815: Fix temperature reading
  power: supply: bd71828: Fix current direction
  power: supply: bd71828: Drop duplicate power-supply property
  power: supply: bd71828: Do not hide errors
  power: supply: bd99954: Drop bad register fields

 drivers/power/supply/bd71828-power.c   | 20 ++++++++++++--------
 drivers/power/supply/bd99954-charger.h | 23 +----------------------
 2 files changed, 13 insertions(+), 30 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.55.0


--1ToawdUVrBOwgPv2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5owAACgkQeFA3/03a
ocW1Dgf/VXxDRQfM52CO0eDISA39sQdGeWTUSnFgbBJKRIVn2tXgmecmhdRpoUY2
b0L/RM2jDLoYwK5GolOMq6fFpC8lGadtBrBOsM3furmRcfp3w58gGJLDRzZ1W9Ub
lcfpfcGBCwD6Y+8JLO6/TNGQA6s2jAwJXaj8AWt6Hs9yMbGJl0BCKO7OJyCQ080f
JlBFs/e6zFDYj43gN3uDuw0q1FlZYNsEBTp25esgKPagRIkOapQy4BhleSh//MDw
atoogscEu4tSujTKqjQ3LFZpgqjr3nNWmst046ljvVJowcBoSEhzTQrt992SUF0d
SMeRcqe1OfOsY6cnhioWxkGt6SX8xQ==
=3GPu
-----END PGP SIGNATURE-----

--1ToawdUVrBOwgPv2--
