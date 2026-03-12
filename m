Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043A23BCED;
	Thu, 12 Mar 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321049; cv=none; b=SJq8VzpOvitOMQd3Ljea6LKSs63XAP5S6DA76bPAEUO2WtIu69vNkNY9UjECduzZ/zLOYTdCg6lkrfZZ/rsR+tm7o3e+m16c0u9CaswqVceUhKe94B8bpm2s9EN83LfRg7dMh0NzEaXPaH1Tf5nO/7diOX1J4KfJHVWqMl0BYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321049; c=relaxed/simple;
	bh=knQrS10xE8pCiFxKeddUKvT0NROChU5ox+YUb1+I4Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDpMnPa2WKWn+I1wyc22jCV5SRSeo+QzVfpVxKbVT8b6mXDiekGsRLX5FNeqrduRmR0omP40kvVVZ4bA/tWAkoKSHTuTDCbys4yuyGTx1bVs8C5B0jMYJ9KnxMSa9VJLOpppw8ljFr4idVSO8cYVtWV9rL+9n7UWAQkUBexQ/Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/PFIyj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/PFIyj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87868C2BC86;
	Thu, 12 Mar 2026 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773321048;
	bh=knQrS10xE8pCiFxKeddUKvT0NROChU5ox+YUb1+I4Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/PFIyj91n4cjwbkmFrtz1Zp7ltSngsuz/KUHloIpRJcdahbkIMAiUXROd+gGnVOb
	 Iw1Iwc0yAYWvNNZj178FpoLhC5TYOP7Pmp1fvWRDqKAhRMDg2WEuxAeCb6MGSU+Egk
	 73pdalxpbDWCtEsQSVXUKwDlYH4Y0Kha4cPztJa4sDX6hpbUPusZIkB1784SyljfPI
	 4ghgvGGPrpjQ8jiHYiC6WIp9P/SdZcDym9Br0ffyKZF1aEOJDShPudm+SEdxa1e666
	 oUO3wjvTpZz7btpB1PIgJk2lhCAtBhOW9K/0XQJ0gA1R51AQv5NUJOana1FjpgzVs1
	 R1gBn/o3oM87A==
Date: Thu, 12 Mar 2026 13:10:41 +0000
From: Mark Brown <broonie@kernel.org>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v8 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
Message-ID: <500e053a-9919-4c63-a042-30a5e5f09c6f@sirena.org.uk>
References: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
 <20260224-max77759-charger-v8-4-eb86bd570e9c@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z6vnm6QHpA1WTayS"
Content-Disposition: inline
In-Reply-To: <20260224-max77759-charger-v8-4-eb86bd570e9c@google.com>
X-Cookie: I feel better about world problems now!


--z6vnm6QHpA1WTayS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 01:45:34AM +0000, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add a helper function to find the selector for a given value in a linear
> range array. The selector should be such that the value it represents
> should be higher or equal to the given value.

Acked-by: Mark Brown <broonie@kernel.org>

--z6vnm6QHpA1WTayS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmyu1EACgkQJNaLcl1U
h9BlIgf/WMBGgptFYb7yIkxGUKOn+mEm5q45nldetnrV4TDR6/fAFjQxqU/GOzxS
+RPqXEnr6F/3iDWu5WJimjJi9gjJmxkw52yeg39ccZj3DOA2IrooBLGMRFMOqaj6
CVnKmk6oOv71y0xclOYuRpt3je4UIYAwViaJds5ASxPTi2qnDSmjDVez2iBwbuwr
FJZKbzW7hqrcGiRLLkU5TS1+BzMSP/G1ErzLcduQ24Vtc5zwys6wpnkny7ma8URw
eQVUJX+avpSiNGQxBSlOcFUypkh9ISW7OVo67fk76i9MfPiIJZw+g9YtwPKmq7pG
2YWuApGAT4LC24MHQDEFu9Umvmuvqg==
=sJI6
-----END PGP SIGNATURE-----

--z6vnm6QHpA1WTayS--
