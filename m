Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C72C7EE23
	for <linux-pm@archiver.kernel.org>; Mon, 22 May 2023 14:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjEVOl7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 May 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEVOl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 10:41:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC6B5B0;
        Mon, 22 May 2023 07:41:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 742BD11FB;
        Mon, 22 May 2023 07:42:38 -0700 (PDT)
Received: from [10.57.22.146] (unknown [10.57.22.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6163F67D;
        Mon, 22 May 2023 07:41:50 -0700 (PDT)
Message-ID: <e5a75077-e3e6-7a77-c4d0-c55fa120acce@arm.com>
Date:   Mon, 22 May 2023 15:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] Add basic tracing for uclamp and schedutil
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
References: <20230509122246.1702397-1-lukasz.luba@arm.com>
 <88fcd266-301a-f6e1-cf1c-69c20e74ef35@arm.com>
 <CAJZ5v0juOwCHNoCo8gX+NopuzK18d+v3QV0qkGcg1BvDVcPpKQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0juOwCHNoCo8gX+NopuzK18d+v3QV0qkGcg1BvDVcPpKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/22/23 15:40, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Mon, May 22, 2023 at 3:38 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>>
>>
>> On 5/9/23 13:22, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The task scheduler feature: Uclamp, begins to take off. To better understand
>>> the dynamics in the task scheduler and CPU frequency requests we need some
>>> better tracing.
>>> In schedutil (cpufreq governor) we allow to enter the scheduler
>>> and make the frequency change. Although, there is some limit in regards to how
>>> often this can happen. That min period is provided by the cpufreq driver.
>>> Thus, some of the cpufreq requests might be filter out and the frequency won't
>>> be changed (hopefuly will be set a bit later). We would like to know about
>>> those situations, especially in context of the user-space hints made via
>>> Uclamp for particular tasks.
>>> This patch set aims to add base for our toolkits and post-processing trace
>>> analyzes.
>>
>>> Changelog:
>>> v2:
>>> - solved the issue from CI build warning, dropped schedutil.h and re-used
>>>     the sched.h which is available in build_utility.c where cpufreq_schedutil.c
>>>     is included
>>> - added tag for the last patch 3/3 for the CI robot helping hend
>>> - re-based on top of v6.4-rc1
>>> v1:
>>> - implementation can be found here [1]
>>>
>>
>> I was going to gently ping you, while I've realized that you
>> are not on CC list :( I don't know what happened, my apologies.
> 
> No worries.
> 
>> Shell I resend this patch set so you can have it in a proper way
>> in your mailbox?
> 
> Well, for schedutil you should also CC linux-pm (done now), so please resend it.
> 
>> Could you have a look at this, please?
> 
> I could, but if I'm to reply, it will be much more convenient for me
> if it is there in my inbox.
> 

Thanks Rafael for instant response. I'll resend it with the proper CC
list this time.
