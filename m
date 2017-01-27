From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/8] Power domains support for Exynos5433 SoCs
Date: Fri, 27 Jan 2017 08:59:57 +0100
Message-ID: <8986e76b-a8a1-2ff6-021b-d0e3489d43c3@samsung.com>
References: <CGME20170125115558eucas1p18dcb5c4cbab28dcb10bd412b825256b7@eucas1p1.samsung.com>
 <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <20170127074346.iwzaavl2lnu64uxq@kozik-lap>
 <6cbea032-86a3-20b9-6cdf-93099f553531@samsung.com>
 <20170127075232.it4c4e7a3hno7i7e@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:25877 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbdA0ILG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2017 03:11:06 -0500
In-reply-to: <20170127075232.it4c4e7a3hno7i7e@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

Hi Krzysztof,

On 2017-01-27 08:52, Krzysztof Kozlowski wrote:
> On Fri, Jan 27, 2017 at 08:47:44AM +0100, Marek Szyprowski wrote:
>> On 2017-01-27 08:43, Krzysztof Kozlowski wrote:
>>> On Wed, Jan 25, 2017 at 12:55:34PM +0100, Marek Szyprowski wrote:
>>>> This patchset is a final step to add support for all power domains
>>>> on Exynos5433 SoCs. This patchset contains patches for adding Exynos5433
>>>> support to Exynos power domain driver and definitions of all power
>>>> domains found in Exynos5433 SoCs.
>>>>
>>>> Patches have been generated on top of linux-next from 25th January 2017.
>>>>
>>>> This is a part of a larger task, which goal is to add support for power
>>>> domains on Exynos5433 SoCs / TM2 boards. All patches needed to get it
>>>> working have been pushed to the following git repo:
>>>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd
>>>>
>>>> To get everything working following patches/patchsets are needed on top
>>>> of the linux-next tree:
>>> By "get everything working" you also mean that there is a runtime
>>> dependency? In other words, can I apply DTS patches here?
>> IMHO we should wait with applying pm domains DTS patches. Without ALL other
>> patches
>> kernel will sooner or later panic with "(a)synchronous external abort" or
>> deadlock
>> in a different way.
> Okay, makes sense. A partial solution would be to apply them with
> status=disabled. After all it is still a valid description of a
> hardware. However this would not bring much benefits anyway...

First we would need to learn the Exynos power domain driver to honor
"status=disabled" property, because right now it instantiate all domains
regardless the provided status ;) Feel free to prepare a patch for that.

I'm also not sure if driver core will handle such case properly. I remember
that it deferred probing of all devices when no power domain driver was
available, but this might be a bit different case than skipping domain
registration.

> Beside the name of node I mentioned, please put all the power domains
> sorted to each other by address. I see the big picture here:
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/tree/arch/arm64/boot/dts/exynos/exynos5433.dtsi?h=v4.10-next-tm2-pd
> and it does not looks ordered.

I think I've already tried to keep them sorted by address, but maybe while
rebasing/updating/fixing something went wrong.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

