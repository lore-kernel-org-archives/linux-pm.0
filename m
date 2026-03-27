Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCE3F7AAC;
	Fri, 27 Mar 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622288; cv=none; b=jjhIua9KVNVK+onER31x6kKfueQl5j8BIQ3a0V6rGO4XT8pbVgj1HdIuKlHKtiZuWqe12eKjSvOdtPHaPuqJLhTKo1limH5KIPi2Np9h9esK2+3IEAmmYSFU7rCa/oOLtq3d6YOKutgBSU13qGvozUaYgSl0F/L0FrLCN/DA3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622288; c=relaxed/simple;
	bh=9dNEbNhEsFg2D8pemaMOwadUdUuNW18tq6Vuz1MWI7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3+t7mVlZYE4JP8wcyJqkNHUkNBfbCVfUC9wNvSgUvzX38iczNEcf2jNhZPbIVtqEivKMPaWd2uj5fC79/etxbynaVE7Y+9dAd/wILbwx6yhHUcvkLUElfqyxcl3D6qRLB/xynfXn9OFWgib9fDicep4qj2FApv9CNnoQUxzdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFh1y7pR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFh1y7pR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4242AC19423;
	Fri, 27 Mar 2026 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622287;
	bh=9dNEbNhEsFg2D8pemaMOwadUdUuNW18tq6Vuz1MWI7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFh1y7pRRWRLdsigBgPYXNOptvhd6z7D8lfl2w1GQTDbq+DngLVLgLm1psAF2x/wC
	 Y9s6QQIfozvouCG0SqdEaMJ+whlGrJNx1SHO8B3poy9qYV03JfvYFgvkqNWIGby+os
	 4KGBw3q0Il9xrbMzjZ/n8mgrQFapkiXUcVrA+lUURG53/8TcxXuhksaYJKVzLeJsnj
	 nJeF4sMxFQl67x8XCeTDOquoNPaL4M5R4iSnKadyxgIcuJbJKgto8hvXFvpML8Ksq2
	 cEyV7k/WKQAEDmE54G129j1JBkUhQWvFVQIUzKd6cNcNqyOW25/syBz3SnCHgo5H0I
	 Ka2rsETG383ig==
Date: Fri, 27 Mar 2026 15:38:05 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] ARM: tegra: Add SOCTHERM support on Tegra114
Message-ID: <acaWQgc3_gtHRqu7@orome>
References: <20250828055104.8073-1-clamor95@gmail.com>
 <20250828055104.8073-7-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ar7a6xe4beb7qmat"
Content-Disposition: inline
In-Reply-To: <20250828055104.8073-7-clamor95@gmail.com>


--ar7a6xe4beb7qmat
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 6/6] ARM: tegra: Add SOCTHERM support on Tegra114
MIME-Version: 1.0

On Thu, Aug 28, 2025 at 08:51:04AM +0300, Svyatoslav Ryhel wrote:
> Add SOCTHERM and thermal zones nodes into common Tegra 4 device tree.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm/boot/dts/nvidia/tegra114.dtsi | 197 +++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)

Applied, finally.

Thanks,
Thierry

--ar7a6xe4beb7qmat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnGlkwACgkQ3SOs138+
s6Gncw/8Dt/FX+xnNjL2tgArxAADn///JW4L5JK68aiHtjZpyoCaMw4WXwcDgxhZ
6enKJ4XJNjDjgskVEqSUn0OAfy7XE/HkpjPH2aTA/CLUaBudwYZcZ7JfSuGlw483
rI1RaqXrgbj7RLfXsSXeXsTaGXrll8o4iQbeaKRlohyo7SSpC9mCJXe5qqhGg4h5
Mg7SEFuR2r0HzVEoYfcq9ns99JDKPwbPRE3mipo/KOXcu8CFsYVvfIa5zCluy1/C
G+G4Q7mTvICG8xbnjeVhxaA+tG/2ruiEt2Nquxh4wj476jLvOZl8CC7kV3PfV0VA
T383jtg9xWpplNhUdaDnjLYvxOdzqy7JlvK56r6wVssOR3kyNZonwFcGjiW5/Qo0
ON2SI7FI87bXwJ1ENL5QHlIzRzHcLaa6QiZmT5er6i9NsQbgiEDjr9mzaNOCQwt/
4qql29mvPcSOHhc1LEcrWZf5wPOokhCdN0ULc/JPDs4PCzOhnt6XZAh82V/biJYp
ZcyX5RjfUx61yH9fHYddJPaifyav/REnp65wO5oMB5u0J36IXQVKlog0j9CP6AcO
UvGCP+e/xt8wn5/HUef2OMPCOz7kgfJMx110RggXuE1YNwc7hmFPC8q6zurmcy5P
xKOnI5KvjURqTFJWro6UFTfaFpe0btCXuanY2WU8iUWHM3mgw7g=
=tz65
-----END PGP SIGNATURE-----

--ar7a6xe4beb7qmat--
