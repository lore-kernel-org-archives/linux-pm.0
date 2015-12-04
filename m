From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 02/12] clk: samsung: exynos5420: add cpu clock
 configuration data and instantiate cpu clock
Date: Fri, 04 Dec 2015 11:25:55 +0900
Message-ID: <5660F9B3.8030001@samsung.com>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <1449091167-20758-3-git-send-email-ben@smart-cactus.org>
 <565FDC5A.1010504@samsung.com> <874mfz4yfb.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44278 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbbLDC0M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 21:26:12 -0500
In-reply-to: <874mfz4yfb.fsf@smart-cactus.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, Thomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 03.12.2015 19:30, Ben Gamari wrote:
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
>> On 03.12.2015 06:19, Ben Gamari wrote:
>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>
>>> With the addition of the new Samsung specific cpu-clock type, the
>>> arm clock can be represented as a cpu-clock type. Add the CPU clock
>>> configuration data and instantiate the CPU clock type for Exynos5420.
>>>
>>> Changes by Bartlomiej:
>>> - split Exynos5420 support from the original patches
>>> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
>>>
>>> Changes by Ben Gamari:
>>> - Rebased
>>
>> If only rebasing then you should retain the Lukasz's review tag. He
>> doesn't have to review it again, right? :)
> 
> Yep, very true.
> 
>>> +static const struct exynos_cpuclk_cfg_data exynos5420_eglclk_d[] __initconst = {
>>> +	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
>>> +	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
>>> +	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
>>> +	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
>>> +	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
>>> +	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
>>> +	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
>>> +	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
>>> +	{ 1000000, E5420_EGL_DIV0(3, 6, 6, 2), },
>>> +	{  900000, E5420_EGL_DIV0(3, 6, 6, 2), },
>>> +	{  800000, E5420_EGL_DIV0(3, 5, 5, 2), },
>>> +	{  700000, E5420_EGL_DIV0(3, 5, 5, 2), },
>>> +	{  600000, E5420_EGL_DIV0(3, 4, 4, 2), },
>>> +	{  500000, E5420_EGL_DIV0(3, 3, 3, 2), },
>>> +	{  400000, E5420_EGL_DIV0(3, 3, 3, 2), },
>>> +	{  300000, E5420_EGL_DIV0(3, 3, 3, 2), },
>>> +	{  200000, E5420_EGL_DIV0(3, 3, 3, 2), },
>>> +	{  0 },
>>
>> The vendor code (Galaxy S5 with Exynos5422) sets pclk_dbg divider to 7.
>> In the same time APLL divider is only 1.
>>
>> For the ACLK divider (of KFC below) the vendor sets 3, not 2.
>>
>> The values also don't match the Exynos5420 from Note 3.
>>
>> The Exynos5800 apparently has values more similar to 5422.
>>
>> The question is: for which exact model this is? We can of course choose
>> the safest values here but probably these would be with the highest
>> dividers?
>>
> I'm afraid I can't comment here. Thomas, perhaps you could offer some
> insight?

Actually I found your patch #5 adding support for 5800 with the values
more like matching 5422. So actually the difference should be between
5420 and 5422. The Exynos5420 mainline boards are:
 - Peach Pit - chromeos tree could be a good vendor reference,
 - Arndale Octa,
 - SMDK5420.

For the last two I don't know where to get the vendor reference.
Unfortunately sometimes the particular values (supported frequencies and
clock dividers) differ for one SoC between products but we don't support
the ASV here.

Overall probably this means that we should not care about such details,
except maybe the difference between 5420 and 5422? (where 5422=5800)

Best regards,
Krzysztof

