From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update callbacks
Date: Wed, 10 Feb 2016 23:12:05 +0100
Message-ID: <CAJZ5v0jxDC7_Mg03pTNVLWApHRCLnbfzjJiz9DN1+zqSi6mq2w@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<56B93548.9090006@linaro.org>
	<CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
	<5387313.xAhVpzgZCg@vostro.rjw.lan>
	<56BA8C29.4090905@linaro.org>
	<CAJZ5v0gBzjz9d7eBLZj3bYNLexTCs+UtNpLwWyZMDTA_Gi=zRg@mail.gmail.com>
	<CAJZ5v0jF4rJVeauZi08FYbDp6qsB4y3g--O4tx=C15go8z9nbw@mail.gmail.com>
	<56BB93BB.5050405@linaro.org>
	<CAJZ5v0jBB8-q5DOakUoMrPrjBSttZgDuNBEivR5WfdWR4s1mKA@mail.gmail.com>
	<56BBB4B7.2070209@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34089 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbcBJWMH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 17:12:07 -0500
In-Reply-To: <56BBB4B7.2070209@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Feb 10, 2016 at 11:07 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 02/10/2016 01:49 PM, Rafael J. Wysocki wrote:
>>>> If done this way, I guess we may pass rq_clock_task(rq) as the time
>>>> >> arg to cpufreq_update_util() from there and then the cpu_lock() call
>>>> >> I've added to this prototype won't be necessary any more.
>>> >
>>> > Is it rq_clock_task() or rq_clock()? The former can omit irq time so may
>>> > gradually fall behind wall clock time, delaying callbacks in cpufreq.
>>
>> What matters to us is the difference between the current time and the
>> time we previously took a sample and there shouldn't be too much
>> difference between the two in that respect.
>
> Sorry, the reference to wall clock time was unnecessary. I just meant it
> can lose time, which could cause cpufreq updates to be delayed during
> irq heavy periods.
>
>> Both are good enough IMO, but I can update the patch to use rq_clock()
>> if that's preferred.
>
> I do believe rq_clock should be used as workloads such as heavy
> networking could spend a significant portion of time in interrupts,
> skewing rq_clock_task significantly, assuming I understand it correctly.

OK, I'll send an update, then.

Thanks,
Rafael
