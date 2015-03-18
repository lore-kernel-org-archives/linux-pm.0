From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v6 5/8] PM / devfreq: tegra: remove operating-points
Date: Wed, 18 Mar 2015 08:25:28 +0100
Message-ID: <CAAObsKBZndddvouL4RKPLghCad9LCBmvYJTMB83m6wH7O7Hwzw@mail.gmail.com>
References: <192647817.276191426656237193.JavaMail.weblogic@epmlwas07d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <192647817.276191426656237193.JavaMail.weblogic@epmlwas07d>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18 March 2015 at 06:23, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> As the DT bindings don't have an operating-points property any more,
>> build the OPP table from the frequencies supported by the EMC clock.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index 5a6164c..1de3f8b 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -618,6 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>       struct tegra_devfreq_device *dev;
>>       struct resource *res;
>>       unsigned int i;
>> +     unsigned long rate;
>>       int irq;
>>       int err;
>>
>> @@ -649,12 +650,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>               return PTR_ERR(tegra->emc_clock);
>>       }
>>
>> -     err = of_init_opp_table(&pdev->dev);
>> -     if (err) {
>> -             dev_err(&pdev->dev, "Failed to init operating point table\n");
>> -             return err;
>> -     }
>> -
>>       clk_set_rate(tegra->emc_clock, ULONG_MAX);
>>
>>       tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
>> @@ -691,6 +686,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>               tegra_actmon_configure_device(tegra, dev);
>>       }
>>
>> +     for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>> +             rate = clk_round_rate(tegra->emc_clock, rate);
>> +             dev_pm_opp_add(&pdev->dev, rate, 0);
>> +     }
>> +
>
> Although I am not going to NACK for the single-time performance of a
> single device driver for a device that I do not have or fully understand,
> please note that you may be wasting several billion cycles unless
> your product is running at MHZ/kHZ level.
>
> What is going on with this loop? Do you really have such a virtually-continuous
> frequency scaling in your product? (Wow.... but in such a case, I don't think
> OPP is appropriate.)

Actually, that loop is expected to only execute as many times as
frequencies are supported by the clock. This is using knowledge of the
clock always rounding up when possible, which I think is fine in this
case.

Regards,

Tomeu

>
> Cheers,
> MyungJoo
>
>
>>       irq = platform_get_irq(pdev, 0);
>>       if (irq <= 0) {
>>               dev_err(&pdev->dev, "Failed to get IRQ\n");
>> --
>> 2.1.0
>>
