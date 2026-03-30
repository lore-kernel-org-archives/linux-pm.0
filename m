Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39F39EF37;
	Mon, 30 Mar 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855329; cv=none; b=EtMc7fthazO7DUvDzCgM8GNLo1Ac5W7a89eGf+bF4qJ93YkrniXxtHcxNrn0mMNrN4qkq58n3J0MnQax1OHFCJK3ITGrbuNysqss20Ci7YTRubTXFfOk8QzfMRCgVkPb8MkBOW39fmeNqPQa/NJlLn26MD6nqfkZaz3uFWVHOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855329; c=relaxed/simple;
	bh=y9mD+65Lfnb411B/kfQPwX/qSL7/8ZFUg+bOT7K+rGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa2b4UeBttckotTWs8eDRz4BleS2Hh8/G3FLbl6GaJr0Jheow67IeWqYpEqtvm5U4CBl1M/04kjwr5o/Y2CHRJTmANFosjQ26cNTX3ZIJfdOpgIGv2DFXx8+O09wEQCu5tFMYGN3F4N5RJ0yjmIVpu0rCR4gkCkamaPwSMUvHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oaw7gFD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oaw7gFD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44BFC4CEF7;
	Mon, 30 Mar 2026 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774855329;
	bh=y9mD+65Lfnb411B/kfQPwX/qSL7/8ZFUg+bOT7K+rGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oaw7gFD1elda2OVOh5Mf2F+21lWFSJ6PFcjYNXBpLh7kYUqXGWm91AkDoESlBm7Pn
	 uxPYKRpAkL+oYRIVQmIHr98FHYjQ10R0wM1v4tVmyWnri2w3N0Vd4mtQCPq0HjiZlf
	 iLmU29HaIMaTpc70mpC4Gh26jLbB6+1q2zQoD6PEvNcNrvtpqEpXWEnuEE2AdgYLdL
	 zpPR1h6pELEN2H0aR5XXYG20V/L/F76hlGNsJa1R5iYUJ0Lt5yydyACY0u6qhaDP9x
	 4uSuRO7od9Miwn9qpJtEzSmo6h10BBQinoPdGqTC23vrORJUzCPkoXofndbE6C3TK1
	 BXbJ0u0opLehg==
Date: Mon, 30 Mar 2026 09:22:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khushal Chitturi <khushalchitturi@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ulli.kroll@googlemail.com, linusw@kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: gemini: Rename power controller node to
 gemini-poweroff
Message-ID: <20260330-rough-military-saluki-e2dd8f@quoll>
References: <20260329205151.15161-1-khushalchitturi@gmail.com>
 <20260329205151.15161-3-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329205151.15161-3-khushalchitturi@gmail.com>

On Mon, Mar 30, 2026 at 02:21:51AM +0530, Khushal Chitturi wrote:
> Update the node name for the Cortina Gemini power controller from
> power-controller to gemini-poweroff since node "power controller" is
> reserved for power domain controller.
> 
> Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>
> ---
>  arch/arm/boot/dts/gemini/gemini.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/gemini/gemini.dtsi b/arch/arm/boot/dts/gemini/gemini.dtsi
> index befe322bd7de..c524adadcf81 100644
> --- a/arch/arm/boot/dts/gemini/gemini.dtsi
> +++ b/arch/arm/boot/dts/gemini/gemini.dtsi
> @@ -228,7 +228,7 @@ intcon: interrupt-controller@48000000 {
>  			#interrupt-cells = <2>;
>  		};
>  
> -		power-controller@4b000000 {
> +		gemini-poweroff@4b000000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

Why gemini is added here? It's not generic.

Best regards,
Krzysztof

