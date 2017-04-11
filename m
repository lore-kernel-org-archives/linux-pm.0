From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH V2] PM / OPP: Use - instead of @ for DT entries
Date: Tue, 11 Apr 2017 10:13:58 +0900
Message-ID: <CAK7LNATAW4jHbKZU6xWD_nU=ccFo73rBSX_UDpQEMo9OC_u=cw@mail.gmail.com>
References: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35559 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdDKBOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 21:14:06 -0400
In-Reply-To: <70e7c7ee13722ab9c73cb073f88502eaf1ada5f5.1491816050.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linaro-kernel@lists.li

Hi Viresh,


2017-04-10 18:21 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> Compiling the DT file with W=1, DTC warns like follows:
>
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
>
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com> (uniphier)


Thank you!




-- 
Best Regards
Masahiro Yamada
