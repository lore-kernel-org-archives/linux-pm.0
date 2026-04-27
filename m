Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73A3C3449
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295632; cv=pass; b=F6CTOqRpcaN1iNLzG4FGXgowON6iRUysfOHuTFu8PwMavReF2/0jRBeDvMesoK8o3VnNl6Z+xHdd3gTG8jYkS7bNMJtZx0RPpU+2ePIC3+wd0veSHXKgWYkafHbNpwZeep3GbS2FYx0zeMKpBuHmHr2sxpCrh4j1Z04FuBdwVH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295632; c=relaxed/simple;
	bh=Bj5yC+8b46RDVgUptaLnu/xG3/FmzZC5vpJJyId/REg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD/kJFSEfpeUcvPyPnkbzMq98uXsACVl8b3ytLrrf5zetI1CRQ9jLoh7ErvtqhOj+TF530U7G/9pLq5QtNLfImCvukB/oMu7f2pqun2RegtmY9PIOj6hAusxup/mrEeRoYfSlwWA9MXJDJyjQjxyh5UvAuo7ta6cLDYmcycfapk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/UkDcqa; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/UkDcqa"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso7384142e87.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 06:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777295629; cv=none;
        d=google.com; s=arc-20240605;
        b=lFe15n9G3V6jwN1Qqmnt1QP1bNOsCsYloNQZPM6biGFCv3OknFghHwlNJQi+N3Ma9L
         Vi5lUlBHpiIhx3gnHdZ55bzC5pRAWddvJdjfae9XhKzRwgWeMNb2xGpj8F7vWiWKTK2U
         KdiLEpeJZj08a1WNwyAsaw1LTA4BUH3airI04N2MzQnUeSEwsvgHrVYsIjvEZes1mv5m
         9Csj2+Tx9pzog2VVI43vCBtXsNSJZVPTPHwG6nQSaxo8iGYnDPY5cg0LwD7eg/Ar1A9R
         OVF2+3kO4H1T2erTyMNJqs1iPLY2H4H4gtYYqxc6+Uhut0N22G1ACiSvteLF3s8PyK8A
         un+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L7//5ece1DlWDMT1aLpKgGFyRfsm8Y+IqHoNcwNLtWg=;
        fh=q9zSDGh6oq4t9LXVVJ5xDnSRflmrrvJFjxcZgNLZDHY=;
        b=RwOSnD/EsWFqxQWzVmeoKK2PdcqCHsCcJIQ1yiGEDtxI1ymTaanbj13oP1DVLfguvR
         PZlBAWZyZUotrnBKuMH603cP2S+o7Y1Ze9uX35eQUps0oVbVE8cJ7bJ6L/Q5GZCwdDiJ
         YHhzjqQQSYfn74TzIcg1UcPJSSRg5ZublT4WV4Kv7G+mBKEsGJW+RR06vRiKf7sxnaWY
         ThgKWKo4kaV/TJywF/mf/3wHnYITpdto+42EfBproXHVz/NHeESFeiTNBPsn4yRpbIZt
         iOE3IEsN73MJE28w8BZIQ3v/+NpmJOyKgFWihcSYKxrNpKcYNSX0ghjhgmn50dEcsyH5
         cZ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777295629; x=1777900429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L7//5ece1DlWDMT1aLpKgGFyRfsm8Y+IqHoNcwNLtWg=;
        b=T/UkDcqaD+Vy7Lhtce4drzBtghuLePgTrncmXUFzJBpgX16jvusyijLVWq+AI4Qwm6
         A5oRJXe2HcYOWtJ6o4evB9QTNAeiA6wvU1Ip2ZlvBVm/vEZqSO+Ln79AQ0QZQx6HYeUC
         xNTxrj1MjBw+KK9aCxKPzCweXSmgnH2PcTtu7aGCJdPd+jGIRDcpTJLqTtuy8NVy2B2t
         EJc/EEyspzCiMo1MrFONYwojk2kr6UH5E079NtJ54t0XZUgrF7mdczu8pDddfwQISFYm
         T+/nwkzFI8BBkSuYse+ZhnK7kGtlkkBV72fIj6cF6V9aE/D0s7cknise5A5+UxFe6e7w
         0bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295629; x=1777900429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7//5ece1DlWDMT1aLpKgGFyRfsm8Y+IqHoNcwNLtWg=;
        b=sARakPVw9s4ibv8hXiET6CmLv7tX+DmIx1H9f6AvcOPBewRJd8mVu+WEo4WcGtBQWY
         nAsfhFL3qAlAtAHmnTp5J59lNpmjBUxVj0SmwXizVeQcMIA8A3zSbqU2UO/BKgWdKT6v
         +x72ude8SuAe01TvVhFIczaqWFnW6SHwdia6G++rYyIYKxd3Ib9d0q5W8I1Y+oJbjecr
         8HUQByao74LM63Vqxvknri7crE5zfhYtsXiN4z/Fx42Eb89XfK+Gj/6GDR8xVDjMi5zw
         CLLDhMqwV18iW7PmqHsS0UD+ekipLMyoHRvEN/lK5qUowKOOYpKkaWpbdzm6S8GkzZbd
         3Z8A==
X-Forwarded-Encrypted: i=1; AFNElJ/pZcgJEnUyYJQ9f98rBHoH2FgEx6NyGS+LtXT092N9O2j7pjcZkPB5QAWaBmrN84ZxVn4AlvnjeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRbHAZWs0+/HFJO/JmXnp+pqhlMOnKeH2sKSDcCjex30ylBhT
	b/zpWfrs2xUNJ45+nNDu92VClVWFNresNu/KPqRI0frBIJIfgStzelPwZ5bad5poCEOarxjHTzP
	G/tO60I51NwWwTyFpZ92HkcScXMZ5OqKpThnti9KZRg==
X-Gm-Gg: AeBDieuNY61kIeTyVCR13s7RPmbCWpX+PXXySg4AeXJyrXXom189J8UfKOcBg/IJNBz
	hlufplZrZo++UfkjInNUZEP1RztnFAIFXjv+6+uhZIoewWBDA4cfkdV7TFS3JA86MayWS6e07SA
	CfVpdHPB+mgkdiCrqhM8JFbSsNWyWHYdAZT2mp6W9KA6jn8nGW0ZMbJZAn5X/s/VaGyf+xtxKX+
	jJUgAxdWjGMAVCnsubibuVgFAW510NVUwk3LqnZiZPxm5ayyFdk0Lsz7Mma/3Cp7PGSBCoNDylb
	XlcUiUk6paVWUJeTWDY=
X-Received: by 2002:a05:6512:3193:b0:5a4:1672:59e0 with SMTP id
 2adb3069b0e04-5a4172cd574mr14121153e87.19.1777295629037; Mon, 27 Apr 2026
 06:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408141121.386522-1-vulab@iscas.ac.cn>
In-Reply-To: <20260408141121.386522-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Apr 2026 15:13:12 +0200
X-Gm-Features: AVHnY4KIw0y71PHOTou49MhZ1vsAm_GUfrl6yfolmci7Zff-_TktbzdbSpL-x1c
Message-ID: <CAPDyKFrTG6tp9XbuiUYjgMYkHYQwVsyXBuggCc3Lp=J_NcKTyA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: fix use-after-free in scpsys_get_bus_protection_legacy()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, nfraprado@collabora.com, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Adam Ford <aford173@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 16:11, Wentao Liang <vulab@iscas.ac.cn> wrote:
>
> In scpsys_get_bus_protection_legacy(), of_find_node_with_property()
> returns a device node with its reference count incremented. The function
> then calls of_node_put(node) before checking whether
> syscon_regmap_lookup_by_phandle() returns an error. If an error occurs,
> dev_err_probe() dereferences the node pointer to print diagnostic
> information, but the node memory may have already been freed due to the
> earlier of_node_put(), leading to a use-after-free vulnerability.
>
> Fix this by moving the of_node_put() call after the error check, ensuring
> the node is still valid when accessed in the error path.
>
> Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps retrieval")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e2800aa1bc59..d3b36f32417c 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -993,6 +993,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>         struct device_node *node, *smi_np;
>         int num_regmaps = 0, i, j;
>         struct regmap *regmap[3];
> +       int ret = 0;
>
>         /*
>          * Legacy code retrieves a maximum of three bus protection handles:
> @@ -1043,11 +1044,14 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
>         if (node) {
>                 regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
>                 num_regmaps++;
> -               of_node_put(node);
> -               if (IS_ERR(regmap[2]))
> -                       return dev_err_probe(dev, PTR_ERR(regmap[2]),
> +               if (IS_ERR(regmap[2])) {
> +                       ret = dev_err_probe(dev, PTR_ERR(regmap[2]),
>                                              "%pOF: failed to get infracfg regmap\n",
>                                              node);
> +                       of_node_put(node);
> +                       return ret;
> +               }
> +               of_node_put(node);
>         } else {
>                 regmap[2] = NULL;
>         }
> --
> 2.34.1
>
