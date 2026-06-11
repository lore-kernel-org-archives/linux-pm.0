Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B412BEFEB;
	Thu, 11 Jun 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197764; cv=none; b=ipRwzNnm/0Sz8GRf7cgmKT+1jcdR2AL+ySsFqOVxL26U/CD82RLzmQJHkQsmh+85O2EMshnt3tHPL/lECGd+PRdzF2UX66ADmGQgv1/fi3t3PbnqMHnI8jBrwpX4nQH+cbTQGft+D3h7kCFhHuIJ/Vo0uf1UqKHprRp5mIb3vGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197764; c=relaxed/simple;
	bh=PvOS8G2yHn40sW1JL4RbHenyU66w9ARekFhP6fio7cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL1PVwuYiFyGIQvgm9sLRvgLoiVnWDCvQtTUC2ILHc405pCmad58cfci4mPEJXq5dTKN5UP2rGNZn05B2wfVrk5ruP75ZMBYcbLcpVYqGhusrGzHbN2s2VaP1h+aTgqK2oGBENfCVE2in49PuiyCyWLvjlPa//n/np8dwTdsU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwHgmY7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwHgmY7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA28A1F00899;
	Thu, 11 Jun 2026 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197762;
	bh=pbv+KRaNAVLTmYg1Zr76xVCZJ54DiXiMKuxdaUODFno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RwHgmY7RZKkTYnwJzPsc39Z0T0OUPdI0CCdTnbRxtBCRHelzNApUCvYFx8T4FNfi/
	 MEVbR0615nCdY5EzdaXeyYJ2aPDWRF3SOTJYhJzZqhUctMbVk9a83cF1Wgm3jid0dJ
	 SbmimKIKSmFObOgKAtGbXKygAPK1c0N2X6aCTeUeAGTw6cqr3hoE0Rdav5fNEmzD8h
	 RefjMUDydpfsRVWfcc80ALmILKXqjNWwUQLnN8OgXaq+fJADghabGmQglOBLxdx7XE
	 y9mxo4rEb4ZXf+CPmCXXvwLt0f50Ldoz2thQXIIp7ZygzLTtegTZj7PPPKb/ebXDi3
	 T/XsEYt3JBN6w==
Message-ID: <33448148-3ac4-48d2-8119-4f9b765430f8@kernel.org>
Date: Thu, 11 Jun 2026 19:09:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: macsmc: Support macOS 27 SMC firmware
To: Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Sebastian Reichel <sre@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.26 18:49, Sasha Finkelstein wrote:
> The SMC firmware included in macOS 27 changed the size of BCF0 key from
> 4 to 1 bytes. This key is used for indicating that battery state is
> critically low.
> 
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
>   drivers/power/supply/macsmc-power.c | 34 +++++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
> index 33ca07460f3a..650dc8740f71 100644
> --- a/drivers/power/supply/macsmc-power.c
> +++ b/drivers/power/supply/macsmc-power.c
> @@ -86,6 +86,7 @@ struct macsmc_power {
>   	bool has_ch0i; /* Force discharge (Older firmware) */
>   	bool has_ch0c; /* Inhibit charge (Older firmware) */
>   	bool has_chte; /* Inhibit charge (Modern firmware) */
> +	bool bcf0_1byte; /* Battery critical */

The comment is a bit misleading, maybe "Battery critical key is 1 
instead of 4 bytes" or "Battery critical key is 1 byte (Modern 
firmware)" instead?

With that changed:

Reviewed-by: Sven Peter <sven@kernel.org>



Best,


Sven


