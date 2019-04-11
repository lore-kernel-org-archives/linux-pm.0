Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4096C10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 14:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5852077C
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 14:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKOFP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:05:15 -0400
Received: from foss.arm.com ([217.140.101.70]:43774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfDKOFP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Apr 2019 10:05:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC0C80D;
        Thu, 11 Apr 2019 07:05:15 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8257E3F68F;
        Thu, 11 Apr 2019 07:05:14 -0700 (PDT)
Subject: Re: [RFC 1/6] Optimize wake-up task for Task Packing heuristic
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-2-parth015@linux.vnet.ibm.com>
 <0b198386-ef0b-75e0-e53a-1160c77326b7@arm.com>
 <60e34244-1e40-e318-080e-e76607bb3d92@linux.vnet.ibm.com>
 <c877a201-2601-5bf4-7c80-0f6b190c1711@arm.com>
Message-ID: <f45f53c6-1200-35dc-580b-67d2062152ab@arm.com>
Date:   Thu, 11 Apr 2019 16:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c877a201-2601-5bf4-7c80-0f6b190c1711@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/10/19 6:33 PM, Dietmar Eggemann wrote:
> On 4/7/19 7:57 AM, Parth Shah wrote:
>>
>>
>> On 3/27/19 3:01 PM, Dietmar Eggemann wrote:
>>> Hi Parth,
>>>
>>> On 3/22/19 7:06 AM, Parth Shah wrote:
> 
> [...]
> 
>>>> +    for_each_cpu_wrap(core, cpus, prev_cpu)
>>>> +    {
>>>> +        long unsigned int core_util = 0;
>>>> +        long unsigned int core_cap = core_cap_mf*capacity_of(core)/10;
>>>> +        long unsigned int cache_cpu_util = (unsigned)-1;
>>>> +        long unsigned est_util = 0, est_util_enqueued = 0;
>>>> +        int cache_cpu = core;
>>>> +        struct cfs_rq *cfs_rq;
>>>> +
>>>> +        for_each_cpu(smt, cpu_smt_mask(core)) {
>>>
>>> This one doesn't build for me on arm64 (make defconfig) since it uses 
>>> cpu_smt_mask() outside the CONFIG_SCHED_SMT guard.
>>>
>>> kernel/sched/fair.c: In function ‘select_non_idle_core’:
>>> kernel/sched/fair.c:6243:21: error: implicit declaration of function 
>>> ‘cpu_smt_mask’; did you mean ‘cpu_cpu_mask’? 
>>> [-Werror=implicit-function-declaration]
>>>     for_each_cpu(smt, cpu_smt_mask(core)) {
>>>                       ^
>>> ./include/linux/cpumask.h:242:32: note: in definition of macro 
>>> ‘for_each_cpu’
>>>
>>> [...]
>>>
>>
>> Thanks for pointing out. It will not build for individual patches for 
>> the current version of RFC.
>>
>> Please try to build it with full patch set. I assure, the following 
>> iterations of RFC will resolve this issue.
> 
> Ah, I see, you have this CONFIG_TURBO_SCHED patch at the end of the 
> series. I think that you will have a hard time to get new CONFIG 
> switches into the task scheduler code. Can you not bting in your feature 
> w/o CONFIG_TURBO_SCHED?

I think you could replace CONFIG_TURBO_SCHED entirely with your static 
key __turbo_sched_enabled (and the existing CONFIG_SMT in case your 
feature relies on SMT).

Please sent your next version to linux-kernel@vger.kernel.org as well 
and cc the task scheduler maintainer to get more review.
