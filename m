Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB14221D96;
	Wed, 22 Jul 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707957; cv=none; b=stYchgKnJutflnhTfhhu+X3mNfZJGxLtoU0lp64gZ1+8zY6nSEXhjlXoBi2ll3ySpo+1i3kH2p2ye1RA4smVAR8Ab5B0YINea6gptvPJ6G05YRLA2hjeugDQhlGiFkC9oTHobQOBAeCS6waHXDNPKaVWBG7G6OLDsJCDORJtBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707957; c=relaxed/simple;
	bh=NpCSJtDiKtk8XRJFpH3k5kFyLGWVp1dTpcaWwwrMHxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSLsx9pK0Fexoh1x3rn3kDACJDHTX0keEHv6dbBZgHl10e1fbp4FHJ17xy1D8eZlzSJ5J8HR9QD2qMjeLIiFsEMYZYevkpyQzvUslZ/CXyQFJpfUaJw729qKTsdKEY2ynzvdvPj0oWcKNKY8Elh6YEd9rBzGXn5F5STwcd0s5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox9cKzjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox9cKzjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A041F000E9;
	Wed, 22 Jul 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784707956;
	bh=4uL12UJfDy9Y3hI8vIlHjfOGnXPnG7SAuEQbC/EYjn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ox9cKzjwZpzCCGbmGshiiOixd45Harja5knO2DgHQRgeuDOKHfBqoe3vTuxAkmkYD
	 Z0kkt4jxRVIZohuPZgJqdcumyK495T6dtoBP3EhosasiWEcGLYHAGRl9Qf0o4KqAk9
	 codF7k/ATo/y/uVtuTJY/y994/E98i82m4aBNWF9q+EnHmJhHWwDA+HvCtfZh/GAkW
	 eY6kBHi+H1+c9J+pJawe3efGcGsqaGc0NcLXdIW1WRzlRSzprPycxaGLPfp3e6T0h2
	 gKU2vc8pNyZZD3rSP4nXXhjUvqC0yxb/kmxrfGTGyyOzUyPoXHsSfMO+z8hJ4oDnWj
	 IHwYQtcJfHUvw==
Date: Wed, 22 Jul 2026 10:12:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v3 4/4] dt-bindings: power: supply: max17042: Allow
 monitored-battery
Message-ID: <20260722-fiery-smilodon-of-anger-9dd4ae@quoll>
References: <20260721185904.40756-1-vincent.cloutier@icloud.com>
 <20260721185904.40756-5-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721185904.40756-5-vincent.cloutier@icloud.com>

On Tue, Jul 21, 2026 at 02:57:36PM -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
> 
> The MAX17042 family binding references the generic power-supply schema,
> but additionalProperties only recognizes properties declared directly by
> this schema.
> 
> Use unevaluatedProperties so properties inherited from power-supply.yaml,
> including monitored-battery, are allowed while unknown properties remain
> rejected.
> 
> Assisted-by: OpenCode:gpt-5.6-sol

And the tool did not suggest to remove redundant properties?

> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> index 242b33f2bcba..395253ca7835 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> @@ -73,7 +73,7 @@ required:
>    - compatible
>    - reg

You need to remove the power-supplies now.

Best regards,
Krzysztof

