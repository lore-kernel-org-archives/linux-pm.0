From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v6 04/13] clk: qcom: gdsc: Manage clocks with !CONFIG_PM
Date: Wed, 29 Jul 2015 10:07:04 +0530
Message-ID: <55B85870.7060900@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org> <1437549069-29655-5-git-send-email-rnayak@codeaurora.org> <55B03D65.8040207@codeaurora.org> <55B0A764.6010708@codeaurora.org> <55B826B0.2090705@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55B826B0.2090705@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, svarbanov@mm-sol.com, srinivas.kandagatla@linaro.org, sviau@codeaurora.org
List-Id: linux-pm@vger.kernel.org


On 07/29/2015 06:34 AM, Stephen Boyd wrote:
> On 07/23/2015 01:35 AM, Rajendra Nayak wrote:
>> []..
>>
>>>> +
>>>> +#ifndef CONFIG_PM
>>>> +static void enable_clock(struct device *dev, const char *con_id)
>>>> +{
>>>> +    struct clk *clk;
>>>> +
>>>> +    clk = clk_get(dev, con_id);
>>>> +    if (!IS_ERR(clk)) {
>>>> +        clk_prepare_enable(clk);
>>>> +        clk_put(clk);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void disable_clock(struct device *dev, const char *con_id)
>>>> +{
>>>> +    struct clk *clk;
>>>> +
>>>> +    clk = clk_get(dev, con_id);
>>>> +    if (!IS_ERR(clk)) {
>>>> +        clk_disable_unprepare(clk);
>>>> +        clk_put(clk);
>>>> +    }
>>>> +}
>>>
>>> Is there a reason why this whole patch isn't generic code? I recall some
>>> discussion but I forgot now and there isn't any mention of why this
>>> isn't generic code in the commit text.
>>
>> If by generic code, you mean using PM clocks, then this thread should
>> give some context..
>> http://www.spinics.net/lists/arm-kernel/msg414072.html
>
> Sorry, I read the thread and I tried to understand what was going on but
> I'm still lost. Can you clarify further in the commit text somehow?

So I can add this in the commit text, if it seems fine

"The use of pm_clk_add_notifier() isn't appropriate here since we need
to only manage clocks with valid power domain associations done via
DT, instead of what pm_clk_add_notifier() does, which is manage clocks
for all on SoC/off SoC devices associating all of them to a dummy power 
domain instead"

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
