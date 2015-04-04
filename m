From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 12/20] cpufreq: Mark policy->governor = NULL for inactive
 policies
Date: Fri, 03 Apr 2015 18:20:59 -0700
Message-ID: <551F3C7B.7060004@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <466c5246b6ad83b960eeb63ab34a04379448980d.1424345053.git.viresh.kumar@linaro.org> <551CC7E2.6070806@codeaurora.org> <CAKohpok37PXGxmP+M-d8mpT-eGxaCjtAwgQdZO=mJ9PmvxTv3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59866 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbDDBVC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 21:21:02 -0400
In-Reply-To: <CAKohpok37PXGxmP+M-d8mpT-eGxaCjtAwgQdZO=mJ9PmvxTv3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 04/01/2015 11:09 PM, Viresh Kumar wrote:
> On 2 April 2015 at 10:08, Saravana Kannan <skannan@codeaurora.org> wrote:
>> What's wrong with this behavior? If you cat scaling_min/max_freq, it's going
>> to show the last minimum and maximum freqs too. I don't think this needs to
>> be set to NULL until the governor is unloaded. Which you are already taking
>> care of in the previous patch.
>>
>> It's handy to be able to tell what governor will be restored when a cluster
>> if offline.
>>
>> Nacked because I think this patch is not helping.
>
> Oh, I really believe this patch makes sense. :)
>
> Don't confuse it with the 'last-governor' thing or scaling_min/max stuff..
> Its different.

Ok, I agree that I misread your other patch and mentally read it as 
setting both last_governor to "" and the governor pointer to NULL. I 
think if you set the governor to NULL in the same for loop, you would 
solve the issues you mention below without compromising the case where 
the governor is not removed and you still let userspace query what the 
last governor is without having to online a CPU.

I think that's way more user friendly without and real negatives. We 
shouldn't make it any less user friendly than it needs to be.

>
> Consider a scenario:
> - Cluster was using ONDEMAND governor.
> - Cluster hotplugged out
> - Governor removed, but the pointer policy->governor isn't updated.
>
> -> At this point accessing 'scaling_governor' or 'scaling_setspeed' can
> get called and that will result in a crash.
>
> - We go ahead and insert the governor again
>
> -> At this point also the same problem will happen as governor will
> get allocated again.
>
> Now, what we are talking about here is a pointer to the governor, not
> its name which is stored in 'last_governor' in the previous patch.
>
> We store that name as it is used for internal working of the core, not for
> userspace.
>
> What we expose to userspace must be consistent, and so if the governor
> is removed, we will not be able to provide 'scaling_setspeed' or
> 'scaling_governor' to userspace.
>
> Also, it is scaling-governor, not what the next governor is going to be.
> Plus, what should we print on scaling_setspeed of a cluster not running
> anymore ?

The same could be said for all the files in that directory. What does it 
mean to say scaling_min_freq for a CPU that's hotplugged out. And the 
argument can be make for cases when the CPU is power collapsed too. What 
does it mean to ask for "current frequency" when it's powered off. The 
point is that these files are representing what will be done when the 
CPUs are clocked. Not what's happening at this absolute instance.

> And so why keep something that we can't provide to userspace all the
> time. That may break userspace if it relies on it..

Because there are plenty of use cases where the module isn't going to be 
removed since it's not even a module. So, still letting userspace figure 
out what the last used governor was and what will it come up with is 
still useful. And this isn't going to break userspace any more than 
returning an error all the time.

I would strongly prefer that this is not done and just clear out the 
pointer if/when the governor module is removed.

Nack

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
