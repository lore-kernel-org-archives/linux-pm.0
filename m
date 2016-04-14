From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5/7] clk: samsung: exynos542x: Add the clock id for ACLK
Date: Thu, 14 Apr 2016 15:28:17 +0900
Message-ID: <570F3881.9000100@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
 <570CDB16.2050001@samsung.com>
 <CA+Ln22EFdspBdHwWar65UZ-uFxq4c9+RPhNCJjgKp9idvDvM5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CA+Ln22EFdspBdHwWar65UZ-uFxq4c9+RPhNCJjgKp9idvDvM5A@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux.amoon@gmail.com, m.reichl@fivetechno.de, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, InKi Dae <inki.dae@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz and Krzysztof,

On 2016=EB=85=84 04=EC=9B=94 13=EC=9D=BC 15:20, Tomasz Figa wrote:
> 2016-04-12 14:25 GMT+03:00 Krzysztof Kozlowski <k.kozlowski@samsung.c=
om>:
>> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>>> This patch adds the clock id for ACLK clock which is source clock o=
f AMBA AXI
>>> Bus. This clock should be handled in Bus frequency scaling driver.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/clk/samsung/clk-exynos5420.c | 85 +++++++++++++++++++++++-=
------------
>>>  1 file changed, 55 insertions(+), 30 deletions(-)
>>
>> The IDs itself look good but you are not adding only clock ID. You a=
re
>> changing all of them from NULL-flags to CLK_SET_RATE_PARENT. This sh=
ould
>> be explained in the commit message why you need it. Probably it shou=
ld
>> be also in separate commit.
>=20
> +1. And CLK_SET_RATE_PARENT for a clock which has a mux as its parent
> is a bit suspicious, so I'd like to know the rationale for each singl=
e
> clock with CLK_SET_RATE_PARENT being added.

This patch don't need the CLK_SET_RATE_PARENT flag. As Tomasz's comment=
,
the mux of divider's parent don't need this flag. Sorry for confusion.

I'll drop the CLK_SET_RATE_PARENT flag.

Best Regards,
Chanwoo Choi
