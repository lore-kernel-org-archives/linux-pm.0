From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RFC 1/4] PM / devfreq: Add DevFreq subsystem suspend/resume
Date: Thu, 24 Nov 2016 17:20:55 +0900
Message-ID: <5836A2E7.5080504@samsung.com>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <CGME20161123135204epcas1p4c16e65584e901dfc5062f9afdc00b0fe@epcas1p4.samsung.com>
 <1479909087-22659-2-git-send-email-tjakobi@math.uni-bielefeld.de>
 <583643A7.6020502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <583643A7.6020502@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Tobias,

On 2016년 11월 24일 10:34, Chanwoo Choi wrote:
> Hi Tobias,
> 
> I like your suggestion. But I have some comment on below.
> 
> On 2016년 11월 23일 22:51, Tobias Jakobi wrote:
>> This suspend/resume operations works analogous to the
>> cpufreq_{suspend,resume}() calls in the CPUFreq subsystem.
>>
>> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> ---
>>  drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/devfreq.h   | 10 +++++++
>>  2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index bf3ea76..2f1aa83 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -785,6 +785,81 @@ int devfreq_resume_device(struct devfreq *devfreq)
>>  EXPORT_SYMBOL(devfreq_resume_device);
>>  
>>  /**
>> + * devfreq_suspend() - Suspend DevFreq governors
>> + *
>> + * Called during system wide Suspend/Hibernate cycles for suspending governors
>> + * in the same fashion as cpufreq_suspend().
>> + */
>> +void devfreq_suspend(void)
>> +{
>> +	struct devfreq *devfreq;
>> +	unsigned long freq;
>> +	int ret;
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		if (!devfreq->suspend_freq)
>> +			continue;
>> +
>> +		ret = devfreq_suspend_device(devfreq);

The devfreq_suspend_device() stop the monitoring of governors.
But, this function is exported. It means that each devfreq device.
can call the devfreq_suspend/resume_device() (e.g., int drivers/scsi/ufs/ufshcd.c)

So, you should consider following case:
- case :Before calling the devfreq_suspend() and specific devfreq already call
  the devfreq_suspend_device(), how to support it?
  In this case, the specific devfreq device don't want to call
  the devfreq_resume_device() in the devfreq_resume().

>> +		if (ret < 0) {
>> +			dev_warn(&devfreq->dev, "%s: governor suspend failed\n", __func__);
>> +			continue;
>> +		}
>> +
>> +		devfreq->resume_freq = 0;
>> +		if (devfreq->profile->get_cur_freq) {
>> +			ret = devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq);
>> +			if (ret >= 0)
>> +				devfreq->resume_freq = freq;
>> +		}
>> +
>> +		freq = devfreq->suspend_freq;
>> +		ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
> 
> 
> DEVFREQ subsystem has the passive governor[2] and devfreq device using passive[1]
> governor depends on the parent devfreq device. The passive governor uses
> 'DEVFREQ_TRANSITION_NOTIFIER' notifier to track the changed state of
> parent devfreq device.
> 
> When changing the clock/voltage of parent devfreq device,
> DEVFREQ subsystem have to notify the changed frequency
> to the passive devfreq device.
> 
> So, you should call the devfreq_notifiy_transition()
> before/after 'devfreq->profile->target' as following:
> You can refer the update_devfreq() function 
> that is how to use devfreq_notifiy_transition().
> 
> For example,
> 		struct devfreq_freq freqs;
>  
> 		if (devfreq->profile->get_cur_freq) {
> 			ret = devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq);
> 			if (ret >= 0)
> 				devfreq->resume_freq = freq;
> 		} else {
> 			devfreq->resume_freq = devfreq_previous_freq;
> 		} 
> 
> 		freqs.old = devfreq->resume_freq;
> 		freqs.new = devfreq->suspend_freq;
> 		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> 
>                 freq = devfreq->suspend_freq;
>                 ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
>  
> 		freqs.new = freq;
> 		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> 
>                 if (ret < 0)
>                         dev_warn(&devfreq->dev, "%s: setting suspend frequency failed\n", __func__);
>         }
> 
> [1] DEVFREQ_TRANSITION_NOTIFIER notifier
> - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0fe3a66410a3ba96679be903f1e287d7a0a264a9
> [2] DEVFREQ passive governor
> - https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=996133119f57334c38b020dbfaaac5b5eb127e29
> 
>> +
>> +		if (ret < 0)
>> +			dev_warn(&devfreq->dev, "%s: setting suspend frequency failed\n", __func__);
>> +	}
>> +
>> +	mutex_unlock(&devfreq_list_lock);
>> +}
>> +
>> +/**
>> + * devfreq_resume() - Resume DevFreq governors
>> + *
>> + * Called during system wide Suspend/Hibernate cycle for resuming governors that
>> + * are suspended with devfreq_suspend().
>> + */
>> +void devfreq_resume(void)
>> +{
>> +	struct devfreq *devfreq;
>> +	unsigned long freq;
>> +	int ret;
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		if (!devfreq->suspend_freq)
>> +			continue;
>> +
>> +		freq = devfreq->resume_freq;
>> +		ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
> 
> ditto.
> 
>> +
>> +		if (ret < 0) {
>> +			dev_warn(&devfreq->dev, "%s: setting resume frequency failed\n", __func__);
>> +			continue;
>> +		}
>> +
>> +		ret = devfreq_resume_device(devfreq);
>> +		if (ret < 0)
>> +			dev_warn(&devfreq->dev, "%s: governor resume failed\n", __func__);
>> +	}
>> +
>> +	mutex_unlock(&devfreq_list_lock);
>> +}
>> +
>> +/**
>>   * devfreq_add_governor() - Add devfreq governor
>>   * @governor:	the devfreq governor to be added
>>   */
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 2de4e2e..555d024 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -171,6 +171,9 @@ struct devfreq {
>>  	struct notifier_block nb;
>>  	struct delayed_work work;
>>  
>> +	unsigned long suspend_freq; /* freq during devfreq suspend */
>> +	unsigned long resume_freq; /* freq restored after suspend cycle */
>> +
>>  	unsigned long previous_freq;
>>  	struct devfreq_dev_status last_status;
>>  
>> @@ -211,6 +214,10 @@ extern void devm_devfreq_remove_device(struct device *dev,
>>  extern int devfreq_suspend_device(struct devfreq *devfreq);
>>  extern int devfreq_resume_device(struct devfreq *devfreq);
>>  
>> +/* Suspend/resume the entire Devfreq subsystem. */
>> +void devfreq_suspend(void);
>> +void devfreq_resume(void);
>> +
>>  /* Helper functions for devfreq user device driver with OPP. */
>>  extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>>  					   unsigned long *freq, u32 flags);
>> @@ -410,6 +417,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
>>  {
>>  	return -EINVAL;
>>  }
>> +
>> +static inline void devfreq_suspend(void) {}
>> +static inline void devfreq_resume(void) {}
>>  #endif /* CONFIG_PM_DEVFREQ */
>>  
>>  #endif /* __LINUX_DEVFREQ_H__ */
>>
> 
> 
Best Regards,
Chanwoo Choi
