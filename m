From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Thu, 24 Mar 2016 23:17:20 +0900
Message-ID: <CAGTfZH34ojHu3bnGSZpbVamZOJ08vnTjzxM-R3r1V8U19eHyDQ@mail.gmail.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
	<56F36D65.6030504@samsung.com>
	<56F3EE8E.3020308@fivetechno.de>
	<56F3F11E.9090200@math.uni-bielefeld.de>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <56F3F11E.9090200@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Markus Reichl <m.reichl@fivetechno.de>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Anand Moon <linux.amoon@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Tobias,

On Thu, Mar 24, 2016 at 10:52 PM, Tobias Jakobi
<tjakobi@math.uni-bielefeld.de> wrote:
> Hello everybody,
>
>
> Markus Reichl wrote:
>> Hi Chanwoo,
>>
>> Am 24.03.2016 um 05:30 schrieb Chanwoo Choi:
>>> Dear Anand and Tobias,
>>>
>>> To Anand,
>>> First of all, thanks to your test on previous patchset.
>>> I removed the your tested-by tag from this version
>>> because I modified the devfreq core using DEVFREQ_TRANSITION_NOTIFIER notifier.
>>> I think that this patch-set need to test with this patchset.
>>> If you possible, could you please test this patch-set? Thanks in advance.
>>>
>>> To Tobias,
>>> I fixed the following issues reported by you. Thanks your test and report.
>>> - RCU locking issue
>>> - debugfs error during kernel booting
>>>
>>> Best Regards,
>>> Chanwoo Choi
>>
>> This set works fine on odroid U3 but gives the following with dmesg |grep devfreq:
>>
>> [    2.066890] devfreq bus_dmc: Couldn't update frequency transition information.
>> [    2.190238] devfreq bus_leftbus: Couldn't update frequency transition information.
> I have yet to test this new iteration of the patchset, but this message
> looks familiar. I already encountered it with the older version applied
> to vanilla-4.5.y.
>
> The messages happen when devfreq_update_status() (in
> drivers/devfreq/devfreq.c) encounters a uninitialized (zero)
> previous_freq. I have currently fixed this in my local tree by just
> skipping (goto out) devfreq_update_status() in that case.

I agree. Your comment is correct.

>
> Maybe it would be more elegant to set previous_freq to something sane on
> probe. IIRC then it is set from initial_freq on probe, but the exynos
> code doesn't set this one.

The devfreq have already this issue before sending my patches.
So, I think that you better to send your fixup patch.

Maybe, the exynos-bus.c read the current frequency in the probe function
and then devfreq core should set the devfreq->previous_freq field.

>
> Maybe this info is helpful?

Your info is very helpful. Thanks.

Best Regards,
Chanwoo Choi
