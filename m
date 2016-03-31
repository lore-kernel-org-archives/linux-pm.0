From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v7 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Thu, 31 Mar 2016 21:28:32 +0900
Message-ID: <CAGTfZH0mgxyQPKBTX=ZXgtSn=bQ2zAMSNMHfO+OXh3U5qrUr4g@mail.gmail.com>
References: <1459415165-32613-1-git-send-email-cw00.choi@samsung.com>
	<1459415165-32613-2-git-send-email-cw00.choi@samsung.com>
	<56FD13D2.1050300@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56FD13D2.1050300@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Anand Moon <linux.amoon@gmail.com>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vg>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 31, 2016 at 9:10 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 03/31/2016 11:05 AM, Chanwoo Choi wrote:
>
>> +static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
>> +{
>
>> +     new_opp = devfreq_recommended_opp(dev, freq, flags);
>> +     if (IS_ERR_OR_NULL(new_opp)) {
>> +             dev_err(dev, "failed to get recommed opp instance\n");
>
> s/recommed/recommended/

OK. I'll fix it.

>
>> +             rcu_read_unlock();
>> +             return PTR_ERR(new_opp);
>> +     }
>
>> +}
>
>> +static int exynos_bus_probe(struct platform_device *pdev)
>> +{
>
>> +     bus->devfreq = devm_devfreq_add_device(dev, profile, "simple_ondemand",
>> +                                             ondemand_data);
>> +     if (IS_ERR_OR_NULL(bus->devfreq)) {
>> +             dev_err(dev, "failed to add devfreq device\n");
>> +             return  PTR_ERR(bus->devfreq);
>> +     }
>
>> +}
>
> You should use IS_ERR() instead of IS_ERR_OR_NULL(), since functions
> of which the return value is being tested return only ERR_PTR() values.
> IS_ERR_OR_NULL() suggest NULL values are possible and then constructs
> like
>         if (IS_ERR_OR_NULL(result))
>                 return PTR_ERR(result);
>
> are not correct anyway.

OK. I'll use IS_ERR() instead of IS_ERR_OR_NULL()

Thanks,
Chanwoo Choi
