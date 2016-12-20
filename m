From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 2/7] PM / devfreq: exynos-ppmu: Use the regmap interface
 to handle the registers
Date: Wed, 21 Dec 2016 04:20:38 +0900
Message-ID: <CAGTfZH16S2rRDFkC9ppzYKPWzV5vOQuy2CsSxDiemHACk1EWQA@mail.gmail.com>
References: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
 <1481794243-5046-3-git-send-email-cw00.choi@samsung.com> <CGME20161219194750epcas2p46c42c6d79a6fc088c78daa693756af87@epcas2p4.samsung.com>
 <58583941.1040809@math.uni-bielefeld.de> <585898FB.7050801@samsung.com>
 <5858E70B.2000902@math.uni-bielefeld.de> <5858EB49.3010609@samsung.com> <58593683.2050307@math.uni-bielefeld.de>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58593683.2050307@math.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2016-12-20 22:47 GMT+09:00 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>:
> Hey Chanwoo,
>
>
> Chanwoo Choi wrote:
>> On 2016=EB=85=84 12=EC=9B=94 20=EC=9D=BC 17:08, Tobias Jakobi wrote:
>>> Hello Chanwoo,
>>>
>>>
>>> Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2016=EB=85=84 12=EC=9B=94 20=EC=9D=BC 04:47, Tobias Jakobi wrote:
>>>>> Hello,
>>>>>
>>>>> I was just wondering what is improved by moving to regmap. For me thi=
s
>>>>> looks like it only complicates the code. Lots of regmap_{read,write}(=
)
>>>>> and for each one of these we need to check the return code.
>>>>
>>>> It is correct to check the return value. It cover all of exception.
>>> that doesn't really answer my question. Which 'exceptions' are we
>>> talking about? What can go wrong with  __raw_{writel,readl}(), that
>>
>> When using __raw_readl/writel() don't check the any return value, it it =
not correct.
>> When calling the function, basically we should check whether return valu=
e is error or success.
>> What is problem to check the return value?
> So what you're saying is the following. When using
> __raw_{readl,writel}() somde error can occur, that we can't catch by
> using __raw_{readl,writel}(), but only by using the regmap API on top.

>
> So, what error would that be? Do you have an example where such an error
> occurs? In particular this leads me to the following question: What bug
> does the conversion to regmap actually fix?

I don't mention that this patch is bug fix.

No. It is well working. There is no any know error. As I already said,
First is checking the return value of function call as following.
>> When calling the function, basically we should check whether return valu=
e is error or success.

>
>
>>> makes it necessary to put another layer on top of it? AFAIK regmap was
>>> introduced to handle read/writes to slow busses like I2C and SPI. I
>>> don't see that this applies here.
>>
>> The regmap support the MMIO on following driver.
>> - drivers/base/regmap/regmap-mmio.c
> I know, but just because something exist isn't enough reason for me to
> using it. There should be a benefit here.
>
> At the moment I only see that this does the following:
> - makes the code more convoluted

I don't agree. As I already said as following, first is checking the
return value of function call as following.
">> When calling the function, basically we should check whether
return value is error or success."

> - does some dubious error checking

I don't want you use 'dobious' word. I need correct reason why you do
obeject to use it.
The error checking is clear.

> - impact of performance (__raw_{readl,writel}() maps to some load/stores
> on the assembler level, now we have go through a whole subsystem to
> achieve the same thing)

Do you have the performance result between regmap and __raw_readl/writel?
Do you mean that regmap-mmio is unneeded?

It is not reasonable. The system is enough fast to use the regmap. The
many device driver use the 'regmap-mmio.c' driver in mainline kernel.
You can find them.

>
>
>>>>> Also when exactly did __raw_writel() and friends become legacy?
>>>>
>>>> Also, I want to use the regmap interface (regmap-io) instead of __raw_=
readl/__raw_writel using the base address
>>>> directly.
>>> I see, but why are __raw_{writel,readl}() legacy as you say? I don't se=
e
>>> this anywhere else in the kernel.
>>
>> If you just don't like the 'legacy' expression. I'll remove it.
> No, actually the 'legacy' part is important, if it were true. If
> __raw_{writel,readl}() would indeed be legacy and there was a consensus
> that using a different interface is better, then I would agree to this
> change.
> But the calls are not legacy, hence I'm missing some reason for this chan=
ge.

When using devm_regmap_init_mmio(), the device driver don't need to
consider the 'iounmap' becaue it is automatically by framework. And
when using __raw_readl/writel to read and write the registers, they
check whether register is writable/readable is not.

The __raw_readl/writel don't consider them and support them.

>
>
>> It is not any important. The key point of this patch uses the regmap int=
erface.
>> Usually, when adding new device driver, I use the regmap mmio interface
>> instead of __raw_readl/writel. So, this patch changes it.
> That doesn't sound like a good reasoning. What improvement do we get by
> this change? And no, I don't buy the error checking argument ;)

I replied already why regmap interface is used.

--=20
Best Regards,
Chanwoo Choi
