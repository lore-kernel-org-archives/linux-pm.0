Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A733769FF;
	Fri, 21 Aug 2026 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332714; cv=none; b=k6jS6hBFVB9y1rp3eoNyYanOtqa5UZPwTxdObir6+nT1RVrOB1OsKPF6f/4kzlnp32JHuvnj5FDT19yNMTJgOltg/xl/SET+xTjA2aJc6/7UMVwe/lo5rlbtBVcHSbgA0655EiK2q+UvwUIjfxn4Le9DuydW9G6x0iAGrgNbIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332714; c=relaxed/simple;
	bh=GS1qQDP/Be5NshQnlyobrrr7FcIivBLhbPmcuwqsGhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjWOs4H6Nl2f3ZB+DE9+dfW1p2UwHXxpVIh05jKOW8q5FqDoVpsjXkBqK86GMGAEDDGOAPa5p8khGASDpqHOIlch/cdfugT9ItNi1ZF5jGn537AI2lDlrxvPlsit8lXuhHxyTgXs/t/pLr4MQayT4f1B8ViYpgt/zHAd/tj9jzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R46EMPu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R46EMPu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3FD1F000E9;
	Fri, 21 Aug 2026 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787332711;
	bh=GS1qQDP/Be5NshQnlyobrrr7FcIivBLhbPmcuwqsGhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R46EMPu2fmoIm4wL7snOkkb+y6mgk7Wp8/BLncHtQKvrebObI05Rd4Yvsx2sggW4N
	 r+kERmMd2NoPJgq5M+de3E/5oCIhBsi54wRE6Zvl5oFCI+qU+rZguTAF8MKV62DVmu
	 VpfIeDk4Xe+cay9Uf+FreiRW5XcneW01L/ZyrM1LDLEeVmavnb1OT4m/0oTYbqvK6L
	 8SHX0fR2eq3AzytoFtEhhhqr8xpe6PaqjBJbAt2xJK7sYYL74l7BlTNs6JHdjSusBd
	 aLEeOCCQuWh5PbD1Ll8mrTCv8DvmchEdokGErId6SB+Iyvbu0pKN3+U1vwAAgYlAcL
	 GKoW40aUX4C/w==
Date: Fri, 21 Aug 2026 18:18:27 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: amlogic: Add A9 thermal
 bindings
Message-ID: <20260821-envision-mousy-bef9a2c51e2f@spud>
References: <20260821-a9-thermal-v3-0-0e7abf3941e3@amlogic.com>
 <20260821-a9-thermal-v3-1-0e7abf3941e3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rBQNQ4cmFmVpeZDt"
Content-Disposition: inline
In-Reply-To: <20260821-a9-thermal-v3-1-0e7abf3941e3@amlogic.com>

--rBQNQ4cmFmVpeZDt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rBQNQ4cmFmVpeZDt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoiIYgAKCRB4tDGHoIJi
0ieYAP9rHImLhgtylICcvJnyJJVKYYhFsFpKMqhdSEs66+5r4AEA+DIUM4F6Cbsh
vRwJotnGqwmpDT4WSw83ag4UscMZHQI=
=gyny
-----END PGP SIGNATURE-----

--rBQNQ4cmFmVpeZDt--
