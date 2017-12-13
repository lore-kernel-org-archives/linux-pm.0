From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Wed, 13 Dec 2017 08:13:42 -0800
Message-ID: <000701d3742d$5948f420$0bdadc60$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net> P0Mmegy2kTqmMP0MoeccOV
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:58192 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbdLMQNp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 11:13:45 -0500
In-Reply-To: P0Mmegy2kTqmMP0MoeccOV
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Andy Tang' <andy.tang@nxp.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>

On 2017.12.12 22:18 Viresh Kumar wrote:
> On 12-12-17, 19:10, Doug Smythies wrote:

>> Thanks for the suggestion. It was so very close, the problem commit is the very
>> next one, aa7519af450d.
>> 
>> Bisect result:
>> 
>> aa7519af450d3c62a057aece24877c34562fa25a is the first bad commit
>> commit aa7519af450d3c62a057aece24877c34562fa25a
>> Author: Viresh Kumar <viresh.kumar@linaro.org>
>> Date:   Wed Jul 19 15:42:42 2017 +0530
>> 
>>     cpufreq: Use transition_delay_us for legacy governors as well
>> 
>>     The policy->transition_delay_us field is used only by the schedutil
>>     governor currently, and this field describes how fast the driver wants
>>     the cpufreq governor to change CPUs frequency. It should rather be a
>>     common thing across all governors, as it doesn't have any schedutil
>>     dependency here.
>> 
>>     Create a new helper cpufreq_policy_transition_delay_us() to get the
>>     transition delay across all governors.
>> 
>>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> What has changed for intel-pstate after this patch ?
>
> sampling_rate for conservative and ondemand is 500 us now, which was 20000 us
> earlier. So we reevaluate load very frequently now, but in case load isn't over
> 80% then we wouldn't increase the frequency.
>
> @Doug/Andy: Can you please try following:
>
> - Checkout 4.14 or mainline (the broken kernels).
> - Set governor to conservative.
> - Monitor /sys/devices/system/cpu/cpufreq/policy*/stats/total_trans (to check if
>  frequency is getting changed or not).

I do not have a stats directory. I am now using kernel 4.15-rc3

> - Run some dummy load, I did this:
>
>  perf bench sched messaging --pipe --thread --group 8
>
> This should result in frequency updates, so its not that we aren't changing
> frequency at all now with conservative.
>
> Then do this:
>
> echo 20000 > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
>
> and this should take you back to the original behavior which was there pre-4.14.

Yes, that works.
The breakpoint is <2000 (on my system, at least). 1999 doesn't work, but one can observe that it is trying.
2000 works, but seems to struggle a little.

... Doug
