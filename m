Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34B421EF2;
	Fri,  6 Mar 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825910; cv=none; b=AouDqlasf4+33le9e+H3lOcA3zJP+X8Imw4cnkGMRma+/ozHIdr+bGeqd5/mthIVbs3xyowd7gQQXHX+5ycYsf8yNx2Exp1I86R5UrGMsQkRv9SwaCeybG7K5xZahePnTXdSc8FkZ8n3tGG59eFCPvFEVjq6x34L8KF6dZZwEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825910; c=relaxed/simple;
	bh=F+VsyjDnhdkVtoTzKqInIT/SRhhmu7vdgTUKD9Z0BtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQTFrbDU0lS6Snl62Ab9zl4bNaHY3CUI9nesFQASv6st1X9ickiG7gOz825mWOlTFVNJ53RD/+QgI9G+emylgtOvGKbRXiagPuB56B9E7zF40FCAbMflRpAITC54YemM8/4jj+kub14hUagcizyy4rCP3kgp5Cnh/fVdzysASaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKJd9ySz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKJd9ySz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE88C4CEF7;
	Fri,  6 Mar 2026 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772825909;
	bh=F+VsyjDnhdkVtoTzKqInIT/SRhhmu7vdgTUKD9Z0BtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKJd9ySzFZ21s8mvGp2vTfJMyYKdGw1nQAk72QrSG6ENLAQ9nZO2eJOkYeu5cSsNz
	 6fvckxU849KXZdlvy32jwjmLbF+INhYPMh4LeDq8wgjw5kNCw1OaCR6RVmuwNC5R87
	 QCH+sxIu6RcvoA/QEYyDMwZY6PceWtS9ChjKa95Nsp+L5pEpJvY8QGiBKoondwt7xa
	 WGaiTueiS1CXyKcTTuoaDNHjhl8xvSLeAilDHyUaWF3uiMWjl8SN6ZfrMIA7nw2hxs
	 mHjNrb2gvU8FYN1RYKcQEFdthNJJhLK9AphwvR+A5IOYqPmlzTLBJYc8hqEl5lrWMC
	 5yCgg8tmISoNA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 032AC1AC52CF; Fri, 06 Mar 2026 19:38:16 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:38:16 +0000
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
Subject: Re: [PATCH v2 10/11] regulator: bq257xx: Add support for BQ25792
Message-ID: <aastKJcP9qWiC_BJ@sirena.co.uk>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
 <20260306-bq25792-v2-10-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lUij+DOArCeRJ5l"
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-10-6595249d6e6f@flipper.net>
X-Cookie: Think big.  Pollute the Mississippi.


--5lUij+DOArCeRJ5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2026 at 06:33:10PM +0400, Alexey Charkov wrote:

> Add support for TI BQ25792, an integrated battery charger and buck/boost
> regulator. This enables VBUS output from the charger's boost converter
> for use in USB OTG applications, supporting 2.8-22V output at up to 3.32A
> with 10mV and 40mA resolution.

Acked-by: Mark Brown <broonie@kernel.org>

--5lUij+DOArCeRJ5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrLSgACgkQJNaLcl1U
h9B96gf+OfNVXHunpRVgnes9KGJMs6DlXoCfc1bwDuys0Tf55VGzXUJF8+vdTbna
C6ZGDhwxzEptPzWAkoWrjPY0wJlBKLd8b1TFbdeYP48cv8sph3/cQyEE7YsuLWob
6eADAOUtp+MFUiGQ2grTTZZjGhOJ2He6LkCXJWRXQ2i/rrDu2VHkK5DzMAYBBFJc
cKX1jviockEjkuGnkGwPBMlNLPLn07tANNUt8na2f5CPgsYDlMJ6ZV+53xwwiHWw
I86tBskBuWjIYNUsHL0//j2BhZpnnia7sJwPzaAFLU+3j4AJ3cPpT0EjOkkybzu0
X0GWCz/3750N/JcvMbpKmXxMpEWKcA==
=iQCh
-----END PGP SIGNATURE-----

--5lUij+DOArCeRJ5l--
