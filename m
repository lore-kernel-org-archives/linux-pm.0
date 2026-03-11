Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540E3E3DB3
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250215; cv=pass; b=DUg5/aVrE9LEnjlBkOY6K5ZXt5pQ8q/yIwoslEF4st5Aq5qjLs7GomDhUPvYkh9iYHKCLGUML3krBpwCqY1WN+iEfuSWrkRVpxoTOXqtjkYPd1+J6lNRYsLOk5bUan2sfkbSVsoV0Qk/qVutsLTsWMiJ4hUtBq9vrzkFkD8bJ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250215; c=relaxed/simple;
	bh=5OBYZAWAFAqgPgNE3W1sS8+lHsHF1CjyBY9nqyA0F/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpi5QHxrZ9EG4Iylci9EmmoRCKVh3wcN8AlVWF72981QLC5n0RNDv6LOz14GFqLBasqRC99iiKTYzY7wMdSDI94YEcrP0EvW7+CMOlPc+I03+nSecXtYBZ+ZJRlAfsdTpe5Kad6K+0kTJh89LxM2T4a9Xl+i62qN4+xpmyCTd/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8jAAivA; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8jAAivA"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a131870b72so210086e87.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773250206; cv=none;
        d=google.com; s=arc-20240605;
        b=lfpeGveauCfWaQdBHaL0g/fwevBAj4f0jIe3iCexZm38tdrws0FyLlAqX9UveHJbh3
         4fTem9H/kTdJJ3wlBjzIxvNh4f7yf6povKbjDNSDmsXYA2bKfrkDRuQo7JoidOY8WTcZ
         sQEnv9GwbFQQwlYMOXXourDtGOtpNJu/u1c66BqwIUDqP8ZNeRxVm61ZUm3HzGSixw2k
         Cc9fkepczrJg4zpSMekJ7eVvwPg6nAcKxARctOASSGsfrzJbVD02ki6GPa7ROiN+FCqo
         +pvqyut2ggUU3eHnE9eOM05nGuorVeX/RMoTtkcXxa3cLnh+eSpeYW70GRAY9V/nvY5G
         h36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fZnfHCfBs+6Zz4+9A320LuMDypzwbYjaEq8gelT4T9I=;
        fh=sWvTF/R9nrBfMUL+xYdhvHS4ayL9F2lE4BMQ01SgjYw=;
        b=jVGMdpmdT7fJp/dvr0XwnI3no3L9uzfMQOxo188GHO8iMWp2imrgBDhJoxdyXliKa/
         vIOHgSDnGCpBYXdh973rG/bNeijan/lfw7VZ5kKfCDOElG0tHdXNpd2bWntWB1itx8j6
         fTZ75kWOK3mRaPe5URO7/VNbGo/quJZNmQILVQS8QsPxLo4xnXVfIgrO2O9vNLR28nZX
         3AbYRjK9KSjOwKMrWv30PrEtdrwXKJdhvR+MDV0HeAhAxS9kQ1rb51EGrMXVRG44CQb2
         cM5cQf3VSe5qhfxmsqb8goQMRj5SPxFGSX7TXFbh0URpxlzRNrE6KXvXqs+43AiZ/ZwQ
         kgQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773250206; x=1773855006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZnfHCfBs+6Zz4+9A320LuMDypzwbYjaEq8gelT4T9I=;
        b=u8jAAivAOaWNJqMAsqliMbtQKLxSB5FeqaPwoUUJLHvbRiCVbzF65h9Gcij+DbzrPU
         iG81bSqETZnbYVaw/cJqqaQHpQ544ZHMkuo9FFiPdKowk8pdN/bYByvk8rOGzkFbcL4k
         A+6iMoo6J4m8g1DAcKfdrtKQqUKcDsv0h1oB6bJWM6QITeiWdtOhvIApPYKSI5OBAKkl
         L4L2hlMTgAbE3EOzhldn8k+Yp1YTV/+aJsF9U7ke98nwrWzE4iupy/6WUswUublWHBMM
         L+y1yYqvcCEAPofnccXAYCAdiIsn+F5Pgk3duhw8QytZ8iKRv3yCWwvpIsznYUy5SX3j
         Qg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250206; x=1773855006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZnfHCfBs+6Zz4+9A320LuMDypzwbYjaEq8gelT4T9I=;
        b=N1Yu2up3Ec7Shqsr2ZqqD0RI3HfTItYew1doRfkadDO+32RXL2CTWroQq3FY1RrNK0
         P0WRL8M3omj4BHbVyPCsoSmkvC/AJYqRTzY5vTKA8iWIjFicqLQHiLb1+079a4cVL/ji
         O5x7u414vVy2wVz0FxRX9hI7ddKqEOZzuWMs61mnXtjRLkWVQAFJ2Nv39dQkT5KHmCmp
         VzGh1kfLnxIHpRy8M7ed3BU1pyfKYJ56Wr30mLHKMtSN52NGZj3NqGV40VEY7Qf4wMB4
         v+vXtMTbkTrAyv/5NQdyLekda1pX6tJB/vkrLpGFQpL03S6JwQYenoeMkVjvP982d9kq
         CtAg==
X-Forwarded-Encrypted: i=1; AJvYcCX8YiT6PR9xihP1jRGgSVeeX3J2O0LEjcRlsLIYgEGU7koEWvNd5fa+f9qfY3eJTmY6Z2Ms9Pqo2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+WhJhy+Hn29Rjf3lh6aRXIjIDllMXP4d0aGV8ruB30vfVcSp
	k1qOcbPFB3gftJaRNIUQIE89j/PQzB/ZUmZrzunTEikf6wD3jJWhiVSOfDH+TzV873ka4gdLIi5
	Fz2WJoIxtQHgJxYn8fTl+9Jb2LpE+rYAssUf3U7YJEQ==
X-Gm-Gg: ATEYQzwv+wv6vIiRAfgEdQYQi/3eMUvQFh3fksn+V0im1xvLmYbI1qrNt6hTuUOE3nX
	RXX9fNocBUNJnezlrfh9vm07lLdThrQyu5XPynKH9b9B1KabOJzdStldLc5K36gNbYlcLfEUr9N
	a/c+oTOetqbpWQAnyuig97ybNBda4Y/Ro/VJ20PTWyKWvOFGcoZmldn7LrXISD8wtYZmxsazbL7
	/pAPefod4V83MMMcx1y9KslSOZMUy4J8lmSnK53UPgT4agyKX39nQ4DOYtUGEXw7+eOuRA+mX5Q
	grCX5Ghe8lzu9HDxx8k=
X-Received: by 2002:a05:6512:2c0d:b0:5a0:ee11:8d94 with SMTP id
 2adb3069b0e04-5a156ba88f7mr1283885e87.1.1773250206343; Wed, 11 Mar 2026
 10:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210053708.17239-1-aford173@gmail.com> <CAPDyKFrsMY8q+rvrbOdppYnefX6TA1-EhF+e+pGG6k49KpeTRA@mail.gmail.com>
 <7fd891b7-b1ff-4668-ac99-8f8ac244d90c@collabora.com>
In-Reply-To: <7fd891b7-b1ff-4668-ac99-8f8ac244d90c@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Mar 2026 18:29:30 +0100
X-Gm-Features: AaiRm52dneMJr0I61s4TTlnxGT0AaZqfVcItp2PRBKI4_FSf_MRvM1HPHY0fnQg
Message-ID: <CAPDyKFqbS+PUkLXkjoHjbiVFCYM4FxQeHdJk_LVVfLA5nGEZ-A@mail.gmail.com>
Subject: Re: [PATCH 1/5] pmdomain: mediatek: Fix power domain count
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Adam Ford <aford173@gmail.com>, linux-mediatek@lists.infradead.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 10:50, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 12/02/26 12:34, Ulf Hansson ha scritto:
> > On Tue, 10 Feb 2026 at 06:40, Adam Ford <aford173@gmail.com> wrote:
> >>
> >> The wrong value of the number of domains is wrong which leads to
> >> failures when trying to enumerate nested power domains.
> >>
> >>   PM: genpd_xlate_onecell: invalid domain index 0
> >>   PM: genpd_xlate_onecell: invalid domain index 1
> >>   PM: genpd_xlate_onecell: invalid domain index 3
> >>   PM: genpd_xlate_onecell: invalid domain index 4
> >>   PM: genpd_xlate_onecell: invalid domain index 5
> >>   PM: genpd_xlate_onecell: invalid domain index 13
> >>   PM: genpd_xlate_onecell: invalid domain index 14
> >>
> >> Attempts to use these power domains fail, so fix this by
> >> using the correct value of calculated power domains.
> >>
> >> Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > We should have a fixes tag for this too I think:
> >
> > Fixes: 88914db077b6 ("pmdomain: mediatek: Add support for Hardware
> > Voter power domains")
> >
> >
> >> ---
> >>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> >> index 58648f4f689b..d2b8d0332951 100644
> >> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> >> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> >> @@ -1228,7 +1228,7 @@ static int scpsys_probe(struct platform_device *pdev)
> >>          scpsys->soc_data = soc;
> >>
> >>          scpsys->pd_data.domains = scpsys->domains;
> >> -       scpsys->pd_data.num_domains = soc->num_domains;
> >> +       scpsys->pd_data.num_domains = num_domains;
> >
> > Not sure this is the complete fix, as scpsys_add_one_domain() seems to
> > be using the wrong value of "num_domains" too, no?
> >
>
> No, scpsys_add_one_domain() uses num_domains from the soc_data for DIRECT_CTL,
> which is expected. Maybe that can be improved, but it's how it is supposed to work.
>
> So yeah, this patch is resolving an issue, and it is a complete fix.

I had a closer look and unfortunately, it still looks weird to me.

More precisely, we are allocating and registering a number of genpds,
that corresponds to the sum of "soc->num_domains +
soc->num_hwv_domains". The index each genpd gets in the array (struct
genpd_onecell_data) must correspond to the index specified in DT, for
both a consumer-node and a child-domain-node, right?

It seems like adding them dynamically changes the index. In other
words, the index specified using the "reg" property in a
child-domain-node, may not match what a consumer-node should specify
in its "power-domains" property. Isn't that a problem? Perhaps not,
because we never have both "scpsys_domain_data" and
"scpsys_hwv_domain_data", but then why are we adding them in ->probe()
with "soc->num_domains + soc->num_hwv_domains"?

[...]

Kind regards
Uffe
