Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992E3C2762
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326569; cv=pass; b=KpFKceGsmKoT0uNFCSsMNENK7gDuKluyVwfCU0vEnTTTPtMTXbPKRDLg0k/+XdVxMWmIlsJOOor3jKpIYhi0nsTtntLhoMadXL3lOXBk4Ob7HsiYZaGa+Ihl5dSFdypLx/o5v3lxJuIPZnApejGSvmvSNbZBBQlZi+wM017KifY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326569; c=relaxed/simple;
	bh=O9LcIYrKm3IMRU3Xcbw5ao9vnQL7OMM6Hl0piZRl6B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBtuPX71PEp9yuJEirE+LpSKaGLVf5tGp13n7fZbw5HEsi1JyWNpJg2+00g2/lzbzapuvqLUD0HJtrbAYGloYwlw69i7qFOZXKxFD6TGhLsVz0sC22gE+Q2pnj4OY8EmJEJ7+rJn7RmA2KCbmO5JBF/bEQKQtowL/dy8oQmKCwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OweVSTHQ; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OweVSTHQ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so1598089e87.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 07:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773326564; cv=none;
        d=google.com; s=arc-20240605;
        b=ZEry9mGTELrp9htcmI5X+Y1Ovh/MqMDlUlEB4I8HbXouE99TNnNsDafsCV2TjZdXwD
         c9cytxnhifzyRFVBspcaUyDEqLRDAX5Q2cHmygFyaoZAnHic7jeRO2YV/LLC4Pxgf2Nw
         KIjrzaEds6p1MBDN8JXSxmaa3AwSreGvERx8yszmc405UHcsxirHLsxl2w/y9lJL8AOk
         5STbmKMm56JwS1lHQBln11yo0Bdzrv9uUcX2UU1+5xtk0NvMYYOsjItwf7hNy6WPTf6I
         6hu+N1KImGmzpaGqYPioV5+X8INjX5EjmbbGcUrgTY2o+OY0oTXqjZBraZG3d7IYlK9p
         MddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0R6OZluBmRNxZl/w5NAcbeDBTecdzejm214xvTMZFOU=;
        fh=DeqsVaCpk/a1sdcaj3RApHjLqvl1qDZr42VgbPYpOPU=;
        b=Ex4kGZlUoyLv38Xsc/rx2ASHASQrJA8h9jn3vxN4iIYXYwS74Sk4FjNZdNhb4XUj1p
         PvXhlFugAE1q7p7SfY40fwFNq9Syb/JrWeIonIBBJUViZTou674aN67tdBfn7EBum8I0
         CMeuSDeTZ/4Y1br4FdhpHDUaeVRBJXh2ZZ5W5pq85Mvww18CTs0FgqA3dRSqosGk92Li
         QkdlhLA7MSEKgL2WcCB7JDcLvQsK24zzwKyvPEAeAhT2CsWi+7C3kBIEPzWdt91ct7TV
         YdbUlZnp6SPlhiZxa6Mq2HGDDELcEL64NoIQIVBQ2Hq9qAhMET1U5bMPxXhaPAnT5mFV
         VYww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773326564; x=1773931364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0R6OZluBmRNxZl/w5NAcbeDBTecdzejm214xvTMZFOU=;
        b=OweVSTHQkJIYH+xVrlXrb3YCzjZ5K2VKCMnH5dcKqOZ9zGfvDjxgAtmXHaYB8u6trC
         83V0/jQD7Oat5Yu530vLOyQZAPUL0Fo7sKMu9CWrS7/0DbqR1mMnWvA+lSByg/fnMbqY
         Y/UGENCV4fWA2D9CA+z2Jhr/J+HvoaEZzXXwpLZ8G6sqK6LtY6XB3jymPT4+CdmboX89
         Aok6X7JuOlNMFeG3n8R0P2j24vnm8LSywkSF3e7cx/fSYKeo0kIZmOu9M7tpqcvhkj63
         kfx0LahHrlkYeLZW7iXt/uJWaYHrB+lcZHK4OgYA15WAd/jdLn6bWFsObRqCkDg+97R0
         OeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326564; x=1773931364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R6OZluBmRNxZl/w5NAcbeDBTecdzejm214xvTMZFOU=;
        b=OSzEH2hwRNcTm7U4NWnX854VlJ/qISwMJg/XcM78yfbt/FtG2CadFDNpL9quw3rnwj
         JtK5chR1FYJxHuqPsbE3CAevmeFUkXQaZNeEsxqWTQDSRgzvwdq3XUwmySl9855XJGeJ
         AFUfBpCrHgZENkgiP8+/l91XEICY57glEXgNSHcVGznayht1ZKi15yQE11mW5VwZiFUt
         ETAXdjlK8bpChAHED9WXGryPQN1TgxzFvz1Vx1XuolFwEGZEc6oHisMfamMWBzaWds+d
         tWgPOc9KZGIV3oNEwXIy/d93RzVB2Knix0dKUabjCUdJqUnKCKsEzU1ceueIAgefo5uq
         73sg==
X-Forwarded-Encrypted: i=1; AJvYcCU5fRF2o+BMp1M/hoaEQ1DMQI1XFOH7shdCO9sde7327p0+cxyU/YkIKjG3SLZDeqpGbJnXQdZ1SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPtilWJr9EnXrzry5tXcp1YSMj+RFWln2ZwSdy2BqbOUOLV8Ef
	VgFg6svVOAF8T713BMmnHkjUbYEx9NuU0nEf2Wj1QEpfNZfgLm4WAxVOxZiQ7+Wi7uSJVs4oWku
	y1pJ7a7TX6fAuzp10KV0a+/eClNqYIw+xykqfwkE81g==
X-Gm-Gg: ATEYQzypNyeyaPkHHedityPynkC1O8qBaQ874ocASrXji2hMHEg34/wryusfAdcHvG3
	BJYq+IcBoU1DpLSPXtzzadENtIs0uYi3dB1a1B2y35T6Y5x7B/NB4Cu5/vd371ljqjpwkP89hZs
	PtVz2fddwRy6zVNo0Qf8I1W6AHfvX283+O0VdARdFw5XSqh73Lmf54/t1VnpfUmXSoxj0KC4ig8
	D2xf4xpFExlQmtM6qkaLAsa5WGr4vg3inbdbUxwPzhe9UuYSqk/H6kK8RqDUkpw91TNFTpPluHo
	98poKUo=
X-Received: by 2002:a05:6512:3405:b0:5a1:2ea2:3683 with SMTP id
 2adb3069b0e04-5a156ddd92cmr2624715e87.44.1773326563685; Thu, 12 Mar 2026
 07:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210053708.17239-1-aford173@gmail.com> <CAPDyKFrsMY8q+rvrbOdppYnefX6TA1-EhF+e+pGG6k49KpeTRA@mail.gmail.com>
 <7fd891b7-b1ff-4668-ac99-8f8ac244d90c@collabora.com> <CAPDyKFqbS+PUkLXkjoHjbiVFCYM4FxQeHdJk_LVVfLA5nGEZ-A@mail.gmail.com>
 <108e6fad-401c-427a-bc30-8ddd00bd93a5@collabora.com>
In-Reply-To: <108e6fad-401c-427a-bc30-8ddd00bd93a5@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Mar 2026 15:42:07 +0100
X-Gm-Features: AaiRm53Syf4tONBWunUd9bjmXw_xdyFjtpRQ2mt1ntlqT4z8S3DYLkSeLVjeLKo
Message-ID: <CAPDyKFoY+pdSh-h_=Ko9L7QaFo4V4iA2_A0jA3BfnuKmiCyzCA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pmdomain: mediatek: Fix power domain count
To: Adam Ford <aford173@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 13:46, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 11/03/26 18:29, Ulf Hansson ha scritto:
> > On Fri, 6 Mar 2026 at 10:50, AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 12/02/26 12:34, Ulf Hansson ha scritto:
> >>> On Tue, 10 Feb 2026 at 06:40, Adam Ford <aford173@gmail.com> wrote:
> >>>>
> >>>> The wrong value of the number of domains is wrong which leads to
> >>>> failures when trying to enumerate nested power domains.
> >>>>
> >>>>    PM: genpd_xlate_onecell: invalid domain index 0
> >>>>    PM: genpd_xlate_onecell: invalid domain index 1
> >>>>    PM: genpd_xlate_onecell: invalid domain index 3
> >>>>    PM: genpd_xlate_onecell: invalid domain index 4
> >>>>    PM: genpd_xlate_onecell: invalid domain index 5
> >>>>    PM: genpd_xlate_onecell: invalid domain index 13
> >>>>    PM: genpd_xlate_onecell: invalid domain index 14
> >>>>
> >>>> Attempts to use these power domains fail, so fix this by
> >>>> using the correct value of calculated power domains.
> >>>>
> >>>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>>
> >>> We should have a fixes tag for this too I think:
> >>>
> >>> Fixes: 88914db077b6 ("pmdomain: mediatek: Add support for Hardware
> >>> Voter power domains")
> >>>
> >>>
> >>>> ---
> >>>>    drivers/pmdomain/mediatek/mtk-pm-domains.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> >>>> index 58648f4f689b..d2b8d0332951 100644
> >>>> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> >>>> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> >>>> @@ -1228,7 +1228,7 @@ static int scpsys_probe(struct platform_device *pdev)
> >>>>           scpsys->soc_data = soc;
> >>>>
> >>>>           scpsys->pd_data.domains = scpsys->domains;
> >>>> -       scpsys->pd_data.num_domains = soc->num_domains;
> >>>> +       scpsys->pd_data.num_domains = num_domains;
> >>>
> >>> Not sure this is the complete fix, as scpsys_add_one_domain() seems to
> >>> be using the wrong value of "num_domains" too, no?
> >>>
> >>
> >> No, scpsys_add_one_domain() uses num_domains from the soc_data for DIRECT_CTL,
> >> which is expected. Maybe that can be improved, but it's how it is supposed to work.
> >>
> >> So yeah, this patch is resolving an issue, and it is a complete fix.
> >
> > I had a closer look and unfortunately, it still looks weird to me.
> >
> > More precisely, we are allocating and registering a number of genpds,
> > that corresponds to the sum of "soc->num_domains +
> > soc->num_hwv_domains". The index each genpd gets in the array (struct
> > genpd_onecell_data) must correspond to the index specified in DT, for
> > both a consumer-node and a child-domain-node, right?
> >
> > It seems like adding them dynamically changes the index. In other
> > words, the index specified using the "reg" property in a
> > child-domain-node, may not match what a consumer-node should specify
> > in its "power-domains" property. Isn't that a problem? Perhaps not,
> > because we never have both "scpsys_domain_data" and
> > "scpsys_hwv_domain_data", but then why are we adding them in ->probe()
> > with "soc->num_domains + soc->num_hwv_domains"?
> >
>
> As you understood, having both is not really supported right now, and the
> intention there was to have the flexibility to do so without restructuring
> the entire thing in the future.

Thanks for clarifying!

Although, having both seems problematic for the reasons I pointed out
above. At least, it looks like some more re-work will be needed to
support that case.

>
> Though, from what I understand, the confusion comes from a single line (and
> reading it again, I do agree, because I got confused myself for a moment as
> well, and I'm the one who wrote this, so that's bad bad bad):
>
>         num_domains = soc->num_domains + soc->num_hwv_domains;
>
> where, to avoid confusion, this should've been:
>
>         num_domains = soc->num_domains ?
>                       soc->num_domains : soc->num_hwv_domains;

Agreed.

>
> (perhaps with a check `if (num_domains && num_hwv_domains) dev_err(only one
>   supported)` but being this taken from hardcoded data, I'm not really for it)

Agreed, a print would be superfluous.

>
> ...and still, like the proposed fix does:
>
>         scpsys->pd_data.num_domains = num_domains;
>
>
> While I agree, again, in that the code could be improved (and it shall be),
> how the logic behaves, right now, with the proposed fix, still looks good to me.

Okay, I'm queuing the $subject patch as a fix and by adding a stable/fixes-tag.

>
> I can eventually just send a patch that clarifies the `num_domains` if you prefer.

Well, actually, I would suggest splitting the driver into two drivers
(each handling its own type of match data) and adding some shared
helper functions, that both drivers can use.

It's more work, but we should end up with more maintainable code, I think.

What do you think?

[...]

Kind regards
Uffe
