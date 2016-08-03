From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] cpufreq: cpufreq_stats in the absence of frequency table
Date: Wed, 3 Aug 2016 09:41:21 -0600
Message-ID: <a004f58d-d467-c2a4-ffa4-7179d628e8c8@codeaurora.org>
References: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org>
 <1547887.jMFZtBx5tV@vostro.rjw.lan>
 <5a559b20-28f5-5b51-6b8e-11d7884709ab@codeaurora.org>
 <4103198.vv1olU1ZFT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60787 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbcHCPli (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Aug 2016 11:41:38 -0400
In-Reply-To: <4103198.vv1olU1ZFT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

Hi Rafael,

On 8/2/2016 5:49 PM, Rafael J. Wysocki wrote:
> On Tuesday, August 02, 2016 05:41:24 PM Prakash, Prashanth wrote:
>> Hi Rafael,
>>
>> On 8/2/2016 5:27 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, August 02, 2016 05:18:57 PM Prashanth Prakash wrote:
>>>> cpufreq drivers such as CPPC works on contigious scale and does
>>>> not have a static frequency table. This commit adds cpufreq_stats
>>>> support for such drivers by creating a pseudo frequency table by
>>>> discretizing the contigious scale.
>>> No.
>>>
>>> And why?
>> The motivation is to be able to collect the frequency distribution data via
>> time_in_state sysfs entry as we can collect for other cpufreq drivers that
>> uses a frequency table.
> Which can be done by using the cpu_frequency trace point just fine, can't it?
Yes, but wanted to make sure existing userspace tools can be used with
platforms using CPPC as well.
> Plus, cpufreq_stats don't work with the schedutil governor and fast frequency
> switching anyway.
If we are expecting that usage of cpufreq_stats will slowly go away as we
switch to schedutil and more drivers enable fast_switching, then I agree
it doesn't make much sense to add support for cpufreq_stats.

Thanks,
Prashanth
