From: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / devfreq: set min/max freq limit from freq table
Date: Tue, 15 Jan 2013 16:51:20 +0530
Message-ID: <CA+Z25wVnFMkXvSOvetipBEFkZgSKe2Qjn1wYf-x5i7skGQ-XSA@mail.gmail.com>
References: <1357624239-13938-1-git-send-email-rajagopal.venkat@linaro.org>
	<CAJ0PZbTAOdQrUjefOpc2MDam1hHLjSEDLHw3VrP+9=OAbgQ8ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAJ0PZbTAOdQrUjefOpc2MDam1hHLjSEDLHw3VrP+9=OAbgQ8ug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 14 January 2013 20:06, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Tue, Jan 8, 2013 at 2:50 PM, Rajagopal Venkat
> <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Set devfreq device min and max frequency limits when device
>> is added to devfreq, provided frequency table is supplied.
>> This helps governors to suggest target frequency with in
>> limits.
>>
>> Signed-off-by: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Could you please elaborate the benefit of the patch?
>

When freq table is supplied, it's unreasonable to suggest the target frequency
which is - target_freq < min_freq and target_freq > max_freq. It avoids
unnecessary checks at devfreq drivers.

> The devfreq device drivers are required to choose proper frequencies
> anyway regardless which values the governors may give (hopefully by
> choosing the closest value that can support the required performance).
>

Yes. but then each driver needs to have conditional checks for choosing
closet value even though freq table is provided.

> Besides, the min/max values are to be set by userspace. Users may
> enter 0 in order to express that they do not want to limit the
> behaviors of governors.
>
>
> Cheers,
> MyungJoo.
>
>> ---
>>  drivers/devfreq/devfreq.c |   24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index a8f0173..5782c9b 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -69,6 +69,29 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>>  }
>>
>>  /**
>> + * devfreq_set_freq_limits() - Set min and max frequency from freq_table
>> + * @devfreq:   the devfreq instance
>> + */
>> +static void devfreq_set_freq_limits(struct devfreq *devfreq)
>> +{
>> +       int idx;
>> +       unsigned long min = ~0, max = 0;
>> +
>> +       if (!devfreq->profile->freq_table)
>> +               return;
>> +
>> +       for (idx = 0; idx < devfreq->profile->max_state; idx++) {
>> +               if (min > devfreq->profile->freq_table[idx])
>> +                       min = devfreq->profile->freq_table[idx];
>> +               if (max < devfreq->profile->freq_table[idx])
>> +                       max = devfreq->profile->freq_table[idx];
>> +       }
>> +
>> +       devfreq->min_freq = min;
>> +       devfreq->max_freq = max;
>> +}
>> +
>> +/**
>>   * devfreq_get_freq_level() - Lookup freq_table for the frequency
>>   * @devfreq:   the devfreq instance
>>   * @freq:      the target frequency
>> @@ -476,6 +499,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>                                                 devfreq->profile->max_state,
>>                                                 GFP_KERNEL);
>>         devfreq->last_stat_updated = jiffies;
>> +       devfreq_set_freq_limits(devfreq);
>>
>>         dev_set_name(&devfreq->dev, dev_name(dev));
>>         err = device_register(&devfreq->dev);
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
