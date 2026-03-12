Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF703B47ED;
	Thu, 12 Mar 2026 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319604; cv=none; b=mnU4q1oNjneIHL4wOqB6FYbGk7jrQcNtHGS9I5/iXdRQ5IZT8uSN69irCKjpYGIz79JNntAzCGcCKqdxjIWxnATn9J0+XZtcHc0C2KMl9ARLs3NDFNHqwgnKnAyZ5OJvghbpNtnt8QmN0h3g6rPR3p2k0Ly4BsvrgwHyzS/P5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319604; c=relaxed/simple;
	bh=mY+91mincze6m6Vha1kTJqvDpfgu54oXIdulrrOWVak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlo4b7QJRbCI0uFEjqqYOh5Q3PJZz7u2neDdGRNUWOqA1dF3dYhyXumDAzfxHb8IOdrhzgHrwuEe5xPb0Y/TWl1xejxdN1Bod630jLdkw+TfZVLd7llOQYnnE1yf5YPSzYnM1hgIwTCPcEIWAsQ2Pi2Lzl0cUBgNxTjsCrGNaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jVierYV/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jVierYV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773319601;
	bh=mY+91mincze6m6Vha1kTJqvDpfgu54oXIdulrrOWVak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVierYV/GlJ8hYRKH5G0X3lUl+ORL1jv32MHDZPBr8uxj4Qg8i6fdzr2QgGOHFwXs
	 UOls6/3zWdZT4CPpTYj7JUvCDTSB8lVXMqZXbV7K5zWYlKA0hRckuJES4CXKwnLPQ7
	 rSdxWXl3iErmSh9C2vN03XFrXSR7uNNz5gSA/EmBkyPDGWe05E/cXd76aUn5/2eOCX
	 FVfN6cL2YecwE602yiAeVnt2VX6P/RP2WeTZwhKnLiU+X+9X93CcCdaQTUl7NG64E/
	 CyfThuVug++ZhGNRd14tzJiby6TrwWQZ0Mhsn2IgBvGy2iM4PdgMrnAqTPtrqGFs5n
	 sCgN5+eQoxiNg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C776017E0E6C;
	Thu, 12 Mar 2026 13:46:40 +0100 (CET)
Message-ID: <108e6fad-401c-427a-bc30-8ddd00bd93a5@collabora.com>
Date: Thu, 12 Mar 2026 13:46:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pmdomain: mediatek: Fix power domain count
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adam Ford <aford173@gmail.com>, linux-mediatek@lists.infradead.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260210053708.17239-1-aford173@gmail.com>
 <CAPDyKFrsMY8q+rvrbOdppYnefX6TA1-EhF+e+pGG6k49KpeTRA@mail.gmail.com>
 <7fd891b7-b1ff-4668-ac99-8f8ac244d90c@collabora.com>
 <CAPDyKFqbS+PUkLXkjoHjbiVFCYM4FxQeHdJk_LVVfLA5nGEZ-A@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAPDyKFqbS+PUkLXkjoHjbiVFCYM4FxQeHdJk_LVVfLA5nGEZ-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/03/26 18:29, Ulf Hansson ha scritto:
> On Fri, 6 Mar 2026 at 10:50, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 12/02/26 12:34, Ulf Hansson ha scritto:
>>> On Tue, 10 Feb 2026 at 06:40, Adam Ford <aford173@gmail.com> wrote:
>>>>
>>>> The wrong value of the number of domains is wrong which leads to
>>>> failures when trying to enumerate nested power domains.
>>>>
>>>>    PM: genpd_xlate_onecell: invalid domain index 0
>>>>    PM: genpd_xlate_onecell: invalid domain index 1
>>>>    PM: genpd_xlate_onecell: invalid domain index 3
>>>>    PM: genpd_xlate_onecell: invalid domain index 4
>>>>    PM: genpd_xlate_onecell: invalid domain index 5
>>>>    PM: genpd_xlate_onecell: invalid domain index 13
>>>>    PM: genpd_xlate_onecell: invalid domain index 14
>>>>
>>>> Attempts to use these power domains fail, so fix this by
>>>> using the correct value of calculated power domains.
>>>>
>>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>
>>> We should have a fixes tag for this too I think:
>>>
>>> Fixes: 88914db077b6 ("pmdomain: mediatek: Add support for Hardware
>>> Voter power domains")
>>>
>>>
>>>> ---
>>>>    drivers/pmdomain/mediatek/mtk-pm-domains.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>>> index 58648f4f689b..d2b8d0332951 100644
>>>> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>>> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
>>>> @@ -1228,7 +1228,7 @@ static int scpsys_probe(struct platform_device *pdev)
>>>>           scpsys->soc_data = soc;
>>>>
>>>>           scpsys->pd_data.domains = scpsys->domains;
>>>> -       scpsys->pd_data.num_domains = soc->num_domains;
>>>> +       scpsys->pd_data.num_domains = num_domains;
>>>
>>> Not sure this is the complete fix, as scpsys_add_one_domain() seems to
>>> be using the wrong value of "num_domains" too, no?
>>>
>>
>> No, scpsys_add_one_domain() uses num_domains from the soc_data for DIRECT_CTL,
>> which is expected. Maybe that can be improved, but it's how it is supposed to work.
>>
>> So yeah, this patch is resolving an issue, and it is a complete fix.
> 
> I had a closer look and unfortunately, it still looks weird to me.
> 
> More precisely, we are allocating and registering a number of genpds,
> that corresponds to the sum of "soc->num_domains +
> soc->num_hwv_domains". The index each genpd gets in the array (struct
> genpd_onecell_data) must correspond to the index specified in DT, for
> both a consumer-node and a child-domain-node, right?
> 
> It seems like adding them dynamically changes the index. In other
> words, the index specified using the "reg" property in a
> child-domain-node, may not match what a consumer-node should specify
> in its "power-domains" property. Isn't that a problem? Perhaps not,
> because we never have both "scpsys_domain_data" and
> "scpsys_hwv_domain_data", but then why are we adding them in ->probe()
> with "soc->num_domains + soc->num_hwv_domains"?
> 

As you understood, having both is not really supported right now, and the
intention there was to have the flexibility to do so without restructuring
the entire thing in the future.

Though, from what I understand, the confusion comes from a single line (and
reading it again, I do agree, because I got confused myself for a moment as
well, and I'm the one who wrote this, so that's bad bad bad):

	num_domains = soc->num_domains + soc->num_hwv_domains;

where, to avoid confusion, this should've been:

	num_domains = soc->num_domains ?
		      soc->num_domains : soc->num_hwv_domains;

(perhaps with a check `if (num_domains && num_hwv_domains) dev_err(only one
  supported)` but being this taken from hardcoded data, I'm not really for it)

...and still, like the proposed fix does:

        scpsys->pd_data.num_domains = num_domains;


While I agree, again, in that the code could be improved (and it shall be),
how the logic behaves, right now, with the proposed fix, still looks good to me.

I can eventually just send a patch that clarifies the `num_domains` if you prefer.

Cheers,
Angelo

> [...]
> 
> Kind regards
> Uffe


