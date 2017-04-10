From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Use - instead of @ for DT entries
Date: Mon, 10 Apr 2017 11:52:58 +0530
Message-ID: <20170410062258.GA24555@vireshk-i7>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34615 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdDJGXC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 02:23:02 -0400
Received: by mail-pg0-f42.google.com with SMTP id 21so100733396pgg.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Apr 2017 23:23:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10-04-17, 10:46, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

+ Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

-- 
viresh
