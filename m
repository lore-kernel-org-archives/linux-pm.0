From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH V5 4/7] ARM: pxa: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 22:14:25 +0200
Message-ID: <87a87a7s66.fsf@belgarion.home>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
        <cover.1492685450.git.viresh.kumar@linaro.org>
        <741bc9af28d6968e6a9409f94681066db5d1228b.1492685450.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:41166 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032441AbdDTUOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 16:14:34 -0400
In-Reply-To: <741bc9af28d6968e6a9409f94681066db5d1228b.1492685450.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Thu, 20 Apr 2017 16:25:08 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

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
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
