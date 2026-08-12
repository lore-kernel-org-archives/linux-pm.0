Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D1282F2A;
	Wed, 12 Aug 2026 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522258; cv=none; b=K4IwgExXibkmaHXH2uPCg1Cugw+Q81Ojx/8bCbsMzHMaJhXt5rovT3w2JFFu8zUlg/seG/Q+M7lGqekjPK31v3SpDhc+e/PyUrCm5vHGg24Y8rfOWX9e0Vr5Y8Z7SWqHw5cMf7OzFnuaoDaOJ/95XaV4prLtuRmdc0BQs7DWhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522258; c=relaxed/simple;
	bh=77Wnbx0Jt3XwRIxIKTPN2IfXzRoPTrVz699zuiOLUOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3JjxpimKsKLHtA9Eb9zU9swlRFpt1N9Pvxd8Ysyv5yTnzi6rc84gNQQ5xK//FA77gDvq/JxnjpjgbkT7pGnv462C8XikpwhKDQzFU24P5v5tvzt0NbmYzHM8imM2HDm/HOKFRzZmZDAECPSp79hylyI8fEiSSVjg+8FkhU4CkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=tSJMmNxj; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="tSJMmNxj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=ZCjsWHk942s1B5G7YRBFqA4CRRqTkS5s5lOeUYD5l6w=; t=1786522257; x=1787731857; 
	b=tSJMmNxjbKXhSXaDd+0OPlBALf5stXb82wnVrMT5tKUg7lMCLSyJvCr+2htJfXAb5ELnaoRAHRZ
	xf46HroiIJrOQ5+MnRoOi7JYw5tBSunvK74ZQ5dxdns9oeABpvfZEsUGynW6BH/dMQDio0NRGOrpq
	w8UcXriLB38+0pyNnmbukL7QjPr/N8bEArVYuLrMfl9FsjBG7PjIjhJA++TfGEUlD2UwZB6W4YH2W
	1rjfgAcyqsmeI3qbeIs9OGgJCWbCw3WDsoE97UJTRQbv+72mk4PovnAkMQzC6PJqNhzo49Fu88UZR
	Qb+qgz3ccg5vkt0P42Q2RdP5vks2jTXrEObQ==;
Date: Wed, 12 Aug 2026 10:10:50 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Sebastian Reichel <sre@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kalle Niemi
 <kaleposti@gmail.com>, Topi =?UTF-8?B?U29ua2Fqw6Rydmk=?=
 <sonkajarvi@hotmail.com>, Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
 Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <20260812101050.575c9bfb@kemnade.info>
In-Reply-To: <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
	<22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 13:09:07 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Both the current and the average current registers contain same
> 'direction' -bit to denote the direction of the current. The code
> reading these registers incorrectly caches the direction read from the
> first register, and uses it also for the second.
> 
> Fix this by initializing the direction bit for both register reads.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")

Weird. I reported that issue after you have submitted an RFC.
current_avg just changing direction after disconnecting power supply.

Then I had a fix to enable current_now property.
Somehow we thought that averaging current in the chip ist just weird.

But now it makes sense.

Tested-by: Andreas Kemnade <andreas@kemnade.info> # Kobo Clara 2e rev B

> ---
>  drivers/power/supply/bd71828-power.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
> index e1ae5fe52e1d..9927a7e8934a 100644
> --- a/drivers/power/supply/bd71828-power.c
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -192,12 +192,13 @@ static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *curr, int
>  {
>  	__be16 tmp_curr;
>  	char *tmp = (char *)&tmp_curr;
> -	int dir = 1;
>  	int regs[] = { pwr->regs->ibat, pwr->regs->ibat_avg };
>  	int *vals[] = { curr, curr_avg };
>  	int ret, i;
>  
> -	for (dir = 1, i = 0; i < ARRAY_SIZE(regs); i++) {
> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> +		int dir = 1;
> +
>  		ret = regmap_bulk_read(pwr->regmap, regs[i], &tmp_curr,
>  				       sizeof(tmp_curr));
>  		if (ret)

That code is complicated. What about a generic 16bit non_2complemented sign
to 2-complemented sign function/macro. Such would have prevented the error
in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor

Regards,
Andreas
