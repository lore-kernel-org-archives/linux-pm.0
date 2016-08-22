From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Mon, 22 Aug 2016 10:31:40 +0800
Message-ID: <CANRm+Czabiyv2donHAzGw-fqhEgdkcTgpaqSB4AapY0qTQARkQ@mail.gmail.com>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org> <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36445 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbcHVCbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Aug 2016 22:31:43 -0400
In-Reply-To: <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

2016-08-19 23:30 GMT+08:00 Morten Rasmussen <morten.rasmussen@arm.com>:
> Hi Steve,
>
> On Thu, Aug 18, 2016 at 06:55:41PM -0700, Steve Muckle wrote:
>> PELT scales its util_sum and util_avg values via
>> arch_scale_cpu_capacity(). If that function is passed the CPU's sched
>> domain then it will reduce the scaling capacity if SD_SHARE_CPUCAPACITY
>> is set. PELT does not pass in the sd however. The other caller of
>> arch_scale_cpu_capacity, update_cpu_capacity(), does. This means
>> util_sum and util_avg scale beyond the CPU capacity on SMT.
>>
>> On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
>> util_avg scales up to 1024.
>
> I can't convince myself whether this is the right thing to do. SMT is a
> bit 'special' and it depends on how you model SMT capacity.
>
> I'm no SMT expert, but the way I understand the current SMT capacity
> model is that capacity_orig represents the capacity of the SMT-thread
> when all its thread-siblings are busy. The true capacity of an
> SMT-thread where all thread-siblings are idle is actually 1024, but we
> don't model this (it would be nightmare to track when the capacity
> should change). The capacity of a core with two or more SMT-threads is
> chosen to be 1024 + smt_gain, where smt_gain is supposed represent the
> additional throughput we gain for the additional SMT-threads. The reason
> why we don't have 1024 per thread is that we would prefer to have only
> one task per core if possible.

Agreed, maybe the capacity of an SMP-thread where all thread-siblings
are idle can be 1024 + smt_gain after latest IA technology.
http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html

Regards,
Wanpeng Li
