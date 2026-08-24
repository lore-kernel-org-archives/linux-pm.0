Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08B45D5E3;
	Mon, 24 Aug 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588666; cv=none; b=cIcnOWwpD32FIl7QkQAPjsf3nv8L+lX6BZJBVEunzO0ZJmaaZ5nPajWpVYcc98wLc/JwM0fd3egsWwAFOACbpCJr+zkd+JB53oSH9l+k6063S2mBKRdhWaNmrnn+8NO/uXOS4zOGvBIOitvO+KmzO3Oz7oU+leuizHBaBa7xv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588666; c=relaxed/simple;
	bh=INvRM4NtzOlPC3FwwWeKbd5+d09XvIUdKQXV3BbMflo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd03i428HJ9YfkuxmliznyX3m547s1W1yJkMilcQEbJbNAfRFY+4VvUK4K9wCHelPbLBzugBor0hCEzPtJujTjhR5MaEa95vPrxtejL4OXqlqbsPyUSSzg/hO8aaIJZrkRN63i8vYMxZARrYG+4QoGbOwexhaYAqhY89F5jN0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSoDI9sQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSoDI9sQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FAB1F000E9;
	Mon, 24 Aug 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588665;
	bh=uZTtou1nRtbS6X9wfhp/PYfrCMog+YyUjJyHyt53b9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CSoDI9sQ9BHabsbH51rW1u8jLgL4QG++cA48MrXJMxPR4bDejclsFyhIgG3qxIHIo
	 pmI6mr2UaRmsJztTzXiQ6OAPaqTOB2Z0m5Ky2JSuWSmtOMQIEZs/BirC1kXNi6UpfC
	 CqivYmGPQTbjfAGmbJeqAvLGfB1bl7AiiRcY76XiVO+Jr3VpbXzs8Q9GWE9XsVAiTh
	 1tcWhwMQ9lriNfxV6NwPEi2bKFQD812en2/eKGMC8Ye1YzUcHxfikkhBPEsxIRtNa4
	 PgNIad6IHpt5nuuGNR8MWaGouLZ65pnAT8yueKCumctr/hVmi9i4l6qDRwTKw675Fd
	 5lWdCxADZsxtA==
Date: Mon, 24 Aug 2026 17:24:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
	p.zabel@pengutronix.de, ogabbay@kernel.org,
	zhangqing@rock-chips.com, royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com, alchark@flipper.net,
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/13] dt-bindings: power: rockchip: allow resets in a
 power domain node
Message-ID: <20260824-hardening-tinwork-60c54a562c8a@spud>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <c34278613fdb483ee7d771077a9451f66973e89d.1787568944.git.gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+tDi0f/c68q1mpsR"
Content-Disposition: inline
In-Reply-To: <c34278613fdb483ee7d771077a9451f66973e89d.1787568944.git.gahing@gahingwoo.com>

--+tDi0f/c68q1mpsR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:08:55PM +1200, Jiaxing Hu wrote:
> Some domains do not come up in a usable state on their own and need
> their resets cycled once power is on. The RK3576 NPU domains are one
> case: without it the first access after power-on takes an async SError.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-contr=
oller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-control=
ler.yaml
> index b41db576f..83741f048 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> @@ -136,6 +136,13 @@ $defs:
>            A number of phandles to clocks that need to be enabled
>            while power domain switches state.
> =20
> +      resets:
> +        maxItems: 1
> +        description:
> +          A phandle to a reset that needs to be cycled once the power do=
main has
> +          been switched on, for domains whose logic does not come up in =
a usable
> +          state by itself.
> +
>        domain-supply:
>          description: domain regulator supply.
> =20
> @@ -216,6 +223,7 @@ examples:
>                      reg =3D <RK3399_PD_IEP>;
>                      clocks =3D <&cru ACLK_IEP>,
>                               <&cru HCLK_IEP>;
> +                    resets =3D <&cru SRST_A_IEP>;
>                      pm_qos =3D <&qos_iep>;
>                      #power-domain-cells =3D <0>;
>                  };
> --=20
> 2.43.0
>=20

--+tDi0f/c68q1mpsR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxwMgAKCRB4tDGHoIJi
0kv+AP0WeUFb4dKPJSmjaR2SbLsqglAK44hwzBB4HyxQNKxIqgEA+h8O0hVC2kna
C84nBPE3JorbtfSL3jl4fvdc2oOxcAc=
=lpjX
-----END PGP SIGNATURE-----

--+tDi0f/c68q1mpsR--
