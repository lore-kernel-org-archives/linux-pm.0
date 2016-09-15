From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/5] clk: add support for runtime pm
Date: Thu, 15 Sep 2016 10:32:04 +0200
Message-ID: <648b0ce0-dcc5-d32d-5c4e-b7e0c0f10d4c@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-2-git-send-email-m.szyprowski@samsung.com>
 <20160908001943.GC13062@codeaurora.org>
 <CGME20160912101857eucas1p29b2bbd5ac0eda92284091ad1b86decc4@eucas1p2.samsung.com>
 <f18fee35-cb5d-abce-0415-a98b58e3a302@samsung.com>
 <20160912223105.GI7243@codeaurora.org>
 <e3cceb9a-7a30-c662-dba4-bc453f6fddb6@samsung.com>
 <20160914213903.GG7243@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:56697 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763275AbcIOIcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 04:32:11 -0400
In-reply-to: <20160914213903.GG7243@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Stephen,


On 2016-09-14 23:39, Stephen Boyd wrote:
> On 09/13, Marek Szyprowski wrote:
>> On 2016-09-13 00:31, Stephen Boyd wrote:
>>> Great! So you have runtime PM callbacks that are calling
>>> clk_prepare/unprepare?
>> Well, not really. clock controller's runtime pm functions must not call
>> clk_prepare/unprepare yet.
>>
>> I didn't get your question. I thought that you are asking if my change
>> won't introduce any deadlock related to prepare and dev->pm locks. My
>> runtime pm functions doesn't do any call to clk_prepare/unprepare.
>> Although global clock prepare lock is re-entrant from the same process, it
>> would cause deadlock if called from runtime pm functions, because runtime
>> pm functions might be called from the worker running on the different
>> cpu/process.
> I mean non-clk controller driver based runtime PM callbacks that
> call clk_prepare/unprepare in them. For example, some i2c or spi
> device driver that has clk operations in the runtime PM
> callbacks. That would allow lockdep to see any potential deadlock
> because of aliasing lock classes for the device power lock and
> the global prepare lock.

This works perfectly fine. Runtime pm callbacks are called with power lock
released, so there is no deadlock possible related to dev->power.lock.
See __rpm_callback() function in drivers/base/power/runtime.c

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

