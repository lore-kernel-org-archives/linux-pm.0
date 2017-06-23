From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 Resend] PM / OPP: Use - instead of @ for DT entries
Date: Sat, 24 Jun 2017 01:45:15 +0200
Message-ID: <4275705.6o67YAg0Lz@aspire.rjw.lan>
References: <31dd4526b3975260a669494aaaaa19323f6d201d.1498103050.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55808 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754058AbdFWXwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2017 19:52:36 -0400
In-Reply-To: <31dd4526b3975260a669494aaaaa19323f6d201d.1498103050.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, June 22, 2017 09:15:11 AM Viresh Kumar wrote:
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
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> @Rafael: You haven't applied it yesterday and I couldn't find it in
> patchwork anymore, so I am assuming that I need to send it again.

Correct.

Thanks,
Rafael
