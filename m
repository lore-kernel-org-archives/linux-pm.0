From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 4/6] PM / devfreq: Set the freq_table of devfreq device
Date: Mon, 23 Nov 2015 17:51:27 +0900
Message-ID: <CAGTfZH2BmZ1_sev87Z7BYRHnVBkAKB3yyOWmsryx+yg36Tu7NA@mail.gmail.com>
References: <106136506.126661448263783195.JavaMail.weblogic@epmlwas06a>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34363 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbbKWIv2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 03:51:28 -0500
In-Reply-To: <106136506.126661448263783195.JavaMail.weblogic@epmlwas06a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Nov 23, 2015 at 4:29 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>
>>  This patch initialize the freq_table array of each devfreq device by using
>> the devfreq_set_freq_table(). If freq_table is NULL, the devfreq framework
>> is not able to support the frequency transtion information through sysfs.
>>
>> The OPP core uses the integer type for the number of opps in the opp list
>> and uses the 'unsigned long' type for each frequency. So, this patch modifies
>> the type of some variable as following:
>> - the type of freq_table : unsigned int -> unsigned long
>> - the type of max_state  : unsigned int -> int
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> []
>> +/**
>>   * devfreq_update_status() - Update statistics of devfreq behavior
>>   * @devfreq: the devfreq instance
>>   * @freq:    the update target frequency
>> @@ -477,7 +516,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>       devfreq->previous_freq = profile->initial_freq;
>>       devfreq->data = data;
>>       devfreq->nb.notifier_call = devfreq_notifier_call;
>> +     mutex_unlock(&devfreq->lock);
>>
>> +     if (devfreq->profile->max_state <= 0 && !devfreq->profile->freq_table)
>> +             devfreq_set_freq_table(devfreq);
>> +
>> +     mutex_lock(&devfreq->lock);
>
> Anyway, what about modifying the block above as:
>
> +       if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
> +               mutex_unlock(&devfreq->lock);
>                 devfreq_set_freq_table(devfreq);
> +               mutex_lock(&devfreq->lock);
> +       }
>
>>       devfreq->trans_table =  devm_kzalloc(dev, sizeof(unsigned int) *
>>                                               devfreq->profile->max_state *
>>                                               devfreq->profile->max_state,
> []
>
> If that's not a problem, I'll squash
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=for-rafael&id=55df2b43cdb5ac82d26b64d739f3d758c9b7486c
> with the given patch.

I agree. Thanks for fixing this.

Regards,
Chanwoo Choi
