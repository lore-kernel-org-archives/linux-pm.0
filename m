From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 01/27] PM / Domains: core changes for multiple states
Date: Thu, 17 Dec 2015 22:19:31 +0100
Message-ID: <CAPDyKFovwXNnr4RPDww_wp_4+mOjN7ZL1zfc3i=G4EbktzsJOQ@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-2-git-send-email-lina.iyer@linaro.org>
	<CAPDyKFoBkKdBpuA6_EMtQNc-n0HxVAFpULrxgpnU5eXtcuS6og@mail.gmail.com>
	<CAKXjFTOMwMBq7Md6BFLuGnq4yQTZOyv4QVA6Cw7MWrkH0PvYDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35495 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbbLQVTc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 16:19:32 -0500
Received: by mail-yk0-f180.google.com with SMTP id v6so35060791ykc.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2015 13:19:31 -0800 (PST)
In-Reply-To: <CAKXjFTOMwMBq7Md6BFLuGnq4yQTZOyv4QVA6Cw7MWrkH0PvYDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Titinger <mtitinger@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

[...]

>>> +static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>>
>> In this patch I would rather just add *one* new "alloc" function and
>> name it like below.
>>
>> static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
>>
>> I assume the name I suggest for it, indicates what it needs to do and
>> *not* needs to do.
>
> Hi Ulf,
>
> Thanks for your thorough review!
> i will implement your suggestions for the next spin,

Great, thanks!

>
> However I have a doubt about this comment, do you mean that i should get rid of
> genpd_alloc_states_data completly? i had a static number of states before

Yes, in this patch - but we still want to alloc the data on the heap.

Just alloc a state struct with size of one array.

> but that was droped because o wasted memory if no states were needed.

There will always be at least *one* state, so we shouldn't waste any
memory following my suggestion above.

>
> if you just meant that it should be added in a separate patch, since i
> will be sqashing

I think you need to go through review comments for each patch
separately. In the end that might very well mean that you should
completely drop some patches, rework some and even create some some
new.

> this patch with "PM / Domains: make governor select deepest state"   can
> i keep it here? maybe it should  go with the dt parsing patch from Marc?

I don't think so.

Try to keep each logical change in a separate patch. That makes it
easier to review and thus also to accept patches.

[...]

Kind regards
Uffe
