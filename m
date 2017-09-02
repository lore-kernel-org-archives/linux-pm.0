From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] CHROMIUM: devfreq: rk3399: Clear edev->dev drvdata before
 enabling dfi
Date: Sat, 02 Sep 2017 09:51:41 +0800
Message-ID: <59AA0EAD.3030305@rock-chips.com>
References: <20170901235237.18390-1-jeffy.chen@rock-chips.com> <20170902004659.GA105370@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:38860 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdIBBvy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 21:51:54 -0400
In-Reply-To: <20170902004659.GA105370@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: linux-kernel@vger.kernel.org, dbasehore@chromium.org, dianders@chromium.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org

hi brian,
On 09/02/2017 08:47 AM, Brian Norris wrote:
> On Sat, Sep 02, 2017 at 07:52:37AM +0800, Jeffy Chen wrote:
>> Currently we are using edev->dev drvdata to get rk3399-dmc data, but
>> it would be inited to edev in devfreq_event_add_edev.
>>
>> So we need to clear the edev->dev drvdata before enabling dfi, to
>> prevent dfi from getting the wrong rk3399-dmc data when the irq
>> triggered too early.
>
> Your description doesn't match your code. You say you're clearing
> evdev->dev driver data but...
>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>>   drivers/devfreq/rk3399_dmc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>> index 1b89ebbad02c..12f9f03f349f 100644
>> --- a/drivers/devfreq/rk3399_dmc.c
>> +++ b/drivers/devfreq/rk3399_dmc.c
>> @@ -429,6 +429,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>
>>   	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
>>
>> +	platform_set_drvdata(pdev, NULL);
>
> ...here you're only clearing the drvdata for the platform device. Is
> that a mistake? (Hint: that's not what you uploaded on the Chromium OS
> instance, where you presumably tested this.)
>
> And if you're really trying to do what your commit message says:
>
> We're having two different files fight over who owns the edev drvdata?
> That seems like a big no-no.
>
> We should work out who's the real owner of 'drvdata', and find some
> other solution for the others.

sorry, indeed...it turns out the upstream dmc driver is not using 
dfi(it's simple_onfemand below ;)...

so we don't need thus patch for upstream kernel...or maybe we should 
submit other cros patches(contains the one causes this issue, and this 
patch)
>
> Brian
>
>>   	data->devfreq = devm_devfreq_add_device(dev,
>>   					   &rk3399_devfreq_dmc_profile,
>>   					   "simple_ondemand",
>> --
>> 2.11.0
>>
>>
>
>
>
