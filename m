From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] kernel/hung_task.c: disable on suspend
Date: Fri, 14 Sep 2018 16:19:52 +0200
Message-ID: <87d0tg88l3.fsf@vitty.brq.redhat.com>
References: <20180913160851.18169-1-vkuznets@redhat.com>
        <4793718.OcKebjM5bH@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4793718.OcKebjM5bH@aspire.rjw.lan> (Rafael J. Wysocki's message
        of "Fri, 14 Sep 2018 13:26:13 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Thursday, September 13, 2018 6:08:51 PM CEST Vitaly Kuznetsov wrote:
...

>> +static int hungtask_pm_notify(struct notifier_block *self,
>> +			      unsigned long action, void *hcpu)
>> +{
>> +	switch (action) {
>> +	case PM_SUSPEND_PREPARE:
>> +	case PM_HIBERNATION_PREPARE:
>> +		hung_detector_suspended = true;
>> +		break;
>> +	case PM_POST_SUSPEND:
>> +	case PM_POST_HIBERNATION:
>> +		hung_detector_suspended = false;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>>  /*
>>   * kthread which checks for tasks stuck in D state
>>   */
>> @@ -261,7 +282,8 @@ static int watchdog(void *dummy)
>>  		interval = min_t(unsigned long, interval, timeout);
>>  		t = hung_timeout_jiffies(hung_last_checked, interval);
>
> Since you are adding the notifier anyway, what about designing it to make
> the thread wait on _PREPARE until the notifier kicks it again on exit
> fron suspend/hibernation?
>

We can either park the kthread (kthread_park/unpark) or make it go away
completely by doing kthread_stop/kthread_run(). I'm leaning toward
parking, what do you think?

-- 
  Vitaly
