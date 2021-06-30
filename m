Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8AC11F65
	for <linux-pm@archiver.kernel.org>; Wed, 30 Jun 2021 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D6B61490
	for <linux-pm@archiver.kernel.org>; Wed, 30 Jun 2021 17:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhF3Rbe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:31:34 -0400
Received: from foss.arm.com ([217.140.110.172]:42988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3Rbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Jun 2021 13:31:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 302C36D;
        Wed, 30 Jun 2021 10:29:04 -0700 (PDT)
Received: from [10.57.10.3] (unknown [10.57.10.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4243F718;
        Wed, 30 Jun 2021 10:29:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
References: <20210625152603.25960-1-lukasz.luba@arm.com>
 <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAJZ5v0iOzp5FKo4NsNE-m+sEXZUvv1TbkAO_9+jSidx9c0iq8A@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <ffc63114-c1c2-f866-8b2a-15e9fd0a7818@arm.com>
Date:   Wed, 30 Jun 2021 18:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iOzp5FKo4NsNE-m+sEXZUvv1TbkAO_9+jSidx9c0iq8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/30/21 6:01 PM, Rafael J. Wysocki wrote:
> On Fri, Jun 25, 2021 at 5:26 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
>> task. It probes many possibilities and compares the estimated energy values
>> for different scenarios. For calculating those energy values it relies on
>> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
>> EM data is in milli-Watts (or abstract scale), which sometimes is not
>> sufficient. In some cases it might happen that two CPUs from different
>> Performance Domains (PDs) get the same calculated value for a given task
>> placement, but in more precised scale, they might differ. This rounding
>> error has to be addressed. This patch prepares EAS code for better
>> precision in the coming EM improvements.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> If you want me to pick up this series, this patch requires an ACK from
> the scheduler maintainers.
> 

It would be great, if you could take it after e.g. Peter ACK it.

Peter could you have a look at it, please?
In this patch 1/3 we have only variables upgrade.

Regards,
Lukasz
