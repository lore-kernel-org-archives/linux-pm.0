From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC v2 04/12] ARM: cpuidle: Add runtime PM support for CPUs
Date: Tue, 1 Mar 2016 11:36:30 -0700
Message-ID: <20160301183630.GL1440@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-5-git-send-email-lina.iyer@linaro.org>
 <20160226182419.GV28849@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160226182419.GV28849@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 26 2016 at 11:24 -0700, Stephen Boyd wrote:
>On 02/12, Lina Iyer wrote:
>> @@ -45,6 +48,8 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>
>>  	ret = cpu_pm_enter();
>>  	if (!ret) {
>> +		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
>
>Can you add a comment on why we need to use RCU_NONIDLE here?
>It's not super obvious.
>
OK.

>> +
>>  		/*
>>  		 * Pass idle state index to cpu_suspend which in turn will
>>  		 * call the CPU ops suspend protocol with idle index as a
>> @@ -52,6 +57,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>  		 */
>>  		arm_cpuidle_suspend(idx);
>>
>> +		RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
>>  		cpu_pm_exit();
>>  	}
>>
>> @@ -84,6 +90,30 @@ static const struct of_device_id arm_idle_state_match[] __initconst = {
>>  	{ },
>>  };
>>
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static int cpu_hotplug(struct notifier_block *nb,
>
>This function is pretty generically named. Maybe something more
>runtime PM specific or cpu idle specific?
>
OK

>> +			unsigned long action, void *data)
>> +{
>> +	struct device *cpu_dev = get_cpu_device(smp_processor_id());
>> +
>> +	/* Execute CPU runtime PM on that CPU */
>> +	switch (action) {
>
>We could do the & ~CPU_TASKS_FROZEN trick here to save a few cases.
>
OK

>> +	case CPU_DYING:
>> +	case CPU_DYING_FROZEN:
>> +		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
>
>And do we actually need to use it for hotplug path? These
>notifiers don't run from idle context do they?
>
True. Will remove.

> +
>>  /*
>>   * arm_idle_init
>>   *
>> @@ -96,6 +126,7 @@ static int __init arm_idle_init(void)
>>  	int cpu, ret;
>>  	struct cpuidle_driver *drv = &arm_idle_driver;
>>  	struct cpuidle_device *dev;
>> +	struct device *cpu_dev;
>>
>>  	/*
>>  	 * Initialize idle states data, starting at index 1.
>> @@ -148,10 +189,17 @@ static int __init arm_idle_init(void)
>>  		}
>>  	}
>>
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	/* Register for hotplug notifications for runtime PM */
>> +	hotcpu_notifier(cpu_hotplug, 0);
>
>Define an empty cpu_hotplug() function for !CONFIG_HOTPLUG_CPU
>and then always call this without the ifdef?
>
I did this so we dont even register a hotplug notifier. Will change.

Thanks,
Lina
