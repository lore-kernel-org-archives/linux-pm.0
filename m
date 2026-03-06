Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EA2253A1;
	Fri,  6 Mar 2026 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825630; cv=none; b=f2VgBThBA/pUYv+IpvjeHMoR39OytBq1uqLaHoVl1BtS1evEjDCS4I24q6iWBPuBlaDe6DrOwuunY6GQi4tGTeRr9liUp1UdrvK9heSr+xX2OmpQOknYuHagpiUb6c2I/ldqr+2e/TzbCwNU01JL8C7CLB4/1BB+4dyLgjWAtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825630; c=relaxed/simple;
	bh=MZYR8UjO1La/uOwjFhABrV8pmfgmFz8BISXIR0unh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtSQ70v4yFrUAxlZFFrGFnrF9vySxk3y/9TpByTVPg6kNrb/DdgIzzfOkbEsQRDXJEDjvoOPJRHbzBuEejxJCftbRuS/hb7sRR32vgTYYZ3DiUl5uFnt11S0Ogew3IzqMNnuUaGVq1N2+QSx6aO/SGayP5DVkg5FlUeO+fcVbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5PoroOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5PoroOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B2C4CEF7;
	Fri,  6 Mar 2026 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772825630;
	bh=MZYR8UjO1La/uOwjFhABrV8pmfgmFz8BISXIR0unh0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5PoroOrf8PSKKSfeRDJLJwzBcKqrmtpw66+rADFEj8mFz18aD5kInLOGgqwWl6yQ
	 p+2gBmM8LEwDDlnEGcRrqxQtObr7EWvH2vse3P/4cShCygNF+nEPlNzS8xWDrdPIip
	 IF861GA6+iepIqsaEjZPrQbMpHbDX/NR0qUSwKrPbO1+X46aR2Vw43j5iQGNJ+JAWA
	 b4bS7GdDuqsS5ndIUEhy5xVUpSQq8NY1GyoLQJxSTlzDVnlQbLl74GzmTEeV4jBBFu
	 iiYdSGw28xj6au5tKuWow/Tt5NU0LokFsOo9Q1snx0CGKbPaDKyip/clLGIaywB1tb
	 ra05TUHmn3qfQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id CBA901AC52D4; Fri, 06 Mar 2026 19:33:40 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:33:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/11] regulator: bq257xx: Drop the regulator_dev from
 the driver data
Message-ID: <aassFFJ6-dlvwaqS@sirena.co.uk>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
 <20260306-bq25792-v2-3-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JBm7Cga1uIFwkQ+t"
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-3-6595249d6e6f@flipper.net>
X-Cookie: Think big.  Pollute the Mississippi.


--JBm7Cga1uIFwkQ+t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2026 at 06:33:03PM +0400, Alexey Charkov wrote:
> The field was not used anywhere in the driver, so just drop it. This helps
> further slim down the platform data structure.

Acked-by: Mark Brown <broonie@kernel.org>

--JBm7Cga1uIFwkQ+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrLBQACgkQJNaLcl1U
h9B2PAgAhaetfKvXEytptcp9/87wybVarYpmQ6hBHa6DV5DBc9VqQwI3Pv3LTI33
csl4wmhZKCMCEetk2p2o4LLKhmPfqelFy2zngGm5nEYN8Idi3G6SEgqD0C+TLmA9
d7wKeT2Vl/exX9crYBXauRSF70eWXS2/1iwRyvGkXfaB6PQCRNSzLXWYfOfCyHNQ
SkIh2w9+WkY3VycLsdJXNSsGHk66dTRjs5WWYDZ1yt7d/mej88JCVtVcT7IRpHyG
/N4DBjcJ4IpldaoDL1LEN5wtlRa82QkK3cx0GVPAkDIVTlrBh+o7zgUOtO2h0qrl
foGw3J8725eAA1znMJNWbN5uDvDTlg==
=yOsW
-----END PGP SIGNATURE-----

--JBm7Cga1uIFwkQ+t--
