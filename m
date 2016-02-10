From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Wed, 10 Feb 2016 11:47:07 -0800
Message-ID: <56BB93BB.5050405@linaro.org>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan> <56BA8C29.4090905@linaro.org>
 <CAJZ5v0gBzjz9d7eBLZj3bYNLexTCs+UtNpLwWyZMDTA_Gi=zRg@mail.gmail.com>
 <CAJZ5v0jF4rJVeauZi08FYbDp6qsB4y3g--O4tx=C15go8z9nbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36623 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcBJTrK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 14:47:10 -0500
Received: by mail-pf0-f173.google.com with SMTP id e127so16894140pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2016 11:47:10 -0800 (PST)
In-Reply-To: <CAJZ5v0jF4rJVeauZi08FYbDp6qsB4y3g--O4tx=C15go8z9nbw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On 02/09/2016 07:09 PM, Rafael J. Wysocki wrote:
>>> >> I think additional hooks such as enqueue/dequeue would be needed in
>>> >> RT/DL. The task tick callbacks will only run if a task in that class is
>>> >> executing at the time of the tick. There could be intermittent RT/DL
>>> >> task activity in a frequency domain (the only task activity there, no
>>> >> CFS tasks) that doesn't happen to overlap the tick. Worst case the task
>>> >> activity could be periodic in such a way that it never overlaps the tick
>>> >> and the update is never made.
>> >
>> > So if I'm reading this correctly, it would be better to put the hooks
>> > into update_curr_rt/dl()?

That should AFAICS be sufficient to avoid stalling. It may be more than
is required as that covers more than just enqueue/dequeue but I'm not
sure offhand.

>
> If done this way, I guess we may pass rq_clock_task(rq) as the time
> arg to cpufreq_update_util() from there and then the cpu_lock() call
> I've added to this prototype won't be necessary any more.

Is it rq_clock_task() or rq_clock()? The former can omit irq time so may
gradually fall behind wall clock time, delaying callbacks in cpufreq.

thanks,
Steve
