Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02EF1C2324;
	Mon, 22 Jun 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147641; cv=none; b=GWa9M5wCaqpAkWHtBXPspLJvScGJ/Dg13JacECBRq+8if4fYkdSl0EgEQOxRnXEBfR5XEl7reXuVUWFQIfVJ3Ms4AXkSYVDF2/zHm1s9G1OWQhEyxJzpLbMcGDjcoFDfJogfWRnzKxJhBdR1O49fKtxuwcl5dLlZNBrMUP3HD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147641; c=relaxed/simple;
	bh=FBPNSe4CPrmYI7tdrVEFFESNM2AQv28THAVOyYtFOEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG9Eq6bM5k8vdeOCL3e/g2mNYtv2JCeM4ProtlQfYedGTmOI7hHmf3QLJIBfwV4/qY34kAiCzgAzZcufLsGKtk8RPdBvrA4BN3+w1iadyFENDP1W4wQxJTpfAgJkbK+oB5rfBFbc50o1UaUMJtXiJXhA5H+yZzpuyLVgV2lZGd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7sNwPJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7sNwPJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179101F00A3A;
	Mon, 22 Jun 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147638;
	bh=FBPNSe4CPrmYI7tdrVEFFESNM2AQv28THAVOyYtFOEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n7sNwPJLODKiRXF3ckMys9a0madlZ0QlBOjYZTx2GavzrrW3/QRmV3JeyB24/EZv3
	 BRHFAExyTS2FzXigFI8UDWdLfavBXWAuhHMrapEic0JLHIohNnMHnohCRjYK3PUPLC
	 4Rl5EYkYprfryDf3jF89EjjuImusXvrM9H0WgPgEacIMbCPAxH7oPXuWbvPZrFUBVu
	 GwWHT/ScgXSiGewELPxVxuIfWHGkNtWAVyT11/AJf0F/5CJIqeonNdRebDGYbCo6I9
	 /AClqSuz6/0yFBwwPcQVSgR49SkKXOGd0x2fQ1S9mPE6/v767IrCuv0/SsYC25QLxd
	 VRKBj0ZycUhpQ==
Date: Mon, 22 Jun 2026 18:00:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
Message-ID: <70dd1974-3360-4169-8b3a-36e7e1cc4460@sirena.org.uk>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rGlF+30zJ9UqBxku"
Content-Disposition: inline
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org>
X-Cookie: Now I am depressed ...


--rGlF+30zJ9UqBxku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2026 at 07:00:55AM +0200, Linus Walleij wrote:
> Remove the obsolete DB8500 PRCMU regulator drivers.

Acked-by: Mark Brown <broonie@kernel.org>

--rGlF+30zJ9UqBxku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmo5ai8ACgkQJNaLcl1U
h9BaJwf/cE6zFilqlprukQbzoS9v80E9/7Y2JJSaiLnvW6JjSjMvkSnz7MwKRKjV
5YmmCXijisVfGbkgQLL3ad/7NkhLD//cJnPh11Mp4W8IA1IGV41qH9W5gUgwo7QE
MHb+IChEB+Ba8VSWtCqsktqI6O3TNmd/SKnnheO8g88/ldpZ+keIlYk6Ox8zVVf4
JmMuWMMFBJR2ybHy/L2ok0OshjgcUKGaQS0QpAhPBJTQ2/+NJYGliH322Y/irXhe
exF9MfFUEJDjCI6RxKMOqAp+IChlNd2l9/5zJ4xG+1jPtgdCd8g8P/WMGjdebbhB
mELR4oOXs2c5uPurZH8ILur5P+kN8w==
=UUpz
-----END PGP SIGNATURE-----

--rGlF+30zJ9UqBxku--
