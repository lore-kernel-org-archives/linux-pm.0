From: Simon Horman <horms@verge.net.au>
Subject: Re: [1/2] cpufreq: dt-platdev: Automatically create cpufreq device
 with OPP v2
Date: Mon, 21 Aug 2017 15:17:59 +0200
Message-ID: <20170821131759.GA15330@verge.net.au>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46383 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbdHUNSD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Aug 2017 09:18:03 -0400
Content-Disposition: inline
In-Reply-To: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org, maxime.ripard@free-electrons.com, wens@csie.org, xuwei5@hisilicon.com, kgene@kernel.org, krzk@kernel.org, yamada.masahiro@socionext.com, jun.nie@linaro.org, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org

On Wed, Aug 16, 2017 at 11:07:27AM +0530, Viresh Kumar wrote:
> The initial idea of creating the cpufreq-dt-platdev.c file was to keep a
> list of platforms that use the "operating-points" (V1) bindings and
> create cpufreq device for them only, as we weren't sure which platforms
> would want the device to get created automatically as some had their own
> cpufreq drivers as well, or wanted to initialize cpufreq after doing
> some stuff from platform code.
> 
> But that wasn't the case with platforms using "operating-points-v2"
> property. We wanted the device to get created automatically without the
> need of adding them to the whitelist. Though, we will still have some
> exceptions where we don't want to create the device automatically.
> 
> Rename the earlier platform list as *whitelist* and create a new
> *blacklist* as well.
> 
> The cpufreq-dt device will get created if:
> - The platform is there in the whitelist OR
> - The platform has "operating-points-v2" property in CPU0's DT node and
>   isn't part of the blacklist .
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I have exercised this on the r8a7795 and r8a7795 with the following
reverted:

* 034def597bb7 ("cpufreq: rcar: Add support for R8A7795 SoC")
* bea2ebca6b91 ("cpufreq: dt: Add r8a7796 support to to use generic
cpufreq driver")

Tested-by: Simon Horman <horms+renesas@verge.net.au>
