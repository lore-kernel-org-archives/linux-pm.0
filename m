Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023667;
	b=mDEm6+6Nr1COj/gsdrS315oskxvlQSj6Y6E4W+fBifgAI/E3VGQ6tNc5e6Y3kwU1HgIX
	 7FxkBXiJYSEJjJyVWJRGDX2ns8f7wFAmcH8Jc8BlZMmLyhKDA4ZWrma13uDX5sFiz7fOZ
	 h5zSjVeDVqJFUH/REhJO5OMWZVOVw6XI5tEjkc0RIaoLvG07aJpE1N/AyCi58fenlGD7b
	 WRARQjRTm1feMXArzbpWk45Zv7D3OodaCP3k+V92wBE9jqhxQ1iRM5gJoFFEDMFeAFqY4
	 pOepCWM1vgdAV851gtTWt7btuo+b/Qsm+Oxn8H75UIUAiUMfJGYwHZgrm7DzLvrDQBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023667;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=XDw7IcoXcwWijRhNP3kWys9OVzhOsB2/yX037KXF4Ro=;
	b=M+AnUGooJMLBAnri1vpbvuJzqg518sUA7Q5ksL+NbnEWmZL3ktb8mkpgYD+HDSe1nGiI
	 73jEWrHYjNwkp6DpLf0qrPh80FbYcA3swxK8QobKJ+MVSmCV+TBd8fCrjkndit/uZzHo4
	 0ZK3WrSo6epeSDXnFTEibRE/TtcaeZjEzZKfK4QEe3V4iHddJzPB4v2thsFCkOpb0/NQq
	 RtmrWqFJ5thb6yw4jV0bhH0I7GS6/i9Y6ZTRG2HiaRTlvaIlQFj7iwfkNPxVHTY68zH1o
	 +oCeMjZtFJhr/QSGG92kzNOBcTp2KW1Uot11GbV0LkJxd6v0g1N/AW+ZizxCSOdRHTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm1 header.b=o46p7hQR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kJWpizz3;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017F606A320
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3017F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm1 header.b=o46p7hQR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kJWpizz3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A75491D003C9
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:07:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 10:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793023665;
	 x=1793110065; bh=XDw7IcoXcwWijRhNP3kWys9OVzhOsB2/yX037KXF4Ro=; b=
	o46p7hQR3/YbzRr2CCRs1S2eiUv5n9mlYWyHvKK0h0qmJCVuziv0nIPq1p3A8Tmv
	m+B3RP2iFVgZyP9SkKtoV31LvT5Nb29pY7A686y3uis1mfyUVyxeU1ylTQEs9agK
	u9ZWwBhxFpBxxPSUh+101tcpWjBnT+aKioJ++5gH+ZOkDnMfGzGs1gPqBJCOObwK
	TuFQTdTTa70uoOkNXyhRHkxGNbj3ewfMJr7qZi55UkDQ341RpYLqnaVhX84j8c+O
	i7R5rDc4rjPxlhUwC4km/UStSNYU8zqutOZATloCZ0jEplNi77jQ24mw9QShu7rn
	o9NDbogjcHrvNVI/+V4AkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793023665; x=
	1793110065; bh=XDw7IcoXcwWijRhNP3kWys9OVzhOsB2/yX037KXF4Ro=; b=k
	JWpizz3fOK78tFLHyT5grz6NoaFp1oE5A/ckX5oG8T7yrtRV0Gz3X8hT2qWyIlXU
	BvvfU0rnxEGMCsJ+WGO5tqfZxEDsSbjdUv+ahMBnF+mOee5qon+vIKpyiMfrVn2c
	N4zhA6wQf3BeMS7oGT29Gzy29E0RHH8V+s3KfbWmFkMGa1itQXgAFJVVyZZ7jj1l
	fitpwnw9JYuCkY5nPc54q7IATsfXe7uoxa671htykh2JJdVaXGJcP9LsGhCoxZBo
	A5zbZVlVbP2IFeR6pWbQ5Bof5f8toF5Eu6m5qYjAEedqRMkaV5Fyub4sKz2VBy8D
	TYTobxtjPfsjaTfbzXpZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793023665; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:av449MNg97Q9LombL6P9ccNuCoIL5hRmcq6iAUfug+fd0pL
	uVvCwy25n2CXdEZQdF3K70CsjcPwf7gHaMfilW8P8OysgcaxucMzu3WJewlxMGzb
	U4ei+BG+3MTiBFKEMkC4GzHuCZzIZlpe/Apzrm8ZZyLGUvZaLQWuCYn0sS3Cwd0/
	ha5j0NGxG4A2TR06gOUQXrq61xC+9VKNNQAYAi3wRTJnHdmq+IKNHdfVDRKtRnAf
	D8yp3FzSG25whUwMwOdg1Q/HXawdaBRm6t5BejZCOcgikBuUmklEP/r3ZrkUcGAo
	tOVxFyo0ssKH0eE7/Zm6WREZVAqQwZhzoj8sPkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tUMj578xm9B5bEJc5f+ImvL62O44PBjXsoN9GLoT8Qk=:Sp4nMPPIXzzLdI3HqpoHKlLEmIpXU1wWVVuz7Rm2M8I=;
X-ME-Sender: <xms:sV7fapqb-nCJ7Hle3FAcC-NEQxBhOOypEOpKd_WjyIYKJsieb2TfWw>
    <xme:sV7fanhvXTcugqQqKpb1EfRLHg4IyRGwbwekEddoL6OabyjFbvgZ8eJ3jn1IxaSXv
    eZD7khiOXS6b4rk25Q2I0ctpdwT2VBi3xfmQFtn7ShQ9CYIn6R89bMhOQ>
X-ME-Received: <xmr:sV7fajNhWSfjbQaWzJloaLAqPxr1-xU2581qIbNavvglmb8etfGFIEf8hsnSJ0X0uJCdK7a1MoHmUQwk8f1JSaTqpY-HC3w>
X-ME-Proxy-Cause: dmFkZTGNXUMS2UHU5v6sb7fcqJngNDG5NVCmW3qZ0sw87WXfPII9v0gOfz0bEclZzCQ2Hq
    9czmEI30wu42dYLjIHp2kagQI9GVgCgBzbdkWzk1G1Fke1RSQ79ocvNsCGLH4i/WJ6V9zY
    e3l2htE24rbLqk85ZUY6pwFoLj5F5PMSrGTpgD28cGlKPsfjy7iPBCPzbgr23fz9kO7viY
    DyxejT69Mh6UlKrIfks7yLlh9lJR6CBTQUYVM2qSJ9d/gx/7i4BB6qUPBjhnB6azYo69FV
    gWKS9ubyd0mia3+nmweHqrKuB1RXjydOJfxmcA//PN7zN5iGn8YsZfvPvI/v5vutMeeDZQ
    IPk3WiisB8asHoX8HJCTZW8mPvZJ8kwMTG6fO6U9Tg9XfK2mXnR/F4FItygnS5KoXz6zzG
    N+j6ydimR1zcWg6oQw2h4jBNeLs9Wepm4A2EV1BMJ/6AhngyBuudGQnNZ+olKjVNIlF5OZ
    LsUuweIUf1APpGvQqtu8nKuCYygIB7tmV755fN7lZvYXVJaLv7BCSkx5IDMCc58DWat7BZ
    YqIwxKz6oL79sR0kK4f0i8SFB15U1s1BfgjkkJQtl0ZK7f2sMKVIhHnjsysvRAwH4uEqFx
    9UzdCOrormkv+/JA1B5JiW52aOwc9CY54oN8m4n5l78z/mFxYYvsl+1+9GNw
X-ME-Proxy: <xmx:sV7fapyfl6BVdfZSYBeL1HWdXYDlwh2vIVhn1O6EX1OUq-g-3jPoPQ>
    <xmx:sV7fatpWFs5dbe157ZNPAE_vGwNqXNYC1r7BlWePS214e0mU3nFjTg>
    <xmx:sV7fahMUMSFhkX4lKFEYjrXsMGZ6AY_FyBUzdY9l49D6ROeUY_BSEA>
    <xmx:sV7fapc0_XsEfPvaeR4fQM_48nlHv35AkiCKmjVOPHGC_wNqgtAwOw>
    <xmx:sV7fahq4bLlo31OxPmAnOXmnGAdYfEvGEK2EUwodOnPFWJlaLrVeej5o>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 10:07:44 -0400 (EDT)
Date: Mon, 26 Oct 2026 15:07:42 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Li Ximo <lixicaicai@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wang Haoran <haoranwangsec@gmail.com>
Subject: Re: [PATCH] thermal/drivers/rcar_thermal: fix list_first_entry on
 possibly empty sensor list in suspend/resume
Message-ID: <20261026140742.GB1959885@ragnatech.se>
References: <20261026115018.3227372-1-lixicaicai@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026115018.3227372-1-lixicaicai@gmail.com>

Hello Li,

Thanks for your work.

On 2026-10-26 19:50:18 +0800, Li Ximo wrote:
> From: Wang Haoran <haoranwangsec@gmail.com>
> 
> rcar_thermal_suspend() and rcar_thermal_resume() call
> list_first_entry(&common->head, ...) without checking whether the list
> is empty. list_first_entry() does not return NULL for an empty list; it
> returns the container_of() of the list head pointer, i.e. a wild pointer
> into struct rcar_thermal_common. Dereferencing it at
> priv->chip->needs_suspend_resume (and the MMIO accesses through
> priv->base that follow) is undefined behavior and can corrupt memory or
> crash the kernel.
> 
> The list can indeed be empty: rcar_thermal_probe() only adds a sensor to
> common->head after platform_get_resource() succeeds, and it returns
> success even when zero sensors were probed (no i == 0 check before
> "return 0"). With a malformed DT node (no MEM resource) the driver binds
> successfully with an empty list, and the PM core then unconditionally
> invokes the suspend/resume callbacks. This was found by code audit; we
> do not have R-Car hardware to reproduce it at runtime.

Could you please audit the code some more, preferably without an LLM.  
While I agree the issue should be solved this is not the fix.

Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Does it make sens to allow probe to succeed if we haver a malformed DT 
node? Would a nicer fix not be to fail probe with -ENODEV in that case?

> 
> Fix both callbacks by switching to list_first_entry_or_null() and
> returning 0 early when the sensor list is empty. This matches how the
> rest of the driver already tolerates an empty list via the
> list_for_each_entry()-based rcar_thermal_for_each_priv() iterator used
> in remove and IRQ handling, and does not change behavior on the normal
> non-empty path.
> 
> Reported-by: Wang Haoran <haoranwangsec@gmail.com>
> Reported-by: Li Ximo <lixicaicai@gmail.com>
> Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
> ---
>  drivers/thermal/renesas/rcar_thermal.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index 9a9038671..65dba6354 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -530,8 +530,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  static int rcar_thermal_suspend(struct device *dev)
>  {
>  	struct rcar_thermal_common *common = dev_get_drvdata(dev);
> -	struct rcar_thermal_priv *priv = list_first_entry(&common->head,
> -							  typeof(*priv), list);
> +	struct rcar_thermal_priv *priv = list_first_entry_or_null(&common->head,
> +								  typeof(*priv), list);
> +
> +	if (!priv)
> +		return 0;
>  
>  	if (priv->chip->needs_suspend_resume) {
>  		rcar_thermal_common_write(common, ENR, 0);
> @@ -545,10 +548,13 @@ static int rcar_thermal_suspend(struct device *dev)
>  static int rcar_thermal_resume(struct device *dev)
>  {
>  	struct rcar_thermal_common *common = dev_get_drvdata(dev);
> -	struct rcar_thermal_priv *priv = list_first_entry(&common->head,
> -							  typeof(*priv), list);
> +	struct rcar_thermal_priv *priv = list_first_entry_or_null(&common->head,
> +								  typeof(*priv), list);
>  	int ret;
>  
> +	if (!priv)
> +		return 0;
> +
>  	if (priv->chip->needs_suspend_resume) {
>  		ret = rcar_thermal_update_temp(priv);
>  		if (ret < 0)
> -- 
> 2.30.2
> 

-- 
Kind Regards,
Niklas Söderlund
