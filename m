From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
Date: Fri, 11 Dec 2015 13:00:32 +0900
Message-ID: <566A4A60.8060402@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18314 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbLKEAn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 23:00:43 -0500
In-reply-to: <20151211033253.GN3612@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>

On 11.12.2015 12:32, Viresh Kumar wrote:
> On 11-12-15, 00:25, Javier Martinez Canillas wrote:
>> The problem is that the big and LITTLE cores have different ordering per SoCs:
>>
>> - Exynos5420 and Exynos5800: cpu0-3 (Cortex-A15) and cpu4-7 (Coretx-A7)
>> - Exynos5422: cpu0-3 (Cortex-A7) and cpu4-7 (Cortex-A15)
>>
>> So the OPP tables are set in this DTSI file, to prevent the OPP tables
>> in the Exynos5422 to be inverted for the cluster 0 and 1.
> 
> Oh dude, that's really *ugly*. :)
> 
> Reusing files/definitions is fine to the point where things are
> readable. But you have screwed it up so very badly.
> 
> Over that, why can't you keep cpu0-3 as A7 and 4-7 as a15 for all the
> cases? The only worrying thing for you should be that CPU0 within the
> kenrel should be controllable, right? i.e. you want a A15 to boot 5800
> and A7 to boot 5422.
> 
> If yes, than you could have kept the CPUs in 5422 as:
> 0-3: A7
> 4-7: A15
> 
> and in 5420 as:
> 4-7: A15
> 0-3: A7
> 
> Wouldnt' that work ?

It wasn't working like this. The cpu0 got the index from booting cpu, so
on 5420 cpu0 was A15 and on 5422 it was A7.

Maybe I am not aware of some changes recently in the kernel but how do
you want to assign the booting CPU proper number (not CPU0)?

Best regards,
Krzysztof

