From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 06/10] cpufreq: governor: Keep single copy of information
 common to policy->cpus
Date: Thu, 03 Dec 2015 14:00:51 -0800
Message-ID: <5660BB93.8050809@codeaurora.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>  <efd892126475600e751c0e1206553270ebba5c00.1434713657.git.viresh.kumar@linaro.org>  <1448625400.3689.103.camel@pengutronix.de> <20151130051915.GH3373@ubuntu>  <1448879672.8275.15.camel@pengutronix.de> <20151130110327.GC4899@ubuntu>  <565F661F.1020204@codeaurora.org> <20151203045425.GA4302@ubuntu> <1449125623.17314.13.camel@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60800 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbLCWAx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 17:00:53 -0500
In-Reply-To: <1449125623.17314.13.camel@tu-dresden.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com

On 12/02/2015 10:53 PM, Robert Sch=C3=B6ne wrote:
>
>> There is another idea that I have.
>>
>> Lets sacrifice idleness of CPU0 (which is already considered as
>> housekeeping CPU in scheduler) to save us from all the complexity we
>> have today.
>>
>> Suppose we have 16 CPUs, with 4 CPUs per policy and hence 4 policies=
=2E
>> - Keep a single delayed-work (non-deferrable) per policy and queue
>> them as:

This is a 100% no go. Non-deferrable is going to kill mobile idle power=
=2E

>>    queue_work_on(CPU0).
>> - This will work because any CPU can calculate the load of other
>> CPUs,
>>    and there is no dependency on the local CPU.
>> - CPU0 will hence get interrupted, check if the policy->cpus are idl=
e
>>    or not, and if not, update their frequency (perhaps with an IPI).
>>
>> Not sure if this will be better performance wise though.
>>
>
> No it is not. In your example, everything could be okay with many ifs=
=2E
> I'm from the HPC field and would expect load imbalances because this
> approach does not scale with the number of frequency domains.

Agree. I think that's why we had per policy timers (forced to be=20
implemented with per CPU deferrable timers) in the first place.

-Saravana

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
