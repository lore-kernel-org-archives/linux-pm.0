From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 03 Mar 2015 10:59:43 +0000
Message-ID: <54F5941F.6030402@arm.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>	<1425316643-31991-6-git-send-email-javi.merino@arm.com> <CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <Javi.Merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh!

On 03/03/15 04:03, Viresh Kumar wrote:
> On Mon, Mar 2, 2015 at 10:47 PM, Javi Merino <javi.merino@arm.com> wrote:
>> From: Kapileshwar Singh <kapileshwar.singh@arm.com>
>>
>> When cpufreq changes the policy cpu, we need to update our cached cpu
>> device accordingly.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
>> ---
>>  drivers/thermal/cpu_cooling.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index c4974144c787..e306d6bc3cf1 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -269,6 +269,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>>                 mutex_unlock(&cooling_cpufreq_lock);
>>                 break;
>>
>> +       case CPUFREQ_UPDATE_POLICY_CPU:
>> +               update_cpu_device(policy->cpu);
>> +               break;
>>         case CPUFREQ_CREATE_POLICY:
>>                 update_cpu_device(policy->cpu);
>>                 break;
> 
> First of all, I wasn't able to find 3/5 on LKML and I looked at 3/7
> from an earlier
> version to look at how update_cpu_device() looks like.
> 
> What I couldn't understand is why do you need to update things if policy->cpu
> is changing ?
> 
We store the device pointer of the lead CPU (policy CPU) in a cpufreq domain as a part of the 
cpufreq_cooling_device data structure. There is one cpufreq_cooling_device per 
cpufreq domain. 

We need the device to find out the current OPP for the cpufreq_cooling_device for our static power calculation.

        opp = opp_find_freq_exact(cpu_dev, freq_hz, true);
        voltage = dev_pm_opp_get_voltage(opp);


The problem we are trying to solve here is:

When this lead CPU gets hotplugged out, the device pointer becomes stale and the policy 
cpu for the cpufreq domain changes. We then store the new policy CPU's device pointer for the 
in cpufreq_cooling_device on the reception of a notification from cpufreq. Being open to your 
suggestions for any other possible ways to solve the problem..

Regards, 
KP


> I am expecting a detailed answer here according to your design, and we may
> be able to work out without such updates. Lets see..
> 
