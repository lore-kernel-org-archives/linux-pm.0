From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] PM / OPP: Use - instead of @ for DT entries
Date: Mon, 10 Apr 2017 08:45:25 +0200
Message-ID: <CAJKOXPe_+Y+9ZLE7Jymqc5nULzo+qM4cCMFg2-cV_YnpCFkRCA@mail.gmail.com>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
 <20170410062258.GA24555@vireshk-i7> <CAK7LNAR=+k6iuqUPUNLW=EHUuOw4fBr4SbEtP-jnSyrsiEydgg@mail.gmail.com>
 <20170410063239.GB24555@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20170410063239.GB24555@vireshk-i7>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Rafael Wysocki <rjw@rjwysocki.net>, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 10, 2017 at 8:32 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-04-17, 15:30, Masahiro Yamada wrote:
>> 2017-04-10 15:22 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
>> > On 10-04-17, 10:46, Viresh Kumar wrote:
>> >> Compiling the DT file with W=1, DTC warns like follows:
>> >>
>> >> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
>> >> unit name, but no reg property
>> >>
>> >> Fix this by replacing '@' with '-' as the OPP nodes will never have a
>> >> "reg" property.
>> >>
>> >> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >
>> > + Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >
>> > --
>> > viresh
>>
>>
>> Given that this had already been reported one year before,
>> the reported-by credit should be given to Krzysztof.
>>
>> Please drop my Reported-by.
>
> I don't think we need to drop any of you. We can very well keep both
> :)

Yes, keeping both make most sense, I think.

Anyway, I found now the original report thread of Masahiro and I see
Mark's response about using '-'. In that case I am fine with this. I
would prefer to take only the exynos part (separated to ARMv7 and
ARMv8) through my tree but I already sent a pull request so I am fine
with this going directly to arm-soc.

I think you need to update also:
Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
With that change:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
(and implied acked-by)

Best regards,
Krzysztof
