From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Thu, 5 Mar 2015 15:25:57 +0530
Message-ID: <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
	<CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
	<CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, Chen Fan <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.k>
List-Id: linux-pm@vger.kernel.org

On 5 March 2015 at 12:57, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:

> On 4 March 2015 at 19:09, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> There are 2 clusters, but only the big cluster need to do voltage scaling in the
> notifier, since the voltage controlling is done by cpufreq-dt driver
> in this version.
> Therefore only one dvfs_info struct here.

Do you really think its readable enough that way? You must have added some
comments on how this is working. Also, what about putting this stuff in your
regulator driver, so that you don't really have to do this in PRE/POST
notifiers.

>>> +       inter_clk = clk_get(&pdev->dev, NULL);
>>
>> How is this supposed to work ? How will pdev->dev give intermediate
>> clock ?
>
> It works with the the device tree binding in the 2nd patch of this series, too.
> Since the cpufreq node is not allowed, would you have some suggestions on
> how to get the intermediate clock source in this case?

How exactly? I am not doubting your work, just that I don't know how that DT
binding will reflect here with clock_get for pdev->dev..

>>> +       pd->independent_clocks = 1,
>>
>> s/,/; ??
>
> It's strange that I didn't get a compiling error here.
> Will fix it.

Its a perfectly valid statement :) and so no errors. Both will execute as they
will in case of ';', just that output of the later one will be
returned. But there
in no variable on LHS (left-hand-side) and so the value doesn't matter.

>> Don't want to free OPP table here on error ?
>
> Please correct me if I was wrong. Since the OPP table in the dvfs_info is
> allocated by devm_kzalloc(), it is supposed to be freed if the probe function
> failed, isn't it?
>
> And the OPP table initialized by of_init_opp_table() in cpu_opp_table_init()
> was freed right before the function return since it will be initialized again in
> the cpufreq-dt driver.

Okay, I was talking about this only and I missed it. We probably need to fix
this in OPP library so that multiple callers are allowed.

>>> +       dev = platform_device_register_data(NULL, "cpufreq-dt", -1, pd,
>>> +                                           sizeof(*pd));
>>
>> So this routine is going to be called only once. Then how are you
>> initializing stuff
>> for both the clusters in the upper for loop ? It looked very very confusing.
>
> Please let me clarify this here.
> We have two clusters, one for big and another for little cores. For
> the little cores'
> cluster, only one voltage source needs to be controlled when doing CPU DVFS.
> Therefore the voltage scaling of little cores' cluster is done in the
> cpufreq-dt.
> But for the big cores' cluster, there are two voltage sources here to
> be controlled
> and these two voltage source need to be scaled up and down in a SoC specific
> manner which is implemented in the mtk_cpufreq_voltage_trace() function.
> Hence, we put the voltage scaling of big cores' cluster in the cpufreq
> notifier and
> that's also why we need a mtk-cpufreq driver in addition to cpufreq-dt.
>
> In the confusing loop above, I am trying to solve two problems:
> 1. to find out which CPUs shares the same clock / power domains among all CPUs
> 2. to initialize the dvfs_info which is only needed by big cores' cluster
>
> I think that's why the loop looks so confusing. Maybe doing it in two
> separate loops
> will make the code more readable? I'll try it in next version.

Yes.
