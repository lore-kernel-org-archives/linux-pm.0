Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC73B5E01;
	Fri, 18 Sep 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722026; cv=none; b=HKluHcjQBrjEBe309NoZTHsav7iAIWvpXYMRTOxAgntMy2KuO6RJCHxX7nlPNppUr75JL5gsh6fI0LM2t4Xw1u+OmyggeJGOYKkUQWc8iXqWWlFPQdUPJlr3jTHbJDk1eC0A9vRh+vT1WbRP6KR71LOLo64d+xhvlJaTeiiz2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722026; c=relaxed/simple;
	bh=viCsBNByx1yxx+GkBh2banjQOswsRlIrVmdAPSnJoIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUTWFfF7jkj3TbpN2bbQ1h2KvUV/q5kOFCLDIaGe02zWEkGjYqv2yUXFC237WOctYRzQmiYQJgNf9uLB/v6E13LYDqeQ3nqGf+XlFeZCy8OIKeDm7OuQNj5iFwRLz+6cBuIKAFHWTJoc+uUThIdu+r2qga5xkV3orlFqJQxpp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6/RaQGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6/RaQGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701ED1F000FF;
	Fri, 18 Sep 2026 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789722025;
	bh=5Fj5MUlBo9WLeAQxjtdzxncIR9hXSeIHhIRzNrIqShE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6/RaQGYJKplkFNE8XGOsneB3haDia2zg8SNeZ0hSuX77rkMJypjX7+1cT2CfmEKg
	 0R94XGKwlovL/q+/OM7hN6T+ePMy9JxkW9Ap+nyJWPgHAVzUoQSwbVNo7kXrTgGNKm
	 hGZjtKSP7jv4Z8c1km5/EMdIG/9JKCbiDMjhKqK+L+vQ5k52qTjwwF4Zjt+hJNYorD
	 OORoBXCNCTAYEKGnKWujlZqUzUyIEFcEDDQNhjxe9mFgzPWA6L2MdQOrMQ5y5P8407
	 d/7VqPKVtokf2laAR8Oe7db+5YtL5yt91+8+xN3YrQ3jxWu49vroDuErjdAt7ACyCd
	 sa0gUNjJDT5jQ==
Date: Fri, 18 Sep 2026 11:00:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: ab8500: Allow AB8505
 interrupts
Message-ID: <20260918-cerise-chamois-of-speed-af2e93@quoll>
References: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
 <20260915-ab8500-charger-dt-v1-1-10b7b387e6a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-ab8500-charger-dt-v1-1-10b7b387e6a6@kernel.org>

On Tue, Sep 15, 2026 at 11:46:54PM +0200, Linus Walleij wrote:
> AB8505 has no main charger or main-charger interrupts. Permit its
> nine USB charger interrupts as an alternative to the full set of
> fourteen AB8500 interrupts.
> 
> Also clarify that autopower_cfg describes the AB8500 facility, since
> the corresponding AB8505 register bit is reserved.
> 
> Fixes: eb917497734c ("dt-bindings: power: supply: ab8500: Convert to DT schema format")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../power/supply/stericsson,ab8500-charger.yaml    | 44 ++++++++++++++--------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
> index 4f19744844e9..437b58e82e9a 100644
> --- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
> @@ -28,27 +28,39 @@ properties:
>  
>    autopower_cfg:
>      type: boolean
> -    description: automatic poweron after powerloss
> +    description: AB8500 automatic poweron after powerloss
>  
>    interrupts:
> +    minItems: 9
>      maxItems: 14

You should have a different compatible for ab8505, with ab8500 as
fallback, but maybe we just don't care about such old hardware?

Best regards,
Krzysztof

