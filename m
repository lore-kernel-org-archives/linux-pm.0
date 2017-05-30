From: David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] cpufreq: cpufreq_register_driver should return -ENODEV if
 init fails
Date: Tue, 30 May 2017 08:05:44 -0400
Message-ID: <78060adf-a388-daea-e587-4670c269778e@redhat.com>
References: <1495813051-146077-1-git-send-email-darcari@redhat.com>
 <20170529043215.GA5752@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170529043215.GA5752@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/29/2017 12:32 AM, Viresh Kumar wrote:
> You sent it to the wrong list and missed Rafael too. MAINTAINERS file should
> help getting these details in the future.

Oops - my bad.

Rafael - is this OK as is or would you prefer I resend this?

Thanks,

-DA

> 
> On 26-05-17, 11:37, David Arcari wrote:
>> For a driver that does not set the CPUFREQ_STICKY flag, if all of the
>> ->init() calls fail, cpufreq_register_driver() should return an error.
>> This will prevent the driver from loading.
>>
>> Fixes: ce1bcfe94db8 ("cpufreq: check cpufreq_policy_list instead of scanning policies for all CPUs")
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: David Arcari <darcari@redhat.com>
> 
> +
> Cc: 4.0+ <stable@vger.kernel.org> # 4.0+
> 
>> ---
>>  drivers/cpufreq/cpufreq.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 0e3f649..26b643d 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2468,6 +2468,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>>  	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
>>  	    list_empty(&cpufreq_policy_list)) {
>>  		/* if all ->init() calls failed, unregister */
>> +		ret = -ENODEV;
>>  		pr_debug("%s: No CPU initialized for driver %s\n", __func__,
>>  			 driver_data->name);
>>  		goto err_if_unreg;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

