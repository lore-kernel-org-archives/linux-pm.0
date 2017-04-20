From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/7] PM / OPP: Use - instead of @ for DT entries
Date: Thu, 20 Apr 2017 15:00:56 +0530
Message-ID: <20170420093056.GH5436@vireshk-i7>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34753 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943310AbdDTJbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 05:31:00 -0400
Received: by mail-oi0-f44.google.com with SMTP id x184so42569487oia.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2017 02:31:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: arm@kernel.org
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>

On 20-04-17, 11:14, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> This has been sent separately as a single patch earlier, and Olof
> suggested to split it per-platform and get it merged via platform
> specific trees. Please get these applied to your trees guys and the rest
> can go via arm-soc.

This is based over 4.11-rc7 and there are no conflicts apart from
sun8i. All the other maintainers can apply their platform specific
patches from this series only.

Thanks.

-- 
viresh
