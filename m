From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 11 Sep 2015 13:43:51 -0700
Message-ID: <55F33D07.5090107@codeaurora.org>
References: <001401d0e691$302127b0$90637710$@net> <001601d0e7af$01a22140$04e663c0$@net> <20150905081407.GK5285@linux> <36067670.SJVW3MBOsV@vostro.rjw.lan> <20150908024014.GD26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34040 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbbIKUnx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 16:43:53 -0400
In-Reply-To: <20150908024014.GD26760@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, linux-pm@vger.kernel.org

Sorry about the late reply and not helping out earlier. Didn't check 
this email account for sometime.

On 09/07/2015 07:40 PM, Viresh Kumar wrote:
> On 07-09-15, 15:32, Rafael J. Wysocki wrote:
>> First, if policy->cpu is offline, the policy will be inactive to my eyes, so
>> we don't need the second check.
>
> Hmm, or maybe just drop the first check.
>
>> But if the policy is active (and policy->cpu is online), it will not generally
>> fail for an offline CPU.
>
> Right.
>
>> So, if the policy applies to more than 1 CPU, you
>> can use any of them to manipulate it, even if one of them is offline as long
>> as there are any online CPUs in the set.
>
> Right.
>
>> This isn't entirely consistent.  We should either fail store() for any offline
>> CPU
>
> At that point we have no idea of the CPU for which the sysfs operation
> is called. And so we have to go ahead without failing, if policy is
> active.
>
>> or make the changes for offline CPUs to.
>
> What does that mean? Most of the stuff we do is for the policy, rather
> than per-cpu. And if there is per-cpu stuff, then we *only* should be
> doing that for the online ones.
>
> Not sure if I understood what you meant here. :(
>
>> And in the particular case of
>> the governor, I'm wondering what will be the problem with changing last_governor
>> for an inactive policy?
>
> I don't think we should be adding special cases for updating sysfs
> attributes of an inactive policy. Its not just about the last_governor
> thing, but other sysfs attributes as well.
>

The way I see it, having the cpufreq policy control sysfs "bits" under 
every CPU directory is what's causing some semantic confusion/inconsistency.

Every single node under a cpufreq folder is for policy control and not 
CPU control. But by putting the policy control bits under the cpuX 
directory, we give the wrong semantic impression that it's a per CPU 
attribute when it's really per-policy.

Ideally (in terms of semantics) we would have put all the policy control 
bits in a per policy directory under 
/sys/devices/system/cpu/cpufreq/policyX/ where X would/could be the tied 
to the first CPU in related CPUs -- so that it's easy to correlate and 
also to avoid having the policy numbering being different depending on 
the order in which CPUs get hotplugged.

But we can't go about breaking userspace ABI by removing the cpufreq 
directories out of the cpu directories just because of the semantic 
confusion.

Well, we COULD still put the policy directories under cpu/cpufreq/ and 
then make every cpuX/cpufreq directory a symlink to the actual policy 
directory. But that is not going to help with this specific 
issue/discussion.

Having said all that, I still think that stores to all these sysfs files 
should work. I'm not saying it's a trivial change (like setting a 
governor's polling time, etc would need some checks to cache the value 
and not start a timer immediately, etc), but I think it's a more 
consistent and user friendly API.

If the user wants to set a min CPU freq, why should they care if the CPU 
is online at that very instant? It gets especially painful if you have a 
thermal daemon that's plugging in/out CPUs while the user or a script is 
trying to set the parameters.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
