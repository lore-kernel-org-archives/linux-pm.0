From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Tue, 12 Dec 2017 19:10:00 -0800
Message-ID: <000f01d373bf$deacca10$9c065e30$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> OnmAeAGHQC2CsOnmBePWkD
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:36148 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdLMDKF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Dec 2017 22:10:05 -0500
In-Reply-To: OnmAeAGHQC2CsOnmBePWkD
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Andy Tang' <andy.tang@nxp.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

On 2017.12.12 08:51 Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2017 at 5:18 PM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2017.12.11 23:31 Viresh Kumar wrote:
>>> On 12-12-17, 02:46, Andy Tang wrote:
>>>> Hi,
>>>>
>>>> I run into a question that conservative governor can't work while ondemand governor works well.
>>>> When cpu load gets higher, if ondemand governor is used, cpu frequency can get higher and higher.
>>>> But if I use conservative governor, cpu frequency stays on lowest frequency no matter what cpu load is.
>>>>
>>>> This issue was found on kernel 4.14.0, on kernel 4.9 kernel. It acts well.
>>>
>>> You mean to say that the problem exists on 4.14 but not on 4.9?
>>>
>>> Strange, as we haven't seen any such reports from anyone else.
>>
>> Well, it is easy enough for us to check.
>> Indeed, it is broken in kernel 4.14-rc1, but O.K. in kernel 4.13.
>> It remains broken in kernel 4.15-rc1 (I am not on -rc3 yet).
>>
>> Because it was easier for me to do so, I used intel_cpufreq (i.e. intel_pstate in passive mode).
>>
>>>
>>>> I think it may related to cpufreq framework, not driver itself. Could you guys give me some clues on how to debug it?
>>>> I don't expect a direct answer; any suggestions are welcome.
>>>
>>> Please provide output of below:
>>>
>>> grep . /sys/devices/system/cpu/cpufreq/policy*/*
>>>
>>> And then you may need to bisect the problem as well by going to kernel version
>>> in between 4.9 and 4.14.
>>
>> @Andy: Have you started bisecting the kernel yet? I suppose I could if you haven't,
>> or if you do not know how.
>
> There is only one commit touching conservative in 4.14:
> 
> 2d045036322c cpufreq: governor: Drop min_sampling_rate
>
> Maybe try to revert this one?

Thanks for the suggestion. It was so very close, the problem commit is the very
next one, aa7519af450d.

Bisect result:

aa7519af450d3c62a057aece24877c34562fa25a is the first bad commit
commit aa7519af450d3c62a057aece24877c34562fa25a
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed Jul 19 15:42:42 2017 +0530

    cpufreq: Use transition_delay_us for legacy governors as well

    The policy->transition_delay_us field is used only by the schedutil
    governor currently, and this field describes how fast the driver wants
    the cpufreq governor to change CPUs frequency. It should rather be a
    common thing across all governors, as it doesn't have any schedutil
    dependency here.

    Create a new helper cpufreq_policy_transition_delay_us() to get the
    transition delay across all governors.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
