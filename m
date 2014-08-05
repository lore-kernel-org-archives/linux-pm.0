From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Date: Tue, 05 Aug 2014 16:26:23 +0200
Message-ID: <53E0E98F.5020706@samsung.com>
References: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
 <53E0E420.8060207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:23339 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbaHEO0X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Aug 2014 10:26:23 -0400
In-reply-to: <53E0E420.8060207@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On 05.08.2014 16:03, Daniel Lezcano wrote:
> On 08/05/2014 03:34 PM, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> This patch series adds support for AFTR idle mode on boards with
>> secure firmware enabled and allows EXYNOS cpuidle driver usage on
>> Exynos4x12 SoCs.
>>
>> It has been tested on Trats2 board (using Exynos4412 SoC with secure
>> firmware enabled) on which AFTR mode reduces power consumption by ~12%
>> when EXYNOS cpuidle driver is enabled (in both cases the default
>> exynos_defconfig config is used and CPU1-3 are offlined).
>
> As a sidenote:
>
> On my odroid-U2:
>   * 4 cpus online -> 130 mA
>   * 3 cpus online -> 164 mA
>   * 2 cpus online -> 160 mA
>   * 1 cpu online  -> 157 mA
>
> So were are consuming more when there are unplugged cpu ... any ideas ?

On which tree are you testing? Current next has ARMCLK down feature 
enabled. ARMCLK down may stop working after hotunplugging CPU:
http://www.spinics.net/lists/arm-kernel/msg352890.html

That was observed especially on Exynos4212 where ARMCLK down stops 
working permanently. On Trats2 (Exynos4412) the clock down stopped only 
a for short period after disabling CPU.

Best regards,
Krzysztof



