From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH 2/7] PM / devfreq: exynos-ppmu: Use the regmap interface
 to handle the registers
Date: Thu, 5 Jan 2017 17:07:57 +0100
Message-ID: <586E6F5D.8020306@math.uni-bielefeld.de>
References: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
 <1481794243-5046-3-git-send-email-cw00.choi@samsung.com>
 <CGME20161219194750epcas2p46c42c6d79a6fc088c78daa693756af87@epcas2p4.samsung.com>
 <58583941.1040809@math.uni-bielefeld.de> <585898FB.7050801@samsung.com>
 <5858E70B.2000902@math.uni-bielefeld.de> <5858EB49.3010609@samsung.com>
 <58593683.2050307@math.uni-bielefeld.de>
 <CAGTfZH16S2rRDFkC9ppzYKPWzV5vOQuy2CsSxDiemHACk1EWQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:32807 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965750AbdAEQIC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 11:08:02 -0500
In-Reply-To: <CAGTfZH16S2rRDFkC9ppzYKPWzV5vOQuy2CsSxDiemHACk1EWQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cwchoi00@gmail.com
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Hello Chanwoo,

sorry for the late reply. I was staying with my parents over the
Christmas days and didn't have access to the board. Also internet
connectivity was a bit troublesome *rolleyes*



Chanwoo Choi wrote:
> 2016-12-20 22:47 GMT+09:00 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>:
>> Hey Chanwoo,
>>
>>
>> Chanwoo Choi wrote:
>>> On 2016년 12월 20일 17:08, Tobias Jakobi wrote:
>>>> Hello Chanwoo,
>>>>
>>>>
>>>> Chanwoo Choi wrote:
>>>>> Hi,
>>>>>
>>>>> On 2016년 12월 20일 04:47, Tobias Jakobi wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I was just wondering what is improved by moving to regmap. For me this
>>>>>> looks like it only complicates the code. Lots of regmap_{read,write}()
>>>>>> and for each one of these we need to check the return code.
>>>>>
>>>>> It is correct to check the return value. It cover all of exception.
>>>> that doesn't really answer my question. Which 'exceptions' are we
>>>> talking about? What can go wrong with  __raw_{writel,readl}(), that
>>>
>>> When using __raw_readl/writel() don't check the any return value, it it not correct.
>>> When calling the function, basically we should check whether return value is error or success.
>>> What is problem to check the return value?
>> So what you're saying is the following. When using
>> __raw_{readl,writel}() somde error can occur, that we can't catch by
>> using __raw_{readl,writel}(), but only by using the regmap API on top.
> 
>>
>> So, what error would that be? Do you have an example where such an error
>> occurs? In particular this leads me to the following question: What bug
>> does the conversion to regmap actually fix?
> 
> I don't mention that this patch is bug fix.
> 
> No. It is well working. There is no any know error. As I already said,
> First is checking the return value of function call as following.
>>> When calling the function, basically we should check whether return value is error or success.
I've spend some time to go through the regmap core and the regmap mmio
code, and I don't see the point in this conversion.

What you do is to replace __raw_{readl,writel}() with writel()/readl(),
which is what regmap mmio calls internally. So in particular this adds
memory barriers. Plus all the indirection, spinlock locking/unlocking, etc.

See below for a detailed analysis of regmap_write().



>>>> makes it necessary to put another layer on top of it? AFAIK regmap was
>>>> introduced to handle read/writes to slow busses like I2C and SPI. I
>>>> don't see that this applies here.
>>>
>>> The regmap support the MMIO on following driver.
>>> - drivers/base/regmap/regmap-mmio.c
>> I know, but just because something exist isn't enough reason for me to
>> using it. There should be a benefit here.
>>
>> At the moment I only see that this does the following:
>> - makes the code more convoluted
> 
> I don't agree. As I already said as following, first is checking the
> return value of function call as following.
> ">> When calling the function, basically we should check whether
> return value is error or success."
You want to have some error code returned just for the sake of having an
error code. I don't follow this reasoning. In particular if it involves
putting a indirection layer on top, without gaining anything from it.

The conversion doesn't make the code cleaner, which can be already seen
from the diffstat (much more lines added than removes). It also doesn't
make the code safer.


>> - does some dubious error checking
> 
> I don't want you use 'dobious' word. I need correct reason why you do
> obeject to use it.
No offense meant by 'dubious', but it is indeed the case here. :)


> The error checking is clear.
No, it's not clear to me.

Please see the regmap core code yourself, and ask yourself what kind of
errors you're actually checking here.

Take e.g. regmap_write() and trace the return statements.
- alignment check [in regmap_write]
  We already know that we always have correct alignment.
- writable check [in _regmap_write]
  We already know that the code only writes to writable registers.
- clock checks [in regmap_mmio_write]
  We don't do clock management via regmap.

If you look at regmap_mmio_write() again, you see that no error value is
propagated from ctx->reg_write(ctx, reg, val) at all. If you omit the
clock stuff, then regmap_mmio_write() always returns zero.

Hence we have replaced a simple __raw_writel(), a function that maps to
a single (!) CPU instruction on ARM, with a bunch of checks that are
known (by static analysis) to never fail, plus the write instruction
with memory barriers.
And we do all this _every_ _single_ _time_. For a particular bad example
see the zero-initialisation in exynos_ppmu_v2_disable(). Sorry, but by
all means, this is not a improvement of the code.



> 
>> - impact of performance (__raw_{readl,writel}() maps to some load/stores
>> on the assembler level, now we have go through a whole subsystem to
>> achieve the same thing)
> 
> Do you have the performance result between regmap and __raw_readl/writel?
My preliminary tests show a increase of CPU cycles spend to access these
registers by several orders of magnitude. Not surprising, with the
memory barriers and the spinlocks now in place.

Maybe I have some time on the weekend to do some further tests.

> Do you mean that regmap-mmio is unneeded?
I'm saying that in _this_ particular case, the use of regmap-mmio is
counterproductive.



> It is not reasonable. The system is enough fast to use the regmap. The
> many device driver use the 'regmap-mmio.c' driver in mainline kernel.
> You can find them.
Sure, you could probably add six more abstraction layers on top and the
system would still be fast enough to handle ut, but I don't see why you
want to make code slower on _purpose_, just for the sake of using
regmap-mmio.

regmap-mmio has its purpose, but I disagree that it applies here (both
for exynos-bus and ppmu). The diffstat again supports my point.


> 
>>
>>
>>>>>> Also when exactly did __raw_writel() and friends become legacy?
>>>>>
>>>>> Also, I want to use the regmap interface (regmap-io) instead of __raw_readl/__raw_writel using the base address
>>>>> directly.
>>>> I see, but why are __raw_{writel,readl}() legacy as you say? I don't see
>>>> this anywhere else in the kernel.
>>>
>>> If you just don't like the 'legacy' expression. I'll remove it.
>> No, actually the 'legacy' part is important, if it were true. If
>> __raw_{writel,readl}() would indeed be legacy and there was a consensus
>> that using a different interface is better, then I would agree to this
>> change.
>> But the calls are not legacy, hence I'm missing some reason for this change.
> 
> When using devm_regmap_init_mmio(), the device driver don't need to
> consider the 'iounmap' becaue it is automatically by framework. And
> when using __raw_readl/writel to read and write the registers, they
> check whether register is writable/readable is not.
This is no improvement.

First of all the amount of init code in exynos_ppmu_parse_dt() has
increased with your patch. Instead of of_iomap()  you now have
platform_get_resource(), devm_ioremap_resource() and
devm_regmap_init_mmio() there.
If iounmap() really were a problem, which I doubt it is, one could just
use devm_ioremap().

The writable/readable argument is also none, since you have to supply
this information yourself/explicitly. We know beforehand which registers
are of which type. This is not a situation where e.g. userspace passes
us some values, which might potentially be wrong. We know when a
register is writable and when it's not. Everything else would a bug in
the code itself.



> 
> The __raw_readl/writel don't consider them and support them.
> 
>>
>>
>>> It is not any important. The key point of this patch uses the regmap interface.
>>> Usually, when adding new device driver, I use the regmap mmio interface
>>> instead of __raw_readl/writel. So, this patch changes it.
>> That doesn't sound like a good reasoning. What improvement do we get by
>> this change? And no, I don't buy the error checking argument ;)
> 
> I replied already why regmap interface is used.
> 


With best wishes,
Tobias

