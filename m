Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1B3DEAEB;
	Thu,  8 Oct 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444469; cv=none; b=Z8lBjTQTtt1yTJh1SDVc8ydR6CFi/xWcrVCmyCP9ypB2x847Lhw0bR6S8qafx8wZZwNyBV9XQMlluZuU6xVYGmUHXdcPNIrMoU9AGAqk00csszPlvUS7bhqtMqcwmLJiUTi3YxD0kKk59UudZv6OCHg82ewRpBN09qeaG7d99Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444469; c=relaxed/simple;
	bh=a/wgdCw+vlwEvfrU9r1UD1Ehk3HHmpStwfalJY2Y4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjSzm9RYLDlLbH7dlRDYHmgiMk2F/K/PrgWdksjfPj0HEFitjKtG35aPLTyyhqvY4y0GPf23Cr2aj7HkLgOyEQ+BjdDnmrBu2YNx9xo8nbwIm+728WRUdeYOeZCXH/Rnnuarlhxy3LCr7SvKx4ucVRoNIuaVHBUsAGC/4efZ+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz5Pr9Ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz5Pr9Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1401F000FF;
	Thu,  8 Oct 2026 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791444468;
	bh=TnWYILSYeeTCHANrL+mdG4bCULRUtRx6phf8U1pqrAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sz5Pr9IpNZ2oxDSwgeJyVdnoueFC6fMFIZuXkig6321BumIL+lyXhWe7IpIbCVPx4
	 hxghuhA79t+opuAqWp6u196b0ApYEe74znghzpHSTMzsui7GSQwnVxmzjOcGAS2OoQ
	 KXm6C0kcwFbT/fXhBRiOCIckzv2BtkBZnPw5n0HvdAlmhlddw/bMyenjEBGQ1PaUuW
	 +cucY0K3kbU1RcapsGd/bguA/N1mezNrArMjL+8sCGC61KHGKfthb6AjtcQrfZMbHI
	 K4Lmjb2LiAeGrL8s+d7Emka621IX9dldTKwhnurerBxYu0ICYWtYyVikSNheMx8it0
	 FXrFTFOjOx8Vw==
Date: Thu, 8 Oct 2026 08:27:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Icenowy Zheng <uwu@icenowy.me>,
	Iker Pedrosa <ikerpedrosam@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
Message-ID: <20261008-df80c21d73b287d09b6baa78@squawk>
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
 <20261008-04-k3-pm-support-v2-1-6f778a53dd2d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TnlMawwbesYq3LTv"
Content-Disposition: inline
In-Reply-To: <20261008-04-k3-pm-support-v2-1-6f778a53dd2d@kernel.org>

--TnlMawwbesYq3LTv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 03:44:29AM +0000, Yixun Lan wrote:
> Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
> Domain Controller is SoC internal module which is part of APMU (Advanced
> Power Management Unit), it is responsible for managing power across multi
> power domains, which includes power on/off, isolation, power-on sequence.

You should prob mention that this APMU is already documented elsewhere.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  include/dt-bindings/power/spacemit,k1-power.h | 14 ++++++++++++++
>  include/dt-bindings/power/spacemit,k3-power.h | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/include/dt-bindings/power/spacemit,k1-power.h b/include/dt-b=
indings/power/spacemit,k1-power.h
> new file mode 100644
> index 000000000000..41ef540b5c44
> --- /dev/null
> +++ b/include/dt-bindings/power/spacemit,k1-power.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_SPACEMIT_K1_POWER_H_
> +#define _DT_BINDINGS_SPACEMIT_K1_POWER_H_
> +
> +#define K1_PMDOMAIN_VPU		0
> +#define K1_PMDOMAIN_GPU		1
> +#define K1_PMDOMAIN_LCD		2
> +#define K1_PMDOMAIN_ISP		3
> +#define K1_PMDOMAIN_AUDIO	4
> +#define K1_PMDOMAIN_GNSS	5
> +#define K1_PMDOMAIN_HDMI	6
> +
> +#endif
> diff --git a/include/dt-bindings/power/spacemit,k3-power.h b/include/dt-b=
indings/power/spacemit,k3-power.h
> new file mode 100644
> index 000000000000..519fbf946312
> --- /dev/null
> +++ b/include/dt-bindings/power/spacemit,k3-power.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_SPACEMIT_K3_POWER_H_
> +#define _DT_BINDINGS_SPACEMIT_K3_POWER_H_
> +
> +#define K3_PMDOMAIN_VPU		0
> +#define K3_PMDOMAIN_GPU		1
> +#define K3_PMDOMAIN_AUDIO	2
> +#define K3_PMDOMAIN_LCD0	3
> +#define K3_PMDOMAIN_LCD1	4
> +
> +#endif
>=20
> --=20
> 2.56.0
>=20

--TnlMawwbesYq3LTv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasdF7QAKCRB4tDGHoIJi
0jpNAP436/C+jaTVphmOQBd7copLZX6MLYpjIeqQmN+rslqWtQEAnlyGn3BU55iI
w5/yDEpgYQ5j2UoKnH4u/SydQRDfCQA=
=7Zs5
-----END PGP SIGNATURE-----

--TnlMawwbesYq3LTv--
