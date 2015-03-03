From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 03 Mar 2015 15:34:55 +0000
Message-ID: <54F5D49F.2060408@arm.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>	<1425316643-31991-6-git-send-email-javi.merino@arm.com>	<CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>	<54F5941F.6030402@arm.com>	<CAKohpon3sn_4aX7g+=LFdY-AgYrWdFCWtyethJtVMEK=Dw9Xbw@mail.gmail.com>	<54F59DEF.3020700@arm.com>	<CAKohponB3cNXT8p=SqrfpGEPjLpeE=tnzUVOiabV8hEfBMb8rQ@mail.gmail.com>	<54F5CEBC.1070303@arm.com> <CAKohpokrxi2p0Ad3SZDjX90gk7HSgwHwNs5DTiYPZYUZMOTJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokrxi2p0Ad3SZDjX90gk7HSgwHwNs5DTiYPZYUZMOTJSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <Javi.Merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 03/03/15 15:29, Viresh Kumar wrote:
> On 3 March 2015 at 20:39, Kapileshwar Singh <kapileshwar.singh@arm.com> wrote:
> 
>> I did test this but we were working with the assumption that OPPs should be populated for all the CPUs and also that OPPs are lost for a hotplugged CPU which I see is not the case.
> 
> Then what did you test? My point here is, even with the latest patches
> that you have
> sent, you wouldn't be able to get the OPPs once policy->cpu goes down. So, how
> did this worked for you ?

We were basing our fix on possibility of having OPPs for all the CPUs and we incorrectly attributed the erroneous OPP we got from dev_pm_opp_find_freq_exact to the missing OPPs in the other CPUs.

> 
>> We have looked at this more closely and found that problem lies in:
>>
>>         freq = cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
>>
>> which returns a NULL frequency as we are not checking for online CPUs here. We shall come up with a fix for this. Many thanks for helping us with the investigation.
> 
> Right.
> 
