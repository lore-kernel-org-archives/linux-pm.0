Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562823D2AB;
	Fri,  6 Mar 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825608; cv=none; b=kmsTq+xeqhDCx+IwfCtoigszzheDaLCpKbXjwFtvEstGqb/rSlhPB+Ce6KyEDkArhFpdazVwjI9Le/E/Zu1IX5khRyZCDfc6y+9jjho4TrX93x4ptHO5wlm4jvw9hjw7pKNIfnvIRDHuJBv5542rmrRQwQNbGYvJWcJeatwvkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825608; c=relaxed/simple;
	bh=F0tcM+0aLtyu9+sy+4raX3Cn0ZsSeO8j8SqZmuvw1uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJXqZ8cGsF1X/LsvtjLqRta7iKHf4JAmvdT32zcbh3IXcTufTIlIhIDGUyMXs4j7OFKTi2EObzM8x35jzlHzNkFOZdneU8aARgXdNwrPb8Tt35F4kQFXHihTNX9jeqSfy2hwUPOql9sX5j7+IEz9H8Yb2L0s2Afmt9WwHjw6JWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTOjsbKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTOjsbKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E51AC4CEF7;
	Fri,  6 Mar 2026 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772825607;
	bh=F0tcM+0aLtyu9+sy+4raX3Cn0ZsSeO8j8SqZmuvw1uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTOjsbKgBgOw9uUr54vBA4E5HBdfPYtwFOZNctHClWMTzUryPUoD91QnCIBXGig0h
	 M78ldaSAWi93zFGxwhzJm5cl5Fd7aggnXGYij8ho+2RsK+z6nMaoUY1qPtjSj6P31q
	 Fbgc8zFRQdN3t+/H6wwnOYQraPBvumcBUuHtLJtnapGl5evH+NOtYw4c86dsn9x3Hv
	 l0c9snZCyBSxx35jOxiLK4IfHupcIzAS3Lh1j0pvUaDx40gc3vlDFAjiuHuwkIHc6H
	 uYyLTeA/We0gw/DQiFJ5F65Qo5gwUqXwF2cY9c2nMixAbjXQ2jxU9ZRly0Nk2KxZbH
	 1xE7atDy5yCDw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 8C0971AC52D4; Fri, 06 Mar 2026 19:33:14 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:33:14 +0000
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
Subject: Re: [PATCH v2 02/11] regulator: bq257xx: Remove reference to the
 parent MFD's dev
Message-ID: <aasr-tgjMg1bZfe6@sirena.co.uk>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
 <20260306-bq25792-v2-2-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VpFhgN6x+jAiy75m"
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-2-6595249d6e6f@flipper.net>
X-Cookie: Think big.  Pollute the Mississippi.


--VpFhgN6x+jAiy75m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2026 at 06:33:02PM +0400, Alexey Charkov wrote:
> Drop the ->bq field from the platform data of the bq257xx regulator driver,
> which was only used to get the regmap of the parent MFD device, and use the
> regmap from the regulator_dev instead, slimming down the code a bit.

Acked-by: Mark Brown <broonie@kernel.org>

--VpFhgN6x+jAiy75m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrK/kACgkQJNaLcl1U
h9AHgwf/QpvfnzNs9Gq4PTDZoePPZUCcfU+/w6q8CtE8ci9Ii4+mP1eR73TQG+R/
M5jTgaP+8g4cwAF5ZxpRSfhJyeCj5OqQsbwPjgu+5yRWdm29z5OBWsDjwmJIoeTU
mTfkoOFbdnymcDxSgsW5qKvIkbyNuD9TDjwfqVEUEk6nddxKYmIkD8v9UUBzWbeQ
81HJot+TdEbgw3Ev1kNo/5FNgB/iJSdf+hNsLO2E5kyilEfIMFuZgX6AFJazGhRp
IWmGM0EIpdeIkZqwq+FHMZXhrL3vg/T/F1aolnV0yBTL9HyDdaKRt39NSjNhQnjO
jAKZ3RlFkbxhe/+vj9R8skALL+vJ1A==
=7ziW
-----END PGP SIGNATURE-----

--VpFhgN6x+jAiy75m--
