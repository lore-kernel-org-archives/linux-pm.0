From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 3/7] ARM: exynos: Use - instead of @ for DT OPP entries
Date: Fri, 21 Apr 2017 10:57:05 +0530
Message-ID: <20170421052705.GA26900@vireshk-i7>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <8fd1dcd1bfa2011411dceab82bcd1587fe913cd1.1492685450.git.viresh.kumar@linaro.org>
 <20170420160930.halyszjunt4q2634@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:33089 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035394AbdDUF1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2017 01:27:22 -0400
Received: by mail-io0-f181.google.com with SMTP id k87so104190363ioi.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2017 22:27:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170420160930.halyszjunt4q2634@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arm@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 20-04-17, 18:09, Krzysztof Kozlowski wrote:
> On Thu, Apr 20, 2017 at 04:25:07PM +0530, Viresh Kumar wrote:
> > Compiling the DT file with W=1, DTC warns like follows:
> > 
> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> > unit name, but no reg property
> > 
> > Fix this by replacing '@' with '-' as the OPP nodes will never have a
> > "reg" property.
> > 
> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
> >  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
> >  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
> >  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
> >  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
> >  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
> >  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
> >  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
> >  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
> >  9 files changed, 194 insertions(+), 194 deletions(-)
> 
> 
> Thanks, split ARM64 from ARM and applied (for v4.12). arm-soc keeps DTS
> separated between ARM architectures. Technically this should require a
> resend but we had way too many resends for this simple patch.

Bah! Will make sure to send separate patches from now on. Thanks.

-- 
viresh
