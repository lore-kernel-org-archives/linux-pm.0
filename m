Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6922D78A;
	Fri, 23 Jan 2026 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.141.101.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166565; cv=none; b=rJvQJhDnsi5Ph/eU0h38olP01wNfoJjSaAZwkEHUT+fkkk4ImBEGP+Lei9UcvSipgNWgUqsvKKpbFYKZBlccTk62qUXAF3nxyi9nRkxBPwsGje3lTDFLFwJhZtFBho2NT4uoPAB5wOlEVeIPzZvOSMieNvA2APdHnmcByXtEsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166565; c=relaxed/simple;
	bh=/LZNc30g3t4Cjfm+QmOsx9EY/eY3QG6PbxIOoVMaxwQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Ws6yV6+xMBAUpXRQISoiK2AKGiLX23PoNG3ep+OfPSMBLI9H0O4qJE7BQ7wMwVM/1Zl+0rihcciShypy1TWTWygwYmEdtiW/Rz4T9Ci1MUlR5uAT08EzX1yIWqnfoiDTkINPBnumS7O6cIb1a93PJ5tHdTc9cfcwbRdpnElXyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=0uSEDq/7; arc=none smtp.client-ip=45.141.101.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="0uSEDq/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1769166551; bh=/LZNc30g3t4Cjfm+QmOsx9EY/eY3QG6PbxIOoVMaxwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0uSEDq/7xsj/cMSWXEEwvCebRHR8tljunhbxIHoVjRmf3MsInzBMtE8U+5aLpPOQz
	 Sh4c8lGbY41sOKhNHbQBQScQM85bDi2SvGrdJM8yRuROgeqzQqk2i9OqJ1ZzUoHQII
	 aNveL7ed501S4UIJH6Ho7Lz+OazHsilfMokXUsBb9Tsn2A0etAGu4wdV2idzjmoZOl
	 9mO54i365gBygjefBgu+pl+IaxUKs1YBwrw0uzjTT8/ORrq0MVEXmhs5D6TRpAb+4r
	 vGfRxODH3g3c0zbUDzMu+nYO2gaDl42xTxxWlgLcH6zn0iqxpgl3+QxSor5dIwjmwp
	 m9r7/rhdo5sYQ==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 283FE698FC;
	Fri, 23 Jan 2026 16:09:11 +0500 (+05)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Jan 2026 16:09:11 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@axis.com, Sebastian Reichel
 <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: pm8916_lbc: Fix use-after-free for extcon
 in IRQ handler
In-Reply-To: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
References: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
Message-ID: <79e7cfe8c324d580ad0189cbdd583184@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Waqar Hameed писал(а) 23.01.2026 15:24:
> Using the `devm_` variant for requesting IRQ _before_ the `devm_`
> variant for allocating/registering the `extcon` handle, means that the
> `extcon` handle will be deallocated/unregistered _before_ the interrupt
> handler (since `devm_` naturally deallocates in reverse allocation
> order). This means that during removal, there is a race condition where
> an interrupt can fire just _after_ the `extcon` handle has been
> freed, *but* just _before_ the corresponding unregistration of the IRQ
> handler has run.
> 
> This will lead to the IRQ handler calling `extcon_set_state_sync()` with
> a freed `extcon` handle. Which usually crashes the system or otherwise
> silently corrupts the memory...
> 
> Fix this racy use-after-free by making sure the IRQ is requested _after_
> the registration of the `extcon` handle.
> 
> Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Note that this patch is based on `for-next` branch in Sebastian
> Reichel's tree [1]. See the discussion in a previous patch series [2]
> for reason and background.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/?h=for-next
> [2] https://lore.kernel.org/lkml/64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com/
> 

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

Thanks!
Nikita

>  drivers/power/supply/pm8916_lbc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
> index 3ca717d84aade..6b631012a7959 100644
> --- a/drivers/power/supply/pm8916_lbc.c
> +++ b/drivers/power/supply/pm8916_lbc.c
> @@ -327,11 +327,6 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
> -					IRQF_ONESHOT, "pm8916_lbc", chg);
> -	if (ret)
> -		return ret;
> -
>  	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
>  	if (IS_ERR(chg->edev))
>  		return PTR_ERR(chg->edev);
> @@ -340,6 +335,11 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to register extcon device\n");
>  
> +	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
> +					IRQF_ONESHOT, "pm8916_lbc", chg);
> +	if (ret)
> +		return ret;
> +
>  	ret = regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS, &tmp);
>  	if (ret)
>  		goto comm_error;
> 
> base-commit: 432b119ab8d8bf1f550c247f7fbe960e87ba6c92
