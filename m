From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH V5 3/7] ARM: exynos: Use - instead of @ for DT OPP entries
Date: Mon, 24 Apr 2017 10:32:16 +0200
Message-ID: <CAJKOXPcWJbibxahgnDAsnGbUpkurwSOtSsdV28hKbWxn_x83Jw@mail.gmail.com>
References: <cover.1492685450.git.viresh.kumar@linaro.org> <8fd1dcd1bfa2011411dceab82bcd1587fe913cd1.1492685450.git.viresh.kumar@linaro.org>
 <20170420160930.halyszjunt4q2634@kozik-lap> <CAK7LNAQChtyRzKoSWCFakg+3_Qp_NZoXP1pEt6edDQrnL9FQ2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQChtyRzKoSWCFakg+3_Qp_NZoXP1pEt6edDQrnL9FQ2w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, arm@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <robh@kernel.org>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 24, 2017 at 10:30 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2017-04-21 1:09 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
>> On Thu, Apr 20, 2017 at 04:25:07PM +0530, Viresh Kumar wrote:
>>> Compiling the DT file with W=1, DTC warns like follows:
>>>
>>> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
>>> unit name, but no reg property
>>>
>>> Fix this by replacing '@' with '-' as the OPP nodes will never have a
>>> "reg" property.
>>>
>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
>>>  arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
>>>  arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
>>>  arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
>>>  arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
>>>  arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
>>>  arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
>>>  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
>>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
>>>  9 files changed, 194 insertions(+), 194 deletions(-)
>>
>>
>> Thanks, split ARM64 from ARM and applied (for v4.12). arm-soc keeps DTS
>> separated between ARM architectures. Technically this should require a
>> resend but we had way too many resends for this simple patch.
>>
>
>
> Minor note:
>
> For arm64 part, Krzysztof's Signed-off-by is doubled.
> (commit 5dccc9873c4af60f4478b3ef54267353f25cc301)

Thanks for spotting it.

Best regards,
Krzysztof
