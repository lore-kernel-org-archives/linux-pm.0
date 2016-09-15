From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain to
 exynos4x12 clocks device
Date: Thu, 15 Sep 2016 16:13:31 +0200
Message-ID: <CAPDyKFpibwe2fgviT8z3atd4RJUBx1PMNuG3txbjAa5qY8o_dg@mail.gmail.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
 <20160908002254.GD13062@codeaurora.org> <CGME20160912102332eucas1p145e79669788329b44343da62dcbe50ca@eucas1p1.samsung.com>
 <f340cca5-6cd6-6bd1-3b9a-ccd58cbc0091@samsung.com> <20160912222852.GH7243@codeaurora.org>
 <6e52af56-8b0e-d8c4-62c2-6efeee0e912d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36588 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756574AbcIOONh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 10:13:37 -0400
Received: by mail-lf0-f50.google.com with SMTP id g62so36827247lfe.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2016 07:13:36 -0700 (PDT)
In-Reply-To: <6e52af56-8b0e-d8c4-62c2-6efeee0e912d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>

[...]

>>> I see some serious design problems with multiple entries in power domains
>>> property. First how to show that some part of the device IS NOT in
>>> any domain?
>>
>> Is that even possible? Every device should be in some power
>> domain, even if it's just an "always on" power domain that we
>> don't really control from software.
>
>
> Right now none dts of which I'm aware of doesn't define the power domain for
> the parts of the SoC, which are always on and doesn't need any additional
> management.

Actually there's is one reason for doing this, as it would allow
devices to be monitored for device PM QoS constraints by the genpd
governor.

Although, I doubt's someone actually does it because of this benefit,
at least yet.

[...]

Kind regards
Uffe
