From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH V5 6/7] ARM: uniphier: Use - instead of @ for DT OPP entries
Date: Sun, 14 May 2017 01:23:52 +0900
Message-ID: <CAK7LNASgFd1V=gRpEqOsQkRpqVZu25N10mCSjRR=Vbmwbxp6yA@mail.gmail.com>
References: <cover.1492685450.git.viresh.kumar@linaro.org> <1faba32eeaa493cc5463488af32eaea0dc2f7a94.1492685450.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:54748 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdEMQX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 May 2017 12:23:58 -0400
In-Reply-To: <1faba32eeaa493cc5463488af32eaea0dc2f7a94.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-04-20 19:55 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
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
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to linux-uniphier.  Thanks!



-- 
Best Regards
Masahiro Yamada
