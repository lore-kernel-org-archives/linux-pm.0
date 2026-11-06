Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985662;
	b=bUUy92msSNfZEd7qgMmI3yV9B3izN/hjMatX3RyRbTtu9a3UJ4MxHCkz6ZeExl0leksA
	 e4GLZ9FWzWjs4dbwhUbBHaXsMSM863DoOW8TLOvyrRbIo3GPtog3nWVrFh+I6tEee+gnq
	 Ail65K7avoQH7JTPXkbXV2U00CzZ0UPldnGxSR0CPLwZrUzvugU6A2IkZ+51YBpCczHqc
	 DJ/pLw1fU08RnsziNdtgKrToyECcWFMSklcKQpuWwjTCvgGEtAmHqVdzeXQE5TzgN+xF2
	 TxwveCeWw+yK1voVgfCFVgVrKKVOjpnbE9+a2RavMkb1g53Mrt6bokINXqw4bvGq5UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mlSihzr8pYdtWScxo62ogUk0KfJHGdqcjF1TEJEb7DY=;
	b=pyx8l/t+V/k9B6RRxT+NXB+q+lHLmmUfzBUMWNGrDj7yPqSEDTTeNd6TGziRJeVj64GD
	 OTWlzZeqKBRV0deDJK1SH4KK8dxM7Kyt/M7DfMVhQPJzDz2QnNxivT5ZixM0VC6G9CFHz
	 lsn8gW5VPFk6IWSv84miunH3Vhq0TUpb+adzqHxl5aca2/8X48Ih7vA4sgah3AzXi4FeL
	 SgZXev0I3T3Bon+hvSn5hXGWROW9rL1UvrUZtj9UXo7Z5KZjMHMEOXCmC3SrnEix+m7iA
	 fgA9OyArXVDbW9peg9BErgSsymu0w/0uCyt9IvjOh8nbKBcz3j9yMHXUvQOcil4yo1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVAFAHzp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA253606D814;
	Fri,  6 Nov 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVAFAHzp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6A91F008A6;
	Fri,  6 Nov 2026 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985661;
	bh=mlSihzr8pYdtWScxo62ogUk0KfJHGdqcjF1TEJEb7DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FVAFAHzpuPHwNet8qjtzgoQhyvQ+HIyuWRIzFwjxmR69yiVWDf4Bjk8dDAeod7FDh
	 73BsDPXG/OHWFl5rJs3ZyxF1waQq6nVtAWDwblVgxXXHrKWFB6Y+pCIkpN7K+im3BH
	 btzWs8U0+K74gk6xCgMIRlFKAIyWfiHO29S9elOyGv/ePdZFy5mrb7F2EbIxHwGUKv
	 UkMr/O/8bMsQvnJukcVT35rIUcnvkoFbbHj43+3o4zOnGrSIURLnbdleZmKY8UKUqo
	 YsPYUeASvPXYiX9bXT6kZCl1Ox/QR3NMuTCN0PlcNxfoJsZeTJALRp/bcro9kg0kJ3
	 PP36r2lsRlS5Q==
Date: Fri, 6 Nov 2026 17:20:56 +0000
From: Conor Dooley <conor@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Stefan =?iso-8859-1?Q?K=F6v=E9r-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: amlogic: add S4
Message-ID: <20261106-surfacing-catcall-223c1c454b8e@spud>
References: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
 <20261106101913.46664-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wFxvJZ9ZE23zKehY"
Content-Disposition: inline
In-Reply-To: <20261106101913.46664-2-christian.koever-draxl@student.uibk.ac.at>

--wFxvJZ9ZE23zKehY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 11:19:11AM +0100, christian.koever-draxl@student.ui=
bk.ac.at wrote:
> From: Christian Stefan K=F6v=E9r-Draxl <ckoever@outlook.de>
>=20
> The S4 temperature sensors are the G12A design, but like on T7 their
> calibration value is only available through the secure monitor: the
> ao-secure register used on G12A holds unrelated data on S4. Add a
> compatible for them. As on T7 the sensor index is the argument of the
> secure monitor phandle, so one compatible serves the CPU and the DDR
> sensor. Each sensor has a bus clock gating register access (ts_pll /
> ts_ddr in the S4 peripheral clock controller) besides the functional
> clock, so it takes both, named.

Why can this not use the t7 as a fallback? Driver suggest it can.

>=20
> Signed-off-by: Christian Stefan K=F6v=E9r-Draxl <ckoever@outlook.de>
> ---
>  .../devicetree/bindings/thermal/amlogic,thermal.yaml         | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.ya=
ml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> index e72cb39ac635..66dd572ff44b 100644
> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -23,6 +23,7 @@ properties:
>            - const: amlogic,g12a-thermal
>        - enum:
>            - amlogic,a1-cpu-thermal
> +          - amlogic,s4-thermal
>            - amlogic,t7-thermal
> =20
>    reg:
> @@ -84,7 +85,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: amlogic,t7-thermal
> +            enum:
> +              - amlogic,s4-thermal
> +              - amlogic,t7-thermal
>      then:
>        properties:
>          clocks:
> --=20
> 2.56.0
>=20

--wFxvJZ9ZE23zKehY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4MeAAKCRB4tDGHoIJi
0qkxAQC/MXuDpuDromjVxEip2g7fLcdreRxIw+GpS5nss/+w8wD+Ig8l8mJmB0PP
rERuia+XhvRrf4GiiJF+FhFho4j97QQ=
=LKGV
-----END PGP SIGNATURE-----

--wFxvJZ9ZE23zKehY--
