Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DF38AC95;
	Tue, 24 Mar 2026 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342539; cv=none; b=AtXOYaER/BycWMRMMuAsJWRc19Jrzu5czefELayt6jQe709vRPK3tppWGnYutg48NayV55A9dbyjHbSvJJ9Qcgh0XcjUh/jJUCoicO8vL55jL3mOabgdXvd/aIEdJhhBNaN/+y9IMquIOY1+ebmAo6AnftOdb6hL9ObVmfeanVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342539; c=relaxed/simple;
	bh=q82UVWsJ+a6XedGbHrQQANcuVwbRG8YWeDeDrv9AsUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyR55WxFrH76AUI8uNDM8xqBOeTkNODeo6hG2M3CV50iR8nOUulugg+Qv8ghcc/11XP6pMBO9EyyVjs2+6V6o0rH0CKHti72ngb4mpa950fjj8Pfhl9rvpwEfy2zKOcJwOllZl0vOO4N+tLlu5y44NLdV7j/mLtAiwR3YtSsz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/tfJIzq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/tfJIzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53264C19424;
	Tue, 24 Mar 2026 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342538;
	bh=q82UVWsJ+a6XedGbHrQQANcuVwbRG8YWeDeDrv9AsUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/tfJIzqNqvWNysSR5nDNJbYgBBdvf+Ejb+MURe0FSL/KCTrbLs/ObGZ1hopmfpLN
	 5RA0KnVAn1d3H1Rw8L294uyG+u36nsdC78iFaT7xb8OHFT/2RnGj//As/w4mpmd7Uc
	 zB+nMr2VUCFyOV+JqwhJ+JoadYGStI9LTh7fROTT3yMRsvlhoeNvi7307FzswneCC/
	 hOWJBMGRBYcomv4/Hp+kEKNxvwflM4GSdxRT0d83whp5KxDSn8tmcOcDJJ1H57zFxZ
	 lC6CL2AEFT9J4zzkN+EyblW+2XKqRap4YEB78i3teT+pFan6VD1/BfneyZsc9OWvf+
	 3ftjmenoBuMCw==
Date: Tue, 24 Mar 2026 09:55:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: gpio-charger: add
 support for fast-charge timer
Message-ID: <20260324-hypnotic-tuna-of-domination-bb046a@quoll>
References: <20260323-gpio-charger-timer-v3-0-885796d681a5@liebherr.com>
 <20260323-gpio-charger-timer-v3-1-885796d681a5@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323-gpio-charger-timer-v3-1-885796d681a5@liebherr.com>

On Mon, Mar 23, 2026 at 05:04:06PM +0100, Dimitri Fedrau wrote:
>    charger-type:
>      enum:
> @@ -62,6 +67,10 @@ properties:
>      description: Default charge current limit. Must be listed in
>        charge-current-limit-mapping.
>  
> +  fast-charge-timer-gpios:
> +    maxItems: 1
> +    description: GPIO used for enabling/disabling the fast-charge timer
> +

So where is the solution for "and then only allow
'fast-charge-timer-gpios' for the BQ24081."?

See example-schema or other bindings for the "if:not:...then:...
fast-charge-timer-gpios: false"


Best regards,
Krzysztof

