From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [1/2] cpufreq: dt-platdev: Automatically create cpufreq device
 with OPP v2
Date: Wed, 23 Aug 2017 12:48:43 +0900
Message-ID: <CAK7LNAQSrHA2_5Az6D1xxFUgm-FHaeQqVnn5O+7GOb6kgKL4vw@mail.gmail.com>
References: <e93c74a19ebf6d7ee687ef8b71b3150a96527f7c.1502861444.git.viresh.kumar@linaro.org>
 <20170821131759.GA15330@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26736 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbdHWDtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 23:49:39 -0400
In-Reply-To: <20170821131759.GA15330@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Wei Xu <xuwei5@hisilicon.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jun Nie <jun.nie@linaro.org>, baoyou.xie@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-08-21 22:17 GMT+09:00 Simon Horman <horms@verge.net.au>:
> On Wed, Aug 16, 2017 at 11:07:27AM +0530, Viresh Kumar wrote:
>> The initial idea of creating the cpufreq-dt-platdev.c file was to keep a
>> list of platforms that use the "operating-points" (V1) bindings and
>> create cpufreq device for them only, as we weren't sure which platforms
>> would want the device to get created automatically as some had their own
>> cpufreq drivers as well, or wanted to initialize cpufreq after doing
>> some stuff from platform code.
>>
>> But that wasn't the case with platforms using "operating-points-v2"
>> property. We wanted the device to get created automatically without the
>> need of adding them to the whitelist. Though, we will still have some
>> exceptions where we don't want to create the device automatically.
>>
>> Rename the earlier platform list as *whitelist* and create a new
>> *blacklist* as well.
>>
>> The cpufreq-dt device will get created if:
>> - The platform is there in the whitelist OR
>> - The platform has "operating-points-v2" property in CPU0's DT node and
>>   isn't part of the blacklist .
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> I have exercised this on the r8a7795 and r8a7795 with the following
> reverted:
>
> * 034def597bb7 ("cpufreq: rcar: Add support for R8A7795 SoC")
> * bea2ebca6b91 ("cpufreq: dt: Add r8a7796 support to to use generic
> cpufreq driver")
>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>



Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
