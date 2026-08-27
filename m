Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2611940B0;
	Thu, 27 Aug 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851039; cv=none; b=m3WmuxgtipPEVC+LBzgewwzEc0eorhu+rEfAFghLc++5KRi/IQrCxnxNNgvCPoizv6059NTe4hmv2Ck/tbCdmZPQ/clVKy6BTsISVFcAfwhmshtoRPbrHh9e9yILxP7bLWM1+Y4gByYWE/XNqCpp0w+t0vnqt9RQTjtC/bzNQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851039; c=relaxed/simple;
	bh=7UOQHNXVkSIHrnBWEaQCbGWTy0LYXQDSOVpqYzYWwYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzWInPizKsfKH3x1HKFXbgztTPq6qUlr6cSXeFKiMm9w8xRIw320cHZVT2Ufk4/+++6igrcyPZJXJdYhdzVBIpqFqf7qCuVpcFxHOTqF8mAGLWuzzKLrMsNONsOKuyqIoTeyXe0u3461RSog9WolIg7i5rmOFwE8HL7DOVv2xp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3c1brqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3c1brqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8588A1F000E9;
	Thu, 27 Aug 2026 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851038;
	bh=7UOQHNXVkSIHrnBWEaQCbGWTy0LYXQDSOVpqYzYWwYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M3c1brqZPBzQoxr0HQ2oPhtaKfEEkhu9eW3leG67p4qXW5/5tK95d2MEoS6aJf1I2
	 qwXHzyjg4DOxOMWfNEMeg5KxQjKl7+UJa4LW5pngtYf3ryfkiszBiXLwAIpAKT7LWO
	 M7X82gN/5UY4cy3rofVJNxQmPar9TteuOYS+4kWjDkmL64tFIZJd0i9RBecsra9wCp
	 PiCrgS7hWnMRwrlUAmiIQWRcJRIl+g/Zlq8xBfJJlMnw8QaUUQmqAiNebFZE03Irep
	 6a5vKF4nrem2yW1WPKM3CzKUKNMCc7BFO4XKoKEEYaT1OGdRKSGl6Ow3B4yvDCv06o
	 C/LOh4dfOsOug==
Date: Thu, 27 Aug 2026 19:17:15 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add Tegra264 header
Message-ID: <apBwZwOkctBETKVJ@orome>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
 <20260827-tegra264-fan-v1-2-3c55f0c748b1@nvidia.com>
 <20260827-riverbank-cinema-d898d4e5a522@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cr2ptokaig36ntnn"
Content-Disposition: inline
In-Reply-To: <20260827-riverbank-cinema-d898d4e5a522@spud>


--cr2ptokaig36ntnn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add Tegra264 header
MIME-Version: 1.0

On Thu, Aug 27, 2026 at 05:35:28PM +0100, Conor Dooley wrote:
> On Thu, Aug 27, 2026 at 05:07:51PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > This header file defines the set of thermal zones exposed by the BPMP on
> > Tegra264.
>=20
> Does this need to be a binding, since you're just using it in the dts?
> Can it just go into your dts directory insteaD?

I don't think we've ever used these headers outside of DTS files, so,
yes, they could go into the DTS directory.

We've never done that before and there's a bunch of Tegra-specific files
that would be in the same basket. What's your recommendation for any of
the existing headers? Should I move those into the DTS directory, too?
If they are not used outside, that is? Or not worth the churn?

Thierry

--cr2ptokaig36ntnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqQcRsACgkQ3SOs138+
s6E9zw/7BYRPip5eGaJjGlRHxKU9JFf1MDCM2ANmadWagLsvPusHvkDECCFGsGYJ
AYrX9toQAj8dIfPTdY3u919LJYiuf6rUl0OsEARnyfCPlh4DIUejVrZNSSdLxI0E
IE7a+4cxSmNzkHfhReReZb5N05+hMw81X+L4jlmnJv2LSbo06oCT6yJB758JpQyU
Kd3k920QFeEM/g5izLDFZjlejmO20WT3fsEPCi1KTuAlDLyD6JJcynP1pfQ+yH7I
f1kjTq2RK5AzadxOHAW7IJtuzUumzsqCX5ocbrmjyObrRfiBJMUJhLVYFFnV22EL
9AWjB233dbuf6UchldTeDVpRvLAJrYvvdMKrxb52v4l3uccrO9+VCjRqnTvO4ZQP
qoHf6EEb2NMA/27dWgVTYFGV5Qxv72KmyxIOgRqCHGeF2sdrn0ITeoOQJBJpmOIt
qjYtlREsdjWTDGIpyxSV/8WtsWrtCBgHJ1uIqPiCJI0YhWmsfLbz1koF4Bu+qjCU
xS6YRq7WNdWMo3eErbEB1gC8sZ00Q41dP/6+QJ+dZoOChGe8iiF8q4rZuymPAK1q
aHCFmA9Snc8fMjiWgdQLCKg0VaDteeL4Xwpphm9SHCC8TPgxFw4JasULNNZdVtie
a54J+OpqWtJB//RoVVS57bCCzC7NYHIlz4pWm414NFsURW4pck8=
=hw6n
-----END PGP SIGNATURE-----

--cr2ptokaig36ntnn--
