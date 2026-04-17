Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544413563FB;
	Fri, 17 Apr 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444036; cv=none; b=Srvurhht+PLBCWND3G57dcFs/9VIuZhCrHut3Dy5PYeAcUKeBahBQEIjP2I8kX5nMhn6yBh3KgRiMKO8IUpxICJZxZzWvp6NHBInXN4TYKDc5iPrdf2gOsnjO/JEWhMJuO8pO07layv0J1h3gM9c+9vZBjBTlmgTKQynoneIruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444036; c=relaxed/simple;
	bh=vS+6JjIgSwATnAo0FDNGd2EBykmQuR1wkqPKp83GKMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqaLWfeoNLcyzX3XpU3wbxNd+0Rd0r6oQRg6JARpAUHxoIhn7f9BhWl+tjaB13cyDQVuvOPfL0Ll5LZHItfQeMiaE9EL3l/Lx02ze+66bUg4CWvXhmsJPLq4DjLwx5+yi+nMJjDKu00qs3Up51K2lgxlnaWl6GYO6FEQD0niVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9GWZ1tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9GWZ1tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B168FC19425;
	Fri, 17 Apr 2026 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776444035;
	bh=vS+6JjIgSwATnAo0FDNGd2EBykmQuR1wkqPKp83GKMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9GWZ1tk5cd9ZwIhZsBOpKbe1Wt4MbDlnyOBqRcBM3Z2ySyLmocXF9Y4f2eXQ0Gzi
	 Nvv6xCB4ZZKL+TEgTyYg3Uj78qNZWG38cCwP/8dPab0YZmsVGkoX4vqzN6g7PB/ARa
	 YLxVw8QCDZnVxh6cZcVhOlG4QNM6klXU4/OqYM6JDfGaqjdDzqSZjqohcZgelD9Uas
	 KnWYQkGlov7sgzkeE8zyidF4Ot5QbarZ23UnlHKMF+sGQP3BLfLDheRiE6EnoFGDix
	 6L1DypqMLaqlpISnowtoZBeVggsS6xPcZy/YJoMyb+Xb8T3grFgqw1hpzFaJbWSMjA
	 ZD84jBXaSRrVA==
Date: Fri, 17 Apr 2026 17:40:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Shi <binbin.shi@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hector Yuan <hector.yuan@mediatek.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	vince-wl.liu@mediatek.com
Subject: Re: [PATCH] dt-bindings: cpufreq: add mt8189 cpufreq hw dt-bindings
Message-ID: <20260417-heat-broom-3ffd6419fa07@spud>
References: <20260417080648.3692438-1-binbin.shi@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O16sYH1P8rELRFuU"
Content-Disposition: inline
In-Reply-To: <20260417080648.3692438-1-binbin.shi@mediatek.com>


--O16sYH1P8rELRFuU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 04:06:17PM +0800, Binbin Shi wrote:
> Add mt8189 cpufreq hw compatible in dt-bindings.

Why's this not compatible with the existing device? You've got no driver
change with this so I can't even guess as why. The incompatibility should
be explained in the commit message.

pw-bot: changes-requested

Cheers,
Conor.

>=20
> Signed-off-by: Binbin Shi <binbin.shi@mediatek.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-h=
w.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> index d0aecde2b89b..cff52fffc6b8 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -16,7 +16,9 @@ description:
> =20
>  properties:
>    compatible:
> -    const: mediatek,cpufreq-hw
> +    enum:
> +      - mediatek,cpufreq-hw
> +      - mediatek,mt8189-cpufreq-hw
> =20
>    reg:
>      minItems: 1
> --=20
> 2.45.2
>=20

--O16sYH1P8rELRFuU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJifgAKCRB4tDGHoIJi
0s9TAQD+qCFWSseJi4hwmF+JLmEE23ceOhV1OauB+CRT623n9AD/UTVQllhEmCr7
1OjjOwDL92kHJhFrA7d6dYxHqxkLqQ8=
=VuKY
-----END PGP SIGNATURE-----

--O16sYH1P8rELRFuU--
