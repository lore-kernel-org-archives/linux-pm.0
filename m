From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
Date: Tue, 6 Feb 2018 11:48:59 +0100
Message-ID: <54081703-c48f-3e07-b79d-3a2831bc28d7@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
 <20180205041734.GD28462@vireshk-i7>
 <911804cd-2f1d-a1f7-61a2-6c8b95a88d6b@linaro.org>
 <20180206042853.GI28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34428 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFKtC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Feb 2018 05:49:02 -0500
Received: by mail-wm0-f48.google.com with SMTP id j21-v6so17311199wmh.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2018 02:49:01 -0800 (PST)
In-Reply-To: <20180206042853.GI28462@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, daniel.thompson@linaro.org

On 06/02/2018 05:28, Viresh Kumar wrote:
> On 05-02-18, 11:32, Daniel Lezcano wrote:
>> On 05/02/2018 05:17, Viresh Kumar wrote:
>>> Right, but I thought the cooling-maps can help us specify different cooling
>>> states for different cooling devices for the same trip point. Maybe my
>>> understanding of that is incorrect.
> 
> Any inputs on this? I am still wondering if this can be done.

Can you give an example? Or your understanding is incorrect or I missed
the point.

>> At the first glance, it sounds interesting but I'm afraid that raises
>> more corner-cases than it solves because we have to take into account
>> all the combinations: cpuidle=0 && cpufreq=1, cpuidle=1 && cpufreq=0,
>> cpuidle=1 && cpufreq=1 with dynamic code changes when the cpufreq driver
>> is loaded/unloaded.
>>
>> I'm not against this approach as well as merging all the cpu cooling
>> devices into a single one but that won't be trivial and will need
>> several iterations before reaching this level of features.
>>
>> IMO, we should keep the current approach (but handle the cpufreq
>> loading/unloading) and then iteratively merge all the cooling device
>> into a single one with policy change at runtime which will automatically
>> handle the cpufreq load/unload.
> 
> Surely we can do one thing at a time if that's the way we choose to do it.

Easy to say :)

The current code is to introduce the feature without impacting the DT
bindings in order to keep focused on the thermal mitigation aspect.

There are still a lot of improvements to do after that. You are
basically asking me to implement the copy-on-write before the memory
management is complete.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
