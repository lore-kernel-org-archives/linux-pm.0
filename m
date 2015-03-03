From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 03 Mar 2015 15:09:48 +0000
Message-ID: <54F5CEBC.1070303@arm.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>	<1425316643-31991-6-git-send-email-javi.merino@arm.com>	<CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>	<54F5941F.6030402@arm.com>	<CAKohpon3sn_4aX7g+=LFdY-AgYrWdFCWtyethJtVMEK=Dw9Xbw@mail.gmail.com>	<54F59DEF.3020700@arm.com> <CAKohponB3cNXT8p=SqrfpGEPjLpeE=tnzUVOiabV8hEfBMb8rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43974 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbbCCPJw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 10:09:52 -0500
In-Reply-To: <CAKohponB3cNXT8p=SqrfpGEPjLpeE=tnzUVOiabV8hEfBMb8rQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>

On 03/03/15 13:07, Viresh Kumar wrote:
> On 3 March 2015 at 17:11, Kapileshwar Singh <kapileshwar.singh@arm.com> wrote:
>> Yes I indeed tested the case where we cache the device pointer of the CPU for which the OPP's are populated.
>> When this CPU is hotplugged out, it invalidates the device pointer itself. Here are the error we get in dmesg:
> 
> What do you mean by 'invalidates the device pointer' ? that cpu_dev is NULL ?

The cpu_dev is not NULL but we get an erroneous OPP back. We found the problem lies in the way we calculate the frequency for the cluster.

>> <3>[67203.216774] opp_get_voltage: Invalid parameters
>> <3>[67203.326774] opp_get_voltage: Invalid parameters
>> <3>[67203.326774] opp_get_voltage: Invalid parameters
> 
> Have you handwritten them ? Why don't they precede with dev_pm_* ??

I have not handwritten them, It was from a Linaro 3.10 based kernel when I first noticed this issue but the same problem exists in mainline. 

Apologies for this I sent you an older trace which I had saved when I found the bug. Here is the trace I get from mainline

[ 5680.135339] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.245528] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.355432] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.465521] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.575599] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.685817] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.795556] dev_pm_opp_get_voltage: Invalid parameters
[ 5680.905598] dev_pm_opp_get_voltage: Invalid parameters

> 
>>
>> Which happens because:
>>
>> unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
>> {
>> ..
>>         tmp_opp = rcu_dereference(opp);
>>         if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->available)
>>                 pr_err("%s: Invalid parameters\n", __func__);
> 
> This %s should print routine name ..
> 
>>         else
>> ..
>>
>> Which happens when
>>
>>         opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
>>                                          true);
>>
>> returns a an erroneous or NULL OPP or the opp is unavailable (in the above condition)
> 

Update: This returns an erroneous  OPP

> Please goto the depth of this thing, as I don't think it should happen.
> 
> Over that I was asking you if you have tested the solution Javi gave,
> because OPPs
> wouldn't have been initialized for other CPUs once policy->cpu goes down.
I did test this but we were working with the assumption that OPPs should be populated for all the CPUs and also that OPPs are lost for a hotplugged CPU which I see is not the case. 

We have looked at this more closely and found that problem lies in:

	freq = cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));

which returns a NULL frequency as we are not checking for online CPUs here. We shall come up with a fix for this. Many thanks for helping us with the investigation.

Regards, 
KP

