Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F533A9CB;
	Mon, 22 Jun 2026 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146707; cv=none; b=gQuNdZFHf4txQaGlWh2JlFaeubxZnDHjC/G0VUDGbhmAN5oXXq8g65DCRCQs2CWXLc0HJE3dauwYHm1glMdC5aY9y297RXD1WbJptWKtebKg3GVWBgQZNM65DBjU41tBWxvKFPZa3wGIxSlsLFMsYyNq3R8qlpXFUZ9RKNqPwKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146707; c=relaxed/simple;
	bh=zElci/os7/jfn0A3RRkTkeT4o+9LImhbDkPRqYp8/WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2phP6M05pKulUhZTwQrZW6KvU+RFE3+WrvsQinLA/mfac3aN1fg4j6W+Cc2IRkfPL+F6tDwns3WegW/ep5jkbPsnzwHM5ur+UE/dePRKvIWblEGYI2D64Q0CE0ar6inebavtw5XFUpLWqruN8L7YcYenCV83rJbSysZohPoSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRH30SM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRH30SM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747681F000E9;
	Mon, 22 Jun 2026 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146706;
	bh=zElci/os7/jfn0A3RRkTkeT4o+9LImhbDkPRqYp8/WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mRH30SM62YpD2Z+K9rgpoEji+0iTSa1+8T+yA1AiKDwhK88HqRGRtCmoCAzNk+UBq
	 yDePdxjlnviQRP5tviQOoQ0hkA++9MRNhPYX0wYVvm08AqmXAvc/hKQcZS6zCqS5C/
	 nFFNcJjrpFtS6Jp029Tpv7OPEvpsuj7LSpu9kYW4+vPyR/igvTOjMqf0//Mx1Ewnr2
	 2gvGpivanhrDrGTbzEbg9Kzqw9J4o0pp8F5nCrHKmsQpwB5AbByNw2np/6syGjeKBi
	 Mem0Ta3NKALsne4MfGWAKGJW0bBUmP2g+lrXJ6O3+P1q+l8wMVbLu9gtZVVBr2gzuf
	 OjF0R2oiHZxLg==
Date: Mon, 22 Jun 2026 17:45:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: amlogic: Fix missing header in
 the example
Message-ID: <20260622-pointless-rebirth-ef77e609d5c0@spud>
References: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MKrwKpMqithOr1GF"
Content-Disposition: inline
In-Reply-To: <20260622100231.438435-3-krzysztof.kozlowski@oss.qualcomm.com>


--MKrwKpMqithOr1GF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--MKrwKpMqithOr1GF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajlmjQAKCRB4tDGHoIJi
0j+0AP9/kaVJ5YKD8KOSM/zeSpTH30n0PabudqDxHmktnTBKDQEAz+EvpXQJ7fcu
yP2y1kIeTx60Yc0SovfQ09YiHJuAuQc=
=+rkZ
-----END PGP SIGNATURE-----

--MKrwKpMqithOr1GF--
