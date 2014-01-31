From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 1/3] cpuidle: split cpuidle_idle_call main function
 into functions
Date: Fri, 31 Jan 2014 15:10:32 +0100
Message-ID: <52EBAED8.8080807@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-2-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1401301433320.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.11.1401301433320.1652@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/30/2014 08:39 PM, Nicolas Pitre wrote:
> On Thu, 30 Jan 2014, Daniel Lezcano wrote:
>
>>   /**
>> + * cpuidle_select - ask the cpuidle framework to choose an idle sta=
te
>> + *
>> + * @drv: the cpuidle driver
>> + * @dev: the cpuidle device
>> + *
>> + * Returns the index of the idle state. On error it returns:
>> + * -NODEV : the cpuidle framework is available
>
> s/available/not available/
>
>> + * -EBUSY : the cpuidle framework is not initialized
>> + */
>> +int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_devic=
e *dev)
>> +{
>> +	if (off || !initialized)
>> +		return -ENODEV;
>> +
>> +	if (!drv || !dev || !dev->enabled)
>> +		return -EBUSY;
>> +
>> +	return cpuidle_curr_governor->select(drv, dev);
>> +}
>> +EXPORT_SYMBOL(cpuidle_select);
>
> Peterz comment notwithstanding, is there actually a need to export th=
ose
> symbols? No modules should ever need to use this given this is going =
to
> be called by the scheduler code.

Yes, you are right. I will remove them.

Thanks !

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
