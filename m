From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: Re: [PATCH 2/3] PM / devfreq: fix stats start time stamp
Date: Tue, 15 Jan 2013 17:10:39 +0530
Message-ID: <CA+Z25wXg=exK5XB_j4-iNX2GH8tEOUg=DsN6mDk67eidx873Mw@mail.gmail.com>
References: <1357624239-13938-1-git-send-email-rajagopal.venkat@linaro.org>
	<1357624239-13938-2-git-send-email-rajagopal.venkat@linaro.org>
	<CAJ0PZbQ1FOk0LMxDCpANqAJ5MOciGy1fvyN__TrEgTGRz-63KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ0PZbQ1FOk0LMxDCpANqAJ5MOciGy1fvyN__TrEgTGRz-63KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: jonghwa3.lee@samsung.com, kyungmin.park@samsung.com, mturquette@linaro.org, rjw@sisk.pl, patches@linaro.org, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14 January 2013 20:12, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> On Tue, Jan 8, 2013 at 2:50 PM, Rajagopal Venkat
> <rajagopal.venkat@linaro.org> wrote:
>> Mark the stats start time stamp when actual load monitoring is
>> started for accuracy.
>>
>
> It appears that you are changing the semantics of the information here.
>
>
> For example, in the case:
> - devfreq started at 0 w/ 100MHz
> - at 10, devfreq monitor starts w/ 100MHz
> - at 20, devfreq updates the freq to 200MHz
> - at 30, devfreq is requested to show the stat
>
> The conventional:
> 20 @ 100MHz / 10 @ 200MHz
>
> You proposed:
> 10 @ 100MHz / 10 @ 200MHz
>
>
> Could you please give some reasons why the latter is "more accurate"?
> To me, the former seems appropriate.
Yes. I agree. Please ignore this change.
>
>
>
> Cheers,
> MyungJoo
>
>
>> Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
>> ---
>>  drivers/devfreq/devfreq.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 5782c9b..2843a22 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -254,9 +254,12 @@ static void devfreq_monitor(struct work_struct *work)
>>  void devfreq_monitor_start(struct devfreq *devfreq)
>>  {
>>         INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> -       if (devfreq->profile->polling_ms)
>> +       if (devfreq->profile->polling_ms) {
>>                 queue_delayed_work(devfreq_wq, &devfreq->work,
>>                         msecs_to_jiffies(devfreq->profile->polling_ms));
>> +
>> +               devfreq->last_stat_updated = jiffies;
>> +       }
>>  }
>>  EXPORT_SYMBOL(devfreq_monitor_start);
>>
>> @@ -498,7 +501,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>         devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
>>                                                 devfreq->profile->max_state,
>>                                                 GFP_KERNEL);
>> -       devfreq->last_stat_updated = jiffies;
>>         devfreq_set_freq_limits(devfreq);
>>
>>         dev_set_name(&devfreq->dev, dev_name(dev));
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> MyungJoo Ham, Ph.D.
> Mobile Software Platform Lab, DMC Business, Samsung Electronics



-- 
Regards,
Rajagopal
