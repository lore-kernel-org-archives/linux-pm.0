Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79548376A16;
	Fri, 24 Jul 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876987; cv=none; b=S+LBSFObre/qd00tdWpPmpcCxO2esydWQEMLs+6G4ii1g4256RQJmXgMUJDT0Xe9plIrcDPIhyi2gRP23tOa1mzjMNOKslvgf52YZH10NiYtF8KxfiwDqmAlxXTKJbNBxwTPEfOnw0k4NqgRET197ljS2tGhPz3tN9VDMTf0tqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876987; c=relaxed/simple;
	bh=gdWY8ZLwlDTBzBNlMhvzyfEPsb0Ak6kT0MKLCSCvxkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwY8YZUVc9driXQbAjMJn3qBNdriwJrjA4XH0zVfeJ5e5bZ+LpurtuHDCyAjqxZ6JIOnKyIz1H6AXT1pVOJuZHtfnvhmENp9aNXxgak7k/L/DpgwYwnuk1Q2f/n2Z0z79QLM8UhrdSt527Ch5+g4cJEOqG/rjrk5g6Dr6dA5wgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhe4gmK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhe4gmK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675881F000E9;
	Fri, 24 Jul 2026 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784876986;
	bh=smCE3zkHSVpYMLVZBYOzeCcQF45U8Re7SgEYlbSp9cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xhe4gmK199U6siaMOiI145Lh0UaipXg9Lq6s7iLK2YY7Zyw8HlTfA68LYyREDo837
	 Qk9dbNouTA9JSeee4mAlk7VXy6znA3L4dmoZEw24xayrctYlwWviR73ZgfO7KH+N/b
	 U9xt3dTdRdpc5bVQ1xIULJ/nJ6YIsoh7FcEYLfTvBZuD5t0SX8gJmpLg/ZtuYLh5VS
	 ewEPV3CB470jf65SHg5rj83+cf2hyrU+7QKKltUoMyDJkzUHsV8bZ88H4Ckw9SPfoc
	 xSqSdK2KuV/JeJhRcdCW37cBEpdrJVf5dG3rgtVTsTLrAo0UrGxNcAwx8enXQ1zTse
	 lE9S2sUHvDDXg==
Date: Fri, 24 Jul 2026 09:09:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?U8O2cmVu?= Hantel <fugininsane@gmail.com>
Cc: linux-pm@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Rossak <embed3d@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	=?utf-8?B?U8O2cmVu?= Hantel <fugininsane@googlemail.com>, Claude Fable 5 <noreply@anthropic.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: sun8i: Add binding for the
 A80 THS controller
Message-ID: <20260724-hysterical-fantastic-koala-1756c6@quoll>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
 <20260722210046.2932498-1-fugininsane@googlemail.com>
 <20260722210046.2932498-2-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260722210046.2932498-2-fugininsane@googlemail.com>

On Wed, Jul 22, 2026 at 11:00:44PM +0200, S=C3=B6ren Hantel wrote:
> The Allwinner A80 has a thermal sensor with four channels which shares
> its MMIO block, bus gate, module clock and reset line with the GPADC.
> Register-wise it is an early version of the THS found in the A83T and
> later SoCs, with the THS registers starting at offset 0x40 of the
> shared block.
>=20
> Add the compatible to the sun8i THS binding. The A80 takes a bus and a
> module clock plus a reset line, so the existing conditionals already
> describe it correctly.
>=20
> Co-authored-by: Claude Fable 5 <noreply@anthropic.com>

NAK. Tools cannot certify DCO, cannot be authors.

> Signed-off-by: S=C3=B6ren Hantel <fugininsane@googlemail.com>

Messed DCO even more.

> ---
>  .../devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml    | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a8=
3t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83=
t-ths.yaml
> index 3e61689..718c44d 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.=
yaml
> @@ -18,6 +18,7 @@ properties:
>        - allwinner,sun8i-a83t-ths
>        - allwinner,sun8i-h3-ths
>        - allwinner,sun8i-r40-ths
> +      - allwinner,sun9i-a80-ths

Really, single compatible was co-authored by the tool? Folks cannot
write a single line of code nowadays or how does it work exactly?

And the tool did not even read the rules about sending patches, DCO,
proper subject for DT bindings? What is the use of the tool if it
produces obviously incorrect patch?

 subject: drop second/last, redundant "binding for". The "dt-bindings"
prefix is already stating that these are bindings.  See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/b=
indings/submitting-patches.rst#L23

Ask your tool to read the docs before using it, please.

Best regards,
Krzysztof

