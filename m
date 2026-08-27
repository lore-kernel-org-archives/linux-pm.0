Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5433FFD;
	Thu, 27 Aug 2026 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848534; cv=none; b=gjg1ioCn6UVBf5hPqltefIDWAauvZB0NQHMnQ7WZcCAPmptOpcn282SY33ZCdbYxrz9qzylzdhd7QeKECNIVoJM/OlN42lcFQ5m77icXs9HkVR3Pyjq0yxlHByqSqsbBJ60Sivm6t6WF2DxUrYQmTszHlt0P7Z2I2g2NMUoQKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848534; c=relaxed/simple;
	bh=FMOa7K8c9ntfrDsnr/HJ1yPnOO249osGs33iCOsn7Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa6/8KwuUhIcmH2X2IDZQ8oRdwrXtBlNeyQA1z1J2x3R94RNf+Ed1W02yQgVaahLpTIwX0KIDKVFnSBxDl0wf5Y9mL2nFWpb5qo+2NRdTHRplLcLUeitq8H31ep/jGCU+6UOgTZ28s5ZPnFvqn5+uCsENOfwdVsnRjJT5g3fGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqtrQ3UO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqtrQ3UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F731F000E9;
	Thu, 27 Aug 2026 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787848532;
	bh=UkC+ptFG83CHhhlpQRvkIDNUp0LPgh2nBFtJOu4cRYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OqtrQ3UO5DK5ea7IutsBW0fKPbPHZ3JqecFipin5mSzscVkAtNQ+Ty9+jliAFK4Zt
	 g15Qi+KZlP/yiux+fX3lJ4bUzm7zMOW5vWhnPEbxGjCbQV+ZlJh/gyViUhDHbCq4xw
	 crwLqTzYEvyQxhKYOMg8UuPIlqgZ0owmUkH43f/c9UjzfkQAmwcNHYIECT/uWbBvy6
	 gnHZi+/H8z7ZThawDtjTuqcXoYnXGlTCfSgUCFosG9tHcgclDHoUwKW5WoYJKmbz6C
	 nC43AcrVTtC90M6Ont11jqNz6ty1+ZT/4vzL1AVi0WLUKqz3IBh1HFw97z2ku9bchh
	 MN80ZQQOtj/Sw==
Date: Thu, 27 Aug 2026 17:35:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/4] dt-bindings: thermal: Add Tegra264 header
Message-ID: <20260827-riverbank-cinema-d898d4e5a522@spud>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
 <20260827-tegra264-fan-v1-2-3c55f0c748b1@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j61CVKVvUtbZjtu/"
Content-Disposition: inline
In-Reply-To: <20260827-tegra264-fan-v1-2-3c55f0c748b1@nvidia.com>

--j61CVKVvUtbZjtu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 05:07:51PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> This header file defines the set of thermal zones exposed by the BPMP on
> Tegra264.

Does this need to be a binding, since you're just using it in the dts?
Can it just go into your dts directory insteaD?

Cheers,
Conor.

>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/dt-bindings/thermal/nvidia,tegra264-bpmp.h | 20 ++++++++++++++++=
++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/include/dt-bindings/thermal/nvidia,tegra264-bpmp.h b/include=
/dt-bindings/thermal/nvidia,tegra264-bpmp.h
> new file mode 100644
> index 000000000000..b32739691385
> --- /dev/null
> +++ b/include/dt-bindings/thermal/nvidia,tegra264-bpmp.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/* SPDX-FileCopyrightText: Copyright (c) 2023-2025 NVIDIA CORPORATION & =
AFFILIATES. All rights reserved. */
> +
> +#ifndef DT_BINDINGS_THERMAL_NVIDIA_TEGRA264_BPMP_H
> +#define DT_BINDINGS_THERMAL_NVIDIA_TEGRA264_BPMP_H
> +
> +#define TEGRA264_THERMAL_ZONE_TJ_MAX		0
> +#define TEGRA264_THERMAL_ZONE_TJ_MIN		1
> +#define TEGRA264_THERMAL_ZONE_GPU_AVG		2
> +#define TEGRA264_THERMAL_ZONE_CPU_AVG		3
> +#define TEGRA264_THERMAL_ZONE_SOC_012_AVG	4
> +#define TEGRA264_THERMAL_ZONE_SOC_45_AVG	5
> +#define TEGRA264_THERMAL_ZONE_SOC_3_AVG		6
> +#define TEGRA264_THERMAL_ZONE_GPU_MAX		7
> +#define TEGRA264_THERMAL_ZONE_CPU_MAX		8
> +#define TEGRA264_THERMAL_ZONE_SOC_012_MAX	9
> +#define TEGRA264_THERMAL_ZONE_SOC_345_MAX	10
> +#define TEGRA264_THERMAL_ZONE_TJ_AVG		11
> +
> +#endif /* DT_BINDINGS_THERMAL_NVIDIA_TEGAR264_BPMP_H */
>=20
> --=20
> 2.55.0
>=20

--j61CVKVvUtbZjtu/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapBnUAAKCRB4tDGHoIJi
0q4DAP44AXo8+VuIeThg7JueM2wliz1yUngCjU3ZDbI7xRjAQAD/TljVAvfIa4lF
NFgx3cC+O8jitOvsYhKJwceeVuZPGQc=
=VgGR
-----END PGP SIGNATURE-----

--j61CVKVvUtbZjtu/--
