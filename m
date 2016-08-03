From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: cpufreq_stats in the absence of frequency table
Date: Wed, 3 Aug 2016 23:41:14 +0200
Message-ID: <CAJZ5v0ir0UnT7qg5CQ7_asv1+5Wxj5Lm-pqo=hdyDnSsb=9ejQ@mail.gmail.com>
References: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org>
 <1547887.jMFZtBx5tV@vostro.rjw.lan> <5a559b20-28f5-5b51-6b8e-11d7884709ab@codeaurora.org>
 <4103198.vv1olU1ZFT@vostro.rjw.lan> <a004f58d-d467-c2a4-ffa4-7179d628e8c8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37209 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758388AbcHCVsE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2016 17:48:04 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so355018893wmg.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Aug 2016 14:48:03 -0700 (PDT)
In-Reply-To: <a004f58d-d467-c2a4-ffa4-7179d628e8c8@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Alexey Klimov <alexey.klimov@arm.com>, hotran@apm.com, Christopher Covington <cov@codeaurora.org>

On Wed, Aug 3, 2016 at 5:41 PM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi Rafael,
>
> On 8/2/2016 5:49 PM, Rafael J. Wysocki wrote:
>> On Tuesday, August 02, 2016 05:41:24 PM Prakash, Prashanth wrote:
>>> Hi Rafael,
>>>
>>> On 8/2/2016 5:27 PM, Rafael J. Wysocki wrote:
>>>> On Tuesday, August 02, 2016 05:18:57 PM Prashanth Prakash wrote:
>>>>> cpufreq drivers such as CPPC works on contigious scale and does
>>>>> not have a static frequency table. This commit adds cpufreq_stats
>>>>> support for such drivers by creating a pseudo frequency table by
>>>>> discretizing the contigious scale.
>>>> No.
>>>>
>>>> And why?
>>> The motivation is to be able to collect the frequency distribution data via
>>> time_in_state sysfs entry as we can collect for other cpufreq drivers that
>>> uses a frequency table.
>> Which can be done by using the cpu_frequency trace point just fine, can't it?
>
> Yes, but wanted to make sure existing userspace tools can be used with
> platforms using CPPC as well.

powertop uses the cpu_frequency trace point already.

Generally, everything that works with intel_pstate should be using it
too, as intel_pstate doesn't use cpufreq_stats.

>> Plus, cpufreq_stats don't work with the schedutil governor and fast frequency
>> switching anyway.
>
> If we are expecting that usage of cpufreq_stats will slowly go away as we
> switch to schedutil and more drivers enable fast_switching, then I agree
> it doesn't make much sense to add support for cpufreq_stats.

Regardless of the expectations about the future, let's just say that
cpufreq_stats only makes sense if frequency tables are in use and only
if __target_index() is used to change frequencies.

And yes, I would like it to go away, because it is inefficient and clunky.

Thanks,
Rafael
