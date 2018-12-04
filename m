From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 3/5] devfreq: add devfreq_suspend/resume() functions
Date: Tue, 4 Dec 2018 10:44:46 +0100
Message-ID: <bb7c2fd1-69e2-fdc6-ecb9-83ee22c2601e@partner.samsung.com>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143132eucas1p128c029a7c7461e1127924a08e4a71811@eucas1p1.samsung.com>
        <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
        <5C061C74.808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C061C74.808@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On 12/4/18 7:19 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>> This patch adds implementation for global suspend/resume for
>> devfreq framework. System suspend will next use these functions.
>>
>> The patch is based on earlier work by Tobias Jakobi.
> 
> Please remove it from each patch description.
OK
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/devfreq.h   |  6 ++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 36bed24..7d60423 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -935,6 +935,48 @@ int devfreq_resume_device(struct devfreq *devfreq)
>>   EXPORT_SYMBOL(devfreq_resume_device);
>>   
>>   /**
>> + * devfreq_suspend() - Suspend devfreq governors and devices
>> + *
>> + * Called during system wide Suspend/Hibernate cycles for suspending governors
>> + * and devices preserving the state for resume. On some platforms the devfreq
>> + * device must have precise state (frequency) after resume in order to provide
>> + * fully operating setup.
>> + */
>> +void devfreq_suspend(void)
>> +{
>> +	struct devfreq *devfreq;
>> +	int ret;
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		ret = devfreq_suspend_device(devfreq);
>> +		if (ret)
>> +			dev_warn(&devfreq->dev, "device suspend failed\n");
> 
> When I checked the cpufreq_suspend(), cpufreq_suspend() prints message as 'err' level.
> I think that dev_err is more proper than dev_warn.
> 
> I'm not sure what is more correct log.
> But, 'devfreq->dev' device has the separate suspend/resume function.
> So, I think that devfreq_suspend() should print error log containing
> that it is error by devfreq framework.
> 
> "device suspend failed"
> -> "failed to suspend devfreq device"
OK, changed in next v3 patch set.
> 
>> +	}
>> +	mutex_unlock(&devfreq_list_lock);
>> +}
>> +
>> +/**
>> + * devfreq_resume() - Resume devfreq governors and devices
>> + *
>> + * Called during system wide Suspend/Hibernate cycle for resuming governors and
>> + * devices that are suspended with devfreq_suspend().
>> + */
>> +void devfreq_resume(void)
>> +{
>> +	struct devfreq *devfreq;
>> +	int ret;
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		ret = devfreq_resume_device(devfreq);
>> +		if (ret)
>> +			dev_warn(&devfreq->dev, "device resume failed\n");
> 
> ditto.
> 
> "device resume failed"
> -> "failed to resume devfreq device"
> 
ACK

Regards,
Lukasz
> 
>> +	}
>> +	mutex_unlock(&devfreq_list_lock);
>> +}
>> +
>> +/**
>>    * devfreq_add_governor() - Add devfreq governor
>>    * @governor:	the devfreq governor to be added
>>    */
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index d985199..fbffa74 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -205,6 +205,9 @@ extern void devm_devfreq_remove_device(struct device *dev,
>>   extern int devfreq_suspend_device(struct devfreq *devfreq);
>>   extern int devfreq_resume_device(struct devfreq *devfreq);
>>   
>> +extern void devfreq_suspend(void);
>> +extern void devfreq_resume(void);
>> +
>>   /**
>>    * update_devfreq() - Reevaluate the device and configure frequency
>>    * @devfreq:	the devfreq device
>> @@ -331,6 +334,9 @@ static inline int devfreq_resume_device(struct devfreq *devfreq)
>>   	return 0;
>>   }
>>   
>> +static inline void devfreq_suspend(void) {}
>> +static inline void devfreq_resume(void) {}
>> +
>>   static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>>   					   unsigned long *freq, u32 flags)
>>   {
>>
> 
